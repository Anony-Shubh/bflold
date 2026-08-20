<%@ page session="true" buffer="50kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%
String PRJ_NAME="";
String PRJ_COST="";
String IND_GRP_CD="";
DBCon db= new DBCon();
db.connect();
String vOffType=request.getParameter("OFFTYPE")==null?"KVIC":(String) request.getParameter("OFFTYPE");


ResultSet rsmast = db.execSQL("SELECT upper(cir_sub), to_char(cir_date,'DD-MON-RRRR') as cir_date, kvic_msme, file_nm FROM PMEGPONLINE.circulars WHERE ACT_YN='Y' and kvic_msme like '"+vOffType+"'order by  to_date(cir_date) desc" );
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>PMEGP Circulars</title>
<script src="https://code.jquery.com/jquery-1.12.3.js"></script>
<link href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css">

<script src="https://cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>
<script src="../js/dis.js"></script>
<link rel="stylesheet" type="text/css" href="../css/dis.css">

<style type="text/css">
<!--
.style1 {color: #0000FF}
-->
</style>
<script type="text/javascript">
function Popup(url, title, w, h) {
// Fixes dual-screen position Most browsers Firefox
var dualScreenLeft = window.screenLeft != undefined ? window.screenLeft : screen.left;
var dualScreenTop = window.screenTop != undefined ? window.screenTop : screen.top;
width = window.innerWidth ? window.innerWidth : document.documentElement.clientWidth ? document.documentElement.clientWidth : screen.width;
height = window.innerHeight ? window.innerHeight : document.documentElement.clientHeight ? document.documentElement.clientHeight : screen.height;

var left = ((width / 2) - (w / 2)) + dualScreenLeft;
var top = ((height / 2) - (h / 2)) + dualScreenTop;
var newWindow = window.open(url, title, 'scrollbars=yes, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);

// Puts focus on the newWindow
if (window.focus) {
newWindow.focus();
}
}
</script>
</head>

<body>
<center>
<img src="../images/04_01.png" width="100%" style="border-bottom: 1px solid #003399">
<!--<iframe src="../headerinc.html" width="985" height="150" scrolling="no"></iframe>-->
</center>
<form method = "post"  name="form1">

<div align="center">
  <h2><span class="style1">PMEGP Circulars and Notifications of<%= vOffType %> </span></h2>
</div>
<div align="center"><a href="../pmegphome/index.jsp" class="button">Back</a>

	<!-- <a href="upload_app_doc_puf.jsp?CIR_ID=0" class="greenButtonRound" onClick="javascript:Popup(this.href, 'Upload Document', 800, 350);return (false);">Upload Circular</a>-->
	
	</div>
<table id="example" class="display" cellspacing="0" width="100%">
        <thead>
            <tr bordercolor="#000066" bgcolor="#FFFFFF">
				<th>Sr No </th>
    <th>Circular Subject </th>
    <th>Circular Date</th>
    <th>View</th>               
            </tr>
        </thead>
        <tfoot>
            <tr bordercolor="#000066" bgcolor="#FFFFFF">
                
                <th>Sr No </th>
    <th>Circular Subject </th>
    <th>Circular Date</th>
    <th>View</th>  
            </tr>
        </tfoot>
		        <tbody>	

  <%
  int srno=0;
  while (rsmast.next()) { 
  srno=srno+1;
  %>
   <td nowrap><div align="center">
        <%out.print(srno); %>
   </div></td>
     <td>
       <div align="left">
         <%out.print(rsmast.getObject(1)); %>
       </div></td><td nowrap><div align="center">
           <%out.print(rsmast.getObject(2)); %>
         </div></td>
    <th nowrap><a href="<%out.print(rsmast.getObject(4)); %>" target="_blank">View</a></th>
  </tr>
  <%}
	rsmast.close();
	
	%>
 </tbody>
</table>
</body>
</html>
