<%@ page buffer="1000kb" session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%@ include file="menu.jsp"%>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
<link rel="stylesheet" href="css/bootstrap.min.css" /> 
 <SCRIPT language="javascript" src="js/ModalPopupWindow.js"></SCRIPT>
<style type="text/css">
<!--
.style1 {font-weight: bold}

.button {
  background-color: #4CAF50; /* Green */
  border: none;
  color: white;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
}
</style>
</head>

<body>

<div class="container">
<FORM  name="form" id="form" method="post" >

<%
String app_id=(String)session.getAttribute("sAPP_ID");
%>
<table align="center"  width="100%" id="customers" >
<th><center>
  <h1>DATA SUCCESSFULLY SAVED...</h1>
  </center></th></table>
<br />
<table align="center"  width="100%" id="customers" >
<th> <div align="center"><input name="button" type="button" class="button"  onClick="ShowReport('<%=app_id%>')" value="View Report"></div></th></table>

</FORM>
</div>
</body>
	<script>
	 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("images/loading.gif");
 modalWin.SetCloseButtonImagePath("images/remove.gif");
 
	function ShowReport(app_id){
 modalWin.ShowURL('genreport.jsp?REP_NM=CFTRI_report&app_id='+app_id,900,1200,'CFTRI Report',null,null);
 }
 
 function HideModalWindow() {
    modalWin.HideModalPopUp();
}
function EnrollLater(){
modalWin.HideModalPopUp();
}

function refresh_data(){
window.parent.location.reload();
}

function refreshpage(){
window.parent.location.reload();
}

	</script>
<script src="js/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="js/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</html>


