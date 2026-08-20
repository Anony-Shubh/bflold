<%@ page session="true"  buffer="300kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%@ include file="IncludeHeader.jsp" %>

<html>
<head>

 <link rel="stylesheet" type="text/css" href="../css/dis.css">
<script type="text/javascript" src="../js/inlineMsgMain.js"></script>

<style>
textbox[readonly="true"] {
  color:#CCCCCC;
}

</style>
<script language="javascript">
 function form_submit(){ 
 
    var emailRegex = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/;
    var numberOnly= /^[0-9 \.-]+$/;
    var nameRegex = /^[a-zA-Z]+(([\'\,\.\- ][a-zA-Z ])?[a-zA-Z]*)*$/;
    var mobileno = /^[789]\d{9}$/;
	
	var BR_IFSL_CODE = document.form.BR_IFSL_CODE.value; 
	var DISTRICT_NAME = document.form.DISTRICT_NAME.value; 
	var DISTRICT = document.form.DISTRICT.value;	
	var BRANCH_NAME =document.form.BRANCH_NAME.value; 
	var EMAIL = document.form.EMAIL.value; 
	var CONT_NAME= document.form.CONT_NAME.value;
	var DESIG= document.form.DESIG.value;
	var CONT_NO= document.form.CONT_NO.value;
	
	if (BR_IFSL_CODE== "") {	 inlineMsg ( 'BR_IFSL_CODE','INVALID BRANCH_IFS_CODE ',2);	return (false);}	
	if (DISTRICT_NAME== "") {	 inlineMsg ( 'DISTRICT_NAME','ENTER DISTRICT_NAME',2);	return (false);}	
	if (!nameRegex.test(DISTRICT)) {	 inlineMsg ( 'DISTRICT_NAME','PLEASE ENTER VALID DISTRICT NAME',2);	return (false);}	
	if (BRANCH_NAME== "") {	 inlineMsg ( 'BRANCH_NAME','ENTER BRANCH_NAME',2);	return (false);} 
	if (!nameRegex.test(BRANCH_NAME)) {	 inlineMsg ( 'BRANCH_NAME','PLEASE ENTER VALID BRANCH NAME',2);	return (false);}	
	if (EMAIL== "") {	 inlineMsg ( 'EMAIL','ENTER EMAIL-ID',2);	return (false);} 
    if (!emailRegex.test(EMAIL)) {	 inlineMsg ( 'EMAIL','INVALID EMAIL-ID',2);	return (false);}	
	
	if ((CONT_NAME != "") || (DESIG != "")|| (CONT_NO != ""))
	{
		if (CONT_NAME== "") {	 inlineMsg ( 'CONT_NAME','ENTER CONTACT PERSON NAME',2);	return (false);} 
		if (!nameRegex.test(CONT_NAME)) {	 inlineMsg ( 'CONT_NAME','PLEASE ENTER VALID NAME',2);	return (false);}	
		if (DESIG== "") {	 inlineMsg ( 'DESIG','ENTER DESIGNATION',2);	return (false);} 
		if (!nameRegex.test(DESIG)) {	 inlineMsg ( 'DESIG','PLEASE ENTER VALID DESIGNATION',2);	return (false);}	
		if (CONT_NO== "") {	 inlineMsg ( 'CONT_NO','ENTER MOBILE NO',2);	return (false);} 
        if (!numberOnly.test(Number(CONT_NO))) { inlineMsg ( 'CONT_NO','INVALID MOBILE NO',2);	return (false);}
		if (!mobileno.test(CONT_NO)) {inlineMsg  ( 'CONT_NO','ENTER VALID MOBILE_NO',2);	return (false);}
       	
	}
	
	document.form.ins.value='I';
	document.form.submit();

}
</script>

<script language="javascript">
	function populateValue(vname,vname1) {
var str=document.getElementsByName(""+vname+"")[0].value
var fn=str.indexOf("("); 
var fnLast=str.indexOf(")"); 
fnLast=fnLast;
fn=fn+1;
//var len=str.length;
//len=len-1;
var getcd=str.substring(fn,fnLast);
getcd =getcd.replace(/^\s+|\s+$/gm,'');

if (fn=='0') {
document.getElementsByName(""+vname+"")[0].value='';

}else {
document.getElementsByName(""+vname1+"")[0].value=getcd;
}

}

</script>
   </head>
   <body>
   
<form method="post" name="form" id="form" action="updateProfile.jsp">


<%

String IFSC_CODE= request.getParameter("IFSC_CODE")==null?"":(String) request.getParameter("IFSC_CODE");
String HIRONE="";
String HIRTWO="";
String WRD_PW = "";
String ins= request.getParameter("ins")==null?"":(String) request.getParameter("ins");
		DBCon db= new DBCon();
        db.connect();
		List values=new ArrayList();
        List pstm=new ArrayList();
		


        StringBuffer qrysb = new StringBuffer();
		qrysb.append(" SELECT BBM.BR_IFSL_CODE,BBM.STATE,BBM.DISTRICT,BBM.BRANCH_NAME,BBM.EMAIL,BBM.DISTRICT|| ' '|| BBM.STATE||' ('||BBM.DISTRICT ||')' AS DISTRICT_NAME,BBM.HIRONE,BBM.HIRTWO, " );
		qrysb.append(" BBM.TRANS_ACNO,BBM.CONT_NAME,BBM.DESIG,BBM.CONT_NO FROM BANK_BR_MAST BBM ");
		qrysb.append(" WHERE BR_IFSL_CODE=? AND N_IFSC_CODE=? ");
		values.add (IFSC_CODE);pstm.add ("D");
		values.add (IFSL_CODE);pstm.add ("D");
		
		//out.print (qrysb.toString());
		ResultSet rsUP = db.executeSQL(qrysb.toString(),values);
		values.clear();
		 pstm.clear();
		values.add (IFSL_CODE);pstm.add ("D");
		
		ResultSet rsHirone = db.executeSQL("SELECT HIRONE FROM BANK_BR_MAST WHERE N_IFSC_CODE=? GROUP BY HIRONE ",values);
		ResultSet rsHirtwo = db.executeSQL("SELECT HIRTWO FROM BANK_BR_MAST WHERE N_IFSC_CODE=? GROUP BY HIRTWO ",values);
		 values.clear();
         pstm.clear();
		
		

String STATE="";
String DISTRICT="";
String DISTRICT_NAME="";
String BRANCH_NAME="";
String EMAIL="";
String TRANS_ACNO="";
String CONT_NAME="";
String DESIG="";
String CONT_NO="";
String BR_IFSL_CODE="";
 while(rsUP.next())
  {			
BR_IFSL_CODE=rsUP.getString("BR_IFSL_CODE")==null?"":rsUP.getString("BR_IFSL_CODE");
STATE =rsUP.getString("STATE")==null?"":rsUP.getString("STATE");	
DISTRICT =rsUP.getString("DISTRICT")==null?"":rsUP.getString("DISTRICT");	
DISTRICT_NAME=rsUP.getString("DISTRICT_NAME")==null?"":rsUP.getString("DISTRICT_NAME");
BRANCH_NAME =rsUP.getString("BRANCH_NAME")==null?"":rsUP.getString("BRANCH_NAME");	
EMAIL =rsUP.getString("EMAIL")==null?"":rsUP.getString("EMAIL");	
TRANS_ACNO =rsUP.getString("TRANS_ACNO")==null?"":rsUP.getString("TRANS_ACNO");	
CONT_NAME =rsUP.getString("CONT_NAME")==null?"":rsUP.getString("CONT_NAME");	
DESIG =rsUP.getString("DESIG")==null?"":rsUP.getString("DESIG");	
CONT_NO=rsUP.getString("CONT_NO")==null?"":rsUP.getString("CONT_NO");	
HIRONE=rsUP.getString("HIRONE")==null?"":rsUP.getString("HIRONE");	
HIRTWO=rsUP.getString("HIRTWO")==null?"":rsUP.getString("HIRTWO");	
									 		
  }
  
rsUP.close();



ResultSet rsMax= db.execSQL("SELECT round(dbms_random.value(11111111,99999999),0) AS RAND_PWD FROM DUAL  ");
while (rsMax.next()) {
	WRD_PW=rsMax.getString("RAND_PWD");

}
rsMax.close();





%>



<p></p>
<p>&nbsp;</p>
  <table width="880" border="1" align="center" bordercolor="#000066" bgcolor="#CCCCCC">

  <tr bgcolor="#FF9966"><th height="58" colspan="4"><div align="center"> <h2>
     
 FINANCING BRANCH RESET PASSWORD</h2>
      <input name="ins" type="hidden" id="ins" value="<%= ins %>   ">
  </div></th>



 <tr>
 <th width="121" height="43" bgcolor="#CCCCCC">IFS_CODE</th>
    <td width="385" bgcolor="#CCCCCC" ><input name="BR_IFSL_CODE" type="text" id="BR_IFSL_CODE"  value="<%=BR_IFSL_CODE %>" size="20" maxlength="11" readonly="true" class="background-color: yellow;" ></td>
    <th width="177" bgcolor="#CCCCCC" >STATE</th>
   
    <td width="169" bgcolor="#CCCCCC" > <input name="STATE" type="text" id="STATE" value="<%=STATE%>" maxlength="120"  readonly="true"> </td>
    </tr>
	  <tr>
	 <th bgcolor="#CCCCCC">DISTRICT </th>
	<td bgcolor="#CCCCCC"><input name="DISTRICT_NAME" type="text" id="DISTRICT_NAME" value="<%=DISTRICT_NAME %>" onBlur="populateValue('DISTRICT_NAME','DISTRICT');" size="40" maxlength="40">	
    <input name="DISTRICT" type="hidden" id="DISTRICT" value="<%=DISTRICT%>"  ></td> 
  
   
	 
   
  
  <th bgcolor="#CCCCCC" >BRANCH_NAME</th>
  <td bgcolor="#CCCCCC">  <input name="BRANCH_NAME" type="text" id="BRANCH_NAME" value="<%=BRANCH_NAME%>" maxlength="120">    </td></tr>
  <tr>
  <th bgcolor="#CCCCCC" >EMAIL-ID</th>
  <td bgcolor="#CCCCCC">  <input name="EMAIL" type="text" id="EMAIL" value="<%=EMAIL %>" maxlength="60" size="40">
    </td> 
	<th bgcolor="#CCCCCC" >TRANSIENT_ACCOUNT_NO</th>
  <td bgcolor="#CCCCCC">  <input name="TRANS_ACNO" type="text" id="TRANS_ACNO" value="<%= TRANS_ACNO %>" maxlength="60" size="40" readonly="true">
    </td>
  </tr>
  <tr>
    <th bgcolor="#CCCCCC" >ZONE/ HIR ONE:</th>
    <td bgcolor="#CCCCCC"><select id="HIRONE" name="HIRONE" >
      <option value="-">-</option>
	  <% 
	  
	  String vhirone="";
	  while ( rsHirone.next() ) {
	  vhirone=rsHirone.getString(1)==null?"-":rsHirone.getString(1);
	  
	  %>
	  
	    <option value="<%= rsHirone.getString(1) %>" <% if ( vhirone.equals(HIRONE) ) { out.print("Selected"); }%>><%= rsHirone.getString(1) %></option>
		
		<%
		}  
		rsHirone.close();
		%>
    </select></td>
    <th bgcolor="#CCCCCC" ><div align="right">REGION/HIR TWO :</div></th>
    <td bgcolor="#CCCCCC">
	<select id="HIRTWO" name="HIRTWO">
      <option value="-">-</option>
	   <%
	    String vhirtwo="";
	    while ( rsHirtwo.next() ) {
		 vhirtwo=rsHirtwo.getString(1)==null?"-":rsHirtwo.getString(1);
		
		%>
	    <option value="<%= rsHirtwo.getString(1) %>" <% if ( vhirtwo.equals(HIRTWO) ){ out.print("Selected"); }%>><%= rsHirtwo.getString(1) %></option>
		<%
		}  
		rsHirtwo.close();
		%>
    </select>
	
	
	&nbsp;</td>
  </tr> 
  </table>
  <BR/>
   <table width="880" border="1" align="center" bordercolor="#000066" bgcolor="#CCCCCC">
    <tr bgcolor="#FF9966" class="style60">
      <td height="51" colspan="4"><div align="center" class="style98"><strong> <h2>CONTACT PERSON DETAILS </h2></strong></div></td>
    </tr>
  <tr bgcolor="#CCCCCC">
      <th width="76"><div align="center">Sr. No. </div></th>
      <th width="309"><div align="center">Name </div></th>
      <th width="232"><div align="center">Mobile No </div></th>
      <th width="243"><div align="center">Designation</div></th>
	   <input name="WRD_PW" type="hidden" id="WRD_PW" value="<%=WRD_PW%>">
    </tr>
  
   <tr bgcolor="#CCCCCC"> 
      <td class="style60">(1)</td>

  <td>  <input name="CONT_NAME" type="text" id="CONT_NAME" value="<%=CONT_NAME%>" maxlength="30"></td>
  
  <td>  <input name="CONT_NO" type="text" id="CONT_NO" value="<%=CONT_NO %>" maxlength="10"></td>  
  
  <td>  <input name="DESIG" type="text" id="DESIG" value="<%=DESIG%>" maxlength="50"> </td>
  </tr>
  
  
  
  
   
  <tr>
    <td colspan="2" bgcolor="#CCCCCC"> 
        <div align="right">           </div></td>
    <td colspan="2" bgcolor="#CCCCCC"><input name="Button" type="button" class="button" onClick="form_submit();" value="RESET FINANCING BRANCH PASSWORD"></td>
    </tr>
  </table>
  
  <%
  try {
if (ins.equals("I")){
BR_IFSL_CODE=(String) request.getParameter("BR_IFSL_CODE")==null?"":(String) request.getParameter("BR_IFSL_CODE");
DISTRICT =(String) request.getParameter("DISTRICT")==null?"":(String) request.getParameter("DISTRICT");
BRANCH_NAME =(String) request.getParameter("BRANCH_NAME")==null?"":(String) request.getParameter("BRANCH_NAME");
EMAIL =(String) request.getParameter("EMAIL")==null?"":(String)request.getParameter("EMAIL");		
TRANS_ACNO =(String)request.getParameter("TRANS_ACNO")==null?"":(String) request.getParameter("TRANS_ACNO");	
CONT_NAME =(String)request.getParameter("CONT_NAME")==null?"":(String)request.getParameter("CONT_NAME");	
DESIG =(String)request.getParameter("DESIG")==null?"":(String)request.getParameter("DESIG");	
CONT_NO=(String)request.getParameter("CONT_NO")==null?"":(String)request.getParameter("CONT_NO");
HIRONE=(String)request.getParameter("HIRONE")==null?"":(String)request.getParameter("HIRONE");
HIRTWO=(String)request.getParameter("HIRTWO")==null?"":(String)request.getParameter("HIRTWO");
	
	session.setAttribute("IFSC_CODE",BR_IFSL_CODE);
	session.setAttribute("EMAIL",EMAIL);
StringBuffer sb = new StringBuffer();
		 sb.append("   UPDATE  BANK_BR_MAST SET DISTRICT=?, BRANCH_NAME=?, EMAIL=?,   ").
             append("   TRANS_ACNO=?,  CONT_NAME=?,  DESIG=?,  CONT_NO=?, PSSWD=? ,HIRONE=?,HIRTWO=?  WHERE BR_IFSL_CODE =? AND N_IFSC_CODE=?   ");

db.setSqlValue(sb.toString());
        db.setValues(values,pstm); 
		
  values.add(DISTRICT);pstm.add("D");
  values.add(BRANCH_NAME);pstm.add("D");
  values.add(EMAIL);pstm.add("D");
  values.add(TRANS_ACNO);pstm.add("D");
  values.add(CONT_NAME);pstm.add("D");
  values.add(DESIG);pstm.add("D");
  values.add(CONT_NO);pstm.add("D");
  values.add(WRD_PW);pstm.add("D");
  values.add(HIRONE);pstm.add("D");
  values.add(HIRTWO);pstm.add("D");
  values.add(BR_IFSL_CODE);pstm.add("D");
  values.add(IFSL_CODE);pstm.add("D");
  
  
 db.executeUpdate();
 	 values.clear();
  pstm.clear();	
  db.close();
	response.sendRedirect("sendMail.jsp");

  }
  }
  catch (Exception e) {
	  //out.print(e);
	  
}
	
	   
  %>
 </form>
 <script>
jQuery(function(){
$("#DISTRICT_NAME").autocomplete("itemlov.jsp");
});
   </script>
	
  </table> 
 
   <table class="pmegpTable"><br>
<tr>
<th>
 
  </th>
  </tr>
  </table>
 


</script>
  </form>
  </body>
  </html>

