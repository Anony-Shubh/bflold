<%@ page import = "java.sql.*,java.nio.charset.StandardCharsets,java.util.Base64,javax.crypto.*,java.security.*,com.toml.dp.util.*,java.lang.reflect.Array,pkgPmegpNew.DBCon,java.util.*" %>
<HTML>
<META name="viewport" content="width=device-width, initial-scale=1">
<HEAD>
<TITLE>sbiepay PMEGP Covid page</TITLE>

<LINK rel="stylesheet" type="text/css" href="css/main1.css">
   
   <BODY>
    <P><IMG src="images/04_01.png" width="100%" alt="img">  </P>
<FORM>
<%
String showrecv="N";
String encData=request.getParameter("encData")==null?"":(String) request.getParameter("encData");

String merchIdVal=request.getParameter("merchIdVal")==null?"11009":(String) request.getParameter("merchIdVal");
String MERCHANTORDERNO="0";

AES128Bit enc =new AES128Bit();


 String datafieldDelimited="MERCHANTORDERNO|SBIEPAYREFERENCEID|STATUS|AMOUNT|CURRENCY|PAYMODE|OTHERDETAILS|REASON|BANKCODE|BANKREFERENCENUMBER|TRANSACTIONDATE|COUNTRY|CIN|REF1|REF2|REF3|REF4|REF5|REF6|REF7|REF8|REF9|REF10|CUSTMERID";

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
    
 if ( y.equals("MERCHANTORDERNO")) {
     wh=" WHERE COVDONID="+(String) Array.get(array, i)+"";
     }



 if ( y.equals("MERCHANTORDERNO")) {
     MERCHANTORDERNO=(String) Array.get(array, i);
     }



     if ( y.equals("TRANSACTIONDATE")) {
     x="TO_DATE('"+(String) Array.get(array, i)+"','RRRR-MM-DD HH24:MI:SS')"+",";
     }
     
      if (y.equals("CUSTMERID")) {
     x="'"+(String) Array.get(array, i)+"'";
     }
     finalqry=finalqry+y+" ="+x;
     
         //   System.out.print(y+" ="+x ); 
        } //end of for loop
        
        finalqry="UPDATE ACOVID_DONATION_TRANS SET  "+finalqry+"  DBUPDAT_DT=SYSDATE "+wh;
     
     //  out.print(finalqry); 
	   
	  // out.print("<br><br>"); 
	// out.print(MERCHANTORDERNO);
	   
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
String APP_NAME="";
String COVDONID="";

String MOB_NO="";

String STATUS="";
String SBIEPAYREFERENCEID="";
String TRANSACTIONDATE="";
String ADDL_CHARGES="";
String AMOUNT="";

String E_MAIL="";

StringBuffer qry = new StringBuffer();
qry.append("SELECT ADT.COVDONID, ");
qry.append(" ADT.APP_NAME, ");
  qry.append("ADT.MOB_NO,");
 qry.append(" ADT.E_MAIL,");
  qry.append("ADT.AMOUNT,");
 qry.append(" ADT.STATUS,");
  qry.append("  ADT.SBIEPAYREFERENCEID,");
  qry.append(" ADT.REF2 AS ADDL_CHARGES,");
 qry.append("  TO_CHAR( ADT.TRANSACTIONDATE,'DD-MON-RRRR HH:MI') AS TRANSACTIONDATE");
qry.append("  FROM ACOVID_DONATION_TRANS ADT");
qry.append(" WHERE ADT.COVDONID = ?");

values.add(MERCHANTORDERNO);
ResultSet rsMain = db.executeSQL(qry.toString(),values);

while (rsMain.next()){
APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
MOB_NO =rsMain.getString("MOB_NO")==null?"":rsMain.getString("MOB_NO");

 COVDONID=rsMain.getString("COVDONID")==null?"":rsMain.getString("COVDONID");
AMOUNT=rsMain.getString("AMOUNT")==null?"":rsMain.getString("AMOUNT");
 //E_MAIL=rsMain.getString("E_MAIL")==null?"":rsMain.getString("E_MAIL");
  STATUS=rsMain.getString("STATUS")==null?"":rsMain.getString("STATUS");
  SBIEPAYREFERENCEID=rsMain.getString("SBIEPAYREFERENCEID")==null?"":rsMain.getString("SBIEPAYREFERENCEID");
 TRANSACTIONDATE=rsMain.getString("TRANSACTIONDATE")==null?"":rsMain.getString("TRANSACTIONDATE");
 ADDL_CHARGES=rsMain.getString("ADDL_CHARGES")==null?"":rsMain.getString("ADDL_CHARGES");



}
rsMain.close();
db.close();

%>
 <DIV align="center"><IMG src="images/YbIni.png" alt="img" width="12%" height="133">	</DIV>

<TABLE border="1" align="center" id="customers" width="50%">
  <TR>
    <TH colspan="2"><DIV align="center">Payment Receipt of KVIC COVID19 FUND Donation </DIV></TH>
    </TR>
  <TR>
    <TD><DIV align="left">KVIC Tranasction No </DIV></TD>
    <TD><H2>PMEGPCOVID- <%= COVDONID %> </H2></TD>
  </TR>
  <TR>
    <TD><DIV align="left">Scheme Name </DIV></TD>
    <TD>KVIC COVID19 FUND Donation </TD>
  </TR>
  <TR>
    <TD><DIV align="left">Name</DIV></TD>
    <TD><%= APP_NAME %></TD>
  </TR>
  <TR>
    <TD><DIV align="left">Mobile No.</DIV></TD>
    <TD><%= MOB_NO %></TD>
  </TR>
  
  <TR>
    <TD><DIV align="left">Donation Amount</DIV></TD>
    <TD><%= AMOUNT %></TD>
  </TR>
  <TR>
    <TD><DIV align="left">Transation Status</DIV></TD>
    <TD><h2><%= STATUS %> <h2></TD>
  </TR>
  <TR>
    <TD><DIV align="left">Transation Date</DIV></TD>
    <TD><%= TRANSACTIONDATE %></TD>
  </TR>
  <TR>
    <TD><DIV align="left">ePay ID </DIV></TD>
    <TD><%= SBIEPAYREFERENCEID %></TD>
  </TR>
  
  <TR>
    <TD><DIV align="left">Addl. Bank Charges </DIV></TD>
    <TD><%= ADDL_CHARGES %></TD>
  </TR>
</TABLE>
<% } %>
</FORM>
</BODY>
</HTML>