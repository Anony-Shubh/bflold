<%@ page session="true"  import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.SQLException"%>
<%
response.setContentType("text/html");
response.setHeader("Cache-control","no-cache");
response.setHeader("Cache-control","private");
%>

<HTML>
<HEAD>
<TITLE>PMEGP Agency Status Update Form</TITLE>

<LINK rel="stylesheet" type="text/css" href="css/pmegpTable.css">
<SCRIPT language="javascript" src="../js/sweetalert.min.js"></SCRIPT>


<SCRIPT language="javascript">


//}

</SCRIPT>
</HEAD>
<BODY >
<form   name="form" id ="form" method="post" >
<%	

DBCon db= new DBCon();
db.connect();
String ins = "";
ins = (String) request.getParameter("ins")==null?"":(String) request.getParameter("ins").trim();
String  APP_ID =request.getParameter("APP_ID")==null?"":(String)request.getParameter("APP_ID");
String  PMEGPGEOTAGID =request.getParameter("PMEGPGEOTAGID")==null?"":(String)request.getParameter("PMEGPGEOTAGID");
String  APP_NAME =request.getParameter("APP_NAME")==null?"":(String)request.getParameter("APP_NAME");

String MARGIN_MONEY_ADJUSTMENT_AMOUNT="";
String MM_REL_AMT="";
String CO_REMARKS="";
String VERIFICATION_STATUS="";
String VERIFIER_REMARKS="";

String NODAL_OFFICER_REMARK="";
String MM_ADJUSTMENT_AMT_S="";
String PHYSICAL_VERIFICATION_STATUS="";
String MM_ADJUSTMENT_STATUS="";
String CALLBACK_AMOUNT="";
  String DATE_OF_VERIFICATION="";
  String VERIFICATION_BY="";
  String TOT_PRJ="";

  String PER_CAPITA_INVESTMENT_NORM_SAT="";
  String TOTAL_EMPLOYEES="";
  String UNIT_ESTABLISHMENT_DATE="";
  String UNIT_SETUP_ON="";
  String UNIT_NAME="";
  String CAPITAL_COST_OF_BUILDING="";
  String CAPITAL_COST_OF_MACHINERY="";
  String CALLBACK_REASON="";
  String MACHINARY_COST="";
  String WORKING_CAPITAL="";
String ACT_ID="";
String REMTRID="";
String TOT_PRJ_PROP="";
String pending_loan_amount="";
String PEN_LOAN="";
String MAX_AMT="";
String DIS_AMT="";
//StringBuffer qrysb= new StringBuffer();
String verror ="";
String validateqry="SELECT * FROM TABLE(GEOPHYSICAL_ERROR(?,?))";
List values=new ArrayList();
        List pstm=new ArrayList();	
    values.add(APP_ID);
values.add(PMEGPGEOTAGID);




  ResultSet rsValidate = db.executeSQL(validateqry,values);
values.clear();	

int errcount =0;

while (rsValidate.next()){
errcount =errcount+1;
verror=verror+""+rsValidate.getString(2)+"<br>";
//sout.print (verror);
}
rsValidate.close();
			
if (errcount<1)
{

 response.sendRedirect("GTStatusUpdate1.jsp?APP_ID="+APP_ID+"&PMEGPGEOTAGID="+PMEGPGEOTAGID);

}	




	


%>
<FORM name="form" id="form"  class="form" method="post" >

  <TABLE align="center">

  <TR>
    <TH colspan="7"> 
      <INPUT name="APP_ID" type="hidden" id="APP_ID" value="<%= APP_ID %>">
      
      <DIV align="center"> System Validation Report</DIV></TH>
  </TR>
  <TR>
    <TD colspan="2" ><strong>Geo Tagging Id:</strong> <%= PMEGPGEOTAGID %> </TD>
    <TD colspan="2" ><DIV align="left">
      <INPUT name="ins" type="hidden" id="ins">
      <strong>Applicant Id</span> :</strong> <%=APP_ID %></DIV></TD>
    </TR>
  
   <% if (!verror.equals("")) {%>
	<TR >
	  <TH colspan="7" ><DIV align="center"> </DIV></TH>
    </TR>
	<TR >
	  <TD colspan="7"  ><strong><%out.print (verror);%> </strong></TD>
	 
	</TR>
	<%}%>
	  <TR>
    <TD colspan="7"> 
        <DIV align="center">
		

         
          <INPUT name="Button" type="button" class="button" value="Cancel" onClick="self.close();">          
      </DIV></TD>
  </TR>
</TABLE>






    </p>
</FORM>
</BODY>
</HTML>
