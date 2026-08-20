<HTML>
<HEAD>
<TITLE></TITLE>

<style>
#container{
  font-family: Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 100%;
}
#container td, #container tr {
  padding:6px;
  border: 1px solid #221F1F;
 
}

#container tr:hover, #container tr:active {text-decoration: underline; background-color: #ddd;} 

#container th {
  padding: 12px;
  text-align: center;
  background-color: #8B9DC3;
  
}
input[type=text] {
  width: 85%;
  box-sizing: border-box;
}
.button{
  background-color: #8B9DC3;
  border: none;
  color: black;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
  border: 1px solid #221F1F;
}
.SR {
border: 1px solid #221F1F;
background-color: #8B9DC3;
text-align: center;

}

</style>


<SCRIPT language="javascript">

function refresh_close(){
//opener.location.reload();
//self.close();
window.parent.refreshpage();
}
</SCRIPT>

<style type="text/css">
<!--
.button1 {  background-color: #8B9DC3;
  border: none;
  color: black;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
  border: 1px solid #221F1F;
}
-->
</style>
</HEAD>
<BODY>
<BR>


<table width="50%" align="center" id="container">
<tr>
<th height="60"  align="center">
SUCESSFULLY UPLOADED..... </DIV>
   <DIV align="center"></th></tr>
   <BR>
   <BR>
   <tr>
     <td height="155"><div align="center">
       <input name="ok" type="submit" class="button1"onClick="refresh_close();" value="Close" />
     </DIV></td></tr>
</table>


 
</BODY>
</HTML>