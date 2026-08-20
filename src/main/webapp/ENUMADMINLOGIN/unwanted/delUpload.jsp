<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Delete product sales </title>
<!--<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />-->
<script>
function submit_update(){
document.form.ins.value='I';
document.form.submit();
//window.parent.refresh_data();
}
</script>
</head>

<body>
<form name="form" id="form"  class="form" method="post">
<%
String EN_ID = request.getParameter("EN_ID")==null?"0":(String) request.getParameter("EN_ID");
DBCon db= new DBCon();
db.connect();
%>
<table width="80%" align="center" class="shadow">
  <tr>
    <th colspan="2">Are You Sure You want to delete :  
      <input name="EN_ID" type="text" id="EN_ID" value="<%=EN_ID%>" readonly="readonly" /></th>
    </tr>
 
  
  <tr>
    <td colspan="2"> <div align="center">
      <input name="Button" type="button" class="buttonDarkGreen" value="DELETE" onClick="submit_update();">
    </div></td>
    </tr>
</table>
  <input name="ins" type="hidden" id="ins">
  
   <%
   if ((String)request.getParameter("ins")!=null){
  



ResultSet rsMax= db.execSQL("UPDATE GEOENUM_DETAIL SET ACT_YN='N',DEL_TIMESTAMP=SYSDATE WHERE EN_ID='"+EN_ID+"'");
		   rsMax.close();

response.sendRedirect("savemsg.jsp");

   
   }
  
  db.close();
  
  %>
  
  
  
  
</form>
</body>
</html>
