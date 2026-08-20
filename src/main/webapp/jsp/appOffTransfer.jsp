<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<html>
<head>
<title>
</title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script src="../js/inlineMsgMain.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.1/jquery.min.js"></script>
<link href="../css/jquery-customselect.css" rel="stylesheet" />  
 <script src="../js/jquery-customselect.js"></script>

<script>
function form_submit(){

var UNIT_DIST_CD=form.UNIT_DIST_CD.value;
if (UNIT_DIST_CD != ""){
var OFF_CD=form.OFF_CD.value;
if (OFF_CD== "") {inlineMsg ('OFF_CD','Please Select Office Note: Change the Unit District to get the office name...........',2);	return (false);}
}

document.form.ins.value='I'; 
	document.form.submit();
}



 function getOffice(val) {
	$.ajax({
	type: "GET",
	url: "get_Office.jsp",
	data:'UNIT_DIST_CD='+val,
	success: function(data){
		$("#OFF_CD").html(data);
	}
	});
}

$(function() {
$("#UNIT_DIST_CD").customselect({
"csclass":"custom-select",  // Class to match
"search": true, // Is searchable?
"numitems":     5,    // Number of results per page
"searchblank":  false,// Search blank value options?
"showblank":    false, // Show blank value options?
"searchvalue":  false,// Search option values?
"hoveropen":    false,// Open the select on hover?
"emptytext":    "",   // Change empty option text to a set value
"showdisabled": false,// Show disabled options
"mobilecheck":  function() {// Mobile check function / boolean
  return navigator.platform && navigator.userAgent.match(/(android|iphone|ipad|blackberry)/i);
}});
});
</script>
</head>
<body>
 <form name="form" id="form"  class="form" method="post">
	    <%
		String APP_ID= request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID");
		String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");
		String vstare=(String) session.getAttribute("state_cd");
		DBCon db= new DBCon();
        db.connect();
		List values=new ArrayList();
        List pstm=new ArrayList();
		
        StringBuffer qrysb = new StringBuffer();
		qrysb.append(" SELECT AD.APP_ID,MOM.OFF_NAME,AD.ACT_ID,AD.OFF_CD,ASM.ACT_DESC,AD.APP_NAME,AD.UNIT_DIST_CD,TO_CHAR(AD.DOB,'DD-MON-YYYY') AS DOB,AD.MOB_NO1,AD.IND_TYPE,AD.E_MAIL,AD.AADHAR_NO,AD.PAN_NO," );
		qrysb.append(" AM.ACTIVITY_NAME,CASE when nvl(AD.dltfc_ce,0)+nvl(AD.dltfc_wc,0) > 0 then nvl(AD.dltfc_ce,0)+nvl(AD.dltfc_wc,0)  ");
		qrysb.append(" else  NVL(AD.MACHINARY_COST, 0) + NVL(AD.WORKING_CAPITAL,0) end  PROJECT_COST  ");
		qrysb.append(" FROM APP_DETAIL AD,ACTIVITY_MAST AM, MAS_OFF_MAST MOM ,APP_STATUS_MAST ASM ");
		qrysb.append(" WHERE ASM.ACT_ID=AD.ACT_ID AND AM.ACTIVITY_CD=AD.ACTIVITY_CD AND AD.OFF_CD= MOM.OFF_CD AND AD.APP_ID='"+APP_ID+"' ");

		ResultSet rsMain = db.execSQL(qrysb.toString());
		values.clear();
        pstm.clear(); 
		
String ACT_DESC="";
String APP_NAME="";
String OFF_CD="";
String DOB="";
String MOB_NO1="";
String IND_TYPE="";
String E_MAIL="";
String AADHAR_NO="";
String PAN_NO="";
String ACTIVITY_NAME="";
String UNIT_DIST_CD="";
String PROJECT_COST="";
String ACT_ID="";
String OFF_NAME="";

	
  while(rsMain.next())
  {			
	  APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");	
	  APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
	  AADHAR_NO=rsMain.getString("AADHAR_NO")==null?"":rsMain.getString("AADHAR_NO");
	  PAN_NO=rsMain.getString("PAN_NO")==null?"":rsMain.getString("PAN_NO");
	  MOB_NO1=rsMain.getString("MOB_NO1")==null?"":rsMain.getString("MOB_NO1");
	  E_MAIL=rsMain.getString("E_MAIL")==null?"":rsMain.getString("E_MAIL");
	  IND_TYPE=rsMain.getString("IND_TYPE")==null?"":rsMain.getString("IND_TYPE");
	  ACTIVITY_NAME=rsMain.getString("ACTIVITY_NAME")==null?"":rsMain.getString("ACTIVITY_NAME");
	  DOB=rsMain.getString("DOB")==null?"":rsMain.getString("DOB");
	  OFF_CD=rsMain.getString("OFF_CD")==null?"":rsMain.getString("OFF_CD");
	  UNIT_DIST_CD=rsMain.getString("UNIT_DIST_CD")==null?"":rsMain.getString("UNIT_DIST_CD");
	  ACT_ID=rsMain.getString("ACT_ID")==null?"":rsMain.getString("ACT_ID");
	  PROJECT_COST=rsMain.getString("PROJECT_COST")==null?"":rsMain.getString("PROJECT_COST");
	  OFF_NAME=rsMain.getString("OFF_NAME")==null?"":rsMain.getString("OFF_NAME");
	  ACT_DESC=rsMain.getString("ACT_DESC")==null?"":rsMain.getString("ACT_DESC");	
	 }
			rsMain.close();
			
		ResultSet rsDoc=db.execSQL("SELECT DISTRICT_CD,DISTRICT_NAME FROM M_DISTRICT WHERE DISTRICT_STATUS='A' AND STATE_CD='"+vstare+"' ");		
		
        %>

  <table align="center">
  <th colspan="4"><div align="center"> 
     
 TRASFER TO OTHER OFFICE 
 <input name="ins" type="hidden" id="ins" value="<%= ins %>">
  <input name="ACT_ID" type="hidden" id="ACT_ID" value="<%= ACT_ID %>">
  </div></th>

<tr bgcolor="#FF9E5E" >
    <td colspan="4">Note: Unit District and Office can be Change only before Approve or Reject/Return by the DLTFC Convenor and forward to Bank. </td>
    </tr>

 <tr>
   <th>Present Office Name </th>
   <td ><%=OFF_NAME%></td>
   <th >Current Status Of Application </th>
   <td ><%=ACT_DESC %></td>
 </tr>
 <tr>
 <th>Applicant_ID</th>
    <td ><%=APP_ID%></td>
    <th >Applicant Name </th>
   
    <td ><%=APP_NAME %></td>
    </tr>
	  
	   <th>Adhaar No: </th>
	
    <td><%=AADHAR_NO %> </td>
    <th >Pan No </th>
  <td>  <%=PAN_NO%></td></tr>
  <tr>
  <th >Mobile No </th>
  <td><%=MOB_NO1 %></td>


  
  <th >Email_Id</th>
  <td><%=E_MAIL%></td>
  </tr>
  <tr>
  <th >Industry Type </th>
  <td><%=IND_TYPE %></td>
  <th >Industry</th>
  <td><%=ACTIVITY_NAME%></td>
   </tr>
  <tr>
    <th>Date of Birth</th>
    <td><%=DOB%></td>
    <th>Project Cost</th>
    <td><%=PROJECT_COST%></td>
  </tr>
  <tr>
    <th >Unit District </th>
    <td colspan="2"><select name="UNIT_DIST_CD"  id="UNIT_DIST_CD" onChange="getOffice(this.value);" class="custom-select">
      <% 
			
			String vDISTRICT_CD="";
			String vDISTRICT_NAME="";
			 while (rsDoc.next()) {
			 vDISTRICT_CD=rsDoc.getString("DISTRICT_CD")==null?"":rsDoc.getString("DISTRICT_CD");
			 vDISTRICT_NAME=rsDoc.getString("DISTRICT_NAME")==null?"":rsDoc.getString("DISTRICT_NAME");
			  %>
      <option value="<%= vDISTRICT_CD %>"<% if (vDISTRICT_CD.equals(UNIT_DIST_CD)){out.print("selected");}%>><%=  vDISTRICT_NAME %></option>
      <%}
			rsDoc.close();
			%>
    </select></td>
    <td><span class="GreenLebel">( Change the Unit District to get Office Name)</span></td>
  </tr>
  <tr>
    <th colspan="2" class="mtextarea">Select Office to be Transfer </th>
    <td colspan="2"><select name="OFF_CD" class="info" id="OFF_CD" value="<%=OFF_CD%>"  onFocus="getOffice(document.form.UNIT_DIST_CD.value);" >
      <option value="">--Select--</option>
    </select>      </td>
    </tr>
  <tr>
  <th colspan="4" nowrap class="warning">Note: Once The application will Tranfer to another office, this will not visible to <br>your login and you will not be able to revert......, Please Confirm correctness before Tranfer........ </th>
  </tr>
  <tr>
 
    <th colspan="4"><div align="center">
        <input name="btnClose" type="button" class="button" id="btnClose" value="Close Form" onClick="window.parent.HideModalWindow();">
        <input name="btnUpload" type="button" class="button" id="btnUpload" value="Transfer" onClick="form_submit();">
    </div></th>
    </tr> 
	 
  </table>
   <%
			
     
			if (ins.equals("I")) {
		
        OFF_CD = request.getParameter("OFF_CD")==null?"0":request.getParameter("OFF_CD");
        UNIT_DIST_CD=request.getParameter("UNIT_DIST_CD")==null?"0":request.getParameter("UNIT_DIST_CD");	    
		APP_ID=request.getParameter("APP_ID")==null?"":request.getParameter("APP_ID");		
	   
	    StringBuffer sb= new StringBuffer();
		sb.append("  UPDATE APP_DETAIL SET  ").
		append("   OFF_CD=?, UNIT_DIST_CD=?,MTG_ID=NULL,DLTFC_PROC_DT=NULL WHERE APP_ID=? AND ACT_ID<4 ");
		db.setSqlValue(sb.toString());
        db.setValues(values,pstm); 
		values.add (OFF_CD);pstm.add ("D");			
		values.add (UNIT_DIST_CD);pstm.add ("D"); 
		values.add (APP_ID);pstm.add ("D");         
		db.executeUpdate();		
		values.clear();
        pstm.clear();		
		 db.close();
		response.sendRedirect("savemsg.jsp");
		return;
			}
		
			
			%>
</table>    
</form>
</body>
</html>