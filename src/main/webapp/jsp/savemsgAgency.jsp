<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Save Message</title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script language="javascript">
function closeAndRefresh(){
     window.parent.refresh_data();
    }
</script>
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
      <input name="Button" type="button" class="button" onclick="closeAndRefresh();" value="Close"/>
    </div></th>
    </tr>
</table>
</form>
</body>
</html>
