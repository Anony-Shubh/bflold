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
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>BANK UPLOAD LOGIN FORM</title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />

<style type="text/css">
<!--
.style6 {color: #A05454; font-weight: bold; }
.style8 {color: #00AE57; font-weight: bold; }
.style12 {color: #663300; font-weight: bold; }
-->
</style></head>

<body>
<form name="form1" method="post" action="index.jsp">
<% 
String msgStr="";
   
   
    String bank_flag="";
    String uc= request.getParameter("USR");
    String pw = request.getParameter("PWD");
	String bank_id= "";
	String mBankid="" ;
	
	 List values=new ArrayList();
     values.add (uc); 
	 values.add (pw);
	
	
	try {
	// TO INSERT INTO BANK MASTER DATA THOSE APPLICATION FORWARDED TO UBI BANK
	StringBuffer sbTr= new StringBuffer();
	
	 DBCon db= new DBCon();
     db.connect();
	 
  if (uc.toUpperCase().equals(pw.toUpperCase())) {
 sbTr.append(" SELECT spon_bank_name FROM bank_br_mast ").
append( " WHERE SUBSTR(br_ifsl_code,1,4)=TRIM(UPPER(? )) AND SUBSTR(br_ifsl_code,1,4)=TRIM(UPPER(?))").
 append( "  GROUP BY SUBSTR(br_ifsl_code,1,4),spon_bank_name ");
 
			
ResultSet rsmon = db.executeSQL(sbTr.toString(),values);
 
    
  while (rsmon.next()) {
  session.setAttribute("sponc_banknm",rsmon.getString(1));
  response.sendRedirect("../bankpmegpmr");
     response.flushBuffer();
  }
 rsmon.close();
  }//end if if
		
		
		String qryBank=	"SELECT  br_ifsl_code,BANK_FLAG,PSSWD,RESETYN FROM bank_br_mast where upper(br_ifsl_code)=  upper(TRIM (?)) and  upper( psswd)= upper(TRIM (?)) ";	
		
		String RESETYN="";
	ResultSet rs1 = db.executeSQL(qryBank.toString(),values);
   while (rs1.next() ){
   bank_id= rs1.getString("br_ifsl_code");
    session.setAttribute("bank_id",rs1.getString("br_ifsl_code"));
	session.setAttribute("bank_flag",rs1.getString("BANK_FLAG"));
	String PASSWD=rs1.getString("PSSWD");
	RESETYN =rs1.getString("RESETYN");
	if (RESETYN.equals("Y")){
	response.sendRedirect("BANKCHANGEPW.jsp");
     response.flushBuffer();
     return; 
	 }else{
	 response.sendRedirect("bankApplicationView.jsp");
    response.flushBuffer();
     return; 
	 } 
	} 
	
   rs1.close();
    db.close();
  values.clear();	
  
   if ( (bank_id.equals("null")||bank_id.length()<1) && uc.length()>0 ) {
    response.sendRedirect("resetpwd.jsp");
	//msgStr="Login failed ....... <br> <a href=resetpwd.jsp>click here to reset the password </a>";
	}
   
 

  }catch(Exception e){
//out.print(e.toString());
  }
   
   %>
<div align="center">
 <img src="../images/pmegponlineN.jpg" width="100%">
  <h2 align="center" class="style6"><img src="../images/pmegpetrackN.png" width="699" height="83"></h2>
  <table border="5" align="center" cellpadding="3" cellspacing="3" bordercolor="#990000" class="style8">
    <tr>
      <th colspan="2" nowrap><div align="center" class="style12"> BANK LOGIN FORM</div></th>
    </tr>
    <tr>
      <th nowrap><div align="right" class="style12">
        <div align="left">User Name: </div>
      </div></th>
      <th nowrap>
        
          <div align="center">
            <span class="style1">
            <input name="USR" type="text" id="USR" maxlength="11" autocomplete="off" >
            </span></div></th>
    </tr>
    <tr>
      <th nowrap><div align="right" class="style12">
        <div align="left"><strong>Password:</strong></div>
      </div></th>
      <th nowrap>
        
          <div align="center">
            <span class="style1">
            <input name="PWD" type="password" id="PWD" maxlength="11" autocomplete="off">
            </span></div></th>
    </tr>
    <tr>
      <th colspan="2" nowrap>
        <div align="center"><span class="style1">
          <input name="Submit" type="submit" class="button" value="LOGIN">
        </span></div></th></tr>
    <tr>
      <th colspan="2" nowrap>
        <div align="center" class="style1"><%= msgStr %> </div></th>
    </tr>
  </table>
</form>
</body>
</html>
