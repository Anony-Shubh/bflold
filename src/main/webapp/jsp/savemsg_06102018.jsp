<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Save Message</title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script language="javascript">
function closeAndRefresh(){
   window.parent.refreshpage();  
    }</script>
<style type="text/css">
<!--
body {
	background-color: #E3C993;
}
-->
</style></head>
<body>
<form>
<p>&nbsp;</p>
<p>&nbsp;</p>
<table align="center" cellpadding="6" cellspacing="6" >
  <tr>
    <th><div align="center" class="GreenLebel">Save Message: </div></th>
    </tr>
  <tr>
    <td class="redLebel">Record Successfully Saved........ </td>
    </tr>
  <tr>
    <th><div align="center">
      <input name="Button" type="button" class="button" onclick=" closeAndRefresh();" value="Close"/>
    </div></th>
    </tr>
</table>


<p>&nbsp;</p>
<p>&nbsp;</p>
</form>
</body>
</html>
