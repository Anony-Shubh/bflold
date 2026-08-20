<html>
<head>
<%
String FromDt=(String) request.getParameter("FROMDT");
String ToDt=(String) request.getParameter("TODT");
%>
<script type="text/javascript">
var auto_refresh = setInterval(
function ()
{
fillinbox('pmegpBankLiveUpdate.jsp');
//$('#load_tweets').load('summarise_bankupdate.jsp').fadeIn("slow");
}, 10000); // refresh every 10000 milliseconds
</script>
<title>PMEGP BANK LIVE UPDATE</title>
</head>
<body>
<form method="post">
<div id="load_tweets">
<input name="FROMDT" type="text" value="<%=FromDt  %>">
<input name="TODT" type="text" value="<%=ToDt  %>">
Please wait.... Live update will display
</div>
</form>
</body>
</html>
