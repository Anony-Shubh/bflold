<%@ page contentType="text/html; charset=iso-8859-1" buffer="100kb" language="java"  import="javax.naming.*,java.sql.*,javax.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>GRIVANCES REPORT</title>
<link rel="stylesheet" type="text/css" href="../css/lov.css" />
<script src="../js/inlineMsgMain.js"></script>

  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>

  <script>
 
  </script>
  <script>
  
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


   $(document).ready(function() {
 
todaydt();
            //option A
            $("form").submit(function(e){
			if (document.form.ins !='I'){
               e.preventDefault(e);
			   showProduct();
			   }
            });
        });
 
  var dtRegex = new RegExp("^([0]?[1-9]|[1-2]\\d|3[0-1])-(JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC)-[1-2]\\d{3}$", 'i');
 


    function view()
  {
	  
  var frm= document.getElementById("OFF_TYPE_CD").value;
  var toDT=document.getElementById("STATE").value;
  //var GRV_TYPE=document.getElementById("GRV_TYPE").value;
   if (frm == "") {
  inlineMsg('OFF_TYPE_CD',"PLEASE SELECT EDP CENTER TYPE",2);
    return false;
   }
  
   if (toDT == "") {
  inlineMsg('STATE',"PLEASE SELECT STATE",2);
    return false;
 
  }
window.location.href = 'edpRepGenerate.jsp?REPNM=EDPTRAINING&STATE='+toDT+'&OFFTYPE='+frm;
}

 
 
  
  
  </script>
<style type="text/css">
<!--
.style6 {color: #990000}
-->
</style>
</head>

<body>



<p>
  <%
String STATE="";
String OFF_TYPE_CD="";
String FROMDT="";
String TODT="";
 DBCon db= new DBCon();
 db.connect();
 ResultSet rsState=db.execSQL(" SELECT MS.STATE_CD,MS.STATE_NM FROM M_STATE MS  ORDER BY MS.STATE_NM ");
%>
</p>
  <%@include file="AppIncludePage.jsp"%><BR/>
<table  border="1" cellpadding="3" cellspacing="3" class="bordered" align="center">
  <tr>
    <td><div align="center">EDP CENTER TYPE* </div></td>
    <td><div align="center">
     <select name="OFF_TYPE_CD"  id="OFF_TYPE_CD">
        
  <option value="ALL">ALL</option>
      <% 
	   String vOFF_TYPE_CD = "";
		  String vOFF_TYPE_LONG_DESC= "";
  
          ResultSet rsUp= db.execSQL("SELECT OFF_TYPE_CD ,OFF_TYPE_LONG_DESC FROM MAS_OFF_TYPE_CDMAST WHERE OFF_TYPE_CD IN (26,17,18,19,28,29,30,31,32,33,34)");
		 
		  while (rsUp.next()){
	      vOFF_TYPE_CD =rsUp.getString("OFF_TYPE_CD")==null?"":rsUp.getString("OFF_TYPE_CD");
		  vOFF_TYPE_LONG_DESC =rsUp.getString("OFF_TYPE_LONG_DESC")==null?"":rsUp.getString("OFF_TYPE_LONG_DESC");
		 
  %>
     <option value="<%=vOFF_TYPE_CD %>" <% if (vOFF_TYPE_CD.equals(OFF_TYPE_CD)){out.print("selected");} %>><%= vOFF_TYPE_LONG_DESC%></option>
<% }
rsUp.close();
%>
     </select>
    </div></td>
    <td><div align="center">STATE*</div></td>
    <td><div align="center">
      <select name="STATE" id="STATE">
 <option value="ALL">ALL</option>			   
		<%
	   String sn="";
	   String sn1="";
	   while (rsState.next()) {
	   sn1=rsState.getString(1);	
	   sn=rsState.getString(2);	   
	    %>
        <option value="<%=sn1 %>" <% if (sn.equals(STATE)){ out.print("selected");}%>><%= sn %></option>
		<%
	   }
		rsState.close();
		%>		  
      </select>
	        </div></td>
   
  </tr>
</table>
<br>
<p align="center">REPORTS MENU</p>
<table  width="50%" border="1" cellpadding="3" cellspacing="3" class="bordered" align="center">
  <tr bordercolor="#FFFFFF">
    <td colspan="2"><div align="center"><span class="style6">Select dates for (*)Marked Fields</span></div></td>
  </tr>
  
  <tr bordercolor="#FFFFFF">
    <th>1) EDP TRaining Center Report</th>
    <th><div align="center"><input type="button" class="button"  onClick="view();" value="View" > </div>    </th>
  </tr>
  
 
</table>


</body>
</html>
