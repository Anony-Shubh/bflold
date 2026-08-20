<%@ page buffer="500kb" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="pkgPmegpNew.DBCon"%>


<%@ page import="pkgPmegpNew.validateAutoForward"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>SECOND lOAN</title>

<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script language="javascript" src="../js/ModalPopupWindow.js"></script>
<script type="text/javascript" src="../js/inlinemsg.js"></script>
<script language="javascript" src="../js/popcalendarN.js"></script>
  <script language="javascript" src="../js/jquery-1.12.4.js"></script>  
<script type="text/javascript" src="../js/jquery-1.12.0.min.js"></script>
<script src="../js/jquery-customselect.js"></script>
<script type="text/javascript" src="../js/Pmegpsecondloan.js"></script>
<script src="../js/jquery.autocomplete.js"></script>
<link rel="stylesheet" type="text/css" href="../css/autolist.css" />



<script language="javascript">
  function sub_form(){	  					 	
	 document.form.ins.value='I';
     document.form.submit();
					}
					
					
					function logout(){
 window.location.href='logout.jsp'
}
	</script>
</head>

<body>
 
<form name="form"  id="form" method="post">
<%
String DIS = request.getParameter("DIS")==null?"N":(String) request.getParameter("DIS");
//out.print(Appid);
%>



 <% if (DIS.equals("N")) {%>
   <img src="../images/04_01.png" width="100%" height="150" >
  <BR><table align="center">
  <tr><input name="FLAG" type="hidden" id="FLAG" value="1">
    <td colspan="3"><div align="left">
	
      <input name="Button"  type="button" disabled="true"  class="buttonOrange" id="CHR"  onclick="index();" value="Personal Details" />
      <input name="Button2" type="button" disabled="true" class="buttonOrange" id="REC"  onclick="sanction();" value="Previous Sanction Details" />
      <input name="Button3" type="button" disabled="true" class="buttonOrange" id="CON"  onclick="charges();" value="Apply Online" />
	  <input name="Button3" type="button" disabled="true" class="buttonOrange" id="EDIT"  onclick="finalCalc();" value="Edit Application" />
     <input name="Button3" type="button" disabled="true" class="buttonOrange" id="CAL"  onclick="finalCalc();" value="Upload Documents" />
	 <input name="Button3" type="button" disabled="true" class="buttonGreen" id="up"  onclick="finalCalc();" value="Final Submit" />
	
	 <input name="Button3" type="button"  class="buttonOrange" id="LG"  onclick="logout();"  value="Logout" />
	
    </div></td>
    </tr>
</table><BR>
<%} else{%>

<%@ include file="appIncludeHeaderPage.jsp" %>

<%}%>
        <%

		String ACT_ID=request.getParameter("ACT_ID")==null?"-1":(String) request.getParameter("ACT_ID");
		//out.print(ACT_ID);
		String APP_ID= (String) session.getAttribute("sAPP_ID");
		//out.print(APP_ID);
		APP_ID=APP_ID.trim();
		APP_ID=APP_ID.toUpperCase();
		
        String APP_NAME="";
        String SUB_DT="";
		String MOB_NO1="";
		String E_MAIL="";
		String AADHAR_NO="";
		String APP_PWD="";
		String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");
		
        DBCon db= new DBCon();
        db.connect();

           StringBuffer qry = new StringBuffer();
         qry.append(" SELECT A.APP_ID,A.ACT_ID, ");
		  qry.append("UPPER(A.APP_NAME) AS APP_NAME,  ");
		   qry.append("  TO_CHAR(A.ONLINE_SUBDT, 'DD-MON-RRRR HH:MI:SS') AS ONLINE_SUB_DT, ");
		    qry.append("  A.MOB_NO1, A.APP_PWD, ");
			 qry.append(" A.DOB,  A.E_MAIL,A.AADHAR_NO ");
			  qry.append(" FROM APP_DETAIL_ONLINE_SECOND A ");
			  qry.append("WHERE A.APP_ID = '"+APP_ID+"' ");

        ResultSet rsApp = db.execSQL(qry.toString());
       String SmsText="";


        while (rsApp.next()){
		APP_ID=rsApp.getString("APP_ID")==null?"":rsApp.getString("APP_ID");
        APP_NAME=rsApp.getString("APP_NAME")==null?"":rsApp.getString("APP_NAME");
        SUB_DT=rsApp.getString("online_sub_dt")==null?"":rsApp.getString("online_sub_dt");
	    MOB_NO1=rsApp.getString("MOB_NO1")==null?"":rsApp.getString("MOB_NO1");
		 E_MAIL=rsApp.getString("E_MAIL")==null?"":rsApp.getString("E_MAIL");
		 AADHAR_NO=rsApp.getString("AADHAR_NO")==null?"":rsApp.getString("AADHAR_NO");
		 APP_PWD=rsApp.getString("APP_PWD")==null?"":rsApp.getString("APP_PWD");
		 ACT_ID=rsApp.getString("ACT_ID")==null?"":rsApp.getString("ACT_ID");
		}
		
			rsApp.close();
			
        %>
        <table align="center">
          <tr>
            <td colspan="2" scope="col">&nbsp;</td>
          </tr>
          <tr>
            <th colspan="2" scope="col"><div align="center">
              <h2>FINAL SUBMISSION OF APPLICATION </h2>
            </div></th>
          </tr>
          <tr><input name="DIS" type="hidden" id="DIS" value="<%=DIS%>">
            <td colspan="2" scope="col"><input name="ins" type="hidden" id="ins"></td><input name="ACT_ID" type="hidden" id="ACT_ID"  value="<%=ACT_ID%>"/>
          </tr>
          <tr>
            <td colspan="2" scope="col">
			
			<% if (ACT_ID.equals("0")){
			out.print ("<h1>Your Applicant ID is :  "+APP_ID+" </h1>");out.print ("</br>");
			out.print ("<h1>Your Password is :  "+APP_PWD+" </h1>");
			  }else{
				out.print ("<div class=\"redLebel\"><marquee>Click On Final Submission Button to Print Your Applicantion and forward to sponsoring Agency...... </marquee></div>");
				}
			 %>
				
				</td>
          </tr>
          <tr>
            <th scope="col"> Applicant ID </th>
            <td scope="col"><%=APP_ID%></td><input name="APP_ID" type="hidden" id="APP_ID" value="<%=APP_ID%>"></td><input name="APP_NAME" type="hidden" id="APP_NAME" value="<%=APP_NAME%>">
			</td><input name="MOB_NO1" type="hidden" id="MOB_NO1" value="<%=MOB_NO1%>">
          </tr>
          <tr>
            <th>Name of the Applicant: </th>
            <td><div align="left">
                <div align="left"><%= APP_NAME %> </div></td>
          </tr>
          <tr>
            <th>Aadhar Card No: </th>
            <td><%= AADHAR_NO %></td>
          </tr>
          <tr>
            <th>Mobile No: </th>
            <td><%= MOB_NO1 %></td>
          </tr>
          <tr>
            <th>eMail ID: </th>
            <td><%= E_MAIL%></td>
          </tr>
          <tr>
            <td colspan="2" class="redLebel">Note: (1) Data cannot be modified Once the application Finally Submitted to Sponsoring Agency. </td>
          </tr>
          <tr>
            <th colspan="2"><div align="center">
			<% if (ACT_ID.equals("-1")){ %>
              <input name="Button" type="button" class="button" value="FINAL SUBMISSION OF APPLICATION TO SPONSORING AGENCY" onClick="sub_form();">
			  
			  <% }else{%>
			  <div align="center"><a href="PMEGPGenAppForm.jsp?APP_ID=<%= APP_ID %>" class="greenButtonRound">(Click
                here to print your application in pdf format)</a> </div>
				 <% }%>
            </div></th>
          </tr>
        </table>
		<%
		if ((String)request.getParameter("ins")!=null){
					List values=new ArrayList();
	List pstm=new ArrayList(); 
 APP_ID=(String) request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID").trim();
 DIS=(String) request.getParameter("DIS")==null?"":(String) request.getParameter("DIS").trim();
 //out.print(APP_ID);
 APP_NAME=(String) request.getParameter("APP_NAME")==null?"":(String) request.getParameter("APP_NAME").trim();
 MOB_NO1=(String) request.getParameter("MOB_NO1")==null?"":(String) request.getParameter("MOB_NO1").trim();
 try {
		
		
		
		values.clear();
        pstm.clear();

        values.add(APP_ID); pstm.add ("L");
		//UPDATING STATUS
		 
		 db.setSqlValue("UPDATE APP_DETAIL_ONLINE_SECOND SET ACT_ID=0,ONLINE_SUBDT=SYSDATE WHERE APP_ID=?");
		db.setValues(values,pstm);
		db.executeUpdate() ;
		
		//INSERTING INTO APP_ONLINE ON FINAL SUBMISSION
		 db.setSqlValue("INSERT INTO APP_DETAIL_SECOND  SELECT * FROM APP_DETAIL_ONLINE_SECOND WHERE APP_ID=?");
		db.setValues(values,pstm);
		db.executeUpdate() ;
		
		session.setAttribute("sACT_ID","0"); 
		}catch (Exception e) {
		out.print (e.toString());
		
		
		}
		//if(MOB_NO1.length() == 10){
	 //String sms_string="Dear  "+APP_NAME+ ",Your PMEGP e-Tracking Application is registered. User  ID is "+APP_ID+" and password is: "+APP_PWD+". After Final Submission You can Print Application form. ";
	 //SMSServices sms1=new SMSServices();
	 //sms1.sendSingleSMS("KVICDIT", "Panda@1974",sms_string, "KVICIT",MOB_NO1,"2740939a-a79d-42ba-984c-02fb4fa0e10d");
//}
		   
 db.close();
		 
		//SmsText="Dear  "+APP_NAME+ ",Your PMEGP e-Tracking  Application ID is "+APP_ID+". You have successfully Submitted Your Application. Please Print your Applicant form ";
		 		//SendSMS.sendBulkSMS("KVICDIT", "Kvic@1974", "KVICIT", MOB_NO1, SmsText);
           
		   
		   
		   
	response.sendRedirect("final_submit.jsp?DIS="+DIS); 
  }

		%>
		
		

</form>
</body>
</html>