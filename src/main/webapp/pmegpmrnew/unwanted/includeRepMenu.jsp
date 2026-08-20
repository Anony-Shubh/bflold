<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>PMEGP Report Menu</title>
</head>
<div align="right">
<table cellpadding="2" cellspacing="5">
  <tr>
    <th nowrap="nowrap">Click on underlined value of <em>No of prj. columns </em>to generate beneficiary/branch wise detailed report in excel format </th>
    <th nowrap="nowrap"><a href="reportHomePage.jsp">Home</a></th>
    <th nowrap="nowrap">
        <input name="imageField" type="image" src="img/print-icon.png" alt="Print This Page" onClick="window.print();return (false);"width="25" height="25" border="0" />
     
    </th>
    <th nowrap="nowrap"><form name="form1" id="form1" method="post" action="">
      <input type="button" name="Button" value="Go Back" class="button" onClick="window.back()" />
    </form></th>
    <th nowrap="nowrap">&nbsp;
	</th>
    <th nowrap="nowrap">&nbsp;
	</th>
  </tr>
</table>
</div>
</html>
