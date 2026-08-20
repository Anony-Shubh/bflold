<%@ include file="appIncludeHeaderPage.jsp" %>
<HTML>

<HEAD>
    <META http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
   <SCRIPT src="js/inlinemsg.js"></SCRIPT>


    <TITLE>
       
    </TITLE>
	<SCRIPT>
        function submitform() {
		
		var NEW_MOB_NO = document.form.NEW_MOB_NO.value;
		if(NEW_MOB_NO==""){
inlineMsg('NEW_MOB_NO',"Please Enter Mobile Number",2);			
return (false);
}
var NEW_MOB_NO1 = document.form.NEW_MOB_NO1.value;
		if(NEW_MOB_NO1==""){
inlineMsg('NEW_MOB_NO1',"Please Re-enter Mobile Number",2);			
return (false);
}
		
		var CHANGE_REASON = document.form.CHANGE_REASON.value;
		if(CHANGE_REASON==""){
inlineMsg('CHANGE_REASON',"Please Enter Reason",2);			
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
<FORM method = "post"  id="form" name="form">
 <%
String APP_ID=(String) session.getAttribute("sAPP_ID");
String APP_NAME="";
String MOB_NO1="";
String PREV_MOB_NO="";
String NEW_MOB_NO="";
String REQ_DATE="";
String CHANGE_REASON="";
String CURRENT_STATUS="";
String add_update="I";
String req="";
String REQID="";



DBCon db= new DBCon(); 
db.connect(); 
List values=new ArrayList(); 
List pstm=new ArrayList(); 


StringBuffer poR = new StringBuffer();

poR.append(" SELECT AD.APP_ID, "      );
poR.append(" AD.APP_NAME, trunc(DBMS_RANDOM.value(100000,999999)) as req ,"      );
poR.append(" AD.MOB_NO1, "      );
poR.append(" FUNC_GETCURRENTSTATUS(AD.APP_ID) AS CURRENT_STATUS ,(SELECT COUNT(*) FROM APP_MOB_CHANGE_LOG AM WHERE AM.APP_ID=AD.APP_ID)  AS REQCOUNT"      );  
poR.append(" FROM APP_DETAIL AD,BANK_DATAENTRY BD "      );
poR.append(" WHERE AD.APP_ID=?  AND AD.APP_ID=BD.APP_ID AND BD.ACT_ID=11 AND ACT_YN='Y'"      );




values.add(APP_ID);

String REQCOUNT="0";
ResultSet rsMain = db.executeSQL(poR.toString(),values);

String updt="N";
while (rsMain.next()){
APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");
APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
PREV_MOB_NO=rsMain.getString("MOB_NO1")==null?"":rsMain.getString("MOB_NO1");
CURRENT_STATUS=rsMain.getString("CURRENT_STATUS")==null?"":rsMain.getString("CURRENT_STATUS");
req=rsMain.getString("req")==null?"":rsMain.getString("req");
REQCOUNT=rsMain.getString("REQCOUNT")==null?"":rsMain.getString("REQCOUNT");
updt="Y";

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
  
  <% if (updt.equals("Y") ){ 
  
  if (!REQCOUNT.equals("1")) {
  
  
  %>	
<table align="center" class="pmegpTable">
 <tr>
   <td colspan="2"><div align="center"><strong>Mobile No Update form ( After forward to Bank) </strong></div></td>
 </tr>
 <tr>
   <td colspan="2">&nbsp;</td>
 </tr>
 <tr>
   <td colspan="2"><strong>Note: Only One time you can change your mobile No after Bank Sanction </strong> </td>
   </tr>
 <tr>
   <td colspan="2">(Mobile No. Change will reflect in application , after approval of Nodal Officer of the  Agency.) </td>
   </tr>
 <tr>
   <td colspan="2">&nbsp;</td>
   </tr>
 <tr>
   <td>&nbsp;</td>
   <td>&nbsp;</td>
 </tr>
 <tr>
 <td>Applicant Id:</td>
 <td><input name="APP_ID" type="text" id="APP_ID" value="<%=APP_ID%>" readonly="true"></td>
</tr>
<tr>
 <td>Applicant Name:</td>
 <td><%=APP_NAME%></td>
 </tr>
  <tr>
 <td>Current Status of Application:</td>
 <td><%=CURRENT_STATUS%></td>
  </tr>
  <tr>
 <td>Mobile Number:</td>
 <td><%=PREV_MOB_NO%></td>
  </tr>
  <tr>
 <td>New Mobile Number:</td>
 <td><input name="NEW_MOB_NO"  type="password" id="NEW_MOB_NO" onKeyPress="return numbersonly(event);" value=""  maxlength="10" onkeyup='check();'></td>
  </tr>
  <tr>
 <td>Confirm New  Mobile Number:</td>
 <td><input name="NEW_MOB_NO1"  type="text" id="NEW_MOB_NO1" onKeyPress="return numbersonly(event);" value=""  maxlength="10" onkeyup='check();' Autocomplete="off">
  <span id='message'></span></td>
 </tr>
 <tr>
<td align="left"><strong>Reason for Change:</strong></td>
<td colspan="3">
<input name="CHANGE_REASON"  type="text" id="CHANGE_REASON"  value=""  maxlength="25" >

</td>
    </tr>
 <tr>
 <td colspan="5"><div align="center">
  <INPUT name="ins" id="ins" type="hidden" value="">
   <INPUT type="button" name="Submit" class="buttonLogin" onClick="submitform();" value="Generate OTP">
 </div></td>
 </tr>
 </table>
 <%
 }else {out.print ( "You have already submitted your request contact nodal officer for approval");}
 }else{ out.print ( "You can change your mobile No, after Bank Sanction only, In case not sanctioned by Bank Contact Your Agency for Change Mobile No.");}
 
          


if ((String)request.getParameter("ins")!=null){ 
values.clear();

//PREV_MOB_NO =(String) request.getParameter("PREV_MOB_NO")==null?"":(String) request.getParameter("PREV_MOB_NO").trim(); 
NEW_MOB_NO=(String) request.getParameter("NEW_MOB_NO")==null?"":(String) request.getParameter("NEW_MOB_NO").trim();
CHANGE_REASON=(String) request.getParameter("CHANGE_REASON")==null?"":(String) request.getParameter("CHANGE_REASON").trim();
APP_ID =(String) request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID").trim();


StringBuffer qryUpdate = new StringBuffer();

ResultSet rsMax = db.execSQL("SELECT SQREQ_ID.NEXTVAL AS REQID FROM DUAL");
 while (rsMax.next()){
 REQID=rsMax.getString("REQID")==null?"":rsMax.getString("REQID");
 }
 rsMax.close();
 

qryUpdate.append(" INSERT INTO APP_MOB_CHANGE_LOG ");
qryUpdate.append("( PREV_MOB_NO ,");
qryUpdate.append(" NEW_MOB_NO ,REQ_OTP,");
qryUpdate.append(" CHANGE_REASON ,");
qryUpdate.append(" REQID ,");
qryUpdate.append(" APP_ID ");
qryUpdate.append( ") VALUES (?,?,?,?,?,?) ");



values.add(PREV_MOB_NO); pstm.add ("L");
values.add(NEW_MOB_NO); pstm.add ("L");
values.add(req); pstm.add ("L");
values.add(CHANGE_REASON); pstm.add ("L");
values.add(REQID); pstm.add ("L");
values.add(APP_ID); pstm.add ("L");

db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate();

values.clear();
pstm.clear();

db.close();

try {

 SMSServices sms1=new SMSServices();

 String SmsText="Your OTP for "+APP_ID+"  Form Change Mobile No is  : "+req+"  Regards,KVIC";

	try {
     String smsresponse=sms1.sendSingleSMS("KVICDIT", "Panda@1974",SmsText, "KVICIT",NEW_MOB_NO,"2740939a-a79d-42ba-984c-02fb4fa0e10d","1007353226336882857");
}catch (Exception e) {}
	

}catch(Exception e) {}


response.sendRedirect("otpconf.jsp?REQID="+REQID);


}

%>


</FORM>
<SCRIPT>
var check = function() {
      if (document.getElementById('NEW_MOB_NO').value ==
          document.getElementById('NEW_MOB_NO1').value) {
          document.getElementById('message').style.color = 'green';
          document.getElementById('message').innerHTML = 'Matched';
      } else {
      		document.getElementById('message').style.color = 'red';
          document.getElementById('message').innerHTML = 'Not Matching';
      }
  }
  </SCRIPT>
</BODY>

</HTML>
