
<%@ include file="includeHeaderPage.jsp" %>


<html>
<head>
<title>Reports</title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />

<script type="text/javascript" src="../js/datetimepicker_css.js"></script>



<link rel="stylesheet" type="text/css" href="../css/jquery.dataTables.min.css" />
<script language="javascript" src="../js/jquery-1.12.4.js"></script>
<script language="javascript" src="../js/jquery.dataTables.min.js"></script>
<script language="javascript">
$(document).ready(function() {
    $('#example').DataTable( {
	 "order": [[ 4, "desc" ]]
    } );
} );


function submitfun(){

   var FROMDT = document.getElementById("FROMDT").value;
   var TODT = document.getElementById("TODT").value;

  if(FROMDT == "" || FROMDT == "0" ) {
    inlineMsg('FROMDT','SELECT DATE',2);
    return false;
  }
    if(TODT == "" || TODT == "0" ) {
    inlineMsg('TODT','SELECT DATE',2);
    return false;
  }

openModal();
document.form.ins.value='I';
document.form.submit();
document.getElementById("formsubmitbutton").style.display = "none"; // to undisplay
   document.getElementById("buttonreplacement").style.display = ""; // to display
}

	function openModal() {
        document.getElementById('modal').style.display = 'block';
        document.getElementById('fade').style.display = 'block';
}

function closeModal() {
    document.getElementById('modal').style.display = 'none';
    document.getElementById('fade').style.display = 'none';
}

function view1(){

// var frm= document.getElementById("FROMDT").value;
//var to=document.getElementById("TODT").value;
//window.location.href = '../jasperrop/generateExcel.jsp?REPNAME=MMELIG&FROMDT='+frm+'&TODT='+to;
window.location.href = '../jasperrop/generateExcel.jsp?REPNAME=MMELIG';
}
function view2(){

 //var frm= document.getElementById("FROMDT").value;
//var to=document.getElementById("TODT").value;
//window.location.href = '../jasperrop/generateExcel.jsp?REPNAME=ValidationRep&FROMDT='+frm+'&TODT='+to;
window.location.href = '../jasperrop/generateExcel.jsp?REPNAME=ValidationRep';
}

</script>

</head>

<body >

<form id="form" name="form" method="post">


<%


String FROMDT=(String) request.getParameter("FROMDT")==null?"":(String) request.getParameter("FROMDT").trim();
String TODT=(String) request.getParameter("TODT")==null?"":(String) request.getParameter("TODT").trim();


  String  APPLICATION_ID="";
  
	%>


<div align="center">
  <input type="hidden" name="ins" id="ins">
  <br>
  <span class="redLebel">PMEGP Geotagging Online (Datewise Api) </span><br>
</div>
<BR>

<table border="1" align="center">
  
  <tr>
    <th colspan="2"><div align="center"></div></th>
  </tr>
  <tr>
   <!-- <th><div align="center">From Date:
      <input name="FROMDT" type="text" id="FROMDT"  onClick="javascript:NewCssCal('FROMDT','yyyyMMdd')" value="<%= FROMDT %>" readonly="" >
    </div></th>
    <th><div align="center">To Date :
      <input name="TODT" type="text" id="TODT" value="<%= TODT %>"  onClick="javascript:NewCssCal('TODT','yyyyMMdd')" readonly="" >
    </div></th>-->
  </tr>
  <tr colspan="2"></tr>
  <tr>
  
  </tr>
  <tr>
   <th> Margin Money GeoApi Report</th>
   <td><div align="center"><input type="button" class="buttonMerun" onClick="view1();" value="View" ></div></td>
   </tr>
   <tr>
   <th>Application Validation report</th>
   <td><div align="center"><input type="button" class="buttonMerun" onClick="view2();" value="View" ></div></td>
  </tr>
</table>


        
</body>
</html>
