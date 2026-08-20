<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="pkgPmegpNew.DBCon"%>
<%@ page import="in.gov.mgov.mobileseva.SendSMS"%>

<html>
<head>
    <%
    response.setHeader("Cache-Control", "no-cache");
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
    %>

    <title>online Application Acknowledgement</title>
	<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />

</head>

<body>
    <form>
	<img src="../images/pmegponline.jpg" width="100%" height="150" >

        <%
		
		String APP_ID= request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID") ;
		APP_ID=APP_ID.trim();
		APP_ID=APP_ID.toUpperCase();
		
        String APP_NAME="";
        String SUB_DT="";
		String MOB_NO1="";
		String E_MAIL="";
		String AADHAR_NO="";
		
		try {
		
        DBCon db= new DBCon();
        db.connect();

        

           StringBuffer qry = new StringBuffer();
         qry.append(" SELECT A.APP_ID, ");
		  qry.append("UPPER(A.APP_NAME) AS APP_NAME,  ");
		   qry.append("  TO_CHAR(A.ONLINE_SUBDT, 'DD-MON-RRRR HH:MI:SS') AS ONLINE_SUB_DT, ");
		    qry.append("  A.MOB_NO1, ");
			 qry.append(" A.DOB,  A.E_MAIL,A.AADHAR_NO ");
			  qry.append(" FROM APP_DETAIL A ");
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
		 SmsText="Dear  "+APP_NAME+ ",Note Your PMEGP e-Tracking Applicant ID "+APP_ID+". You Can View Application Status at any stage. Visit kviconline.gov.in/pmegp  ";
		 		SendSMS.sendBulkSMS("KVICDIT", "Panda@1974", "KVICIT", MOB_NO1, SmsText);

        }
		
			rsApp.close();
			db.close();
			}catch (Exception e) {
			out.print (e.toString());
			
			}
        %>
<div align="center"><img src="../images/pmegpetrackN.png"></div>
        <table align="center">
            <tr>
              <td></td>
            </tr>
            <tr>
                <th>PMEGP   Online Application for Non-Individual </th>
            </tr>



            <tr>
                <th><div align="center"><a href="pmegponlineNI.jsp?BENF_CD=4" class="greenButtonRound">Self Help Groups (SHGs) </a></div></th>
            </tr>


            <tr>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <th><div align="center"><a href="pmegponlineNI.jsp?BENF_CD=5" class="greenButtonRound">Trust</a></div></th>
            </tr>
            <tr>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <th><div align="center"><a href="pmegponlineNI.jsp?BENF_CD=2" class="greenButtonRound">Regd. Institutions</a></div></th>
            </tr>
            <tr>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <th><div align="center"><a href="pmegponlineNI.jsp?BENF_CD=3" class="greenButtonRound">Co-operative Societies</a></div></th>
            </tr>
            <tr>
              <td>&nbsp;</td>
            </tr>
			
      </table>
    </form>
</body>
</html>