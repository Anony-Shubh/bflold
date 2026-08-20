
<%@ page session="true" buffer="500kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon,org.apache.commons.codec.binary.*,java.io.FileInputStream,java.security.MessageDigest"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>PMEGP</title>

<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<SCRIPT src="../js/sweetalert.min.js"></SCRIPT>

<SCRIPT>

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

<body onload="checkradio('C');showqry();">
<form name="form" action='https://secure.payu.in/_payment' method='post' onSubmit="return ValidateForm();">

  <div align="center"><img src="pmegponline.jpg" width="100%" height="150" >
    <BR>
    <BR>
    <span class="style1">Verify PMEGP E- Challan</span>
	<br> 
		 
    <%
	String APP_ID =session.getAttribute("SAPPID")==null?"": (String)session.getAttribute("SAPPID");
    String IFSC_CODE=session.getAttribute("bank_id")==null?"": (String)session.getAttribute("bank_id");


String TXNID="";
String FIRSTNAME="";
String LASTNAME="";
String KEY="";
String AMOUNT="";
String PRODUCTINFO="";
String PHONE="";
String EMAIL="";
String UDF1="";
String UDF2="";
String UDF3="";
String UDF4="";
String UDF5="";
String HASH="";

%>
    <CENTER>
    <input name="APP_ID" type="HIDDEN" id="APP_ID" value="<%= APP_ID %>" size="100" maxlength="30">
    <BR>
  
   
    <%
DBCon db= new DBCon();
db.connect();

String BRANCHEMAIL="";
   List values=new ArrayList();	
    List pstm=new ArrayList();


	  values.add(APP_ID);
	  values.add(APP_ID);
	  values.add(APP_ID);


ResultSet Mainrs=db.executeSQL(" SELECT * FROM (SELECT TXNID, FIRSTNAME, LASTNAME, KEY, AMOUNT, PRODUCTINFO, PHONE, EMAIL, UDF1, UDF2, UDF3, UDF4, UDF5, HASH FROM INDBANK_REQUEST WHERE SUBSTR(TXNID,3,LENGTH(TXNID)) =substr(?,instr(?,'-')+1,length(?))  ORDER BY TXNID DESC) WHERE ROWNUM=1 ",values);

values.clear();

while (Mainrs.next()) {

TXNID=Mainrs.getString("TXNID")==null?"":Mainrs.getString("TXNID");
FIRSTNAME=Mainrs.getString("FIRSTNAME")==null?"":Mainrs.getString("FIRSTNAME");
LASTNAME=Mainrs.getString("LASTNAME")==null?"":Mainrs.getString("LASTNAME");
KEY=Mainrs.getString("KEY")==null?"":Mainrs.getString("KEY");
AMOUNT=Mainrs.getString("AMOUNT")==null?"":Mainrs.getString("AMOUNT");
PRODUCTINFO=Mainrs.getString("PRODUCTINFO")==null?"":Mainrs.getString("PRODUCTINFO");
PHONE=Mainrs.getString("PHONE")==null?"":Mainrs.getString("PHONE");
EMAIL=Mainrs.getString("EMAIL")==null?"":Mainrs.getString("EMAIL");
UDF1=Mainrs.getString("UDF1")==null?"":Mainrs.getString("UDF1");
UDF2=Mainrs.getString("UDF2")==null?"":Mainrs.getString("UDF2");
UDF3=Mainrs.getString("UDF3")==null?"":Mainrs.getString("UDF3");
UDF4=Mainrs.getString("UDF4")==null?"":Mainrs.getString("UDF4");
UDF5=Mainrs.getString("UDF5")==null?"":Mainrs.getString("UDF5");
HASH=Mainrs.getString("HASH")==null?"":Mainrs.getString("HASH");
}
Mainrs.close();
db.close();
 %>
<table  border="1" align="center" width="60%">
  <tr>
    <th>Transaction Id : </th>
    <td ><input type="HIDDEN" id="txnid" name="txnid" value="<%= TXNID %>" readonly="true" /><%= TXNID %></td>
	  <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>  
  <tr>
    <th>PMEGP e-portal Applicant Id : </th>
    <td ><input name="udf1" id="udf1" type="hidden" value="<%= APP_ID %>"   size="100"  readonly="true" />
	<input name="pg" id="pg" type="hidden" value="NEFT"  size="100"  readonly="true" />

        <%= APP_ID %></td>
    <th>Applicant's  Name :
	    <input name="lastname" id="lastname" type="hidden" value="<%= LASTNAME %>" />
          <input name="key" id="key" type="hidden" value="BHUZlo" /></th>
	  <td ><input name="firstname" id="firstname" type="hidden" value="<%= FIRSTNAME %>"  size="100" readonly="true" />
	      <%= FIRSTNAME %></td>
  </tr>
  <tr>
    <th>Margin Money Refund Amount : </th>
    <td ><input type="HIDDEN" name="amount" id="amount" value="<%= AMOUNT %>"   size="100" readonly="true" />Rs. <%= AMOUNT %> /-</td>
	  <th>Financing Branch IFSC Code : </th>
	  <td ><input name="udf3" id="udf3" type="hidden" value="<%= UDF3 %>"   size="100"  readonly="true" />
          <%= UDF3 %></td>
  </tr>
  <tr>
    <th colspan="4" ><div align="center">
         <%= PRODUCTINFO %>
      <input name="productinfo" id="productinfo" type="HIDDEN" value="<%= PRODUCTINFO %>" />
    </div></th>
    </tr>
  
  <tr>
    <th>Financing Bank Name : </th>
    <td><input name="udf2" id="udf2" type="HIDDEN" value="<%= UDF2 %>"   size="100"  readonly="true" /><%= UDF2 %></td>
    <th>Branch Name :</th>
    <td ><input name="udf4" id="udf4" type="hidden" value="<%= UDF4 %>"  size="100"  readonly="true" />
        <%= UDF4 %></td>
  </tr>
  
  <tr>
    <th>Branch Manager Mobile No. *:</th>
    <td ><input name="phone" type="hidden" id="phone"  value="<%= PHONE %>" /><%= PHONE %></td>
	  <th>Branch Manager Email Id *: </th>
	  <td ><input name="email" type="hidden" id="email" value="<%=EMAIL%>" /><%= EMAIL %></td>
  </tr>
    
  <tr>
    <th>Financing Branch Remark : </th>
    <td colspan="3" ><input name="udf5" type="hidden" id="udf5"  value="<%=UDF5%>" />
	<input name="hash" type="HIDDEN" id="hash"  value="<%=HASH%>" />
	<%= UDF5 %></td>
    </tr>
  <tr>
    <td colspan="4" ><div align="center">
	<%// if(SVC.equals("0") || SVC.equals("")){ %>
      <input type="submit" name="submit" id="submit" value="Confirm"  />
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