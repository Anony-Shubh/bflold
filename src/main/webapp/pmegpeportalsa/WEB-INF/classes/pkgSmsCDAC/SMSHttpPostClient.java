package pkgSmsCDAC;

import java.io.*;
import java.net.URLEncoder;
import java.net.URL ;
import java.net.*;

public class SMSHttpPostClient {
  
  static String username = "KVICDIT";
  static String password = "Panda@1974";
  static String senderid = "KVICIT";
  static String message = "Test SMS from MSDG, Sorry for inconvenience!";
  static String mobileNo = "9987402341";
  static String mobileNos = "09987402341";
  //StartTime Format: YYYYMMDD hh:mm:ss
  static String scheduledTime = "20110701 02:27:00";
  static HttpURLConnection connection = null;
  static URL url =null;
  /*
  public static void main(String[] args) {
  try {
  System.setProperty("http.proxyHost", "192.168.50.100");
  System.setProperty("http.proxyPort", "3128");
  URL url = new URL("http://msdgweb.mgov.gov.in/esms/sendsmsrequest");
  connection = (HttpURLConnection) url.openConnection();
  connection.setDoInput(true);
  connection.setDoOutput(true);
  connection.setRequestMethod("POST");
  connection.setFollowRedirects(true);
  
  connection = sendBulkSMS(mobileNos,message);
  
  System.out.println("Resp Code:" + connection.getResponseCode());
  System.out.println("Resp Message:"
  + connection.getResponseMessage());
  
  } catch (MalformedURLException e) {
  // TODO Auto-generated catch block
  e.printStackTrace();
  } catch (IOException e) {
  // TODO Auto-generated catch block
  e.printStackTrace();
  }
  }
  */
  // Method for sending single SMS.
  public SMSHttpPostClient(){
    super();
  }
  
  public HttpURLConnection sendSingleSMS(String mobileNo, String message) {
    try {
      String smsservicetype = "singlemsg"; // For single message.
      String query = "username=" + URLEncoder.encode(username,"UTF-8")
      + "&password=" + URLEncoder.encode(password,"UTF-8")
      + "&smsservicetype=" + URLEncoder.encode(smsservicetype,"UTF-8")
      + "&content=" + URLEncoder.encode(message,"UTF-8") + "&mobileno="
      + URLEncoder.encode(mobileNo,"UTF-8") + "&senderid="
      + URLEncoder.encode(senderid,"UTF-8");
      
      connection.setRequestProperty("Content-length", String
      .valueOf(query.length()));
      connection.setRequestProperty("Content-Type",
      "application/x-www-form-urlencoded");
      connection.setRequestProperty("User-Agent",
      "Mozilla/4.0 (compatible; MSIE 5.0; Windows 98; DigExt)");
      
      // open up the output stream of the connection
      DataOutputStream output = new DataOutputStream(connection
      .getOutputStream());
      
      // write out the data
      int queryLength = query.length();
      output.writeBytes(query);
      // output.close();
      
      // get ready to read the response from the cgi script
      DataInputStream input = new DataInputStream(connection
      .getInputStream());
      
      // read in each character until end-of-stream is detected
      for (int c = input.read(); c != -1; c = input.read())
      System.out.print((char) c);
      input.close();
    } catch (Exception e) {
      System.out.println("Something bad just happened.");
      System.out.println(e);
      e.printStackTrace();
    }
    
    return connection;
  }
  
  // method for sending bulk SMS
  public  HttpURLConnection sendBulkSMS( String mobileNos, String message) {
    try {
      String smsservicetype = "bulkmsg"; // For bulk msg
      String query = "username=" + URLEncoder.encode(username,"UTF-8")
      + "&password=" + URLEncoder.encode(password,"UTF-8")
      + "&smsservicetype=" + URLEncoder.encode(smsservicetype,"UTF-8")
      + "&content=" + URLEncoder.encode(message,"UTF-8")
      + "&bulkmobno=" + URLEncoder.encode(mobileNos, "UTF-8")
      + "&senderid=" + URLEncoder.encode(senderid,"UTF-8");
      
      connection.setRequestProperty("Content-length", String
      .valueOf(query.length()));
      connection.setRequestProperty("Content-Type",
      "application/x-www-form-urlencoded");
      connection.setRequestProperty("User-Agent",
      "Mozilla/4.0 (compatible; MSIE 5.0; Windows 98; DigExt)");
      
      // open up the output stream of the connection
      DataOutputStream output = new DataOutputStream(connection
      .getOutputStream());
      
      // write out the data
      int queryLength = query.length();
      output.writeBytes(query);
      // output.close();
      
      System.out.println("Resp Code:" + connection.getResponseCode());
      System.out.println("Resp Message:" + connection.getResponseMessage());
      
      // get ready to read the response from the cgi script
      DataInputStream input = new DataInputStream(connection
      .getInputStream());
      
      // read in each character until end-of-stream is detected
      for (int c = input.read(); c != -1; c = input.read())
      System.out.print((char) c);
      input.close();
    } catch (Exception e) {
      System.out.println("Something bad just happened.");
      System.out.println(e);
      e.printStackTrace();
    }
    return connection;
  }
  
  public  HttpURLConnection sendSingleUicodeSMS(String mobileNo, String message) {
    try {
      url = new URL("http://msdgweb.mgov.gov.in/esms/sendsmsrequest");
      
      connection = (HttpURLConnection) url.openConnection();
      connection.setDoInput(true);
      connection.setDoOutput(true);
      connection.setRequestMethod("POST");
      connection.setFollowRedirects(true);
      
      String finalmessage = "";
      String sss = "";
      char ch = 0;
      //  String smsservicetype = "singlemsg"; // For single message.
      String smsservicetype = "unicodemsg";
      
      for(int i = 0 ; i < message.length();i++){
        
        ch = message.charAt(i);
        int j = (int) ch;
        //  System.out.println("iiii::"+j);
        
        sss = "&#"+j+";";
        finalmessage = finalmessage+sss;
      }
      System.out.println("ddd"+finalmessage);
      
      
      message=finalmessage;
      System.out.println("unicoded message=="+message);
      String query = "username=" + URLEncoder.encode(username,"UTF-8")
      + "&password=" + URLEncoder.encode(password,"UTF-8")
      + "&smsservicetype=" + URLEncoder.encode(smsservicetype,"UTF-8")
      + "&content=" + URLEncoder.encode(message,"UTF-8") + "&mobileno="
      + URLEncoder.encode(mobileNo,"UTF-8") + "&senderid="
      + URLEncoder.encode(senderid,"UTF-8");
      
      connection.setRequestProperty("Content-length", String
      .valueOf(query.length()));
      connection.setRequestProperty("Content-Type",
      "application/x-www-form-urlencoded");
      connection.setRequestProperty("User-Agent",
      "Mozilla/4.0 (compatible; MSIE 5.0; Windows 98; DigExt)");
      
      // open up the output stream of the connection
      DataOutputStream output = new DataOutputStream(connection
      .getOutputStream());
      
      // write out the data
      int queryLength = query.length();
      output.writeBytes(query);
      // output.close();
      
      // get ready to read the response from the cgi script
      DataInputStream input = new DataInputStream(connection
      .getInputStream());
      
      // read in each character until end-of-stream is detected
      for (int c = input.read(); c != -1; c = input.read())
      System.out.print((char) c);
      input.close();
    } catch (Exception e) {
      System.out.println("Something bad just happened.");
      System.out.println(e);
      e.printStackTrace();
    }
    
    return connection;
  }
  
  public  HttpURLConnection sendBulkUnicodeSMS( String mobileNos, String message) {
    try {
      
      System.out.println(message);
      String finalmessage = "";
      String sss = "";
      char ch = 0;
      
      for(int i = 0 ; i < message.length();i++){
        
        ch = message.charAt(i);
        int j = (int) ch;
        //  System.out.println("iiii::"+j);
        
        sss = "&#"+j+";";
        finalmessage = finalmessage+sss;
      }
      System.out.println("ddd"+finalmessage);
      
      message=finalmessage;
      System.out.println("unicoded message=="+message);
      
      String smsservicetype = "unicodemsg"; // For bulk msg
      String query = "username=" + URLEncoder.encode(username,"UTF-8")
      + "&password=" + URLEncoder.encode(password,"UTF-8")
      + "&smsservicetype=" + URLEncoder.encode(smsservicetype,"UTF-8")
      + "&content=" + URLEncoder.encode(message,"UTF-8") 
      + "&bulkmobno=" + URLEncoder.encode(mobileNos, "UTF-8") 
      + "&senderid=" + URLEncoder.encode(senderid,"UTF-8");
      
      connection.setRequestProperty("Content-length", String
      .valueOf(query.length()));
      connection.setRequestProperty("Content-Type",
      "application/x-www-form-urlencoded");
      connection.setRequestProperty("User-Agent",
      "Mozilla/4.0 (compatible; MSIE 5.0; Windows 98; DigExt)");
      
      // open up the output stream of the connection
      DataOutputStream output = new DataOutputStream(connection
      .getOutputStream());
      
      // write out the data
      int queryLength = query.length();
      output.writeBytes(query);
      // output.close();
      
      System.out.println("Resp Code:" + connection.getResponseCode());
      System.out.println("Resp Message:" + connection.getResponseMessage());
      
      // get ready to read the response from the cgi script
      DataInputStream input = new DataInputStream(connection
      .getInputStream());
      
      // read in each character until end-of-stream is detected
      for (int c = input.read(); c != -1; c = input.read())
      System.out.print((char) c);
      input.close();
    } catch (Exception e) {
      System.out.println("Something bad just happened.");
      System.out.println(e);
      e.printStackTrace();
    }
    return connection;
  }
}
        

  package com.hubberspot.java7;
 
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import static java.nio.file.StandardCopyOption.*;
 
public class CopyMoveFile {
 
 public static void main(String[] args) {
 
  // Let say we have a file placed at the directory
  // D:\books\java by the name CopyAndMove.txt and 
  // we want to copy or move it to a different directory
  // by name D:\books\CopyAndMove. 
  // In order to do that we create two Path instances 
  // in which one path represent the source and other
  // represents the target
  Path source = Paths.get("D:\\books\\java\\CopyAndMove.txt");
  Path target = Paths.get("D:\\books\\CopyAndMove\\CopyAndMove.txt");
 
  // In order to take a backup we usually use copy()
  // method of Files class by passing three parameters
  // such as source from where it picks the file
  // the target where it tranfers the file and 
  // lastly the CopyOption which tells that 
  // whether to replace existing file if it exists 
  // by the name provided already.
  try {
 
   Files.copy(source, target, REPLACE_EXISTING);
 
  } catch (IOException e) {
 
   e.printStackTrace();
  }
 
  // In order to move a file completely we usually 
  // use move() method of Files class by passing 
  // three parameters such as source from 
  // where it picks the file the target where 
  // it tranfers the file and lastly the 
  // CopyOption which tells that whether 
  // to replace existing file if it exists 
  // by the name provided already.
 
  try {
 
   Files.move(source, target, REPLACE_EXISTING);
 
  } catch (IOException e) {
 
   e.printStackTrace();
  }
 
 }
 
}