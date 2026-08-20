<%@ include file="appIncludeHeaderPage.jsp" %>

<script language="javascript">
function submit_offupdate(){
	var OTP = document.form.OTP.value;
	//var OTP_D = document.form.OTP_D.value;
//alert(OTP_D);

 var numberOnly=/^[0-9]*$/;
 
 if(OTP == "") {
    inlineMsg("OTP","Enter OTP",2);
    return false;
	 }
	 

	
	 if(Number(OTP.length)!=8) {
	inlineMsg('OTP','Invalid OTP.......',2);
				return false;
	}
	/*if(OTP != OTP_D ) {
    inlineMsg("OTP","Incorrect OTP",2);
    return false;
	 }*/
document.form.ins.value='I'; 
document.form.submit();
}

function submit_offupdateOTP(){
	
	
document.form.ins.value='O'; 
document.form.submit();
}
</script>

<form name="form"  id="form" method="post"  >
        <%
		String DIS_YN="N";
		String ACT_ID= (String) session.getAttribute("sACT_ID");
		String STRID= (String) session.getAttribute("STRID");
		String APP_ID= (String) session.getAttribute("sAPP_ID");
		String msgStrFS=(String) session.getAttribute("msgStrFS")==null?"":(String) session.getAttribute("msgStrFS");
		  DIS_YN=(String) session.getAttribute("DIS_YN")==null?"N":(String) session.getAttribute("DIS_YN");
		  String CLIENT_IP= (String)session.getAttribute("SCLIENTIP") ;
		//out.print("msg"+CLIENT_IP);
		APP_ID=APP_ID.trim();
		APP_ID=APP_ID.toUpperCase();
		
        String APP_NAME="";
        String SUB_DT="";
		String MOB_NO1="";
		String E_MAIL="";
		String AADHAR_NO="";
		String APP_PWD="";
		String CONTACT_NO="";
		String TRID="";
		String OTP="";
		
		String HRS="";
		
		String OTP_D =(String) session.getAttribute("OTP_D");
		String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");
		//out.print("ins"+ins);
        DBCon db= new DBCon();
        db.connect();

           StringBuffer qry = new StringBuffer();
         qry.append(" SELECT A.APP_ID,LPAD(SUBSTR(MOB_NO1,-4),LENGTH(MOB_NO1),'X') AS CONTACT_NO , ");
		  qry.append("UPPER(A.APP_NAME) AS APP_NAME,  ");
		   qry.append("  TO_CHAR(A.ONLINE_SUBDT, 'DD-MON-RRRR HH:MI:SS') AS ONLINE_SUB_DT, ");
		    qry.append("  A.MOB_NO1, A.APP_PWD, ");
			 qry.append(" A.DOB,  A.E_MAIL,A.AADHAR_NO ");
			  qry.append(" FROM APP_DETAIL_ONLINE A ");
			  qry.append("WHERE A.APP_ID = '"+APP_ID+"' ");

        ResultSet rsApp = db.execSQL(qry.toString());
       String SmsText="";
int count=0;

        while (rsApp.next()){
		APP_ID=rsApp.getString("APP_ID")==null?"":rsApp.getString("APP_ID");
        APP_NAME=rsApp.getString("APP_NAME")==null?"":rsApp.getString("APP_NAME");
        SUB_DT=rsApp.getString("online_sub_dt")==null?"":rsApp.getString("online_sub_dt");
	  MOB_NO1=rsApp.getString("MOB_NO1")==null?"":rsApp.getString("MOB_NO1");
		 E_MAIL=rsApp.getString("E_MAIL")==null?"":rsApp.getString("E_MAIL");
		 AADHAR_NO=rsApp.getString("AADHAR_NO")==null?"":rsApp.getString("AADHAR_NO");
		 APP_PWD=rsApp.getString("APP_PWD")==null?"":rsApp.getString("APP_PWD");
		 CONTACT_NO=rsApp.getString("CONTACT_NO")==null?"":rsApp.getString("CONTACT_NO");
		 count=count+1;
		
		 	 if (ins.equals("O")) {
		 if (count>0) {
			MOB_NO1=(String) request.getParameter("MOB_NO1")==null?"":(String) request.getParameter("MOB_NO1").trim(); 
			 //CONTACT_NO=(String) request.getParameter("CONTACT_NO")==null?"":(String) request.getParameter("CONTACT_NO").trim();
		
		
	
		 ResultSet rsMax= db.execSQL("select nvl(max(TRID),0)+1 from PMEGP_OTP ");
     while (rsMax.next()) {
     TRID=rsMax.getString(1);
     }
rsMax.close();
 session.setAttribute("STRID",TRID);


		ResultSet rsRd = db.execSQL("select round(dbms_random.value(10000000,99999999),0) APP_PWD from dual ");
		
		while (rsRd.next()){
		  OTP=rsRd.getString(1);
		}
		rsRd.close();
 String sms_string=" Your OTP for PMEGP Application Form of Final Authentication is : "+OTP+" Regards, KVIC ";
 


	 SMSServices sms1=new SMSServices();
			try {
	      String smsresponse=sms1.sendSingleSMS("KVICDIT", "Panda@1974",sms_string, "KVICIT",MOB_NO1,"2740939a-a79d-42ba-984c-02fb4fa0e10d","1007353226336882857");	
}catch (Exception e) {}

		
	StringBuffer qryUpdate = new StringBuffer();
						
							List values=new ArrayList();
							List pstm=new ArrayList();
						
						qryUpdate.append(" INSERT INTO PMEGP_OTP ( TRID,");
						qryUpdate.append("APP_ID,");
						
						qryUpdate.append("MOB_NO,");
						qryUpdate.append("OTP,VALID_YN,U_TIMESTAMP ) VALUES (?,?,?,?,'N',SYSDATE) ");
						
						values.add (TRID);pstm.add ("S");
						values.add (APP_ID);pstm.add ("S");
						
						values.add (MOB_NO1);pstm.add ("S");
		                values.add (OTP);pstm.add ("S");
						db.setValues(values,pstm);
						db.setSqlValue(qryUpdate.toString());
						db.executeUpdate() ;
						pstm.clear();
						values.clear();	
						 session.setAttribute("STRID",TRID);
						 session.setAttribute("OTP_D",OTP);
						
	
	 msgStrFS="your otp for final submission has been sent to your mobile no "+CONTACT_NO+" ";
	 }else {
	  msgStrFS="No Data found Please verify ....";
	 }
	 session.setAttribute("msgStrFS",msgStrFS);
	 session.setAttribute("DIS_YN","Y");
		 response.sendRedirect("appFinalSubmission.jsp");
		}
		 
		 
		  if (ins.equals("I")) {
			  
		 	OTP=(String) request.getParameter("OTP")==null?"":(String) request.getParameter("OTP").trim();
			
			 StringBuffer qrytm = new StringBuffer();
         qrytm.append(" select extract(hour from (T1-T2)) hrs FROM(select  to_timestamp(to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'), 'yyyy-mm-dd hh24:mi:ss') t1, ");
         qrytm.append("  to_timestamp(to_char(U_TIMESTAMP, 'yyyy-mm-dd hh24:mi:ss'), 'yyyy-mm-dd hh24:mi:ss') t2 FROM PMEGP_OTP WHERE TRID="+STRID+") ");
		 
		// session.setAttribute("SBEN_CD",BEN_CD);	
		   ResultSet rsApptm = db.execSQL(qrytm.toString());
	
	 while (rsApptm.next()){
	 
	 	 HRS=rsApptm.getString("HRS")==null?"":rsApptm.getString("HRS");
		
		
	 }
	rsApptm.close();	
		
		int t1 = Integer.parseInt(HRS);
		
		if ((OTP.equals(OTP_D)) && (t1 <= 1)){
		String docStr="update PMEGP_otp set valid_yn='Y',A_TIMESTAMP=SYSDATE where trid="+STRID+" ";
		    ResultSet rsDoc = db.execSQL(docStr);	
					 try {
		 List values=new ArrayList();
		List pstm=new ArrayList();
		
		
		values.clear();
        pstm.clear();
		try {
		values.add(CLIENT_IP); pstm.add ("L");
        values.add(APP_ID); pstm.add ("L");
		//UPDATING STATUS
		 
		 db.setSqlValue(" UPDATE APP_DETAIL_ONLINE SET ACT_ID=0,CLIENT_IP=?,ONLINE_SUBDT=SYSDATE WHERE APP_ID=? ");
		db.setValues(values,pstm);
		db.executeUpdate() ;
		}
		catch(Exception e)
{out.print(e);}
		values.clear();
        pstm.clear();
		//INSERTING INTO APP_ONLINE ON FINAL SUBMISSION
		try {
		 values.add(APP_ID); pstm.add ("L");
		db.setSqlValue("INSERT INTO APP_DETAIL  SELECT * FROM APP_DETAIL_ONLINE WHERE APP_ID=?");
		db.setValues(values,pstm);
		db.executeUpdate() ;
	
		session.setAttribute("sACT_ID","0"); 
		
		}
		catch(Exception e)
{out.print(e);}
		
		
		
		}catch (Exception e) {
		}
           
 
		 
		SmsText="Dear  "+APP_NAME+ ",Your PMEGP Portal Application ID is "+APP_ID+". You have successfully Submitted Your Application. Please Print your Applicant form. -KVIC ";
		 		 SMSServices sms1=new SMSServices();

	try {
     String smsresponse=sms1.sendSingleSMS("KVICDIT", "Panda@1974",SmsText, "KVICIT",MOB_NO1,"2740939a-a79d-42ba-984c-02fb4fa0e10d","1007544884160518735");	
}catch (Exception e) {}
 

					String docStr1="update pmegp_otp set valid_yn='Y',A_TIMESTAMP=SYSDATE where trid="+STRID+" ";
		    ResultSet rsDoc1 = db.execSQL(docStr1);	
			
			//01-11-2024 clientip
			
	String docStr5="update app_detail set client_ip='"+CLIENT_IP+"' where app_id='"+APP_ID+"' ";
		    ResultSet rsDoc5 = db.execSQL(docStr5);	
		
		 msgStrFS="Application Submitted Successfully...";
	 }else {
	  msgStrFS="Incorrect OTP....";
	 }
		
		// session.setAttribute("DIS_YN","N");
		session.setAttribute("msgStrFS",msgStrFS);
		response.sendRedirect("appFinalSubmission.jsp");
		    }
		}rsApp.close();
		
	
		
        %>
        <table align="center">
          <tr>
            <td colspan="3" scope="col">&nbsp;</td>
          </tr>
          <tr>
            <th colspan="3" scope="col"><div align="center">
              <h2>FINAL SUBMISSION OF APPLICATION </h2>
            </div></th>
          </tr>
          <tr>
            <td colspan="3" scope="col"><input name="ins" type="hidden" value="<%=ins%>" id="ins"></td>
          </tr>
          <tr>
            <td colspan="3" scope="col">
			
			<% if (ACT_ID.equals("0")){
			out.print ("<h1>Your Applicant ID is :  "+APP_ID+" </h1>");
			  }else{
				out.print ("<div class=\"redLebel\"><marquee>Click On Get Otp to Final Submit...... </marquee></div>");
				}
			 %>				</td>
          </tr>
          <tr>
            <th colspan="2" scope="col"> Applicant ID </th>
            <td scope="col">-</td>
          </tr>
          <tr>
            <th colspan="2">Name of the Applicant: </th>
            <td><div align="left">
                <div align="left"><%= APP_NAME %> </div></td>
          </tr>
          
          <tr>
            <th colspan="2">Mobile No: </th>
            <td><%= MOB_NO1 %></td>
          </tr>
          <tr>
            <th colspan="2">eMail ID: </th>
            <td><%= E_MAIL%></td>
          </tr>
		  <% if (ACT_ID.equals("-1")){%>
          <tr>
            <td colspan="3" class="redLebel">Note: (1) Data cannot be modified Once the application Finally Submitted to Sponsoring Agency. </td>
          </tr>
		  <%}%>
		  	<% if (ACT_ID.equals("-1")){ %>
			<br/>
          <tr>
            <th colspan="2">Enter OTP </th>
			<input name="MOB_NO1" type="hidden" id="MOB_NO1" value="<%= MOB_NO1 %>">
            <td><input name="OTP" type="password" id="OTP"  maxlength="8" value="<%= OTP %>">
			<input name="OTP_D " type="hidden" id="OTP_D " value="<%= OTP_D  %>">
			<% if (DIS_YN.equals("N")){%>
			<input name="Button" type="button" class="button" value="Get OTP" onClick="submit_offupdateOTP();">
			<%}%></td>
          </tr>
		  <%}%>
		
          <tr>
            <th colspan="3"><div align="center">
			<% if (ACT_ID.equals("0")){ %>
			  <div align="center"><a href="PMEGPGenAppForm.jsp?APP_ID=<%= APP_ID %>" class="greenButtonRound">(Click
                here to print your application in pdf format)</a> </div>
				 <% }%>
            </div></th>
          </tr>
		  
<tr>
    <td colspan="3" ><div align="center" class="redLebel"><%=msgStrFS%></div></td>
</tr>
  <% if ((ACT_ID.equals("-1"))&& (DIS_YN.equals("Y"))){ %>
		     <tr>
            <th colspan="3"><div align="center">
              <input name="Button2" type="button"  class="button" onclick="submit_offupdate();" value="FINAL SUBMIT" />
            </div>
				 
            </div></th>
          </tr>
		  <% }db.close();%>
        </table>
</form>
</body>
</html>