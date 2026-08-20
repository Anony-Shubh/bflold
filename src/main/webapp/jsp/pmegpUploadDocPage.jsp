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
<script language="javascript">
function mypopup(myurl,param,w,h ) { 
var winl = (screen.width-w)/2; 
var wint = (screen.height-h)/2; 
if (winl < 0) winl = 0; 
if (wint < 0) wint = 0; 
var page = myurl+'?'+param; 
windowprops = "height="+h+",width="+w+",top="+ wint +",left="+ winl +",location=no,scrollbars=yes,menubars=no,toolbars=no,resizable=no,status=no"; 
window.open(page, "Popup", windowprops); 
} 

</script>
</head>

<body>
    <form>
	    <p><img src="../images/pmegponline.jpg" width="100%" height="150" >
	      
	        <%
		
		String APP_ID= request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID") ;
		APP_ID=APP_ID.trim();
		APP_ID=APP_ID.toUpperCase();
		
        String APP_NAME="";
        String SUB_DT="";
		String MOB_NO1="";
		String E_MAIL="";
		String AADHAR_NO="";
		String APP_PWD="";
		
	
		
        DBCon db= new DBCon();
        db.connect();

           StringBuffer qry = new StringBuffer();
         qry.append(" SELECT A.APP_ID,A.BENF_TYPE_CD,A.BENF_CATAGORY_CD,BENF_SPECAT_CD, ");
		  qry.append("UPPER(A.APP_NAME) AS APP_NAME,  ");
		   qry.append("  TO_CHAR(A.ONLINE_SUBDT, 'DD-MON-RRRR HH:MI:SS') AS ONLINE_SUB_DT, ");
		    qry.append("  A.MOB_NO1, A.APP_PWD, ");
			 qry.append(" A.DOB,  A.E_MAIL,A.AADHAR_NO ");
			  qry.append(" FROM APP_DETAIL A ");
			  qry.append("WHERE A.APP_ID = '"+APP_ID+"' ");

//out.print(qry.toString());
        ResultSet rsApp = db.execSQL(qry.toString());
       String SmsText="";

String QryUpload="";
        while (rsApp.next()){
		APP_ID=rsApp.getString("APP_ID")==null?"":rsApp.getString("APP_ID");
        APP_NAME=rsApp.getString("APP_NAME")==null?"":rsApp.getString("APP_NAME");
        SUB_DT=rsApp.getString("online_sub_dt")==null?"":rsApp.getString("online_sub_dt");
	  MOB_NO1=rsApp.getString("MOB_NO1")==null?"":rsApp.getString("MOB_NO1");
		 E_MAIL=rsApp.getString("E_MAIL")==null?"":rsApp.getString("E_MAIL");
		 AADHAR_NO=rsApp.getString("AADHAR_NO")==null?"":rsApp.getString("AADHAR_NO");
		 APP_PWD=rsApp.getString("APP_PWD")==null?"":rsApp.getString("APP_PWD");
		 SmsText="Dear  "+APP_NAME+ ",Your PMEGP e-Tracking ID is "+APP_ID+" and password is: "+APP_PWD+". You Can Upload Documents and View Status at any stage. Visit kviconline.gov.in/pmegp  ";
		 		//SendSMS.sendBulkSMS("KVICDIT", "Panda@1974", "KVICIT", MOB_NO1, SmsText);

        }
		
			rsApp.close();
			db.close();
			
			
			
		 
		
			
			
        %>
      </p>
	    <table border="1" align="center">
          <tr>
            <th colspan="2">Note:</th>
          </tr>
          <tr>
            <th>(1)</th>
            <th><p> ID and password has been sent to your 1st Registered Mobile No</p></th>
          </tr>
          <tr>
            <th>(2)</th>
            <th> After Login You can Update your Application Form and Upload Necessary Documents for Final Submission. </th>
          </tr>
          <tr>
            <th>(3)</th>
            <th> For &quot;FINAL SUBMISSION&quot; of Application to the Concerned agency  Documents with Photo Must be uploaded. </th>
          </tr>
          <tr>
            <th>(4)</th>
            <th> After completion of upload documents and necessary correction in the PMEGP Online Application, Please Click on &quot;FINAL SUBMISSION BUTTION&quot; </th>
          </tr>
          <tr>
            <th>(5)</th>
            <th> After FINAL SUBMISSION you can Print your Application Form and entire Application with uploaded Documents will be forwarded to the concerned Agency.</th>
          </tr>
        </table>
	    <p>&nbsp;</p>
	    <table border="1" align="center">
          <tr>
            <th colspan="2"><div align="center">PMEGP Applicant Login </div></th>
          </tr>
          <tr>
            <td colspan="2" class="GreenLebel"><div align="center">
              <p>Enter User ID and Password Sent to Your Registered Mobile No. <br>
                <br>
              </p>
            </div></td>
          </tr>
          <tr>
            <td colspan="2" class="GreenLebel">&nbsp;</td>
          </tr>
          <tr>
            <th>Enter User ID </th>
            <td><input type="text" name="textfield"></td>
          </tr>
          <tr>
            <th>Enter Password </th>
            <td><input type="text" name="textfield2"></td>
          </tr>
          <tr>
            <th colspan="2" class="redLebel">(For Final Submission of Requir  Documents Must Be Uploaded) </th>
          </tr>
          <tr>
            <td colspan="2"><div align="center">
                <input name="Submit" type="submit" class="button" value="Login">
            </div></td>
          </tr>
        </table>
	    <p>&nbsp;</p>
	    <p>&nbsp;</p>
	    <p>&nbsp;</p>
	    <p>&nbsp;</p>
	    <p>&nbsp; </p>
	    <p>&nbsp;</p>
	    <p>&nbsp;</p>
	    <p>&nbsp;</p>
	    <p>&nbsp;</p>
</form>
</body>
</html>