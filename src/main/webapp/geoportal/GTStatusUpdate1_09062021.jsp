<%@ page session="true"  import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.SQLException"%>
<%
response.setContentType("text/html");
response.setHeader("Cache-control","no-cache");
response.setHeader("Cache-control","private");
%>

<HTML>
<HEAD>
<TITLE>PMEGP Agency Status Update Form</TITLE>
<LINK rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<SCRIPT language="javascript" src="../js/inlineMsgMain.js"></SCRIPT>


<SCRIPT language="javascript">

function chMd()
 {	
	var actid=document.form.MM_ADJUSTMENT_STATUS.value;

     if( actid == "FA")
     {
		
        document.forms[0].MM_ADJUSTMENT_AMT_S.disabled=false;
		document.forms[0].MM_ADJUSTMENT_AMT_S.value=document.form.MM_REL_AMT.value;
                  
     }
     else if( actid == "PA")
     {
	 
	 var ce=document.form.MM_REL_AMT.value;	
		
	 var tcewe=Number(ce)/2;
	
      
        document.forms[0].MM_ADJUSTMENT_AMT_S.disabled=false;
       
		document.forms[0].MM_ADJUSTMENT_AMT_S.value=tcewe;
        
        
      
     }
	   else if( actid == "FD")
     {      
        document.forms[0].MM_ADJUSTMENT_AMT_S.disabled=true;
       
		document.forms[0].MM_ADJUSTMENT_AMT_S.value=0
              
      document.forms[0].MM_ADJUSTMENT_AMT_S.style.backgroundColor="#A0A0A0";
     }
       
	    else if( actid == "RU")
     {      
        document.forms[0].MM_ADJUSTMENT_AMT_S.disabled=true;
       
		document.forms[0].MM_ADJUSTMENT_AMT_S.value=''
              
      document.forms[0].MM_ADJUSTMENT_AMT_S.style.backgroundColor="#A0A0A0";
     }
       

	
	
	}


function form_submit(){



var MM_ADJUSTMENT_STATUS = document.form.MM_ADJUSTMENT_STATUS.value;
    var MM_ADJUSTMENT_AMT_S = document.form.MM_ADJUSTMENT_AMT_S.value;
    var NODAL_OFFICER_REMARK = document.form.NODAL_OFFICER_REMARK.value;
	var MM_REL_AMT  = document.form.MM_REL_AMT.value


if ( MM_ADJUSTMENT_STATUS == "") {	 inlineMsg ( 'MM_ADJUSTMENT_STATUS','Select MM Adjustemnt Status',2);	return (false);}
if (MM_ADJUSTMENT_AMT_S == "") {	 inlineMsg ( 'MM_ADJUSTMENT_AMT_S','Enter MM Adjustemnt Amount',2); return (false);}
 if (NODAL_OFFICER_REMARK== "") {	 inlineMsg ( 'NODAL_OFFICER_REMARK','Enter Nodal Officer Remarksn',2);	return (false);}

if ( MM_ADJUSTMENT_STATUS == "FA") {
if (MM_ADJUSTMENT_AMT_S != MM_REL_AMT) {
inlineMsg ( 'MM_ADJUSTMENT_AMT_S','Enter Correct MM Adjustemnt Amount',2); return (false);}
}
if ( MM_ADJUSTMENT_STATUS == "PA") {

if (Number(MM_ADJUSTMENT_AMT_S) > Number(MM_REL_AMT) || MM_ADJUSTMENT_AMT_S == "0") {
//alert(MM_REL_AMT);
inlineMsg ( 'MM_ADJUSTMENT_AMT_S','Enter Correct MM Adjustemnt Amount',2); return (false);}
}

document.form.ins.value='I';
document.form.submit();


}

//}

</SCRIPT>
</HEAD>
<BODY>
<form   name="form" id ="form" method="post" >
<%	

DBCon db= new DBCon();
db.connect();
String ins = "";
ins = (String) request.getParameter("ins")==null?"":(String) request.getParameter("ins").trim();
String  APP_ID =request.getParameter("APP_ID")==null?"":(String)request.getParameter("APP_ID");
String  PMEGPGEOTAGID =request.getParameter("PMEGPGEOTAGID")==null?"":(String)request.getParameter("PMEGPGEOTAGID");
String  APP_NAME =request.getParameter("APP_NAME")==null?"":(String)request.getParameter("APP_NAME");

String MARGIN_MONEY_ADJUSTMENT_AMOUNT="";
String MM_REL_AMT="";

String VERIFICATION_STATUS="";
String VERIFIER_REMARKS="";

String NODAL_OFFICER_REMARK="";
String MM_ADJUSTMENT_AMT_S="";
String PHYSICAL_VERIFICATION_STATUS="";
String MM_ADJUSTMENT_STATUS="";
String CALLBACK_AMOUNT="";
  String DATE_OF_VERIFICATION="";
  String VERIFICATION_BY="";
  String TOT_PRJ="";

  String PER_CAPITA_INVESTMENT_NORM_SAT="";
  String TOTAL_EMPLOYEES="";
  String UNIT_ESTABLISHMENT_DATE="";
  String UNIT_SETUP_ON="";
  String UNIT_NAME="";
  String CAPITAL_COST_OF_BUILDING="";
  String CAPITAL_COST_OF_MACHINERY="";
  String CALLBACK_REASON="";
  String MACHINARY_COST="";
  String WORKING_CAPITAL="";

StringBuffer qrysb= new StringBuffer();
	
qrysb.append("   "      );
qrysb.append("    SELECT GT.PMEGPGEOTAGID,"      );
qrysb.append("     AD.APP_ID, GT.VERIFICATION_STATUS,GT.VERIFIER_REMARKS ,  AD.APP_NAME,NVL(BD.WORKING_CAPITAL,0) AS WORKING_CAPITAL,+NVL(BD.MACHINARY_COST,0) AS ");
qrysb.append(" MACHINARY_COST,NVL(BD.MACHINARY_COST,0)+NVL(BD.WORKING_CAPITAL,0)AS TOT_PRJ, "      );

qrysb.append(" BD.MM_REL_AMT, GT.MARGIN_MONEY_ADJUSTMENT_AMOUNT, GT.NODAL_OFFICER_REMARK,"      );
 qrysb.append(" GT.MM_ADJUSTMENT_AMT_S, GT.PHYSICAL_VERIFICATION_STATUS, GT.MM_ADJUSTMENT_STATUS,"      );
qrysb.append("  GT.CALLBACK_AMOUNT, "      );
qrysb.append("   TO_CHAR(GT.DATE_OF_VERIFICATION,'DD-MON-RRRR') AS DATE_OF_VERIFICATION, "      );
qrysb.append("   GT.VERIFICATION_BY, "      );
qrysb.append("   GT.VERIFICATION_STATUS, "      );
qrysb.append("   GT.VERIFIER_REMARKS,"      );
qrysb.append("   GT.PER_CAPITA_INVESTMENT_NORM_SAT, "      );
qrysb.append("   GT.TOTAL_EMPLOYEES, "      );
qrysb.append("   TO_CHAR(GT.UNIT_ESTABLISHMENT_DATE,'DD-MON-RRRR') AS UNIT_ESTABLISHMENT_DATE,"      );
qrysb.append("   GT.UNIT_SETUP_ON, "      );
qrysb.append("   GT.UNIT_NAME, "      );
qrysb.append("   GT.CAPITAL_COST_OF_BUILDING, "      );
qrysb.append("   GT.CAPITAL_COST_OF_MACHINERY,"      );
qrysb.append("  GT.CALLBACK_REASON "      );
qrysb.append("      FROM APP_DETAIL AD,"      );
qrysb.append("        BANK_DATAENTRY BD,"      );
qrysb.append("        MAS_OFF_MAST MOM,"      );
qrysb.append("        M_DISTRICT MD,"      );
qrysb.append("        M_STATE MS,"      );
qrysb.append("        ACTIVITY_MAST AM,"      );
qrysb.append("        GEOTAG_TRANS GT,"      );
qrysb.append("        RBIBANKLIST RBL,"      );
qrysb.append("        IND_GRP_MAST IGM"      );
qrysb.append("    WHERE AD.APP_ID     = BD.APP_ID"      );
qrysb.append("      AND AD.OFF_CD       = MOM.OFF_CD"      );
qrysb.append("      AND AD.UNIT_DIST_CD = MD.DISTRICT_CD"      );
qrysb.append("      AND MS.STATE_CD     = MD.STATE_CD"      );
qrysb.append("      AND AM.ACTIVITY_CD  = AD.ACTIVITY_CD"      );
qrysb.append("      AND AD.IFSC_CODE    = RBL.IFSC_CODE"      );

qrysb.append("      AND AD.APP_ID       = GT.APP_ID AND AM.IND_GRP_CD   = IGM.IND_GRP_CD AND BD.PACT_ID      = 34 AND AD.APP_ID =? AND GT.PMEGPGEOTAGID=?     "      );


List values=new ArrayList();

values.add(APP_ID);
values.add(PMEGPGEOTAGID);
  
   ResultSet rs = db.executeSQL(qrysb.toString(),values);
   values.clear();




	while (rs.next()){
	
	
	APP_ID=rs.getString("APP_ID")==null?"":rs.getString("APP_ID");	
	APP_NAME=rs.getString("APP_NAME")==null?"":rs.getString("APP_NAME");
	PMEGPGEOTAGID=rs.getString("PMEGPGEOTAGID")==null?"":rs.getString("PMEGPGEOTAGID");
	MARGIN_MONEY_ADJUSTMENT_AMOUNT=rs.getString("MARGIN_MONEY_ADJUSTMENT_AMOUNT")==null?"":rs.getString("MARGIN_MONEY_ADJUSTMENT_AMOUNT");
	
	NODAL_OFFICER_REMARK=rs.getString("NODAL_OFFICER_REMARK")==null?"":rs.getString("NODAL_OFFICER_REMARK");
	MM_ADJUSTMENT_AMT_S=rs.getString("MM_ADJUSTMENT_AMT_S")==null?"":rs.getString("MM_ADJUSTMENT_AMT_S");
	PHYSICAL_VERIFICATION_STATUS=rs.getString("PHYSICAL_VERIFICATION_STATUS")==null?"":rs.getString("PHYSICAL_VERIFICATION_STATUS");
	MM_ADJUSTMENT_STATUS=rs.getString("MM_ADJUSTMENT_STATUS")==null?"":rs.getString("MM_ADJUSTMENT_STATUS");
	MM_REL_AMT=rs.getString("MM_REL_AMT")==null?"":rs.getString("MM_REL_AMT");
	VERIFICATION_STATUS=rs.getString("VERIFICATION_STATUS")==null?"":rs.getString("VERIFICATION_STATUS");
	VERIFIER_REMARKS=rs.getString("VERIFIER_REMARKS")==null?"":rs.getString("VERIFIER_REMARKS");
	 CALLBACK_AMOUNT=rs.getString("CALLBACK_AMOUNT")==null?"":rs.getString("CALLBACK_AMOUNT");
  DATE_OF_VERIFICATION=rs.getString("DATE_OF_VERIFICATION")==null?"":rs.getString("DATE_OF_VERIFICATION");
  VERIFICATION_BY=rs.getString("VERIFICATION_BY")==null?"":rs.getString("VERIFICATION_BY");
  VERIFICATION_STATUS=rs.getString("VERIFICATION_STATUS")==null?"":rs.getString("VERIFICATION_STATUS");
  TOT_PRJ=rs.getString("TOT_PRJ")==null?"":rs.getString("TOT_PRJ");
  PER_CAPITA_INVESTMENT_NORM_SAT=rs.getString("PER_CAPITA_INVESTMENT_NORM_SAT")==null?"":rs.getString("PER_CAPITA_INVESTMENT_NORM_SAT");
  TOTAL_EMPLOYEES=rs.getString("TOTAL_EMPLOYEES")==null?"":rs.getString("TOTAL_EMPLOYEES");
  UNIT_ESTABLISHMENT_DATE=rs.getString("UNIT_ESTABLISHMENT_DATE")==null?"":rs.getString("UNIT_ESTABLISHMENT_DATE");
  UNIT_SETUP_ON=rs.getString("UNIT_SETUP_ON")==null?"":rs.getString("UNIT_SETUP_ON");
  UNIT_NAME=rs.getString("UNIT_NAME")==null?"":rs.getString("UNIT_NAME");
  CAPITAL_COST_OF_BUILDING=rs.getString("CAPITAL_COST_OF_BUILDING")==null?"":rs.getString("CAPITAL_COST_OF_BUILDING");
  CAPITAL_COST_OF_MACHINERY=rs.getString("CAPITAL_COST_OF_MACHINERY")==null?"":rs.getString("CAPITAL_COST_OF_MACHINERY");
  CALLBACK_REASON=rs.getString("CALLBACK_REASON")==null?"":rs.getString("CALLBACK_REASON");
  MACHINARY_COST=rs.getString("MACHINARY_COST")==null?"":rs.getString("MACHINARY_COST");
  WORKING_CAPITAL=rs.getString("WORKING_CAPITAL")==null?"":rs.getString("WORKING_CAPITAL");
	
	
	
		}
	  rs.close();


%>
<FORM name="form" id="form"  class="form" method="post" >

  <TABLE align="center" width="100%">

  <TR>
    <TH colspan="12"> 
      <INPUT name="APP_ID" type="hidden" id="APP_ID" value="<%= APP_ID %>">
      <DIV align="center"><H3>Margin Money Adjustment Update Form</H3></DIV></TH>
  </TR>
  <TR>
    <TH colspan="6"><DIV align="left">
          <INPUT name="ins" type="hidden" id="ins">
      Applicant Id</span> :      </DIV></TH>
    <TH colspan="4"><DIV align="left"><%=APP_ID %>   </DIV></TH>
    <TH>Geo Tagging Id </TH>
    <TH><%= PMEGPGEOTAGID %></TH>
  </TR>
  <TR >
    <TH colspan="6" ><DIV align="left">Beneficiary Name  :</DIV></TH>
    <TD colspan="6" ><DIV align="left"><%=  APP_NAME %></DIV></TD>
    </TR>
  
	<TR >
	  <TH colspan="12" ><DIV align="center">Verification Details </DIV></TH>
    </TR>
	<TR >
	  <TH colspan="6" >Date of Verification: </TH>
	  <TD colspan="4" ><%= DATE_OF_VERIFICATION %></TD>
      <TH >Verification By:</TH>
      <TD ><%= VERIFICATION_BY %></TD>
	</TR>
	<TR >
	  <TH colspan="6" >Physical Verification Status: </TH>
	  <TD colspan="4" ><H1><%= VERIFICATION_STATUS %></H1></TD>
      <TH >Physical Verification Remarks: </TH>
      <TD ><%= VERIFIER_REMARKS %></TD>
	</TR>
	
	<TR >
	  <TH colspan="12" >&nbsp;</TH>
    </TR>
	<TR >
	  <TH colspan="6" >Per Capita Investment : </TH>
	  <TD colspan="4" ><%= PER_CAPITA_INVESTMENT_NORM_SAT %></TD>
      <TH >Total Employees: </TD>
      <TD ><%= TOTAL_EMPLOYEES %></TD>
	</TR>
	
	<TR >
	  <TH colspan="12" ><DIV align="center">Unit Description </DIV></TH>
    </TR>
	<TR >
	  <TH colspan="6" >Unit Name: </TH>
	  <TD ><%= UNIT_NAME %></TD>
      <TH >Unit Establishment Date </TH>
      <TD ><%= UNIT_ESTABLISHMENT_DATE %></TD>
      <TH >Unit Set Up On: </TH>
      <TD colspan="2" ><%= UNIT_SETUP_ON %></TD>
    </TR>
	
	<TR >
	  <TH colspan="12" >&nbsp;</TH>
    </TR>
	<TR >
	  <TH colspan="6" >Capital Cost Of Biulding : </TH>
	  <TD colspan="4" ><%= CAPITAL_COST_OF_BUILDING %></TD>
      <TH >Capital Cost Of Machinery: </TH>
      <TD ><%= CAPITAL_COST_OF_MACHINERY %></TD>
	</TR>
	
	 <TR >
    <TH ><DIV align="left">Working Capital </DIV></TH>
    <TH ><%= WORKING_CAPITAL %></TH>
    <TH >Capital Expenditure </TH>
    <TH ><%= MACHINARY_COST %></TH>
    <TH >Total Project Cost </TH>
    <TH colspan="5" ><DIV align="left"><%= TOT_PRJ %></DIV></TH>
    <TD ><STRONG>MM Released Amount</STRONG></TD>
    <TD ><%= MM_REL_AMT %>
      <INPUT name="MM_REL_AMT" type="hidden" id="MM_REL_AMT"  size="10" maxlength="7"  value="<%= MM_REL_AMT %>" ></TD>
  </TR>
  	 <TR >
  	   <TH colspan="12" >&nbsp;</TH>
    </TR>
    <TR >
	  <TH colspan="6" >CallBack Reason: </TH>
	  <TD colspan="4" ><%= CALLBACK_REASON %></TD>
      <TH >CallBack Amount: </TH>
      <TD ><%= CALLBACK_AMOUNT %></TD>
	</TR>
  <TR >
    <TH colspan="12" ><DIV align="center"><STRONG><H3>Recommendation of District Nodal Officer</H3></STRONG></DIV></TH>
    </TR>
  <TR >
    <TH colspan="6" rowspan="2" ><DIV align="left">MM Adjustemnt Status </DIV></TH>
	 <% if (VERIFICATION_STATUS.equals("Completed") || VERIFICATION_STATUS.equals("Defunct")) {%>
    <TD colspan="4" >
      <DIV align="left">
      		
		<INPUT type="radio" id="opt-1" value="FA"  onClick="chMd()" name="MM_ADJUSTMENT_STATUS" <% if (MM_ADJUSTMENT_STATUS.equals("FA")){out.print("checked");}%>> <SPAN class="GreenLebel">Fully Allowed</SPAN>		</DIV>  </TD>
    <TD colspan="2" ><DIV align="left">
	<INPUT type="radio" id="opt-1" value="PA"  onClick="chMd()" name="MM_ADJUSTMENT_STATUS" <% if (MM_ADJUSTMENT_STATUS.equals("PA")){out.print("checked");}%>><SPAN class="OrangeLebel">Partially Allowed</SPAN>
     </DIV></TD>
	 <%}%>
    </TR>

  <TR >
  	<% if (VERIFICATION_STATUS.equals("Non-Traceable") || VERIFICATION_STATUS.equals("Completed")  || VERIFICATION_STATUS.equals("Defunct")) {%>
    <TD colspan="4" ><DIV align="left">
	<INPUT type="radio" id="opt-1" value="FD"  onClick="chMd()" name="MM_ADJUSTMENT_STATUS" <% if (MM_ADJUSTMENT_STATUS.equals("FD")){out.print("checked");}%>> <SPAN class="redLebel">Fully Disallowed</SPAN>
   
     </DIV></TD>
	 <%}%>
	 <% if (VERIFICATION_STATUS.equals("Non-Traceable")) {%>
    <TD colspan="2" >
    <DIV align="left">
	  <INPUT type="radio" id="opt-1" value="RU" onClick="chMd()" name="MM_ADJUSTMENT_STATUS" <% if (MM_ADJUSTMENT_STATUS.equals("RU")){out.print("checked");}%>><SPAN class="MarunLebel">Reverification of Unit </SPAN>    </DIV></TD>
	  <%}%>
    </TR>
  <TR >
    <TH colspan="6" ><DIV align="left">MM Adjustemnt Amount </DIV></TH>
    <TD colspan="6" ><DIV align="left"><INPUT type="text" name="MM_ADJUSTMENT_AMT_S" id="MM_ADJUSTMENT_AMT_S" value="<%= MM_ADJUSTMENT_AMT_S %>"></DIV></TD>
    </TR>
  <TR >
    <TH colspan="6" ><DIV align="left"><STRONG>Nodal Officer</STRONG> Remarks</DIV></TH>
    <TD colspan="6" ><INPUT type="text" name="NODAL_OFFICER_REMARK" id="NODAL_OFFICER_REMARK" value="<%= NODAL_OFFICER_REMARK %>"></TD>
  </TR>
  
  <TR>
    <TH colspan="12"> 
        <DIV align="center">
		 <INPUT name="Button" type="button" class="button" onClick="form_submit()" value="Save Record">

         
          <INPUT name="Button" type="button" class="button" value="Cancel" onClick="self.close();">          
        </DIV></TH>
  </TR>
</TABLE>





    <% if (ins.equals("I")){

NODAL_OFFICER_REMARK=(String) request.getParameter("NODAL_OFFICER_REMARK")==null?"":(String) request.getParameter("NODAL_OFFICER_REMARK").trim();
MM_ADJUSTMENT_AMT_S=(String) request.getParameter("MM_ADJUSTMENT_AMT_S")==null?"":(String) request.getParameter("MM_ADJUSTMENT_AMT_S").trim();
PHYSICAL_VERIFICATION_STATUS=(String) request.getParameter("PHYSICAL_VERIFICATION_STATUS")==null?"":(String) request.getParameter("PHYSICAL_VERIFICATION_STATUS").trim();
MM_ADJUSTMENT_STATUS=(String) request.getParameter("MM_ADJUSTMENT_STATUS")==null?"":(String) request.getParameter("MM_ADJUSTMENT_STATUS").trim();


 StringBuffer qryUpdate = new StringBuffer();
 
qryUpdate.append("UPDATE GEOTAG_TRANS SET  ");

qryUpdate.append("NODAL_OFFICER_REMARK=?,");
qryUpdate.append("MM_ADJUSTMENT_AMT_S=?,");
qryUpdate.append("PHYSICAL_VERIFICATION_STATUS=?,");
qryUpdate.append("MM_ADJUSTMENT_STATUS=?,LAST_UPDATE_DT=SYSDATE ");

qryUpdate.append("WHERE APP_ID=? AND PMEGPGEOTAGID=?");

//List values=new ArrayList();
List pstm=new ArrayList();



values.add(NODAL_OFFICER_REMARK); pstm.add ("L");
values.add(MM_ADJUSTMENT_AMT_S); pstm.add ("L");
values.add(PHYSICAL_VERIFICATION_STATUS); pstm.add ("L");
values.add(MM_ADJUSTMENT_STATUS); pstm.add ("L");
values.add(APP_ID); pstm.add ("L");
values.add(PMEGPGEOTAGID); pstm.add ("L");

db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate();
db.close();
values.clear();
pstm.clear();
response.sendRedirect("savepage.jsp");
}
//out.print(qryUpdate.toString());

 %>
    </p>
</FORM>
</BODY>
</HTML>
