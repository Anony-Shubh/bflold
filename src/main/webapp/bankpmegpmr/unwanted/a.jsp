<%@ taglib uri="taglib144.tld" prefix="w" %>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="css/indexr.css">
	</head>
<body>
<w:wait>
<w:infoPage>

<table border="4" align="center" cellpadding="2" cellspacing="2">
  <tr>
    <td><div align="center">
      <input type="image" src="img/loading.gif" width="100" height="100" />
    </div></td>
  </tr>
  <tr>
    <td> Page is being loaded, wait please ...</td>
  </tr>
</table>

</w:infoPage>
<w:realPage>
  <jsp:include page="BankRepGenerate.jsp"/>
</w:realPage>
</w:wait> 
</body>
</html>