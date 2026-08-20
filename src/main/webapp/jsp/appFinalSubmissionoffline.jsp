<%@ page buffer="500kb" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="pkgPmegpNew.DBCon"%>
<%@ page import="in.gov.mgov.SMSServices"%>
<%@ include file="responseheaderinclude.jsp" %>

<html>
<head>
   <title>PMEGP Tracking</title>
  
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script type="text/javascript" src="../js/pmegpOnlinemessages.js"></script>
<SCRIPT type="text/javascript" src="../js/ModalPopupWindow.js"></SCRIPT>
<script src="../js/inlineMsgMain.js"></script>

</head>

<script language="javascript">
function closeAndRefresh(){
     window.parent.refresh_data();
    }
function submit_offupdate(){
document.form.ins.value='I'; 
document.form.submit();
}
</script>

<form name="form"  id="form" method="post"  >
        <%
		
		String ACT_ID= (String) session.getAttribute("sACT_ID");
		
		String APP_ID= (String) session.getAttribute("sAPP_ID");
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
         qry.append(" SELECT A.APP_ID, ");
		  qry.append("UPPER(A.APP_NAME) AS APP_NAME,  ");
		   qry.append("  TO_CHAR(A.ONLINE_SUBDT, 'DD-MON-RRRR HH:MI:SS') AS ONLINE_SUB_DT, ");
		    qry.append("  A.MOB_NO1, A.APP_PWD, ");
			 qry.append(" A.DOB,  A.E_MAIL,A.AADHAR_NO ");
			  qry.append(" FROM APP_DETAIL_ONLINE A ");
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
		 
		 if (ins.equals("I")) {
		 
		 try {
		 List values=new ArrayList();
		List pstm=new ArrayList();
		
		
		values.clear();
        pstm.clear();

        values.add(APP_ID); pstm.add ("L");
		//UPDATING STATUS
		 
		 db.setSqlValue("UPDATE APP_DETAIL_ONLINE SET ACT_ID=0,ONLINE_SUBDT=SYSDATE WHERE APP_ID=?");
		db.setValues(values,pstm);
		db.executeUpdate() ;
		
		//INSERTING INTO APP_ONLINE ON FINAL SUBMISSION
		 db.setSqlValue("INSERT INTO APP_DETAIL  SELECT * FROM APP_DETAIL_ONLINE WHERE APP_ID=?");
		db.setValues(values,pstm);
		db.executeUpdate() ;
		
		session.setAttribute("sACT_ID","0"); 
		}catch (Exception e) {
		}
           

		 
		SmsText="Dear  "+APP_NAME+ ",Your PMEGP Portal Application ID is "+APP_ID+". You have successfully Submitted Your Application. Please Print your Applicant form. -KVIC ";
		 		 SMSServices sms1=new SMSServices();

	try {
     String smsresponse=sms1.sendSingleSMS("KVICDIT", "Panda@1974",SmsText, "KVICIT",MOB_NO1,"2740939a-a79d-42ba-984c-02fb4fa0e10d","1007544884160518735");	
}catch (Exception e) {}
			
			 

		    }
        }			
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
          <tr>
            <td colspan="2" scope="col"><input name="ins" type="hidden" id="ins"></td>
          </tr>
          <tr>
            <td colspan="2" scope="col">
			
			<% if (ACT_ID.equals("0")){
			out.print ("<h1>Your Applicant ID is :  "+APP_ID+" And Password is : "+APP_PWD+"  </h1>");
			  }else{
				out.print ("<div class=\"redLebel\"><marquee>Click On Final Submission Button to Print Your Applicantion and forward to sponsoring Agency...... </marquee></div>");
				}
			 %>
				
				</td>
          </tr>
          <tr>
            <th scope="col"> Applicant ID </th>
            <td scope="col">-</td>
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
              <input name="Button" type="button" class="button" value="FINAL SUBMISSION OF APPLICATION TO SPONSORING AGENCY" onClick="submit_offupdate();">
			  
			  <% }else{%>
			  <input name="Button" type="button" class="button" onclick="closeAndRefresh();" value="Close"/> </div>
				 <% }%>
            </div></th>
          </tr>
        </table>
</form><% rsApp.close(); db.close();%>
</body>
<script language="javascript">

var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 




function refresh_data(){
window.parent.location.reload();
}



function HideModalWindow() {
    modalWin.HideModalPopUp();
}

   </script>
</html>