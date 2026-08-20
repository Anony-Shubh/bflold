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
String  APP_NAME ="";
DBCon db= new DBCon();
db.connect();

String ATTACHMENT_NAME="";
String MEDIA_TYPE="";
String UNIT_NAME="";
String IND_TYPE="";

String ACTIVITY_NAME="";
String PRJ_COST="";
ResultSet  rs;
ResultSet  rst;

  StringBuffer qry= new StringBuffer();
	
qry.append(" SELECT gd.APP_ID,gd.APP_NAME, ga.unit_name,  decode(gd.IND_TYPE,'M','MANUFACTURING','T','TRADEING','S','SERVICE')  AS IND_TYPE, ");
qry.append("   gd.ACTIVITY_NAME ||'-'||gd.PROD_DESC as ACTIVITY_NAME ,  NVL(gd.PRJ_CE,0)+NVL(gd.PRJ_WC,0) AS PRJ_COST ");
qry.append("  FROM geotag_trans ga, GEOTAGAPIDATA gd WHERE gd.APP_ID = ga.APP_ID AND ga.APP_ID=? ");

   List values=new ArrayList();
   
   values.add(APP_ID);
   
    rst = db.executeSQL(qry.toString(),values);
   values.clear();
  
while (rst.next()){

	UNIT_NAME=rst.getString("UNIT_NAME")==null?"":rst.getString("UNIT_NAME");
	IND_TYPE=rst.getString("IND_TYPE")==null?"":rst.getString("IND_TYPE");	
	ACTIVITY_NAME=rst.getString("ACTIVITY_NAME")==null?"":rst.getString("ACTIVITY_NAME");
	PRJ_COST=rst.getString("PRJ_COST")==null?"":rst.getString("PRJ_COST");
APP_NAME=rst.getString("APP_NAME")==null?"":rst.getString("APP_NAME");
}


   
   
    StringBuffer qrysb= new StringBuffer();
	

qrysb.append("   SELECT ga.ATTACHMENT_NAME, ga.MEDIA_TYPE, ga.APP_ID FROM geotag_attch ga  where  ga.APP_ID=?"      );

int count=0;



values.add(APP_ID);
  
   rs = db.executeSQL(qrysb.toString(),values);
   values.clear();
 
 
	
%>

<div align="center">

<table align="center" class="pmegpTable">
  <tr>
    <th colspan="4" scope="row"><div align="center">PMEGP </div></th>
  </tr>
  <tr>
    <td scope="row">Applicant ID: </td>
    <td><%= APP_ID %></td><td>Applcant Name: </td>
    <td><%= APP_NAME %></td>
   
  </tr>
   <tr>
    <td scope="row">Project Cost: </td>
    <td><%= PRJ_COST %></td>
    <td>Industry Type: </td>
    <td><%= IND_TYPE %></td>
  </tr>
   <tr>
    <td>Unit Name: </td>
    <td><%= UNIT_NAME %></td>
    <td scope="row">Activity: </td>
    <td><%= ACTIVITY_NAME %></td>
    
  </tr>
  <tr>
  <td colspan="4" scope="row"></td>
  </tr>
  </table>
<p>&nbsp;</p>
<table width="50%">

<tr>
<th><DIV align="center">Sr.no</DIV></th>
<th><DIV align="center">Document</DIV></th>
<th><DIV align="center">View</DIV></th>
</tr>

<%
while (rs.next()){	
	ATTACHMENT_NAME=rs.getString("ATTACHMENT_NAME")==null?"":rs.getString("ATTACHMENT_NAME");
	MEDIA_TYPE=rs.getString("MEDIA_TYPE")==null?"":rs.getString("MEDIA_TYPE");	
	count=count+1;


%>
<tr>
<td><DIV align="center"><%=count%></DIV></td>
<td><DIV align="center"><%=ATTACHMENT_NAME%></DIV></td>
<td><DIV align="center"><A href="<%=MEDIA_TYPE%>" class="greenButtonRound">View</A></DIV></td>

</tr>
<%} rs.close();%>

</table>
</div>


</BODY>
</HTML>
