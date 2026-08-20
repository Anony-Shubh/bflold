<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*,pkgPmegpNew.DBCon"%>

<!-- saved from url=(0039)http://kvicnetold/pmegpeportal/pmegpmr/ -->
<html><head><meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>PMEGP e-Tracking Monitoring Report </title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<link rel="stylesheet" type="text/css" href="../css/DASHBOARD.css" />

<script type="text/javascript" src="../js/inlineMsgMain.js"></script>

<script language="JavaScript">
function validatePwd() {
var vusr = document.form1.usr.value;
var vpw = document.form1.pwd.value;
  if (vusr == '' || vpw == '') {
    alert('username or password should not be blank');
    return false;
    }
}
</script>

<style type="text/css">
<!--
.style1 {color: #FF0000}
.style2 {color: #FFFFFF}
.style4 {color: #FFFFFF; font-size: 18px; }
-->
</style>
<link href="../css/dashboard.CSS" rel="stylesheet" type="text/css">

<style type="text/css">
.style6 {font-family: "Times New Roman", Times, serif}
.style7 {
	font-size: 36px;
	font-family: "Times New Roman", Times, serif;
}
.style8 {font-size: 16px}
.style9 {font-size: 14px}
.style11 {font-size: 36px; color: #FFFFFF; font-family: "Times New Roman", Times, serif; }
</style>
</head>

<body>
 <form name="form1" method="Post">
 
   <table align="center">
     <tbody>
       <tr>
         <th colspan="11"><img src="../images/pmegponlineN.jpg"></th>
       </tr>
       <tr>
         <td colspan="4"><center>
           <img src="../images/eportal.png" align="middle">
         </center></td>
       </tr>
       <tr>
         <td width="331" height="184"><div class="rcorners1"> 
           <div align="center"><span class="style11" id="ContentPlaceHolder1_lblSSI">1563974</span>
           </div>
           <p align="center" class="style4 style8">Applications Received</p>
           
                           <div>
                             <div align="center"><a href="" class="style2" >More info  </a><img src="../images/arrowN.jpg"</div>
                           </div>
         </div></td>
         <td width="331"><div class="rcorners2"> 
           <div align="center"><span class="style2 style7" id="ContentPlaceHolder1_lblEM">2196902</span>
           </div>
           <p align="center" class="style4 style8">Approved by DLTFC</p>
         
                           <div align="center"><a href="" class="style2" >More info  </a><img src="../images/arrowN.jpg" </div>
         </div></td>
         <td width="331"><div class="rcorners3"> 
           <div align="center"><span class="style11" id="ContentPlaceHolder1_lblSSI">1563974</span>
           </div>
           <p align="center" class="style4 style8">Forwarded to Bank</p>
         
                           <div align="center"><a href="" class="style2" >More info  </a><img src="../images/arrowN.jpg" </div>
         </div></td>
         <td width="339"><div class="rcorners4"> 
           <div align="center"><span class="style11" id="ContentPlaceHolder1_lblTotal">4759605</span>
           </div>
           <p align="center" class="style4 style8">Sanctioned By Bank</p>
         
                 <div align="center"><a href="" class="style2" >More info </a><img src="../images/arrowN.jpg" </div>
         </div></td>
       </tr> 
	  
   </tbody>
   </table>
 
   <table border="1" align="center" cellpadding="10" cellspacing="0" bordercolor="#00FFFF" width="1406">
   <tbody><tr>
     <td colspan="4"></td>
   </tr>
   <tr>
     <td colspan="4"><div align="center">
	 <h1>
	 
 
	 
	 
	 PMEGP ePORTAL MIS REPORTING LOGIN FORM 
	 </h1>
	 </div></td>
    </tr>
   <tr>
     <td colspan="2"><table align="center" cellpadding="5" cellspacing="5">
       <tbody><tr>
         <th colspan="2" nowrap="">Login for MSME/KVIC/KVIB/DIC/HO</th>
       </tr>
       <tr>
         <th>User Name: </th>
         <th><div align="left">
           <input name="usr" type="text" id="usr" tabindex="1" size="15" maxlength="10">
         </div></th>
       </tr>
       <tr>
         <th>Password:</th>
         <th><div align="left">
           <input name="pwd" type="password" id="pwd" tabindex="2" size="15" maxlength="10">         
         </div></th>
       </tr>
       <tr>
         <th colspan="2"><div align="center"><span class="style6">
             <input name="btnLogIn" type="submit" class="button" id="btnLogIn" tabindex="3" onClick="validatePwd()" value=" Login">
         </span></div></th>
       </tr>
     </tbody></table></td>
    
     <td colspan="2"><table align="center" cellpadding="5" cellspacing="5">
       <tbody><tr>
         <th colspan="2">Login for Bank User </th>
       </tr>
       <tr>
         <th>User Name </th>
         <th><div align="left">
           <input name="usrbank" type="text" id="usrbank" tabindex="4" size="15" maxlength="10">
         </div></th>
       </tr>
       <tr>
         <th>Password</th>
         <th><div align="left">
           <input name="pwdbank" type="password" id="pwdbank" tabindex="5" size="15" maxlength="10">         
         </div></th>
       </tr>
       <tr>
         <th colspan="2"><div align="center"><span class="style6">
             <input name="btnLogIn" type="submit" class="button" id="btnLogIn" tabindex="6" onClick="validatePwd()" value="Bank Login">
         </span></div></th>
       </tr>
     </tbody></table></td>
   </tr>
  
   
   <tr>
     <th colspan="4" nowrap=""><div align="center">Designed and Developed by Directorate of Information Technology(DIT),KVIC,Mumbai </div></th>
    </tr>
 </tbody></table>
 </form>





</body></html>