package com.kodehelp.sftp;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;

public class SFTPinJava{
	
	private String host;
	private Integer port;
	private String user;
	private String password;
	
	
	private JSch jsch;
	private Session session;
	private Channel channel;
	private ChannelSftp sftpChannel;
	
	
	public SFTPinJava(String host, Integer port, String user, String password ) {
		this.host = host;
		this.port = port;
		this.user = user;
		this.password = password;
		String DT="";
	}

	public void connect() {
		
		
		System.out.println("connecting..."+host);
		try {
			jsch = new JSch();
			session = jsch.getSession(user, host,port);
			session.setConfig("StrictHostKeyChecking", "no");
			session.setPassword(password);
			session.connect();

			channel = session.openChannel("sftp");
			channel.connect();
			sftpChannel = (ChannelSftp) channel;

		} catch (JSchException e) {
			e.printStackTrace();
		}

	}
	
	public void disconnect() {
		System.out.println("disconnecting...");
		sftpChannel.disconnect();
		channel.disconnect();
		session.disconnect();
	}
	
	public void upload(String fileName, String remoteDir) {

		FileInputStream fis = null;
		connect();
		try {
			
			// Change to output directory
			sftpChannel.cd(remoteDir);

			// Upload file
			File file = new File(fileName);
			fis = new FileInputStream(file);
			sftpChannel.put(fis, file.getName());

			fis.close();
			System.out.println("File uploaded successfully - "+ file.getAbsolutePath());

		} catch (Exception e) {
			e.printStackTrace();
		}
		disconnect();
	}
	
	public void download(String fileName, String localDir) {

		byte[] buffer = new byte[1024];
		BufferedInputStream bis;
		connect();
		try {
			// Change to output directory
			String cdDir = fileName.substring(0, fileName.lastIndexOf("/") + 1);
			sftpChannel.cd(cdDir);

			File file = new File(fileName);
			bis = new BufferedInputStream(sftpChannel.get(file.getName()));

			File newFile = new File(localDir + "/" + file.getName());
		

			// Download file
			OutputStream os = new FileOutputStream(newFile);
			BufferedOutputStream bos = new BufferedOutputStream(os);
			int readCount;
			while ((readCount = bis.read(buffer)) > 0) {
				bos.write(buffer, 0, readCount);
			}
			bis.close();
			bos.close();
			System.out.println("File downloaded successfully - "+ file.getAbsolutePath());


		} catch (Exception e) {
			e.printStackTrace();
		}
		disconnect();
	}

	public static void main(String[] args) {
	    //String download="SUCCESS_FAILED_NEW_MM_DISB_TRANSACTION_AS_ON_22032107.xls";
		
		//String localPath = "C:/Users/test/Desktop/print/";
		//String remotePath = "/export/home/madan/";
		
		//SFTPinJava ftp = new SFTPinJava("0.0.0.0", 22, "kvic", "kvic@123");
		
		//ftp.upload(localPath+uploadfile, remotePath);
		
		//ftp.download(remotePath+"FILTER.txt",localPath);

	}

	public SFTPinJava() {
		super();
	}

}
