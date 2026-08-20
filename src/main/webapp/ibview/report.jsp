<%@ include file="IncludeHeader.jsp" %>
<html>
<head>

<script type="text/javascript" src="../js/datetimepicker_css.js"></script>
<link rel="stylesheet" type="text/css" href="../css/dis.css"> 
<script>

function callback(){ 
var frm= document.getElementById("FROMDT").value;
var to=document.getElementById("TODT").value;
window.location.href = '../jasperrop/genrepexcelInd.jsp?REPNAME=callback&FROMDT='+frm+'&TODT='+to;
}

function Failcaseibview(){ 
var frm= document.getElementById("FROMDT").value;
var to=document.getElementById("TODT").value;
window.location.href = '../jasperrop/generateFailCaseExcel.jsp?REPNAME=Failcaseibview&FROMDT='+frm+'&TODT='+to;
}


function FailcaseibviewSFTP(){ 

window.location.href = '../jasperrop/generateFailCaseExcel.jsp?REPNAME=SFTPFAILCASE';
}



  function now()
{
 var todaydt=new Date();
var dd=todaydt.getDate();
var mm=todaydt.getMonth()+1;
var yr=todaydt.getFullYear();
var months=['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
var showdt=dd+'-'+months[mm-1]+'-'+yr;
showdt=showdt.toUpperCase();

return (showdt);
}
 
 function todaydt() {
 test = new Date()
document.getElementById("TODT").value=now();
 }

</script>
</head>
<body onLoad="todaydt()">

<form method="post" action="" name="form" id="form">
  
  <table class="pmegpTable"><br>
    <tr>
      <th>&nbsp;</th>
      <th>MM Release From Date :
      <input name="FROMDT" type="text" id="FROMDT"  onClick="javascript:NewCssCal('FROMDT','ddMMMyyyy')"  value="" readonly="readonly" ></th>
      <th colspan="2">MM Release To Date :      
      <input name="TODT" type="text" id="TODT"  onClick="javascript:NewCssCal('TODT','ddMMMyyyy')" value="" readonly="readonly" ></th>
    </tr>
    <tr>
      <th>1)</th>
      <th colspan="2">Callback Report</th>
      <th nowrap><div align="center"> <input name="button9" type="button" class="buttongrey" onClick="callback();" value="View"></div></th>
  </tr>
  
  <tr>
    <th>2)</th>
    <th colspan="2">Fail Case</th>
    <th nowrap><div align="center"> <input name="button9" type="button" class="buttongrey" onClick="Failcaseibview();" value="View"></div></th>
  </tr>
   <tr>
    <th>3)</th>
    <th colspan="2">Recommended Case  Fail to Upload in SFTP</th>
    <th nowrap><div align="center"> <input name="button9" type="button" class="buttongrey" onClick="FailcaseibviewSFTP();" value="View"></div></th>
  </tr>
  </table>
</form>  
 
</body>
</html>
