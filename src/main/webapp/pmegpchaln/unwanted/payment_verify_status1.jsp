<%@ page session="true" buffer="500kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon,pmegp.challanjsonMain,pmegp.testpayuapi,pmegp.SHACheckHash,org.apache.commons.codec.binary.*,java.io.FileInputStream,java.security.MessageDigest,org.apache.http.HttpResponse,org.apache.http.client.methods.HttpPost,org.apache.http.entity.StringEntity,org.apache.http.impl.client.DefaultHttpClient,org.apache.http.util.EntityUtils"  %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>PMEGP</title>

<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<SCRIPT src="sweetalert.min.js"></SCRIPT>

<style type="text/css">

.style1 {
	font-size: 18px;
	font-weight: bold;
}

</style>
</head>

<body onload="checkradio('C');showqry();">
<form name="form" method='post' onSubmit="return ValidateForm();">
<%@ include file = "responseheaderinclude.jsp" %>

  <div align="center"><img src="pmegponline.jpg" width="100%" height="150" >
    <BR>
    <BR>
    <span class="style1">PMEGP E- Challan Verify Status</span>
	<br>
<%	

 String APP_ID=request.getParameter("APP_ID")==null?"": (String) request.getParameter("APP_ID"); 
DBCon db= new DBCon();
db.connect();

String BRANCHEMAIL="";
   List values=new ArrayList();	
    List pstm=new ArrayList();


	  values.add(APP_ID);
 values.add(APP_ID);
 values.add(APP_ID);


String PTXNID="";
ResultSet Mainrs=db.executeSQL(" select LISTAGG(         txnid,         '|'      ) WITHIN GROUP(     ORDER BY         txnid     ) as TXNID from indbank_request where  substr(txnid,3,length(txnid))=substr(?,instr(?,'-')+1,length(?))  and trunc(SYSTIMESTAMP) BETWEEN trunc(rtimestamp_req) AND trunc(rtimestamp_req)+7   ",values);

values.clear();

while (Mainrs.next()) {

PTXNID=Mainrs.getString("TXNID")==null?"":Mainrs.getString("TXNID");

}
Mainrs.close();
db.close();

String result="";
 
  /*
 StringBuffer qryUpdate = new StringBuffer();

qryUpdate.append("DELETE FROM INDBANKPAY_RESPONSE_TEMP");

db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate();
values.clear();
pstm.clear();
  */

  
 try{
 
 
String aresult="";

int bresult=0;
testpayuapi api=new testpayuapi();
aresult=api.requestapi(PTXNID);

challanjsonMain apiu=new challanjsonMain();
bresult=apiu.paymentstatusverify(aresult);

out.print(aresult);

  Connection conn = null;
	try{
	
Class.forName("oracle.jdbc.OracleDriver");
conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.50.86:1521:iasdb", "pmegpnew", "pmegp123");

CallableStatement cs = conn.prepareCall("{call  PROC_INDBANK_PAYMENT_INS(1) }");
//cs.execute();

}catch(Exception e){
out.print(e.toString());
}
}catch(Exception e){ 
out.print(e.toString()+"Can't get the response from api,please verify");
	}
//out.print (ptxnid);
	
	//  out.print (vhash);
 %>
  
    <CENTER>
    
    <BR>
  
</form>
</body>
</html>
