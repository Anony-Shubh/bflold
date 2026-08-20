<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.io.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="javazoom.upload.*"%>
<%@ page import="pkgPmegpNew.DBCon"%>
<html>
<head>
    <%
    response.setHeader("Cache-Control", "no-cache");
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
    %>
    <title>upload </title>
	<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script language="javascript">
window.onunload = refreshParent;
    function refreshParent() {
      window.opener.location.reload();
    }
	
function submit_form() {
	document.form.ins.value='I';
	document.form.submit();
	
}
</script>
</head>

<body>
<%@ include file="./kvicglbp/inckvicglpfl.jsp" %>

sddsdsdfsdssd