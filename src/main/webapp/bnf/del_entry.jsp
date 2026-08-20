<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Delete product sales </title>
<LINK rel="stylesheet" type="text/css" href="../css/bnfstylesheet.css">
<script>
function submit_update(){
document.form.ins.value='I';
document.form.submit();
window.parent.refreshpage();
}
</script>
</head>

<body>
<form name="form" id="form"  class="form" method="post">
<%
List values=new ArrayList();
List pstm=new ArrayList();
String BNF_ID = request.getParameter("BNF_ID")==null?"0":(String) request.getParameter("BNF_ID");
String REMARKS="";
DBCon db= new DBCon();
db.connect();
%>
<table width="80%" align="center" class="shadow">
  <tr>
    <th colspan="2">Are You Sure You want to delete :  
      <input name="BNF_ID" type="text" id="BNF_ID" value="<%=BNF_ID%>" readonly="readonly" /></th>
    </tr>
   <tr>
    <th colspan="2">Remarks :  
      <input name="REMARKS" type="text" id="REMARKS" value="<%=REMARKS%>"/></th>
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
 REMARKS=(String) request.getParameter("REMARKS")==null?"":(String) request.getParameter("REMARKS").trim(); 
StringBuffer qryEXR = new StringBuffer();

qryEXR.append("INSERT INTO BNF_FUND_DEL SELECT SM.*,SYSDATE AS DEL_TIMESTAMP ,? AS  DEL_REMARKS FROM BNF_FUND SM WHERE BNF_ID=?");


values.add(REMARKS); pstm.add ("L");
values.add(BNF_ID); pstm.add ("L");



db.setSqlValue(qryEXR.toString());
db.setValues(values,pstm);
db.executeUpdate();
values.clear();
pstm.clear();

try {




StringBuffer qryUpdate = new StringBuffer();

qryUpdate.append("DELETE FROM BNF_FUND WHERE BNF_ID=?");
values.add(BNF_ID); pstm.add ("L");



db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate();
db.close();
values.clear();
pstm.clear();

response.sendRedirect("savemsg.jsp");


}
catch(Exception e){


response.sendRedirect("savemsg.jsp");



}
   }
 
  
  %>
  
  
  
  
</form>
</body>
</html>
