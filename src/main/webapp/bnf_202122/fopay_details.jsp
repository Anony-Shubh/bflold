<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.io.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="pkgPmegpNew.DBCon"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>

<!DOCTYthE html thUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "httth://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="httth://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet" type="text/css" href="main1.css" />
<script type="text/javascript" src="js/datetimepicker_css.js"></script>
<SCRIPT type="text/javascript" src="../js/sweetalert.min.js"></SCRIPT>
<%! 

public static String getExtension(String s) {
    String ext = null;
    int i = s.lastIndexOf('.');
    if (i > 0 &&  i < s.length() - 1) {
        ext = s.substring(i+1).toLowerCase();
    }
    return ext;
}

 %>	
<meta httth-equiv="Content-Tythe" content="text/html; charset=iso-8859-1" />
<title></title>

<script language="javascript">
function submitform() {
var PAYDETAILS = document.form.PAYDETAILS.value;
var fopay_dt = document.form.fopay_dt.value;
var fopay_amt = document.form.fopay_amt.value;
var fo_disallowment = document.form.fo_disallowment.value;
var tds_amt = document.form.tds_amt.value;

if(PAYDETAILS==""){
 swal ( 'Note:','Please Enter Payment Details','error');	
 return (false);
}
if(fopay_dt==""){
 swal ( 'Note:','Please Enter Payment Date','error');	
 return (false);
}
if(fopay_amt==""){
 swal ( 'Note:','Please Enter Amount','error');	
 return (false);
}
if(fo_disallowment==""){
 swal ( 'Note:','Please Enter Field Office disallowment','error');	
 return (false);
}
if(tds_amt==""){
 swal ( 'Note:','Please Enter Tds/Other Amount','error');	
 return (false);
}

document.form.ins.value='I';
document.form.submit();

}
</script>
<style>
input {
  vertical-align: middle;
  margin: 5px 10px 5px 0;
  padding: 10px;
  background-color: #fff;
  border: 1px solid black;
  width:100%;
}
.style1 {font-size: 16px}
.style3 {font-size: 24px}
</style>
</head>
<FORM method="post" name="form">
  <%@ include file = "sessionoutinc.jsp" %>
<%
List values=new ArrayList(); 


//String off_cd =request.getParameter("off_cd")==null?"1":(String)request.getParameter("off_cd") ;
String off_cd = SOFF_CD;

String state ="";
String off_name1 ="";
String invupid =request.getParameter("invupid")==null?"":(String)request.getParameter("invupid") ;
String BACK1=request.getParameter("MONTH_DT")==null?"":(String)request.getParameter("MONTH_DT") ;
String ANY_REMARKS="";
String fopay_dt="";
String fopay_amt="";
String fo_disallowment="";
String tds_amt="";
String PAYDETAILS="";
String TOTAL_AMT="";
String err="";

String add_update="I";
String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");



 DBCon db= new DBCon();
      db.connect(); 

if(!off_cd.equals("")){

StringBuffer poR = new StringBuffer();


poR.append(" SELECT "      );
poR.append(" to_char(boi.month_dt, 'DD-MON-RRRR') AS month_dt, "  );

poR.append(" to_char(boi.fopay_dt,'dd-mon-yyyy')as fopay_dt,  " );
poR.append(" boi.fopay_amt, " );
poR.append("  boi.paydetails,  " );
poR.append("  boi.any_remarks, " );
poR.append("  boi.fo_disallowment, " );
poR.append("  boi.tds_amt, " );
poR.append("  boi.invupid " );
poR.append(" FROM " );
poR.append(" bnf_onlineedp_inf boi  " );

poR.append(" WHERE  " );
poR.append(" to_char(boi.month_dt, 'DD-MON-RRRR') = '31-MAR-2022' " );
poR.append(" AND boi.off_cd = ? and boi.invupid =? " );

values.add (off_cd); 
values.add (invupid); 




//ResultSet rsMain = db.executeSQL(poR.toString(),values);

//ResultSet rsMain = db.execSQL(poR.toString());
 ResultSet rsMain = db.executeSQL(poR.toString(),values);
//out.print (poR.toString());



while (rsMain.next()){

invupid=rsMain.getString("invupid")==null?"1":rsMain.getString("invupid");
fopay_dt=rsMain.getString("fopay_dt")==null?"":rsMain.getString("fopay_dt");
fopay_amt=rsMain.getString("fopay_amt")==null?"":rsMain.getString("fopay_amt");
fo_disallowment=rsMain.getString("fo_disallowment")==null?"":rsMain.getString("fo_disallowment");
tds_amt=rsMain.getString("tds_amt")==null?"":rsMain.getString("tds_amt");
PAYDETAILS=rsMain.getString("PAYDETAILS")==null?"":rsMain.getString("PAYDETAILS");
ANY_REMARKS=rsMain.getString("ANY_REMARKS")==null?"":rsMain.getString("ANY_REMARKS");

add_update="U";


}
rsMain.close();

}






%>
<body>

<br>

<table width="50%" border="1" align="center" id="customers2">
<tr>
  <th colspan="3"><div align="center"><span class="style3">Payment Details Form (<%= BACK1 %>)</span></div></th>
  </tr>
<tr>
  <td  class="style1"><div align="center">(1)</div></td>
  <td  class="style1"> Field Office Payment Details*</td>
      <td  class="style1"><input type="text" name="PAYDETAILS" id="PAYDETAILS" value="<%= PAYDETAILS %>">
	  <input type="hidden" name="ins" id="ins" >	  </td>
  </tr>
    <tr>
      <td  class="style1"><div align="center">(2)</div></td>
      <td  class="style1">Payment Date*</td>
      <td  class="style1">
<input type="text"  name="fopay_dt" readonly="true" onClick="javascript:NewCssCal('fopay_dt','ddMMMyyyy')"  id="fopay_dt" value="<%= fopay_dt %>" /> </td>
    </tr>
    <tr>
      <td class="style1"><div align="center">(3)</div></td>
      <td class="style1"> Amount*</td>
      <td class="style1">
      <input type="text" id="fopay_amt" name="fopay_amt" value="<%=fopay_amt %>"></th>		     </td>
    </tr>
    <tr>
      <td class="style1"><div align="center">(4)</div></td>
      <td class="style1">Any Remarks</td>
      <td class="style1"><input type="text" name="ANY_REMARKS" id="ANY_REMARKS" value="<%=ANY_REMARKS %>">  </td>
    </tr>
    <tr>
      <td class="style1"><div align="center">(5)</div></td>
      <td class="style1"> Field Office disallowment*</td>
      <td class="style1"><input  type="text"  name="fo_disallowment" id="fo_disallowment" value="<%= fo_disallowment %>" required /></td>
    </tr>
    <tr>
      <td class="style1"><div align="center">(6)</div></td>
      <td class="style1"> Tds/Other Amount*</td>
      <td class="style1"><input  type="text"  name="tds_amt"  id="tds_amt" value="<%= tds_amt %>"required />    </td>
    </tr>
    <tr>
      <td colspan="3" align="center" class="style1">
      <a class="myButton"  href="samadhan_view.jsp">Go Back</a>
	  <input name="button" type="button" class="myButton" style="width:20%;" onClick="submitform();" value="Save" />
	  </td>
    </tr>
  </table>
  <%
				
		
  if ((String)request.getParameter("ins")!=null){

invupid=(String) request.getParameter("invupid")==null?"1":(String) request.getParameter("invupid").trim();
fopay_dt=(String) request.getParameter("fopay_dt")==null?"":(String) request.getParameter("fopay_dt").trim();
fopay_amt=(String) request.getParameter("fopay_amt")==null?"":(String) request.getParameter("fopay_amt").trim();
fo_disallowment=(String) request.getParameter("fo_disallowment")==null?"":(String) request.getParameter("fo_disallowment").trim();
tds_amt=(String) request.getParameter("tds_amt")==null?"":(String) request.getParameter("tds_amt").trim();
PAYDETAILS=(String) request.getParameter("PAYDETAILS")==null?"":(String) request.getParameter("PAYDETAILS").trim();
ANY_REMARKS=(String) request.getParameter("ANY_REMARKS")==null?"":(String) request.getParameter("ANY_REMARKS").trim();


List pstm=new ArrayList();
		StringBuffer qryUpdate = new StringBuffer();
		values.clear();
		
		pstm.clear();
		
try{

qryUpdate.append("	UPDATE BNF_ONLINEEDP_INF SET ");
qryUpdate.append("	fopay_dt = ?, ");
qryUpdate.append("	fopay_amt = ?, ");
qryUpdate.append("	fo_disallowment = ?, ");
qryUpdate.append("	tds_amt = ?, ");
qryUpdate.append("  PAYDETAILS = ?,");
qryUpdate.append("  ANY_REMARKS = ? ");
qryUpdate.append(" WHERE invupid = ?   ");


}
catch(Exception e){
out.print(e.toString());

}





values.add(fopay_dt); pstm.add ("L");
values.add(fopay_amt); pstm.add ("L");
values.add(fo_disallowment); pstm.add ("L");
values.add(tds_amt ); pstm.add ("L");
values.add(PAYDETAILS ); pstm.add ("L");
values.add(ANY_REMARKS ); pstm.add ("L");
values.add(invupid); pstm.add ("L");


						
db.setSqlValue(qryUpdate.toString()); 
db.setValues(values,pstm); 
db.executeUpdate() ;				
						
		//out.print ("invupid: "+invupid) ;			
						
					   
					db.close();
					response.sendRedirect("samadhan_view.jsp");
					
										
					}

%>

 </FORM> 
</body>
</html>


