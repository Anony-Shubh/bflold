  <%@page language="java" import="java.sql.*"%>
<%@page import="java.util.*" %>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.simple.parser.ParseException"%>
<%@ page import="pkgPmegpNew.DBCon"%>

		<%
		
DBCon db= new DBCon();
db.connect();
StringBuffer qrysb = new StringBuffer();
qrysb.append("   SELECT MOM.AGENCY_TYPE,"      );
qrysb.append("     MOM.OFF_NAME,"      );
qrysb.append("     AD.APP_ID,"      );
qrysb.append("     AD.APP_NAME,"      );
qrysb.append("     AD.AADHAR_NO,"      );
qrysb.append("     BBM.BR_IFSL_CODE,"      );
qrysb.append("     BD.APPLOAN_ACCNO,"      );
qrysb.append("     BBM.BR_NAME,"      );
qrysb.append("     BBM.BRANCH_NAME,"      );
qrysb.append("     TO_CHAR(BD.MM_CLAIM_DT,'DD-MON-RRRR') AS MM_CLAIM_DT,"      );
qrysb.append("     BD.MM_CLAIM_AMT,"      );
qrysb.append("     BD.FB_ACNO,BD.LOAN_DOCFNAME"      );
qrysb.append("   FROM BANK_DATAENTRY_SECOND BD,"      );
qrysb.append("     APP_DETAIL_SECOND AD,"      );
qrysb.append("     BANK_BR_MAST BBM,"      );
qrysb.append("     MAS_OFF_MAST MOM"      );
qrysb.append("   WHERE AD.APP_ID       = BD.APP_ID"      );
qrysb.append("   AND BD.IFSC_CODE      = BBM.BR_IFSL_CODE"      );
qrysb.append("   AND AD.OFF_CD         = MOM.OFF_CD"      );
qrysb.append("   AND BD.MM_CLAIM_AMT   > 0");
qrysb.append("   AND BD.LOAN_DOCFNAME IS NOT NULL AND (APPRV_YN='N'  OR APPRV_YN IS NULL )ORDER BY BD.MM_CLAIM_DT DESC ");

try{
JSONArray list = new JSONArray();
ResultSet rsMain = db.execSQL(qrysb.toString());

out.print ("{ \"data\":");
while(rsMain.next())
  { 
JSONObject obj=new JSONObject();
 obj.put("AGENCY", rsMain.getString("AGENCY_TYPE")); 
 obj.put("APP_ID", rsMain.getString("APP_ID"));
 obj.put("APPLICANT NAME", rsMain.getString("APP_NAME")); 
 obj.put("IFSC", rsMain.getString("BR_IFSL_CODE"));
 obj.put("MM CLAIM DATE", rsMain.getString("MM_CLAIM_DT")); 
 obj.put("MM CLAIM", rsMain.getString("MM_CLAIM_AMT"));
 obj.put("VIEW","<center><input name=btnDocument type=button class=buttonMerun id='btnDocument' onClick=viewAlldocument('"+rsMain.getString("APP_ID")+"') value=Forms></center>");
 //obj.put("VIEW", rsMain.getString("BR_IFSL_CODE"));
 obj.put("STATUS","<center><input type=button name=Button class='buttonOrange' value='Update' onClick=ShowMMClaim('"+rsMain.getString("APP_ID")+"') ></center>");
 //obj.put("STATUS", rsMain.getString("BR_IFSL_CODE"));
 obj.put("TRANSIENT A/C", rsMain.getString("FB_ACNO")); 
  list.add(obj);
  } out.print(list);
		
    out.print ("}");
}
    catch(Exception ex)
    {
        //out.println("<h1>"+ex+"</g1>");
    }

 
 %>
        