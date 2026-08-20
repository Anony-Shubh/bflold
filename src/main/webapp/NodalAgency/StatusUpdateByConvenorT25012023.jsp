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


	 function Checkradiobutton()
 {
   var ACT_ID=form.elements["ACT_ID"].value;

 if ((ACT_ID == "1") || (ACT_ID == "4") || (ACT_ID == "2"))
 {

        document.getElementById('REJ_ID').disabled=true; 
		document.getElementById("REJ_ID").value = '';
   }
   if (ACT_ID == "7"){
 
                    document.getElementById('REJ_ID').disabled = false;
                }
 }


	
function submit_form () {

     var actid=document.form.ACT_ID.value;
	 var REJ_ID=document.form.REJ_ID.value;
	 if(actid == "") {
    inlineMsg('ACT_ID','You must Select Status',2);
    return false;
	}
	if(actid == "7") {
   
  if(REJ_ID == "") {
    inlineMsg('REJ_ID','Select Rejection Reason.........',2);
    return false;
  }
   
  } 
	 
	 var DLTFC_REMARK=document.form.DLTFC_REMARK.value;
	   	 if(DLTFC_REMARK == "") {
    inlineMsg('DLTFC_REMARK','You must Enter Remarks',2);
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
<body onLoad="Checkradiobutton()">
<form   name="form" id ="form" method="post" >
<%
String  APP_ID =request.getParameter("APP_ID")==null?"":(String)request.getParameter("APP_ID");

String OFF_CD = (String) session.getAttribute("sOffCd");

try {
if (OFF_CD==null||OFF_CD.equals("")){
response.sendRedirect("../jsp/AgencyloginPageNew.jsp");
}
	}catch (Exception m) {}		
	
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
int TOTAL_SCORE=0;
String REJ_ID="";
String VALID_DATA="Y";
String DLTFC_CE = "";
String DLTFC_WC = "";
String DLTFC_TOTAL = "";
String MSG="";
String BENF_CATEGORY_DESC="";
String BENF_TYPE_DESC="";
String EMP_ENV="";
String GENDER="";
String AADHAR_NO="";
ArrayList aerror = new ArrayList();
DBCon db= new DBCon();
db.connect();
StringBuffer qrysb= new StringBuffer();
qrysb.append("   SELECT  FUN_LOCKUPDATE_REJ(ad.APP_ID) AS MSG,AD.REJ_ID,NVL( (SELECT TOTAL_SCORE FROM PMEGP_SCORE_CARD PSC WHERE PSC.APP_ID=AD.APP_ID),0) AS TOTAL_SCORE,"      );
qrysb.append("   AD.APP_ID,AD.AADHAR_NO,AD.GENDER,AD.EMP_ENV,BTM.BENF_TYPE_DESC,bcm.BENF_CATEGORY_DESC,"      );
qrysb.append("   AD.ACT_ID,AD.IND_TYPE,AD.EDU_ID,"      );
qrysb.append("   UPPER(AD.APP_NAME) AS APP_NAME,AD.REMARKS AS AGENCY_REMARKS, IFSC_CODE,"      );
qrysb.append("   AM.ACTIVITY_NAME,AD.PROD_DESC, AD.DLTFC_REMARK, "      );
qrysb.append("   NVL(AD.MACHINARY_COST,0) AS PROP_CE,"      );
qrysb.append("   NVL(AD.WORKING_CAPITAL,0) AS PROP_WC,"      );
qrysb.append("   NVL(AD.MACHINARY_COST,0)+NVL(AD.WORKING_CAPITAL,0) AS PROP_PROJ_TOTAL,"      );

qrysb.append("   to_Char(AD.ONLINE_SUBDT,'dd-mon-yyyy') as ONLINE_SUBDT,"      );
qrysb.append("   to_Char(AD.FORD_DT_DLTFC,'dd-mon-yyyy') as FORD_DT_DLTFC,"      );
qrysb.append("   UMD.DISTRICT_NAME AS UNIT_DIST,"      );
qrysb.append("   ASM.ACT_DESC , AD.DLTFC_CE,AD.DLTFC_WC "      );
qrysb.append("   FROM APP_DETAIL AD,benf_type_mast BTM,benf_category_mast bcm, "      );
qrysb.append("   APP_STATUS_MAST ASM, M_DISTRICT UMD,ACTIVITY_MAST AM"      );
qrysb.append("   WHERE AD.OFF_CD=?"      );
qrysb.append("   AND AD.ACTIVITY_CD=AM.ACTIVITY_CD AND AD.APP_ID=?"      );
qrysb.append("   AND AD.ACT_ID=ASM.ACT_ID AND ad.BENF_TYPE_CD     = BTM.BENF_TYPE_CD AND ad.BENF_CATAGORY_CD = bcm.BENF_CATEGORY_CD "      );
qrysb.append("   AND AD.UNIT_DIST_CD=UMD.DISTRICT_CD"      );
qrysb.append("   ORDER BY AD.FORD_DT_DLTFC DESC"      );


List valuesq = new ArrayList();
valuesq.add(OFF_CD);
valuesq.add(APP_ID);

   ResultSet rsApp = db.executeSQL(qrysb.toString(),valuesq);
   valuesq.clear();

while (rsApp.next()){

APP_ID=rsApp.getString("APP_ID")==null?"":rsApp.getString("APP_ID");
ACT_ID=rsApp.getString("ACT_ID")==null?"":rsApp.getString("ACT_ID");
 BENF_CATEGORY_DESC=rsApp.getString("BENF_CATEGORY_DESC")==null?"":rsApp.getString("BENF_CATEGORY_DESC");
 BENF_TYPE_DESC=rsApp.getString("BENF_TYPE_DESC")==null?"":rsApp.getString("BENF_TYPE_DESC");
 EMP_ENV=rsApp.getString("EMP_ENV")==null?"":rsApp.getString("EMP_ENV");
 AADHAR_NO=rsApp.getString("AADHAR_NO")==null?"":rsApp.getString("AADHAR_NO");
 GENDER=rsApp.getString("GENDER")==null?"":rsApp.getString("GENDER");
APP_NAME=rsApp.getString("APP_NAME")==null?"":rsApp.getString("APP_NAME");
ACTIVITY_NAME=rsApp.getString("ACTIVITY_NAME")==null?"":rsApp.getString("ACTIVITY_NAME");
PROD_DESC=rsApp.getString("PROD_DESC")==null?"":rsApp.getString("PROD_DESC");
PROP_CE=rsApp.getString("PROP_CE")==null?"":rsApp.getString("PROP_CE");
PROP_WC=rsApp.getString("PROP_WC")==null?"":rsApp.getString("PROP_WC");
PROP_PROJ_TOTAL=rsApp.getString("PROP_PROJ_TOTAL")==null?"":rsApp.getString("PROP_PROJ_TOTAL");
REJ_ID=rsApp.getString("REJ_ID")==null?"":rsApp.getString("REJ_ID");
ONLINE_SUBDT=rsApp.getString("ONLINE_SUBDT")==null?"":rsApp.getString("ONLINE_SUBDT");
FORD_DT_DLTFC=rsApp.getString("FORD_DT_DLTFC")==null?"":rsApp.getString("FORD_DT_DLTFC");
UNIT_DIST=rsApp.getString("UNIT_DIST")==null?"":rsApp.getString("UNIT_DIST");


ACT_DESC=rsApp.getString("ACT_DESC")==null?"":rsApp.getString("ACT_DESC");
AGENCY_REMARKS=rsApp.getString("AGENCY_REMARKS")==null?"":rsApp.getString("AGENCY_REMARKS");
DLTFC_REMARK=rsApp.getString("DLTFC_REMARK")==null?"":rsApp.getString("DLTFC_REMARK");
DLTFC_CE=rsApp.getString("DLTFC_CE")==null?"":rsApp.getString("DLTFC_CE");
DLTFC_WC=rsApp.getString("DLTFC_WC")==null?"":rsApp.getString("DLTFC_WC");
IFSC_CODE=rsApp.getString("IFSC_CODE")==null?"":rsApp.getString("IFSC_CODE");
IND_TYPE=rsApp.getString("IND_TYPE")==null?"":rsApp.getString("IND_TYPE");
EDU_ID=rsApp.getString("EDU_ID")==null?"":rsApp.getString("EDU_ID");
MSG=rsApp.getString("MSG")==null?"":rsApp.getString("MSG");
TOTAL_SCORE=rsApp.getInt("TOTAL_SCORE");
}

rsApp.close();
%>
  <div>
  

  <table align="center">
    <tr>
      <th colspan="4"><div align="center">APPLICANT CURRENT STATUS UPDATE BY DISTRICT CO-ORDINATOR OFFICER </div></th>
    </tr>
    <tr>
      <th colspan="4">&nbsp;</th>
    </tr>
    <tr>
      <th><input name="ins" type="hidden" id="ins"><input name="IND_TYPE"  value="<%=IND_TYPE%>" type="hidden" id="IND_TYPE">
	  <input name="ACT_ID1" type="hidden" id="ACT_ID1" value="<%=ACT_ID%>">
	  <INPUT name="TOTAL_SCORE" type="hidden" id="TOTAL_SCORE" value="<%= TOTAL_SCORE %>">
      Applicant Id : <INPUT name="ACT_ID" type="radio" disabled value="2" <% if (ACT_ID.equals("2")){out.print("Checked");}%>></th>
      <th><%=APP_ID %> </th>
      <th><div align="right">Name Of Applicant :</div></th>
      <th><%=  APP_NAME %></th>
    </tr>
    <tr >
      <th>Aadhar No </th>
      <th><%=AADHAR_NO %></th>
      <th>Gender</th>
      <th><%=GENDER %></th>
    </tr>
    <tr >
      <th>Social Cateogry </th>
      <th><%=BENF_CATEGORY_DESC %></th>
      <th>Special Cateogry </th>
      <th><%=BENF_TYPE_DESC %></th>
    </tr>
    <tr >
      <th>Industry/Activity:</th>
      <th><%=ACTIVITY_NAME %> (<%=PROD_DESC %>) </th>
      <th>Employement</th>
      <th><%=EMP_ENV %></th>
    </tr>
    <tr >
      <th rowspan="2">Proposed Project Cost by Applicant: </th>
      <th><div align="center">Capital Expenditure (CE) </div></th>
      <th><div align="center">Working Capital (WC) </div></th>
      <th><div align="center">Total (CE+WC)</div></th>
    </tr>
    <tr >
      <td><div align="center">Rs.<%=PROP_CE%>
        <input name="PROP_CE" type="HIDDEN" id="PROP_CE"  size="10" maxlength="7"  value="<%= PROP_CE %>" >
      </div></td>
      <td><div align="center">Rs.<%=PROP_WC%><input name="PROP_WC" type="HIDDEN" id="PROP_WC"  size="10" maxlength="7"  value="<%=  PROP_WC %>" ></div></td>
      <td><div align="center">Rs.<%=  PROP_PROJ_TOTAL  %></div></td>
    </tr>
    <tr >
      <th>Forwarding Date to Approver Agency: </th>
      <th colspan="3"><%=  FORD_DT_DLTFC %></th>
    </tr>
  
    <tr >
      <th>Agency Recomendation Remarks</th>
      <th><%=  AGENCY_REMARKS %></th>
      <th>Score Obtained </th>
      <th><%=TOTAL_SCORE%></th>
    </tr>
    <tr >
      <th colspan="4"></th>
    </tr>
    <tr valign="middle">
      <th><div align="right">Select Current Status: * </div></th>
      <td colspan="3" >
	    <p>
	      
          <INPUT name="ACT_ID"  id="radio" type="radio" onClick="Checkradiobutton()" value="4" <% if (ACT_ID.equals("4")){out.print("Checked");}%>>
          <SPAN class="GreenLebel">Approved to Forward Bank</SPAN>		  
		 
		  
       </p>
	    <p>
	      <input name="ACT_ID" id="ACT_ID"  type="radio" onClick="Checkradiobutton()" value="7"  <% if (ACT_ID.equals("7")){out.print("Checked");}%>>
           <span class="redLebel"> Returned to the Applicant </span></p>
	    <p>   
	      <input name="ACT_ID" id="ACT_ID"  type="radio" onClick="Checkradiobutton()"  value="1"  <% if (ACT_ID.equals("1")){out.print("Checked");}%> \>
           <span class="OrangeLebel">Returned to Nodal Officer</span>          </p>
	   </td>
    </tr>
  <TR >
      <TH><DIV align="right">Select Rejection Reason : </DIV></TH>
      <TD colspan="3" class="GreenLebel" >
	  <select name="REJ_ID" id="REJ_ID" value=<%=REJ_ID%> >
	   <option value="">--Select Rejection Reason--</option>
      <%
	  String qrystr="";
	  String REJID="";
		String REJDESC="";
	    qrystr="SELECT REJ_ID,REJ_DESC FROM REJECTION_MAST WHERE ACT_YN='Y' AND REL_TP IN ('A','C') ORDER BY REJ_ID";
       ResultSet rs = db.execSQL(qrystr);
	   while(rs.next()){ 
	   REJID=rs.getString(1);
REJDESC=rs.getString(2);
	   %>
      <option value="<%=rs.getString("REJ_ID")%>" <% if (REJID.equals(REJ_ID)){out.print("selected");}%>><%=rs.getString("REJ_DESC")%></option>
      <% } 
	  rs.close();
	   %>
       
      </select></TD>
    </TR>

    <tr >
      <th ><div align="right">Remarks by Approver : </div></th>
      <td colspan="3" ><input name="DLTFC_REMARK" type="text" id="DLTFC_REMARK" size="100" maxlength="100"   value="<%= DLTFC_REMARK %>">      </td>
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
DLTFC_WC=(String) request.getParameter("PROP_WC")==null?"0":(String) request.getParameter("PROP_WC").trim();
DLTFC_CE=(String) request.getParameter("PROP_CE")==null?"0":(String) request.getParameter("PROP_CE").trim();
REJ_ID	=(String) request.getParameter("REJ_ID")==null?"":(String) request.getParameter("REJ_ID").trim();
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

if (ACT_ID.equals("4")){

qryUpdate.append("  UPDATE APP_DETAIL SET ACT_ID=?,MTG_ID=-1, ");
qryUpdate.append("  DLTFC_REMARK =? ,");
qryUpdate.append("  DLTFC_APPR_DT=SYSDATE WHERE APP_ID=?");

values.clear();
pstm.clear();

values.add(ACT_ID); pstm.add ("L");
values.add(DLTFC_REMARK); pstm.add ("L");
values.add(APP_ID); pstm.add ("L");
}
else if (ACT_ID.equals("1")){
qryUpdate.append("  UPDATE APP_DETAIL SET ACT_ID=?, ");
qryUpdate.append("  DLTFC_REMARK =? ,");
qryUpdate.append("  DLTFC_PROC_DT=SYSDATE WHERE APP_ID=?");

values.clear();
pstm.clear();

values.add(ACT_ID); pstm.add ("L");
values.add(DLTFC_REMARK); pstm.add ("L");
values.add(APP_ID); pstm.add ("L");


}
else {
qryUpdate.append("  UPDATE APP_DETAIL SET ACT_ID=?, ");
qryUpdate.append("  DLTFC_REMARK =? ,");
qryUpdate.append("  DLTFC_PROC_DT=SYSDATE,ACT_YN='N',REJ_ID=? WHERE APP_ID=?");

values.clear();
pstm.clear();

values.add(ACT_ID); pstm.add ("L");
values.add(DLTFC_REMARK); pstm.add ("L");
values.add(REJ_ID); pstm.add ("L");
values.add(APP_ID); pstm.add ("L");


}

db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate() ;


if(ACT_ID.equals("4")){
try {
values.add(APP_ID); pstm.add ("L");
db.setSqlValue("UPDATE PMEGP_SCORE_CARD SET HO_VERIFY_YN='Y', HO_VERIFY_DT=SYSDATE WHERE APP_ID =? ");
db.setValues(values,pstm);
//db.executeUpdate() ;
}catch (Exception e) {}
}





db.close();
response.sendRedirect("savemsgAgency.jsp");

}
}

%>
</table>
</form>
</body>
</html>
