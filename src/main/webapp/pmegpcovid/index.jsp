<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<HTML>
<META name="viewport" content="width=device-width, initial-scale=1">
<HEAD>
<TITLE></TITLE>

<LINK rel="stylesheet" type="text/css" href="css/main1.css">

<SCRIPT src="js/sweetalert.min.js"></SCRIPT>

<SCRIPT>
   function generateCaptcha()
         { var alpha = new Array('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z');
             var i;
             for (i=0;i<4;i++){
               var a = alpha[Math.floor(Math.random() * alpha.length)];
               var b = alpha[Math.floor(Math.random() * alpha.length)];
               var c = alpha[Math.floor(Math.random() * alpha.length)];
               var d = alpha[Math.floor(Math.random() * alpha.length)];
              }
            var code = a + '' + b + '' + '' + c + '' + d;
            document.getElementById("mainCaptcha").value = code
          }
		  
function submitform1() {
var APP_NAME = document.form.APP_NAME.value;
var UNIT_NAME = document.form.UNIT_NAME.value;
var MOB_NO = document.form.MOB_NO.value;
var E_MAIL = document.form.E_MAIL.value;
var APP_POST_ADDR = document.form.APP_POST_ADDR.value;
var STATE_CD = document.form.STATE_CD.value;
var PINCODE = document.form.PINCODE.value;
var checkbox = document.form.checkbox.value;
var emailRegex = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/;

if(APP_NAME==""){
 swal ( 'Note:','Please Enter PMEGP Beneficiary Name.','error');	
 return (false);
}

if(UNIT_NAME==""){
 swal ( 'Note:','Please Enter Unit Name.','error');	
 return (false);
}

if(MOB_NO==""){
 swal ( 'Note:','Please Enter Mobile No.','error');	
 return (false);
}

if(MOB_NO.length !=10)
{
  swal('Note:','Enter 10 digit Mobile Number.','error');
        return false;
  }

if(E_MAIL==""){
 swal ( 'Note:','Please Enter Email Id','error');	
 return (false);
}

  if(!E_MAIL.match(emailRegex) && !E_MAIL == "") {
 swal ( 'Note:','Invalid Email. Please Enter Valid Email Id','error');	
    return false;
  }
  
if(APP_POST_ADDR==""){
 swal ( 'Note:','Please Enter Applicant Post Address','error');	
 return (false);
}

if(STATE_CD==""){
 swal ( 'Note:','Please Select State Name','error');	
 return (false);
}

if(PINCODE==""){
 swal ( 'Note:','Please Enter Pincode','error');	
 return (false);
}

//if(checkbox==""){
// swal ( 'Note:','Please agreeeeee','error');	
// return (false);
//}


              var string1 = removeSpaces(document.getElementById('mainCaptcha').value);
              var string2 = removeSpaces(document.getElementById('txtInput').value);
              if (!(string1 == string2)){
        // document.getElementById('success').innerHTML = "Form is validated Successfully";
         //alert("Form is validated Successfully");
            //    return true;
           //   }
          //    else{       
        
		swal ( 'Note:','Invalid Captcha. Please enter valid captcha.','error');	
		// document.getElementById('error').innerHTML = "Please enter a valid captcha."; 
         //alert("Please enter a valid captcha.");
                return false;
         
              }
			  
if(!this.form.checkbox.checked)
{
swal ( 'Note:','Please check on the checkbox','error');	
return (false);
}			  
								
document.form.ins.value='I';
document.form.submit();
}

 function removeSpaces(string){
            return string.split(' ').join('');
          }
		  
		  

function isNumberNoDec(evt)
      {
         var BNF_ASTFFCNTCT = (evt.which) ? evt.which : event.keyCode
		 var BNF_NOOFPARTCPNTS = (evt.which) ? evt.which : event.keyCode
	//	 var BNF_ATA = (evt.which) ? evt.which : event.keyCode
		 if (BNF_ASTFFCNTCT > 31 && (BNF_ASTFFCNTCT < 48 || BNF_ASTFFCNTCT > 57))
		 if (BNF_NOOFPARTCPNTS > 31 && (BNF_NOOFPARTCPNTS < 48 || BNF_NOOFPARTCPNTS > 57))
	//	 if (BNF_ATA > 31 && (BNF_ATA < 48 || BNF_ATA > 57))
		 return false;
         return true;
      }		
		
</SCRIPT>

<STYLE>
input[type="checkbox"][readonly]{
pointer-events: none;
}
input[id="mainCaptcha"]
{
    font-size:24px;
	font-family:"Lucida Sans Typewriter"
	text-align: center;
	
}

.boxed{
border:1px solid green;
padding:5px;
background-color:#def0d8;
width:90%;
font-family:"Times New Roman", Times, serif;
font-size:20px;
color:green;

}
.style2 {font-family: "Times New Roman", Times, serif; font-weight: bold; font-size: 36px;}
</STYLE>

</HEAD>

<BODY  onload="generateCaptcha();">

<FORM  name="form" id="form" method="post" >
  <P><IMG src="images/04_01.png" width="100%" alt="img">  </P>
   <DIV align="center" class="style2">KVIC COVID19 DONATION FORM</DIV><BR>

   <DIV align="center"><A href="#" class="myButtonap">Download Appeal </A> </DIV><BR>
   <CENTER>
   <DIV class="boxed">
  <P align="left">Khadi and Village Industries Commission (KVIC), Ministry of MSME, Government of India accepts voluntary donation of Rs.500 (Rupees five hundred only) from PMEGP/REGP beneficiaries to COVID-19 Donation Fund.</P>
   </DIV><BR>
   <DIV class="boxed">
  <P align="left">It is to inform that KVIC does not collect any money through SMS/Missed Call services or though any such service provider. It is advised that any such Calls/Messages should not be entertained.</P>
   </DIV><BR>
    <DIV class="boxed">
  <P align="left">Doners are carefully verify and satisfy the web site address of https://www.kviconline.gov.in/pmegpeportal or https://www.kvic.gov.in before proceeding for payment. Donors making donation though this portal are advised not to make repeated transactions. If any amount has been debited from the account but the message appears as &quot;Transaction failure/pending confirmation from bank&quot; at the end of the process. </P>
   </DIV>
   </CENTER>
  <P align="center"><EM><STRONG>For any query please feel free to write to covid19.kvic@gov.in</STRONG></EM> <BR>
    <BR> 
  
 
    
    <%

List values=new ArrayList();

String COVDONID="";
String APP_ID="";
String APP_PRIX="";
String APP_NAME="";
String UNIT_NAME="";
String MOB_NO="";
String E_MAIL="";
String APP_POST_ADDR="";
String PINCODE="";
String STATE_CD="";
String BEN_TP="";
String OT_PMEGP="";

String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");

DBCon db= new DBCon();
db.connect();

%>
    <INPUT name="ins" type="hidden" id="ins" >
    
    <%

if (ins.equals("I")) {

COVDONID=(String) request.getParameter("COVDONID")==null?"":(String) request.getParameter("COVDONID").trim();
APP_ID=(String) request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID").trim();
APP_PRIX=(String) request.getParameter("APP_PRIX")==null?"":(String) request.getParameter("APP_PRIX").trim();
APP_NAME=(String) request.getParameter("APP_NAME")==null?"":(String) request.getParameter("APP_NAME").trim();
UNIT_NAME=(String) request.getParameter("UNIT_NAME")==null?"":(String) request.getParameter("UNIT_NAME").trim();
MOB_NO=(String) request.getParameter("MOB_NO")==null?"":(String) request.getParameter("MOB_NO").trim();
E_MAIL=(String) request.getParameter("E_MAIL")==null?"":(String) request.getParameter("E_MAIL").trim();
APP_POST_ADDR=(String) request.getParameter("APP_POST_ADDR")==null?"":(String) request.getParameter("APP_POST_ADDR").trim();
PINCODE=(String) request.getParameter("PINCODE")==null?"":(String) request.getParameter("PINCODE").trim();
STATE_CD=(String) request.getParameter("STATE_CD")==null?"":(String) request.getParameter("STATE_CD").trim();
BEN_TP=(String) request.getParameter("BEN_TP")==null?"":(String) request.getParameter("BEN_TP").trim();
OT_PMEGP=(String) request.getParameter("OT_PMEGP")==null?"":(String) request.getParameter("OT_PMEGP").trim();

List pstm=new ArrayList();
StringBuffer qryUpdate = new StringBuffer();
values.clear();
pstm.clear();
	
		
String maxId="SELECT NVL(MAX(COVDONID),0)+1 AS COVDONID FROM ACOVID_DONATION_TRANS" ;
ResultSet rsMax=db.execSQL(maxId);
while (rsMax.next()){
COVDONID=rsMax.getString("COVDONID")==null?"":rsMax.getString("COVDONID");
}

rsMax.close();

qryUpdate.append("INSERT INTO ACOVID_DONATION_TRANS ( ");

qryUpdate.append("COVDONID,");
qryUpdate.append("APP_ID,");
qryUpdate.append("APP_PRIX,");
qryUpdate.append("APP_NAME,");
qryUpdate.append("UNIT_NAME,");
qryUpdate.append("MOB_NO,");
qryUpdate.append("E_MAIL,");
qryUpdate.append("APP_POST_ADDR,");
qryUpdate.append("PINCODE,");
qryUpdate.append("STATE_CD,");
qryUpdate.append("BEN_TP,");
qryUpdate.append("OT_PMEGP");

qryUpdate.append(" ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)");

values.add(COVDONID); pstm.add ("L");
values.add(APP_ID); pstm.add ("L");
values.add(APP_PRIX); pstm.add ("L");
values.add(APP_NAME); pstm.add ("L");
values.add(UNIT_NAME); pstm.add ("L");
values.add(MOB_NO); pstm.add ("L");
values.add(E_MAIL); pstm.add ("L");
values.add(APP_POST_ADDR); pstm.add ("L");
values.add(PINCODE); pstm.add ("L");
values.add(STATE_CD); pstm.add ("L");
values.add(BEN_TP); pstm.add ("L");
values.add(OT_PMEGP); pstm.add ("L");


db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate();
%>




<jsp:forward page="pay.jsp" >
    <jsp:param name="COVDONID" value="<%= COVDONID %>"/>
</jsp:forward>
<%
//response.sendRedirect("pay.jsp");

}

%>
  </P>
  <CENTER>

<TABLE border="1" id="customers" width="80%">
  <TR>
    <TH colspan="4"><DIV align="center">KVIC COVID19 DONATION FORM (Personal Detail) </DIV></TH>
  </TR>
  
  <TR>
    <TH colspan="4"><DIV align="center">Note: In case of any error during transaction. Please wait for 72 hours before initiating a new transaction. </DIV></TH>
  </TR>
  <TR>
    <TD colspan="4"><DIV align="center">
      <INPUT name="BEN_TP" type="hidden" id="BEN_TP" value="PMEGP"  autocomplete="off"  maxlength="4">
      <INPUT name="APP_PRIX" type="hidden" id="APP_PRIX" value="-"  autocomplete="off"  maxlength="4">
      All (*) marked fields are mandatory </DIV></TD>
    </TR>
  
  <TR>
    <TD><DIV align="center">(1)</DIV></TD>
    <TD> Beneficiary Name * </TD>
    <TD colspan="2"><INPUT name="APP_NAME" type="text" id="APP_NAME" value="<%= APP_NAME%>"  autocomplete="off" PLACEHOLDER="PMEGP Beneficiary Name" maxlength="50"></TD>
    </TR>
  
  <TR>
    <TD><DIV align="center">(2)</DIV></TD>
    <TD>Applicant ID (if any) </TD>
    <TD colspan="2"><INPUT name="APP_ID" type="text" id="APP_ID" value="<%= APP_ID%>"  AUTOCOMPLETE="off" PLACEHOLDER="Applicant ID" maxlength="20"></TD>
    </TR>
  
  <TR>
    <TD><DIV align="center">(3)</DIV></TD>
    <TD>Unit Name * </TD>
    <TD colspan="2"><INPUT name="UNIT_NAME" type="text" id="UNIT_NAME" value="<%= UNIT_NAME%>"  autocomplete="off" PLACEHOLDER="Unit Name" maxlength="100"></TD>
    </TR>
  <TR>
    <TD><DIV align="center">(4)</DIV></TD>
    <TD>Mobile No * </TD>
    <TD colspan="2"><INPUT name="MOB_NO" type="text" id="MOB_NO" value="<%= MOB_NO%>" onKeyPress="return isNumberNoDec(event)"  autocomplete="off" PLACEHOLDER="Mobile No" maxlength="10"></TD>
    </TR>
  <TR>
    <TD><DIV align="center">(5)</DIV></TD>
    <TD>Email Id * </TD>
    <TD colspan="2"><INPUT name="E_MAIL" type="text" id="E_MAIL" value="<%= E_MAIL%>"  autocomplete="off" PLACEHOLDER="Email Id" maxlength="60"></TD>
  </TR>
  <TR>
    <TD><DIV align="center">(6)</DIV></TD>
    <TD>Address * </TD>
    <TD colspan="2"><INPUT name="APP_POST_ADDR" type="text" id="APP_POST_ADDR" value="<%= APP_POST_ADDR%>"  autocomplete="off" PLACEHOLDER="Address" maxlength="300"></TD>
  </TR>
  <TR>
    <TD><DIV align="center">(7)</DIV></TD>
    <TD>State Name * </TD>
    <TD colspan="2"><SELECT name="STATE_CD" id="STATE_CD" >
      <OPTION value="">----Select----</OPTION>
      <%
	String STATE_CD_D1="";
	String STATE_NM_D1="";
	ResultSet staters1 =db.execSQL("SELECT STAT.STATE_CD,STAT.STATE_NM FROM MAS.M_STATE STAT");
	while (staters1.next()) {
STATE_CD_D1=staters1.getString(1);
STATE_NM_D1=staters1.getString(2);
	%>
      <OPTION value="<%= STATE_CD_D1 %>" ><%= STATE_NM_D1 %></OPTION>
      <%  }  staters1.close();//while close  
	   %>
    </SELECT></TD>
    </TR>
  <TR>
    <TD><DIV align="center">(8)</DIV></TD>
    <TD>Pincode * </TD>
    <TD colspan="2"><INPUT name="PINCODE" type="text" id="PINCODE" value="<%= PINCODE%>" onKeyPress="return isNumberNoDec(event)"  autocomplete="off" PLACEHOLDER="Pincode" maxlength="6"></TD>
    </TR>
  <TR>
    <TD><DIV align="center">(9)</DIV></TD>
    <TD>Amount</TD>
    <TD colspan="2">Rs.500 (Rupees Five Hundered only) </TD>
  </TR>

  <TR>
    <TD rowspan="2"><DIV align="center">(10)</DIV></TD>
    <TD rowspan="2">Captcha*</TD>
    <TD colspan="2"><INPUT name="text2" type="text" id="mainCaptcha" size="30" maxlength="30"readonly="readonly"/>
      <INPUT name="button" class="myButtonr" type="button" id="refresh" onClick="generateCaptcha();" value="Refresh Captcha" /></TD>
  </TR>
  <TR>
    <TD colspan="2"><INPUT name="text" type="text" id="txtInput" PLACEHOLDER="Enter Captcha"/ size="10" AUTOCOMPLETE="off"></TD>
  </TR>
  
  

  <TR>
    <TD><DIV align="center">(11)</DIV></TD>
    <TD colspan="3"><INPUT type="checkbox" name="checkbox" value="check" id="checkbox" >
I note that this donation will not provide any Tax exemption. I agreed to donate Rs.500 ( Rupees Five Hundered Only) For 'KVIC COVID-19 FUND'.</TD>
    </TR>
  <TR>
    <TD colspan="4"> <DIV align="center"><INPUT type="reset" class="myButtonred" value="Decline">    <A onClick="submitform1();" class="myButton">Proceed For Payment</A></DIV></TD>
    </TR>
  </TABLE>


</CENTER>

<%
	   db.close();
%>
</FORM>
 
</BODY>
</HTML>
