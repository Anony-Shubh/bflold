<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.SQLException"%>

<html>
<head>
<TITLE>Search</TITLE>
<script>

function strtest(){
	
var vindval1=document.lov1.cmbind1.value;
var vsrch=document.lov1.txtSearch.value;
var vinds=document.lov1.cmbind.value;

location.href='./PMEGPlovpage.jsp?cmbind='+vindval1+'&txtsearch='+vsrch+'&catdesc='+"'"+vinds+"'";
}

function strpos(str, ch) 
{
for (var i = 0; i < str.length; i++)
if (str.substring(i, i+1) == ch) return i;
return -1;
}

function pwin()
{
for (var i=0; i < document.lov1.optActCode.length; i++)
 {
   if (document.lov1.optActCode[i].checked)
   {
     opt_val=document.lov1.optActCode[i].value;
   }
 }
 //alert(opt_val);
 
 var inputlength =" "+ opt_val.length;
 //alert(inputlength);
 var opt_pos =strpos(opt_val,"-");
 //alert(opt_pos);
 var str_actdesc=opt_val.substring(opt_pos+1,inputlength);
//alert(str_actdesc);
 var str_actid=opt_val.substring(0,opt_pos);
// alert(str_actid);
  window.parent.document.form.Activity_desc.value=str_actdesc;
  window.parent.document.form.ACTIVITY_CD.value=str_actid;
window.parent.HideModalWindow();
}
</script>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
.style2 {
	font-family: Arial, Helvetica, sans-serif;
	font-weight: bold;
}
body,td,th {
	font-family: Arial, Helvetica, sans-serif;
	color: #0000CC;
	font-size: 14px;
}
body {
	background-color: #FFFFFF;
}
-->
</style>
</head>

<body>
<form action="PMEGPlovpage.jsp" method="post" name="lov1" id="lov1">
  <div align="center">
    <p>
      <% 
 //String vIndDesc = (String) request.getParameter("catdesc" );
 Object vIndDesc = null;
%>
        <span class="style2"><u>List of Values Activity </u></span>
      </h1>
</p>
    <p><strong>Search by Activity Name</strong>: 
      <input name="txtSearch" type="text" id="txtSearch" size="40">
      <input name="Submit" type="submit" onClick="strtest();" value="Find">
    </p>
  </div>
  <center>
  </center>
<div style="border:1px blue solid; width:600px; height:250px; overflow:auto;">

 <input type="hidden" name="cmbind" value=<%=vIndDesc%>>

 <table width="662" height="29"  border="1" align="left" bordercolor="#000099" bgcolor="#FFFFCC" hight=200 >
   <%
 
 String AGENCY=request.getParameter("AGENCY")==null?"":request.getParameter("AGENCY");
 //out.print(AGENCY);
 String vcls="";
 
 if ((AGENCY.equals("KV")) || (AGENCY.equals("DI")) || (AGENCY.equals("KB")))
 {
	 vcls = vcls + " and a.IND_GRP_CD <> 8  " ;
 }
 else{
	 
	  vcls = vcls + " and a.IND_GRP_CD = 8  " ;
 }
 
 
 Object str= null;

ResultSet  rs;
 Object txtSearch=null;
 
 if (request.getParameter("txtSearch") != null){
			txtSearch ="%"+ (String) request.getParameter("txtSearch")+"%";
		}else{
			txtSearch = "%%";
		}
 

   String QueryStr1=" SELECT a.activity_cd, a.activity_name,initCap(b.ind_grp_short_desc),a.activity_name||'('||initcap(b.ind_grp_long_desc)||')' FROM activity_mast a,IND_GRP_MAST b where a.ind_grp_cd=b.ind_grp_cd and STATUS='Y'  and UPPER(activity_name) like  UPPER('"+txtSearch+"') "; 
  //out.print(QueryStr1.toString());
Context ctx=new InitialContext();
 Context envCtx = (Context) ctx.lookup("java:comp/env");
   DataSource ds=(DataSource) envCtx.lookup("jdbc/PMEGPDSNEW");
   Connection conn=ds.getConnection();
   Statement stmt=conn.createStatement();

 rs = stmt.executeQuery(QueryStr1);
 
    while (rs.next()){ 
    %>
   <tr> <input type="hidden" name="agency" id="agency" value="<%=AGENCY%>"/>
     <td colspan="10%"><input type="radio" name="optActCode"  value="<%=rs.getString(1)+"-"+rs.getString(4)%>"/></td>
     <td colspan="72"><%=rs.getString(2)%></td>
	  <td width="165" colspan="72"><%=rs.getString(3)%></td>
   </tr>
   <%}
  
   rs.close();
   conn.close();%>
 </table>
  <input name="optActCode" type="radio" disabled="true"  value="" checked/>
 </div>
      <input type ="hidden" name="cmbind1" value=<%=str%>>
    <center> <input id="OK" name="OK" onClick="pwin();" style="BACKGROUND-COLOR: #000099; BORDER-BOTTOM-COLOR: #000099; BORDER-LEFT-COLOR: #000099; BORDER-RIGHT-COLOR: #000099 BORDER-TOP-COLOR: #000099; COLOR: white; FONT-WEIGHT: bold; HEIGHT: 29px; LEFT: 344px; POSITION: bottom; TOP: 99px; WIDTH: 90px; Z-INDEX: 101"  type="button" value="OK">      
    <input id="CANCEL" name="CANCEL" onClick="self.close();" style="BACKGROUND-COLOR:  #000099; BORDER-BOTTOM-COLOR: #000099; BORDER-LEFT-COLOR: #000099; BORDER-RIGHT-COLOR: #000099; BORDER-TOP-COLOR: #000099; COLOR: white; FONT-WEIGHT: bold; HEIGHT: 29px; LEFT: 452px; POSITION: bottom; TOP: 99px; WIDTH: 90px; Z-INDEX: 101" type="button" value="CANCEL">
    </center>
</form>
</body>
</html>
