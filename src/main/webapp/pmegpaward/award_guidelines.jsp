<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ include file="pmegp_menu.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
</head>
<style>
.cont1{

background-color:#FAF5EF; }
.style1 {
	font-family: Arial, Helvetica, sans-serif;
	font-weight: bold;
}
.con{  font-family: Arial, Helvetica, sans-serif;s
  border-collapse: collapse;
  width: 85%;
  border-style: inset;
  background-color:#FFFFFF;
  }
</style>
<body>
<%
String sAPP_ID=session.getAttribute("sAPP_ID")==null?"0":(String)session.getAttribute("sAPP_ID");
%>
<center>
<div align="center"><h1><u>Read Eligibility Criteria</u></h1></div>
<form  class="con">
 <div align="center"  class="cont1" style="background-color:#3f506e; color:#FFFFFF">
   <h1 class="style1"><u>PMEGP National Award Guidelines</u></h1>
 </div>
<div align="center" class="cont1">
 
  <p>&nbsp;</p>
  <p>The objective of the awards programme is to promote and reward innovation and excellence in achieving the overall objectives of PMEGP scheme every year. 
    PMEGP award are proposed considering the average performance of 3 years from FY 2018-19 to FY 2020-21 for all nomination categories. Since the turnover criteria has been considered for all nominations, separate category of award manufacturing and services may not be required. The awards are tentatively planned to be conferred by June or July 2022. </p>
	<ul>
	  <li>
	    <div align="left"><strong>	Eligibility criteria for Nomination</strong><br />
        The awards are open to all existing PMEGP beneficiaries considering the average performance of 3 years from FY 2018-19 to FY 2020-21.  </div>
  </ul>
  	<ul>
	  <li>
	    <div align="left"><strong>		Best PMEGP beneficiaries </strong><br />
      Top MSME unit, registered under PMEGP, from each state will be awarded and recognized for their performance score. <br />Certain special award may also be considered in categories such as –
	    <div align="left">-Turnover as compared to the project cost
	      <div align="left">-Employment generated
	        <div align="left">-Standardization, trademark, Quality Certification
	          <div align="left">-Compliance
	            <div align="left"><br />-Utilization of market channels </div>
	          </div>
	        </div>
	      </div>
	    </div>
	    </div>
	  
      <li>
        <div align="left"><strong>Beneficiary  Nominations</strong>
          <div align="left">-Nominations will be entertained only through the  link provided on PMEGP portal. The beneficiaries to submit nomination within  the stipulated timeline. Further, no nomination beyond the deadline will be  considered.</div>
        </div>
      </li>
  </ul>
  <div align="center">
    <p align="center" class="style1"><u>Award Criteria for Beneficiaries: (FY 2018-19 to FY  2020-21)</u></p>
    <div align="center">
      <table border="1" cellspacing="0" cellpadding="0" align="center" width="800"  class="cont1">
        <tr>
          <td width="47" valign="top"><div a>
            <div align="center"><br />
              <strong>Sr. No.</strong> </div>
          </div></td>
          <td width="122" valign="top"><p align="center"><strong>Performance    Indicator</strong></p></td>
          <td width="284" valign="top"><p align="center"><strong>Description</strong></p></td>
          <td width="85" valign="top"><p align="center"><strong>Weightage</strong></p></td>
          <td width="95" valign="top"><p align="center"><strong>Documents Required</strong></p></td>
        </tr>
        <tr>
          <td width="47" valign="top"><p>1</p></td>
          <td width="122" valign="top"><p>Annual sales    turnover</p></td>
          <td width="284" valign="top"><p>Units which have an    annual turnover of more than double the project cost after starting the unit.<br />
            &lt;2 times project    cost &ndash; <strong>0 Marks </strong><br />
            &gt;=2 - &lt;3 times    of project cost &ndash; <strong>15 Marks</strong><br />
            &gt;=3 - &lt;4 times    of project cost &ndash;<strong> 20 Marks</strong><br />
            &gt;=4 - &lt;5 times    of project cost<strong> </strong>&ndash;<strong> 25 Marks</strong><br />
            &gt;=5 times of    project cost &ndash;<strong> 30 Marks </strong></p></td>
          <td width="85" valign="top"><p><strong>&nbsp;</strong></p>
              <p><strong>&nbsp;</strong></p>
            <p>30 Marks</p></td>
          <td width="95" valign="top"><p><strong>&nbsp;</strong></p>
              <p>&nbsp;&nbsp;&nbsp;&nbsp; CA<br />
                Certificate<strong></strong></p></td>
        </tr>
        <tr>
          <td width="47" valign="top"><p>2</p></td>
          <td width="122" valign="top"><p>Employment    Generation</p></td>
          <td width="284" valign="top"><p>The employment    percentage is to be calculated on CE portion assumed to be at 60 of total    project cost.<br />
                  <strong>For example, </strong>if total project cost is Rs.10 Lakhs    then minimum employment generation expected is of 6 persons (i.e., calculated    on 60% of project cost @ <strong>1 Employment/ 1 Lakhs Project Cost)</strong><br />
                  <strong>Similarly, for NER/    Hill Areas, </strong>if the    project cost is RS. 10 Lakhs then minimum 4 employment to be provided (<strong>Calculated    at CE @ 60% of project cost/ 1.5 Lakhs) (i.e., 6 Lakhs/ 1.5 Lakhs = 4)</strong><br />
            If employment as per    above parameter is &lt;60%, -<strong> 0 Marks</strong><br />
            If employment as per    above parameter is <br />
            &gt;= 60% - &lt;70%,    - <strong>10 Marks</strong><br />
            If employment as per    above parameter is &gt;=70% - &lt;80%, - <strong>15 Marks</strong><br />
            If employment as per    above parameter is &gt;=80% - &lt;90%, - <strong>20 Marks</strong><br />
            If employment as per    above parameter is &gt;=90% - &lt;100%, - <strong>25 Marks</strong><br />
            If employment as per    above parameter is &gt;=100%,&nbsp; - <strong>30    Marks</strong></p>
              <p>&nbsp;</p></td>
          <td width="85" valign="top"><p>&nbsp;</p>
              <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>30 Marks<strong></strong></p></td>
          <td width="95" valign="top"><p>&nbsp;&nbsp; </p>
              <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <p>&nbsp; CA<br />
              Certificate<strong></strong></p></td>
        </tr>
        <tr>
          <td width="47" valign="top"><p>3</p></td>
          <td width="122" valign="top"><p>Standardization,    Trademark, Quality Certification</p></td>
          <td width="284" valign="top"><p>Based on relevant    certification as required by regulatory bodies:</p>
              <ul>
                <li>ISO Certification- <strong>5 Marks</strong></li>
                <li>GST Registration - <strong>5 Marks</strong></li>
                <li>UDYAM Registration - <strong>5 Marks</strong></li>
                <li>Trademark Registration - <strong>5 Marks</strong></li>
              </ul></td>
          <td width="85" valign="top"><p>&nbsp;</p>
              <p>20 Marks</p></td>
          <td width="95" valign="top"><p>Applicable    certificates to be uploaded</p></td>
        </tr>
        <tr>
          <td width="47" valign="top"><p>4</p></td>
          <td width="122" valign="top"><p>Utilization of    marketing channels (local marketing, procurement &amp; social media)</p></td>
          <td width="284" valign="top"><ul>
            <li>GEM    registration -<strong> 5 Marks</strong></li>
            <li>E- commerce    collaboration<strong> </strong>-<strong> 5</strong><strong>Marks</strong></li>
            <li>Supply to Government/Public Offices/Corporates - <strong>5 Marks</strong></li>
            <li>Participation in national/ local level exhibitions,trade fairs ect.- <strong>5 Marks</strong></li>
          </ul></td>
          <td width="85" valign="top"><p>&nbsp;</p>
              <p>20 Marks</p></td>
          <td width="95" valign="top"><p>Applicable certificates    or MOU to be uploaded</p></td>
        </tr>
      </table>
    </div>

</table>
</form>
</center>
</body>
</html>
