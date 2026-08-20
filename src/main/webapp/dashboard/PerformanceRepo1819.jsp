<%@ page session="true"  import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon" %>
<%@ page import="kvic.inputvalid.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Untitled Document</title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />

<style type="text/css">
<!--
.style1 {
	color: #FFFFFF;
	font-size: 14px;
}
.style2 {color: #FFFFFF}
.style3 {color: #FFFFFF; font-size: 16px; }
.style4 {
	color: #FFFF33;
	font-size: 18px;
}
.style6 {font-size: 18px}
.style7 {	font-size: 36px;
	font-weight: bold;
}
-->
</style>
</head>

<body>
<div id="header" align="center">
<img src="images/pmegponlineN.jpg"  height="20%" width="100%">
</div>
 <center>
   <p><a href="../pmegphome/dashboard.jsp" class="greenButtonRound" >   
   Back</a></p>
   <p><span class="style7">Annual Progress Report </span></p>
</center>
 <table width="50%"  border="0" cellspacing="1" cellpadding="1" align="center">
   <tr bordercolor="#FFFFFF" bgcolor="#003333">
     <td colspan="5"><div align="center" class="style3 style4">**** REPORTS MENU **** </div></td>
   </tr>
   <tr bordercolor="#FFFFFF" bgcolor="#124B1B">
     <td><div align="center"></div></td>
     <td nowrap><span class="style2">PMEGP NEW</span></td>
	 <td nowrap><span class="style2">PMEGP SECOND LOAN</span></td>
     <td nowrap><span class="style2">PMEGP OLD </span></td>
     <td><span class="style2">CONSOLIDATEED</span></td>
   </tr>
   <tr bordercolor="#FFFFFF">
     <th nowrap>1) Bank Wise Performance </th>
     <th><div align="center"><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=BANK_WISE_APR1718&QRYCODE=5" class="button" target="_blank">View</a></div></th>
	 <th><div align="center"><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=BANK_WISE_APR1718&QRYCODE=6" class="button" target="_blank">View</a></div></th>
     <th><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=BANK_WISE_APR1718&QRYCODE=7" class="button" target="_blank">View</a></th>
     <th><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=BANK_WISE_APR1718&QRYCODE=8" class="button" target="_blank">View</a></th>
   </tr>
   <tr bordercolor="#FFFFFF" bgcolor="#124B1B">
     <td colspan="5"><div align="center" class="style1">Industry Group Wise </div></td>
   </tr>
   <tr bordercolor="#FFFFFF">
     <th>2) No Of Project </th>
     <th><div align="center"><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=IND_WISE_NO_PROJ&QRYCODE=5" class="button" target="_blank">View</a></div></th>
     <th><div align="center"><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=IND_WISE_NO_PROJ&QRYCODE=6" class="button" target="_blank">View</a></div></th>
	 <th><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=IND_WISE_NO_PROJ&QRYCODE=7" class="button" target="_blank">View</a></th>
     <th><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=IND_WISE_NO_PROJ&QRYCODE=8" class="button" target="_blank">View</a></th>
   </tr>
   <tr bordercolor="#FFFFFF">
     <th>3) MM Utilization </th>
     <th><div align="center"><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=IND_WISE_MM&QRYCODE=5" class="button" target="_blank">View</a></div></th>
    <th><div align="center"><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=IND_WISE_MM&QRYCODE=6" class="button" target="_blank">View</a></div></th>
	<th><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=IND_WISE_MM&QRYCODE=7" class="button" target="_blank">View</a></th>
     <th><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=IND_WISE_MM&QRYCODE=8" class="button" target="_blank">View</a></th>
   </tr>
   <tr bordercolor="#FFFFFF">
     <th>4)Employement</th>
     <th><div align="center"><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=IND_WISE_EMP&QRYCODE=5" class="button" target="_blank">View</a></div></th>
     <th><div align="center"><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=IND_WISE_EMP&QRYCODE=6" class="button" target="_blank">View</a></div></th>
	 <th><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=IND_WISE_EMP&QRYCODE=7" class="button" target="_blank">View</a></th>
     <th><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=IND_WISE_EMP&QRYCODE=8" class="button" target="_blank">View</a></th>
   </tr>
   <tr bordercolor="#FFFFFF" bgcolor="#124B1B">
     <td colspan="5"><div align="center" class="style2">Social Category </div></td>
   </tr>
   <tr bordercolor="#FFFFFF">
     <th>5)No Of Project </th>
     <th><div align="center"><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=CAT_WISE_NO_PRJ&QRYCODE=5" class="button" target="_blank">View</a></div></th>
      <th><div align="center"><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=CAT_WISE_NO_PRJ&QRYCODE=6" class="button" target="_blank">View</a></div></th>
	 <th><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=CAT_WISE_NO_PRJ&QRYCODE=7" class="button" target="_blank">View</a></th>
     <th><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=CAT_WISE_NO_PRJ&QRYCODE=8" class="button" target="_blank">View</a></th>
   </tr>
   <tr bordercolor="#FFFFFF">
     <th>6) MM Utilization </th>
     <th><div align="center"><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=CAT_WISE_MM&QRYCODE=5" class="button" target="_blank">View</a></div></th>
    <th><div align="center"><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=CAT_WISE_MM&QRYCODE=6" class="button" target="_blank">View</a></div></th>
	<th><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=CAT_WISE_MM&QRYCODE=7" class="button" target="_blank">View</a></th>
     <th><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=CAT_WISE_MM&QRYCODE=8" class="button" target="_blank">View</a></th>
   </tr>
   <tr bordercolor="#FFFFFF">
     <th>7)Employement</th>
     <th><div align="center"><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=CAT_WISE_EMP&QRYCODE=5" class="button" target="_blank">View</a></div></th>
      <th><div align="center"><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=CAT_WISE_EMP&QRYCODE=6" class="button" target="_blank">View</a></div></th>
	 <th><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=CAT_WISE_EMP&QRYCODE=7" class="button" target="_blank">View</a></th>
     <th><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=CAT_WISE_EMP&QRYCODE=8" class="button" target="_blank">View</a></th>
   </tr>
   <tr bordercolor="#FFFFFF" bgcolor="#124B1B">
     <td colspan="5"><div align="center" class="style2">Financial Range wise </div></td>
   </tr>
   <tr bordercolor="#FFFFFF">
     <th>8) No Of Project</th>
     <th><div align="center"><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=FINANCIAL_RANGE&QRYCODE=5" class="button" target="_blank">View</a></div></th>
     <th><div align="center"><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=FINANCIAL_RANGE&QRYCODE=6" class="button" target="_blank">View</a></div></th>
	 <th><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=FINANCIAL_RANGE&QRYCODE=7" class="button" target="_blank">View</a></th>
     <th><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=FINANCIAL_RANGE&QRYCODE=8" class="button" target="_blank">View</a></th>
   </tr>
   <tr bordercolor="#FFFFFF" bgcolor="#124B1B">
     <td colspan="5" class="style2"><div align="center">Statewise Performance </div></td>
   </tr>
   <tr bordercolor="#FFFFFF">
     <th nowrap>9) Statewise Performance </th>
     <th><div align="center"><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=UNIT_LOC_REPO1718&QRYCODE=5" class="button" target="_blank">View</a></div></th>
	  <th><div align="center"><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=UNIT_LOC_REPO1718&QRYCODE=6" class="button" target="_blank">View</a></div></th>
     <th><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=UNIT_LOC_REPO1718&QRYCODE=7" class="button" target="_blank">View</a></th>
     <th><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=UNIT_LOC_REPO1718&QRYCODE=8" class="button" target="_blank">View</a></th>
   </tr>
   <tr bordercolor="#FFFFFF" bgcolor="#124B1B">
     <td colspan="5"><div align="center"><span class="style2">Agency wise Performance </span></div></td>
   </tr>
   <tr bordercolor="#FFFFFF">
     <th nowrap>10)Overall (KVIC,KVIB,DIC) </th>
     <th><div align="center"><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=AGENCY_PERFORMANCE&QRYCODE=5" class="button" target="_blank">View</a></div></th>
	  <th><div align="center"><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=AGENCY_PERFORMANCE&QRYCODE=6" class="button" target="_blank">View</a></div></th>
     <th><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=AGENCY_PERFORMANCE&QRYCODE=7" class="button" target="_blank">View</a></th>
     <th><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=AGENCY_PERFORMANCE&QRYCODE=8" class="button" target="_blank">View</a></th>
   </tr>
   <tr bordercolor="#FFFFFF">
     <th>11)KVIC Performance</th>
     <th><div align="center"><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=KVIC_PERFORMANCE&QRYCODE=5" class="button" target="_blank">View</a></div></th>
    <th><div align="center"><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=KVIC_PERFORMANCE&QRYCODE=6" class="button" target="_blank">View</a></div></th>
	<th><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=KVIC_PERFORMANCE&QRYCODE=7" class="button" target="_blank">View</a></th>
     <th><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=KVIC_PERFORMANCE&QRYCODE=8" class="button" target="_blank">View</a></th>
   </tr>
   <tr bordercolor="#FFFFFF">
     <th>12)KVIB Performance</th>
     <th><div align="center"><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=KVIB_PERFORMANCE&QRYCODE=5" class="button" target="_blank">View</a></div></th>
      <th><div align="center"><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=KVIB_PERFORMANCE&QRYCODE=6" class="button" target="_blank">View</a></div></th>
	 <th><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=KVIB_PERFORMANCE&QRYCODE=7" class="button" target="_blank">View</a></th>
     <th><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=KVIB_PERFORMANCE&QRYCODE=8" class="button" target="_blank">View</a></th>
   </tr>
   <tr bordercolor="#FFFFFF">
     <th>13)DIC Performance</th>
     <th><div align="center"><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=DIC_PERFORMANCE&QRYCODE=5"  class="button" target="_blank">View</a></div></th>
     <th><div align="center"><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=DIC_PERFORMANCE&QRYCODE=6"  class="button" target="_blank">View</a></div></th>
	<th><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=DIC_PERFORMANCE&QRYCODE=7"  class="button" target="_blank">View</a></th>
     <th><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=DIC_PERFORMANCE&QRYCODE=8"  class="button" target="_blank">View</a></th>
   </tr>
    <tr bordercolor="#FFFFFF" bgcolor="#124B1B">
     <td colspan="5"><div align="center" class="style1">Industry Group Wise (District wise) </div></td>
   </tr>
   <tr bordercolor="#FFFFFF">
     <th>14) No Of Project </th>
     <th><div align="center"><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=IND_WISE_NO_PROJ_D&QRYCODE=5" class="button" target="_blank">View</a></div></th>
	   <th><div align="center"><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=IND_WISE_NO_PROJ_D&QRYCODE=6" class="button" target="_blank">View</a></div></th>
     <th><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=IND_WISE_NO_PROJ_D&QRYCODE=7" class="button" target="_blank">View</a></th>
     <th><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=IND_WISE_NO_PROJ_D&QRYCODE=8" class="button" target="_blank">View</a></th>
   </tr>
   <tr bordercolor="#FFFFFF">
     <th>15) MM Utilization </th>
     <th><div align="center"><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=IND_WISE_MM_D&QRYCODE=5" class="button" target="_blank">View</a></div></th>
	  <th><div align="center"><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=IND_WISE_MM_D&QRYCODE=6" class="button" target="_blank">View</a></div></th>
     <th><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=IND_WISE_MM_D&QRYCODE=7" class="button" target="_blank">View</a></th>
     <th><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=IND_WISE_MM_D&QRYCODE=8" class="button" target="_blank">View</a></th>
   </tr>
   <tr bordercolor="#FFFFFF">
     <th>16)Employement</th>
     <th><div align="center"><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=IND_WISE_EMP_D&QRYCODE=5" class="button" target="_blank">View</a></div></th>
	    <th><div align="center"><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=IND_WISE_EMP_D&QRYCODE=6" class="button" target="_blank">View</a></div></th>
     <th><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=IND_WISE_EMP_D&QRYCODE=7" class="button" target="_blank">View</a></th>
     <th><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=IND_WISE_EMP_D&QRYCODE=8" class="button" target="_blank">View</a></th>
   </tr>
   <tr bordercolor="#FFFFFF" bgcolor="#124B1B">
     <td colspan="5"><div align="center" class="style2">Social Category <span class="style1"> (District wise) </span></div></td>
   </tr>
   <tr bordercolor="#FFFFFF">
     <th>17)No Of Project </th>
     <th><div align="center"><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=CAT_WISE_NO_PRJ_D&QRYCODE=5" class="button" target="_blank">View</a></div></th>
	  <th><div align="center"><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=CAT_WISE_NO_PRJ_D&QRYCODE=6" class="button" target="_blank">View</a></div></th>
     <th><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=CAT_WISE_NO_PRJ_D&QRYCODE=7" class="button" target="_blank">View</a></th>
     <th><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=CAT_WISE_NO_PRJ_D&QRYCODE=8" class="button" target="_blank">View</a></th>
   </tr>
   <tr bordercolor="#FFFFFF">
     <th>18) MM Utilization </th>
     <th><div align="center"><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=CAT_WISE_MM_D&QRYCODE=5" class="button" target="_blank">View</a></div></th>
	   <th><div align="center"><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=CAT_WISE_MM_D&QRYCODE=6" class="button" target="_blank">View</a></div></th>
     <th><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=CAT_WISE_MM_D&QRYCODE=7" class="button" target="_blank">View</a></th>
     <th><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=CAT_WISE_MM_D&QRYCODE=8" class="button" target="_blank">View</a></th>
   </tr>
   <tr bordercolor="#FFFFFF">
     <th>19)Employement</th>
     <th><div align="center"><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=CAT_WISE_EMP_D&QRYCODE=5" class="button" target="_blank">View</a></div></th>
	 <th><div align="center"><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=CAT_WISE_EMP_D&QRYCODE=6" class="button" target="_blank">View</a></div></th>
     <th><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=CAT_WISE_EMP_D&QRYCODE=7" class="button" target="_blank">View</a></th>
     <th><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=CAT_WISE_EMP_D&QRYCODE=8" class="button" target="_blank">View</a></th>
   </tr>
    <tr bordercolor="#FFFFFF" bgcolor="#124B1B">
     <td colspan="5"><div align="center"><span class="style2">Agency wise Performance (District Wise) </span></div></td>
   </tr>
   <tr bordercolor="#FFFFFF">
     <th nowrap>20)Overall (KVIC,KVIB,DIC) </th>
     <th><div align="center"><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=AGENCY_PERFORMANCE_D&QRYCODE=5" class="button" target="_blank">View</a></div></th>
	   <th><div align="center"><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=AGENCY_PERFORMANCE_D&QRYCODE=6" class="button" target="_blank">View</a></div></th>
     <th><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=AGENCY_PERFORMANCE_D&QRYCODE=7" class="button" target="_blank">View</a></th>
     <th><a href="../jasperrop/pmegpPerformance1718.jsp?REPNM=AGENCY_PERFORMANCE_D&QRYCODE=8" class="button" target="_blank">View</a></th>
   </tr>

 </table>
 <div align="center"></div>
</body>
</html>
