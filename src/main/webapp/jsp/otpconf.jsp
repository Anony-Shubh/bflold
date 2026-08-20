<%@ include file="appIncludeHeaderPage.jsp" %>
<HTML>

<HEAD>
    <META http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
   <LINK rel="stylesheet" type="text/css" href="css/pmegpNew.css">
    <SCRIPT src="js/inlinemsg.js"></SCRIPT>

    <TITLE>
       
    </TITLE>
	<SCRIPT>
        function submitform() {	
		
		var CONF = document.form.CONF.value;
		if(CONF==""){
inlineMsg('CONF',"Please Enter One Time Password(OTP)",2);			
return (false);
}
            document.form.ins.value = 'I';
            document.form.submit();
        }


function numbersonly(e){
var unicode=e.charCode? e.charCode : e.keyCode
if (unicode!=8){ //if the key isn't the backspace key (which we should allow)
if (unicode<48||unicode>57) //if not a number
return false //disable key press
}
}

    </SCRIPT>
</HEAD>



<BODY>

 <%
String APP_ID=(String) session.getAttribute("sAPP_ID");
String REQID=request.getParameter("REQID")==null?"":(String) request.getParameter("REQID");
String REQ_OTP="";
String OTP_CONF="";
String CONF_DATE="";
String add_update="I";
String CONF =(String) request.getParameter("CONF")==null?"":(String) request.getParameter("CONF").trim();




DBCon db= new DBCon(); 
db.connect(); 
List values=new ArrayList(); 
List pstm=new ArrayList(); 


StringBuffer poR = new StringBuffer();

poR.append(" SELECT AM.APP_ID, "      );
poR.append(" AM.REQID, "      );
poR.append(" AM.REQ_OTP "      );
poR.append(" FROM APP_MOB_CHANGE_LOG AM "      );
poR.append(" WHERE AM.REQID=? AND AM.APP_ID=? AND REQ_DATE IS NULL "      );


values.add(REQID);
values.add(APP_ID);


ResultSet rsMain = db.executeSQL(poR.toString(),values);

while (rsMain.next()){
APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");
REQID=rsMain.getString("REQID")==null?"":rsMain.getString("REQID");
REQ_OTP=rsMain.getString("REQ_OTP")==null?"":rsMain.getString("REQ_OTP");


}
rsMain.close();


%>

<br>
<br>
<br>
<br>
<br>
<CENTER>
  <FORM method="post" name="form" id="form">		
 <table id="example" class="display"  border="1">
 <tr>
   <td colspan="2"><div align="center"><strong>Sms Sent to your new Mobile No....... </strong></div></td>
   </tr>
 <tr>
 <td>Applicant Id:</td>
 <td><input name="APP_ID" type="hidden" id="APP_ID" value="<%=APP_ID%>" readonly="true"><%=APP_ID%></td>
 </tr>
 <tr>
 <td>Please Enter OTP Received on New Registered Mobile Number:</td>
 <td><input name="CONF" type="number" id="CONF"  value="<%=CONF%>" maxlength="6"></td>
 </tr>
 <tr>
 <td colspan="5"><div align="center">
  <INPUT name="ins" id="ins" type="hidden" value="">
   <INPUT type="button" name="Submit" class="buttonLogin" onClick="submitform();" value="Submit">
 </div></td>
 </tr>
 </table>
 
 
            <%


if ((String)request.getParameter("ins")!=null){ 
values.clear();
//REQ_OTP =(String) request.getParameter("REQ_OTP")==null?"":(String) request.getParameter("REQ_OTP").trim();
//REQID =(String) request.getParameter("REQID")==null?"":(String) request.getParameter("REQID").trim();
CONF =(String) request.getParameter("CONF")==null?"":(String) request.getParameter("CONF").trim();


StringBuffer qryUpdate = new StringBuffer();

qryUpdate.append(" UPDATE APP_MOB_CHANGE_LOG SET ");
qryUpdate.append(" REQ_DATE= SYSDATE,");
qryUpdate.append(" CONF_DATE= SYSDATE,");
qryUpdate.append(" OTP_CONF=? ");
qryUpdate.append(" WHERE REQID =? AND REQ_OTP=? ");

values.add(CONF); pstm.add ("L");
values.add(REQID); pstm.add ("L");
values.add(CONF); pstm.add ("L");

db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate();

values.clear();
pstm.clear();

db.close();

if(!REQ_OTP.equals(CONF))
{
out.print("Please Enter Correct One Time Password(OTP)");
}
else
{
response.sendRedirect("confmsg.jsp?REQID="+REQID+"&APP_ID="+APP_ID);
}

}
   

%>


</FORM>
  </CENTER>
</BODY>

</HTML>
