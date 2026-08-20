<%@ include file="appIncludeHeaderPage.jsp" %>
<HTML>

<HEAD>
<META http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
   <LINK rel="stylesheet" type="text/css" href="css/pmegpNew.css">

<TITLE>
       
</TITLE>
	<SCRIPT>
        function submitform() {
            document.form.ins.value = 'I';
            document.form.submit();
        }

    </SCRIPT>
   
    <style type="text/css">
<!--
.style2 {font-size: 18}
.style3 {
	font-size: 14px;
	color: #FF0000;
}
-->
    </style>
</HEAD>



<BODY>

 <%
String APP_ID=(String) session.getAttribute("sAPP_ID");
String REQID=request.getParameter("REQID")==null?"":(String) request.getParameter("REQID");
String NEW_MOB_NO="";




DBCon db= new DBCon(); 
db.connect(); 
List values=new ArrayList(); 
List pstm=new ArrayList(); 


StringBuffer poR = new StringBuffer();

poR.append(" SELECT AM.NEW_MOB_NO "      );
poR.append(" FROM APP_MOB_CHANGE_LOG AM "      );
poR.append(" WHERE AM.REQID=? AND AM.APP_ID=?"      );


values.add(REQID);
values.add(APP_ID);


ResultSet rsMain = db.executeSQL(poR.toString(),values);

while (rsMain.next()){
NEW_MOB_NO=rsMain.getString("NEW_MOB_NO")==null?"":rsMain.getString("NEW_MOB_NO");



}
rsMain.close();

db.close();
%>

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

<CENTER>
  <FORM method="post" name="form" id="form">		
 <table id="example" class="display"  border="1" width="40%">
 <tr>
 <td height="94" colspan="5">
   <div align="center" class="style2">
     <p>Your request for changing mobile number to <strong>'<%=NEW_MOB_NO%>'</strong><br />
         <br/>
       has been forwarded to Nodal Officer for approval</p>
     <p align="left" class="style3">Note: After approval of the Nodal Officer your mobile number will get updated </p>
   </div></td>
 
 </tr>
 <tr>
 <td colspan="5">
   <div align="center">
     <INPUT type="button" name="Submit" class="buttonLogin" onClick="location.href='mobchng.jsp';" value="Back">
     
     </div>
 </tr>
 </table>
</FORM>
  </CENTER>
</BODY>

</HTML>
