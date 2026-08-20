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
<script type="text/javascript" src="../js/popcalendarN.js"></script>
<script src="../js/inlineMsgMain.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
<script type="text/javascript" src="../js/datetimepicker_css.js"></script>
<script type="text/javascript">
function abc(){

 var dtRegex = new RegExp("^([0]?[1-9]|[1-2]\\d|3[0-1])-(JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC)-[1-2]\\d{3}$", 'i');

	            //var TDR_ADJ_DT = document.form1.TDR_ADJ_DT.value; 
				var EDP_FR_DT = document.form1.EDP_FR_DT.value; 
				var EDP_TO_DT = document.form1.EDP_TO_DT.value; 
				var EDP_CERT_DT = document.form1.EDP_CERT_DT.value; 
	
	
	
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







function closeAndRefresh(){
       window.parent.refresh_data();
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
		String vREDPATH=(String)session.getAttribute("sREDPATH");
		String vDOCNAME=(String)session.getAttribute("sDOC_NAME");
		String EXT="";
		//out.print(vREDPATH);
//out.print(vDOCNAME);
        String ins= request.getParameter("ins")==null?"":(String) request.getParameter("ins");   
		 String OFF_CD="";     		
		//out.print(APP_ID);
		
		DBCon db= new DBCon();
        db.connect();
		
        StringBuffer qrysb = new StringBuffer();
   qrysb.append("  SELECT ad.app_id,app_name, upper(SUBSTR('"+vDOCNAME+"', INSTR('"+vDOCNAME+"', '.') + 1)) AS EXT from app_detail ad where ad.app_id='"+APP_ID+"'" );
  
   
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
String verror="";


int edpcount=0;
while(rsMain.next())
  {	 
      	
	  APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");	
	  EXT=rsMain.getString("EXT")==null?"":rsMain.getString("EXT");	  
	 edpcount=edpcount+1;		
  }
 rsMain.close();
 //Validation query
 try{
 
			if (ins.equals("I")){
				
				
				
				
APP_ID=request.getParameter("APP_ID")==null?"":request.getParameter("APP_ID");
EDP_TRG_NAME=request.getParameter("EDP_TRG_NAME")==null?"":request.getParameter("EDP_TRG_NAME").trim();
EDP_FR_DT=request.getParameter("EDP_FR_DT")==null?"":request.getParameter("EDP_FR_DT").trim();	
EDP_TO_DT =request.getParameter("EDP_TO_DT")==null?"":request.getParameter("EDP_TO_DT").trim();	
EDP_CERT_DT=request.getParameter("EDP_CERT_DT")==null?"":request.getParameter("EDP_CERT_DT").trim();
OFF_CD=request.getParameter("OFF_CD")==null?"":request.getParameter("OFF_CD").trim();


String validateqry="SELECT * FROM TABLE(GET_PMEGP_BANKERROR_EDP(?,?,?,?,?))";
List values=new ArrayList();
        List pstm=new ArrayList();	
     values.add (APP_ID); 	 
	 values.add (EDP_TRG_NAME);
	 values.add (EDP_FR_DT);
	 values.add (EDP_TO_DT);
	 values.add (EDP_CERT_DT);
	// values.add (OFF_CD);
	
	
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
		 sb.append("   UPDATE  BANK_DATAENTRY SET    ").
             append("   EDP_TRG_NAME=? ,EDP_FR_DT=?, EDP_TO_DT=?,  EDP_CERT_DT=?, OFF_CD=?  WHERE APP_ID =?  AND ACT_ID=11   ");

db.setSqlValue(sb.toString());
        db.setValues(values,pstm); 
		
  
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
<div class="error">

<%
out.print (verror);
%> </div>
<%}%>

 <% if (verror.equals("") && ins.equals("I")) {%>
<div class="success">
  
 </div><%}%>
  
    <table width="100%">
    <tr>
      <th height="23" colspan="6" nowrap><div align="center" class="style29 style39 style3">EDP DETAIL UPDATION FORM </div></th>
	  <input name="ins" type="hidden" id="ins" value="<%= ins %>   ">
	  <input name="APP_ID" type="hidden" id="APP_ID" value="<%= APP_ID %>   ">
	  </tr>
	  <tr>
      <th colspan="6" ><div align="center" class="style34">(Date Format:dd-mon-yyyy ex:
              <input name="TODAYDT" type="hidden"  id="TODAYDT" tabindex="0" value="<%=TODAYDT %>" size="12">
              <%=TODAYDT %>) </div></th>
    </tr>
    <tr>
      <th  ><div align="right">Applicant ID : </div></th>
      <th > <%= APP_ID %> </th>
       <th colspan="3"  ><div align="right">Applicant Name:</div></th>
      <th  ><%= APP_NAME %> </th>
    </tr>
    
   </table>
    <table width="100%">
    
      <tr>
        <th colspan="5"><div align="center">
            <input name="btnFinalSave" type="button" class="button" id="btnFinalSave" tabindex="24" onClick="abc();"  value="Save Data">
			  <input name="btnFinalSave" type="button" class="button" id="btnFinalSave" tabindex="24" onClick="closeAndRefresh();"  value="Close">
        </div></th>
      </tr>
      <tr>
	 
	   
        <td colspan="5"><div align="center" class="GreenLebel">EDP Training Detail</div></td>
    </tr>
	 
	  <tr>
        <th>(1)</th>
        <th>Training Center Name: </th>
        <td colspan="3"><input name="EDP_TRG_NAME" id="EDP_TRG_NAME" type="text" size="50" maxlength="50" readonly="true" value="<%= EDP_TRG_NAME %>">
		<input name="OFF_CD" type="HIDDEN" id="OFF_CD" value="<%= OFF_CD %>" size="50" maxlength="50" >
          <!-- <a href="edplov.jsp" class="buttonBlue">Select  EDP Centers</a>-->
		   <input name="btnEDP" type="button" class="buttonBlue" id="btnEDP" value="Select  EDP Centers" onClick="ShowEdpList();"></td>
    </tr>
	 <tr>
        <th>(2)</th>
        <th>Training Date From: </th>
        <td><input name="EDP_FR_DT" type="text" id="EDP_FR_DT" value="<%= EDP_FR_DT %>" size="12" maxlength="11" placeholder="DD-MON-YYYY" ></td>
        <th><div align="right">To: </div></th>
        <td><input name="EDP_TO_DT"type="text" id="EDP_TO_DT" value="<%= EDP_TO_DT %>" size="12" maxlength="11" placeholder="DD-MON-YYYY" ></td>
      </tr>
	  <tr >
        <th>(3)</th>
        <th>Certificate Issue Date: </th>
        <td colspan="3"><input name="EDP_CERT_DT" type="text"  id= "EDP_CERT_DT" value="<%= EDP_CERT_DT %>" size="12" maxlength="11" autocomplete="off" placeholder="DD-MON-YYYY" ></td>
    </tr>
	
	 <tr>
	    <th>EDP preview</th>
	    <th colspan="6"><div align="center">
		<% if (!EXT.equals("PDF")){%>
		<img src="../../pmegpeportalappdoc/<%= vREDPATH %>/<%= vDOCNAME %>"  >
		<%} else {%>
		<a href="../../pmegpeportalappdoc/<%= vREDPATH %>/<%= vDOCNAME %>" target="_blank">Download PDF </a>
		<%}%>
		</div></th>
      </tr>
	
	
	
	
	
	
	
	
	
	
	
        <th colspan="6"></th>
    </table>
	
	 
	<%
    
 
 
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
 
 function getEdpName(OFFNAME,OFF_CD){
 form1.EDP_TRG_NAME.value=OFFNAME;
 form1.OFF_CD.value=OFF_CD;
}


 
function HideModalWindow() {
    modalWin.HideModalPopUp();
}



</script>
</body>
</html>
