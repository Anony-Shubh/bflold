<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="in.gov.mgov.SMSServices"%>
<%@ page import="pkgPmegpNew.DBCon"%>
<%@ page import="java.nio.charset.StandardCharsets"%>
<%@ page import="java.util.Base64"%>
<%@ page import="javax.crypto.*"%>
<%@ page import="java.security.*"%>
<%@ page import="com.toml.dp.util.*"%>
<%@ page import="java.lang.reflect.Array"%>

<HTML>
<META name="viewport" content="width=device-width, initial-scale=1">
<STYLE type="text/css">
<!--
.style1 {
	font-size: 18px;
	font-weight: bold;
}
.style2a {color: #FF0000}
-->
</STYLE>
<HEAD>
<TITLE>sbiepay</TITLE>

<LINK rel="stylesheet" type="text/css" href="css/main1.css">
 <LINK href="bootstrap/css/bootstrap.min.css" rel="stylesheet">      
  
   <BODY>
<%@ include file = "headerfile.jsp" %>  
<DIV id="wrapper" class="container">
<BR>
<FORM>
<%

String showrecv="N";
String encData=request.getParameter("encData")==null?"":(String) request.getParameter("encData");

String merchIdVal=request.getParameter("merchIdVal")==null?"11009":(String) request.getParameter("merchIdVal");
String MERCHANTORDERNO="0";

AES128Bit enc =new AES128Bit();


 String datafieldDelimited="MERCHANT_ORDER_NO|SBIE_PAYREF_ID|STATUS|AMOUNT|CURRENCY|PAYMODE|OTHER_DETAILS|REASON|BANKCODE|BANK_REFERENCE_NUMBER|TRANSACTION_DATE|COUNTRY|CIN|MERCHANTID|OTHBANKCHARGES";

       String pipeDelimited = enc.decrypt(encData,"NXumfcvGR4y70vDyhsRpyA==");
	  
    String[] array = pipeDelimited.split("|");
     String [] arraydf=datafieldDelimited.split("|");
      
    array = pipeDelimited.split("\\|");
     arraydf = datafieldDelimited.split("\\|");

  
     
   String finalqry="";
     String wh=""; 

    
     for (int i = 0; i < array.length; i++) { 
      String y = (String) Array.get(arraydf, i); 
      String x = "'"+(String) Array.get(array, i)+"'"+",";
    
 if ( y.equals("MERCHANT_ORDER_NO")) {
     wh=" WHERE custid="+(String) Array.get(array, i)+"";
     }



 if ( y.equals("MERCHANT_ORDER_NO")) {
     MERCHANTORDERNO=(String) Array.get(array, i);
     }



     if ( y.equals("TRANSACTION_DATE")) {
     x="TO_DATE('"+(String) Array.get(array, i)+"','RRRR-MM-DD HH24:MI:SS')"+",";
     }
     
      if (y.equals("CUSTMERID")) {
     x="'"+(String) Array.get(array, i)+"'";
     }
     finalqry=finalqry+y+" ="+x;
     
        } //end of for loop
        
        finalqry="UPDATE ecom_cust SET  "+finalqry+"  RTIMESTAMP=SYSDATE "+wh;
   //  out.print(finalqry);
	List pstm=new ArrayList();
List values=new ArrayList();   
DBCon db= new DBCon();
db.connect();
   
   try {
  


     db.setSqlValue(finalqry);
db.setValues(values,pstm);
db.executeUpdate();

showrecv="Y";

}catch (Exception e){
  // out.print("<br><br>"); 
   showrecv="N";
out.print (e.toString());
}

if (showrecv.equals("Y")) {
String CUSTNAME="";
String CUSTID="";

String MOBILE="";

String STATUS="";
String SBIE_PAYREF_ID="";
String TRANSACTIONDATE="";
String ADDL_CHARGES="";
String AMOUNT="";

String E_MAIL="";

StringBuffer qry = new StringBuffer();
qry.append("SELECT ADT.custid,  ");
qry.append(" ADT.CUSTNAME,  ");
qry.append("  ADT.MOBILE, ");
qry.append("  ADT.EMAIL, ");
qry.append("  ADT.AMOUNT, ");
qry.append("  ADT.STATUS, ");
qry.append("    ADT.SBIE_PAYREF_ID, ");
qry.append("   ADT.OTHBANKCHARGES AS ADDL_CHARGES, ");
qry.append("   TO_CHAR( ADT.TRANSACTION_DATE,'DD-MON-RRRR HH:MI:SS') AS TRANSACTIONDATE ");
qry.append("  FROM ECOM_CUST ADT ");
qry.append(" WHERE ADT.custid = ? ");

values.add(MERCHANTORDERNO);
ResultSet rsMain = db.executeSQL(qry.toString(),values);

int count=0;

while (rsMain.next()){
CUSTNAME=rsMain.getString("CUSTNAME")==null?"":rsMain.getString("CUSTNAME");
MOBILE =rsMain.getString("MOBILE")==null?"":rsMain.getString("MOBILE");

 CUSTID=rsMain.getString("CUSTID")==null?"":rsMain.getString("CUSTID");
AMOUNT=rsMain.getString("AMOUNT")==null?"":rsMain.getString("AMOUNT");
 //E_MAIL=rsMain.getString("E_MAIL")==null?"":rsMain.getString("E_MAIL");
  STATUS=rsMain.getString("STATUS")==null?"":rsMain.getString("STATUS");
  SBIE_PAYREF_ID=rsMain.getString("SBIE_PAYREF_ID")==null?"":rsMain.getString("SBIE_PAYREF_ID");
 TRANSACTIONDATE=rsMain.getString("TRANSACTIONDATE")==null?"":rsMain.getString("TRANSACTIONDATE");
 ADDL_CHARGES=rsMain.getString("ADDL_CHARGES")==null?"":rsMain.getString("ADDL_CHARGES");

count=count+1;

}
rsMain.close();
db.close();
session.invalidate();  
     
%>

<DIV align="center">
Note : Incase of any error during transaction. PLease wait for 72 hours before initiating a new transaction. <BR>
<SPAN class="style2a">Note : Please don't use refresh or back button</SPAN></DIV>
<DIV style="overflow-x:auto;">  
<TABLE width="50%" align="center" cellpadding="5" cellspacing="5"  >
  <TR>
    <TD colspan="2"><DIV align="center" class="style1">Transaction Status : Failed ! <IMG src="images/fail.png" width="90"></DIV></TD>
    </TR>
  <TR>
    <TD colspan="2"><DIV align="center"><H2>KHADI MASK</H2></DIV></TD>
    </TR>
  <TR>
    <TD><DIV align="left"><STRONG>KVIC Order No. </STRONG></DIV></TD>
    <TD><H2><STRONG><%= CUSTID %> </STRONG></H2></TD>
  </TR>
  
  <TR>
    <TD><DIV align="left"><STRONG>Name</STRONG></DIV></TD>
    <TD><STRONG><%= CUSTNAME %></STRONG></TD>
  </TR>
  <TR>
    <TD><DIV align="left"><STRONG>Mobile No.</STRONG></DIV></TD>
    <TD><STRONG><%= MOBILE %></STRONG></TD>
  </TR>
  
  <TR>
    <TD><DIV align="left"><STRONG> Amount</STRONG></DIV></TD>
    <TD><STRONG>Rs. <%= AMOUNT %></STRONG></TD>
  </TR>
  <TR>
    <TD><DIV align="left"><STRONG>Transation Status</STRONG></DIV></TD>
    <TD><STRONG><%= STATUS %> 
     
    </STRONG></TD>
  </TR>
  <TR>
    <TD><DIV align="left"><STRONG>Transation Date</STRONG></DIV></TD>
    <TD><STRONG><%= TRANSACTIONDATE %></STRONG></TD>
  </TR>
  <TR>
    <TD><DIV align="left"><STRONG>ePay ID </STRONG></DIV></TD>
    <TD><STRONG><%= SBIE_PAYREF_ID %></STRONG></TD>
  </TR>
  
  <TR>
    <TD><DIV align="left"><STRONG>Additional Bank Charges </STRONG></DIV></TD>
    <TD><STRONG><%= ADDL_CHARGES %></STRONG></TD>
  </TR>
  <TR>
    <TD colspan="2" align="center"><A href="prodouctsgrps.jsp">Shop More</A></TD>
    </TR>
</TABLE>
</DIV>
<% } %>
</FORM>

 <DIV style="padding-top: 80px">                
<DIV style="border: 0px; background-color: #48c4a0; height: 85px" class="card mb-3">
  <DIV class="card-body"><P align="center" style="font-size: 12px;font-weight: 100;color: white;padding-top: 16px;" >@ 2020 KVIC. All rights reserved | Developed by KVIC.</P>  </DIV> 
</DIV>
 </DIV>           
      

</DIV>
</BODY>
</HTML>