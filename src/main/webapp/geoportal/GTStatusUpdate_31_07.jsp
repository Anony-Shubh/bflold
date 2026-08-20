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
<LINK rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<SCRIPT language="javascript" src="../js/inlineMsgMain.js"></SCRIPT>


<SCRIPT language="javascript">

function form_submit(){
var COM_MODE = document.form.COM_MODE.value;
    var NB_NAME = document.form.NB_NAME.value;
    var NB_DESIG = document.form.NB_DESIG.value;
	var INT_REMARK  = document.form.INT_REMARK.value


if ( COM_MODE== "") {	 inlineMsg ( 'COM_MODE','Select Interaction Mode',2);	return (false);}
else if (NB_NAME== "") {	 inlineMsg ( 'NB_NAME','Enter Name of Nodal Officer',2); return (false);}
else if (NB_DESIG== "") {	 inlineMsg ( 'NB_DESIG','Enter Designation',2);	return (false);}
else if (INT_REMARK == "") {	 inlineMsg ( 'INT_REMARK','Remark Must be entered',2);	return (false);

}else {

document.form.ins.value='I';
document.form.submit();


}}

</SCRIPT>
</HEAD>
<BODY>
<% 
String ins = "";
ins = (String) request.getParameter("ins")==null?"":(String) request.getParameter("ins").trim();
String  APP_ID =request.getParameter("APP_ID")==null?"":(String)request.getParameter("APP_ID");
String  APP_NAME =request.getParameter("APP_NAME")==null?"":(String)request.getParameter("APP_NAME");





%>
<FORM name="form" id="form"  class="form" method="post" action="InteractionDetailUpdate.jsp">

  <TABLE align="center">

  <TR>
    <TH colspan="4"><DIV align="center"> 
      <INPUT name="APP_ID" type="hidden" id="APP_ID" value="<%= APP_ID %>">
      Margin Money Adjustment Update Form </DIV></TH>
  </TR>
  <TR>
    <TH><INPUT name="ins" type="hidden" id="ins">
      Applicant Id</span> :      </TH>
    <TH colspan="3"></TH>
    </TR>
  
  
  
  <TR >
    <TH >Name Of Applicant :</TH>
    <TD colspan="3" ></TD>
    </TR>
  <TR >
    <TH >Physical Verification Status: </TH>
    <TD >&nbsp;</TD>
    <TH >&nbsp;</TH>
    <TD >&nbsp;</TD>
  </TR>
  <TR >
    <TH >MM Adjustemnt Status at Agency </TH>
    <TD ><LABEL>
      <INPUT name="radiobutton" type="radio" value="radiobutton">
    </LABEL>
      Recommended for Adjustment of MM </TD>
    <TH colspan="2" ><INPUT name="radiobutton" type="radio" value="radiobutton">
      Recommended for Reverification </TH>
    </TR>
  <TR >
    <TH >&nbsp;</TH>
    <TD ><INPUT name="radiobutton" type="radio" value="radiobutton" checked> 
      Under Process at Agency </TD>
    <TH >&nbsp;</TH>
    <TD >&nbsp;</TD>
  </TR>
  <TR >
    <TH >MM Rleased Amount </TH>
    <TD >&nbsp;</TD>
    <TH >&nbsp;</TH>
    <TD >&nbsp;</TD>
  </TR>
  <TR >
    <TH >MM Allowed for Adjustment </TH>
    <TD >&nbsp;</TD>
    <TH >&nbsp;</TH>
    <TD >&nbsp;</TD>
  </TR>
  
  <TR >
    <TH >MM Called back Amount(Disallowed)  </TH>
    <TD colspan="3" >&nbsp;</TD>
  </TR>
  <TR >
    <TH >Remarks by Agency: </TH>
    <TD colspan="3" >&nbsp;</TD>
  </TR>
  
  <TR>
    <TH colspan="4"> 
        <DIV align="center">
		 <INPUT name="Button" type="button" class="button" onClick="form_submit()" value="Verified">

         
          <INPUT name="Button" type="button" class="button" value="Cancel" onClick="self.close();">          
        </DIV></TH>
  </TR>
</TABLE>



    </p>
</FORM>
</BODY>
</HTML>
