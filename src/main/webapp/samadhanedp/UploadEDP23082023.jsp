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
	<title>SAMADHAN ONLINE EDP TRAINIG</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
	<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="css/style.css">
	<link rel="stylesheet" type="text/css" href="css/responsive.css">
</head>
<script type="text/javascript" src="js/datetimepicker_css.js"></script>
<script>

function newfun(){
 
var EDPARRPAY=document.getElementById('EDPARRPAY').value;
var FIVEDAYTRGINVNO=document.getElementById('FIVEDAYTRGINVNO').value;
var TENDAYTRGINVNO=document.getElementById('TENDAYTRGINVNO').value;

var myResult4=Number(FIVEDAYTRGINVNO)*1650; 
document.getElementById("FIVEDAYTRGINVAMT").value=myResult4.toFixed(0);

var myResult5=Number(TENDAYTRGINVNO)*3300;;
document.getElementById("TENDAYTRGINVAMT").value=myResult5.toFixed(0);

var myResult6=Number(myResult4)+Number(myResult5)+Number(EDPARRPAY);
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

 
  

var inv_no = form.inv_no.value; 
var inv_date = form.inv_date.value;
//var updoc_edp = form.updoc_edp.value; 
var total_inv_amt = form.total_inv_amt.value; 

var vuploadfile= form.uploadfile.value; 




 
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
                    alert(
                      " file size is large, Maximum size should be 1 MB");
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
	
	  //if (updoc_edp == "") {	 alert ( 'please Upload Edp Invoice ',2);	return (false);}
	 if (total_inv_amt == "") {	 alert ( 'please enter Invoice Amount',2);	return (false);}
	 
	

//alert("data save");
document.form.ins.value='I';
document.form.submit(); 

}
</script>




<style>

<style>
table {
  border-collapse: collapse;
  border-spacing: 0;
  width: auto;
  border: 1px solid #ddd;
}

th, td {
  text-align: left;
  padding: 4px;
}

tr:nth-child(even) {
  background-color: #f2f2f2;
}

.readonlytext {
 border: 0;
  box-shadow: none;
  background-color:#CCCCCC;
}


.style1 {font-weight: bold}
</style>
</style>


</head>
<body>
<form method="post"  name="form" id="form" class="form" enctype="multipart/form-data" >

<jsp:useBean id="upBean" scope="page" class="javazoom.upload.UploadBean" >
  <jsp:setProperty name="upBean" property="filesizelimit" value="1000000" />
    <jsp:setProperty name="upBean" property="folderstore" value="/opt/tomcat5/webapps/pmegpeportal/samadhanedp/otherdocu" />
  <jsp:setProperty name="upBean" property="overwrite" value="false" />
  <jsp:setProperty name="upBean" property="whitelist" value="*.pdf" />
  </jsp:useBean>
<%
List values=new ArrayList(); 

String off_cd=request.getParameter("off_cd")==null?"0":(String)request.getParameter("off_cd") ;
String month_dt=session.getAttribute("sInvDt")==null?"":(String) session.getAttribute("sInvDt");
String edp_no=request.getParameter("no_ofapp")==null?"0":(String)request.getParameter("no_ofapp") ;;
String state ="";
String off_name1 ="";
String invupid =request.getParameter("invupid")==null?"0":(String)request.getParameter("invupid");
String TOTAL_INV_AMT="";
String gst_amt="";
String total_inv_amt="";
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
String EDPARR_REM="";

//String off_name1="";

String add_update="I";
String ins=request.getParameter("ins")==null?"I":(String) request.getParameter("ins");



 DBCon db= new DBCon();
      db.connect(); 

if(!off_cd.equals("")){

StringBuffer qrysb = new StringBuffer();



qrysb.append("  SELECT mq.state,"      );
  qrysb.append("  mq.OFF_NAME1,"      );
  qrysb.append("  mq.OFF_CD,"      );
  qrysb.append("  sq.INVUPID,"      );
  qrysb.append("  sq.UPDOC_EDP,"      );
  qrysb.append("  sq.TOTAL_AMT,"      );
  qrysb.append("  sq.total_inv_amt,"      );
  qrysb.append("  sq.month_dt,"      );
  qrysb.append("  sq.GST_AMT,"      );
 qrysb.append("   NVL(sq.edp_no,"+edp_no+") AS EDP_NO,"      );
  qrysb.append("  sq.INV_NO,"      );
  qrysb.append("  sq.inv_date,"      );
  qrysb.append("  sq.FIVEDAYTRGINVNO,"      );
  qrysb.append("  sq.TENDAYTRGINVNO,"      );
  qrysb.append("  sq.FIVEDAYTRGINVAMT,"      );
  qrysb.append("  sq.EDPARRPAY,sq.EDPARR_REM,"      );
  qrysb.append("  sq.TENDAYTRGINVAMT"      );
  qrysb.append("  "      );
qrysb.append("  FROM "      );
  qrysb.append("  (SELECT ms.STATE_NM AS state, "      );
   qrysb.append("   mom.OFF_NAME1, "      );
  qrysb.append("    mom.OFF_CD  "      );
  qrysb.append("  FROM mas_off_mast mom, "      );
    qrysb.append("  m_district md, "      );
   qrysb.append("   m_state ms "      );
qrysb.append("    WHERE mom.DISTRICT_CD = md.DISTRICT_CD "      );
 qrysb.append("   AND md.STATE_CD       = ms.STATE_CD "      );
  qrysb.append("  AND mom.OFF_CD     =? "      );
 qrysb.append("   ) mq, "      );
  qrysb.append("  (SELECT boi.OFF_CD, "      );
  qrysb.append("    boi.INVUPID, "      );
  qrysb.append("    boi.UPDOC_EDP, "      );
   qrysb.append("   boi.TOTAL_AMT, "      );
   qrysb.append("   boi.total_inv_amt, "      );
    qrysb.append("  TO_CHAR(boi.MONTH_DT, 'DD-MON-RRRR') AS month_dt, "      );
   qrysb.append("   boi.GST_AMT, "      );
   qrysb.append("    NVL(boi.EDP_NO, 3) AS edp_no, "      );
   qrysb.append("   boi.INV_NO, "      );
    qrysb.append("  TO_CHAR(boi.INV_DATE, 'DD-MON-RRRR')   AS inv_date, "      );
     qrysb.append("  TO_CHAR(boi.FORWARD_DT, 'DD-MON-RRRR') AS FORWARD_DT, "      );
   qrysb.append("   boi.FIVEDAYTRGINVNO, "      );
   qrysb.append("   boi.TENDAYTRGINVNO, "      );
   qrysb.append("   boi.FIVEDAYTRGINVAMT, "      );
    qrysb.append("  boi.EDPARRPAY,boi.EDPARR_REM, "      );
   qrysb.append("   boi.TENDAYTRGINVAMT "      );
 
 qrysb.append("   FROM bnf_onlineedp_inf boi "      );
  qrysb.append("  WHERE NVL(boi.INVUPID, 0) = ?"      );
 qrysb.append("   ) sq "      );
qrysb.append("   WHERE mq.OFF_CD = sq.OFF_CD(+) "      );

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


if (!invupid.equals("0")) {
add_update="U";
}


}
rsMain.close();

}

%>
<body>

<table align="center" border="1" id="cont" >

			
				<form class="login100-form validate-form">
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
    <input name="edp_no" type="hidden" id="edp_no" value="<%=edp_no%>"  readonly="true" ></td>
  <td class="style1"><%=month_dt%> </td>
  <td><strong><strong>Training</strong> Completed </strong></td>
  <td class="style1"><%=edp_no%></td> 
</tr>
</table>

<table  align="center" cellpadding="2" cellspacing="2"  id="cont1" >
  
  <tr>
    <td align="center">&nbsp;</td>
    <td colspan="3">Invoice Should be in pdf file and Maximum size 1 mb. </td>
    </tr> 
  <tr>
    <td align="center"><strong>(1)</strong></td>
    <td><strong>Invoice Date:</strong></td>
    <td colspan="2"><input name="inv_date" type="text" id="inv_date" onClick="javascript:NewCssCal('inv_date','ddMMMyyyy')" value="<%=inv_date%>" >  <input type="text" id="month_dt" name="month_dt" value="<%=month_dt%>" readonly="true">  </td>
    </tr>
  <tr>
    <td align="center"><strong>(2)</strong></td>
    <td><strong>Invoice No:</strong></td>
    <td colspan="2"><input type="text"  name="inv_no" id="inv_no"  value="<%=inv_no%>" required /></td>
    </tr>
	
  
  <tr>
    <td align="center">&nbsp;</td>
    <td>&nbsp;</td>
    <td>No of Trainees </td> 
    <td>EDP Fees Amount </td>
  </tr>
  <tr>
    <td align="center">&nbsp;</td>
    <td><div align="right">5 Days Training @Rs. 1650  </div></td>
    <td><input type="number" id="FIVEDAYTRGINVNO" name="FIVEDAYTRGINVNO" value="<%=FIVEDAYTRGINVNO%>" onChange="newfun();" ></td>
    <td><input type="number"  id="FIVEDAYTRGINVAMT" name="FIVEDAYTRGINVAMT"  value="<%=FIVEDAYTRGINVAMT%>" readonly="true" class="readonlytext"  onChange="newfun();"></td>
  </tr>
  <tr>
    <td align="center">&nbsp;</td>
    <td><div align="right">10  Days Training @ Rs. 3300  </div></td>
    <td><input type="number" id="TENDAYTRGINVNO"  name="TENDAYTRGINVNO" value="<%=TENDAYTRGINVNO%>"  onchange="newfun();"></td>

	<td><input type="number"  id="TENDAYTRGINVAMT" name="TENDAYTRGINVAMT"  value="<%=TENDAYTRGINVAMT%>" readonly="true" class="readonlytext" onChange="newfun();"></td>
  </tr>
  <tr>
    <td align="center">&nbsp;</td> 
    <td colspan="2"><div align="right">EDP Arrear (If Any)</div></td> 
    <td><input type="number" id="EDPARRPAY" name="EDPARRPAY" value="<%=EDPARRPAY%>"  onChange="newfun();"></td>
  </tr> 
  <tr>
    <td align="center">&nbsp;</td> 
    <td><div align="right">Total EDP  </div></td>
    <td><input type="text" id="edp_no" name="edp_no" value="<%=edp_no%>" class="readonlytext"  readonly="true" ></td>
    <td><input type="text"  name="total_inv_amt" id="total_inv_amt"  onChange="newfun();" value="<%=total_inv_amt%>"  class="readonlytext"  readonly="true"></td>
  </tr>
  
  <tr>
    <td align="center">&nbsp;</td>
    <td>Remark (if Any) </td>
    <td colspan="2"><input name="EDPARR_REM" type="text" id="EDPARR_REM" value="<%=EDPARR_REM%>" size="50" maxlength="100"></td>
  </tr>
  <tr> 
    <td align="center"><strong>(4)</strong></td> 
    <td><strong>GST@18%*:</strong></td>
    <td colspan="2"><input  type="text"  name="gst_amt" id="gst_amt" value="<%=gst_amt%>"  onChange="newfun();"  readonly="true" class="readonlytext" /></td>
    </tr>
  <tr>
    <td align="center"><strong>(5)</strong></td>
    <td><strong>Total EDP Fees with GST:</strong></td>
    <td colspan="2"><input  type="text"  name="total_amt"  id="total_amt" value="<%=total_amt%>" readonly="true"  onChange="newfun();"  class="readonlytext"/></td>
    </tr>
  <tr>
    <td align="center"><strong>(6)</strong></td>
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
					
                    //  month_dt=mrequest.getParameter("month_dt")==null?"":(String)mrequest.getParameter("month_dt");
					  edp_no=mrequest.getParameter("edp_no")==null?"10":(String)mrequest.getParameter("edp_no");
                      FIVEDAYTRGINVNO=mrequest.getParameter("FIVEDAYTRGINVNO")==null?"10":(String)mrequest.getParameter("FIVEDAYTRGINVNO");
                      FIVEDAYTRGINVAMT=mrequest.getParameter("FIVEDAYTRGINVAMT")==null?"10":(String)mrequest.getParameter("FIVEDAYTRGINVAMT");
					  TENDAYTRGINVNO=mrequest.getParameter("TENDAYTRGINVNO")==null?"10":(String)mrequest.getParameter("TENDAYTRGINVNO");
					  TENDAYTRGINVAMT=mrequest.getParameter("TENDAYTRGINVAMT")==null?"10":(String)mrequest.getParameter("TENDAYTRGINVAMT");
					  FIVEDAYTRGINVAMT=mrequest.getParameter("FIVEDAYTRGINVAMT")==null?"10":(String)mrequest.getParameter("FIVEDAYTRGINVAMT");
					   EDPARRPAY=mrequest.getParameter("EDPARRPAY")==null?"10":(String)mrequest.getParameter("EDPARRPAY");
					    EDPARR_REM=mrequest.getParameter("EDPARR_REM")==null?"10":(String)mrequest.getParameter("EDPARR_REM");
					   
	 
	 
	 
						String frenNm="doc"+invupid+"_"+rnddt+"."+ext;
						
						
						File f = new File("/opt/tomcat5/webapps/pmegpeportal/samadhanedp/otherdocu/"+file.getFileName()+"");
     					
						boolean success =f.renameTo(new File("/opt/tomcat5/webapps/pmegpeportal/samadhanedp/otherdocu/"+frenNm+""));
						
						
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
qryUpdate.append("inv_no,inv_date,edp_no,off_cd,"); 
qryUpdate.append("invupid ");
qryUpdate.append( ") VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) ");

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
qryUpdate.append("	inv_date = ?, edp_no= ?  ");
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
values.add(off_cd); pstm.add ("L");
values.add(invupid); pstm.add ("L");


						
		db.setSqlValue(qryUpdate.toString()); 
db.setValues(values,pstm); 
db.executeUpdate() ;				
						
		//out.print ("invupid: "+qryUpdate.toString()) ;			
						
					   
				
					//response.sendRedirect("savemsg.jsp");
					
										
						}
						}
						}
		
		 
		 
		
		//out.print(err);
		//out.print (qryUpdate.toString());
  
  
  
  
   

	db.close(); 
  

%>
</form>


</body>
 
</HTML>



