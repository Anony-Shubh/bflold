<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*,pkgPmegpNew.DBCon"%>
<%@ page import="java.text.*,java.util.Date,java.text.SimpleDateFormat"%><head>
<link rel="stylesheet" type="text/css" href="../css/lov.css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="../js/jquery.freezeheader.js"></script>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">\
	 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script>
$(document).ready(function () {
            $("#tableid").freezeHeader();
        })
</script>

<style type="text/css">
<!--
.style2 {color: #FF8000}
-->
</style>
</head>

<body>
<form name="form" id="form" class="form" method="post">

<img src="../images/pmegponlineN.jpg"  height="20%" width="100%">
<%

String vfromdt=request.getParameter("FROMDT")==null?"":(String)request.getParameter("FROMDT");
String vtodt=request.getParameter("TODT")==null?"":(String)request.getParameter("TODT");

String OFF_NAME=request.getParameter("OFF_NAME")== null?"":(String) request.getParameter("OFF_NAME");
String Districtcd=request.getParameter("district")== null?"":(String) request.getParameter("district");
//out.print(OFF_NAME);
String Wcls="";
if(!OFF_NAME.equals("TOTAL")){
Wcls=Wcls+" AND MS.STATE_NM ='"+OFF_NAME+"' ";
}
else {
	//Wcls=Wcls+" AND MOM.OFF_NAME1 LIKE '%%' ";
}

if ( !Districtcd.equals("")) {
Wcls=" AND MD.DISTRICT_CD="+Districtcd+" ";
}

StringBuffer qrysb= new StringBuffer();

	{
		
qrysb.append("   SELECT TOTAL_NO_APP_BANKREJ,NOT_VIAABLE_NO,"      );
qrysb.append("   ROUND((NOT_VIAABLE_NO/TOTAL_NO_APP_BANKREJ)*100,2) AS NOT_VIAABLE_NO_PER,"      );
qrysb.append("   TARGET_ACHIEV,"      );
qrysb.append("   ROUND((TARGET_ACHIEV/TOTAL_NO_APP_BANKREJ)*100,2) AS TARGET_ACHIEV_PER,"      );
qrysb.append("   OUT_SERV_AREA,"      );
qrysb.append("   ROUND((OUT_SERV_AREA/TOTAL_NO_APP_BANKREJ)*100,2) AS OUT_SERV_AREA_PER,"      );
qrysb.append("   APP_NOTINST,"      );
qrysb.append("   ROUND((APP_NOTINST/TOTAL_NO_APP_BANKREJ)*100,2) AS APP_NOTINST_PER,"      );
qrysb.append("   CIBIL,"      );
qrysb.append("   ROUND((CIBIL/TOTAL_NO_APP_BANKREJ)*100,2) AS CIBIL_PER,"      );
qrysb.append("   DEFAULTER,"      );
qrysb.append("   ROUND((DEFAULTER/TOTAL_NO_APP_BANKREJ)*100,2) AS DEFAULTER_PER,"      );
qrysb.append("   EXIST_UNIT,"      );
qrysb.append("   ROUND((EXIST_UNIT/TOTAL_NO_APP_BANKREJ)*100,2) AS EXIST_UNIT_PER,"      );
qrysb.append("   OWN_CON,"      );
qrysb.append("   ROUND((OWN_CON/TOTAL_NO_APP_BANKREJ)*100,2) AS OWN_CON_PER,"      );
qrysb.append("   INADQ_KNWLD,"      );
qrysb.append("   ROUND((INADQ_KNWLD/TOTAL_NO_APP_BANKREJ)*100,2) AS INADQ_KNWLD_PER,"      );
qrysb.append("   ACT_NEG,"      );
qrysb.append("   ROUND((ACT_NEG/TOTAL_NO_APP_BANKREJ)*100,2) AS ACT_NEG_PER,"      );
qrysb.append("   GOV_EMP,"      );
qrysb.append("   ROUND((GOV_EMP/TOTAL_NO_APP_BANKREJ)*100,2) AS GOV_EMP_PER,"      );
qrysb.append("   DOC_INCOMP,"      );
qrysb.append("   ROUND((DOC_INCOMP/TOTAL_NO_APP_BANKREJ)*100,2) AS DOC_INCOMP_PER,"      );
qrysb.append("   PMEGP_LOAN_AVAIL,"      );
qrysb.append("   ROUND((PMEGP_LOAN_AVAIL/TOTAL_NO_APP_BANKREJ)*100,2) AS PMEGP_LOAN_AVAIL_PER,"      );
qrysb.append("   IMP_APP,"      );
qrysb.append("   ROUND((IMP_APP/TOTAL_NO_APP_BANKREJ)*100,2) AS IMP_APP_PER,"      );
qrysb.append("   REV_APP,"      );
qrysb.append("   ROUND((REV_APP/TOTAL_NO_APP_BANKREJ)*100,2) AS REV_APP_PER,"      );
qrysb.append("   OTHER_BANK,"      );
qrysb.append("   ROUND((OTHER_BANK/TOTAL_NO_APP_BANKREJ)*100,2) AS OTHER_BANK_PER,"      );
qrysb.append("   OTHER_REASON,"      );
qrysb.append("   ROUND((OTHER_REASON/TOTAL_NO_APP_BANKREJ)*100,2) AS OTHER_REASON_PER,"      );
qrysb.append("    RET_APP,");
qrysb.append("   ROUND((RET_APP/TOTAL_NO_APP_BANKREJ)*100,2) AS RET_APP_PER ");
qrysb.append("   FROM"      );
qrysb.append("   (SELECT COUNT(AD.APP_ID) AS TOTAL_NO_APP_BANKREJ,"      );
qrysb.append("   SUM(CASE WHEN BD.REJ_ID=42 THEN 1 ELSE 0 END) AS NOT_VIAABLE_NO,"      );
qrysb.append("   SUM(CASE WHEN BD.REJ_ID=41 THEN 1 ELSE 0 END) AS TARGET_ACHIEV,"      );
qrysb.append("   SUM(CASE WHEN BD.REJ_ID=40 THEN 1 ELSE 0 END) AS OUT_SERV_AREA,"      );
qrysb.append("   SUM(CASE WHEN BD.REJ_ID=33 THEN 1 ELSE 0 END) AS APP_NOTINST,"      );
qrysb.append("   SUM(CASE WHEN BD.REJ_ID=35 THEN 1 ELSE 0 END) AS CIBIL,"      );
qrysb.append("   SUM(CASE WHEN BD.REJ_ID=36 THEN 1 ELSE 0 END) AS DEFAULTER,"      );
qrysb.append("   SUM(CASE WHEN BD.REJ_ID=37 THEN 1 ELSE 0 END) AS EXIST_UNIT,"      );
qrysb.append("   SUM(CASE WHEN BD.REJ_ID=45 THEN 1 ELSE 0 END) AS OWN_CON,"      );
qrysb.append("   SUM(CASE WHEN BD.REJ_ID=38 THEN 1 ELSE 0 END) AS INADQ_KNWLD,"      );
qrysb.append("   SUM(CASE WHEN BD.REJ_ID=31 THEN 1 ELSE 0 END) AS ACT_NEG,"      );
qrysb.append("   SUM(CASE WHEN BD.REJ_ID=32 THEN 1 ELSE 0 END) AS GOV_EMP,"      );
qrysb.append("   SUM(CASE WHEN BD.REJ_ID in (44,50) THEN 1 ELSE 0 END) AS DOC_INCOMP,"      );
qrysb.append("   SUM(CASE WHEN BD.REJ_ID=43 THEN 1 ELSE 0 END) AS PMEGP_LOAN_AVAIL,"      );
qrysb.append("   SUM(CASE WHEN BD.REJ_ID in (15,46,47) THEN 1 ELSE 0 END) AS IMP_APP,"      );
qrysb.append("   SUM(CASE WHEN BD.REJ_ID  IN ( 16 ,48) THEN 1 ELSE 0 END) AS REV_APP,"      );
qrysb.append("   SUM(CASE WHEN BD.REJ_ID=34 THEN 1 ELSE 0 END) AS OTHER_BANK,"      );
qrysb.append("   SUM(CASE WHEN BD.REJ_ID  in ( 39,51,55,54,52,53,56) OR BD.REJ_ID IS NULL THEN 1 ELSE 0 END) AS OTHER_REASON,"      );
qrysb.append("   SUM(CASE WHEN BD.REJ_ID IN ( 14 ,49) OR BD.REJ_ID IS NULL THEN 1 ELSE 0 END) AS RET_APP "      );
qrysb.append("   FROM BANK_DATAENTRY BD,"      );
qrysb.append("   APP_DETAIL AD,MAS_OFF_MAST MOM, M_DISTRICT MD,  M_STATE MS"      );
qrysb.append("   WHERE AD.APP_ID=BD.APP_ID AND MD.DISTRICT_CD=AD.UNIT_DIST_CD AND MS.STATE_CD=MD.STATE_CD "      );
qrysb.append("   AND AD.OFF_CD=MOM.OFF_CD AND TRUNC(AD.BANK_F_DATE) BETWEEN '"+vfromdt+"' AND '"+vtodt+"' "      );
qrysb.append("   AND AD.ACT_ID=5 AND BD.ACT_ID=3  AND AD.ACT_YN='Y' "+Wcls+" "      );
qrysb.append("   )"      );
}

//out.print (qrysb.toString());

	


String  OFF_NAME1 = "";
String  TOTAL_NO_APP_BANKREJ = "";
String  NOT_VIAABLE_NO="";
String  NOT_VIAABLE_NO_PER= "";
String  TARGET_ACHIEV    ="";
String   TARGET_ACHIEV_PER   ="";
String OUT_SERV_AREA  ="";
String OUT_SERV_AREA_PER     ="";
String  APP_NOTINST    ="";
String  APP_NOTINST_PER    ="";
String  CIBIL    ="";
String  CIBIL_PER    ="";
String  DEFAULTER    ="";
String  DEFAULTER_PER   ="";
String  EXIST_UNIT    ="";
String   EXIST_UNIT_PER   ="";
String     OWN_CON ="";
String     OWN_CON_PER ="";
String   INADQ_KNWLD   ="";
String INADQ_KNWLD_PER="";
String RET_APP="";
String RET_APP_PER="";
String  ACT_NEG    ="";
String  ACT_NEG_PER    ="";
String  GOV_EMP    ="";
String  GOV_EMP_PER    ="";
String  DOC_INCOMP   ="";
String  DOC_INCOMP_PER    ="";
String  PMEGP_LOAN_AVAIL   ="";
String  PMEGP_LOAN_AVAIL_PER ="";
String  IMP_APP ="";
String  IMP_APP_PER   ="";
String  REV_APP="";
String  REV_APP_PER ="";
String  OTHER_BANK ="";
String  OTHER_BANK_PER  ="";
String  OTHER_REASON="";
String  OTHER_REASON_PER="";



DBCon db= new DBCon();
db.connect();

ResultSet rsMain = db.execSQL(qrysb.toString());
//out.print(qrysb.toString());


 while (rsMain.next()) { 
//OFF_NAME1=rsMain.getString("OFF_NAME1")==null?"":rsMain.getString("OFF_NAME1");
TOTAL_NO_APP_BANKREJ=rsMain.getString("TOTAL_NO_APP_BANKREJ")==null?"":rsMain.getString("TOTAL_NO_APP_BANKREJ");
NOT_VIAABLE_NO=rsMain.getString("NOT_VIAABLE_NO")==null?"":rsMain.getString("NOT_VIAABLE_NO");
NOT_VIAABLE_NO_PER=rsMain.getString("NOT_VIAABLE_NO")==null?"":rsMain.getString("NOT_VIAABLE_NO_PER");
TARGET_ACHIEV=rsMain.getString("TARGET_ACHIEV")==null?"Grand Total":rsMain.getString("TARGET_ACHIEV");
TARGET_ACHIEV_PER=rsMain.getString("TARGET_ACHIEV_PER")==null?"":rsMain.getString("TARGET_ACHIEV_PER");
OUT_SERV_AREA=rsMain.getString("OUT_SERV_AREA")==null?"":rsMain.getString("OUT_SERV_AREA");
OUT_SERV_AREA_PER=rsMain.getString("OUT_SERV_AREA_PER")==null?"Grand Total":rsMain.getString("OUT_SERV_AREA_PER");
APP_NOTINST=rsMain.getString("APP_NOTINST")==null?"":rsMain.getString("APP_NOTINST");
APP_NOTINST_PER=rsMain.getString("APP_NOTINST_PER")==null?"":rsMain.getString("APP_NOTINST_PER");
//OFF_NAME1=rsMain.getString("OFF_NAME1")==null?"Grand Total":rsMain.getString("OFF_NAME1");
CIBIL=rsMain.getString("CIBIL")==null?"":rsMain.getString("CIBIL");
CIBIL_PER=rsMain.getString("CIBIL_PER")==null?"":rsMain.getString("CIBIL_PER");
DEFAULTER=rsMain.getString("DEFAULTER")==null?"Grand Total":rsMain.getString("DEFAULTER");
DEFAULTER_PER=rsMain.getString("DEFAULTER_PER")==null?"":rsMain.getString("DEFAULTER_PER");
OWN_CON=rsMain.getString("OWN_CON")==null?"":rsMain.getString("OWN_CON");
OWN_CON_PER=rsMain.getString("OWN_CON_PER")==null?"Grand Total":rsMain.getString("OWN_CON_PER");
EXIST_UNIT=rsMain.getString("EXIST_UNIT")==null?"":rsMain.getString("EXIST_UNIT");
EXIST_UNIT_PER=rsMain.getString("EXIST_UNIT_PER")==null?"":rsMain.getString("EXIST_UNIT_PER");
INADQ_KNWLD=rsMain.getString("INADQ_KNWLD")==null?"Grand Total":rsMain.getString("INADQ_KNWLD");
INADQ_KNWLD_PER=rsMain.getString("INADQ_KNWLD_PER")==null?"":rsMain.getString("INADQ_KNWLD_PER");
ACT_NEG=rsMain.getString("ACT_NEG")==null?"":rsMain.getString("ACT_NEG");
ACT_NEG_PER=rsMain.getString("ACT_NEG_PER")==null?"Grand Total":rsMain.getString("ACT_NEG_PER");
GOV_EMP=rsMain.getString("GOV_EMP")==null?"":rsMain.getString("GOV_EMP");
GOV_EMP_PER=rsMain.getString("GOV_EMP_PER")==null?"":rsMain.getString("GOV_EMP_PER");
DOC_INCOMP=rsMain.getString("DOC_INCOMP")==null?"Grand Total":rsMain.getString("DOC_INCOMP");
DOC_INCOMP_PER=rsMain.getString("DOC_INCOMP_PER")==null?"":rsMain.getString("DOC_INCOMP_PER");
PMEGP_LOAN_AVAIL=rsMain.getString("PMEGP_LOAN_AVAIL")==null?"":rsMain.getString("PMEGP_LOAN_AVAIL");
PMEGP_LOAN_AVAIL_PER=rsMain.getString("PMEGP_LOAN_AVAIL_PER")==null?"":rsMain.getString("PMEGP_LOAN_AVAIL_PER");
RET_APP=rsMain.getString("RET_APP")==null?"":rsMain.getString("RET_APP");
RET_APP_PER=rsMain.getString("RET_APP_PER")==null?"":rsMain.getString("RET_APP_PER");
IMP_APP=rsMain.getString("IMP_APP")==null?"":rsMain.getString("IMP_APP");
IMP_APP_PER=rsMain.getString("IMP_APP_PER")==null?"":rsMain.getString("IMP_APP_PER");
REV_APP=rsMain.getString("REV_APP")==null?"":rsMain.getString("REV_APP");
REV_APP_PER=rsMain.getString("REV_APP_PER")==null?"":rsMain.getString("REV_APP_PER");
OTHER_BANK=rsMain.getString("OTHER_BANK")==null?"":rsMain.getString("OTHER_BANK");
OTHER_BANK_PER=rsMain.getString("OTHER_BANK_PER")==null?"":rsMain.getString("OTHER_BANK_PER");
OTHER_REASON=rsMain.getString("OTHER_REASON")==null?"":rsMain.getString("OTHER_REASON");
OTHER_REASON_PER=rsMain.getString("OTHER_REASON_PER")==null?"":rsMain.getString("OTHER_REASON_PER");
//OFF_CD==rsMain.getString("OFF_CD")==null?"":rsMain.getString("OFF_CD");





%>
<center>
  <h1> Rejection By Bank Status Report Of <%=OFF_NAME%> </h1>
  <%
ResultSet rsDist = db.execSQL("SELECT MD.DISTRICT_CD,MD.DISTRICT_NAME FROM M_DISTRICT MD, M_STATE MS WHERE MD.STATE_CD      = MS.STATE_CD AND MD.DISTRICT_STATUS = 'A' AND MS.STATE_NM='"+OFF_NAME+"'");  
  
  %>
  
  Select District : 
  <select name="district" id="district">
  <option value="">All</option>
  <% 
  String DISTRICT_CD="";
  String DISTRICT_NAME="";
  while  ( rsDist.next() ) {
  DISTRICT_CD=rsDist.getString("DISTRICT_CD")==null?"":rsDist.getString("DISTRICT_CD");
  DISTRICT_NAME=rsDist.getString("DISTRICT_NAME")==null?"":rsDist.getString("DISTRICT_NAME");
  
   %>
    
  <option value="<%= DISTRICT_CD %>"   <% if (Districtcd.equals(DISTRICT_CD) ) {out.print("selected");} %> ><%= DISTRICT_NAME %></option>
  
  <%
  }
  
  rsDist.close();
  %>

</select>

  <input type="submit" name="Submit" value="Submit">
</center>
<div class="container" align="center">
  <div class="col-md-18">
<br>
<br>
<div id="piechart_3d"></div>

</div>
 </div>
 <table width="80%" align="center" class="bordered" id="tableid">
 
  <tr>
    <th width="10%"><div align="center">Sr.No</div></th>
	<th width="44%"><div align="center">PARTICULARS</div></th>
	<th width="14%">  <div align="center">No.of.proj    </div>
	<th width="13%"><div align="center">In %    </div></th>
	   
	<tr><td>1</td>
	  <td>Total No of Application Rejected</td>
	  <td><%=TOTAL_NO_APP_BANKREJ%></td>
	   <td>-</td></tr>
	  <tr>
	    <td>2</td>
	    <td>Not Viable</td>
	   <td><%=NOT_VIAABLE_NO%></td>
	   <td><%=NOT_VIAABLE_NO_PER%></td></tr>
	   <tr>
	     <td>3</td>
	     <td>PMEGP Target Achieved for current year </td>
	   <td><%=TARGET_ACHIEV%></td>
	   <td><%=TARGET_ACHIEV_PER%></td></tr>
	  <tr>
	    <td>4</td>
	    <td>Out of service area </td>
	   <td><%=OUT_SERV_AREA%></td>
	<td><%=OUT_SERV_AREA_PER%></td></tr>
	  <tr>
	    <td>5</td>
	    <td>Applicant not intrested </td>
	   <td><%=APP_NOTINST%></td>
	<td><%=APP_NOTINST_PER%></td>
    <tr>
	     <td>6</td>
	     <td>CIBIL Report not satisfactory</td>
	   <td><%=CIBIL%></td>
	<td><%=CIBIL_PER%></td>
    <tr>
	    <td>7</td>
	    <td>Defaulter</td>
	  <td><%=DEFAULTER%></td>
	<td><%=DEFAULTER_PER%></td>
    <tr>
	    <td>8</td>
	    <td>Unable to deposit own contribution</td>
	   <td><%=OWN_CON%></td>
	<td><%=OWN_CON_PER%></td>
    <tr>
      <td>9</td>
      <td>Existing unit </td>
	   <td><%=EXIST_UNIT%></td>
	<td><%=EXIST_UNIT_PER%></td>
    <tr>
      <td>10</td>
      <td>Inadequate knowledge in proposed industry </td>
	   <td><%=INADQ_KNWLD%></td>
	<td><%=INADQ_KNWLD_PER%></td>
    <tr>
      <td>11</td>
      <td>Activity in negative list as per PMEGP Scheme</td>
	   <td><%=ACT_NEG%></td>
	<td><%=ACT_NEG_PER%></td>
    <tr>
      <td>12</td>
      <td>Already Govt. Employee </td>
	  <td><%=GOV_EMP%></td>
	<td><%=GOV_EMP_PER%></td>
    <tr>
      <td>13</td>
      <td>Unable to submit Documents</td>
	   <td><%=DOC_INCOMP%></td>
	<td><%=DOC_INCOMP_PER%></td>
    <tr>
      <td>14</td> 
      <td>Spouse PMEGP/REGP Loan availed</td>
	  <td><%=PMEGP_LOAN_AVAIL%></td>
	<td><%=PMEGP_LOAN_AVAIL_PER%></td>
    <tr>
      <td>15</td>
      <td>Applicant requested to return application</td>
	   <td><%=RET_APP%></td>
	<td><%=RET_APP%></td>
    <tr>
      <td>16</td>
      <td>Improper application </td>
	   <td><%=IMP_APP%></td>
	<td><%=IMP_APP_PER%></td>
    <tr>
      <td>17</td>
      <td>Revised Application Submitted </td>
	   <td><%=REV_APP%></td>
	<td><%=REV_APP_PER%></td>
    <tr>
      <td>18</td>
      <td>Applicant willing to avail PMEGP loan from other bank</td>
	   <td><%=OTHER_BANK%></td>
	<td><%=OTHER_BANK_PER%></td>
    <tr>
	     <td>19</td>
	     <td>Other Reasons </td>
	   <td><%=OTHER_REASON%></td>
	<td><%=OTHER_REASON_PER%></td>
   
  </table>
  
  
  
  
  
  
 <%  }
  rsMain.close();
  db.close();
    %>
</form>
<script language="javascript">
 google.charts.load("current", {packages:['corechart']});
    google.charts.setOnLoadCallback(drawChart);
   
      //google.charts.load("current", {packages:["corechart"]});
    
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Reason', 'No of Application'],
          ['Not Viable',     <%= NOT_VIAABLE_NO %>],
          ['PMEGP Target Achieved for current year',     <%= TARGET_ACHIEV %>],
          ['Out of service area',  <%= OUT_SERV_AREA %>],
          ['Applicant not intrested', <%= APP_NOTINST %>],
          ['CIBIL Report not satisfactory',    <%= CIBIL %>],
		  ['Defaulter', <%= DEFAULTER %>],
          ['Unable to deposit own contribution',    <%= OWN_CON %>],
		  ['Existing unit', <%= EXIST_UNIT %>],
          ['Inadequate knowledge in proposed industry ',    <%= INADQ_KNWLD %>],
		  ['Activity in negative list as per PMEGP Scheme', <%= ACT_NEG %>],
          ['Already Govt. Employee',    <%= GOV_EMP %>],
		  ['Unable to submit Documents', <%= DOC_INCOMP %>],
          ['Spouse PMEGP/REGP Loan availed',    <%= PMEGP_LOAN_AVAIL %>],
		  ['Applicant requested to return application', <%= RET_APP %>],
          ['Improper application',    <%= IMP_APP %>],
		  ['Revised Application Submitted', <%= REV_APP %>],
          ['Applicant willing to avail PMEGP loan from other bank',    <%= OTHER_BANK %>],
		  ['Other Reasons', <%= OTHER_REASON %>] 
		  
		  
        ]);

        var options = {
		   width:600,height:400,
          title: 'Rejection Reason wise no  of Application',
          is3D: true,
        };

        var chart = new google.visualization.PieChart(document.getElementById('piechart_3d'));
        chart.draw(data, options);
      }
    </script>

</body>
</html>
