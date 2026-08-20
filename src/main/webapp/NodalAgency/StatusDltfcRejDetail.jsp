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



<html>
<head>
<title>PMEGP Agency Status Update Form</title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />

<script language="javascript">
function submit_form () {
 document.form.ins.value='I'; 
 document.form.submit()
}

</script>
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


DBCon db= new DBCon();
db.connect();
StringBuffer qrysb= new StringBuffer();
qrysb.append("   SELECT"      );
qrysb.append("   AD.APP_ID,"      );
qrysb.append("   AD.ACT_ID,A.MTG_ID,"      );
qrysb.append("   UPPER(AD.APP_NAME) AS APP_NAME,AD.REMARKS AS AGENCY_REMARKS,"      );
qrysb.append("   AM.ACTIVITY_NAME,AD.PROD_DESC, AD.DLTFC_REMARK, "      );
qrysb.append("   NVL(AD.MACHINARY_COST,0) AS PROP_CE,"      );
qrysb.append("   NVL(AD.WORKING_CAPITAL,0) AS PROP_WC,"      );
qrysb.append("   NVL(AD.MACHINARY_COST,0)+NVL(AD.WORKING_CAPITAL,0) AS PROP_PROJ_TOTAL,"      );
qrysb.append("   to_Char(AD.DLTFC_APPR_DT,'dd-mon-yyyy') as MT_DATE,"      );
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
qrysb.append("    NVL(AD.DLTFC_CE,0)+NVL(AD.DLTFC_WC,0) AS DLTFC_TOTAL "      );
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

}

rsApp.close();
%>
  <div>
  <table align="center">
    <tr>
      <th colspan="4"><div align="center">Details for Return of Application </div></th>
    </tr>
    <tr>
      <th><input name="ins" type="hidden" id="ins">
        Applicant Id :        </th>
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
      <td><div align="center">Rs. <%=  PROP_CE %></div></td>
      <td><div align="center">Rs.<%=  PROP_WC %></div></td>
      <td><div align="center">Rs.<%=  PROP_PROJ_TOTAL  %></div></td>
    </tr>
    <tr >
      <th>Forwarding Date to Approver Agency: </th>
      <th><%=  FORD_DT_DLTFC %></th>
      <th><div align="right">Return Date : </div></th>
      <th><%=  MT_DATE %></th>
    </tr>
    
    <tr >
      <th>Approver Agency  Remarks for Return of Application: </th>
      <th colspan="3"><%= DLTFC_REMARK %></th>
    </tr>
    
    
    <tr>
      <th colspan="4">&nbsp;</th>
    </tr>
    <tr>
      <th colspan="4"> <div align="center">
          <input name="Button2" type="button" class="button" tabindex="42" onClick="window.parent.HideModalWindow();" value="Cancel">
          
      </div></th>
    </tr>
  </table>
  <%

if ((String)request.getParameter("ins")!=null){


APP_ID=(String) request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID").trim();
ACT_ID=(String) request.getParameter("ACT_ID")==null?"2":(String) request.getParameter("ACT_ID").trim();
DLTFC_REMARK=(String) request.getParameter("DLTFC_REMARK")==null?"":(String) request.getParameter("DLTFC_REMARK").trim();
DLTFC_WC=(String) request.getParameter("DLTFC_WC")==null?"0":(String) request.getParameter("DLTFC_WC").trim();
DLTFC_CE=(String) request.getParameter("DLTFC_CE")==null?"0":(String) request.getParameter("DLTFC_CE").trim();




	List values=new ArrayList();
		List pstm=new ArrayList();
		StringBuffer qryUpdate = new StringBuffer();
String vTodayDt ="";



qryUpdate.append("  UPDATE APP_DETAIL SET ACT_ID=5,  BANK_F_DATE =SYSDATE  WHERE APP_ID=? ");
values.clear();
pstm.clear();
values.add(APP_ID); pstm.add ("L");
db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
//db.executeUpdate() ;
db.close();

}


%>

</form>
</body>
</html>
