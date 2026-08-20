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
<title>PMEGP: BANK LOGIN FORM</title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<STYLE>
.style18 {color: #FF0000}
</STYLE>
</head>

<body>
<form name="form1" method="post" action="index.jsp">
<% 
String msgStr="";
   
    String CLIENTIP=request.getRemoteHost()==null?"NA":(String) request.getRemoteHost();
    String bank_flag="";
    String uc= request.getParameter("USR");
    String pw = request.getParameter("PWD");
	String bank_id= "";
	String mBankid="" ;
	String USER_DESC="";
	
	 List values=new ArrayList();
     values.add (uc); 
	 values.add (pw);
	
	
	try {
	// TO INSERT INTO BANK MASTER DATA THOSE APPLICATION FORWARDED TO UBI BANK
	StringBuffer sbTr= new StringBuffer();
	
	 DBCon db= new DBCon();
     db.connect();
	 

	


		String qryBank=	"  SELECT IFSL_CODE,USER_NM,USER_DESC,PASSWD FROM BU_USERMAST where ACT_YN='Y' AND BANK_FLAG='F' AND upper(IFSL_CODE)=  upper(TRIM (?)) and  upper(trim(PASSWD))= upper(TRIM(?)) ";	
		
		String RESETYN="";
	ResultSet rs1 = db.executeSQL(qryBank.toString(),values);
   while (rs1.next() ){
   bank_id= rs1.getString("IFSL_CODE");
   USER_DESC= rs1.getString("USER_DESC");
    session.setAttribute("bank_id",rs1.getString("IFSL_CODE"));
	 session.setAttribute("USER_DESC",rs1.getString("USER_DESC"));
	session.setAttribute("bank_flag",rs1.getString("IFSL_CODE"));
session.setAttribute("SCLIENTIP",CLIENTIP);		
	 response.sendRedirect("bankApplicationView.jsp");
    response.flushBuffer();
     return; 
	 //} 
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
 <img src="images/pmegponlineN.jpg" width="100%">
  <h2 align="center" class="style6"><img src="images/pmegpetrackN.png" width="699" height="83"></h2>
 
    <MARQUEE>
   <img src="..\pmegphome\img\blinking_new.gif" width="2%"> <span class="style18"><B>MOU For Physical Verification Between KVIC And Department Of Post</span><a href="Intimation_DoP_Banks.pdf" class="myButtonYellow">  Click Here</a></B>
  </MARQUEE>
  <br/>
  <table border="5" align="center" cellpadding="3" cellspacing="3" bordercolor="#990000"  class="pmegpTable">
    
    <tr>
      <th colspan="2" nowrap><div align="center"><span class="style14">
        <h1>BANK LOGIN FORM</h1>
      </span></div></th>
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
            <input name="PWD" type="password" id="PWD" maxlength="15" autocomplete="off">
            </span></div></th>
    </tr>
    <tr>
      <td colspan="2">
        <div align="center"><span class="style1">
          <input name="Submit" type="submit" class="button" value="LOGIN">
        </span></div></td></tr>
    <tr>
      <th colspan="2" nowrap>
        <div align="center" class="style1"><%= msgStr %> </div></th>
    </tr>
  </table>
  <p>&nbsp;</p>
  <table width="100%"  border="1" class="pmegpTable">
    <tr>
      <th><div align="center" class="style16">
        <p>For Technical Support send mail to <span class="style17">pmegpeportal.kvic@gov.in</span> from your Branch email ID with IFS Code, Branch Name, Contact Person Name, Designation and Contact No. Technical help No. for Bank: 022-26712087 </p>
        </div></th>
    </tr>
  </table>

</form>
</body>
</html>
