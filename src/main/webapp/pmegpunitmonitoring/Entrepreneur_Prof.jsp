<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*,pkgPmegpNew.DBCon"%>
	<html>
<head>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css">
</head>
<%@ include file="MonitoringRep.jsp" %>

<%
String  APP_ID =  session.getAttribute("SAPP_ID")==null?"":(String) session.getAttribute("SAPP_ID");

String  APP_NAME = "";
String  PAN_NO="";
String  AADHAR_NO = "";
String  GENDER= "";
String  CATEGORY = "";
String  SOCIAL_CAT = "";
String  UNIT_LOC = "";
String  IND_TYPE = "";
String  ACTIVITY_NAME = "";
String  PROD_DESC = "";
String  UNIT_POST_ADDR = "";
String  UNIT_TALUK_BLOCK = "";
String  UNIT_PIN = "";
String  DISTRICT_NAME = "";
String  BANK_NAME = "";
String  AGENCY_TYPE = "";
String  OFF_ADDR1 = "";
String  OFF_ADDR2 = "";
String  CITY = "";
String  PINCODE = "";
String BENF_TYPE_DESC="";


StringBuffer qrysb= new StringBuffer();
qrysb.append("   SELECT AD.APP_NAME, "      );
qrysb.append("     AD.APP_ID,"      );
qrysb.append("     AD.GENDER,"      );
qrysb.append("     BCM.BENF_CATEGORY_DESC AS SOCIAL_CAT, "      );
qrysb.append("     BCM_S.BENF_CATEGORY_DESC AS CATEGORY,  "      );
qrysb.append("     AD.UNIT_LOC,"      );
qrysb.append("    CASE WHEN AD.IND_TYPE='M'  "      );
qrysb.append("    THEN 'MANUFACTURING'  "      );
qrysb.append("    WHEN AD.IND_TYPE='S'  "      );
qrysb.append("    THEN 'SERVICING'  "      );
qrysb.append("    WHEN AD.IND_TYPE='T'  "      );
qrysb.append("    THEN 'TRADING' END AS IND_TYPE, "      );
qrysb.append("     AM.ACTIVITY_NAME,  "      );
qrysb.append("     AD.PROD_DESC, "      );
qrysb.append("     AD.UNIT_POST_ADDR, "      );
qrysb.append("     AD.UNIT_TALUK_BLOCK, "      );
qrysb.append("     AD.UNIT_PIN, "      );
qrysb.append("     MD.DISTRICT_NAME,"      );
qrysb.append("     AD.BANK_NAME,MOM.OFF_ADDR2,"      );
qrysb.append("     AD.AADHAR_NO,"      );
qrysb.append("     AD.PAN_NO,MOM.OFF_ADDR1,"      );
qrysb.append("     BTM.BENF_TYPE_DESC,MOM.AGENCY_TYPE,MOM.CITY, MOM.PINCODE "      );
qrysb.append("    FROM APP_DETAIL AD,"      );
qrysb.append("     BANK_DATAENTRY BD,"      );
qrysb.append("     MAS_OFF_MAST MOM,"      );
qrysb.append("     APP_STATUS_MAST ASM,"      );
qrysb.append("     BENF_CATEGORY_MAST BCM,"      );
qrysb.append("     BENF_CATEGORY_MAST BCM_S,"      );
qrysb.append("     M_STATE MS,"      );
qrysb.append("     M_DISTRICT MD,"      );
qrysb.append("     ACTIVITY_MAST AM,"      );
qrysb.append("     BENF_TYPE_MAST BTM,"      );
qrysb.append("     IND_GRP_MAST IGM "      );
qrysb.append("   WHERE AD.APP_ID         = BD.APP_ID(+)"      );
qrysb.append("   AND AD.OFF_CD           = MOM.OFF_CD"      );
qrysb.append("   AND AD.ACT_ID           = ASM.ACT_ID"      );
qrysb.append("   AND AD.BENF_SPECAT_CD   = BCM.BENF_CATEGORY_CD"      );
qrysb.append("   AND AD.UNIT_DIST_CD     = MD.DISTRICT_CD"      );
qrysb.append("   AND MD.STATE_CD         = MS.STATE_CD"      );
qrysb.append("   AND AD.BENF_TYPE_CD     = BTM.BENF_TYPE_CD(+)"      );
qrysb.append("   AND AD.ACTIVITY_CD      = AM.ACTIVITY_CD"      );
qrysb.append("   AND IGM.IND_GRP_CD      = AM.IND_GRP_CD"      );
qrysb.append("   AND AD.BENF_CATAGORY_CD = BCM_S.BENF_CATEGORY_CD AND AD.APP_ID='"+APP_ID+"'  "      );
//out.print(qrysb.toString());
DBCon db= new DBCon();
db.connect();



ResultSet rsMain = db.execSQL(qrysb.toString());
 while (rsMain.next()) {
APP_ID =rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");
APP_NAME =rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
PAN_NO=rsMain.getString("PAN_NO")==null?"":rsMain.getString("PAN_NO");
 AADHAR_NO = rsMain.getString("AADHAR_NO")==null?"":rsMain.getString("AADHAR_NO");
 GENDER= rsMain.getString("GENDER")==null?"":rsMain.getString("GENDER");
  CATEGORY = rsMain.getString("CATEGORY")==null?"":rsMain.getString("CATEGORY");
  SOCIAL_CAT =rsMain.getString("SOCIAL_CAT")==null?"":rsMain.getString("SOCIAL_CAT");
  UNIT_LOC = rsMain.getString("UNIT_LOC")==null?"":rsMain.getString("UNIT_LOC");
  IND_TYPE = rsMain.getString("IND_TYPE")==null?"":rsMain.getString("IND_TYPE");
  ACTIVITY_NAME = rsMain.getString("ACTIVITY_NAME")==null?"":rsMain.getString("ACTIVITY_NAME");
  PROD_DESC = rsMain.getString("PROD_DESC")==null?"":rsMain.getString("PROD_DESC");
  UNIT_POST_ADDR = rsMain.getString("UNIT_POST_ADDR")==null?"":rsMain.getString("UNIT_POST_ADDR");
  UNIT_TALUK_BLOCK = rsMain.getString("UNIT_TALUK_BLOCK")==null?"":rsMain.getString("UNIT_TALUK_BLOCK");
  UNIT_PIN = rsMain.getString("UNIT_PIN")==null?"":rsMain.getString("UNIT_PIN");
  DISTRICT_NAME = rsMain.getString("DISTRICT_NAME")==null?"":rsMain.getString("DISTRICT_NAME");
  BANK_NAME = rsMain.getString("BANK_NAME")==null?"":rsMain.getString("BANK_NAME");
  AGENCY_TYPE = rsMain.getString("AGENCY_TYPE")==null?"":rsMain.getString("AGENCY_TYPE");
  OFF_ADDR1 = rsMain.getString("OFF_ADDR1")==null?"":rsMain.getString("OFF_ADDR1");
  OFF_ADDR2 = rsMain.getString("OFF_ADDR2")==null?"":rsMain.getString("OFF_ADDR2");
  CITY = rsMain.getString("CITY")==null?"":rsMain.getString("CITY");
  PINCODE = rsMain.getString("PINCODE")==null?"":rsMain.getString("PINCODE");
  BENF_TYPE_DESC = rsMain.getString("BENF_TYPE_DESC")==null?"":rsMain.getString("BENF_TYPE_DESC");
 }
%>

<table align="center">

<tr>
  <td>    <table class="CSSTableGenerator">
    <tr bgcolor="#D1A476">
      <td colspan="6"><div align="center" class="style1">
          <h3>Entrepreneur Profile</h3>
      </div></td>
    </tr>
    <tr>
      <th width="44">(1)</th>
      <th width="213"><strong>Name of Applicant:*</strong></th>
      <td colspan="4"><%=APP_NAME%></td>
    </tr>
    <tr>
      <th>(2)</th>
      <th nowrap><strong>Aadhaar Card No: </strong></th>
      <td width="162" colspan="2"><%=AADHAR_NO%></td>
      <td nowrap >Pan No: </td>
      <td><%=PAN_NO%></td>
    </tr>
    <tr>
      <th colspan="6"><div align="center">
      </div></th>
      </tr>
    <tr>
      <th>(3)</th>
      <th nowrap><strong> Sponsoring Agency*:</strong></th>
      <td colspan="4"><%=AGENCY_TYPE%></td>
    </tr>
    <tr>
      <td colspan="6"><div align="center"></div></td>
      </tr>
    <tr>
      <td colspan="6"><div align="center"><%=OFF_ADDR1%> <%=CITY%>  </div>          </td>
      </tr>
    <tr>
      <td colspan="6"><div align="center"><%=PINCODE%>    </div></td>
      </tr>
    <tr>
      <th colspan="6">&nbsp;    </th>
      </tr>
    <tr>
      <th>(4)</th>
      <th nowrap><strong>Legal Type*
           
      </strong></th>
      <td colspan="4"><%=BENF_TYPE_DESC%></th>    </tr>
    <tr>
      <th>(5)</th>
      <th nowrap><strong>Gender:*</strong></th>
      <td colspan="4"><%=GENDER%></td>
    </tr>
    <tr>
      <th colspan="6">&nbsp;</th>
      </tr>
    <tr>
      <th rowspan="2">(6)</th>
      <th nowrap><strong>Social Category : *</strong></th>
      <td colspan="4"><%=SOCIAL_CAT%></td>
    </tr>
    <tr>
      <th nowrap><strong>Special Category (if any): </strong></th>
      <td colspan="4"><%=CATEGORY%></td>
    </tr>
    <tr>
      <th>(7)</th>
      <th nowrap>Unit Location*:</th>
      <td colspan="4"><%=UNIT_LOC%></td>
    </tr>
    <tr>
      <th>(8)</th>
      <th  nowrap>Type of Activity*: </th>
      <td colspan="4" nowrap><%=IND_TYPE%>        </tr>
    <tr>
      <th>(9)</th>
      <th  nowrap>Activity Name*:</th>
      <td colspan="4" nowrap><%=ACTIVITY_NAME%></td>
        </tr>
    <tr>
      <th>(10)</th>
      <th nowrap>Product Description*:
       <td colspan="4" nowrap><%=PROD_DESC%>       </td>
      </tr>
    <tr>
      <th>(11)</th>
      <th colspan="5" nowrap><strong> Unit Address </strong><strong>: </strong></th>
      </tr>
    <tr>
      <td>&nbsp;</td>
      <td>Address*</td>
      <td colspan="4"><%=UNIT_POST_ADDR%></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>Taluk/Block*</td>
      <td colspan="4"><%=UNIT_TALUK_BLOCK%></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td> District*         </td>
      <td colspan="4"> <%=DISTRICT_NAME%></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>Pin*</td>
      <td colspan="4"><%=UNIT_PIN%></td>
    </tr>
    
    <tr>
      <td colspan="6"><div align="right">
         
      </div></td>
    </tr>
  </table>
</table>
   