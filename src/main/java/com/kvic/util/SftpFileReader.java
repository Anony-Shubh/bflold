package com.kvic.util;

import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.Session;

import java.util.Properties;

public class SftpFileReader {

    private String host;
    private int port;
    private String username;
    private String password;

    private int connectionTimeout = 15000;

    /**
     * Constructor
     */
    public SftpFileReader(String host, int port, String username, String password) {

        this.host = host;
        this.port = port;
        this.username = username;
        this.password = password;
    }


    /**
     * Create and return an SFTP channel.
     */
    private ChannelSftp getChannel() throws Exception {

        JSch jsch = new JSch();

        Session session = null;
        ChannelSftp channelSftp = null;

        try {

            session = jsch.getSession(
                    username,
                    host,
                    port
            );

            session.setPassword(password);

            /*
             * For testing.
             *
             * In production, it is better to configure
             * known_hosts / host key verification.
             */
            Properties config = new Properties();

            config.put(
                    "StrictHostKeyChecking",
                    "no"
            );

            session.setConfig(config);

            /*
             * Connect SSH session
             */
            session.connect(connectionTimeout);


            /*
             * Open SFTP channel
             */
            channelSftp =
                    (ChannelSftp) session.openChannel("sftp");


            channelSftp.connect(connectionTimeout);


            return channelSftp;

        }
        catch (Exception e) {

            /*
             * If something failed before returning the
             * channel, make sure session is closed.
             */
            if (channelSftp != null) {

                try {
                    channelSftp.disconnect();
                }
                catch (Exception ex) {
                }
            }

            if (session != null) {

                try {
                    session.disconnect();
                }
                catch (Exception ex) {
                }
            }

            throw e;
        }
    }


    /**
     * Check whether a remote file or directory exists.
     */
    public boolean exists(String remotePath) throws Exception {

        ChannelSftp sftp = null;

        try {

            sftp = getChannel();

            sftp.lstat(remotePath);

            return true;

        }
        catch (Exception e) {

            return false;

        }
        finally {

            disconnect(sftp);
        }
    }


    /**
     * Move / rename a remote file.
     *
     * Example:
     *
     * source:
     * /shared_storage/temp/test.pdf
     *
     * destination:
     * /shared_storage/final/test.pdf
     */
    public void moveFile(
            String source,
            String destination) throws Exception {

        ChannelSftp sftp = null;

        try {

            sftp = getChannel();

            /*
             * Check source file
             */
            try {

                sftp.lstat(source);

            }
            catch (Exception e) {

                throw new Exception(
                        "Source file does not exist: "
                        + source,
                        e
                );
            }


            /*
             * Make sure destination directory exists.
             */
            String destinationDirectory =
                    getParentDirectory(destination);

            if (destinationDirectory != null
                    && destinationDirectory.length() > 0) {

                createDirectories(
                        sftp,
                        destinationDirectory
                );
            }


            /*
             * If destination already exists,
             * rename may fail depending on server.
             */
            try {

                sftp.lstat(destination);

                /*
                 * Destination exists.
                 *
                 * Remove this block if you don't want
                 * existing files to be overwritten.
                 */
                sftp.rm(destination);

            }
            catch (Exception e) {

                /*
                 * Destination does not exist.
                 * Nothing to do.
                 */
            }


            /*
             * Move / rename file
             */
            sftp.rename(
                    source,
                    destination
            );

        }
        finally {

            disconnect(sftp);
        }
    }


    /**
     * Create a remote directory.
     *
     * This method creates all missing parent directories.
     *
     * Example:
     *
     * /shared_storage/A/B/C
     *
     * If A, B and C don't exist, all are created.
     */
    public void createDirectory(
            String directoryPath) throws Exception {

        ChannelSftp sftp = null;

        try {

            sftp = getChannel();

            createDirectories(
                    sftp,
                    directoryPath
            );

        }
        finally {

            disconnect(sftp);
        }
    }


    /**
     * Internal method to recursively create directories.
     */
    private void createDirectories(
            ChannelSftp sftp,
            String directoryPath) throws Exception {


        if (directoryPath == null
                || directoryPath.trim().length() == 0) {

            return;
        }


        /*
         * Normalize path
         */
        directoryPath =
                directoryPath.replace("\\", "/");


        /*
         * Already exists?
         */
        try {

            sftp.lstat(directoryPath);

            return;

        }
        catch (Exception e) {

            /*
             * Directory does not exist.
             * Continue creation.
             */
        }


        /*
         * Split path.
         */
        String[] folders =
                directoryPath.split("/");


        String currentPath = "";


        /*
         * Handle absolute path.
         */
        if (directoryPath.startsWith("/")) {

            currentPath = "/";
        }


        for (String folder : folders) {

            if (folder == null
                    || folder.length() == 0) {

                continue;
            }


            if (currentPath.equals("/")
                    || currentPath.length() == 0) {

                currentPath =
                        currentPath + folder;

            }
            else {

                currentPath =
                        currentPath + "/" + folder;
            }


            /*
             * Check whether current directory exists.
             */
            try {

                sftp.lstat(currentPath);

            }
            catch (Exception e) {

                /*
                 * Directory doesn't exist.
                 */
                try {

                    sftp.mkdir(currentPath);

                }
                catch (Exception mkdirException) {

                    /*
                     * Another request may have created
                     * it at the same time.
                     *
                     * Check once more.
                     */
                    try {

                        sftp.lstat(currentPath);

                    }
                    catch (Exception checkException) {

                        throw mkdirException;
                    }
                }
            }
        }
    }


    /**
     * Get parent directory from a file path.
     *
     * Example:
     *
     * /abc/xyz/test.pdf
     *
     * returns:
     *
     * /abc/xyz
     */
    private String getParentDirectory(
            String filePath) {

        if (filePath == null) {

            return null;
        }


        int lastSlash =
                filePath.lastIndexOf("/");


        if (lastSlash <= 0) {

            return "/";
        }


        return filePath.substring(
                0,
                lastSlash
        );
    }


    /**
     * Disconnect SFTP channel and underlying session.
     */
    private void disconnect(
            ChannelSftp sftp) {

        if (sftp == null) {

            return;
        }


        try {

            Session session =
                    sftp.getSession();


            if (sftp.isConnected()) {

                sftp.disconnect();
            }


            if (session != null
                    && session.isConnected()) {

                session.disconnect();
            }

        }
        catch (Exception e) {

            /*
             * Ignore cleanup exceptions.
             */
        }
    }
}