<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat"  %>
<%@ page import="pkgPmegpNew.DBCon"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Delete product sales </title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script src="../js/ModalPopupWindow.js" type="text/javascript"></script>
<script type="text/javascript" src="../js/datetimepicker_css.js"></script>
<script src="../js/inlineMsgMain.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
<script>
function submit_update(){

document.form.ins.value='I';
document.form.submit();
}

function closeAndRefresh(){
   window.parent.refreshpage();  
    }
</script>
</head>

<body>

<form name="form" id="form"  class="form" method="post">

<%
String MSG="";

String TR_ID = request.getParameter("TR_ID")==null?"":(String) request.getParameter("TR_ID");
String DEL_REMARKS="";
String ins="1";
DBCon db= new DBCon();
db.connect();
	 List values=new ArrayList();	
    List pstm=new ArrayList();
%>
<table width="100%" align="center" class="shadow">
  <tr>
    <th colspan="2">Are You Sure You want to delete this Transaction:  
      <input name="TR_ID" type="text" id="TR_ID" value="<%=TR_ID%>" readonly="readonly" ></th>
    </tr>
  
  <tr>
    <td colspan="2"> <div align="center">
      <input name="Button" type="button" class="buttonDarkGreen" value="Yes" onclick="submit_update();" />
      <input name="Button" type="button" class="buttonOrange" onclick="closeAndRefresh();" value="No"/>
</div></td>
    </tr>
</table>
  <input name="ins" type="hidden" id="ins">
  
   <%
   if ((String)request.getParameter("ins")!=null){





TR_ID=request.getParameter("TR_ID")==null?"":request.getParameter("TR_ID");


StringBuffer qryUpdate = new StringBuffer();

qryUpdate.append("delete FROM LOAN_NPA_DETAIL WHERE NPATR_ID=?");
values.add(TR_ID); pstm.add ("L");


try {
db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate();

values.clear();
pstm.clear();
}catch(Exception e){
out.print(e.toString());
  db.close();

}


  db.close();
response.sendRedirect("savemsg.jsp");

	
   }
  
  %>  
</form>
</body>
</html>
