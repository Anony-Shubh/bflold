<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>


<%List values=new ArrayList();

String TYPE=request.getParameter("TYPE")==null?"A":(String)request.getParameter("TYPE");

String STATE_CD=request.getParameter("STATE_CD")==null?"":(String)request.getParameter("STATE_CD");
String STATE_NM=request.getParameter("STATE_NM")==null?"":(String)request.getParameter("STATE_NM");

String GENDERT=request.getParameter("GENDERT")==null?"":request.getParameter("GENDERT");
String ACTCD=request.getParameter("ACTCD")==null?"":request.getParameter("ACTCD");
String AGENTYPE=request.getParameter("AGENTYPE")==null?"":request.getParameter("AGENTYPE");
String STATE_CD_D1=request.getParameter("STATE_CD_D1")==null?"":request.getParameter("STATE_CD_D1");
String ACTSAVE=request.getParameter("ACTSAVE")==null?"":request.getParameter("ACTSAVE");

String FROMDT=request.getParameter("FROMDT")==null?"01-APR-2020":request.getParameter("FROMDT");
String TODT=request.getParameter("TODT")==null?"01-APR-2021":request.getParameter("TODT");

String FROMDT1="";
String TODT1="";


String whrcls="";
String whrcls2="";	
String whrcls3="";

 StringBuffer sb= new StringBuffer();

sb.append("   SELECT "      );

sb.append("    MAX(MS.STATE_CD) AS STATE_CD, nvl(MS.STATE_NM,' TOTAL')STATE_NM,  "      );

sb.append("   SUM(CASE WHEN TRUNC(ONLINE_SUBDT) BETWEEN '"+FROMDT+"' AND ('"+TODT+"') THEN 1 END) AS NO_OF_APP,"      );
sb.append("   SUM(CASE WHEN AD.ACT_ID IN (3,7) AND TRUNC(ONLINE_SUBDT) BETWEEN '"+FROMDT+"' "      );
sb.append("   AND ('"+TODT+"') THEN 1 ELSE 0 END) RET_BY_AGENCY,"      );
sb.append("   SUM(CASE WHEN AD.ACT_ID =5 AND TRUNC(BANK_F_DATE) BETWEEN '"+FROMDT+"' "      );
sb.append("   AND ('"+TODT+"') THEN 1 ELSE 0 END) BANK_FORD,"      );

sb.append(" SUM(CASE WHEN AD.ACT_ID =5 AND TRUNC(BANK_F_DATE) BETWEEN '"+FROMDT+"' AND '"+TODT+"' AND TRUNC(ONLINE_SUBDT) NOT BETWEEN '"+FROMDT+"' AND '"+TODT+"'  "    );
sb.append("   THEN 1 ELSE 0 END) BANK_FORD_LASTYR,   "      );


sb.append("   SUM(CASE WHEN AD.ACT_ID  NOT IN (3,7,5) AND TRUNC(ONLINE_SUBDT) BETWEEN '"+FROMDT+"' "      );
sb.append("   AND ('"+TODT+"') THEN 1 ELSE 0 END) PENDING_AGENCY,"      );
sb.append("   SUM(CASE WHEN BD.ACT_ID=11 AND TRUNC(BD.LOAN_SANC_DT) BETWEEN '"+FROMDT+"' "      );
sb.append("   AND ('"+TODT+"') THEN 1 ELSE 0 END) LOAN_SANC,"      );
sb.append("   SUM(CASE WHEN BD.ACT_ID =11 AND TRUNC(BD.MM_CLAIM_DT) BETWEEN '"+FROMDT+"' "      );
sb.append("   AND ('"+TODT+"') THEN 1 ELSE 0 END) CLAIM_BY_BANK_NO,"      );
sb.append("   ROUND(SUM(CASE WHEN BD.ACT_ID =11 AND TRUNC(BD.MM_CLAIM_DT) BETWEEN '"+FROMDT+"' "      );
sb.append("   AND ('"+TODT+"') THEN BD.MM_CLAIM_AMT ELSE 0 END)/10000000,2) CLAIM_BY_BANK_MM,"      );
sb.append("   SUM(CASE WHEN BD.PACT_ID=34 AND TRUNC(BD.MM_REL_DT) BETWEEN '"+FROMDT+"' "      );
sb.append("   AND ('"+TODT+"') THEN 1 ELSE 0 END) MM_REL_NO,"      );
sb.append("   ROUND(SUM(CASE WHEN BD.PACT_ID=34 AND TRUNC(BD.MM_REL_DT) BETWEEN '"+FROMDT+"' "      );
sb.append("   AND ('"+TODT+"') THEN BD.MM_REL_AMT ELSE 0 END)/10000000,2) MM_REL_AMT,"      );
sb.append("   SUM(CASE WHEN AD.ACT_ID =5 AND "      );
sb.append("    NVL(BD.ACT_ID,0) IN (0,8) AND"      );
sb.append("   TRUNC(BANK_F_DATE)  BETWEEN '"+FROMDT+"' "      );
sb.append("   AND ('"+TODT+"') THEN 1 ELSE 0 END) FOR_DECISION,"      );
sb.append("   SUM(CASE WHEN AD.ACT_ID =5 AND "      );
sb.append("    BD.ACT_ID=3 AND"      );
sb.append("   TRUNC(BANK_F_DATE)  BETWEEN '"+FROMDT+"' "      );
sb.append("   AND ('"+TODT+"') THEN 1 ELSE 0 END) BANK_REJ, "      );

sb.append("   SUM(CASE WHEN BD.IST_LOAN_DT BETWEEN '"+FROMDT+"' AND '"+TODT+"' THEN ROUND(BD.IST_LOAN_AMT/10000000,2) ELSE 0 END) LOANDIS_MM"      );


sb.append("   FROM APP_DETAIL AD , BANK_DATAENTRY BD, M_DISTRICT MD, M_STATE MS, MAS_OFF_MAST MOM"      );
sb.append("   WHERE AD.APP_ID=BD.APP_ID(+)"      );
sb.append("   AND AD.OFF_CD=MOM.OFF_CD"      );
sb.append("   AND AD.APP_DIST_CD=MD.DISTRICT_CD"      );
sb.append("   AND MD.STATE_CD=MS.STATE_CD"      );

sb.append("   GROUP BY ROLLUP(MS.STATE_NM)  ORDER BY MS.STATE_NM DESC "      );


DBCon db= new DBCon();
db.connect();

//values.add(SOFF_CD);
//out.print(sb.toString());
ResultSet rs = db.execSQL(sb.toString());
//ResultSet rs = db.executeSQL(sb.toString(),values);


String NO_OF_APP="";
String RET_BY_AGENCY="";
String BANK_FORD="";
String PENDING_AGENCY="";
String LOAN_SANC="";
String CLAIM_BY_BANK_NO="";
String CLAIM_BY_BANK_MM="";
String MM_REL_NO="";
String MM_REL_AMT="";
String FOR_DECISION="";
String BANK_REJ="";

String DISTRICT_CD="";
String DISTRICT_NAME="";

String LOANDIS_MM="";

String BANK_FORD_LASTYR="";

String comm=",";
String blank="";


%>

{

  "data": [
  
  
   
	
<%	

int count=0;
while (rs.next()) {

count=count+1;
NO_OF_APP=rs.getString("NO_OF_APP")==null?"":rs.getString("NO_OF_APP");
RET_BY_AGENCY=rs.getString("RET_BY_AGENCY")==null?"":rs.getString("RET_BY_AGENCY");
PENDING_AGENCY=rs.getString("PENDING_AGENCY")==null?"":rs.getString("PENDING_AGENCY");
BANK_FORD=rs.getString("BANK_FORD")==null?"":rs.getString("BANK_FORD");
LOAN_SANC=rs.getString("LOAN_SANC")==null?"":rs.getString("LOAN_SANC");
CLAIM_BY_BANK_NO=rs.getString("CLAIM_BY_BANK_NO")==null?"":rs.getString("CLAIM_BY_BANK_NO");
CLAIM_BY_BANK_MM=rs.getString("CLAIM_BY_BANK_MM")==null?"":rs.getString("CLAIM_BY_BANK_MM");
MM_REL_NO=rs.getString("MM_REL_NO")==null?"":rs.getString("MM_REL_NO");
MM_REL_AMT=rs.getString("MM_REL_AMT")==null?"":rs.getString("MM_REL_AMT");
FOR_DECISION=rs.getString("FOR_DECISION")==null?"":rs.getString("FOR_DECISION");
BANK_REJ=rs.getString("BANK_REJ")==null?"":rs.getString("BANK_REJ");

LOANDIS_MM=rs.getString("LOANDIS_MM")==null?"":rs.getString("LOANDIS_MM");

BANK_FORD_LASTYR=rs.getString("BANK_FORD_LASTYR")==null?"":rs.getString("BANK_FORD_LASTYR");

STATE_CD=rs.getString("STATE_CD")==null?"":rs.getString("STATE_CD");
STATE_NM=rs.getString("STATE_NM")==null?"":rs.getString("STATE_NM");
%>

 {

      "COUNTRY": "<%= STATE_NM %>", 
      "NO_OF_APP": "<%= NO_OF_APP %>",
      "RET_BY_AGENCY": "<%= RET_BY_AGENCY %>",
      "PENDING_AGENCY": "<%= PENDING_AGENCY %>",
      "BANK_FORD": "<%= BANK_FORD %>",
      "LOAN_SANC": "<%= LOAN_SANC %>",
      "CLAIM_BY_BANK_NO": "<%= CLAIM_BY_BANK_NO %>",
	  "CLAIM_BY_BANK_MM": "<%= CLAIM_BY_BANK_MM %>",
	  "MM_REL_NO": "<%= MM_REL_NO %>",
	  "MM_REL_AMT": "<%= MM_REL_AMT %>",
	  "FOR_DECISION": "<%= FOR_DECISION %>",
	  "BANK_REJ": "<%= BANK_REJ %>",
	  "LOANDIS_MM": "<%= LOANDIS_MM %>",
	  "BANK_FORD_LASTYR": "<%= BANK_FORD_LASTYR %>",
	  "STATE_CD": "<%= STATE_CD %>"
    
	}	
	
	<%if(STATE_CD.equals("AN")){%>
	
	
	<%}else{%>
	,
	<%}%>
	
	

	
<%
}
rs.close();
%>	



	  ]
}	


  <%


db.close();
%>	