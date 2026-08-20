
<%@ page session="true"  import="java.sql.*"  %>
<%@ page import="pkgPmegpNew.DBCon" %>
<%@ page import="java.util.*" %>
<%@ page import="pmegpchallan.SHACheckHash" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>PMEGP</title>

<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<SCRIPT src="../js/sweetalert.min.js"></SCRIPT>

<SCRIPT>

/*function checkradio(RADIO){

if(RADIO=="R"){
document.getElementById("productinfo").value="Margin Money Refund";

}else{
document.getElementById("productinfo").value="Margin Money Callback";
}
}*/

function ValidateForm(){
 var numberOnly=/^[0-9]*$/;
var emailre=/^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;

var MOBILE=document.getElementById("phone").value;
var EMAIL=document.getElementById("email").value;


if(MOBILE==""){
 swal ( 'Note:','Please Enter Mobile No.','error');	
 return (false);
}

if(!numberOnly.test(MOBILE)) {
 swal ( 'Note:','Please Enter Correct Mobile No. Only Numbers','error');	
 return (false);
}

if(MOBILE.length!="10"){
 swal ( 'Note:','Please Enter 10 digit Mobile No.','error');	
 return (false);
}

if(EMAIL==""){
 swal ( 'Note:','Please Enter Email Id','error');	
 return (false);
}


if(!emailre.test(EMAIL)) {
 swal ( 'Note:','Please Enter Correct Email Id','error');	
 return (false);
}

document.form.ins.value='I';
document.form.submit();

}
//

</SCRIPT>
<style type="text/css">
<!--
.style1 {
	font-size: 18px;
	font-weight: bold;
}
-->
</style>
</head>

<body onload="checkradio('C');">
<form method="post" name="form" id="form">

  <div align="center"><img src="pmegponline.jpg" width="100%" height="150" >
    <BR>
    <BR>
    <span class="style1">PMEGP E- Challan</span>
	<br> 
	  <table border="1" align="center" width="80%">
<tr><th>Steps to generate e-challan</th></tr>
<tr><td>1): Enter Branch Manager Mobile No.</td></tr>
<tr>
  <td>2): Enter Financing Branch Remarks (if amy) &amp; click on Submit </td>
</tr>

<tr>
  <td>3): Click on NEFT/RTGS and Proceed</td>
</tr>
<tr>
  <td>4): Please accept terms & condition and enter Mobile no. & Email Id</td>
</tr>
<tr>
  <td>5): Then Save Challan as pdf or print</td>
</tr>
</table>
 
    <%

	String APP_ID =session.getAttribute("SAPPID")==null?"": (String)session.getAttribute("SAPPID");
    String IFSC_CODE=session.getAttribute("bank_id")==null?"": (String)session.getAttribute("bank_id");


String MM_REL_AMT="";
String APP_NAME="";
String BANKNAME="";
String BRANCHNAME="";
String TXNID="";

String PRODUCTINFO="";
String EMAIL="";
String PHONE="";
String UDF5="";
%>
    <CENTER>
    <input name="APP_ID" type="HIDDEN" id="APP_ID" value="<%= APP_ID %>" size="25" maxlength="30">
    <BR>
  
   


  <input name="ins" type="hidden" id="ins">


    <%


	
DBCon db= new DBCon();
db.connect();

String BRANCHEMAIL="";
   List values=new ArrayList();	
    List pstm=new ArrayList();
StringBuffer qrysb = new StringBuffer();
values.add(APP_ID);
values.add(IFSC_CODE);
values.add(APP_ID);
values.add(IFSC_CODE);	
qrysb.append(" select p.*, (select lpad(nvl(count(*),0)+1,2,0) from indbank_request  where ");
qrysb.append(" substr(txnid,3,length(txnid))=appid_str)||appid_str txnid  from ( select bd.app_id, ");
qrysb.append(" substr(bd.app_id,instr(bd.app_id,'-')+1,length(bd.app_id)) appid_str, CASE WHEN BD.PBATCH_ID >= 563 THEN");
qrysb.append(" BD.MM_REL_AMT-500 ELSE  BD.MM_REL_AMT END MM_REL_AMT ,  ap.app_name,bd.ifsc_code,rb.bank_name,rb.branchname,bbm.email as ");
qrysb.append(" BRANCHEMAIL from bank_dataentry bd, app_detail ap,  rbibanklist rb ,bank_br_mast bbm where pact_id=34    and ");
qrysb.append(" bd.app_id=ap.app_id  and rb.ifsc_code=bd.ifsc_code and rb.ifsc_code=bbm.br_ifsl_code  AND  bd.app_id=? and bd.IFSC_CODE=?  ");
qrysb.append(" UNION  ");
qrysb.append(" select bd.app_id, ");
qrysb.append(" substr(bd.app_id,instr(bd.app_id,'-')+1,length(bd.app_id)) appid_str, CASE WHEN BD.PBATCH_ID >= 563 THEN");
qrysb.append(" BD.MM_REL_AMT-500 ELSE  BD.MM_REL_AMT END MM_REL_AMT ,  ap.app_name,bd.ifsc_code,rb.bank_name,rb.branchname,bbm.email as ");
qrysb.append(" BRANCHEMAIL from bank_dataentry_second bd,app_detail_second ap,  rbibanklist rb ,bank_br_mast bbm where pact_id=34    and ");
qrysb.append(" bd.app_id=ap.app_id  and rb.ifsc_code=bd.ifsc_code and rb.ifsc_code=bbm.br_ifsl_code ");
qrysb.append(" AND  bd.app_id=? and bd.IFSC_CODE=?)p ");




ResultSet Mainrs = db.executeSQL(qrysb.toString(),values);

values.clear();

while (Mainrs.next()) {

TXNID=Mainrs.getString("TXNID")==null?"":Mainrs.getString("TXNID");
//APP_ID=Mainrs.getString("APP_ID")==null?"":Mainrs.getString("APP_ID");
MM_REL_AMT=Mainrs.getString("MM_REL_AMT")==null?"":Mainrs.getString("MM_REL_AMT");
APP_NAME=Mainrs.getString("APP_NAME")==null?"":Mainrs.getString("APP_NAME");
//IFSC_CODE=Mainrs.getString("IFSC_CODE")==null?"":Mainrs.getString("IFSC_CODE");
BANKNAME=Mainrs.getString("BANK_NAME")==null?"":Mainrs.getString("BANK_NAME");
BRANCHNAME=Mainrs.getString("BRANCHNAME")==null?"":Mainrs.getString("BRANCHNAME");
BRANCHEMAIL=Mainrs.getString("BRANCHEMAIL")==null?"":Mainrs.getString("BRANCHEMAIL");

}
Mainrs.close();

   if ((String)request.getParameter("ins")!=null){
 
    TXNID = request.getParameter("txnid")==null?"":(String) request.getParameter("txnid").trim();
    //APP_ID = request.getParameter("udf1")==null?"":(String) request.getParameter("udf1").trim();
    MM_REL_AMT = request.getParameter("amount")==null?"":(String) request.getParameter("amount").trim();
    APP_NAME = request.getParameter("firstname")==null?"":(String) request.getParameter("firstname").trim();
   // IFSC_CODE = request.getParameter("udf3")==null?"":(String) request.getParameter("udf3").trim();
    BANKNAME = request.getParameter("udf2")==null?"":(String) request.getParameter("udf2").trim();
    BRANCHNAME = request.getParameter("udf4")==null?"":(String) request.getParameter("udf4").trim();
  PRODUCTINFO = request.getParameter("productinfo")==null?"":(String) request.getParameter("productinfo").trim();
  EMAIL = request.getParameter("email")==null?"":(String) request.getParameter("email").trim();
  PHONE=request.getParameter("phone")==null?"":(String) request.getParameter("phone").trim();
	  UDF5=request.getParameter("udf5")==null?"":(String) request.getParameter("udf5").trim();
	 // sha512(key|txnid|amount|productinfo|firstname|email|udf1|udf2|udf3|udf4|udf5||||||SALT)
	 
	 SHACheckHash sh= new SHACheckHash();
	  
  String hash1="BHUZlo|"+TXNID+"|"+MM_REL_AMT+"|"+PRODUCTINFO+"|"+APP_NAME+"|"+EMAIL+"|"+APP_ID+"|"+BANKNAME+"|"+IFSC_CODE+"|"+BRANCHNAME+"|"+UDF5+"||||||MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCdZKRkWFJA/C8CtiveKRI8VIn+3G/mWLWawVzwQH7290C8digYXOZJmqNwHqnE2d+mmQq8qMfN1xcP1K+p/rUTimzrGem3QKrLNxfvd20wssSvNrmtk+AdJLNBzMYKf6OOO3tTZZydrNybgJdEvxwGSXWjjNW/CMeNyW1D1sCOed6VaVUi4YIqL9cy0lXqhT2+BRAJ/lDcDynR9rcuDA0Xl0C34QbbkKJMwWzbKMfRlcCtrvDO4ZSZ5zx606/s0W/TplvwW7MSf1wwMEYURWIGucfnYPIc4r3io+mpHRd55XZM4KsGXS/OIoawC+14pav1ZWlKUB8VB5MwAffoH/+VAgMBAAECggEAZyJLlnVJcMvPAjfdBvZivKWoxxgrOwVl+sI55DRe/fWGtfe2zkARpqlt70oodJVPuBsQrg7q3jbTJcx4TyxX+zX5qRSR0ULOp9qyFHhtVDvQJf/2K4d6k5442CUWoEqDIfBYH4210pwy8rKQbLvN4VDBhSoD5eoa2Q3kS0+tXa322xlEMQ6AMxz3/Fd9u/xz9rHUQ0B1/aD4EhnBjmdhcCFRACIbIeHt7QLOgjLteOIbAsmZpplA+tWwJt5KnjPlv1XuezkrjXpk/pYhOOxJV77XEjITjLXkq8GECDbQA0zRrcZ3mmIJOARuldrQAwX5AF8LcUoZ2NEljtMccpcgAQKBgQDJXYybGaz70o9U1d+N1AieTTVK8qZd/Htw4PrpOg7NabvkN3t8yZLAPdyyH27RigIz9U4mWIwBvEyL5l3uZloxw2dBRasj3NsOvcdNBL6Fwvzy0P7+iMPYzUx9tLGcnC5rMHxi7DT9msPdr4t94Hsw7uqSccRvjEP/wx1coilAtQKBgQDIGNzr9BwyBEgfBFfrc/5vchzFia0RaAY9Z+lf1fyU/94Gdcp6ySOPLeM65OwJ24NoQYHQR3xAuBSFG26X9eDmY9M+C72udF3NTEl/pcPj3vewXCVyQCFFaEkFRJHeelkQfAJjwd9+uxwLqLIwdzliME2/23gpaZrDTmpDG7BvYQKBgQCXE7r0ezUP0pB7I+OQM28r5d2AF8G+bjnnHMTjyw1kDFpOBVp+63VRCpjUg0TPrW2tsfQqTPDuNGpx5CrBPMWa5HJJxI18YK1xx+0J2e9fyEWjoC5QpifaN12WSsWfLIafIUeRqIqxYzZk0tojXRLQSdBwgy7QSjqSX79dysSMqQKBgQCpS+f3NwV4CAlhPNKKYwyeDEVtmMu2U3YcFEPvEuTuyAF5I8YZ1v5gEOoVlURkHrbyyaHkr+bf9x9dc1VB+wW6yDEdaN+mr8wBfA8fkgfIT4jvTTddkAbWa6KEc3ybaJbcjJ+U+Z534iWbc7K3sNf7THUr46uqFjCcGEdt2gqQYQKBgFVpmgw8cy4FwKqkb2naSjJpvHHl77TnqEuHE+n1owcH9tqkJUonTIZpo8A6DcPdAYVTnBMq+ky6MtCJy8ebzx7NzQbl1DuXvPiXoombUMfhvkkIqTdBdzV5N/rhy79pQRLBIvNDgkvhRXmwJiDx6KCIcW5U0hbZyoCE4cOEcjia";

String  hash= sh.sha512 (hash1);

 StringBuffer qryins = new StringBuffer();
qryins.append("  insert into indbank_request (rtimestamp_req,    "      );
qryins.append("  AMOUNT,    "      );
qryins.append("  EMAIL,    "      );
qryins.append("  FIRSTNAME,    "      );
qryins.append("  KEY,    "      );
qryins.append("  LASTNAME,    "      );
qryins.append("  PHONE,    "      );
qryins.append("  PRODUCTINFO,    "      );
qryins.append("  TXNID,    "      );
qryins.append("  UDF1,    "      );
qryins.append("  UDF2,    "      );
qryins.append("  UDF3,    "      );
qryins.append("  UDF4,    "      );
qryins.append("  UDF5,hash)    "      );
qryins.append("  select sysdate,p.mm_rel_amt,?,app_name,'BHUZlo','',?,?, (select lpad(nvl(count(*),0)+1,2,0) from indbank_request     "      );
qryins.append("  where substr(txnid,3,length(txnid))=appid_str)||appid_str  ,?,?,?,?,?,?    "      );
qryins.append("  from ( select bd.app_id,  substr(bd.app_id,instr(bd.app_id,'-')+1,    "      );
qryins.append("  length(bd.app_id)) appid_str, CASE WHEN BD.PBATCH_ID >= 563 THEN  BD.MM_REL_AMT-500 ELSE  BD.MM_REL_AMT END MM_REL_AMT ,ap.app_name,bd.ifsc_code,    "      );
qryins.append("  rb.bank_name,rb.branchname from bank_dataentry bd, app_detail ap,rbibanklist rb     "      );
qryins.append("  where pact_id=34  and bd.app_id=ap.app_id      "      );
qryins.append("  and rb.ifsc_code=bd.ifsc_code and bd.app_id=?  "      );
qryins.append("  UNION "      );
qryins.append("select bd.app_id,  substr(bd.app_id,instr(bd.app_id,'-')+1,    "      );
qryins.append("  length(bd.app_id)) appid_str, CASE WHEN BD.PBATCH_ID >= 563 THEN  BD.MM_REL_AMT-500 ELSE  BD.MM_REL_AMT END MM_REL_AMT ,ap.app_name,bd.ifsc_code,    "      );
qryins.append("  rb.bank_name,rb.branchname from bank_dataentry_second bd, app_detail_second ap,rbibanklist rb     "      );
qryins.append("  where pact_id=34  and bd.app_id=ap.app_id      "      );
qryins.append("  and rb.ifsc_code=bd.ifsc_code and bd.app_id=? "      );
qryins.append(" ) p  where (select lpad(nvl(count(*),0)+1,2,0) from indbank_request   "      );
qryins.append(" where substr(txnid,3,length(txnid))=appid_str)||appid_str not in (select indbank_request.txnid from indbank_request)  "      );

values.add(EMAIL); pstm.add ("L");
values.add(PHONE); pstm.add ("L");
values.add(PRODUCTINFO); pstm.add ("L");
values.add(APP_ID); pstm.add ("L");
values.add(BANKNAME); pstm.add ("L");
values.add(IFSC_CODE); pstm.add ("L");
values.add(BRANCHNAME); pstm.add ("L");
values.add(UDF5); pstm.add ("L");
values.add(hash); pstm.add ("L");
values.add(APP_ID); pstm.add ("L");
values.add(APP_ID); pstm.add ("L");

db.setSqlValue(qryins.toString());
db.setValues(values,pstm);
db.executeUpdate() ;

values.clear();
pstm.clear();

out.print (hash);
response.sendRedirect("payment_gateway_conf.jsp");
}

db.close();
 %>

  <table  border="1" align="center" >
  <tr>
    <th>Transaction Id : </th>
    <td ><input type="text" id="txnid" name="txnid" value="<%= TXNID %>" readonly="true" /></td>
	  <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>  
  <tr>
    <th>PMEGP e-portal Applicant Id : </th>
    <td ><input name="udf1" id="udf1" type="hidden" value="<%= APP_ID %>"   size="50"  readonly="true" />
	<input name="pg" id="pg" type="hidden" value="NEFT"  size="50"  readonly="true" />

        <%= APP_ID %></td>
    <th>Applicant's  Name :
	    <input name="lastname" id="lastname" type="hidden" value="<%= APP_NAME %>" />
          <input name="key" id="key" type="hidden" value="BHUZlo" /></th>
	  <td ><input name="firstname" id="firstname" type="hidden" value="<%= APP_NAME %>"  size="50" readonly="true" />
	      <%= APP_NAME %></td>
  </tr>
  <tr>
    <th>Margin Money Refund Amount : </th>
    <td ><input type="HIDDEN" name="amount" id="amount" value="<%= MM_REL_AMT %>"   size="50" readonly="true" />Rs. <%= MM_REL_AMT %> /-</td>
	  <th>Financing Branch IFSC Code : </th>
	  <td ><input name="udf3" id="udf3" type="hidden" value="<%= IFSC_CODE %>"   size="50"  readonly="true" />
          <%= IFSC_CODE %></td>
  </tr>
  <tr>
    <th colspan="4" ><div align="center">
         
      <input type="radio" id="RADIO" name="RADIO" value="R"  checked="checked"  >  
      Margin Money Refund 
      <input name="productinfo" id="productinfo" type="HIDDEN" value="Margin Money Refund" />
    </div></th>
    </tr>
  
  <tr>
    <th>Financing Bank Name : </th>
    <td><input name="udf2" id="udf2" type="HIDDEN" value="<%= BANKNAME %>"   size="50"  readonly="true" /><%= BANKNAME %></td>
    <th>Branch Name :</th>
    <td ><input name="udf4" id="udf4" type="hidden" value="<%= BRANCHNAME %>"  size="50"  readonly="true" />
        <%= BRANCHNAME %></td>
  </tr>
  
  <tr>
    <th>Branch Manager Mobile No. *:</th>
    <td ><input type="text" id="phone" name="phone" value=""   size="50" maxlength="10" /></td>
	  <th>Branch Manager Email Id *: </th>
	  <td ><input type="text" name="email" id="email" value="<%=BRANCHEMAIL%>"  size="50" maxlength="50" /></td>
  </tr>
    
  <tr>
    <th>Financing Branch Remark : </th>
    <td colspan="3" >
	<textarea id="udf5" name="udf5" rows="5"  cols="50" maxlength="100"></textarea>	</td>
    </tr>
  <tr>
    <td colspan="4" ><div align="center">
	<%// if(SVC.equals("0") || SVC.equals("")){ %>
      <input type="button" onclick="ValidateForm();" name="button" id="button" value="Submit"  />
	  <%//}%>
    </div></td>
    </tr>
</table>
<div id="GETPRODUCTLIST"></div>
<div id="GETPRODUCTLIST1"></div>


<input name="surl" type="hidden" value="succes.jsp" />
<input name="furl" type="hidden" value="fail.jsp" />
<input name="curl" type="hidden" value="curl.jsp" />
</form>
</body>
</html>
