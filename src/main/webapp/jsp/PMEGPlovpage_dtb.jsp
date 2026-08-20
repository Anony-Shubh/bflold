<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.SQLException"%>

<html>
<head>
<TITLE>LOV Search</TITLE>

<link rel="stylesheet" type="text/css" href="../css/lov.css" />
<link rel="stylesheet" type="text/css" href="../js/jquery.dataTables.min.css">
<script language="javascript" src="../js/jquery-1.12.0.min.js"></script>
<script language="javascript" src="../js/jquery.dataTables.min.js"></script>

<script>

	$(document).ready(function() {
    $('#example').DataTable( {
	 "deferRender": true
    } );
} );




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

</head>

<body>
<form action="PMEGPlovpage.jsp" method="post" name="lov1" id="lov1">
      <% 
 //String vIndDesc = (String) request.getParameter("catdesc" );
 Object vIndDesc = null;
%>


 <input type="hidden" name="cmbind" value=<%=vIndDesc%>>

  <table id="example" align="center" class="bordered" width="80%">
   <thead>
 <tr>
 <th></th>
<th width="70%">Activity Name</th>
<th width="30%">Activity Type</th>
</tr>
</thead>
 <%
 
 String AGENCY=request.getParameter("AGENCY")==null?"":request.getParameter("AGENCY");
 //out.print("hello"+AGENCY);
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
 

   String QueryStr1=" SELECT a.activity_cd, a.activity_name,initCap(b.ind_grp_short_desc),a.activity_name||'('||initcap(b.ind_grp_long_desc)||')' FROM activity_mast a,IND_GRP_MAST b where a.ind_grp_cd=b.ind_grp_cd and STATUS='Y' "+vcls+" and UPPER(activity_name) like  UPPER('"+txtSearch+"') "; 
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
     <td><input type="radio" name="optActCode"  value="<%=rs.getString(1)+"-"+rs.getString(4)%>"/></td>
     <td><div align="left"><%=rs.getString(2)%></div></td>
	  <td><div align="left"><%=rs.getString(3)%></div></td>
   </tr>
   <%}
  
   rs.close();
   conn.close();%>
 </table>
  <input name="optActCode" type="radio" disabled="true"  value="" checked/>
      <input type ="hidden" name="cmbind1" value=<%=str%>>
    <center> <input id="OK" name="OK" onClick="pwin();" style="BACKGROUND-COLOR: #000099; BORDER-BOTTOM-COLOR: #000099; BORDER-LEFT-COLOR: #000099; BORDER-RIGHT-COLOR: #000099 BORDER-TOP-COLOR: #000099; COLOR: white; FONT-WEIGHT: bold; HEIGHT: 29px; LEFT: 344px; POSITION: bottom; TOP: 99px; WIDTH: 90px; Z-INDEX: 101"  type="button" value="OK">      
   
    </center>
</form>
</body>
</html>
