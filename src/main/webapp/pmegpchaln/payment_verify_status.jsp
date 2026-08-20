<%@ page session="true"  import="java.sql.*,java.util.*,java.text.*,pmegpchallan.pmegpchallanForView,pkgPmegpNew.DBCon"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>PMEGP</title>
</style>
</head>
<body>
<form name="form" method='post'>

  <div align="center"><img src="pmegponline.jpg" width="100%" height="150" >
    <BR>
    <BR>
    <span class="style1">PMEGP E- Challan Verify Status  &nbsp;&nbsp;&nbsp;<A href="../bankModule/BankPv.jsp" class="button" >BACK</A></span>
	<br>
	<br>
<%	

String APP_ID = (String)session.getAttribute("SAPPID");
 DBCon db= new DBCon();
db.connect();

 List values=new ArrayList();	
 if (APP_ID !="") {

 values.add(APP_ID);
String PTXNID="";
ResultSet Mainrs=db.executeSQL("select LISTAGG(txnid,'|') WITHIN GROUP(ORDER BY txnid) as TXNID from indbank_request WHERE UDF1=?",values);



while (Mainrs.next()) {

PTXNID=Mainrs.getString("TXNID")==null?"":Mainrs.getString("TXNID");

}
Mainrs.close();



pmegpchallanForView pcfv=new pmegpchallanForView();
		String result=pcfv.pmegpchallanID(PTXNID);
		pcfv=null;
		//out.print (result);
		
	 Connection conn = null;
	try{
	
Class.forName("oracle.jdbc.OracleDriver");
conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.50.86:1521:iasdb", "pmegpnew", "pmegp_1239");

CallableStatement cs = conn.prepareCall("{call  PROC_INDBANK_PAYMENT_INS(1) }");
cs.execute();

}catch(Exception e){
out.print(e.toString());
}	
		
} 



%>
<table width="100%" border="2">
  <tr>
    <th>Sr no. </th>
    <th>Transaction Id </th>
    <th>First name</th>
    <th>Amount</th>
    <th>Bank name</th>
    <th>IFSC</th>
    <th>Branchname</th>
    <th>Error message </th>
    <th>Status</th>
    <th>Requested On </th>
    </tr>
<%

String PTRANSACTIONID="";
String AMT="";
String FIRST_NAME="";
String BANKNAME="";
String IFSC="";
String BRANCHNAME="";
String ERROR_MESSAGE="";
String STATUS="";
String RTIMESTAMP_REQ="";
String SRNO="";

   values.clear();

 values.add(APP_ID);

ResultSet Mainrs1=db.executeSQL(" select rownum srno,transactionid,amt,first_name,udf1_resp app_id,udf2_resp bankname,udf3_resp ifsc,udf4_resp branchname,error_message,status,rtimestamp_req from indbank_request where udf1 =?  AND  UPPER(STATUS) NOT IN ('NOT FOUND' ,'FAILURE')   ",values);

while (Mainrs1.next()) {
SRNO=Mainrs1.getString("SRNO")==null?"":Mainrs1.getString("SRNO");
PTRANSACTIONID=Mainrs1.getString("TRANSACTIONID")==null?"":Mainrs1.getString("TRANSACTIONID");
AMT=Mainrs1.getString("AMT")==null?"":Mainrs1.getString("AMT");
FIRST_NAME=Mainrs1.getString("FIRST_NAME")==null?"":Mainrs1.getString("FIRST_NAME");
BANKNAME=Mainrs1.getString("BANKNAME")==null?"":Mainrs1.getString("BANKNAME");
IFSC=Mainrs1.getString("IFSC")==null?"":Mainrs1.getString("IFSC");
BRANCHNAME=Mainrs1.getString("BRANCHNAME")==null?"":Mainrs1.getString("BRANCHNAME");
ERROR_MESSAGE=Mainrs1.getString("ERROR_MESSAGE")==null?"":Mainrs1.getString("ERROR_MESSAGE");
STATUS=Mainrs1.getString("STATUS")==null?"":Mainrs1.getString("STATUS");
RTIMESTAMP_REQ=Mainrs1.getString("RTIMESTAMP_REQ")==null?"":Mainrs1.getString("RTIMESTAMP_REQ");

%>

    <tr>
    <td><%= SRNO %></td>
    <td><%= PTRANSACTIONID %></td>
    <td><%= FIRST_NAME %></td>
    <td><%= AMT %></td>
    <td><%= BANKNAME %></td>
    <td><%= IFSC %></td>
    <td><%= BRANCHNAME %></td>
    <td><%= ERROR_MESSAGE %></td>
    <td><%= STATUS %></td>
    <td><%= RTIMESTAMP_REQ %></td>
    </tr>
	
  <%
  }
Mainrs1.close();
db.close();

  %>
</table>
   
</form>
</body>
</html>




