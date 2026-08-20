
<%@ page session="true" import="java.sql.*,java.util.*,java.util.zip.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%
response.setContentType("text/html");
response.setHeader("Cache-Control", "no-cache,must-revalidate");
response.addHeader("Cache-Control", "post-check=0,pre-check=0");
response.addHeader("Cache-Control", "proxy-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", -1);
response.addHeader("X-XSS-Protection", "1; mode=block");
response.addHeader("X-Content-Type-Options", "nosniff");
response.addHeader("X-Frame-Options", "DENY");
%>
<html>
<head>
<title>FB Profile View Page</title>

<link rel="stylesheet" type="text/css" href="css/indexr.css">
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/msgwindow.js"></script>
<link rel="stylesheet" type="text/css" href="css/loadingbox.css">

<style>
.redLebel
{
 color:#FF0000;
 font-size:24px;
 font-weight:bold;

}

</style>

<script type="text/javascript">
function dateChange(){
vYR=document.getElementsByName("SEL_YEAR")[0].value
var todaydt=new Date();
var dd=todaydt.getDate();
var mm=todaydt.getMonth()+1;
var yr=todaydt.getFullYear();
var months=['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
var showdt=dd+'-'+months[mm-1]+'-'+yr;
showdt=showdt.toUpperCase();

 if  (vYR=='ALL'){
document.getElementsByName("RFROMDT")[0].value='01-JUL-2016';
document.getElementsByName("RTODATE")[0].value=showdt;
}


 if  (vYR=='2016-17'){
document.getElementsByName("RFROMDT")[0].value='01-JUL-2016';
document.getElementsByName("RTODATE")[0].value='31-MAR-2017';
}

 if  (vYR=='2017-18'){
document.getElementsByName("RFROMDT")[0].value='01-APR-2017';
document.getElementsByName("RTODATE")[0].value='31-MAR-2018';
}

 if  (vYR=='2018-19'){
document.getElementsByName("RFROMDT")[0].value='01-APR-2018';
document.getElementsByName("RTODATE")[0].value='31-MAR-2019';
}

 if  (vYR=='2019-20'){
document.getElementsByName("RFROMDT")[0].value='01-APR-2019';
document.getElementsByName("RTODATE")[0].value='31-MAR-2020';
}

if  (vYR=='2020-21'){
document.getElementsByName("RFROMDT")[0].value='01-APR-2020';
document.getElementsByName("RTODATE")[0].value='31-MAR-2021';
}
if  (vYR=='2021-22'){
document.getElementsByName("RFROMDT")[0].value='01-APR-2021';
document.getElementsByName("RTODATE")[0].value='31-MAR-2022';
}

if  (vYR=='2022-23'){
document.getElementsByName("RFROMDT")[0].value='01-APR-2022';
document.getElementsByName("RTODATE")[0].value='31-MAR-2023';
}

if  (vYR=='2023-24'){
document.getElementsByName("RFROMDT")[0].value='01-APR-2023';
document.getElementsByName("RTODATE")[0].value=showdt;
}
}

$.hideprogress = function()
{
    $("#processing_container").remove();
    $("#processing_overlay").remove();
}

function urlparam(){
var vfrdt=document.getElementsByName("RFROMDT")[0].value;
var vtodt=document.getElementsByName("RTODATE")[0].value;
var pars   ='?FROMDT=' + vfrdt+ '&TODT=' + vtodt;
return(pars);
//alert (pars);
}

function fillinbox(repnm){
     $.showprogress('PMEGP ePortal  Monitoring Report Of Bank ','Please Wait Loading.....','<img src="Images/loadingfinal.gif"/>');
         $.post(repnm+urlparam(),{action:'PMEGP ePortal Bank Monitoring Report Loading...',page:'1'},
         function(ret){
          $("#divResult").html(ret);
		  $.hideprogress();
         } 
       );
    // $.hideprogress();
}

function fillinSq(repnm){
     $.showprogress('PMEGP ePortal  Monitoring Report Of Bank ','Please Wait Loading.....','<img src="Images/loadingfinal.gif"/>');
         $.post(repnm+urlparam(),{action:'PMEGP ePortal Bank Monitoring Report Loading...',page:'1'},
         function(ret){
          $("#divResult").html(ret);
		  $.hideprogress();
         } 
       );
     $.hideprogress();
}



function printDiv(divID) {
            //Get the HTML of div
            var divElements = document.getElementById(divID).innerHTML;
            //Get the HTML of whole page
            var oldPage = document.body.innerHTML;

            //Reset the page's HTML with div's HTML only
            document.body.innerHTML = 
              "<html><head><title></title></head><body>" + 
              divElements + "</body>";

            //Print Page
            window.print();

            //Restore orignal HTML
            document.body.innerHTML = oldPage;

          
        }
</script>
  <script>
  function form_submit(){  
	var APP_ID = document.form.APP_ID.value;
	if (APP_ID== "") {	 inlineMsg ( 'APP_ID','ENTER APPLICATION ID',2);	return (false);}    	
	document.form.submit();

}


</script>
</head>
<body onLoad="dateChange();">
<%String vUsrnm= (String) session.getAttribute("sponc_banknm");
  String APP_ID =request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID") ;
  
  %>
<form  method="post"  name="form" action="FindByID.jsp" >
<img src="../images/pmegponlineN.jpg" width="100%">
<table align="center" width="100%">
    <tr>
      <th colspan="9"></th>
    </tr>
    <tr>
      <td colspan="9"><div align="center">
        <span class="style6"><img src="../images/pmegpetrackN.png" width="699" height="83"></span>      </div></td>
    </tr>
      <th colspan="9" nowrap><div align="center" class="headings"><strong>Login  User ( <%= vUsrnm %>)</strong></div></th>
    </tr>
    <tr>
      <td ><div align="right"> Year</div></td>
      <td ><select name="SEL_YEAR"  id="SEL_YEAR" onChange="dateChange();">
	   <option value="ALL" >ALL YEAR</option>
        <option value="2016-17">2016-17</option>
		  <option value="2017-18" >2017-18</option>
		   <option value="2018-19">2018-19</option>
		      <option value="2019-20" >2019-20</option>
			   <option value="2020-21" >2020-21</option>
			     <option value="2021-22">2021-22</option> 
				  <option value="2022-23"  >2022-23</option>  
 <option value="2023-24" selected >2023-24</option>  				  
                  </select></td>
      <td> <div align="right">From Date: </div></td>
      <td >
        <input name="RFROMDT" type="text"  id="RFROMDT" size="13" maxlength="11"> </td>
      <td ><div align="right">To </div></td>
      <td  colspan="4">
      <input name="RTODATE" type="text"  id="RTODATE" size="14" maxlength="11"></td>
    </tr>
    
    <tr>
      <td colspan="9"><table  align="center" cellpadding="4" cellspacing="4" width="100%">
        <tr>
          <th><input name="msreport"  id="msreport" class="button" type="submit"  value="Home"></th>
          <th>
		  
		  <input name="msreport"  id="msreport" class="button" type="button" onClick="fillinbox('pmegpbankmr.jsp');" value="Report"></th>
		   <th> <input name="msreport"  id="msreport" class="button" type="button" onClick="fillinbox('pmegpbankmrSecond.jsp');" value="Second Loan Report"></th>
		  <th><input name="msreport"  id="msreport" class="button" type="button" onClick="javascript:window.open('misc/bankmonitoring_usermanual.pdf')" value="User Manual"></th>
          <th><input name="msreport"  id="msreport" class="button" type="button" onClick="fillinbox('BankMRFAQ.jsp');" value="FAQ"></th>
<th><input name="msreport"  id="msreport" class="button" type="button" onClick="fillinSq('FindByID.jsp');" value="FindBy TranAcno"></th>
          <th><input name="msreport"  id="msreport" class="button" type="button" onClick="location.replace('logout.jsp')" value="Logout"></th>
        </tr>
      </table></td>
    </tr>
  </table>
    <div align="center">
      <p>
        <%
		
  
String TR_ID = "";

String APP_NAME = "";
String MOB_NO1 = "";
String GENDER = "";
String E_MAIL = "";
String UNIT_LOC = "";
String ADDRESS="";
String AADHAR_NO = "";
String PAN_NO = "";
String DISTRICT_NAME = "";
String STATE_NM = "";
String IFSC_CODE = "";
String BANK_NAME = "";
String BRANCHNAME = "";
String MM_CLAIM_DT = "";
String MM_CLAIM_AMT = "";
String APP_FEES = "";
String PBATCH_ID = "";
String BATCH_DATE = "";
String MM_REL_AMT = "";
String MM_REL_DT = "";
String UTRN_NO = "";
String PAY_STATUS = "";
String MMCLAIM_TRANSACNO = "";
String FAIL_REASON = "";
String CREENT_NEFT_IFSC = "";
String CURRENT_TRACCNO = "";
String PAYBLE_MM = "";
String BR_IFSL_CODE = "";
String SANC_YR="";
String OLDCOUNT="";
String OLDIFSC="";
String NODAL_BANK = "";
String PFMS_TRANS_ACNO = "";
String PFMS_BENCODE = "";
String PFMS_NEFT = "";
String PFMS_BANKNAME = "";
String PFMS_UPDATE = "";
String VALIDATION_REMARKS = "";
String PFMS_BENNM_PASSBOOK = "";
String EMAIL = "";
String CONT_NO = "";
String pro_prjcst="";
String APPLOAN_ACCNO = "";
String sanc_prjcst = "";
String FB_ACNO = "";


DBCon db= new DBCon();
db.connect();
List values=new ArrayList();
List pstm=new ArrayList();





		
%>
      </p>
      <p>&nbsp;</p>
    </div>
	<p></p>
<p></p>
<p></p>
  <table width="880" border="1" align="center" bordercolor="#000066" bgcolor="#FFFFFF">

  <tr bgcolor="#FF9966"><th colspan="4"><div align="center">Nodal Bank View ( <%= vUsrnm%> Login)
     
  </div></th>
  </tr>
 <tr>
  <th height="43" align="left" nowrap bgcolor="#CCCCCC" >   <input name="ins" type="hidden" id="ins" value="">	
  Transient Acno*</th>
   
	<td bgcolor="#CCCCCC"><input name="APP_ID"  id="APP_ID" placeholder="Transient Acno" size="21" maxlength="21">	</td>
    <td bgcolor="#CCCCCC"><input name="Button" type="button" class="button" onClick="form_submit();" value="SEARCH"></td>
 </tr>
	
	<tr>
	<th colspan="4">&nbsp;</th>                              
	</tr>
  </table> 
  
  
  <% if (!APP_ID.equals("")) {  %>
  
  
 
  
  <p>&nbsp;</p>
  <table width="880" border="1" align="center" bordercolor="#000066" bgcolor="#FFFFFF">
        <thead>
             <TR>
      <TH bgcolor="#FF9966">Srno</TH>
	 
       <TH bgcolor="#FF9966">PMEGP APPLICATION ID</TH>
      <TH bgcolor="#FF9966" nowrap>PMEGP APPLICANT Name</TH>       
	   <TH bgcolor="#FF9966">Financing Branch IFSC</TH>
	    
	     
	   <TH bgcolor="#FF9966">Loan AcNo</TH>
	    
       <TH bgcolor="#FF9966" nowrap>Claim Date </TH>	  
	  <TH bgcolor="#FF9966">MM Claim (in Rs) :</TH>
       <TH bgcolor="#FF9966">(Less)Application    Fees </TH>
      <TH bgcolor="#FF9966" nowrap>MM  Released to FB</TH>
	 
      <TH nowrap bgcolor="#FF9966">MM Rease Date:</TH>
	  <TH bgcolor="#FF9966">UTRN/Transaction no.</TH>
       <TH bgcolor="#FF9966">Pay Status </TH>
      <TH bgcolor="#FF9966" nowrap>Fail Reason</TH>
	  </TR>
	   </THEAD>
	   <TBODY>
	   <% 
  
 
 
	   StringBuffer qry= new StringBuffer();
qry.append("      SELECT BD.TR_ID,"      );
qry.append("        BD.APP_ID,"      );
qry.append("        AD.APP_NAME,"      );
qry.append("        AD.MOB_NO1,"      );
qry.append("        AD.GENDER, nvl(bd.MACHINARY_COST,0)+nvl(bd.WORKING_CAPITAL,0) as pro_prjcst,"      );
qry.append("        AD.E_MAIL,"      );
qry.append("        AD.UNIT_LOC,DECODE(BD.APPLOAN_ACCNO,NULL,NULL, '*****'    || substr(BD.APPLOAN_ACCNO,8,length(BD.APPLOAN_ACCNO)-5))APPLOAN_ACCNO,"      );
qry.append("        AD.AADHAR_NO,"      );
qry.append("        AD.PAN_NO,"      );
qry.append("       MD.DISTRICT_NAME,"      );
qry.append("        MS.STATE_NM,  nvl(bd.CE_SANC_FB,0)+nvl(bd.WC_SANC_FB,0) as sanc_prjcst,   "      );
qry.append("        TO_CHAR(BD.MM_CLAIM_DT,'DD-MON-RRRR') AS MM_CLAIM_DT, "      );
qry.append("        BD.MM_CLAIM_AMT, bd.FB_ACNO,"      );
qry.append("        500 AS APP_FEES,"      );
qry.append("        BD.PBATCH_ID,"      );
qry.append("        TO_CHAR(BD.BATCH_DATE,'DD-MON-RRRR') AS BATCH_DATE, "      );
qry.append("        BD.MM_REL_AMT,"      );
qry.append("        TO_CHAR(BD.MM_REL_DT,'DD-MON-RRRR') AS MM_REL_DT, "      );
qry.append("        BD.UTRN_NO,"      );
qry.append("        BD.PAY_STATUS,"      );
qry.append("        BD.FB_ACNO AS MMCLAIM_TRANSACNO,"      );
qry.append("        case when  UPPER(BD.PAY_STATUS) like 'S%' THEN '' ELSE BD.FAIL_REASON END AS FAIL_REASON ,"      );
qry.append("        FGETNEFTIFSCODE(AD.APP_ID) AS CREENT_NEFT_IFSC,    "      );
qry.append("        BD.MM_CLAIM_AMT - 500      AS PAYBLE_MM,getfinyr(bd.loan_sanc_dt) AS SANC_YR,"      );
qry.append("      BD.IFSC_CODE as NODAL_BANK "      );
qry.append("      FROM BANK_DATAENTRY BD,"      );
qry.append("        APP_DETAIL AD,"      );
qry.append("        BANK_BR_MAST BBM,"      );
qry.append("        RBIBANKLIST RBL,"      );
qry.append("        M_DISTRICT MD,"      );
qry.append("        M_STATE MS"      );
qry.append("      WHERE AD.APP_ID      = BD.APP_ID"      );
qry.append("      AND AD.UNIT_DIST_CD  = MD.DISTRICT_CD"      );
qry.append("      AND MD.STATE_CD      = MS.STATE_CD"      );
qry.append("      AND BBM.BR_IFSL_CODE = AD.IFSC_CODE"      );
qry.append("      AND BBM.BR_IFSL_CODE = RBL.IFSC_CODE AND BD.PACT_ID=34 "      );
qry.append("     AND UPPER(BBM.spon_bank_name) = UPPER(?)  and bd.fb_acno=? "      );
qry.append("  UNION ");
qry.append("      SELECT BD.TR_ID,"      );
qry.append("        BD.APP_ID,"      );
qry.append("        AD.APP_NAME,"      );
qry.append("        AD.MOB_NO1,"      );
qry.append("        AD.GENDER, nvl(bd.MACHINARY_COST,0)+nvl(bd.WORKING_CAPITAL,0) as pro_prjcst,"      );
qry.append("        AD.E_MAIL,"      );
qry.append("        AD.UNIT_LOC,DECODE(BD.APPLOAN_ACCNO,NULL,NULL, '*****'    || substr(BD.APPLOAN_ACCNO,8,length(BD.APPLOAN_ACCNO)-5))APPLOAN_ACCNO,"      );
qry.append("        AD.AADHAR_NO,"      );
qry.append("        AD.PAN_NO,"      );
qry.append("       MD.DISTRICT_NAME,"      );
qry.append("        MS.STATE_NM,  nvl(bd.CE_SANC_FB,0)+nvl(bd.WC_SANC_FB,0) as sanc_prjcst,   "      );
qry.append("        TO_CHAR(BD.MM_CLAIM_DT,'DD-MON-RRRR') AS MM_CLAIM_DT, "      );
qry.append("        BD.MM_CLAIM_AMT, bd.FB_ACNO,"      );
qry.append("        500 AS APP_FEES,"      );
qry.append("        BD.PBATCH_ID,"      );
qry.append("        TO_CHAR(BD.BATCH_DATE,'DD-MON-RRRR') AS BATCH_DATE, "      );
qry.append("        BD.MM_REL_AMT,"      );
qry.append("        TO_CHAR(BD.MM_REL_DT,'DD-MON-RRRR') AS MM_REL_DT, "      );
qry.append("        BD.UTRN_NO,"      );
qry.append("        BD.PAY_STATUS,"      );
qry.append("        BD.FB_ACNO AS MMCLAIM_TRANSACNO,"      );
qry.append("        case when  UPPER(BD.PAY_STATUS) like 'S%' THEN '' ELSE BD.FAIL_REASON END AS FAIL_REASON ,"      );
qry.append("        FGETNEFTIFSCODE_SEC(AD.APP_ID) AS CREENT_NEFT_IFSC,    "      );
qry.append("        BD.MM_CLAIM_AMT - 500      AS PAYBLE_MM,getfinyr(bd.loan_sanc_dt) AS SANC_YR,"      );
qry.append("      BD.IFSC_CODE as NODAL_BANK "      );
qry.append("      FROM BANK_DATAENTRY_SECOND BD,"      );
qry.append("        APP_DETAIL_SECOND AD,"      );
qry.append("        BANK_BR_MAST BBM,"      );
qry.append("        RBIBANKLIST RBL,"      );
qry.append("        M_DISTRICT MD,"      );
qry.append("        M_STATE MS"      );
qry.append("      WHERE AD.APP_ID      = BD.APP_ID"      );
qry.append("      AND AD.UNIT_DIST_CD  = MD.DISTRICT_CD"      );
qry.append("      AND MD.STATE_CD      = MS.STATE_CD"      );
qry.append("      AND BBM.BR_IFSL_CODE = AD.IFSC_CODE"      );
qry.append("      AND BBM.BR_IFSL_CODE = RBL.IFSC_CODE AND BD.PACT_ID=34 "      );
qry.append("     AND UPPER(BBM.spon_bank_name) = UPPER(?)  and bd.fb_acno=? "      );

values.clear();
values.add(vUsrnm);
values.add(APP_ID);	
values.add(vUsrnm);
values.add(APP_ID);


	
 int c=0;
 
ResultSet rs =db.executeSQL(qry.toString(),values);
	   while (rs.next()){
	
	TR_ID=rs.getString("TR_ID")==null?"":rs.getString("TR_ID");
APP_ID=rs.getString("APP_ID")==null?"":rs.getString("APP_ID");
APP_NAME=rs.getString("APP_NAME")==null?"":rs.getString("APP_NAME");
MOB_NO1=rs.getString("MOB_NO1")==null?"":rs.getString("MOB_NO1");
GENDER=rs.getString("GENDER")==null?"":rs.getString("GENDER");
E_MAIL=rs.getString("E_MAIL")==null?"":rs.getString("E_MAIL");
UNIT_LOC=rs.getString("UNIT_LOC")==null?"":rs.getString("UNIT_LOC");
AADHAR_NO=rs.getString("AADHAR_NO")==null?"":rs.getString("AADHAR_NO");
PAN_NO=rs.getString("PAN_NO")==null?"":rs.getString("PAN_NO");
DISTRICT_NAME=rs.getString("DISTRICT_NAME")==null?"":rs.getString("DISTRICT_NAME");
STATE_NM=rs.getString("STATE_NM")==null?"":rs.getString("STATE_NM");
MM_CLAIM_DT=rs.getString("MM_CLAIM_DT")==null?"":rs.getString("MM_CLAIM_DT");
MM_CLAIM_AMT=rs.getString("MM_CLAIM_AMT")==null?"":rs.getString("MM_CLAIM_AMT");
APP_FEES=rs.getString("APP_FEES")==null?"":rs.getString("APP_FEES");
PBATCH_ID=rs.getString("PBATCH_ID")==null?"":rs.getString("PBATCH_ID");
BATCH_DATE=rs.getString("BATCH_DATE")==null?"":rs.getString("BATCH_DATE");
MM_REL_AMT=rs.getString("MM_REL_AMT")==null?"":rs.getString("MM_REL_AMT");
MM_REL_DT=rs.getString("MM_REL_DT")==null?"":rs.getString("MM_REL_DT");
UTRN_NO=rs.getString("UTRN_NO")==null?"":rs.getString("UTRN_NO");
PAY_STATUS=rs.getString("PAY_STATUS")==null?"":rs.getString("PAY_STATUS");
MMCLAIM_TRANSACNO=rs.getString("MMCLAIM_TRANSACNO")==null?"":rs.getString("MMCLAIM_TRANSACNO");
FAIL_REASON=rs.getString("FAIL_REASON")==null?"":rs.getString("FAIL_REASON");
CREENT_NEFT_IFSC=rs.getString("CREENT_NEFT_IFSC")==null?"":rs.getString("CREENT_NEFT_IFSC");
PAYBLE_MM=rs.getString("PAYBLE_MM")==null?"":rs.getString("PAYBLE_MM");
SANC_YR=rs.getString("SANC_YR")==null?"":rs.getString("SANC_YR");
NODAL_BANK=rs.getString("NODAL_BANK")==null?"":rs.getString("NODAL_BANK");
pro_prjcst=rs.getString("pro_prjcst")==null?"":rs.getString("pro_prjcst");
APPLOAN_ACCNO=rs.getString("APPLOAN_ACCNO")==null?"":rs.getString("APPLOAN_ACCNO");
sanc_prjcst=rs.getString("sanc_prjcst")==null?"":rs.getString("sanc_prjcst");
FB_ACNO=rs.getString("FB_ACNO")==null?"":rs.getString("FB_ACNO");

c=c+1;
	   %>
	   <TR>
	     <TD> <DIV align="center"><%= c %></DIV></TD>
		 	  
      <TD> <%=APP_ID %></TD>
      <TD><%= APP_NAME %> </TD>

	    <TD><%= NODAL_BANK %> </TD>
		
		
      <TD><%= APPLOAN_ACCNO %> </TD>
	  <TD> <%=MM_CLAIM_DT %></TD>
      <TD><%= MM_CLAIM_AMT %> </TD>
	  <TD> <%=APP_FEES %></TD>
      <TD><%= PAYBLE_MM %> </TD>     
	  <TD> <%=MM_REL_DT %></TD>
      <TD><%= UTRN_NO %> </TD>
	  <TD> <%=PAY_STATUS %></TD>
      <TD><%= FAIL_REASON %> </TD>
	  </TR>
	  	<%
			}
			
	  rs.close();
			
		db.close();	
			%>
            
	   </TBODY>
  </table>
 <%} else{ %>
  <!-- <div align="center"><H2>ID is invalid/Not Yet Processed by IB</H2></div>-->
  <%}%>
</form>
 
</body>
</html>
