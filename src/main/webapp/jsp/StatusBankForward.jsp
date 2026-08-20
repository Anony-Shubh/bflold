<%@ page session="true"  import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="in.gov.mgov.mobileseva.SendSMS"%>
<%@ page import="in.gov.mgov.SMSServices"%>
<%
response.setContentType("text/html");
response.setHeader("Cache-control","no-cache");
response.setHeader("Cache-control","private");
%>



<HTML>
<HEAD>
<TITLE>PMEGP Agency Status Update Form</TITLE>
<LINK rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />

<SCRIPT language="javascript">
function submit_form () {
 document.form.ins.value='I'; 
 document.form.submit()
}

</SCRIPT>
<STYLE type="text/css">
<!--
.style1 {color: #FF0000}
-->
</STYLE>
</HEAD>
<BODY>
<FORM   name="form" id ="form" method="post" >
<%
//String  APP_ID =request.getParameter("APP_ID")==null?"":(String)request.getParameter("APP_ID");
String  APP_ID =(String) session.getAttribute("sAPP_ID");
String OFF_CD = (String) session.getAttribute("off_cd");
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

String DLTFC_CE = "";
String DLTFC_WC = "";
String BANK_DISTRICT = "";
String BRANCH_NAME = "";
String BANK_F_DATE = "";
String BANK_NAME = "";
String BANK_POST_ADDR = "";
String IFSC_CODE = "";
String EMAIL = "";
String DLTFC_TOTAL="";
String MOB_NO1="";

int TOTAL_SCORE=0;


DBCon db= new DBCon();
db.connect();
StringBuffer qrysb= new StringBuffer();
qrysb.append("   SELECT"      );
qrysb.append("   AD.APP_ID,AD.MOB_NO1, "      );
qrysb.append("   AD.ACT_ID,A.MTG_ID,"      );
qrysb.append("   UPPER(AD.APP_NAME) AS APP_NAME,AD.REMARKS AS AGENCY_REMARKS,"      );
qrysb.append("   AM.ACTIVITY_NAME,AD.PROD_DESC, AD.DLTFC_REMARK, "      );
qrysb.append("   NVL(AD.MACHINARY_COST,0) AS PROP_CE,"      );
qrysb.append("   NVL(AD.WORKING_CAPITAL,0) AS PROP_WC,"      );
qrysb.append("   NVL(AD.MACHINARY_COST,0)+NVL(AD.WORKING_CAPITAL,0) AS PROP_PROJ_TOTAL,"      );
qrysb.append("   to_Char(A.MT_DATE,'dd-mon-yyyy') as MT_DATE,"      );
qrysb.append("   to_Char(AD.ONLINE_SUBDT,'dd-mon-yyyy') as ONLINE_SUBDT,"      );
qrysb.append("   to_Char(AD.FORD_DT_DLTFC,'dd-mon-yyyy') as FORD_DT_DLTFC,"      );
qrysb.append("   B.DISTRICT_NAME AS UNIT_DIST,"      );
qrysb.append("   A.MTG_PLACE,"      );
qrysb.append("  AD.BANK_DISTRICT, " );
 qrysb.append("   AD.BRANCH_NAME, " );
 qrysb.append("   AD.BANK_F_DATE, " );
  qrysb.append("  AD.BANK_NAME, " );
 qrysb.append("   AD.BANK_POST_ADDR, " );
 qrysb.append("   AD.IFSC_CODE, EMAIL," );
qrysb.append("   B.DISTRICT_NAME AS MTG_DIST,"      );
qrysb.append("   ASM.ACT_DESC , NVL(AD.DLTFC_CE,0) AS DLTFC_CE,NVL(AD.DLTFC_WC,0) AS DLTFC_WC, "      );



qrysb.append("    NVL(AD.DLTFC_CE,0)+NVL(AD.DLTFC_WC,0) AS DLTFC_TOTAL, "      );
qrysb.append("   NVL( (SELECT TOTAL_SCORE FROM PMEGP_SCORE_CARD PSC WHERE PSC.APP_ID=AD.APP_ID),0) AS TOTAL_SCORE,FUNC_SCORECARDVALIDATION(AD.APP_ID) AS SCVALID  "      );
qrysb.append("   FROM  RBIBANKLIST RBL, APP_MEETING_MAST A,M_DISTRICT B,APP_DETAIL AD, "      );
qrysb.append("   APP_STATUS_MAST ASM, M_DISTRICT UMD,ACTIVITY_MAST AM"      );
qrysb.append("   WHERE A.DISTRICT_CD=B.DISTRICT_CD AND AD.OFF_CD=?"      );
qrysb.append("   AND AD.ACTIVITY_CD=AM.ACTIVITY_CD AND AD.APP_ID=? AND  AD.IFSC_CODE = RBL.IFSC_CODE"  );
qrysb.append("   AND A.MTG_ID=AD.MTG_ID "      );
qrysb.append("   AND AD.ACT_ID=ASM.ACT_ID"      );
qrysb.append("   AND AD.UNIT_DIST_CD=UMD.DISTRICT_CD"      );
qrysb.append("   ORDER BY A.MT_DATE DESC"      );
List valuesq = new ArrayList();
valuesq.add(OFF_CD);
valuesq.add(APP_ID);

   ResultSet rsApp = db.executeSQL(qrysb.toString(),valuesq);
   valuesq.clear();

String SCVALID="";
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

BANK_DISTRICT=rsApp.getString("BANK_DISTRICT")==null?"":rsApp.getString("BANK_DISTRICT");
BRANCH_NAME=rsApp.getString("BRANCH_NAME")==null?"":rsApp.getString("BRANCH_NAME");
BANK_F_DATE=rsApp.getString("BANK_F_DATE")==null?"":rsApp.getString("BANK_F_DATE");
BANK_NAME=rsApp.getString("BANK_NAME")==null?"":rsApp.getString("BANK_NAME");
BANK_POST_ADDR=rsApp.getString("BANK_POST_ADDR")==null?"":rsApp.getString("BANK_POST_ADDR");
IFSC_CODE=rsApp.getString("IFSC_CODE")==null?"":rsApp.getString("IFSC_CODE");
EMAIL=rsApp.getString("EMAIL")==null?"":rsApp.getString("EMAIL");
DLTFC_TOTAL=rsApp.getString("DLTFC_TOTAL")==null?"":rsApp.getString("DLTFC_TOTAL");
MOB_NO1=rsApp.getString("MOB_NO1")==null?"":rsApp.getString("MOB_NO1");

SCVALID=rsApp.getString("SCVALID")==null?"":rsApp.getString("SCVALID");
//TOTAL_SCORE=rsApp.getString("TOTAL_SCORE")==null?"":rsApp.getString("TOTAL_SCORE");
TOTAL_SCORE=rsApp.getInt("TOTAL_SCORE");
}

rsApp.close();


%>
  <div>
  <TABLE align="center">
    <TR>
      <TH colspan="4"><DIV align="center">Foward to Bank Status Updation </DIV></TH>
    </TR>
    <TR>
      <TH colspan="4">(SC/ST/NER Applicantion can be forwarded to Bank) </TH>
    </TR>
    <TR>
      <TH><INPUT name="ins" type="hidden" id="ins">
        Applicant Id :        </TH>
      <TH><%=APP_ID %> </TH>
      <TH><DIV align="right">Name Of Applicant :</DIV></TH>
      <TH><%=  APP_NAME %></TH>
    </TR>
    <TR >
      <TH>Industry/Activity:</TH>
      <TH colspan="3"><%=ACTIVITY_NAME %> (<%=PROD_DESC %>) </TH>
    </TR>
    <TR >
      <TH rowspan="2">Proposed Project Cost by Applicant: </TH>
      <TH><DIV align="center">Capital Expenditure (CE) </DIV></TH>
      <TH><DIV align="center">Working Capital (WC) </DIV></TH>
      <TH><DIV align="center">Total (CE+WC)</DIV></TH>
    </TR>
    <TR >
      <TD><DIV align="center">Rs. <%=  PROP_CE %></DIV></TD>
      <TD><DIV align="center">Rs.<%=  PROP_WC %></DIV></TD>
      <TD><DIV align="center">Rs.<%=  PROP_PROJ_TOTAL  %></DIV></TD>
    </TR>
    <TR >
      <TH>Forwarding Date to DLTFC: </TH>
      <TH><%=  FORD_DT_DLTFC %></TH>
      <TH><DIV align="right">Meeting Date : </DIV></TH>
      <TH><%=  MT_DATE %></TH>
    </TR>
    <TR >
      <TH>Meeting Place and District: </TH>
      <TH colspan="3"><%=  MTG_PLACE %>, Dist:<%=  MTG_DIST %></TH>
    </TR>
    
    <TR >
      <TH colspan="4"><DIV align="center" class="redLebel"></DIV></TH>
    </TR>
    
    
    <TR >
      <TH rowspan="2" >Approved Project Cost by DLTFC:      </TH>
      <TH >Capital Expenditure (CE) </TH>
      <TH >Working Capital (WC) </TH>
      <TH >Total (CE+WC) </TH>
    </TR>
    <TR >
      <TD ><DIV align="center">
        Rs.
        <%= DLTFC_CE %>
      </DIV></TD>
      <TD ><DIV align="center">
        Rs.
        <%= DLTFC_WC %>
      </DIV></TD>
      <TD ><DIV align="center">
        Rs.
       <%= DLTFC_TOTAL %>
      </DIV></TD>
    </TR>
   <INPUT name="APPID" type="hidden" value="<%=APP_ID%>" id="APPID"/>
   <INPUT name="APP_NM" type="hidden" value="<%=APP_NAME%>" id="APP_NM"/>
   <INPUT name="IFSC" type="hidden" value="<%=IFSC_CODE%>" id="IFSC"/>
   <INPUT name="MOBNO" type="hidden" value="<%=MOB_NO1%>" id="MOBNO"/> 
    
    <TR>
      <TH>Forwarding Date to Bank: </TH>
      <TH colspan="3">
	  <%
	  if (BANK_F_DATE.equals("")) {
	  %>
	  
	  
	  <%
	  if (MTG_ID.equals("-1")) {
	  %>
	  <% if (SCVALID.equals("Y")) {  %>
	 
	
	   <INPUT name="Button" type="button"  class="button"  onClick="submit_form();" value="Forward to Bank">
	   <%}else{%>
	   
	   <SPAN class="style1"> Cannot Forward to Bank as Total Score Card marks is less then the eligible marks</SPAN>
	   <%}%>
	   
	    <%}else{%>
		 <INPUT name="Button" type="button" class="button"  onClick="submit_form();" value="Forward to Bank">
		<%}%>
	   
	  <%
	  }else{
	  out.print (BANK_F_DATE);
	  }
	 
	  %>	  </TH>
    </TR>
    <TR>
      <TH>IFS Code: </TH>
      <TD colspan="3"><%= IFSC_CODE %></TD>
    </TR>
    <TR>
      <TH>Bank Name: </TH>
      <TD colspan="3"><%= BANK_NAME %></TD>
    </TR>
    <TR>
      <TH>Branch Name </TH>
      <TD colspan="3"><%= BRANCH_NAME %></TD>
    </TR>
    <TR>
      <TH>Bank Address: </TH>
      <TD colspan="3"><%= BANK_POST_ADDR %></TD>
    </TR>
    <TR>
      <TH>District:</TH>
      <TD colspan="3"><%= BANK_DISTRICT %></TD>
    </TR>

    <TR>
      <TH>Bank eMail Id: </TH>
      <TD colspan="3"><%= EMAIL %></TD>
    </TR>
	
	<%if(MTG_ID.equals("-1")){%>
	
        <TR>
      <TH>Total Score Card Marks</TH>
      <TD colspan="3"><%= TOTAL_SCORE %></TD>
    </TR>
	<%}%>
	
    <TR>
      <TH colspan="4"><DIV align="center"><SPAN class="redLebel">(Note: On Change of Status, Automatically message will be sent to applicant and Financing Branch through SMS/eMail) </SPAN></DIV></TH>
    </TR>
    <TR>
      <TH colspan="4"> <DIV align="center">
          <INPUT name="Button2" type="button" class="button" tabindex="42" onClick="" value="Cancel">
          
      </DIV></TH>
    </TR>
  </TABLE>
  <%

if ((String)request.getParameter("ins")!=null){

APP_NAME=(String) request.getParameter("APP_NM")==null?"":(String) request.getParameter("APP_NM").trim();
APP_ID=(String) request.getParameter("APPID")==null?"":(String) request.getParameter("APPID").trim();
ACT_ID=(String) request.getParameter("ACT_ID")==null?"2":(String) request.getParameter("ACT_ID").trim();
DLTFC_REMARK=(String) request.getParameter("DLTFC_REMARK")==null?"":(String) request.getParameter("DLTFC_REMARK").trim();
DLTFC_WC=(String) request.getParameter("DLTFC_WC")==null?"0":(String) request.getParameter("DLTFC_WC").trim();
DLTFC_CE=(String) request.getParameter("DLTFC_CE")==null?"0":(String) request.getParameter("DLTFC_CE").trim();
IFSC_CODE=(String) request.getParameter("IFSC")==null?"0":(String) request.getParameter("IFSC").trim();
MOB_NO1=(String) request.getParameter("MOBNO")==null?"0":(String) request.getParameter("MOBNO").trim();
//out.print(MOB_NO1);
	List values=new ArrayList();
		List pstm=new ArrayList();
		StringBuffer qryUpdate = new StringBuffer();
String vTodayDt ="";



qryUpdate.append("  UPDATE APP_DETAIL SET ACT_ID=5,  BANK_F_DATE =SYSDATE  WHERE APP_ID=? AND ACT_ID=4   ");
values.clear();
pstm.clear();
values.add(APP_ID); pstm.add ("L");
db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate() ;
if(MOB_NO1.length() == 10){

//String sms_string="Dear "+APP_NAME+"  your PMEGP application "+APP_ID +" has been forwarded online to Your Financing Branch ("+IFSC_CODE+").Contact Bank Your Financing Bank -KVIC" ;

String sms_string="Dear "+APP_NAME+" your PMEGP application "+APP_ID +" has been forwarded online to Your Financing Branch ( "+IFSC_CODE+" ). Contact Your Financing Bank. - KVIC" ;
	 SMSServices sms1=new SMSServices();	 
	try {
    String smsresponse=sms1.sendSingleSMS("KVICDIT", "Panda@1974",sms_string, "KVICIT",MOB_NO1,"2740939a-a79d-42ba-984c-02fb4fa0e10d","1007712276697694958");	
}catch (Exception e) {}

}

db.close();
response.sendRedirect("savemsg.jsp");

}


%>

</FORM>
</BODY>
</HTML>
