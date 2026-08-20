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

<head>
	<title> ONLINE EDP TRAINING</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<LINK rel="stylesheet" type="text/css" href="main1.css">
	
	
	
	<SCRIPT src="../js/sweetalert.min.js"></SCRIPT>




	
	
    <style type="text/css">


#cont{
border-style: outset;
}
#cont th{
background:#FFCC99;
padding-top:20thx;
font-size:x-large;
}

.style1 {font-family: Arial black, Helvetica, sans-serif;
font-size:14px;
height:35;

}
#cont1{
  font-family: Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 75%;
  border-style: inset;
  background-color:#FFECD9;
  
}
#cont1 td{height:70;
}

.button {
  box-shadow: 0 8px 16px 0 rgba(0,0,0,0.6), 0 6px 20px 0 rgba(0,0,0,0.19);
  margin: 4px 2px;
  padding: 15px 32px;
}
.button2{
  box-shadow: 0 8px 16px 0 rgba(0,0,0,0.6), 0 6px 20px 0 rgba(0,0,0,0.19);
  margin: 4px 2px;
  padding: 10px 25px;
}

.button1:hover {
  box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24), 0 17px 50px 0 rgba(0,0,0,0.19);
}
.readonlytext11 {border: 0;
  box-shadow: none;
  background-color:#CCCCCC;
}

 

.readonlytext {
 border: 0;
  box-shadow: none;
  background-color:#CCCCCC;
}

input[type=text] {
  width: 60%;
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
.readonlytext1 { border: 0;
  box-shadow: none;
  background-color:#CCCCCC;
}
    .readonlytext2 { border: 0;
  box-shadow: none;
  background-color:#CCCCCC;
}
    .readonlytext3 { border: 0;
  box-shadow: none;
  background-color:#CCCCCC;
}
    .readonlytext4 { border: 0;
  box-shadow: none;
  background-color:#CCCCCC;
}
    .readonlytext5 { border: 0;
  box-shadow: none;
  background-color:#CCCCCC;
}
    </style>
</head>



<script>

function calculateedp(){

document.getElementById('FIVEDAYTRGRECOMAMT').value = Number(document.getElementById('FIVEDAYTRGRECOMNO').value) *1650
document.getElementById('TENDAYTRGRECOMAMT').value = Number(document.getElementById('TENDAYTRGRECOMNO').value) *3300
document.getElementById('FIVEDAYTRGRECOMAMT_OLD').value = Number(document.getElementById('FIVEDAYTRGRECOMNO_OLD').value) *1500
document.getElementById('TENDAYTRGRECOMAMT_OLD').value = Number(document.getElementById('TENDAYTRGRECOMNO_OLD').value) *3000

document.getElementById('TOTALEDPRECOMAMT').value = Number(document.getElementById('FIVEDAYTRGRECOMAMT').value) +Number(document.getElementById('TENDAYTRGRECOMAMT').value)+
Number(document.getElementById('FIVEDAYTRGRECOMAMT_OLD').value)+Number(document.getElementById('TENDAYTRGRECOMAMT_OLD').value)

document.getElementById('GST_AMT_RECOM').value= Number(document.getElementById('TOTALEDPRECOMAMT').value)*18/100

document.getElementById('TOTALRECOMAMT').value=Number(document.getElementById('TOTALEDPRECOMAMT').value) +Number(document.getElementById('GST_AMT_RECOM').value)

document.getElementById('TOTALEDPRECOMNO').value = Number(document.getElementById('FIVEDAYTRGRECOMNO').value) +Number(document.getElementById('TENDAYTRGRECOMNO').value)+
Number(document.getElementById('FIVEDAYTRGRECOMNO_OLD').value)+Number(document.getElementById('TENDAYTRGRECOMNO_OLD').value)



}

</script>
<script language="javascript"> 

//var MOBILE=document.getElementById("phone").value;
//var EMAIL=document.getElementById("email").value;



	
function submitform() {
var TOTAL_INV_AMT=document.form.total_inv_amt.value;
var EDP_NO= document.form.edp_no.value;

var TOTALEDPRECOMNO = document.form.TOTALEDPRECOMNO.value;
var TOTALEDPRECOMAMT = document.form.TOTALEDPRECOMAMT.value;
  
  

  
  if ((Number(TOTALEDPRECOMNO)) > (Number(EDP_NO))) {
	  swal ( 'Note:','No cannot be gretaer than'+EDP_NO,'error');	
	  //inlineMsg ( 'TOTALEDPRECOMNO','No cannot be gretaer than'+EDP_NO,2);
	  return (false);
	  }
	  
	  if ((Number(TOTALEDPRECOMAMT)) > (Number(TOTAL_INV_AMT))) {
		 swal ( 'Note:','Amount cannot be gretaer than'+TOTAL_INV_AMT,'error');	
	  //inlineMsg ( 'TOTALEDPRECOMAMT','Amount cannot be gretaer than'+TOTAL_INV_AMT,2);	return (false);
	  return (false);
	  } 

document.form.ins.value='I';
document.form.submit(); 

}
</script>



</head>
<body onLoad="calculateedp();">
<form method="post"  name="form" id="form" class="form" >

<%@ include file = "sessionoutinc.jsp" %>
<%
List values=new ArrayList(); 

String off_cd=SOFF_CD;

String month_dt=request.getParameter("MONTH_DT")==null?"":(String)request.getParameter("MONTH_DT");


String edp_no=request.getParameter("no_ofapp")==null?"0":(String)request.getParameter("no_ofapp");
String EDPARR_REM="";
String state ="";

String off_name1 ="";
String invupid =request.getParameter("invupid")==null?"0":(String)request.getParameter("invupid");



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
String FIVEDAYTRGRECOMNO_OLD = "";
String TENDAYTRGRECOMNO_OLD = "";
String FIVEDAYTRGRECOMAMT_OLD = "";
String TENDAYTRGRECOMAMT_OLD = "";
String TOTALEDPRECOMAMT = "";
String TOTALEDPRECOMNO = "";
String DISALLOW_REASON = "";
String GST_AMT_RECOM = "";
String TOTALRECOMAMT = "";
String FIVEDAYTRGRECOMNO = "";
String TENDAYTRGRECOMNO = "";
String FIVEDAYTRGRECOMAMT = "";
String TENDAYTRGRECOMAMT = "";
String EDPARRPAYRECOM = "";
String EDPARRRECOM_REM = "";
String add_update="I";
String ins=request.getParameter("ins")==null?"I":(String) request.getParameter("ins");



 DBCon db= new DBCon();
      db.connect(); 

if(!off_cd.equals("")){

StringBuffer qrysb = new StringBuffer();


 qrysb.append("   SELECT "      );
qrysb.append("   TO_CHAR(SQ.MONTH_DT,'MON-RRRR') AS EDPMONTH,"      );
qrysb.append("     MOM.OFF_NAME1,"      );
qrysb.append("     MOM.OFF_CD,"      );
qrysb.append("     sq.INVUPID,"      );
qrysb.append("     sq.UPDOC_EDP,"      );
qrysb.append("     sq.TOTAL_AMT,"      );
qrysb.append("     sq.TOTAL_INV_AMT,"      );
qrysb.append("     sq.month_dt,"      );
qrysb.append("     sq.GST_AMT,"      );
qrysb.append("     NVL(sq.edp_no, 0) AS EDP_NO,"      );
qrysb.append("     sq.INV_NO,"      );
qrysb.append("     sq.inv_date,"      );
qrysb.append("     sq.FIVEDAYTRGINVNO,"      );
qrysb.append("     sq.TENDAYTRGINVNO,"      );
qrysb.append("     sq.FIVEDAYTRGINVAMT,"      );
qrysb.append("     sq.EDPARRPAY,"      );
qrysb.append("     sq.EDPARR_REM,"      );
qrysb.append("     sq.TENDAYTRGINVAMT,"      );
qrysb.append("     sq.TENDAYTRGINVAMT_OLD,"      );
qrysb.append("     sq.FIVEDAYTRGINVAMT_OLD,"      );
qrysb.append("     sq.TENDAYTRGINVNO_OLD,"      );
qrysb.append("     sq.FIVEDAYTRGINVNO_OLD,"      );
qrysb.append("     sq.FIVEDAYTRGRECOMNO_OLD,"      );
qrysb.append("     sq.TENDAYTRGRECOMNO_OLD,"      );
qrysb.append("     sq.FIVEDAYTRGRECOMAMT_OLD,"      );
qrysb.append("     sq.TENDAYTRGRECOMAMT_OLD,"      );
qrysb.append("     sq.TOTALEDPRECOMAMT,"      );
qrysb.append("     sq.TOTALEDPRECOMNO,"      );
qrysb.append("     sq.DISALLOW_REASON,"      );
qrysb.append("     sq.GST_AMT_RECOM,"      );
qrysb.append("     sq.TOTALRECOMAMT,"      );
qrysb.append("     sq.EDPARRPAYRECOM,"      );
qrysb.append("     sq.TENDAYTRGRECOMAMT,"      );
qrysb.append("     sq.FIVEDAYTRGRECOMAMT,"      );
qrysb.append("     sq.TENDAYTRGRECOMNO,"      );
qrysb.append("     sq.FIVEDAYTRGRECOMNO,"      );
qrysb.append("     sq.EDPARRRECOM_REM"      );
qrysb.append("   FROM BNF_ONLINEEDP_INF SQ,"      );
qrysb.append("   MAS_OFF_MAST MOM"      );
qrysb.append("   WHERE SQ.OFF_CD=MOM.OFF_CD"      );
qrysb.append("   AND SQ.INVUPID=? AND SQ.OFF_CD=? AND TRUNC(SQ.MONTH_DT)=? "      );
qrysb.append("   "      );
qrysb.append("   AND SQ.UPDOC_EDP IS NOT NULL"      );


values.add(invupid);

values.add(off_cd);
values.add(month_dt);

//out.print (qrysb.toString());


ResultSet rsMain = db.executeSQL(qrysb.toString(),values);

while (rsMain.next()){
invupid=rsMain.getString("invupid")==null?"0":rsMain.getString("invupid");
updoc_edp=rsMain.getString("updoc_edp")==null?"":rsMain.getString("updoc_edp");
total_amt=rsMain.getString("total_amt")==null?"":rsMain.getString("total_amt");
total_inv_amt=rsMain.getString("total_inv_amt")==null?"":rsMain.getString("total_inv_amt");
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
FIVEDAYTRGRECOMNO=rsMain.getString("FIVEDAYTRGRECOMNO")==null?"":rsMain.getString("FIVEDAYTRGRECOMNO");
TENDAYTRGRECOMNO=rsMain.getString("TENDAYTRGRECOMNO")==null?"":rsMain.getString("TENDAYTRGRECOMNO");
FIVEDAYTRGRECOMAMT=rsMain.getString("FIVEDAYTRGRECOMAMT")==null?"":rsMain.getString("FIVEDAYTRGRECOMAMT");
TENDAYTRGRECOMAMT=rsMain.getString("TENDAYTRGRECOMAMT")==null?"":rsMain.getString("TENDAYTRGRECOMAMT");
EDPARRPAYRECOM=rsMain.getString("EDPARRPAYRECOM")==null?"":rsMain.getString("EDPARRPAYRECOM");
EDPARRRECOM_REM=rsMain.getString("EDPARRRECOM_REM")==null?"":rsMain.getString("EDPARRRECOM_REM");
FIVEDAYTRGRECOMNO_OLD=rsMain.getString("FIVEDAYTRGRECOMNO_OLD")==null?"":rsMain.getString("FIVEDAYTRGRECOMNO_OLD");
TENDAYTRGRECOMNO_OLD=rsMain.getString("TENDAYTRGRECOMNO_OLD")==null?"":rsMain.getString("TENDAYTRGRECOMNO_OLD");
FIVEDAYTRGRECOMAMT_OLD=rsMain.getString("FIVEDAYTRGRECOMAMT_OLD")==null?"":rsMain.getString("FIVEDAYTRGRECOMAMT_OLD");
TENDAYTRGRECOMAMT_OLD=rsMain.getString("TENDAYTRGRECOMAMT_OLD")==null?"":rsMain.getString("TENDAYTRGRECOMAMT_OLD");
TOTALEDPRECOMAMT=rsMain.getString("TOTALEDPRECOMAMT")==null?"":rsMain.getString("TOTALEDPRECOMAMT");
TOTALEDPRECOMNO=rsMain.getString("TOTALEDPRECOMNO")==null?"":rsMain.getString("TOTALEDPRECOMNO");
DISALLOW_REASON=rsMain.getString("DISALLOW_REASON")==null?"":rsMain.getString("DISALLOW_REASON");
GST_AMT_RECOM=rsMain.getString("GST_AMT_RECOM")==null?"":rsMain.getString("GST_AMT_RECOM");
TOTALRECOMAMT=rsMain.getString("TOTALRECOMAMT")==null?"":rsMain.getString("TOTALRECOMAMT");


//add_update="U";


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
    <td colspan="5">&nbsp;</td>
    </tr> 
  <tr> 
    <td align="center"><strong>(1)</strong></td>
    <td><strong>Invoice Date:</strong></td>
    <td><%//=inv_date%>  </td>
    <td><strong>Invoice No:</strong></td>
    <td><%=inv_no%></td>
    <td>&nbsp;</td>
  </tr>
  
	
   
  <tr>
    <td align="center">&nbsp;</td>
    <td><strong>Particulars</strong></td>
    <td colspan="2"><strong>Claimed by Samadhan Samiti Vendor </strong></td>
    <td colspan="2"><strong>Recommended for Payment </strong></td>
    </tr>
  <tr>
    <td align="center"><strong>(3)</strong></td>
    <td>NEW RATE </td> 
    <td>No of Trainees </td> 
    <td>EDP Fees Amount</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr> 
  <tr>
    <td align="center">&nbsp;</td>
    <td><div align="right">5 Days Training @Rs. 1650  </div></td>
    <td><%=FIVEDAYTRGINVNO%></td>
    <td><%=FIVEDAYTRGINVAMT%></td>
    <td><input name="FIVEDAYTRGRECOMNO" type="number"  id="FIVEDAYTRGRECOMNO"   value="<%=FIVEDAYTRGRECOMNO%>" onChange="calculateedp();" maxlength="12" ></td>
    <td><input name="FIVEDAYTRGRECOMAMT" type="text1"   id="FIVEDAYTRGRECOMAMT"   value="<%=FIVEDAYTRGRECOMAMT%>"  maxlength="12" readonly="true"></td>
  </tr> 
  <tr>
    <td align="center">&nbsp;</td>
    <td><div align="right">10  Days Training @ Rs. 3300  </div></td>
    <td><%=TENDAYTRGINVNO%></td>

	<td><%=TENDAYTRGINVAMT%></td>
	<td><input name="TENDAYTRGRECOMNO" type="number"   id="TENDAYTRGRECOMNO"   value="<%=TENDAYTRGRECOMNO%>" onChange="calculateedp();" maxlength="12" ></td>
	<td><input name="TENDAYTRGRECOMAMT" type="text1"  id="TENDAYTRGRECOMAMT"  onChange="calculateedp();" value="<%=TENDAYTRGRECOMAMT%>" maxlength="12" readonly="true"></td>
  </tr>
  <tr>
    <td align="center"><strong>(4)</strong></td>
    <td>OLD RATE </td> 
    <td>No of Trainees </td> 
    <td>EDP Fees Amount</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="center">&nbsp;</td>
    <td><div align="right">5 Days Training @Rs. 1500 </div></td>
    <td><%=FIVEDAYTRGINVNO_OLD%></td>
    <td><%=FIVEDAYTRGINVAMT_OLD%></td>
    <td><input type="number" id="FIVEDAYTRGRECOMNO_OLD" name="FIVEDAYTRGRECOMNO_OLD" value="<%=FIVEDAYTRGRECOMNO_OLD%>" onChange="calculateedp();" class="form-text" maxlength="5"></td>
    <td><input type="text1" id="FIVEDAYTRGRECOMAMT_OLD" name="FIVEDAYTRGRECOMAMT_OLD" value="<%=FIVEDAYTRGRECOMAMT_OLD%>" onChange="calculateedp();"  class="form-text" maxlength="5"></td>
  </tr> 
  <tr>
    <td align="center">&nbsp;</td>
    <td><div align="right">10  Days Training @ Rs. 3000  </div></td>
    <td><%=TENDAYTRGINVNO_OLD%></td>

	<td><%=TENDAYTRGINVAMT_OLD%></td>
	<td><input type="number" id="TENDAYTRGRECOMNO_OLD" name="TENDAYTRGRECOMNO_OLD" value="<%=TENDAYTRGRECOMNO_OLD%>"  onChange="calculateedp();"  class="form-text" maxlength="5"></td>
	<td><input type="text1" id="TENDAYTRGRECOMAMT_OLD" name="TENDAYTRGRECOMAMT_OLD" value="<%=TENDAYTRGRECOMAMT_OLD%>" onChange="calculateedp();" class="form-text" maxlength="5"></td>
  </tr>
  
  <tr>
    <td align="center"><strong>(5)</strong></td>
    <td><div align="right">EDP Arrear Remark (If Any) </div></td> 
    <td colspan="4"><%=EDPARR_REM%></td>
    </tr> 
  <tr> 
    <td align="center">&nbsp;</td> 
    <td><div align="right">Any Arrear Amount </div></td>   
    <td></td> 
    <td><%=EDPARRPAY%></td>
    <td></td>
   <td><input type="text1" id="EDPARRPAYRECOM" name="EDPARRPAYRECOM" value="<%=EDPARRPAYRECOM%>"   class="form-text" maxlength="5"></td>
  </tr>  
  <tr>  
    <td align="center">&nbsp;</td> 
    <td><div align="left"><strong>Total EDP </strong> </div></td>
  <td>
 <%=edp_no%><input type="hidden" id="edp_no" name="edp_no"   value="<%=edp_no%>"></td>
    <td><input type="hidden" id="total_inv_amt" name="total_inv_amt"   value="<%=total_inv_amt%>"><%=total_inv_amt%></td>
    <td><input type="number" id="TOTALEDPRECOMNO" name="TOTALEDPRECOMNO"   value="<%=TOTALEDPRECOMNO%>" class="form-text" maxlength="5"></td>
    <td><input type="text" id="TOTALEDPRECOMAMT" name="TOTALEDPRECOMAMT" value="<%=TOTALEDPRECOMAMT%>"  class="form-text" maxlength="6"></td>
  </tr>
  
  <tr> 
    <td align="center">&nbsp;</td> 
    <td><strong>GST@18%*:</strong></td> 
    <td>&nbsp;</td>
    <td><%=gst_amt%></td>
    <td>&nbsp;</td>
    <td><input type="text1" id="GST_AMT_RECOM" name="GST_AMT_RECOM" value="<%=GST_AMT_RECOM%>"   class="form-text" maxlength="5"></td>
  </tr>
  <tr>
    <td align="center">&nbsp;</td>
    <td><strong>Total EDP Fees with GST:</strong></td>
    <td>&nbsp;</td>
    <td><%=total_amt%></td>
    <td>&nbsp;</td>
    <td><input type="text1" id="TOTALRECOMAMT" name="TOTALRECOMAMT" value="<%=TOTALRECOMAMT%>"  class="form-text" maxlength="5"></td> 
  </tr>
  <br>
  <tr>
    <td class="style1" align="center">&nbsp;</td>
    <td class="style1" align="center">Disallow Reason </td>
    <td colspan="4" align="center" class="style1"><input type="text1" id="DISALLOW_REASON" name="DISALLOW_REASON" value="<%=DISALLOW_REASON%>"  class="form-text" maxlength="300"></td>
    </tr>
  <tr>
    <td colspan="6" class="style1" align="center"><div align="center">
      <input name="button" type="button" class="button2"  onClick="submitform();" value="SAVE DATA" />
    </div></td>
  </tr>
</table>
<%


if ((String)request.getParameter("ins")!=null){

 
FIVEDAYTRGRECOMNO=(String) request.getParameter("FIVEDAYTRGRECOMNO")==null?"":(String) request.getParameter("FIVEDAYTRGRECOMNO").trim();
TENDAYTRGRECOMNO=(String) request.getParameter("TENDAYTRGRECOMNO")==null?"":(String) request.getParameter("TENDAYTRGRECOMNO").trim();
FIVEDAYTRGRECOMAMT=(String) request.getParameter("FIVEDAYTRGRECOMAMT")==null?"":(String) request.getParameter("FIVEDAYTRGRECOMAMT").trim();
TENDAYTRGRECOMAMT=(String) request.getParameter("TENDAYTRGRECOMAMT")==null?"":(String) request.getParameter("TENDAYTRGRECOMAMT").trim();
EDPARRPAYRECOM=(String) request.getParameter("EDPARRPAYRECOM")==null?"":(String) request.getParameter("EDPARRPAYRECOM").trim();
EDPARRRECOM_REM=(String) request.getParameter("EDPARRRECOM_REM")==null?"":(String) request.getParameter("EDPARRRECOM_REM").trim();
FIVEDAYTRGINVNO_OLD=(String) request.getParameter("FIVEDAYTRGINVNO_OLD")==null?"":(String) request.getParameter("FIVEDAYTRGINVNO_OLD").trim();
TENDAYTRGINVNO_OLD=(String) request.getParameter("TENDAYTRGINVNO_OLD")==null?"":(String) request.getParameter("TENDAYTRGINVNO_OLD").trim();
FIVEDAYTRGINVAMT_OLD=(String) request.getParameter("FIVEDAYTRGINVAMT_OLD")==null?"":(String) request.getParameter("FIVEDAYTRGINVAMT_OLD").trim();
TENDAYTRGINVAMT_OLD=(String) request.getParameter("TENDAYTRGINVAMT_OLD")==null?"":(String) request.getParameter("TENDAYTRGINVAMT_OLD").trim();
FIVEDAYTRGRECOMNO_OLD=(String) request.getParameter("FIVEDAYTRGRECOMNO_OLD")==null?"":(String) request.getParameter("FIVEDAYTRGRECOMNO_OLD").trim();
TENDAYTRGRECOMNO_OLD=(String) request.getParameter("TENDAYTRGRECOMNO_OLD")==null?"":(String) request.getParameter("TENDAYTRGRECOMNO_OLD").trim();
FIVEDAYTRGRECOMAMT_OLD=(String) request.getParameter("FIVEDAYTRGRECOMAMT_OLD")==null?"":(String) request.getParameter("FIVEDAYTRGRECOMAMT_OLD").trim();
TENDAYTRGRECOMAMT_OLD=(String) request.getParameter("TENDAYTRGRECOMAMT_OLD")==null?"":(String) request.getParameter("TENDAYTRGRECOMAMT_OLD").trim();
TOTALEDPRECOMAMT=(String) request.getParameter("TOTALEDPRECOMAMT")==null?"":(String) request.getParameter("TOTALEDPRECOMAMT").trim();
TOTALEDPRECOMNO=(String) request.getParameter("TOTALEDPRECOMNO")==null?"":(String) request.getParameter("TOTALEDPRECOMNO").trim();
DISALLOW_REASON=(String) request.getParameter("DISALLOW_REASON")==null?"":(String) request.getParameter("DISALLOW_REASON").trim();
GST_AMT_RECOM=(String) request.getParameter("GST_AMT_RECOM")==null?"":(String) request.getParameter("GST_AMT_RECOM").trim();
TOTALRECOMAMT=(String) request.getParameter("TOTALRECOMAMT")==null?"":(String) request.getParameter("TOTALRECOMAMT").trim();

		
		List pstm=new ArrayList();
			StringBuffer qryUpdate = new StringBuffer();
		  values.clear();
		   pstm.clear();
		   
		
		

qryUpdate.append("UPDATE BNF_ONLINEEDP_INF SET ");
qryUpdate.append("FIVEDAYTRGRECOMNO=?,");
qryUpdate.append("TENDAYTRGRECOMNO=?,");
qryUpdate.append("FIVEDAYTRGRECOMAMT=?,");
qryUpdate.append("TENDAYTRGRECOMAMT=?,");
qryUpdate.append("EDPARRPAYRECOM=?,");
qryUpdate.append("EDPARRRECOM_REM=?,");
qryUpdate.append("FIVEDAYTRGINVNO_OLD=?,");
qryUpdate.append("TENDAYTRGINVNO_OLD=?,");
qryUpdate.append("FIVEDAYTRGINVAMT_OLD=?,");
qryUpdate.append("TENDAYTRGINVAMT_OLD=?,");
qryUpdate.append("FIVEDAYTRGRECOMNO_OLD=?,");
qryUpdate.append("TENDAYTRGRECOMNO_OLD=?,");
qryUpdate.append("FIVEDAYTRGRECOMAMT_OLD=?,");
qryUpdate.append("TENDAYTRGRECOMAMT_OLD=?,");
qryUpdate.append("TOTALEDPRECOMAMT=?,");
qryUpdate.append("TOTALEDPRECOMNO=?,");
qryUpdate.append("DISALLOW_REASON=?,");
qryUpdate.append("GST_AMT_RECOM=?,");
qryUpdate.append(" TOTALRECOMAMT=? ");
qryUpdate.append(" WHERE OFF_CD=? AND  invupid=? AND RECOM_LET_UPLOAD IS NULL ");




//out.print (qryUpdate.toString());



values.add(FIVEDAYTRGRECOMNO); pstm.add ("L");
values.add(TENDAYTRGRECOMNO); pstm.add ("L");
values.add(FIVEDAYTRGRECOMAMT); pstm.add ("L");
values.add(TENDAYTRGRECOMAMT); pstm.add ("L");
values.add(EDPARRPAYRECOM); pstm.add ("L");
values.add(EDPARRRECOM_REM); pstm.add ("L");
values.add(FIVEDAYTRGINVNO_OLD); pstm.add ("L");
values.add(TENDAYTRGINVNO_OLD); pstm.add ("L");
values.add(FIVEDAYTRGINVAMT_OLD); pstm.add ("L");
values.add(TENDAYTRGINVAMT_OLD); pstm.add ("L");
values.add(FIVEDAYTRGRECOMNO_OLD); pstm.add ("L");
values.add(TENDAYTRGRECOMNO_OLD); pstm.add ("L");
values.add(FIVEDAYTRGRECOMAMT_OLD); pstm.add ("L");
values.add(TENDAYTRGRECOMAMT_OLD); pstm.add ("L");
values.add(TOTALEDPRECOMAMT); pstm.add ("L");
values.add(TOTALEDPRECOMNO); pstm.add ("L");
values.add(DISALLOW_REASON); pstm.add ("L");
values.add(GST_AMT_RECOM); pstm.add ("L");
values.add(TOTALRECOMAMT); pstm.add ("L");

values.add(off_cd); pstm.add ("L");
values.add(invupid); pstm.add ("L");

//response.sendRedirect("savemsg.jsp");
						
db.setSqlValue(qryUpdate.toString()); 
db.setValues(values,pstm); 
db.executeUpdate() ;
		
						
		
}
  
  	
  
   

	db.close(); 
  

%>
</form>


</body>
 
</HTML>



