<html>
<head>
<title>PMEGP Log out Page</title>

<style type="text/css">
<!--
body,td,th {
	color: #990000;
}
body {
	background-color: #FFF0F0;
}
.style1 {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	color: #0000FF;
}
.style2 {font-family: Verdana, Arial, Helvetica, sans-serif; color: #0000FF; font-weight: bold; }
.style3 {font-family: Verdana, Arial, Helvetica, sans-serif; color: #990000; }
.style5 {font-family: Verdana, Arial, Helvetica, sans-serif}
-->
</style>
</head>
<div align="center"></div>
<h1 align="center">
  <% 
session.invalidate();
//response.flushBuffer();
response.setHeader("Cache-Control", "no-store");
response.setHeader("Cache-Control", " max-age=0, must-revalidate, no-cache, no-store, private"); 
response.setHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "post-check=0, pre-check=0");
response.setDateHeader("Expires", 0); 
response.setDateHeader("Expires", -1);
 %> 
  <span class="style5"><U>KHADI &amp; VILLAGE INDUSTRIES COMMISSION </U></span></h1>
<h1 align="center" class="style3">PMEGP e-Tracking System For Bank </h1>
<p align="center" class="style1">&nbsp;</p>
<h1 align="center" class="style2"><a href="javascript:window.close();">Close </a></h1>
<h2 align="center" class="style1"><a href="index.jsp"><strong>BANK LOGIN </strong></a>  </h2>
</html>
