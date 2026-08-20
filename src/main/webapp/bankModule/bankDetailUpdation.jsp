 <%@ page session="true" buffer="500kb" import="java.sql.*,java.util.Date,javax.sql.*,javax.naming.*,java.util.*,java.text.*,java.util.*,pkgPmegpNew.DBCon"  %>
<%
response.setContentType("text/html");
response.setHeader("Cache-control","no-cache");
response.setHeader("Cache-control","private");
%>

<HTML>
<HEAD>
<TITLE>PMEGP Bank Data Entry Form</TITLE>

<LINK rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<SCRIPT src="../js/ModalPopupWindow.js" type="text/javascript"></SCRIPT>
<SCRIPT type="text/javascript" src="../js/datetimepicker_css.js"></SCRIPT>
<SCRIPT src="../js/inlineMsgMain.js"></SCRIPT>
<SCRIPT src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></SCRIPT>
<SCRIPT type="text/javascript">
function show(){
var SCHEME_NM=document.form1.BANK_COMMENT.value;
//alert(SCHEME_NM);
    if (SCHEME_NM == "TDR"){
 	 TDR.style.display = "block"; 
	  TDR1.style.display = "block"; 
	}
	else {
		TDR.style.display = "none"; 
		 TDR1.style.display = "none"; 
		
	}
 if (SCHEME_NM == "SRF"){
	 // alert(SCHEME_NM);
 	 SRF.style.display = "block";
	 SRF1.style.display = "block"; 
	}
  else{
	   SRF.style.display = "none"; 
	   SRF1.style.display = "none"; 
  }
}
function abc(){

 var dtRegex = new RegExp("^([0]?[1-9]|[1-2]\\d|3[0-1])-(JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC)-[1-2]\\d{3}$", 'i');

	            var TDR_ADJ_DT = document.form1.TDR_ADJ_DT.value; 
				var EDP_FR_DT = document.form1.EDP_FR_DT.value; 
				var EDP_TO_DT = document.form1.EDP_TO_DT.value; 
				var EDP_CERT_DT = document.form1.EDP_CERT_DT.value; 
	
	 if (TDR_ADJ_DT != "") {
	if  (!dtRegex.test(TDR_ADJ_DT)){
	inlineMsg('TDR_ADJ_DT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
	  }
  }
	
	
	 if (EDP_FR_DT != "") {
	if  (!dtRegex.test(EDP_FR_DT)){
	inlineMsg('EDP_FR_DT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
	  }
  }
	
	 if (EDP_TO_DT != "") {
	if  (!dtRegex.test(EDP_TO_DT)){
	inlineMsg('EDP_TO_DT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
	  }
  }
  
  
   if (EDP_CERT_DT != "") {
	if  (!dtRegex.test(EDP_CERT_DT)){
	inlineMsg('EDP_CERT_DT',"WRONG DATE OR DATE FORMAT SHOULD BE (DD-MON-YYYY)",2);
    return false;
	  }
  }
	
	
	
	
	
	
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
                    $('#EDP').show() && $('#EDP_NAME').show() && $('#EDP_TRAN_DT').show() && $('#EDP_CERT_DT1').show();
				}
				else if (EDP_CERT_DT != "")
				{
					 $('#EDP').show() && $('#EDP_NAME').show() && $('#EDP_TRAN_DT').show() && $('#EDP_CERT_DT1').show();
				
				}
				else
				{
					
					 $('#EDP').hide() && $('#EDP_NAME').hide() && $('#EDP_TRAN_DT').hide() && $('#EDP_CERT_DT1').hide();
				
				}
				
				

            
        });




</SCRIPT> 
<STYLE type="text/css">
<!--
.style1 {
	color: #FF0000;
	font-size: 24px;
}
.style3 {font-size: 18px}
.style8 {font-size: 17px; }
.style9 {color: #008000; font-size: 17px; }
-->
</STYLE>
</HEAD>
 <BODY onLoad="show()";>
 <FORM  method="post"  name="form1" id="form1" >
  <%		
		String APP_ID =request.getParameter("APP_ID")==null?"":(String)request.getParameter("APP_ID");
        String ins= request.getParameter("ins")==null?"":(String) request.getParameter("ins");     		
		//out.print(APP_ID);
		String OFF_CD="";
		DBCon db= new DBCon();
        db.connect();
		
        StringBuffer qrysb = new StringBuffer();
   qrysb.append("  SELECT MOM.OFF_NAME1,BD.BANK_COMMENT,BD.OFF_CD,BD.EDP_TRG_NAME,TO_CHAR(BD.EDP_FR_DT,'DD-MON-YYYY') AS EDP_FR_DT,BD.TDR_ACNO,TO_CHAR(BD.TDR_ADJ_DT,'DD-MON-YYYY') AS TDR_ADJ_DT," );
   qrysb.append("  TO_CHAR(BD.EDP_TO_DT,'DD-MON-YYYY') AS EDP_TO_DT,TO_CHAR(BD.EDP_CERT_DT,'DD-MON-YYYY') AS EDP_CERT_DT, ");
   qrysb.append("  MOM.AGENCY_TYPE,AD.E_MAIL,AD.AADHAR_NO,AD.PAN_NO,  MD.DISTRICT_NAME,to_char(sysdate,'DD-MON-YYYY') as TODAYDT,  AD.APP_ID, AD.APP_NAME,  AD.MOB_NO1,  BD.IFSC_CODE, ");
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
	  TDR_ACNO=rsMain.getString("TDR_ACNO")==null?"":rsMain.getString("TDR_ACNO");
	  TDR_ADJ_DT=rsMain.getString("TDR_ADJ_DT")==null?"":rsMain.getString("TDR_ADJ_DT");
	  BANK_COMMENT=rsMain.getString("BANK_COMMENT")==null?"":rsMain.getString("BANK_COMMENT");
	  
	  
	 edpcount=edpcount+1;		
  }
 rsMain.close();
 //Validation query
 try{
 
			if (ins.equals("I")){
				
				
				
				
APP_ID=request.getParameter("APP_ID")==null?"":request.getParameter("APP_ID");
TDR_ACNO =request.getParameter("TDR_ACNO")==null?"":request.getParameter("TDR_ACNO").trim();	
TDR_ADJ_DT =request.getParameter("TDR_ADJ_DT")==null?"":request.getParameter("TDR_ADJ_DT").trim();	
MM_ADJ_AMT=request.getParameter("MM_ADJ_AMT")==null?"":request.getParameter("MM_ADJ_AMT").trim();
MM_ADJ_DT =request.getParameter("MM_ADJ_DT")==null?"":request.getParameter("MM_ADJ_DT").trim();
EDP_TRG_NAME=request.getParameter("EDP_TRG_NAME")==null?"":request.getParameter("EDP_TRG_NAME").trim();
EDP_FR_DT=request.getParameter("EDP_FR_DT")==null?"":request.getParameter("EDP_FR_DT").trim();	
EDP_TO_DT =request.getParameter("EDP_TO_DT")==null?"":request.getParameter("EDP_TO_DT").trim();	
EDP_CERT_DT=request.getParameter("EDP_CERT_DT")==null?"":request.getParameter("EDP_CERT_DT").trim();
OFF_CD=(String) request.getParameter("OFF_CD")==null?"":(String) request.getParameter("OFF_CD").trim();
BANK_COMMENT=(String) request.getParameter("BANK_COMMENT")==null?"":(String) request.getParameter("BANK_COMMENT").trim();
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
			

if (errcount<1)
{

try {

	
StringBuffer sb = new StringBuffer();
		 sb.append("   UPDATE  BANK_DATAENTRY SET TDR_ACNO=?, TDR_ADJ_DT=?, BANK_COMMENT=?,  ").
             append("  MM_ADJ_AMT=?, EDP_TRG_NAME=? ,EDP_FR_DT=?, EDP_TO_DT=?,  EDP_CERT_DT=?, OFF_CD=?  WHERE APP_ID =?  AND PACT_ID=34  AND APPRV_YN='A'  ");

db.setSqlValue(sb.toString());
        db.setValues(values,pstm); 
		
  values.add(TDR_ACNO);pstm.add("D");
  values.add(TDR_ADJ_DT);pstm.add("D");
  //values.add(MM_ADJ_DT);pstm.add("D");
  values.add(BANK_COMMENT);pstm.add("D");
  values.add(MM_ADJ_AMT);pstm.add("D"); 
  values.add(EDP_TRG_NAME);pstm.add("D");
  values.add(EDP_FR_DT);pstm.add("D");
  values.add(EDP_TO_DT);pstm.add("D"); 
  values.add(EDP_CERT_DT);pstm.add("D");
  values.add(OFF_CD);pstm.add("D");
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
  }


		
		}//end of ins
	}catch (Exception e) {
	
	out.print (e.toString());
	}	
  
 
	  
			
 
 
 %>
   
    <% if (!verror.equals("")) {%>
<DIV class="error">

<%
out.print (verror);
%> </DIV>
<%}%>

 <% if (verror.equals("") && ins.equals("I")) {%>
<DIV class="success">
  
 </DIV><%}%>
  
    <TABLE width="100%">
    <TR>
      <TH height="23" colspan="6" nowrap><DIV align="center" class="style29 style39 style3">BANK DETAIL UPDATION FORM </DIV></TH>
	  <INPUT name="ins" type="hidden" id="ins" value="<%= ins %>   ">
	  <INPUT name="APP_ID" type="hidden" id="APP_ID" value="<%= APP_ID %>   ">
	  </TR>
	  <TR>
      <TH colspan="6" ><DIV align="center" class="style34">(Date Format:dd-mon-yyyy ex:
              <INPUT name="TODAYDT" type="hidden"  id="TODAYDT" tabindex="0" value="<%=TODAYDT %>" size="12">
              <%=TODAYDT %> and Amount in Rs) </DIV></TH>
    </TR>
    <TR>
      <TH  ><DIV align="right">Applicant ID : </DIV></TH>
      <TH > <%= APP_ID %> </TH>
       <TH colspan="3"  ><DIV align="right">Applicant Name:</DIV></TH>
      <TH  ><%= APP_NAME %> </TH>
    </TR>
    <TR>
      <TH  ><DIV align="right">Aadhaar Card No: </DIV></TH>
      <TH  ><%= AADHAR_NO %></TH>
      <TH colspan="3"  ><DIV align="right">PAN NO: </DIV></TH>
      <TH  ><%= PAN_NO %>
      
    </TR>
    <TR>
      <TH  ><DIV align="right">Applicant Contact No: </DIV></TH>
     <TH  ><%= MOB_NO1  %></TH>
    <TH colspan="3"  ><DIV align="right">Applicant email:</DIV></TH>
     <TH  ><%= E_MAIL %></TH>
      </TR>
    <TR>
      <TH  ><DIV align="right">MM Claim Amount: </DIV></TH>
      <TH  ><%=  MM_CLAIM_AMT  %></TH>
      <TH colspan="3"  ><DIV align="right">MM Calim Date:</DIV></TH>
      <TH  ><%=  MM_CLAIM_DT%></TH>
      </TR>
	  <TR>
	    <TH colspan="6"  ><DIV align="center"><u><SPAN class="style1">MARGIN MONEY RELEASE DETAILS </SPAN></u></DIV></TH>
	    
      </TR>
	  <TR>
      <TH  ><DIV align="right" class="style8">MM Release Amount: </DIV></TH>
     <TH  ><SPAN class="style9"><%= MM_REL_AMT  %></SPAN></TH>
      <TH colspan="3"  ><DIV align="right" class="style8">MM Release Date:</DIV></TH>
      <TH  ><SPAN class="style9"><%= MM_REL_DT %></SPAN></TH>
      </TR>
	 <TR>
      <TH  ><DIV align="right" class="style8">Transient Account No: </DIV></TH>
     <TH  ><SPAN class="style9"><%= FB_ACNO  %></SPAN></TH>
      <TH colspan="3"  ><DIV align="right" class="style8">UTRN NO:</DIV></TH>
      <TH  ><SPAN class="style9"><%= UTRN_NO %></SPAN></TH>
      </TR>
   </TABLE>
    <TABLE width="100%">
	<TR>
      <TH>(1)</TH>
	  <TH >Select TDR/SRF: </TH>
      <TD><INPUT name="BANK_COMMENT" type="radio" id="BANK_COMMENT"  onchange="show()"; value="TDR" checked <% if (BANK_COMMENT.equals("TDR")){out.print("checked");} %> >
      TDR
        <INPUT name="BANK_COMMENT"  id="BANK_COMMENT" type="radio" onChange="show()"; value="SRF" <% if (BANK_COMMENT.equals("SRF")){out.print("checked");} %> >
       SRF</TD>     
    </TR>
      <TR>
        <TH>(2)</TH>
        <TH>Beneficiary <SPAN id="TDR" style="display:none">TDR</SPAN><SPAN id="SRF" style="display:none">SRF</SPAN> Account No: </TH>
        <TD><INPUT name="TDR_ACNO" type="text" id="TDR_ACNO"  size="20" maxlength="20" value="<%= TDR_ACNO %>"></TD>
	  </TR>
      <TR>
        <TH>(3)</TH>
        <TH>Deposit Date in <SPAN id="TDR1" style="display:none">TDR</SPAN><SPAN id="SRF1" style="display:none">SRF</SPAN> : </TH>
        <TD><INPUT name="TDR_ADJ_DT" id="TDR_ADJ_DT" type="text"  placeholder="DD-MON-YYYY" size="20" maxlength="20" onClick="javascript:NewCssCal('TDR_ADJ_DT','ddMMMyyyy')" value="<%= TDR_ADJ_DT %>"></TD>
     <TR id="EDP" style="display: none">
	   
        <TD colspan="5"><DIV align="center" class="GreenLebel">EDP Training Detail</DIV></TD>
    </TR>
	 <TR id="EDP_NAME" style="display: none">
        <TH>(4)</TH>
        <TH>Training Center Name: </TH>
        <TD colspan="3"><INPUT name="EDP_TRG_NAME" id="EDP_TRG_NAME" type="text" size="50" maxlength="50" value="<%= EDP_TRG_NAME %>" readonly="true">
		<INPUT name="OFF_CD" type="hidden" id="OFF_CD" value="<%=OFF_CD%>" size="50" maxlength="50" >
            <INPUT name="btnEDP" type="button" style="background-color:#0000CC" class="buttonBlue" id="btnEDP" value="Select  EDP Centers" onClick="ShowEdpList();"></TD>
    </TR>
	 <TR id="EDP_TRAN_DT" style="display: none">
        <TH>(5)</TH>
        <TH>Training Date From: </TH>
        <TD><INPUT name="EDP_FR_DT" type="text" id="EDP_FR_DT" onClick="javascript:NewCssCal('EDP_FR_DT','ddMMMyyyy')"  value="<%= EDP_FR_DT %>" size="12" maxlength="11" PLACEHOLDER="DD-MON-YYYY"></TD>
        <TH><DIV align="right">To: </DIV></TH>
        <TD><INPUT name="EDP_TO_DT"type="text" id="EDP_TO_DT" onClick="javascript:NewCssCal('EDP_TO_DT','ddMMMyyyy')"  value="<%= EDP_TO_DT %>" size="12" maxlength="11" PLACEHOLDER="DD-MON-YYYY"></TD>
      </TR>
	  <TR id="EDP_CERT_DT1" style="display: none">
        <TH>(6)</TH>
        <TH>Certificate Issue Date: </TH>
        <TD colspan="3"><INPUT name="EDP_CERT_DT"type="text" id="EDP_CERT_DT" onClick="javascript:NewCssCal('EDP_CERT_DT','ddMMMyyyy')"  value="<%= EDP_CERT_DT%>" size="12" maxlength="11" PLACEHOLDER="DD-MON-YYYY">
		</TD>
    </TR>
	<INPUT name="MM_ADJ_DT" id="MM_ADJ_DT" type="HIDDEN"  placeholder="DD-MON-YYYY" onClick="javascript:NewCssCal('MM_ADJ_DT','ddMMMyyyy')" value="<%= MM_ADJ_DT%>" size="12" maxlength="11" readonly="true" >
	<INPUT name="MM_ADJ_AMT" id="MM_ADJ_AMT" type="HIDDEN"  tabindex="23"  value="<%=MM_ADJ_AMT %>" size="12" maxlength="7" readonly="true">
	 
       <!-- <TD colspan="3"><DIV align="center" class="GreenLebel">Margin Money (Subsidy) Adjustment against TDR (Stage-7) </DIV></TD>-->
     
	  <!--<TR>
        <TH>(3)</TH>
        <TH>Adjustment Date: </TH>
        <TD></TD>
     
	  <TR>
        <TH>(4)</TH>
        <TH>Adjustment Amount</TH>
        <TD></TD>-->
     
	  <TR>
        <TH colspan="3"><DIV align="center">
            <INPUT name="btnFinalSave" type="button" class="button" id="btnFinalSave" tabindex="24" onClick="abc();"  value="Save Data">
        </DIV></TH>
    </TABLE>
	
	 
	<%
    
 
 
  %>

</FORM>
<SCRIPT>
 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 
 function ShowEdpList(){
var urlpar='edplov.jsp?STATE_CD=';
 modalWin.ShowURL(urlpar,700,900,'EDP LIST',null,null);
 }
 
/* function getEdpName(OFFNAME){
 form1.EDP_TRG_NAME.value=OFFNAME;

}*/
 function getEdpName(OFFNAME,OFF_CD){
 form1.EDP_TRG_NAME.value=OFFNAME;
form1.OFF_CD.value=OFF_CD;
}

 
function HideModalWindow() {
    modalWin.HideModalPopUp();
}



</SCRIPT>
</BODY>
</HTML>
