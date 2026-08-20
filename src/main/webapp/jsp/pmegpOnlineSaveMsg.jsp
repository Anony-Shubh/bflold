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
//var w = 700; 
//var h = 400; 
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
		String APP_PWD="";
		
	
		
        DBCon db= new DBCon();
        db.connect();

           StringBuffer qry = new StringBuffer();
         qry.append(" SELECT A.APP_ID, ");
		  qry.append("UPPER(A.APP_NAME) AS APP_NAME,  ");
		   qry.append("  TO_CHAR(A.ONLINE_SUBDT, 'DD-MON-RRRR HH:MI:SS') AS ONLINE_SUB_DT, ");
		    qry.append("  A.MOB_NO1, A.APP_PWD, ");
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
		 APP_PWD=rsApp.getString("APP_PWD")==null?"":rsApp.getString("APP_PWD");
		 //SmsText="Dear  "+APP_NAME+ ",Your PMEGP e-Tracking ID is "+APP_ID+" and password is: "+APP_PWD+". You Can Upload Documents and View Status at any stage. Visit kviconline.gov.in/pmegp  ";
		 		//SendSMS.sendBulkSMS("KVICDIT", "Panda@1974", "KVICIT", MOB_NO1, SmsText);

        }
		
			rsApp.close();
			db.close();
			
			
			
		 
		
			
			
        %>

        <table align="center">
            <tr>
                <td>(1)</td>

                <td>
                    <table align="center">
                        <tr>
                          <th colspan="2" scope="col"><div align="center">ONLINE APPLICATION ACKNOWLEDGEMENT  </div></th>
                        </tr>
                        <tr>
                          <td colspan="2" scope="col">&nbsp;</td>
                        </tr>
                        <tr>
                            <td colspan="2" scope="col"><input id="APP_ID" name="APP_ID" type="hidden" value="<%=APP_ID%>"> 
							<a href="PMEGPGenAppForm.jsp?APP_ID=<%= APP_ID %>" class="greenButtonRound">(Click
                            here to print your application in pdf format)</a>                            </td>
                        </tr>


                        <tr>
                            <th scope="col">
                                
                                    Applicant ID                            </th>

                            <td scope="col">
                                
                                    <%= APP_ID %>                                                                </td>
                        </tr>


                        <tr>
                            <th>Name of the Applicant:                            </th>

                            <td>
                                <div align="left">
                                    <div align="left"><%= APP_NAME %>                            </div></td>
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
                            <td>Online Submission Date and Time :                            </td>

                            <td>
                                <div align="left">
                                    <div align="left"><%= SUB_DT %>                            </div></td>
                        </tr>
                  </table>                </td>
            </tr>


            <tr>
                <td>
                    
                        (2)                </td>

                <td>In Case Print out of the application form could not be
                taken , Reprint Option is availble in the home page by entering
                Application ID and Date of Birth</td>
            </tr>


            <tr>
                <td>
                    
                        (3)                </td>

                <td>The printed application form along with all documents must be submitted to concerned sponsoring office for verification by seven days from the submission date or Last date
              of the advertisement, which ever is earlier.</td>
            </tr>


            <tr>
              <td>(4)</td>
              <td>If the Printed application alongwith all  document are not
                submitted in time , your application will be 
              rejected.</td>
            </tr>
            <tr>
              <td>(5)</td>
              <td>The Status of your application can be viewed online from
                the website www.kviconline.gov.in/pmegp by entering your
              applicant ID</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <th>Following Documents Required for verification: </th>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>(A) Printed Pmegp Online Application form with Signature </td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>(B) Aadhaar Card ( For Individual Applicant) </td>
            </tr>
            
            <tr>
              <td>&nbsp;</td>
              <td>(C) Project Report </td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>(D) Cast Certificate (SC/ST/OBC)  </td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>(E) Disablity Certificate (For Physically Challenged) </td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>(F) Rural /Urban Certificate (Population Certificate) from competent Authority for Proposed Unit </td>
            </tr>
            
            <tr>
              <td>&nbsp;</td>
              <td>(G) Registration Certificate ( For Non-individual Applicant) </td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>(H) TAN ( For Non-Individual Applicant) </td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>(I) EDP Training Certificate ( In Case EDP Training completed) </td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>(J) Any other supplimentary Documents </td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <th><div align="center">
			  <% String param="APP_ID="+APP_ID; %>
			    <div align="center"><a href="javascript: mypopup('upload_app_doc_puf.jsp','<%= param %>','1000','490');" class="greenButtonRound">Upload Documents (Optional)  </a></div>			 </th>
            </tr>
            <tr>
              <td colspan="2">&nbsp;</td>
            </tr>
            <tr>
              <th colspan="2"><div align="center">Documents Uploaded </div></th>
            </tr>
            <tr>
              <td colspan="2">&nbsp;</td>
            </tr>
      </table>
    </form>
</body>
</html>