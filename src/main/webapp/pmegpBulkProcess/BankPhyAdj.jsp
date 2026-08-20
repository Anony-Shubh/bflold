 <%@ page session="true" buffer="500kb" import="java.sql.*,java.util.Date,javax.sql.*,javax.naming.*,java.util.*,java.text.*,java.util.*,pkgPmegpNew.DBCon"  %>
<%
response.setContentType("text/html");
response.setHeader("Cache-control","no-cache");
response.setHeader("Cache-control","private");
%>

<html>
<head>
<title>PMEGP Bank Data Entry Form</title>

<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script src="../js/ModalPopupWindow.js" type="text/javascript"></script>
<script type="text/javascript" src="../js/datetimepicker_css.js"></script>
<script src="../js/inlineMsgMain.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
<script type="text/javascript">
function now()
{
 var todaydt=new Date();
var dd=todaydt.getDate();
var mm=todaydt.getMonth()+1;
var yr=todaydt.getFullYear();
var months=['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
var showdt=dd+'-'+months[mm-1]+'-'+yr;
showdt=showdt.toUpperCase();

return (showdt);
}
 function todaydt() {
 test = new Date()
document.getElementById("MM_ADJ_DT").value=now();
 }

$(document).ready(function() {
 
todaydt();
 });

function abc(){
var PROC_DT = document.form1.PROC_DT.value; 
PROC_DT=new Date(PROC_DT);
var MM_ADJ_DT = document.form1.MM_ADJ_DT.value;
MM_ADJ_DT=new Date(MM_ADJ_DT);
var MM_DT = document.form1.TODAYDT.value;
MM_DT=new Date(MM_DT);

var BANK_REF_NO = document.form1.BANK_REF_NO.value; 
//alert(BANK_REF_NO);
	
if(MM_ADJ_DT != "") {
//alert(MM_ADJ_DT);
//alert(PROC_DT);
//alert(MM_DT);
  if ((MM_ADJ_DT < PROC_DT ) || (MM_ADJ_DT > MM_DT )) {
 
  inlineMsg('MM_ADJ_DT','Enter Correct date',2);
    return false;
  }
    
  }	
	
	
	if(BANK_REF_NO == "") {
    inlineMsg('BANK_REF_NO','Enter Reference No',2);
    return false;
  }
  
	document.form1.ins.value='I';
	document.form1.submit();
}




</script> 
<style type="text/css">
<!--
.style1 {
	color: #FF0000;
	font-size: 24px;
}
.style3 {font-size: 18px}
.style8 {font-size: 17px; }
.style9 {color: #008000; font-size: 17px; }
-->
</style>
</head>
 <body>
 
 <form  method="post"  name="form1" id="form1" >
  <%		
		String APP_ID =request.getParameter("APP_ID")==null?"":(String)request.getParameter("APP_ID");
        String ins= request.getParameter("ins")==null?"":(String) request.getParameter("ins"); 
String IFSC_CODE=(String)session.getAttribute("bank_id");	
	String BANK_REF_NO="";
		String BANK_ADJ_AMT="";
		String BANK_REM="";
		
		String OFF_CD="";
		String MM_ADJUSTMENT_AMT_S="";
		String MM_ADJ_DATE="";
		DBCon db= new DBCon();
        db.connect();
		
        StringBuffer qrysb = new StringBuffer();
   qrysb.append("  SELECT MOM.OFF_NAME1,BD.BANK_COMMENT,GT.MM_ADJUSTMENT_AMT_S,TO_CHAR(GT.BANK_ADJ_DT,'DD-MON-RRRR') AS MM_ADJ_DATE,BD.OFF_CD,BD.TDR_ACNO,TO_CHAR(BD.TDR_ADJ_DT,'DD-MON-YYYY') AS TDR_ADJ_DT,DECODE(GT.BANK_ADJ_AMT,NULL,GT.MM_ADJUSTMENT_AMT_S,GT.BANK_ADJ_AMT) AS BANK_ADJ_AMT,GT.BANK_REF_NO," );
     qrysb.append("  MOM.AGENCY_TYPE,AD.E_MAIL,AD.AADHAR_NO,AD.PAN_NO,  MD.DISTRICT_NAME,to_char(sysdate,'DD-MON-YYYY') as TODAYDT,  AD.APP_ID, AD.APP_NAME,  AD.MOB_NO1,  BD.IFSC_CODE, ");
   qrysb.append("  RBL.BANK_NAME,   RBL.BRANCHNAME, BD.MM_CLAIM_AMT,TO_CHAR(BD.MM_CLAIM_DT,'DD-MON-YYYY') AS MM_CLAIM_DT  , BD.PBATCH_ID,TO_CHAR( BD.BATCH_DATE,'DD-MON-YYYY') AS  BATCH_DATE  ,  BD.UTRN_NO," );
   qrysb.append("  BD.PAY_STATUS,  BD.FB_ACNO,  BD.MM_REL_AMT,TO_CHAR(BD.MM_REL_DT,'DD-MON-YYYY') AS MM_REL_DT  , BD.PACT_ID,BD.APPRV_YN,TO_CHAR(GR.PROC_DT,'DD-MON-RRRR') AS PROC_DT " ); 
   qrysb.append("  FROM APP_DETAIL AD,  BANK_DATAENTRY BD,  MAS_OFF_MAST MOM,  M_DISTRICT MD,  RBIBANKLIST RBL,GEOTAG_TRANS GT,GEOTAG_REMARKS GR,BANK_BR_MAST BBM " );
   qrysb.append("  WHERE AD.APP_ID = BD.APP_ID AND AD.OFF_CD= MOM.OFF_CD AND MOM.DISTRICT_CD= MD.DISTRICT_CD AND GT.REMTRID=GR.REMTRID " );
   qrysb.append("  AND AD.IFSC_CODE= RBL.IFSC_CODE  AND AD.APP_ID=GT.APP_ID AND GT.ACT_ID=1 AND GT.AGENCY_UPLOAD IS NOT NULL" );
   qrysb.append("  AND RBL.IFSC_CODE=BBM.BR_IFSL_CODE AND BBM.CIRCLE_IFSC='"+IFSC_CODE+"' AND  BD.APP_ID='"+APP_ID+"'    " );
   qrysb.append(" UNION ");
    qrysb.append("  SELECT MOM.OFF_NAME1,BD.BANK_COMMENT,GT.MM_ADJUSTMENT_AMT_S,TO_CHAR(GT.BANK_ADJ_DT,'DD-MON-RRRR') AS MM_ADJ_DATE,BD.OFF_CD ,BD.TDR_ACNO,TO_CHAR(BD.TDR_ADJ_DT,'DD-MON-YYYY') AS TDR_ADJ_DT,DECODE(GT.BANK_ADJ_AMT,NULL,GT.MM_ADJUSTMENT_AMT_S,GT.BANK_ADJ_AMT) AS BANK_ADJ_AMT,GT.BANK_REF_NO," );
   
   qrysb.append("  MOM.AGENCY_TYPE,AD.E_MAIL,AD.AADHAR_NO,AD.PAN_NO,  MD.DISTRICT_NAME,to_char(sysdate,'DD-MON-YYYY') as TODAYDT,  AD.APP_ID, AD.APP_NAME,  AD.MOB_NO1,  BD.IFSC_CODE, ");
   qrysb.append("  RBL.BANK_NAME,   RBL.BRANCHNAME, BD.MM_CLAIM_AMT,TO_CHAR(BD.MM_CLAIM_DT,'DD-MON-YYYY') AS MM_CLAIM_DT  , BD.PBATCH_ID,TO_CHAR( BD.BATCH_DATE,'DD-MON-YYYY') AS  BATCH_DATE  ,  BD.UTRN_NO," );
   qrysb.append("  BD.PAY_STATUS,BD.FB_ACNO,BD.MM_REL_AMT,TO_CHAR(BD.MM_REL_DT,'DD-MON-YYYY') AS MM_REL_DT,BD.PACT_ID,BD.APPRV_YN,TO_CHAR(GR.PROC_DT,'DD-MON-RRRR') AS PROC_DT " ); 
   qrysb.append("  FROM APP_DETAIL_SECOND AD,  BANK_DATAENTRY_SECOND BD,  MAS_OFF_MAST MOM,  M_DISTRICT MD,  RBIBANKLIST RBL,GEOTAG_TRANS GT,GEOTAG_REMARKS GR,BANK_BR_MAST BBM " );
   qrysb.append("  WHERE AD.APP_ID = BD.APP_ID AND AD.OFF_CD= MOM.OFF_CD AND MOM.DISTRICT_CD= MD.DISTRICT_CD AND GT.REMTRID=GR.REMTRID " );
   qrysb.append("  AND AD.IFSC_CODE= RBL.IFSC_CODE AND  AD.APP_ID=GT.APP_ID AND GT.ACT_ID=1 AND GT.AGENCY_UPLOAD IS NOT NULL" );
   qrysb.append("  AND RBL.IFSC_CODE=BBM.BR_IFSL_CODE AND BBM.CIRCLE_IFSC ='"+IFSC_CODE+"' AND  BD.APP_ID='"+APP_ID+"'    " );
   
		ResultSet rsMain = db.execSQL(qrysb.toString());		
		List values=new ArrayList();
        List pstm=new ArrayList();	

String OFF_NAME1="";
String AGENCY_TYPE="";
String DISTRICT_NAME="";
String APP_NAME="";
String MOB_NO1="";
String PROC_DT="";
String BANK_NAME="";
String BRANCHNAME="";
String MM_CLAIM_AMT="";
String MM_CLAIM_DT="";
String PBATCH_ID="";
String BATCH_DATE="";
String UTRN_NO="";
String PAY_STATUS="";
String FB_ACNO="";
String MM_REL_AMT="";
String MM_REL_DT="";
String PACT_ID="";
String APPRV_YN="";
String CO_REMARKS="";
String TODAYDT="";
String TDR_ACNO="";
String TDR_ADJ_DT="";
String MM_ADJ_DT="";
String MM_ADJ_AMT ="";
String AADHAR_NO="";
String PAN_NO="";
String BANK_COMMENT="";
String E_MAIL="";
String EDP_FR_DT="";
String EDP_TRG_NAME="";
String EDP_TO_DT="";
String EDP_CERT_DT="";
String verror="";


int edpcount=0;
while(rsMain.next())
  {	 
      	 OFF_CD=rsMain.getString("OFF_CD")==null?"":rsMain.getString("OFF_CD");
	  OFF_NAME1=rsMain.getString("OFF_NAME1")==null?"":rsMain.getString("OFF_NAME1");	
	  AGENCY_TYPE=rsMain.getString("AGENCY_TYPE")==null?"":rsMain.getString("AGENCY_TYPE");
	  DISTRICT_NAME=rsMain.getString("DISTRICT_NAME")==null?"":rsMain.getString("DISTRICT_NAME");
	  APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");
	  APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
	  MOB_NO1=rsMain.getString("MOB_NO1")==null?"":rsMain.getString("MOB_NO1");
	  IFSC_CODE=rsMain.getString("IFSC_CODE")==null?"":rsMain.getString("IFSC_CODE");
	  BANK_NAME=rsMain.getString("BANK_NAME")==null?"":rsMain.getString("BANK_NAME");
	  BRANCHNAME=rsMain.getString("BRANCHNAME")==null?"":rsMain.getString("BRANCHNAME");
	  MM_CLAIM_AMT=rsMain.getString("MM_CLAIM_AMT")==null?"":rsMain.getString("MM_CLAIM_AMT");
	  MM_CLAIM_DT=rsMain.getString("MM_CLAIM_DT")==null?"":rsMain.getString("MM_CLAIM_DT");
	  PBATCH_ID=rsMain.getString("PBATCH_ID")==null?"":rsMain.getString("PBATCH_ID");
	  BATCH_DATE=rsMain.getString("BATCH_DATE")==null?"":rsMain.getString("BATCH_DATE");
	  UTRN_NO=rsMain.getString("UTRN_NO")==null?"":rsMain.getString("UTRN_NO");
	  PAY_STATUS=rsMain.getString("PAY_STATUS")==null?"":rsMain.getString("PAY_STATUS");
	  FB_ACNO=rsMain.getString("FB_ACNO")==null?"":rsMain.getString("FB_ACNO");
	  MM_REL_AMT=rsMain.getString("MM_REL_AMT")==null?"":rsMain.getString("MM_REL_AMT");
	  MM_REL_DT=rsMain.getString("MM_REL_DT")==null?"":rsMain.getString("MM_REL_DT");
	  PACT_ID=rsMain.getString("PACT_ID")==null?"":rsMain.getString("PACT_ID");
	 MM_ADJ_AMT=rsMain.getString("MM_ADJUSTMENT_AMT_S")==null?"":rsMain.getString("MM_ADJUSTMENT_AMT_S");
	 MM_ADJ_DT=rsMain.getString("MM_ADJ_DATE")==null?"":rsMain.getString("MM_ADJ_DATE");
	  APPRV_YN=rsMain.getString("APPRV_YN")==null?"":rsMain.getString("APPRV_YN");
	  TODAYDT=rsMain.getString("TODAYDT")==null?"":rsMain.getString("TODAYDT");
	  AADHAR_NO=rsMain.getString("AADHAR_NO")==null?"":rsMain.getString("AADHAR_NO");
	  PAN_NO=rsMain.getString("PAN_NO")==null?"":rsMain.getString("PAN_NO");
	  E_MAIL=rsMain.getString("E_MAIL")==null?"":rsMain.getString("E_MAIL");
	  BANK_REF_NO=rsMain.getString("BANK_REF_NO")==null?"":rsMain.getString("BANK_REF_NO");
	  BANK_ADJ_AMT=rsMain.getString("BANK_ADJ_AMT")==null?"":rsMain.getString("BANK_ADJ_AMT");
	 
	  TDR_ACNO=rsMain.getString("TDR_ACNO")==null?"":rsMain.getString("TDR_ACNO");
	  TDR_ADJ_DT=rsMain.getString("TDR_ADJ_DT")==null?"":rsMain.getString("TDR_ADJ_DT");
	  BANK_COMMENT=rsMain.getString("BANK_COMMENT")==null?"":rsMain.getString("BANK_COMMENT");
	    PROC_DT=rsMain.getString("PROC_DT")==null?"":rsMain.getString("PROC_DT");
	  
	 edpcount=edpcount+1;		
  }
 rsMain.close();
 //out.print(PROC_DT);
 //Validation query
 try{
 
			if (ins.equals("I")){
				
				
				
				
APP_ID=request.getParameter("APP_ID")==null?"":request.getParameter("APP_ID");

MM_ADJ_AMT=request.getParameter("MM_ADJ_AMT")==null?"":request.getParameter("MM_ADJ_AMT").trim();
MM_ADJ_DT =request.getParameter("MM_ADJ_DT")==null?"":request.getParameter("MM_ADJ_DT").trim();
BANK_REF_NO=request.getParameter("BANK_REF_NO")==null?"":request.getParameter("BANK_REF_NO").trim();
BANK_REM=request.getParameter("BANK_REM")==null?"":request.getParameter("BANK_REM").trim();
out.print(APP_ID);
out.print(MM_ADJ_AMT);
out.print(MM_ADJ_DT);
out.print(BANK_REF_NO);

/*
String validateqry="SELECT * FROM TABLE(GET_PMEGP_BANKERROR_TDR(?,?,?,?,?,?,?,?,?))";
List values=new ArrayList();
        List pstm=new ArrayList();	
     values.add (APP_ID); 
	 values.add (TDR_ACNO);
	 values.add (TDR_ADJ_DT);
	 values.add (EDP_TRG_NAME);
	 values.add (EDP_FR_DT);
	 values.add (EDP_TO_DT);
	 values.add (EDP_CERT_DT);
	 values.add (MM_ADJ_DT);
	 values.add (MM_ADJ_AMT);
	
	
	ResultSet rsValidate = db.executeSQL(validateqry,values);
values.clear();	

int errcount =0;

while (rsValidate.next()){
errcount =errcount+1;
verror=verror+""+rsValidate.getString(2)+"<br>";
//out.print (verror);
}
rsValidate.close();
	*/		


try {

	
StringBuffer sb = new StringBuffer();
		 sb.append("   UPDATE  GEOTAG_TRANS SET BANK_ADJ_DT=?,   ").
             append("  BANK_ADJ_AMT=?,BANK_REF_NO=?,BANK_REM=?  WHERE APP_ID =? AND ACT_ID=1    ");

db.setSqlValue(sb.toString());
        db.setValues(values,pstm); 
		
  
 
  values.add(MM_ADJ_DT);pstm.add("D");
  
  values.add(MM_ADJ_AMT);pstm.add("D"); 
  
  values.add(BANK_REF_NO);pstm.add("D"); 
  
  values.add(BANK_REM);pstm.add("D");
  
  values.add(APP_ID);pstm.add("D");
 
 db.executeUpdate();
  db.close();
  values.clear();
  pstm.clear();	
 response.sendRedirect("savemsg.jsp");
	
  }
   catch (Exception e) {
	  out.print(e);
  }
 // }


		
		}//end of ins
	}catch (Exception e) {
	
	out.print (e.toString());
	}	
  
 
	  
			
 
 
 %>
   
 

 <% if (ins.equals("I")) {%>
<div class="success">
  
 </div><%}%>
  
    <table width="100%">
    <tr>
      <th height="23" colspan="6" nowrap><div align="center" class="style29 style39 style3">BANK MM ADJUSTMENT FORM </div></th>
	  <input name="ins" type="hidden" id="ins" value="<%= ins %>   ">
	  <input name="APP_ID" type="hidden" id="APP_ID" value="<%= APP_ID %>   ">
	  </tr>
	  <tr>
      <th colspan="6" ><div align="center" class="style34">(Date Format:dd-mon-yyyy ex:
              <input name="TODAYDT" type="hidden"  id="TODAYDT" tabindex="0" value="<%=TODAYDT %>" size="12">
              <%=TODAYDT %> and Amount in Rs) </div></th>
    </tr>
    <tr>
      <th  ><div align="right">Applicant ID : </div></th>
      <th > <%= APP_ID %> </th>
       <th colspan="3"  ><div align="right">Applicant Name:</div></th>
      <th  ><%= APP_NAME %> </th>
    </tr>
    <tr>
      <th  ><div align="right">Aadhaar Card No: </div></th>
      <th  ><%= AADHAR_NO %></th>
      <th colspan="3"  ><div align="right">PAN NO: </div></th>
      <th  ><%= PAN_NO %>
      
    </tr>
    <tr>
      <th  ><div align="right">Applicant Contact No: </div></th>
     <th  ><%= MOB_NO1  %></th>
    <th colspan="3"  ><div align="right">Applicant email:</div></th>
     <th  ><%= E_MAIL %></th>
      </tr>
    <tr>
      <th  ><div align="right">MM Claim Amount: </div></th>
      <th  ><%=  MM_CLAIM_AMT  %></th>
      <th colspan="3"  ><div align="right">MM Calim Date:</div></th>
      <th  ><%=  MM_CLAIM_DT%></th>
      </tr>
	  <tr>
	    <th colspan="6"  ><div align="center"><u><span class="style1">MARGIN MONEY RELEASE DETAILS </span></u></div></th>
	    
      </tr>
	  <tr>
      <th  ><div align="right" class="style8">MM Release Amount: </div></th>
     <th  ><span class="style9"><%= MM_REL_AMT  %></span></th>
      <th colspan="3"  ><div align="right" class="style8">MM Release Date:</div></th>
      <th  ><span class="style9"><%= MM_REL_DT %></span></th>
      </tr>
	 <tr>
      <th  ><div align="right" class="style8">Transient Account No: </div></th>
     <th  ><span class="style9"><%= FB_ACNO  %></span></th>
      <th colspan="3"  ><div align="right" class="style8">UTRN NO:</div></th>
      <th  ><span class="style9"><%= UTRN_NO %></span></th>
      </tr>
   </table>
    <table width="100%">
	
	 <tr>
        <td colspan="3"><div align="center" class="GreenLebel">Margin Money (Subsidy) Adjustment against TDR  </div></td>
	  <tr>
        <th>(1)</th>
        <th>Adjustment Date: </th>
        <td><input name="MM_ADJ_DT" id="MM_ADJ_DT" type="text"   placeholder="DD-MON-YYYY" value="<%= MM_ADJ_DT%>" onClick="javascript:NewCssCal('MM_ADJ_DT','ddMMMyyyy')" size="12" maxlength="11"  >
		<input name="PROC_DT" id="PROC_DT" type="hidden"   placeholder="DD-MON-YYYY" value="<%= PROC_DT%>" size="12" maxlength="11" readonly="true" ></td>
	  <tr>
	    <th>(2)</th>
	    <th>Reference No: </th>
	    <td><input name="BANK_REF_NO" id="BANK_REF_NO" type="text"  value="<%= BANK_REF_NO%>" size="12" maxlength="50"  ></td>
      <tr>
        <th>(3)</th>
        <th>Adjustment Amount</th>
        <td><input name="MM_ADJ_AMT" id="MM_ADJ_AMT" type="text"  tabindex="23"  value="<%=MM_ADJ_AMT %>" size="12" maxlength="7" readonly="true" ></td>
		<tr>
        <th>(4)</th>
        <th>Remarks</th>
        <td><input name="BANK_REM" id="BANK_REM" type="text"  tabindex="23"  value="<%=BANK_REM %>" size="12" maxlength="100" ></td>
	  <tr>
        <th colspan="3"><div align="center">
            <input name="btnFinalSave" type="button" class="button" id="btnFinalSave" tabindex="24" onClick="abc();"  value="Save Data">
        </div></th>
    </table>
	
	 
	<%
    
 
 
  %>

</form>

</body>
</html>
