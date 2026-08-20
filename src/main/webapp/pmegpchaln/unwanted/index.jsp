<%@ page session="true"  import="java.sql.*,java.util.*,java.text.*,pmegpchallan.pmegpchallanForView"  %>
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
    <span class="style1">PMEGP E- Challan Verify Status</span>
	<br>
<%	
/*
 String APP_ID=request.getParameter("APP_ID")==null?"KVUP16177039-13476061": (String) request.getParameter("APP_ID"); 
 
 if (APP_ID !="") {
DBCon db= new DBCon();
db.connect();

 List values=new ArrayList();	
 values.add(APP_ID);
String PTXNID="";
ResultSet Mainrs=db.executeSQL("select LISTAGG(txnid,'|') WITHIN GROUP(ORDER BY txnid) as TXNID from indbank_request WHERE UDF1=?",values);



while (Mainrs.next()) {

PTXNID=Mainrs.getString("TXNID")==null?"":Mainrs.getString("TXNID");

}
Mainrs.close();
db.close();
out.print (PTXNID);
*/
String PTXNID="021315651|011315651|021347606|031347606";
pmegpchallanForView pcfv=new pmegpchallanForView();
		String result=pcfv.pmegpchallanID(PTXNID);
		pcfv=null;
		out.print (result);
		
//} 

%>
   
 </form>
</body>
</html>
