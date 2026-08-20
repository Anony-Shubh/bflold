<%@ page session="true" buffer="500kb" import="java.sql.*,javax.sql.*,javax.naming.*,java.util.*,java.text.*,java.util.*,pkgPmegpNew.DBCon"  %>
<%
response.setContentType("text/html");
response.setHeader("Cache-control","no-cache");
response.setHeader("Cache-control","private");
%>

<html>
<head>
<title>PMEGP Bank Data Entry Form</title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
</head>

<form  method="post"  name="form" id="form" >
  <%@ include file="MonitoringRep.jsp" %>
 
  <%
  
String  APP_ID =  session.getAttribute("SAPP_ID")==null?"":(String) session.getAttribute("SAPP_ID");
String IFSC_CODE="";
 
	String BANK_NAME="";
	String  BRANCH_NAME="";
//String APP_ID = (String)session.getAttribute("SAPP_ID");
//String IFSC_CODE=(String)session.getAttribute("bank_id");

String LOAN_SANC_DT = "";
String WORKSHED_COST ="";
String WORKING_CAPITAL = "";
String MACHINARY_COST = "";




String IST_LOAN_AMT = "";
String IST_LOAN_DT = "";
String CGTSI = "";

String MM_REL_DT = "";
String MM_REL_AMT = "";

String PROJ_COST="";

String APPLOAN_ACCNO = "";
String FB_ACNO = "";

String TDR_ACNO = "";
String TDR_ADJ_DT = "";

String CE_SANC_FB="";
String WC_SANC_FB="";
String TOTAL_SANC_FB="";
String UTRN_NO="";

DBCon db= new DBCon();
db.connect();

try {

StringBuffer av= new StringBuffer();

  
   av.append( "SELECT nvl(b.WORKSHED_COST,0) as WORKSHED_COST,").
   append( "nvl(b.MACHINARY_COST,0) as MACHINARY_COST,").
   append( "NVL(b.CE_SANC_FB, 0) as CE_SANC_FB ,").
   append( "NVL(b.WC_SANC_FB, 0) as WC_SANC_FB,").
   append( "NVL(b.IST_LOAN_AMT, 0) as IST_LOAN_AMT,").
   append( "TO_CHAR(b.IST_LOAN_DT, 'DD-MON-RRRR') AS IST_LOAN_DT,").
   append( "b.APPLOAN_ACCNO,").
   append( "b.TDR_ACNO,").
   append( "TO_CHAR(b.TDR_ADJ_DT, 'DD-MON-RRRR') AS TDR_ADJ_DT,").
   append( "b.UTRN_NO,").
   append( "b.MM_REL_AMT,").
   append( "TO_CHAR(b.MM_REL_DT, 'DD-MON-RRRR') AS MM_REL_DT,").
   append( "NVL(b.CE_SANC_FB, 0) + NVL(b.WC_SANC_FB, 0) TOTAL_SANC_FB,").
   append( "b.WORKING_CAPITAL  ,b.IFSC_CODE ,a.BANK_NAME,a.BRANCH_NAME ").
  append( "  FROM app_detail a,").
  append( " bank_dataentry b").
  append( " WHERE a.APP_ID = b.APP_ID(+) and ").
	append( " a.APP_ID=? ");

//out.print(av.toString());
			List values=new ArrayList();
     values.add (APP_ID); 
	// values.add (IFSC_CODE);
			
ResultSet rsApp = db.executeSQL(av.toString(),values);


values.clear();

while (rsApp.next()) {
    MACHINARY_COST=rsApp.getString("MACHINARY_COST")==null?"0":rsApp.getString("MACHINARY_COST");
	IFSC_CODE=rsApp.getString("IFSC_CODE")==null?"0":rsApp.getString("IFSC_CODE");
	BANK_NAME=rsApp.getString("BANK_NAME")==null?"0":rsApp.getString("BANK_NAME");
	BRANCH_NAME=rsApp.getString("BRANCH_NAME")==null?"0":rsApp.getString("BRANCH_NAME");
	WORKSHED_COST=rsApp.getString("WORKSHED_COST")==null?"0":rsApp.getString("WORKSHED_COST"); 
	APPLOAN_ACCNO=rsApp.getString("APPLOAN_ACCNO")==null?"":rsApp.getString("APPLOAN_ACCNO");
	TDR_ACNO=rsApp.getString("TDR_ACNO")==null?"":rsApp.getString("TDR_ACNO");
	TDR_ADJ_DT=rsApp.getString("TDR_ADJ_DT")==null?"":rsApp.getString("TDR_ADJ_DT");
	CE_SANC_FB=rsApp.getString("CE_SANC_FB")==null?"0":rsApp.getString("CE_SANC_FB");
	WC_SANC_FB=rsApp.getString("WC_SANC_FB")==null?"0":rsApp.getString("WC_SANC_FB");
    TOTAL_SANC_FB=rsApp.getString("TOTAL_SANC_FB")==null?"":rsApp.getString("TOTAL_SANC_FB");
    MM_REL_DT=rsApp.getString("MM_REL_DT")==null?"":rsApp.getString("MM_REL_DT");
    MM_REL_AMT=rsApp.getString("MM_REL_AMT")==null?"":rsApp.getString("MM_REL_AMT");
	IST_LOAN_AMT=rsApp.getString("IST_LOAN_AMT")==null?"":rsApp.getString("IST_LOAN_AMT");
	IST_LOAN_DT=rsApp.getString("IST_LOAN_DT")==null?"":rsApp.getString("IST_LOAN_DT");
	UTRN_NO=rsApp.getString("UTRN_NO")==null?"":rsApp.getString("UTRN_NO");
	} //end of resultset	
	//END OF BANK DATA
	
	//out.print(ACT_ID);
		
	}//end of ins
	catch (Exception e) {
	
	//out.print (e.toString());
	}		
%>
  <br/><br/>
  <table align="center">
    
    <tr>
      <td colspan="4"><div align="center"><span class="mtextarea">Project Profile </span>
      </div></td>
    <tr>
      <th>(1)</th>
      <th>Financing Bank Name*: </th>
      <th colspan="2"><%= BANK_NAME %></th>
    <tr>
      <th>&nbsp;</th>
      <th>IFSC Code : </th>
      <th colspan="2"><%= IFSC_CODE %></th>
    <tr>
      <th>&nbsp;</th>
      <th>Branch Name : </th>
      <th colspan="2"><%= BRANCH_NAME %></th>
    <tr>
      <td colspan="4">&nbsp;</td>
    <tr>
      <th>(2)</th>
      <th>Project Cost Detail: </th>
      <th> <div align="center">Project Cost </div></th>
      <th> <div align="center"> Loan Sanction </div></th>
    <tr>
      <th nowrap>&nbsp;</th>
      <th nowrap>(a) Capital Expenditure/Term Loan (in Rs) </th>
      <td nowrap><div align="center">
       <%= MACHINARY_COST %>
      </div></td>
      <td nowrap><div align="center">
       <%= CE_SANC_FB %>
      </div></td>
    <tr>
      <th>&nbsp;</th>
      <th>(b) Working Capital/Cash Credit (in Rs.) </th>
      <td><div align="center">
      <%= WORKING_CAPITAL %>
      </div></td>
      <td><div align="center">
        <%= WC_SANC_FB %>
      </div></td>
    <tr>
      <th>&nbsp;</th>
      <th> (c) Total  Project Cost  (a+b) </th>
      <th><div align="center">
       
</div></th>
      <th><div align="center">
       <%= TOTAL_SANC_FB %>
        </div></th>
    <tr>
      <th>(3)</th>
      <th>Date of Release of Loan:</th>
      <td colspan="2"><%= IST_LOAN_DT %></td>
    <tr>
      <th>(3)</th>
      <th>Loan Released (in Rs.): </th>
      <td colspan="2"><%= IST_LOAN_AMT %></td>
    <tr>
      <th>(4)</th>
      <th>Loan Account No.( Beneficiary ) </th>
      <td colspan="2"><%= APPLOAN_ACCNO %></td>
    <tr>
      <td>(5)</td>
      <td colspan="3"><div align="center" class="GreenLebel">Details of Margin Money (Subsidy) Claim Transfer through Corp. Bank to Your Bank</div></td>
    <tr>
      <td>&nbsp;</td>
      <td><div align="right">Transfer    Date: </div></td>
      <td colspan="2"><%=MM_REL_DT%></td>
    <tr>
      <td>&nbsp;</td>
      <td><div align="right">MM Amount: </div></td>
      <td colspan="2"><%=MM_REL_AMT%></td>
    <tr>
      <td>&nbsp;</td>
      <td><div align="right"> Reference No: </div></td>
      <td colspan="2"><%=UTRN_NO%></td>
    <tr>
      <td colspan="4">  <div align="center" class="GreenLebel">TDR Account Detail</div></td>
    <tr>
      <th>(6)</th>
      <th>Beneficiary TDR Account No: </th>
      <td colspan="2"><%= TDR_ACNO %></td>
    <tr>
      <th>(7)</th>
      <th>Deposit Date in TDR: </th>
      <td colspan="2"><%= TDR_ADJ_DT %></td>
  </table>
 
</form>
<% db.close();%>

</body>
</html>
