
<%@ include file="includeHeadercomm.jsp" %>
<html>
<head>
<script type="text/javascript">
function dateChange(){
vYR=document.getElementsByName("SEL_YEAR")[0].value
var todaydt=new Date();
var dd=todaydt.getDate();
var mm=todaydt.getMonth()+1;
var yr=todaydt.getFullYear();
var months=['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
var showdt=dd+'-'+months[mm-1]+'-'+yr;
showdt=showdt.toUpperCase();

if (vYR=='2016-17'){
document.getElementsByName("RFROMDT")[0].value='01-APR-2016';
document.getElementsByName("RTODATE")[0].value='31-MAR-2017';
}else if  (vYR=='2017-18'){
document.getElementsByName("RFROMDT")[0].value=showdt;
document.getElementsByName("RTODATE")[0].value=showdt;
}
}
</script>

</head>
<body onLoad="dateChange();">
<form method="post" name="form1" id="form1" action="mmclaimindividualreport.jsp">
<p align="center"><br /> 
  </p>
<p>&nbsp;</p>
<table align="center">
<tr>
<td>

</td>
<tr>
<td>
<table width="1008" align="center">
  <tr>
  <td ><div align="right"> Year</div></td>
      <td ><select name="SEL_YEAR"  id="SEL_YEAR" onChange="dateChange();">
	   <option value="2017-18" selected>2017-18</option>
	   <option value="2016-17" >2016-17</option>
	  
      
                  </select></td>
        <td><div align="right">From Date: </div></td>
    <td ><input name="RFROMDT" type="text"  id="RFROMDT" value="" onClick="javascript:NewCal('RFROMDT','ddmmmyyyy')" size="11" maxlength="11">
    </td>
    <td ><div align="right">To </div></td>
    <td  colspan="4"><input name="RTODATE" type="text" value=""  id="RTODATE" onClick="javascript:NewCal('RTODATE','ddmmmyyyy')" size="11" maxlength="11"></td>
  <td><input name="msreport"  id="msreport" onClick="abc();" class="button" type="submit"  value="submit"></td>
  </tr>
</table>

</td>
</tr>

</table>
</form>
</body>
</html>
