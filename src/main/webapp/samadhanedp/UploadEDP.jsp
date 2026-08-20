<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.io.*"%> 
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="javazoom.upload.*"%>
<%@ page import="pkgPmegpNew.DBCon"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<HTML>
<%! 

public static String getExtension(String s) {
    String ext = null;
    int i = s.lastIndexOf('.');
    if (i > 0 &&  i < s.length() - 1) {
        ext = s.substring(i+1).toLowerCase();
    }
    return ext;
}

 %>
<head>
	<title>SAMADHAN ONLINE EDP TRAINING</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
	<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="css/style.css">
	<link rel="stylesheet" type="text/css" href="css/responsive.css">
    <style type="text/css">
<!--


.readonlytext11 {border: 0;
  box-shadow: none;
  background-color:#CCCCCC;
}

 table {
  border-collapse: collapse;
  border-spacing:0; 
  width:auto;
  border: 1px solid #ddd;
  }

th, td {
  text-align: left;
  padding: 1px;
}


.readonlytext {
 border: 0;
  box-shadow: none;
  background-color:#CCCCCC;
}

input[type=text] {
  width: 30%;
  padding: 1px 5px;
  margin: 1px 0;
  box-sizing: border-box;
  border: 2px solid black;
  border-radius: 1px;
}
input[type=text1] {
  width: 60%;
  padding: 5px 5px;
  margin: 1px 0;
  box-sizing: border-box;
  border: 1px solid black;
  border-radius: 1px;
}



}
.style1 {font-weight: bold}
</style>

</head>
<script type="text/javascript" src="js/datetimepicker_css.js"></script>
<script>

function newfun(){
 
var EDPARRPAY=document.getElementById('EDPARRPAY').value;
var FIVEDAYTRGINVNO=document.getElementById('FIVEDAYTRGINVNO').value;
var TENDAYTRGINVNO=document.getElementById('TENDAYTRGINVNO').value;
var FIVEDAYTRGINVNO_OLD=document.getElementById('FIVEDAYTRGINVNO_OLD').value;
var TENDAYTRGINVNO_OLD=document.getElementById('TENDAYTRGINVNO_OLD').value;
var edp_no=document.getElementById('edp_no').value;


var myResult4=Number(FIVEDAYTRGINVNO)*1650; 
document.getElementById("FIVEDAYTRGINVAMT").value=myResult4.toFixed(0);

var myResult5=Number(TENDAYTRGINVNO)*3300;;
document.getElementById("TENDAYTRGINVAMT").value=myResult5.toFixed(0);

var myResult41=Number(FIVEDAYTRGINVNO_OLD)*1500; 
document.getElementById("FIVEDAYTRGINVAMT_OLD").value=myResult41.toFixed(0);

var myResult51=Number(TENDAYTRGINVNO_OLD)*3000;;
document.getElementById("TENDAYTRGINVAMT_OLD").value=myResult51.toFixed(0);

var myResult6=Number(myResult4)+Number(myResult5)+Number(EDPARRPAY)+Number(myResult41)+Number(myResult51);
document.getElementById("total_inv_amt").value=myResult6.toFixed(0);

var myResult2= myResult6*18/100;
document.getElementById("gst_amt").value=myResult2.toFixed(0);

var myResult3=Number(myResult6)+Number(myResult2);
document.getElementById("total_amt").value=myResult3.toFixed(0);

}


</script>




<script language="javascript"> 

function submitform() {

fileName = document.querySelector('#uploadfile').value;
extension = fileName.substring(fileName.lastIndexOf('.') + 1); 

var edp_no=document.getElementById('edp_no').value;
var FIVEDAYTRGINVNO=document.getElementById('FIVEDAYTRGINVNO').value;
var TENDAYTRGINVNO=document.getElementById('TENDAYTRGINVNO').value;
var FIVEDAYTRGINVNO_OLD=document.getElementById('FIVEDAYTRGINVNO_OLD').value;
var TENDAYTRGINVNO_OLD=document.getElementById('TENDAYTRGINVNO_OLD').value;
var myResult7=Number(FIVEDAYTRGINVNO)+Number(TENDAYTRGINVNO)+Number(FIVEDAYTRGINVNO_OLD)+Number(TENDAYTRGINVNO_OLD); 
var inv_no = form.inv_no.value; 
var inv_date = form.inv_date.value;
//var edp_no = form.edp_no.value; 

var total_inv_amt = form.total_inv_amt.value;  



var vuploadfile= form.uploadfile.value; 


 if ( Number(FIVEDAYTRGINVNO) + Number(TENDAYTRGINVNO)+Number(FIVEDAYTRGINVNO_OLD)+Number(TENDAYTRGINVNO_OLD)==0)   {	 alert ( 'Enter 5 Days/ 10 Days No of EDP Trainees !',2);	return (false);}

 if (myResult7!=edp_no)   {	 alert ( 'Mismatch EDP No ',2);	return (false);} 


  if (vuploadfile == "")   {	 alert ( 'please upload Invoice in PDF ',2);	return (false);} 
  
   if (!(extension.toUpperCase() == "PDF"))   {	 alert ( 'uploaded Invoice is Not a pdf file',2);	return (false);} 
   
   try {
   if (extension.toUpperCase() == "PDF") {
    const fi = document.getElementById('uploadfile');
   if (fi.files.length > 0) {
            for (const i = 0; i <= fi.files.length - 1; i++) {
  
                const fsize = fi.files.item(i).size;
                const file = Math.round((fsize / 1024));
                // The size of the file.
                if (file >= 1024) {
                    alert(" file size is large, Maximum size should be 1 MB");
                      
					  return(false);
                }
            }
        }    
		}// end  
		
		} catch(err) {
 // document.getElementById("demo").innerHTML = err.message;
}
  
  
  


  if (inv_date == "")   {	 alert ( 'please enter Invoice  date ',2);	return (false);} 
  if (inv_no == "")  {	 alert ( 'please enter Invoice No',2);	return (false);}
  if (total_inv_amt == "") {	 alert ( 'please enter Invoice Amount',2);	return (false);}
	
	 
	

//alert("data save");
document.form.ins.value='I';
document.form.submit(); 

}
</script>







</head>
<body>
<form method="post"  name="form" id="form" class="form" enctype="multipart/form-data" >

<jsp:useBean id="upBean" scope="page" class="javazoom.upload.UploadBean" >
  <jsp:setProperty name="upBean" property="filesizelimit" value="1000000" />
   <jsp:setProperty name="upBean" property="folderstore" value="/opt/tomcat5/webapps/pmegpeportal/samadhanedp/otherdocu" />
	
	  <%--<jsp:setProperty name="upBean" property="folderstore" value="E:\\tomcat5\\webapps\\chairmandashboard" />--%>
  <jsp:setProperty name="upBean" property="overwrite" value="false" />
  <jsp:setProperty name="upBean" property="whitelist" value="*.pdf" />
</jsp:useBean>
<%
List values=new ArrayList(); 

//String off_cd="5714";
String off_cd=request.getParameter("off_cd")==null?"0":(String)request.getParameter("off_cd");
String month_dt=session.getAttribute("sInvDt")==null?"":(String) session.getAttribute("sInvDt");
//String month_dt="30-APR-2023";
String edp_no=request.getParameter("no_ofapp")==null?"0":(String)request.getParameter("no_ofapp");
String EDPARR_REM="";
String state ="";
//String edp_no="10";
String off_name1 ="";
String invupid =request.getParameter("invupid")==null?"0":(String)request.getParameter("invupid");
//String invupid="564";
String total_inv_amt="";
String gst_amt="";
String updoc_edp="";
String total_amt="";
String TOTAL_AMT="";
String UPDOC_EDP ="";
String err="";
String inv_no="";
String inv_date="";
String FIVEDAYTRGINVNO="";
String TENDAYTRGINVNO="";
String FIVEDAYTRGINVAMT="";
String TENDAYTRGINVAMT="";
String EDPARRPAY="";
String FIVEDAYTRGINVNO_OLD="";
String TENDAYTRGINVNO_OLD="";
String FIVEDAYTRGINVAMT_OLD="";
String TENDAYTRGINVAMT_OLD="";


String add_update="I";
String ins=request.getParameter("ins")==null?"I":(String) request.getParameter("ins");



 DBCon db= new DBCon();
      db.connect(); 

if(!off_cd.equals("")){

StringBuffer qrysb = new StringBuffer();


 

qrysb.append(" SELECT mq.state,"   );
qrysb.append(" mq.OFF_NAME1,"   );
qrysb.append(" mq.OFF_CD,"    );
qrysb.append(" sq.INVUPID,"      );
qrysb.append(" sq.UPDOC_EDP,"      );
qrysb.append(" sq.TOTAL_AMT,"      );
qrysb.append(" sq.TOTAL_INV_AMT,"      );
qrysb.append("  sq.month_dt,"      );
qrysb.append("  sq.GST_AMT,"      );
qrysb.append(" NVL(sq.edp_no,"+edp_no+") AS EDP_NO, "      );
qrysb.append("  sq.INV_NO, "      );
qrysb.append(" sq.inv_date, "      );
qrysb.append("  sq.FIVEDAYTRGINVNO,"      );
qrysb.append(" sq.TENDAYTRGINVNO,"      );
qrysb.append("  sq.FIVEDAYTRGINVAMT,"      );
qrysb.append("  sq.EDPARRPAY,"      );
qrysb.append("  sq.EDPARR_REM,"      );
qrysb.append("  sq.TENDAYTRGINVAMT,"      );
qrysb.append("  sq.TENDAYTRGINVAMT_OLD,"      );
qrysb.append("  sq.FIVEDAYTRGINVAMT_OLD,"      );
qrysb.append("  sq.TENDAYTRGINVNO_OLD,"      );
qrysb.append(" sq.FIVEDAYTRGINVNO_OLD"      );
qrysb.append(" FROM"      );
qrysb.append(" (SELECT ms.STATE_NM AS   state ,"      );
qrysb.append("  mom.OFF_NAME1,"      );
qrysb.append("  mom.OFF_CD"      );
qrysb.append(" FROM mas_off_mast mom,"      );
qrysb.append(" m_district md, "      );
qrysb.append(" m_state ms "      );
qrysb.append(" WHERE mom.DISTRICT_CD = md.DISTRICT_CD"       );
qrysb.append(" AND md.STATE_CD       = ms.STATE_CD "      );
qrysb.append("  AND mom.OFF_CD        = ? "      );
qrysb.append("  ) mq, "      );
qrysb.append(" (SELECT boi.OFF_CD, "      );
qrysb.append("  boi.INVUPID, "      );
qrysb.append("   boi.UPDOC_EDP, "      );
qrysb.append("   boi.TOTAL_AMT, "      );
qrysb.append("  boi.TOTAL_INV_AMT, "      );
qrysb.append("  TO_CHAR(boi.MONTH_DT, 'DD-MON-RRRR') AS month_dt, "      );
qrysb.append("  boi.GST_AMT, "      );
qrysb.append("   NVL(boi.EDP_NO,"+edp_no+") AS edp_no, "   );
qrysb.append(" boi.INV_NO, "      );
qrysb.append("  TO_CHAR(boi.INV_DATE, 'DD-MON-RRRR')   AS inv_date, "      );
qrysb.append("  TO_CHAR(boi.FORWARD_DT, 'DD-MON-RRRR') AS FORWARD_DT, "      );
qrysb.append("  boi.FIVEDAYTRGINVNO, "      );
qrysb.append("   boi.TENDAYTRGINVNO, "      );
qrysb.append("    boi.FIVEDAYTRGINVAMT, "      );
qrysb.append(" boi.EDPARRPAY, "      );
qrysb.append(" boi.EDPARR_REM,"      );
qrysb.append("  boi.TENDAYTRGINVAMT,"      );
qrysb.append(" boi.FIVEDAYTRGINVNO_OLD,"      );
qrysb.append("  boi.TENDAYTRGINVNO_OLD,"      );
qrysb.append("  boi.FIVEDAYTRGINVAMT_OLD, "      );
qrysb.append("  boi.TENDAYTRGINVAMT_OLD "      );
qrysb.append(" FROM bnf_onlineedp_inf boi "      );
qrysb.append(" WHERE NVL(boi.INVUPID, 0) = ? "      );
qrysb.append("  ) sq "      );
qrysb.append(" WHERE mq.OFF_CD = sq.OFF_CD(+) "      );

values.add(off_cd);
values.add(invupid);

//out.print (qrysb.toString());


ResultSet rsMain = db.executeSQL(qrysb.toString(),values);

while (rsMain.next()){
//off_name1=rsMain.getString("off_name1")==null?"0":rsMain.getString("off_name1");
invupid=rsMain.getString("invupid")==null?"0":rsMain.getString("invupid");
updoc_edp=rsMain.getString("updoc_edp")==null?"":rsMain.getString("updoc_edp");
total_amt=rsMain.getString("total_amt")==null?"":rsMain.getString("total_amt");
total_inv_amt=rsMain.getString("total_inv_amt")==null?"":rsMain.getString("total_inv_amt");
//month_dt=rsMain.getString("month_dt")==null?dt:rsMain.getString("month_dt");
state=rsMain.getString("state")==null?"":rsMain.getString("state");
off_name1=rsMain.getString("off_name1")==null?"":rsMain.getString("off_name1");
gst_amt=rsMain.getString("gst_amt")==null?"":rsMain.getString("gst_amt");
inv_no=rsMain.getString("inv_no")==null?"":rsMain.getString("inv_no");
inv_date=rsMain.getString("inv_date")==null?"":rsMain.getString("inv_date");
edp_no=rsMain.getString("edp_no")==null?"":rsMain.getString("edp_no");
FIVEDAYTRGINVNO=rsMain.getString("FIVEDAYTRGINVNO")==null?"":rsMain.getString("FIVEDAYTRGINVNO");
TENDAYTRGINVNO=rsMain.getString("TENDAYTRGINVNO")==null?"":rsMain.getString("TENDAYTRGINVNO");
FIVEDAYTRGINVAMT=rsMain.getString("FIVEDAYTRGINVAMT")==null?"":rsMain.getString("FIVEDAYTRGINVAMT");
TENDAYTRGINVAMT=rsMain.getString("TENDAYTRGINVAMT")==null?"":rsMain.getString("TENDAYTRGINVAMT");
EDPARRPAY=rsMain.getString("EDPARRPAY")==null?"":rsMain.getString("EDPARRPAY");
EDPARR_REM=rsMain.getString("EDPARR_REM")==null?"":rsMain.getString("EDPARR_REM");
FIVEDAYTRGINVNO_OLD=rsMain.getString("FIVEDAYTRGINVNO_OLD")==null?"":rsMain.getString("FIVEDAYTRGINVNO_OLD");
TENDAYTRGINVNO_OLD=rsMain.getString("TENDAYTRGINVNO_OLD")==null?"":rsMain.getString("TENDAYTRGINVNO_OLD");
FIVEDAYTRGINVAMT_OLD=rsMain.getString("FIVEDAYTRGINVAMT_OLD")==null?"":rsMain.getString("FIVEDAYTRGINVAMT_OLD");
TENDAYTRGINVAMT_OLD=rsMain.getString("TENDAYTRGINVAMT_OLD")==null?"":rsMain.getString("TENDAYTRGINVAMT_OLD");

if (!invupid.equals("0")) {
add_update="U";
}

}
rsMain.close();

}

%> 
<body>  

<table align="center" border="1" id="cont">
				 
<tr>
  <td colspan="4" class="style1" align="center"><div align="center">Online EDP Upload Invoice Form </div></td>
  </tr>
<tr align="left">
  <td class="style1">Office Name:
  <input name="ins" type="hidden" id="ins" value="<%=ins %>"></td>
  <td class="style1"><%=off_name1%></td>
  <td class="style1">State:</td>
  <td class="style1"><%=state%></td>
</tr>
<tr align="left">
  <td class="style1">Month:
   </td>
  <td class="style1"><%=month_dt%> </td>
  <td><strong><strong>Training</strong> Completed </strong></td>
  <td class="style1"><%=edp_no%></td> 
</tr>
</table>

<table  cellpadding="1" cellspacing="1"  id="cont1"  align="center">
  
  <tr>
    <td align="center">&nbsp;</td>
    <td colspan="3">Invoice Should be in pdf file and Maximum size 1 mb. </td>
    </tr> 
  <tr> 
    <td align="center"><strong>(1)</strong></td>
    <td><strong>Invoice Date:</strong></td>
    <td colspan="2"><input name="inv_date" type="text" id="inv_date" onClick="javascript:NewCssCal('inv_date','ddMMMyyyy')" value="<%=inv_date%>" placeholder="enter Invoice Date">  <input type="hidden" id="month_dt" name="month_dt" value="<%=month_dt%>" readonly="true">  </td>
    </tr>
  <tr>
    <td align="center"><strong>(2)</strong></td>
    <td><strong>Invoice No:</strong></td>
    <td colspan="2"><input  name="inv_no" type="text" id="inv_no"  value="<%=inv_no%>" maxlength="20" required /></td>
    </tr>
	
   
  <tr>
    <td align="center"><strong>(3)</strong></td>
    <td>NEW RATE </td> 
    <td>No of Trainees </td> 
    <td>EDP Fees Amount</td>
  </tr>
  <tr>
    <td align="center">&nbsp;</td>
    <td><div align="right">5 Days Training @Rs. 1650  </div></td>
    <td><input type="text" id="FIVEDAYTRGINVNO" name="FIVEDAYTRGINVNO" value="<%=FIVEDAYTRGINVNO%>" onChange="newfun();" class="form-text" maxlength="5"></td>
    <td><input name="FIVEDAYTRGINVAMT" type="text1" class="readonlytext"  id="FIVEDAYTRGINVAMT"  onChange="newfun();"  value="<%=FIVEDAYTRGINVAMT%>" maxlength="12" readonly="true"></td>
  </tr> 
  <tr>
    <td align="center">&nbsp;</td>
    <td><div align="right">10  Days Training @ Rs. 3300  </div></td>
    <td><input  name="TENDAYTRGINVNO" type="text" id="TENDAYTRGINVNO"  onchange="newfun();" value="<%=TENDAYTRGINVNO%>"  class="form-text" maxlength="5"></td>

	<td><input name="TENDAYTRGINVAMT" type="text1" class="readonlytext"  id="TENDAYTRGINVAMT" onChange="newfun();"  value="<%=TENDAYTRGINVAMT%>" maxlength="12" readonly="true"></td>
  </tr>
  <tr>
    <td align="center"><strong>(4)</strong></td>
    <td>OLD RATE </td> 
    <td>No of Trainees </td> 
    <td>EDP Fees Amount</td>
  </tr>
  <tr>
    <td align="center">&nbsp;</td>
    <td><div align="right">5 Days Training @Rs. 1500 </div></td>
    <td><input type="text" id="FIVEDAYTRGINVNO_OLD" name="FIVEDAYTRGINVNO_OLD" value="<%=FIVEDAYTRGINVNO_OLD%>" onChange="newfun();" class="form-text" maxlength="5"></td>
    <td><input name="FIVEDAYTRGINVAMT_OLD" type="text1" class="readonlytext"  id="FIVEDAYTRGINVAMT_OLD"  onChange="newfun();"  value="<%=FIVEDAYTRGINVAMT_OLD%>" maxlength="12" readonly="true"></td>
  </tr> 
  <tr>
    <td align="center">&nbsp;</td>
    <td><div align="right">10  Days Training @ Rs. 3000  </div></td>
    <td><input  name="TENDAYTRGINVNO_OLD" type="text" id="TENDAYTRGINVNO_OLD" class="form-text" onChange="newfun();" value="<%=TENDAYTRGINVNO_OLD%>" maxlength="5"></td>

	<td><input name="TENDAYTRGINVAMT_OLD" type="text1" class="readonlytext"  id="TENDAYTRGINVAMT_OLD" onChange="newfun();"  value="<%=TENDAYTRGINVAMT_OLD%>" maxlength="12" readonly="true"></td>

  </tr>
  
  <tr>
    <td align="center"><strong>(5)</strong></td>
    <td><div align="right">EDP Arrear Remark (If Any) </div></td> 
    <td colspan="2"><input name="EDPARR_REM" type="text1" id="EDPARR_REM" value="<%=EDPARR_REM%>" maxlength="200"></td>
    </tr> 
  <tr> 
    <td align="center">&nbsp;</td> 
    <td><div align="right">Any Arrear Amount </div></td>   
    <td></td>
    <td><input type="text" id="EDPARRPAY" name="EDPARRPAY" value="<%=EDPARRPAY%>"  onChange="newfun();"></td>
  </tr>  
  <tr> 
    <td align="center">&nbsp;</td> 
    <td><div align="right">Total EDP  </div></td>
  <td>
 <input type="text" id="edp_no" name="edp_no" value="<%=edp_no%>" class="readonlytext11" onChange="newfun();"  readonly="true"></td>
    <td><input type="text1"  name="total_inv_amt" id="total_inv_amt"  onChange="newfun();" value="<%=total_inv_amt%>"  class="readonlytext"  readonly="true"></td>
  </tr>
  
  <tr> 
    <td align="center">&nbsp;</td> 
    <td><strong>GST@18%*:</strong></td>
    <td colspan="2"><input  type="text"  name="gst_amt" id="gst_amt" value="<%=gst_amt%>"  onChange="newfun();"  readonly="true" class="readonlytext" /></td>
    </tr>
  <tr>
    <td align="center">&nbsp;</td>
    <td><strong>Total EDP Fees with GST:</strong></td>
    <td colspan="2"><input  type="text"  name="total_amt"  id="total_amt" value="<%=total_amt%>" readonly="true"  onChange="newfun();"  class="readonlytext"/></td>
    </tr>
  <tr>
    <td align="center">&nbsp;</td>
    <td><input name="updoc_edp" type="hidden" id="updoc_edp" value="<%=updoc_edp %>">
        <input name="todo" type="hidden" value="upload"/>
        <strong>Upload Invoice</strong>: </td>
    <td colspan="2"><input name="uploadfile" type="file" id="uploadfile"  value="<%=updoc_edp%>" class="show" ></td>
  </tr> 
  <br>
  <tr>
    <td colspan="4" class="style1" align="center"><div align="center">
      <input name="button" type="button" class="login100-form-btn"  onClick="submitform();" value="Upload Invoice" />    
    </div></td>
  </tr>
</table>
<%



  StringBuffer qryUpdate = new StringBuffer();
 
 values.clear();
      if (MultipartFormDataRequest.isMultipartFormData(request))
      {
         MultipartFormDataRequest mrequest = new MultipartFormDataRequest(request);
         String todo = null;
         if (mrequest != null) todo = mrequest.getParameter("todo");
		// DOC_REMARKS=mrequest.getParameter("DOC_REMARKS")==null?"":mrequest.getParameter("DOC_REMARKS");
	     if ( (todo != null) && (todo.equalsIgnoreCase("upload")) )
	     {
                Hashtable files = mrequest.getFiles();
							
                if ( (files != null) && (!files.isEmpty()))
                {
                    UploadFile file = (UploadFile) files.get("uploadfile");
				
					 upBean.store(mrequest, "uploadfile");
						
						Date dNow = new Date();
						SimpleDateFormat ft = new SimpleDateFormat("yyMMddhhmmssMs");
						String rnddt = ft.format(dNow);
						
						String ext="";
						try{
						ext=getExtension(file.getFileName());
						}catch(Exception e){}

					  total_inv_amt=mrequest.getParameter("total_inv_amt")==null?"0":(String)mrequest.getParameter("total_inv_amt");
					 
					  gst_amt=mrequest.getParameter("gst_amt")==null?"0":(String)mrequest.getParameter("gst_amt");
					  
					  total_amt=mrequest.getParameter("total_amt")==null?"0":(String)mrequest.getParameter("total_amt");
					  inv_no=mrequest.getParameter("inv_no")==null?"0":(String)mrequest.getParameter("inv_no");
					  inv_date=mrequest.getParameter("inv_date")==null?"0":(String)mrequest.getParameter("inv_date");
					  month_dt=session.getAttribute("sInvDt")==null?"":(String) session.getAttribute("sInvDt");
					
                      //month_dt=mrequest.getParameter("month_dt")==null?"":(String)mrequest.getParameter("month_dt");
					  edp_no=mrequest.getParameter("edp_no")==null?"":(String)mrequest.getParameter("edp_no");
                      FIVEDAYTRGINVNO=mrequest.getParameter("FIVEDAYTRGINVNO")==null?"10":(String)mrequest.getParameter("FIVEDAYTRGINVNO");
                      FIVEDAYTRGINVAMT=mrequest.getParameter("FIVEDAYTRGINVAMT")==null?"10":(String)mrequest.getParameter("FIVEDAYTRGINVAMT");
					  TENDAYTRGINVNO=mrequest.getParameter("TENDAYTRGINVNO")==null?"10":(String)mrequest.getParameter("TENDAYTRGINVNO");
					  TENDAYTRGINVAMT=mrequest.getParameter("TENDAYTRGINVAMT")==null?"10":(String)mrequest.getParameter("TENDAYTRGINVAMT");
					  FIVEDAYTRGINVAMT=mrequest.getParameter("FIVEDAYTRGINVAMT")==null?"10":(String)mrequest.getParameter("FIVEDAYTRGINVAMT");
					   EDPARRPAY=mrequest.getParameter("EDPARRPAY")==null?"10":(String)mrequest.getParameter("EDPARRPAY");
					    EDPARR_REM=mrequest.getParameter("EDPARR_REM")==null?"10":(String)mrequest.getParameter("EDPARR_REM");
					   
                     FIVEDAYTRGINVNO_OLD=mrequest.getParameter("FIVEDAYTRGINVNO_OLD")==null?"10":(String)mrequest.getParameter("FIVEDAYTRGINVNO_OLD");
                      TENDAYTRGINVNO_OLD=mrequest.getParameter("TENDAYTRGINVNO_OLD")==null?"10":(String)mrequest.getParameter("TENDAYTRGINVNO_OLD");
                    FIVEDAYTRGINVAMT_OLD=mrequest.getParameter("FIVEDAYTRGINVAMT_OLD")==null?"10":(String)mrequest.getParameter("FIVEDAYTRGINVAMT_OLD");
                    TENDAYTRGINVAMT_OLD=mrequest.getParameter("TENDAYTRGINVAMT_OLD")==null?"10":(String)mrequest.getParameter("TENDAYTRGINVAMT_OLD");

					   
	
	 
	 
						String frenNm="doc"+invupid+"_"+rnddt+"."+ext;
						
						
						File f = new File("/opt/tomcat5/webapps/pmegpeportal/samadhanedp/otherdocu/"+file.getFileName()+"");
						//File f = new File("E:\\tomcat5\\webapps\\chairmandashboard\\"+file.getFileName()+"");
     					
						boolean success =f.renameTo(new File("/opt/tomcat5/webapps/pmegpeportal/samadhanedp/otherdocu/"+frenNm+""));
						
						//boolean success =f.renameTo(new File("E:\\tomcat5\\webapps\\chairmandashboard\\"+frenNm+""));
						
						frenNm=ext.equals("")?UPDOC_EDP:frenNm;
			//out.print(frenNm+"edp_no:"+edp_no);			
						
						List pstm=new ArrayList();
		
		values.clear();
		
		pstm.clear();
		if (add_update.equals("I")) {
		 
		
ResultSet rsMax = db.execSQL("SELECT nvl(max(invupid),0)+1 as invupid  FROM BNF_ONLINEEDP_INF");
while (rsMax.next()) {
invupid=rsMax.getString("invupid")==null?"1":rsMax.getString("invupid");
}



	rsMax.close();
	

  
qryUpdate.append(" INSERT INTO BNF_ONLINEEDP_INF ");
qryUpdate.append("( updoc_edp,");
qryUpdate.append("total_amt, ");
qryUpdate.append("total_inv_amt,");
qryUpdate.append("month_dt,");
qryUpdate.append("gst_amt,FIVEDAYTRGINVNO,FIVEDAYTRGINVAMT,");
qryUpdate.append("TENDAYTRGINVNO,");
qryUpdate.append("TENDAYTRGINVAMT,");
qryUpdate.append("EDPARRPAY,");
qryUpdate.append("EDPARR_REM,");
qryUpdate.append("inv_no,inv_date,edp_no,FIVEDAYTRGINVNO_OLD,TENDAYTRGINVNO_OLD,FIVEDAYTRGINVAMT_OLD,TENDAYTRGINVAMT_OLD,off_cd,"); 
qryUpdate.append("invupid ");
qryUpdate.append( ") VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) ");

}else {
//try{

qryUpdate.append("	UPDATE BNF_ONLINEEDP_INF SET ");
qryUpdate.append("	updoc_edp = ?, ");
qryUpdate.append("	total_amt = ?, ");
qryUpdate.append("	total_inv_amt = ?, ");
qryUpdate.append("	month_dt = ?, ");
qryUpdate.append("  gst_amt = ?, ");
qryUpdate.append("  FIVEDAYTRGINVNO = ?, ");
qryUpdate.append("  FIVEDAYTRGINVAMT = ?, ");
qryUpdate.append("  TENDAYTRGINVNO = ?, ");
qryUpdate.append("  TENDAYTRGINVAMT = ?, ");
qryUpdate.append("  EDPARRPAY = ?, ");
qryUpdate.append("  EDPARR_REM = ?, ");
qryUpdate.append("	inv_no = ?, ");
qryUpdate.append("	inv_date = ?, edp_no= ? FIVEDAYTRGINVNO_OLD=?,TENDAYTRGINVNO_OLD=?,FIVEDAYTRGINVAMT_OLD=?,TENDAYTRGINVAMT_OLD=? ");
qryUpdate.append(" WHERE  off_cd=? and  invupid = ?    ");


}
//out.print (qryUpdate.toString());



values.add(frenNm); pstm.add ("L");
values.add(total_amt); pstm.add ("L");
values.add(total_inv_amt); pstm.add ("L");
values.add(month_dt); pstm.add ("L");
values.add(gst_amt); pstm.add ("L");
values.add(FIVEDAYTRGINVNO); pstm.add ("L");
values.add(FIVEDAYTRGINVAMT); pstm.add ("L");
values.add(TENDAYTRGINVNO); pstm.add ("L");
values.add(TENDAYTRGINVAMT); pstm.add ("L");
values.add(EDPARRPAY); pstm.add ("L");
values.add(EDPARR_REM); pstm.add ("L");

values.add(inv_no); pstm.add ("L");
values.add(inv_date); pstm.add ("L");
values.add(edp_no); pstm.add ("L");
values.add(FIVEDAYTRGINVNO_OLD); pstm.add ("L");
values.add(TENDAYTRGINVNO_OLD); pstm.add ("L");
values.add(FIVEDAYTRGINVAMT_OLD); pstm.add ("L");
values.add(TENDAYTRGINVAMT_OLD); pstm.add ("L");
values.add(off_cd); pstm.add ("L");
values.add(invupid); pstm.add ("L");

response.sendRedirect("savemsg.jsp");
						
db.setSqlValue(qryUpdate.toString()); 
db.setValues(values,pstm); 
db.executeUpdate() ;				
						
		
}
}
}
  
  	
  
   

	db.close(); 
  

%>
</form>


</body>
 
</HTML>



