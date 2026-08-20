<%@ include file="includeHeaderPageDLTFC.jsp" %>
<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>

<%@ page import="in.gov.mgov.SMSServices"%>


<html>
<head>

<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script type="text/javascript" src="../js/inlineMsgMain.js"></script>
<script language="javascript">
function validateform() {

var BEN_CONTACT2_MOB= document.form1.BEN_CONTACT2_MOB.value;

 var numberOnly=/^[0-9]*$/;
 

   if(BEN_CONTACT2_MOB == "") {
    inlineMsg('BEN_CONTACT2_MOB','Enter 10 digit Registered Mobile No',2);
    return false;
  }
  
   if(!numberOnly.test(BEN_CONTACT2_MOB)) {
	inlineMsg('BEN_CONTACT2_MOB','Mobile No should be in Number....',2);
				return false;
	}
  
	
	 if(Number(BEN_CONTACT2_MOB.length)!=10) {
	inlineMsg('BEN_CONTACT2_MOB','Mobile Number must be 10 digit',2);
				return false;
	}
	
	
  document.form1.ins.value="I";
  document.form1.submit();
 
}//end of function

function validateformSub(){
 document.form1.ins.value="I";
  document.form1.submit();
}


	</script>

</head>

<body>
<form name="form1"  method="Post">
<% 
//String BEN_CD =  (String) session.getAttribute("SUSERID");
	 String STRID =  (String) session.getAttribute("STRID");
	 	 String SOTP =  (String) session.getAttribute("SOTP");
		 
		 out.print(STRID);
String msgStr="";
String HRS="";
String VALID_YN="";
   DBCon db= new DBCon();
   db.connect();
  int count=0;
  
  String UPDATE_YN="";
String  TRID1="";
/*
StringBuffer qryt = new StringBuffer();
qryt.append(" SELECT trid,CASE WHEN T2 <= T1 THEN 'Y' ELSE 'N' END AS UPDATE_YN FROM (   ");
qryt.append(" SELECT trid,P_TIMESTAMP AS T1,(to_timestamp(to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'), 'yyyy-mm-dd hh24:mi:ss')) AS T2");
qryt.append(" FROM MDA_ART_OTP WHERE TRID=(SELECT MAX(TRID) FROM MDA_ART_OTP WHERE  BEN_CD="+BEN_CD+"))     ");
		 
		 
		   ResultSet rsAppt = db.execSQL(qryt.toString());
	
	 while (rsAppt.next()){
	 
	 	 UPDATE_YN=rsAppt.getString("UPDATE_YN")==null?"":rsAppt.getString("UPDATE_YN");
		 TRID1=rsAppt.getString("TRID")==null?"":rsAppt.getString("TRID");
		
	 }
	rsAppt.close();	
if (UPDATE_YN.equals("N")){
	
	String docStr="update mda_art_otp set valid_yn='N' where trid="+TRID1+" ";
		  
		    ResultSet rsDoc = db.execSQL(docStr);	
	
}
  
  
  
  
  
  
  */
  
  
  
  
  
  
  
  
    //String BEN_CD=request.getParameter("BEN_CD")==null?"":(String) request.getParameter("BEN_CD");
   
	String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");
	
	String WRD_PW="";
	String  OTP="";
		String  OTP_D="";
	String TRID="";	
	String CONTACT_NO="";
	//out.print(ins);
	
	 
	
	 
	
	 	
	

	
	
	if (ins.equals("I")) {
		 OTP = request.getParameter("OTP")==null?"":(String) request.getParameter("OTP");
	 OTP_D=request.getParameter("OTP_D")==null?"":(String) request.getParameter("OTP_D");
String user_id="";
		out.print(OTP);
		out.print(OTP_D);
		out.print(STRID);
		 StringBuffer qrytm = new StringBuffer();
         qrytm.append(" select  extract(MINUTE from (T1-T2)) hrs ,user_id FROM(select  to_timestamp(to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'), 'yyyy-mm-dd hh24:mi:ss') t1, ");
         qrytm.append("  to_timestamp(to_char(U_TIMESTAMP, 'yyyy-mm-dd hh24:mi:ss'), 'yyyy-mm-dd hh24:mi:ss') t2,user_id FROM geouser_OTP WHERE TRID="+STRID+"  ) ");
		 
		 
		   ResultSet rsApptm = db.execSQL(qrytm.toString());
	
	 while (rsApptm.next()){
	 
	 	 HRS=rsApptm.getString("HRS")==null?"0":rsApptm.getString("HRS");
		user_id=rsApptm.getString("user_id")==null?"":rsApptm.getString("user_id");
	 }
	rsApptm.close();	
		
		int t1 = Integer.parseInt(HRS);
		
		if ((OTP.equals(OTP_D)) && (t1 <= 5)){
			
			
		String docStr="update geouser_otp set valid_yn='Y',U_TIMESTAMP=SYSDATE where trid="+STRID+" ";
		  
		    ResultSet rsDoc = db.execSQL(docStr);	
			
			String docStr1="update geotag_user set act_yn='Y'  where user_id="+user_id+" ";
		  
		    ResultSet rsDoc1 = db.execSQL(docStr1);	
		 msgStr="You Can Now update  Data";
		  session.setAttribute("SmsgStr",msgStr);
	 response.sendRedirect("OtpSucMsg.jsp");	
		}
		
		 
		  
	else{
		 msgStr="ENTERED OTP IS NOT CORRECT.. PLEASE ENTER CORRECT OTP";
		  session.setAttribute("SmsgStr",msgStr);
		}
	
		
	}
	
	
	
	
	
	
	
	
%>




<table align="center">
  <tr>
    <td colspan="2">    </td>
  </tr>

  <tr > 
    <th colspan="2" > <div align="center" class="GreenLebel">
      <h2>
        <input name="ins" type="hidden" id="ins" value="">
       Approver Validation Otp </h2>
    </div></th>
    </tr>  

		
	
	<tr>
    <th ><div align="right">Enter The OTP :</div></th>
    <td ><input name="OTP" type="text" id="OTP" tabindex="2" maxlength="5" value="" autocomplete="off" >
	<input name="OTP_D" type="hidden" id="OTP_D" tabindex="2" maxlength="10" value="<%=SOTP%>" autocomplete="off" >
	</td>
    </tr>
	<tr>
    <th colspan="2" >
      <div align="center">
        <div align="center">
          <input  type="button" name="btnLogIn"   tabindex="3" id="btnLogIn" class="button" onClick="validateformSub()" value="Submit">          
        </div>      </th>
    </tr>

	
	<tr>
  
    <td colspan="2" ><H2><div align="center" class="redLebel"><strong><%=msgStr%></strong></div></H2></td>
    </tr>
  <tr> 
    <td colspan="2">     </td>
    </tr>
   
      <tr > 
        
    <th colspan="2" nowrap>
      <div align="center">Designed and Developed by Directorate of Information Technology(DIT),KVIC,Mumbai    </div></th>
      </tr>
</table>

</form>
</body>
</html>

