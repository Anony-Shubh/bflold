<%@ page session="true" buffer="300kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Bank applicant view</title>
<%@ include file="headerfile.jsp" %>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script language="javascript">
function bankpopup(myurl,param,w,h ) { 
var winl = (screen.width-w)/2; 
var wint = (screen.height-h)/2; 
if (winl < 0) winl = 0; 
if (wint < 0) wint = 0; 
var page = myurl+'?'+param; 
windowprops = "height="+h+",width="+w+",top="+ wint +",left="+ winl +",location=no,scrollbars=yes,menubars=no,toolbars=no,resizable=no,status=no"; 
window.open(page, "Popup", windowprops); 
} 

</script>
</head>

<body>
<form action="bankApplicationView.jsp" method="post" name="form1">

<%
 DBCon db= new DBCon();
 int srn =0;
db.connect();
String txtSearch=request.getParameter("txtSearch") == null?"":(String) request.getParameter("txtSearch");
String IFSC_CODE=(String)session.getAttribute("bank_id");
String APP_NAME="";
String CURRENT_STATUS="";
String BANK_F_DATE="";
String  BANK_REC_DT="";
String  UP_DATE ="";
String APP_ID ="";
 
		
		StringBuffer av= new StringBuffer();
		
		av.append("  select a.app_id,B.act_id ,NVL(c.act_desc,'') AS CURRENT_STATUS, a.app_name,a.fh_name,TO_CHAR(a.bank_f_date,'DD-MON-YYYY') AS bank_f_date,   ").
		append(" TO_CHAR(b.bank_rec_dt,'DD-MON-YYYY') AS BANK_REC_DT,to_char(b.time_stamp,'DD-MON-YYYY:HH:MM:SS') AS UP_DATE from app_detail a, "). 
		append("  bank_dataentry b,bank_app_status c where a.app_id=b.app_id (+) AND A.ACT_ID=5  AND  b.act_id=c.act_id (+) ").
		append("  AND A.IFSC_CODE=?  ").
  		append (" AND UPPER(A.app_id||' '||trim(A.app_name)) LIKE '%'||TRIM(UPPER(?))||'%' Order by  B.bank_rec_dt desc ");
		
		
		List values=new ArrayList();
     values.add (IFSC_CODE); 
	 values.add (txtSearch);

		ResultSet rsinst = db.executeSQL(av.toString(),values);
		values.clear();

		
%>

<h2 align="center"><img src="../images/pmegpetrackN.png" width="699" height="83" /></h2>
<table border="2" align="center"  >
  <tr>
    <th colspan="8" align="left"><div align="center">Applicant data Search and Update form </div></th>
  </tr>
  <tr>
    <th colspan="8" align="left">
        <div align="left"><span >Search by Applicant ID / Name : (enter few letters) :</span>          
          <input name="txtSearch" type="text" class="style1" id="txtSearch" size="20" maxlength="15" />
          <input name="Submit" type="submit" class="button" onClick="strFind();" value="Find" />
          <input name="Submit" type="submit" class="button" onClick="strFind();" value="ALL" />       
    </div></th>
  </tr>
  
  <tr >
   <th align="left">     <div align="center">Applicant id </div></th>
    <th align="left">      <div align="center">Applicant Name<br>
    </div></th>
    <th align="left"><div align="center">Date of Forwarding </div></th>
    <th align="left"><div align="center">Date of Process </div></th>
    <th align="left">Message to Applicant /<br />Sponsoring Agency </th>
    <th align="left">Applicant  Data  </th>
    <th align="left">Upload</th>
    <th align="left"><div align="center">Current Status </div></th>
    </tr>
  <% 
  while (rsinst.next()) {
  srn=srn+1;
  APP_ID=rsinst.getString ("app_id")==null?"":rsinst.getString("app_id") ;
  APP_NAME= rsinst.getString("app_name")==null?"":rsinst.getString("app_name") ;
  BANK_F_DATE=rsinst.getString("BANK_F_DATE")==null?"":rsinst.getString("BANK_F_DATE");
  BANK_REC_DT=rsinst.getString("BANK_REC_DT")==null?"":rsinst.getString("BANK_REC_DT");
  CURRENT_STATUS=rsinst.getString("CURRENT_STATUS")==null?"":rsinst.getString("CURRENT_STATUS");
   %>
  <tr>
    <td align="left" nowrap="nowrap"><span >(<%=srn%>)<%= APP_ID %></span></td>
    <td align="left" nowrap="nowrap"><%= APP_NAME %></td>
    <td align="left" nowrap="nowrap"><span ><%=BANK_F_DATE%></span></td>
    <td align="left" nowrap="nowrap"><span ><%= BANK_REC_DT  %></span></td>
    <td align="left" nowrap="nowrap"><div align="center"><a href="bankInteractionDetailUpdate.jsp?APP_ID=<%= APP_ID %>" class="button">Send Message </a></div></td>
    <td align="left" nowrap="nowrap"><div align="center"><a href="bankDataEntryForm.jsp?APP_ID=<%= APP_ID %>" class="greenButtonRound">Update</a></div></td>
    <td align="left" nowrap="nowrap"><a href="#" class="button">Upload</a></td>
    <td align="left" nowrap="nowrap"><span ><%= CURRENT_STATUS %></span></td>
    </tr>
  <%
}
rsinst.close();
db.close();
%>
</table>

</form>

</body>
</html>
<%
rsinst.close();
db.close();
%>
