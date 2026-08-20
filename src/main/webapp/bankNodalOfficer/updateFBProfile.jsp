<html>
<head>
 <link rel="stylesheet" type="text/css" href="../css/dis.css">

 <script type="text/javascript" src="../js/inlineMsgMain.js"></script>
 <script>
  function form_submit(){  
	var IFSC_CODE = document.form.IFSC_CODE.value;
	if (IFSC_CODE== "") {	 inlineMsg ( 'IFSC_CODE','ENTER IFSC CODE',2);	return (false);}    	
	document.form.submit();

}


</script>

   </head>
   <body>
   
<form method="POST" action="updateProfile.jsp" name="form" id="form">
<%@ include file="IncludeHeader.jsp" %>



<p></p>
<p></p>
<p></p>
<p>&nbsp;</p>
  <p>&nbsp;</p>
  <table width="880" border="1" align="center" bordercolor="#000066" bgcolor="#FFFFFF">

  <tr bgcolor="#FF9966"><th height="58" colspan="4"><div align="center"><%= USER_DESC%>
     
  </div></th>



 <tr>
  <b><th width="359" height="43" align="left" bgcolor="#CCCCCC" nowrap >SEARCH BY IFS CODE* </th>
   
	<td bgcolor="#CCCCCC"><input name="IFSC_CODE" type="text" id="IFSC_CODE"   size="40" maxlength="40"><input name="ins" type="hidden" id="ins" value="">	</td>
   
	
	<tr>
	<th colspan="4"> 

	<input name="Button" type="button" class="button" onClick="form_submit();" value="SEARCH"> </th>                              
	</tr>
		
		



  </table> 
  
 
</form>
  </body>
  </html>

