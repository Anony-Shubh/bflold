<%@ page import="java.io.IOException" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.Files" %>
<%@ page import="java.nio.file.Path" %>
<%@ page import="java.nio.file.Paths" %>
<%@ page import="java.nio.file.StandardCopyOption.*" %>
<%@ page import="pkgPmegpNew.DBCon"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.nio.file.Path" %>
<%@ page import="java.nio.file.Paths" %>
<%@ page import="java.nio.file.Files" %>
<%@ page import="java.util.*" %>
<%@ page import="java.nio.file.StandardCopyOption" %>
<%@ page import="globalp.*"%>


<html>
<head>
<title>Documentview </title>
</head>
<body>
<form>
<%


kvicGlobalPath sm = new kvicGlobalPath();

   String folderPath = sm.getStorage("pmegpeportalupload/2025/JUL/03/13117447/"); // Replace with your folder path
	
	String folderPathtemp=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp361/");
	
	//out.print (folderPath);
	
    String fileName = "app39807009.pdf"; // Replace with your filename
    Path filePathtemp = Paths.get(folderPathtemp, fileName);
	  Path filePath = Paths.get(folderPath, fileName);
	
	//out.print(filePath);
	out.print("<br>");
	
	 if (Files.exists(filePath)) {
        out.print(" Normal File exists in the specified folder."+filePath+"<br>");
    } else {
       out.print(" normal File does not exist in the specified folder."+filePath+"<br>");
    }
	
	
	 if (Files.exists(filePathtemp)) {
        out.print("File exists in the specified folder."+filePathtemp+"<br>");
    } else {
       out.print("File does not exist in the specified folder."+filePathtemp+"<br>");
    }
	
	
	 try {
	   Files.move(filePathtemp ,filePath, StandardCopyOption.ATOMIC_MOVE);
	   } catch (IOException e) {
           out.print("Failed to move file: " + e.toString());
        }
		
	
%>
