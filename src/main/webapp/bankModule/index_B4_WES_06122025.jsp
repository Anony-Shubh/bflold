<%@ page session="true" buffer="500kb" import="java.sql.*,java.util.*,java.text.*,java.util.*,pkgPmegpNew.BankDataValidation,pkgPmegpNew.DBCon"  %>
<%
response.setContentType("text/html");
response.setHeader("Cache-Control", "no-cache,must-revalidate");
response.addHeader("Cache-Control", "post-check=0,pre-check=0");
response.addHeader("Cache-Control", "proxy-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", -1);
response.addHeader("X-XSS-Protection", "1; mode=block");
response.addHeader("X-Content-Type-Options", "nosniff");
response.addHeader("X-Frame-Options", "DENY");
%>
<HTML>
<HEAD>
<META http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<TITLE>BANK UPLOAD LOGIN FORM</TITLE>
<LINK rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />

<STYLE type="text/css">
<!--
.style8 {color: #00AE57; font-weight: bold; }
.style12 {color: #663300; font-weight: bold; }
.style14 {color: #663300; font-weight: bold; font-style: italic; }
.style16 {font-size: 24px}
.style17 {
	font-weight:bold;
	color: #009900;
	font-style: italic;
}
-->
.notification {
  background-color: #bf980b;
  color: white;
  text-decoration: none;
  padding: 15px 26px;
  position: relative;
  display: inline-block;
  border-radius: 2px;
}

.notification:hover {
  background: red;
}

.notification .badge {
  position: absolute;
  top: -10px;
  right: -10px;
  padding: 5px 10px;
  border-radius: 50%;
  background-color: red;
  color: white;
}
.style18 {color: #FF0000}
</STYLE></HEAD>

<BODY>
<IMG src="../images/pmegponlineN.jpg" width="100%"  ><center>
<%//@ include file="edp_header.jsp" %>
<FORM name="form1" method="post" action="index.jsp">
<% 
String msgStr="";
   
    String CLIENTIP=request.getRemoteHost()==null?"NA":(String) request.getRemoteHost();
    String bank_flag="";
    String uc= request.getParameter("USR");
    String pw = request.getParameter("PWD");
	String bank_id= "";
	String mBankid="" ;
	String assign="BK";
	
	 List values=new ArrayList();
     values.add (uc); 
	 values.add (pw);
	
	
	try {
	// TO INSERT INTO BANK MASTER DATA THOSE APPLICATION FORWARDED TO UBI BANK
	StringBuffer sbTr= new StringBuffer();
	
	 DBCon db= new DBCon();
     db.connect();
	 
  if (uc.toUpperCase().equals(pw.toUpperCase())) {

 /*sbTr.append(" SELECT spon_bank_name FROM bank_br_mast ").
append( " WHERE BR_TYPE='NATIONALISE' AND spon_bank_name IS NOT NULL AND SUBSTR(br_ifsl_code,1,4)=TRIM(UPPER(? )) AND SUBSTR(br_ifsl_code,1,4)=TRIM(UPPER(?))").
 append( "  GROUP BY SUBSTR(br_ifsl_code,1,4),spon_bank_name ");
			
			
ResultSet rsmon = db.executeSQL(sbTr.toString(),values);
 
  while (rsmon.next()) {
  session.setAttribute("sponc_banknm",rsmon.getString(1));
  response.sendRedirect("../bankpmegpmr");
     response.flushBuffer();
  }
 rsmon.close();*/
 
 sbTr.append(" SELECT BBM.SPON_BANK_NAME,BBM.BR_TYPE FROM BANK_BR_MAST BBM, BU_USERMAST BU ").
  append( "  WHERE BU.BANK_ID=BBM.BR_ID AND BBM.N_IFSC_CODE=BU.IFSL_CODE AND BU.ACT_YN='Y' AND BU.REP_UNAME=TRIM(UPPER(?)) AND BU.REP_PWD=TRIM(UPPER(?))  ").
  append( "  GROUP BY BBM.SPON_BANK_NAME,BBM.BR_TYPE ");
			
ResultSet rsmon = db.executeSQL(sbTr.toString(),values);
 
  while (rsmon.next()) {
  session.setAttribute("sponc_banknm",rsmon.getString(1));
  session.setAttribute("br_type",rsmon.getString(2));
  response.sendRedirect("../bankpmegpmr");
     response.flushBuffer();
  }
 rsmon.close();
 
 
  }//end if if
		
		
		String qryBank=	"SELECT  br_ifsl_code,BANK_FLAG,BR_NAME,BRANCH_NAME,STATE,PSSWD,REG_YN AS RESETYN FROM bank_br_mast where ACT_YN='Y' AND upper(br_ifsl_code)=  upper(TRIM (?)) and  upper( psswd)= upper(TRIM (?)) ";	
		
		String RESETYN="";
	ResultSet rs1 = db.executeSQL(qryBank.toString(),values);
   while (rs1.next() ){
   bank_id= rs1.getString("br_ifsl_code");
    session.setAttribute("bank_id",rs1.getString("br_ifsl_code"));
	session.setAttribute("bank_flag",rs1.getString("BANK_FLAG"));
	session.setAttribute("BR_NAME",rs1.getString("BR_NAME"));
	session.setAttribute("BRANCH_NAME",rs1.getString("BRANCH_NAME"));
	session.setAttribute("STATE",rs1.getString("STATE"));
	session.setAttribute("SCLIENTIP",CLIENTIP);	
	String PASSWD=rs1.getString("PSSWD");
	RESETYN =rs1.getString("RESETYN");
	if (RESETYN.equals("N")){
	response.sendRedirect("BANKCHANGEPW.jsp");
     response.flushBuffer();
     return; 
	 }else{
	 session.setAttribute("assign",assign);
	 response.sendRedirect("BankHomePage.jsp");
    response.flushBuffer();
     return; 
	 } 
	} 
	
   rs1.close();
    db.close();
  values.clear();	
  
   if ( (bank_id.equals("null")||bank_id.length()<1) && uc.length()>0 ) {
   msgStr="Authentication Failed";
	}

  }catch(Exception e){
//out.print(e.toString());
  }
   
   %>
   
<IMG src="../images/pmegpetrackN.png" width="30%">
    <!--
  <p align="center" class="mtextarea">RRBs Having One IFS Code and More than One Branchs are requested to email their Branch details in the prescribed format
  ( <a href="../excelsheetformat/rrb_branchlist_pmegpeportal.xls" class="greenButtonRound">Click here to download excel format of RRBs </a>) email id: pmegpeportal.kvic@gov.in </p>
  -->
  
  <!--
 <p> <center>
    <a href="edpCircularExmp31032020.pdf">EDP Training</a> 
  </center> </p>  
  -->
  <MARQUEE>
   <img src="..\pmegphome\img\blinking_new.gif" width="2%"> <span class="style18"><B>MOU For Physical Verification Between KVIC And Department Of Pos</span>t <a href="Intimation_DoP_Banks.pdf" class="myButtonYellow">  Click Here</a></B>
  </MARQUEE>
		</br>
  <TABLE border="5" align="center" cellpadding="3" cellspacing="3" bordercolor="#990000" class="style8">
    <TR>
      <TH nowrap><DIV align="left"><A href="../pmegphome/index.jsp" target="_parent" class="greenButtonRound">Home</A></DIV></TH>
      <TH nowrap><DIV align="right"><A href="../bankNodalOfficer/index.jsp" class="greenButtonRound">NODAL OFFICER LOGIN</A> </DIV></TH>
    </TR>
    <TR>
      <TD colspan="2" nowrap><DIV align="center">
	<A href="../pmegphome/Phy.verification.pdf" download class="notification">
  <SPAN>Click here to Download Physical verification and Geo tagging Letter</SPAN>
  <SPAN class="badge">New</SPAN>
</A></DIV></TD>
    </TR>
    <TR>
      <TH colspan="2" nowrap><DIV align="center"><SPAN class="style14"><H1>FINANCING BRANCH LOGIN FORM</H1></SPAN></DIV></TH>
    </TR>
    <TR>
      <TH nowrap><DIV align="right" class="style12">
        <DIV align="left">User Name: </DIV>
      </DIV></TH>
      <TH nowrap>
        
          <DIV align="center">
            <SPAN class="style1">
            <INPUT name="USR" type="text" id="USR" maxlength="11" AUTOCOMPLETE="off" >
            </SPAN></DIV></TH>
    </TR>
    <TR>
      <TH nowrap><DIV align="right" class="style12">
        <DIV align="left"><STRONG>Password:</STRONG></DIV>
      </DIV></TH>
      <TH nowrap>
        
          <DIV align="center">
            <SPAN class="style1">
            <INPUT name="PWD" type="password" id="PWD" maxlength="15" AUTOCOMPLETE="off">
            </SPAN></DIV></TH>
    </TR>
    <TR>
      <TD colspan="2">
        <DIV align="center"><SPAN class="style1">
          <INPUT name="Submit" type="submit" class="button" value="LOGIN">
        </SPAN></DIV></TD></TR>
    <TR>
      <TH colspan="2" nowrap>
        <DIV align="center" class="style1"><%= msgStr %> </DIV></TH>
    </TR>
    <TR>
      <TD colspan="2"><DIV align="right"><A href="getpmegppwdConfirmforgot.jsp" class="blueRound">Reset Password </A></DIV></TD>
    </TR>
  </TABLE>
  <P>&nbsp;</P>
  <TABLE width="100%"  border="1">
    <TR>
      <TH><DIV align="center" class="style16">
        <P>For Technical Support send mail to <SPAN class="style17">pmegpeportal.kvic@gov.in</SPAN> from your Branch email ID with IFS Code, Branch Name, Contact Person Name, Designation and Contact No. </P>
        <P>Technical help No. for Bank: 022-26712087 </P>
      </DIV></TH>
    </TR>
  </TABLE>

</FORM>
</BODY>
</HTML>
