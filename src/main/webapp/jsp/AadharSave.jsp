
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Save Message</title>

<script language="javascript">
function closeAndRefresh(){
   window.parent.refreshpage();  
    }
</script>
<style>

#display-error
{
width: 800px;
border: 1px solid #D8D8D8;
padding: 5px;
border-radius: 5px;
font-family: Arial;
font-size: 18px;
text-transform: uppercase;
background-color: rgb(255, 249, 242);
color: rgb(211, 0, 0);
text-align: center;
}
 
img
{
max-width: 40%; 
float: left;
}
 
#display-success
{
width: 800px;
border: 1px solid #D8D8D8;
padding: 10px;
border-radius: 5px;
font-family: Arial;
font-size: 18px;
text-transform: uppercase;
background-color: rgb(236, 255, 216);
color: green;
text-align: center;
margin-top: 30px;
}
 
#display-success img
{
position: relative;
bottom: 5px;
}
</style>
</head>
<body>

<form>
<p>&nbsp;</p>
<TABLE  border="1" align="center" id="container">
<TR>
<th height="66"><DIV align="center" ><br/><br/><br/><div id="display-success" align="center"><img src="../images/correct.png" alt="Success"  width="35px"/> Successfully Verified from UIDAI Server.........</div></DIV></th></TR>
   <DIV align="center">
   <BR>
   <BR>
    <tr>
    <td><div align="center">
    <input name="Button" type="button" class="button" onClick="closeAndRefresh();" value="Close"/></a>
    </div></td>
    </tr>
</DIV>

</TABLE>


<p>&nbsp;</p>
<p>&nbsp;</p>
</form>
</body>
</html>


