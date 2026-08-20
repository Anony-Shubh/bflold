<%@ page session="true"  import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="pkgPmegpNew.validateAutoForward"%>
<%
response.setContentType("text/html");
response.setHeader("Cache-control","no-cache");
response.setHeader("Cache-control","private");
%>



<html>
<head>
<title>PMEGP Agency Status Update Form</title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script language="javascript" src="../js/inlineMsgMain.js"></script>


<script language="javascript">

function chMd()
 {	
	var actid=document.form.ACT_ID.value;

     if( actid == "4")
     {
		 document.forms[0].DLTFC_CE.disabled=false;
        document.forms[0].DLTFC_WC.disabled=false;
		document.forms[0].DLTFC_CE.value=document.form.PROP_CE.value;
        document.forms[0].DLTFC_WC.value=document.form.PROP_WC.value;
		
		
           
     }
     else if( actid == "7")
     {
      
        document.forms[0].DLTFC_CE.disabled=true;
        document.forms[0].DLTFC_WC.disabled=true;
		document.forms[0].DLTFC_CE.value=0
        document.forms[0].DLTFC_WC.value=0;
        document.forms[0].DLTFC_CE.style.backgroundColor="#A0A0A0";
        document.forms[0].DLTFC_WC.style.backgroundColor="#A0A0A0";
      
     }
       

	
	var ce=document.form.DLTFC_CE.value;	
	var we=document.form.DLTFC_WC.value;	
	var tcewe=Number(ce)+Number(we);
	document.form.DLTFC_TOTAL.value=tcewe;	
	}
	
	function loan_calc(){
		var ce=document.form.DLTFC_CE.value;	
	var we=document.form.DLTFC_WC.value;	
	var tcewe=Number(ce)+Number(we);
	document.form.DLTFC_TOTAL.value=tcewe;
	
	}	
	
function submit_form () {
if(!document.getElementsByName("ACT_ID")[1].checked && !document.getElementsByName("ACT_ID")[2].checked)
{
	inlineMsg ('ACT_ID','Please Select Current Status',2);
          return false;
        }
        	
 document.form.ins.value='I'; 
 document.form.submit()
}
</script>
<style type="text/css">
<!--
.style2 {color: #A0A0A0}
-->
</style>
</head>
<body>
<form   name="form" id ="form" method="post" >
<%
String  APP_ID =request.getParameter("APP_ID")==null?"":(String)request.getParameter("APP_ID");

String OFF_CD = (String) session.getAttribute("sOffCd");
String ACT_ID = "";
String MTG_ID = "";
String APP_NAME = "";
String ACTIVITY_NAME = "";
String PROD_DESC = "";
String PROP_CE = "";
String PROP_WC = "";
String PROP_PROJ_TOTAL = "";
String MT_DATE = "";
String ONLINE_SUBDT = "";
String FORD_DT_DLTFC = "";
String UNIT_DIST = "";
String MTG_PLACE = "";
String MTG_DIST = "";
String ACT_DESC = "";
String AGENCY_REMARKS="";
String DLTFC_REMARK="";
String IFSC_CODE="";
String EDU_ID="";
String IND_TYPE="";

String VALID_DATA="Y";
String DLTFC_CE = "";
String DLTFC_WC = "";
String DLTFC_TOTAL = "";
ArrayList aerror = new ArrayList();
DBCon db= new DBCon();
db.connect();
StringBuffer qrysb= new StringBuffer();
qrysb.append("   SELECT"      );
qrysb.append("   AD.APP_ID,"      );
qrysb.append("   AD.ACT_ID,A.MTG_ID,AD.IND_TYPE,AD.EDU_ID,"      );
qrysb.append("   UPPER(AD.APP_NAME) AS APP_NAME,AD.REMARKS AS AGENCY_REMARKS, IFSC_CODE,"      );
qrysb.append("   AM.ACTIVITY_NAME,AD.PROD_DESC, AD.DLTFC_REMARK, "      );
qrysb.append("   NVL(AD.MACHINARY_COST,0) AS PROP_CE,"      );
qrysb.append("   NVL(AD.WORKING_CAPITAL,0) AS PROP_WC,"      );
qrysb.append("   NVL(AD.MACHINARY_COST,0)+NVL(AD.WORKING_CAPITAL,0) AS PROP_PROJ_TOTAL,"      );
qrysb.append("   to_Char(A.MT_DATE,'dd-mon-yyyy') as MT_DATE,"      );
qrysb.append("   to_Char(AD.ONLINE_SUBDT,'dd-mon-yyyy') as ONLINE_SUBDT,"      );
qrysb.append("   to_Char(AD.FORD_DT_DLTFC,'dd-mon-yyyy') as FORD_DT_DLTFC,"      );
qrysb.append("   B.DISTRICT_NAME AS UNIT_DIST,"      );
qrysb.append("   A.MTG_PLACE,"      );
qrysb.append("   B.DISTRICT_NAME AS MTG_DIST,"      );
qrysb.append("   ASM.ACT_DESC , AD.DLTFC_CE,AD.DLTFC_WC "      );
qrysb.append("   FROM APP_MEETING_MAST A,M_DISTRICT B,APP_DETAIL AD, "      );
qrysb.append("   APP_STATUS_MAST ASM, M_DISTRICT UMD,ACTIVITY_MAST AM"      );
qrysb.append("   WHERE A.DISTRICT_CD=B.DISTRICT_CD AND A.OFF_CD=?"      );
qrysb.append("   AND AD.ACTIVITY_CD=AM.ACTIVITY_CD AND AD.APP_ID=?"      );
qrysb.append("   AND A.MTG_ID=AD.MTG_ID "      );
qrysb.append("   AND AD.ACT_ID=ASM.ACT_ID"      );
qrysb.append("   AND AD.UNIT_DIST_CD=UMD.DISTRICT_CD"      );
qrysb.append("   ORDER BY A.MT_DATE DESC"      );


List valuesq = new ArrayList();
valuesq.add(OFF_CD);
valuesq.add(APP_ID);

   ResultSet rsApp = db.executeSQL(qrysb.toString(),valuesq);
   valuesq.clear();

while (rsApp.next()){

APP_ID=rsApp.getString("APP_ID")==null?"":rsApp.getString("APP_ID");
ACT_ID=rsApp.getString("ACT_ID")==null?"":rsApp.getString("ACT_ID");
MTG_ID=rsApp.getString("MTG_ID")==null?"":rsApp.getString("MTG_ID");
APP_NAME=rsApp.getString("APP_NAME")==null?"":rsApp.getString("APP_NAME");
ACTIVITY_NAME=rsApp.getString("ACTIVITY_NAME")==null?"":rsApp.getString("ACTIVITY_NAME");
PROD_DESC=rsApp.getString("PROD_DESC")==null?"":rsApp.getString("PROD_DESC");
PROP_CE=rsApp.getString("PROP_CE")==null?"":rsApp.getString("PROP_CE");
PROP_WC=rsApp.getString("PROP_WC")==null?"":rsApp.getString("PROP_WC");
PROP_PROJ_TOTAL=rsApp.getString("PROP_PROJ_TOTAL")==null?"":rsApp.getString("PROP_PROJ_TOTAL");
MT_DATE=rsApp.getString("MT_DATE")==null?"":rsApp.getString("MT_DATE");
ONLINE_SUBDT=rsApp.getString("ONLINE_SUBDT")==null?"":rsApp.getString("ONLINE_SUBDT");
FORD_DT_DLTFC=rsApp.getString("FORD_DT_DLTFC")==null?"":rsApp.getString("FORD_DT_DLTFC");
UNIT_DIST=rsApp.getString("UNIT_DIST")==null?"":rsApp.getString("UNIT_DIST");
MTG_PLACE=rsApp.getString("MTG_PLACE")==null?"":rsApp.getString("MTG_PLACE");
MTG_DIST=rsApp.getString("MTG_DIST")==null?"":rsApp.getString("MTG_DIST");
ACT_DESC=rsApp.getString("ACT_DESC")==null?"":rsApp.getString("ACT_DESC");
AGENCY_REMARKS=rsApp.getString("AGENCY_REMARKS")==null?"":rsApp.getString("AGENCY_REMARKS");
DLTFC_REMARK=rsApp.getString("DLTFC_REMARK")==null?"":rsApp.getString("DLTFC_REMARK");
DLTFC_CE=rsApp.getString("DLTFC_CE")==null?"":rsApp.getString("DLTFC_CE");
DLTFC_WC=rsApp.getString("DLTFC_WC")==null?"":rsApp.getString("DLTFC_WC");
IFSC_CODE=rsApp.getString("IFSC_CODE")==null?"":rsApp.getString("IFSC_CODE");
IND_TYPE=rsApp.getString("IND_TYPE")==null?"":rsApp.getString("IND_TYPE");
EDU_ID=rsApp.getString("EDU_ID")==null?"":rsApp.getString("EDU_ID");
}

rsApp.close();
%>
  <div>
  <table align="center">
    <tr>
      <th colspan="4"><div align="center">APPLICANT CURRENT STATUS UPDATE BY CONVENOR DLTFC </div></th>
    </tr>
    <tr>
      <th><input name="ins" type="hidden" id="ins"><input name="IND_TYPE"  value="<%=IND_TYPE%>" type="hidden" id="IND_TYPE">
	  <input name="EDU_ID" type="hidden" id="EDU_ID" value="<%=EDU_ID%>">
      Applicant Id : </th>
      <th><%=APP_ID %> </th>
      <th><div align="right">Name Of Applicant :</div></th>
      <th><%=  APP_NAME %></th>
    </tr>
    <tr >
      <th>Industry/Activity:</th>
      <th colspan="3"><%=ACTIVITY_NAME %> (<%=PROD_DESC %>) </th>
    </tr>
    <tr >
      <th rowspan="2">Proposed Project Cost by Applicant: </th>
      <th><div align="center">Capital Expenditure (CE) </div></th>
      <th><div align="center">Working Capital (WC) </div></th>
      <th><div align="center">Total (CE+WC)</div></th>
    </tr>
    <tr >
      <td><div align="center">Rs.
        <input name="PROP_CE" type="text" id="PROP_CE"  size="10" maxlength="7"  value="<%= PROP_CE %>" readonly="true">
      </div></td>
      <td><div align="center">Rs.<input name="PROP_WC" type="text" id="PROP_WC"  size="10" maxlength="7"  value="<%=  PROP_WC %>" readonly="true"></div></td>
      <td><div align="center">Rs.<%=  PROP_PROJ_TOTAL  %></div></td>
    </tr>
    <tr >
      <th>Forwarding Date to DLTFC: </th>
      <th><%=  FORD_DT_DLTFC %></th>
      <th><div align="right">Meeting Date : </div></th>
      <th><%=  MT_DATE %></th>
    </tr>
    <tr >
      <th>Meeting Place and District: </th>
      <th colspan="3"><%=  MTG_PLACE %>, Dist:<%=  MTG_DIST %>
          <input name="ACT_ID" type="radio" disabled id="radio" value="4" <% if (ACT_ID.equals("2")){out.print("Checked");}%>>
          </th>
    </tr>
    <tr >
      <th colspan="4"><div align="center" class="redLebel">(Note: On Change of Current Status, Automatically message will be sent to applicant through SMS/eMail) </div></th>
    </tr>
    <tr valign="middle">
      <th><div align="right">Select Current Status: * </div></th>
      <td colspan="3" ><input name="ACT_ID" value="4"  onClick="chMd()" type="radio">
      Approved by DLTFC
        <input name="ACT_ID" id="ACT_ID"  type="radio" value="7" onClick="chMd()">
        <span class="redLebel"> Rejected by DLTFC </span></td>
    </tr>
    <tr >
      <th rowspan="3" >Approved Project Cost by DLTFC: </th>     
    </tr>
    <tr >
      <th >Capital Expenditure (CE) </th>
      <th >Working Capital (WC) </th>
      <th >Total (CE+WC) </th>
    </tr>
    <tr >
      <td ><div align="center"> Rs.
              <input name="DLTFC_CE" type="text" id="DLTFC_CE" size="10"  onChange="loan_calc()" maxlength="7" value="<%=DLTFC_CE%>"> 
              
              </div></td>
      <td ><div align="center"> Rs.
              <input name="DLTFC_WC" type="text" id="DLTFC_WC"  size="10"   onChange="loan_calc()"  maxlength="7" value="<%=DLTFC_WC%>">
      </div></td>
      <td ><div align="center"> Rs.
              <input name="DLTFC_TOTAL" type="text" id="DLTFC_TOTAL"   onChange="loan_calc()"  value="" size="10"   maxlength="7" readonly="true">
      </div></td>
    </tr>
    <tr >
      <th ><div align="right">Remarks by DLTFC : </div></th>
      <td colspan="3" ><input name="DLTFC_REMARK" type="text" id="DLTFC_REMARK" size="100" maxlength="100"   value="<%= DLTFC_REMARK %>">
      </td>
    </tr>
    <tr>
      <th colspan="4"> <div align="center">
          <input name="Button2" type="button" class="button"  onClick="window.parent.HideModalWindow();" value="Cancel">
          <input name="Button" type="button" class="button"  onClick="submit_form();" value="Save  Record">
      </div></th>
    </tr>
  </table>
  <%

if ((String)request.getParameter("ins")!=null){

VALID_DATA="Y";
APP_ID=(String) request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID").trim();
ACT_ID=(String) request.getParameter("ACT_ID")==null?"2":(String) request.getParameter("ACT_ID").trim();
DLTFC_REMARK=(String) request.getParameter("DLTFC_REMARK")==null?"":(String) request.getParameter("DLTFC_REMARK").trim();
DLTFC_WC=(String) request.getParameter("DLTFC_WC")==null?"0":(String) request.getParameter("DLTFC_WC").trim();
DLTFC_CE=(String) request.getParameter("DLTFC_CE")==null?"0":(String) request.getParameter("DLTFC_CE").trim();
//DLTFC_TOTAL	=(String) request.getParameter("DLTFC_TOTAL")==null?"0":(String) request.getParameter("DLTFC_TOTAL").trim();
EDU_ID=(String) request.getParameter("EDU_ID")==null?"0":(String) request.getParameter("EDU_ID").trim();
IND_TYPE=(String) request.getParameter("IND_TYPE")==null?"0":(String) request.getParameter("IND_TYPE").trim();
int PROJ_COST=Integer.parseInt(DLTFC_WC)+Integer.parseInt(DLTFC_CE);
//out.print(PROJ_COST);

 if(!ACT_ID.equals("7")){
 
 try {
  if ((PROJ_COST)<1000) {
   aerror.add("Total Projest Cost Mentioned is Too Low:"+PROJ_COST);
    
  }
  }catch (Exception n){
  aerror.add("Total Projest Cost Mentioned is Too Low:"+PROJ_COST);
   }
  
  
 try {
 if ((PROJ_COST)>2500000) {
   aerror.add("Invalid Project Cost.....");
    
  }
  }catch (Exception n){
  aerror.add("Total Projest Cost Mentioned is Too Low:"+PROJ_COST);
   }
   
 
 
 
  if ( !IND_TYPE.equals("M")&& (PROJ_COST)>1000000){
  aerror.add("Invalid Project Cost for Service/Trading Industry.....");
    
  }
  if ( IND_TYPE.equals("M") && EDU_ID.equals("5") && (PROJ_COST)>1000000){
  aerror.add("Total Project Cost for Under 8th  for Manufacturing Industry should not exceed 10 lakhs");
    
  }
  if ( IND_TYPE.equals("S") && EDU_ID.equals("5") && (PROJ_COST)>500000){
  aerror.add("Total Project Cost for Under 8th  for Manufacturing Industry should not exceed 5 lakhs");
    
  }
  if ( IND_TYPE.equals("M") && (PROJ_COST)>2500000){
  aerror.add("Total Project Cost for Manufacturing Unit should not exceed 25 lakhs");
    
  }
  if ( IND_TYPE.equals("S") && ((PROJ_COST))>1000000){
  aerror.add("Total Project Cost for Service Unit should not exceed 10 lakhs");
    
  }
 %>
 <table align="center" class="pmegpTable">
 <tr>
    <td colspan="4" class="warning" scope="row"><h2 class="error">  Submission failed due to following reason: </h2></td>
  </tr>
  <%
   ListIterator itr=aerror.listIterator();
   int cnterro=0;
   while(itr.hasNext()){ VALID_DATA="N"; 
cnterro=cnterro+1;   %>

  <tr class="redLebel">
    <td class="OrangeLebel" scope="row">
	
	  <div align="right"><%= cnterro %></div></td>
    <td colspan="3" class="warning" scope="row"><h3><%= itr.next()%></h3></td>
  </tr>
 
<%			
        }}
 if (VALID_DATA.equals("Y")){

	List values=new ArrayList();
		List pstm=new ArrayList();
		StringBuffer qryUpdate = new StringBuffer();
String vTodayDt ="";



qryUpdate.append("  UPDATE APP_DETAIL SET ACT_ID=?, ");
qryUpdate.append("  DLTFC_CE =? ,");
qryUpdate.append("  DLTFC_WC =? ,");
qryUpdate.append("  DLTFC_REMARK =? ,");
qryUpdate.append("  DLTFC_APPR_DT=SYSDATE WHERE APP_ID=?");

values.clear();
pstm.clear();

values.add(ACT_ID); pstm.add ("L");
values.add(DLTFC_CE); pstm.add ("L");
values.add(DLTFC_WC); pstm.add ("L");
values.add(DLTFC_REMARK); pstm.add ("L");
values.add(APP_ID); pstm.add ("L");

db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate() ;
db.close();
response.sendRedirect("savemsgAgency.jsp");

}
}

%>
</table>
</form>
</body>
</html>
