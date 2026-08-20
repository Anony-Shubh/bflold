 <%@ page session="true" buffer="500kb" import="java.sql.*,javax.sql.*,javax.naming.*,java.util.*,java.text.*,java.util.*,pkgPmegpNew.DBCon"  %>
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
<script language="javascript" src="../js/inlineMsgMain.js"></script>
<script language="javascript" src="../js/popcalendar.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
<script type="text/javascript">
function abc(){
	
	document.form1.ins.value='I';
	document.form1.submit();
}


$(document).ready(function () {
                var EDP_TRG_NAME = document.form1.EDP_TRG_NAME.value; 
				var EDP_FR_DT = document.form1.EDP_FR_DT.value; 
				var EDP_TO_DT = document.form1.EDP_TO_DT.value; 
				var EDP_CERT_DT = document.form1.EDP_CERT_DT.value; 
				
				//alert(EDP_TRG_NAME);
                if ((EDP_TRG_NAME == "") || (EDP_FR_DT == "") || (EDP_TO_DT == "") || (EDP_CERT_DT == ""))
				{
                    $('#EDP').show() && $('#EDP_NAME').show() && $('#EDP_TRAN_DT').show() && $('#EDP_CERT_DT').show();
				}
				else if (EDP_CERT_DT != "")
				{
					 $('#EDP').show() && $('#EDP_NAME').show() && $('#EDP_TRAN_DT').show() && $('#EDP_CERT_DT').show();
				
				}
				else
				{
					
					 $('#EDP').hide() && $('#EDP_NAME').hide() && $('#EDP_TRAN_DT').hide() && $('#EDP_CERT_DT').hide();
				
				}
				
				

            
        });
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
		//out.print(APP_ID);
		
		DBCon db= new DBCon();
        db.connect();
		
        StringBuffer qrysb = new StringBuffer();
   qrysb.append("  SELECT MOM.OFF_NAME1,BD.EDP_TRG_NAME,BD.EDP_FR_DT,BD.EDP_TO_DT,BD.EDP_CERT_DT,  MOM.AGENCY_TYPE,AD.E_MAIL,AD.AADHAR_NO,AD.PAN_NO,  MD.DISTRICT_NAME,to_char(sysdate,'DD-MON-YYYY') as TODAYDT,  AD.APP_ID, AD.APP_NAME,  AD.MOB_NO1,  BD.IFSC_CODE," );
   qrysb.append("  RBL.BANK_NAME,   RBL.BRANCHNAME, BD.MM_CLAIM_AMT,TO_CHAR(BD.MM_CLAIM_DT,'DD-MON-YYYY') AS MM_CLAIM_DT  , BD.PBATCH_ID,TO_CHAR( BD.BATCH_DATE,'DD-MON-YYYY') AS  BATCH_DATE  ,  BD.UTRN_NO," );
   qrysb.append("  BD.PAY_STATUS,  BD.FB_ACNO,  BD.MM_REL_AMT,TO_CHAR(BD.MM_REL_DT,'DD-MON-YYYY') AS MM_REL_DT  , BD.PACT_ID,BD.APPRV_YN ," );
   qrysb.append("  CASE    WHEN BD.PACT_ID = 30    THEN MRT.CO_REMARKS ELSE  BD.FAIL_REASON  END CO_REMARKS" );
   qrysb.append("  FROM APP_DETAIL AD,  BANK_DATAENTRY BD,  MM_REMARKS_TRANS MRT,  MAS_OFF_MAST MOM,  M_DISTRICT MD,  RBIBANKLIST RBL" );
   qrysb.append("  WHERE AD.APP_ID = BD.APP_ID AND AD.OFF_CD= MOM.OFF_CD AND MOM.DISTRICT_CD= MD.DISTRICT_CD" );
   qrysb.append("  AND BD.REMTRID = MRT.REMTR_ID(+)AND AD.IFSC_CODE= RBL.IFSC_CODE AND BD.MM_CLAIM_AMT   > 0" );
   qrysb.append("  AND BD.MM_CLAIM_DT IS NOT NULL AND BD.LOAN_DOCFNAME IS NOT NULL AND BD.APP_ID='"+APP_ID+"'    " );
   
		ResultSet rsMain = db.execSQL(qrysb.toString());		
		
String OFF_NAME1="";
String AGENCY_TYPE="";
String DISTRICT_NAME="";
String APP_NAME="";
String MOB_NO1="";
String IFSC_CODE="";
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
String E_MAIL="";
String EDP_FR_DT="";
String EDP_TRG_NAME="";
String EDP_TO_DT="";
String EDP_CERT_DT="";


int edpcount=0;
while(rsMain.next())
  {	 
      	
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
	  CO_REMARKS=rsMain.getString("CO_REMARKS")==null?"":rsMain.getString("CO_REMARKS");
	  APPRV_YN=rsMain.getString("APPRV_YN")==null?"":rsMain.getString("APPRV_YN");
	  TODAYDT=rsMain.getString("TODAYDT")==null?"":rsMain.getString("TODAYDT");
	  AADHAR_NO=rsMain.getString("AADHAR_NO")==null?"":rsMain.getString("AADHAR_NO");
	  PAN_NO=rsMain.getString("PAN_NO")==null?"":rsMain.getString("PAN_NO");
	  E_MAIL=rsMain.getString("E_MAIL")==null?"":rsMain.getString("E_MAIL");
	  EDP_FR_DT=rsMain.getString("EDP_FR_DT")==null?"":rsMain.getString("EDP_FR_DT");
	  EDP_TRG_NAME=rsMain.getString("EDP_TRG_NAME")==null?"":rsMain.getString("EDP_TRG_NAME");
	  EDP_TO_DT=rsMain.getString("EDP_TO_DT")==null?"":rsMain.getString("EDP_TO_DT");
	  EDP_CERT_DT=rsMain.getString("EDP_CERT_DT")==null?"":rsMain.getString("EDP_CERT_DT");
	  
	  
	  
	  
	 edpcount=edpcount+1;		
  }
 rsMain.close();
   
   %>
    <table width="100%">
    <tr>
      <th height="23" colspan="6" nowrap><div align="center" class="style29 style39 style3">BANK DETAIL UPDATION FORM </div></th>
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
        <th>(1)</th>
        <th>Beneficiary TDR Account No: </th>
        <td><input name="TDR_ACNO" type="text" id="TDR_ACNO"  size="20" maxlength="20" value="<%= TDR_ACNO %>"></td>
	  </tr>
      <tr>
        <th>(2)</th>
        <th>Deposit Date in TDR: </th>
        <td><input name="TDR_ADJ_DT" id="TDR_ADJ_DT" type="text"  onClick="popUpCalendar(this, this.form.TDR_ADJ_DT,'dd-mmm-yyyy');return false;" size="20" maxlength="10" value="<%= TDR_ADJ_DT %>"></td>
     <tr id="EDP" style="display: none">
	   
        <td colspan="5"><div align="center" class="GreenLebel">EDP Training Detail</div></td>
    </tr>
	 <tr id="EDP_NAME" style="display: none">
        <th>(12)</th>
        <th>Training Center Name: </th>
        <td colspan="3"><input name="EDP_TRG_NAME" type="text" id="EDP_TRG_NAME" value="<%= EDP_TRG_NAME %>" size="50" maxlength="50" readonly="true" >
            <input name="btnEDP" type="button" class="buttonBlue" id="btnEDP" value="Select  EDP Centers" onClick="ShowEdpList();"></td>
    </tr>
	 <tr id="EDP_TRAN_DT" style="display: none">
        <th>(13)</th>
        <th>Training Date From: </th>
        <td><input name="EDP_FR_DT" type="text" id="EDP_FR_DT" value="<%= EDP_FR_DT %>" size="12" maxlength="11" onClick="popUpCalendar(this, this.form.EDP_FR_DT,'dd-mmm-yyyy');return false;"></td>
        <th><div align="right">To: </div></th>
        <td><input name="EDP_TO_DT"type="text" id="EDP_TO_DT" value="<%= EDP_TO_DT %>" size="12" maxlength="11" onClick="popUpCalendar(this, this.form.EDP_TO_DT,'dd-mmm-yyyy');return false;"></td>
      </tr>
	  <tr id="EDP_CERT_DT" style="display: none">
        <th>(14)</th>
        <th>Certificate Issue Date: </th>
        <td colspan="3"><input name="EDP_CERT_DT" type="text"  id= "EDP_CERT_DT" value="<%= EDP_CERT_DT %>" size="12" maxlength="11"  onClick="popUpCalendar(this, this.form.EDP_CERT_DT,'dd-mmm-yyyy');return false;"></td>
    </tr>
	 <tr>
        <td colspan="3"><div align="center" class="GreenLebel">Margin Money (Subsidy) Adjustment against TDR (Stage-7) </div></td>
     
	  <tr>
        <th>(3)</th>
        <th>Adjustment Date: </th>
        <td><input name="MM_ADJ_DT" type="text" id="MM_ADJ_DT" onClick="popUpCalendar(this, this.form.MM_ADJ_DT,'dd-mmm-yyyy');return false;" value="<%= MM_ADJ_DT%>" size="12" maxlength="11" readonly="true"></td>
     
	  <tr>
        <th>(4)</th>
        <th>Adjustment Amount</th>
        <td><input name="MM_ADJ_AMT" type="text" id="MM_ADJ_AMT" tabindex="23" value="<%=MM_ADJ_AMT %>" size="12" maxlength="7" readonly="true"></td>
     
	  <tr>
        <th colspan="3"><div align="center">
            <input name="btnFinalSave" type="button" class="button" id="btnFinalSave" tabindex="24" onClick="abc();"  value="Save Data">
        </div></th>
    </table>
    <%
 try {
			if (ins.equals("I")){
				
APP_ID=request.getParameter("APP_ID")==null?"":request.getParameter("APP_ID");
TDR_ACNO =request.getParameter("TDR_ACNO")==null?"":request.getParameter("TDR_ACNO");	
TDR_ADJ_DT =request.getParameter("TDR_ADJ_DT")==null?"":request.getParameter("TDR_ADJ_DT");	
MM_ADJ_AMT=request.getParameter("MM_ADJ_AMT")==null?"":request.getParameter("MM_ADJ_AMT");
MM_ADJ_DT =request.getParameter("MM_ADJ_DT")==null?"":request.getParameter("MM_ADJ_DT");
EDP_TRG_NAME=request.getParameter("EDP_TRG_NAME")==null?"":request.getParameter("EDP_TRG_NAME");
EDP_FR_DT=request.getParameter("EDP_FR_DT")==null?"":request.getParameter("EDP_FR_DT");	
EDP_TO_DT =request.getParameter("EDP_TO_DT")==null?"":request.getParameter("EDP_TO_DT");	
EDP_CERT_DT=request.getParameter("EDP_CERT_DT")==null?"":request.getParameter("EDP_CERT_DT");

List values=new ArrayList();
        List pstm=new ArrayList();		
StringBuffer sb = new StringBuffer();
		 sb.append("   UPDATE  BANK_DATAENTRY SET TDR_ACNO=?, TDR_ADJ_DT=?, MM_ADJ_DT=?,   ").
             append("  MM_ADJ_AMT=?, EDP_TRG_NAME=? ,EDP_FR_DT=?, EDP_TO_DT=?,  EDP_CERT_DT=?  WHERE APP_ID =?  AND PACT_ID=34  AND APPRV_YN='A'  ");

db.setSqlValue(sb.toString());
        db.setValues(values,pstm); 
		
  values.add(TDR_ACNO);pstm.add("D");
  values.add(TDR_ADJ_DT);pstm.add("D");
  values.add(MM_ADJ_DT);pstm.add("D");
  values.add(MM_ADJ_AMT);pstm.add("D"); 
  values.add(EDP_TRG_NAME);pstm.add("D");
  values.add(EDP_FR_DT);pstm.add("D");
  values.add(EDP_TO_DT);pstm.add("D"); 
  values.add(EDP_CERT_DT);pstm.add("D");
  values.add(APP_ID);pstm.add("D");
 
  db.executeUpdate();
  db.close();
  values.clear();
  pstm.clear();	
  //response.sendRedirect("savemsg.jsp");
  }
  }
  catch (Exception e) {
	  out.print(e);
	  
  }	   
  %>
  

</form>
<script>
 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 
 function ShowEdpList(){
var urlpar='edplov.jsp?STATE_CD=';
 modalWin.ShowURL(urlpar,700,900,'EDP LIST',null,null);
 }
 
 function getEdpName(OFFNAME){
 form1.EDP_TRG_NAME.value=OFFNAME;

}

 
function HideModalWindow() {
    modalWin.HideModalPopUp();
}



</script>
</body>
</html>
