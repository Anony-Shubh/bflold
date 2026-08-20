<%@ page import = "java.nio.charset.StandardCharsets,java.util.Base64,javax.crypto.*,java.security.*,com.toml.dp.util.*,java.util.Random,pkgPmegpNew.DBCon,java.util.*,java.sql.*" %>


<HTML>
   <HEAD>
      <TITLE>paymentconfirmation payment</TITLE>
	  <LINK rel="stylesheet" type="text/css" href="css/main1.css">

      <STYLE type="text/css">
<!--
.style1 {color: #FF0000}
-->
      </STYLE>
</HEAD>
   
   <BODY>
    <P><IMG src="images/04_01.png" width="100%" alt="img">  </P>
   <FORM name="pay" method="post" action="https://www.sbiepay.com/secure/AggregatorHostedListener">
      <CENTER>
                   <P>
                     <%

String COVDONID=(String) request.getParameter("COVDONID")==null?"0":(String) request.getParameter("COVDONID").trim();
String APP_ID="";
String APP_PRIX="";
String APP_NAME="";
String UNIT_NAME="";
String MOB_NO="";
String E_MAIL="";
String APP_POST_ADDR="";
String PINCODE="";
String STATE_CD="";
String AMOUNT="";

DBCon db= new DBCon();
db.connect();

List values=new ArrayList();

StringBuffer qrysb = new StringBuffer();
qrysb.append("SELECT * FROM ACOVID_DONATION_TRANS where  COVDONID=? ");


values.add(COVDONID);
ResultSet rsMain = db.executeSQL(qrysb.toString(),values);

while (rsMain.next()){
APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
MOB_NO =rsMain.getString("MOB_NO")==null?"":rsMain.getString("MOB_NO");

 APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");

 UNIT_NAME=rsMain.getString("UNIT_NAME")==null?"":rsMain.getString("UNIT_NAME");
 E_MAIL=rsMain.getString("E_MAIL")==null?"":rsMain.getString("E_MAIL");
 APP_POST_ADDR=rsMain.getString("APP_POST_ADDR")==null?"":rsMain.getString("APP_POST_ADDR");
 PINCODE=rsMain.getString("PINCODE")==null?"":rsMain.getString("PINCODE");
 STATE_CD=rsMain.getString("STATE_CD")==null?"":rsMain.getString("STATE_CD");
AMOUNT=rsMain.getString("AMOUNT")==null?"":rsMain.getString("AMOUNT");


}
rsMain.close();
db.close();
String a="";
if (!APP_NAME.equals("")) {
AES128Bit enc =new AES128Bit();

 a =enc.encrypt("1000919|DOM|IN|INR|1.00|"+APP_NAME+MOB_NO+"|https://www.kviconline.gov.in/pmegpcovid/success.jsp|https://www.kviconline.gov.in/pmegpcovid/fail.jsp|SBIEPAY|"+COVDONID+"|12345|NB|ONLINE|ONLINE","NXumfcvGR4y70vDyhsRpyA==")	;

}


%>
        </P>
                   </p>
                   <TABLE border="1" id="customers" >
                     <TR>
                       <TH colspan="4"><DIV align="center">KVIC COVID19 DONATION PAYMENT CONFIRMATION PAGE 
		 
		                   <INPUT type="hidden" id="EncryptTrans" name="EncryptTrans" value="<%= a %>">
                           <INPUT type="hidden" id="merchIdVal" name="merchIdVal" value="1000919">
</DIV></TH>
                     </TR>
                     <TR>
                       <TH colspan="4"><DIV align="center">Note: In case of any error during transaction. Please wait for 72 hours before initiating a new transaction. </DIV></TH>
                     </TR>
                     
                     <TR>
                       <TD colspan="4"><DIV align="center" class="style1">Note: Please don't use refresh or back button </DIV></TD>
                     </TR>
                     <TR>
                       <TD><DIV align="center">(1)</DIV></TD>
                       <TD> Beneficiary Name </TD>
                       <TD colspan="2">                         <%= APP_NAME %> </TD>
                     </TR>
                     <TR>
                       <TD><DIV align="center">(2)</DIV></TD>
                       <TD>Applicant ID </TD>
                       <TD colspan="2">                         <%= APP_ID %> </TD>
                     </TR>
                     <TR>
                       <TD><DIV align="center">(3)</DIV></TD>
                       <TD>Unit Name </TD>
                       <TD colspan="2">                         <%= UNIT_NAME %> </TD>
                     </TR>
                     <TR>
                       <TD><DIV align="center">(4)</DIV></TD>
                       <TD>Mobile No </TD>
                       <TD colspan="2">                         <%= MOB_NO %></TD>
                     </TR>
                     <TR>
                       <TD><DIV align="center">(5)</DIV></TD>
                       <TD>Email Id </TD>
                       <TD colspan="2">                         <%= E_MAIL %></TD>
                     </TR>
                     <TR>
                       <TD><DIV align="center">(6)</DIV></TD>
                       <TD>Address </TD>
                       <TD colspan="2">                         <%= APP_POST_ADDR %></TD>
                     </TR>
                     <TR>
                       <TD><DIV align="center">(7)</DIV></TD>
                       <TD>State Name </TD>
                       <TD colspan="2"><%= STATE_CD %></TD>
                     </TR>
                     <TR>
                       <TD><DIV align="center">(8)</DIV></TD>
                       <TD>Pincode </TD>
                       <TD colspan="2">                         <%= PINCODE %></TD>
                     </TR>
                     <TR>
                       <TD><DIV align="center">(9)</DIV></TD>
                       <TD>Amount</TD>
                       <TD colspan="2"><%= AMOUNT %></TD>
                     </TR>
                     <TR>
                       <TD colspan="4"><DIV align="center">
                         <INPUT name="paynow" class="myButton" type="submit" value="PAYNOW">
                       </DIV></TD>
                     </TR>
                   </TABLE>
                   <P>&nbsp;</P>
                   <P>&nbsp;         </P>
      </CENTER>
      
      <DIV align = "center"></DIV>
   </FORM>
   </BODY>
</HTML>