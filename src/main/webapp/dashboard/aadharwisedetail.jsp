<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*,pkgPmegpNew.DBCon"%>
<%@ page import="java.text.*,java.util.Date,java.text.SimpleDateFormat"%>
<%@ page import="kvic.inputvalid.*"%>
<head>
<link rel="stylesheet" type="text/css" href="../css/lov.css"/>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="../js/jquery.freezeheader.js"></script>
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/datetimepicker.js"></script>




<style type="text/css">
<!--
.style1 {
	color: #804000;
	font-size: 16px;
}
.style2 {color: #0000A0}
-->
</style>
</head>

<body>
<img src="../images/pmegponlineN.jpg"  height="20%" width="100%">
<form method="post" name="form1" id="form1">
<%

jspinputvalid js = new jspinputvalid();
String ins=request.getParameter("ins")==null?"":(String) js.getOnlyTextspc(request.getParameter("ins"),1);


//String ins= request.getParameter("ins")==null?"":(String) request.getParameter("ins"); 
String Wcls=""; 
Date now = new Date();
DateFormat df = new SimpleDateFormat("dd-MMM-yyyy ");
String curdt = df.format(now);   
StringBuffer qrysb= new StringBuffer();

//String SEL_YEAR=(String) request.getParameter("SEL_YEAR")==null?"":request.getParameter("SEL_YEAR");
String FromDt=request.getParameter("RFROMDT")==null?"1-APR-2016":(String) js.getOnlyTextspc(request.getParameter("RFROMDT"),12);
String ToDt=request.getParameter("RTODATE")==null?"1-APR-2016":(String) js.getOnlyTextspc(request.getParameter("RTODATE"),12);


//String FromDt=(String) request.getParameter("RFROMDT")==null?"1-APR-2016":request.getParameter("RFROMDT");
//String ToDt=(String) request.getParameter("RTODATE")==null?"":request.getParameter("RTODATE");	

if (ToDt.equals("")){
	ToDt=curdt;
}
else{
	ToDt=ToDt;
}
 if (FromDt.equals(""))
 {
	 FromDt="1-APR-2016";
	  }
else {
	FromDt=FromDt;
}

qrysb.append("   SELECT ZONE_NM,OFF_NAME1,"      );
qrysb.append("     APP_REC,"      );
qrysb.append("     AADH_RECV,  APP_REC -AADH_RECV AS APPREC_WOADH,"      );
qrysb.append("     AADH_DISB_NO,"      );
qrysb.append("     AADH_DISB_MM,"      );
qrysb.append("     NVL(TOTAL_DISB_NO,0)- NVL(AADH_DISB_NO,0) AS PAN_DISB_NO,"      );
qrysb.append("     NVL(TOTAL_DISB_MM,0)-NVL(AADH_DISB_MM,0)  AS PAN_DISB_MM,"      );
qrysb.append("      TOTAL_DISB_NO,"      );
qrysb.append("     TOTAL_DISB_MM"      );
qrysb.append("   FROM"      );
qrysb.append("     (SELECT MZ.ZONE_NM,MS.STATE_NM AS OFF_NAME1,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN TRUNC(AD.ONLINE_SUBDT) BETWEEN '"+FromDt+"' AND  '"+ToDt+"'"      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AS APP_REC,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN LENGTH(AD.AADHAR_NO) = 12"      );
qrysb.append("         AND TRUNC(AD.ONLINE_SUBDT) BETWEEN '"+FromDt+"' AND  '"+ToDt+"'"      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AADH_RECV,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN LENGTH(AD.AADHAR_NO) = 12"      );
qrysb.append("         AND BD.PACT_ID            = 34"      );
qrysb.append("         AND BD.MM_REL_DT         IS NOT NULL"      );
qrysb.append("         AND TRUNC(BD.MM_REL_DT) BETWEEN '"+FromDt+"' AND  '"+ToDt+"'"      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AADH_DISB_NO,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN LENGTH(AD.AADHAR_NO) = 12"      );
qrysb.append("         AND BD.PACT_ID            = 34"      );
qrysb.append("         AND BD.MM_REL_DT         IS NOT NULL"      );
qrysb.append("         AND TRUNC(BD.MM_REL_DT) BETWEEN '"+FromDt+"' AND  '"+ToDt+"'"      );
qrysb.append("         THEN ROUND(NVL(BD.MM_REL_AMT, 0) / 100000, 2)"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) AADH_DISB_MM,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN BD.PACT_ID   = 34"      );
qrysb.append("         AND BD.MM_REL_DT IS NOT NULL"      );
qrysb.append("         AND TRUNC(BD.MM_REL_DT) BETWEEN '"+FromDt+"' AND  '"+ToDt+"'"      );
qrysb.append("         THEN 1"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) TOTAL_DISB_NO,"      );
qrysb.append("       SUM("      );
qrysb.append("       CASE"      );
qrysb.append("         WHEN BD.PACT_ID   = 34"      );
qrysb.append("         AND BD.MM_REL_DT IS NOT NULL"      );
qrysb.append("         AND TRUNC(BD.MM_REL_DT) BETWEEN '"+FromDt+"' AND  '"+ToDt+"'"      );
qrysb.append("         THEN ROUND(NVL(BD.MM_REL_AMT, 0) / 100000, 2)"      );
qrysb.append("         ELSE 0"      );
qrysb.append("       END) TOTAL_DISB_MM"      );
qrysb.append("     FROM APP_DETAIL AD,"      );
qrysb.append("       BANK_DATAENTRY BD,"      );
qrysb.append("       MAS_OFF_MAST MOM,"      );
qrysb.append("       M_DISTRICT MD,"      );
qrysb.append("       M_STATE MS,"      );
qrysb.append("       ZONE_MAST MZ"      );
qrysb.append("     WHERE AD.APP_ID = BD.APP_ID(+)  "      );
qrysb.append("     AND AD.OFF_CD   = MOM.OFF_CD"      );
qrysb.append("     AND AD.UNIT_DIST_CD=MD.DISTRICT_CD"      );
qrysb.append("     AND MD.STATE_CD=MS.STATE_CD"      );
qrysb.append("     AND MS.ZONE_CD=MZ.ZONE_CD"      );
qrysb.append("    GROUP BY ROLLUP(MZ.ZONE_NM,MS.STATE_NM)  )"      );

//out.print (qrysb.toString());

String  ZONE_NM = ""; 
String  OFF_NAME = "";
String  TOT_APP = "";
String  TOT_AADHAR="";
String  TOTAL_DISB_NO = "";
String  AADHAR_DISB= "";
String  AADHAR_DISB_MM = "";
String  TOTAL_DISB_MM = "";
String  PAN_DISB = "";
String  PAN_DISB_MM = "";
String APPREC_WOADH="";
//String  ZONE_NM="";


DBCon db= new DBCon();
db.connect();

ResultSet rsMain = db.execSQL(qrysb.toString());
 

	

%>
<center>
  <h1> PMEGP e-portal Margin Money Disbursement with Aadhar/Pan Details<a href="../pmegphome/index.jsp" class="button" >
 <img src="../images/back_image.jpg" height="5%"></a>(MM in Lakhs) </h1>
 
		  <input name="ins" type="hidden" id="ins" value="<%= ins %>   ">

 
<table width="1008" align="center">
  <tr>
    
    <td><div align="right">From Date: </div></td>
    <td ><input name="RFROMDT" type="text"  id="RFROMDT" value="<%=FromDt%>" onClick="javascript:NewCal('RFROMDT','ddmmmyyyy')" size="11" maxlength="11">
    </td>
    <td ><div align="right">To </div></td>
    <td  colspan="4"><input name="RTODATE" type="text" value="<%=ToDt%>"  id="RTODATE" onClick="javascript:NewCal('RTODATE','ddmmmyyyy')" size="11" maxlength="11"></td>
  <td><input name="msreport"  id="msreport" onClick="abc();" class="button" type="submit"  value="submit"></td>
  </tr>
</table>
</center>

 <table id="tableid" align="center" class="bordered">
 <thead>
  <tr>
    <th rowspan="2"><div align="center">Sr.No</div></th>  
<th rowspan="2"><div align="center">Zone Name </div></th>	
    <th rowspan="2"><div align="center">Office Name </div></th>
	<th rowspan="2"><div align="center">Total Applications Recieved</div>	  </th>	
	 <th rowspan="2"><div align="center">Applications Recieved With Aadhar</div></th>
	 <th rowspan="2"><div align="center">Applications Recieved With PAN </div></th>    
	<th colspan="2"><div align="center">Total Disbursement </div>
	  <div align="center"></div></th>
     <th colspan="2"><div align="center"> Disbursement with aadhar </div></th>
	  <th colspan="2"><div align="center"></div>
	  <div align="center">Disbursement with Pan </div></th>
    </tr>
  <tr>
    <th><div align="center">No of Prj. </div></th>
    <th><div align="center">MM Amt </div></th>
    <th><div align="center">No of Prj. </div></th>
    <th><div align="center">MM Amt </div></th>
	<th><div align="center">No of Prj. </div></th>
	<th><div align="center">MM Amt </div></th>
	</tr>
   </thead>
  <% 
String bgcolor="";

int srno =0;
 while (rsMain.next()) { 
TOT_APP=rsMain.getString("APP_REC")==null?"":rsMain.getString("APP_REC");
OFF_NAME=rsMain.getString("OFF_NAME1")==null?"Grand Total":rsMain.getString("OFF_NAME1");
TOT_AADHAR=rsMain.getString("AADH_RECV")==null?"":rsMain.getString("AADH_RECV");
//AADHAR_SANC=rsMain.getString("AADH_SANC")==null?"":rsMain.getString("AADH_SANC");
AADHAR_DISB=rsMain.getString("AADH_DISB_NO")==null?"":rsMain.getString("AADH_DISB_NO");
AADHAR_DISB_MM=rsMain.getString("AADH_DISB_MM")==null?"":rsMain.getString("AADH_DISB_MM");
//PAN_SANC=rsMain.getString("PAN_SANC")==null?"":rsMain.getString("PAN_SANC");
PAN_DISB=rsMain.getString("PAN_DISB_NO")==null?"":rsMain.getString("PAN_DISB_NO");
PAN_DISB_MM=rsMain.getString("PAN_DISB_MM")==null?"":rsMain.getString("PAN_DISB_MM");
TOTAL_DISB_NO=rsMain.getString("TOTAL_DISB_NO")==null?"":rsMain.getString("TOTAL_DISB_NO");
TOTAL_DISB_MM=rsMain.getString("TOTAL_DISB_MM")==null?"":rsMain.getString("TOTAL_DISB_MM");
ZONE_NM=rsMain.getString("ZONE_NM")==null?"":rsMain.getString("ZONE_NM");
APPREC_WOADH=rsMain.getString("APPREC_WOADH")==null?"":rsMain.getString("APPREC_WOADH");
srno =srno+1;
if ( OFF_NAME=="Grand Total"){bgcolor="#FFFF66";
}else{
bgcolor="";
}


%>

<tbody>

  <tr>
    <td><%=srno %></td>
	<td   bgcolor="<%=  bgcolor %>" nowrap><%=ZONE_NM %></td>	
	<td  bgcolor="<%=  bgcolor %>"nowrap><%=OFF_NAME %></td>	
    <td   bgcolor="<%=  bgcolor %>" ><%=TOT_APP %></td>
	<td   bgcolor="<%=  bgcolor %>"><%=TOT_AADHAR%></td>
	<td   bgcolor="<%=  bgcolor %>"><%=APPREC_WOADH %></td>
    <td   bgcolor="<%=  bgcolor %>"><%=TOTAL_DISB_NO%></td>
    <td   bgcolor="<%=  bgcolor %>"><%=TOTAL_DISB_MM%></td>
    <td   bgcolor="<%=  bgcolor %>"><%=AADHAR_DISB %></td>	
    <td   bgcolor="<%=  bgcolor %>"><%=AADHAR_DISB_MM%></td>    
    <td   bgcolor="<%=  bgcolor %>"><%=PAN_DISB%></td>
    <td   bgcolor="<%=  bgcolor %>"><%=PAN_DISB_MM %></td>
    </tr>
  </tbody>
   
<%  }
  rsMain.close();
  db.close();
 %>
</table>
</form>
</body>
</html>
