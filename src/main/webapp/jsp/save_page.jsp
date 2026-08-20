<%@ page buffer="600kb" session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%@ include file="includeHeaderPage.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Save Message</title>

<script language="javascript">
function closeAndRefresh(){
   window.parent.refreshpage();  
    }
</script>
<style>

.h1{border-style: inset;}
#container{
  font-family: Arial, Helvetica, sans-serif;s
  border-collapse: collapse;
  width: 55%;
  border-style: inset;
  background-color:#FFFFFF;
  
}
#container td, #container tr {
  padding:6px;
  font-weight: bold;
  
 
}

#container td:hover, td:active {text-decoration: underline; background-color: #ddd;} 

#container th {
  font-family: Arial black, Helvetica, sans-serif
  font-weight: bold;
  padding: 6px;
  text-align: center;
  border-style: inset;
  background-color: #3f506e;
  color:#FFFFFF;
  
}
input[type=text] {
  width: 80%;
  box-sizing: border-box;
}
.button{
  background-color: #3f506e;
  border: none;
  color: #FFFFFF;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
  border: 1px solid #221F1F;
}
.button:hover{background-color: #8B9DC3;}
.SR {
background-color: #8B9DC3;
text-align: center;

}
.next {
  background-color: #999999;
  color:#000000;
  font-size: 25px;
}

a {
  text-decoration: none;
  display: inline-block;
  padding: 8px 16px;
}

a:hover {
  background-color: #ddd;
  color: black;
}

</style>
</head>
<body>
<%
//String app_id=request.getParameter("app_id")==null?"":(String) request.getParameter("app_id");
%>
<form>
<p>&nbsp;</p>
<TABLE  border="1" align="center" id="container">
<TR>
<th height="66"><DIV align="center" >SUCESSFULLY DATA UPDATED..... </DIV></th></TR>
   <DIV align="center">
   <BR>
   <BR>
    <tr>
    <td><div align="center">
     <a href="GTAppSearchLOV_award.jsp"> <input name="Button" type="button" class="button" onClick="closeAndRefresh();" value="Back"/></a>
    </div></td>
    </tr>
</DIV>

</TABLE>


<p>&nbsp;</p>
<p>&nbsp;</p>
</form>
</body>
</html>
