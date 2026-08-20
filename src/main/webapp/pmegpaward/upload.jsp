<%@ page buffer="1000kb" session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%@ include file="pmegp_menu.jsp"%>
<SCRIPT language="javascript" src="js/jquery-1.4.2.min.js"></SCRIPT>
    <SCRIPT language="javascript" src="js/ModalPopupWindow.js"></SCRIPT>

<head>

<script type="text/javascript">
function isNumberKey(evt){
    var charCode = (evt.which) ? evt.which : evt.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
    return true;
}

</script>
<SCRIPT>

 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("images/loading.gif");
 modalWin.SetCloseButtonImagePath("images/remove.gif");
 //Uncomment below line to make look buttons as link
 modalWin.SetButtonStyle("background:none;border:none;textDecoration:underline;cursor:pointer");
 

function upload(TYPE,app_id1){
var callbackFunctionArray = new Array(refreshpage);
 modalWin.ShowURL("upload_doc.jsp?TYPE="+TYPE+"&app_id1="+app_id1,600,900,'CERTIFICATE',callbackFunctionArray,null);
 } 
 //function ShowNewPage1(app_id1){
//var urlpar='upload.jsp?app_id1='+app_id1;
 //var callbackFunctionArray = new Array(EnrollNow, EnrollLater);
 //modalWin.ShowURL(urlpar,400,900,'User Enrollment',null,callbackFunctionArray);
 //}
 
function EnrollNow(msg){
modalWin.HideModalPopUp();
modalWin.ShowMessage(msg,200,400,'User Information',null,null);
}

function EnrollLater(){
modalWin.HideModalPopUp();
modalWin.ShowMessage(msg,200,400,'User Information',null,null);
}

function HideModalWindow() {
    modalWin.HideModalPopUp();
}

function refreshpage(){
form.submit();
}

 </SCRIPT>



<title>Untitled Document</title>

<SCRIPT language="javascript">
//function refreshpage()
//{
//form.submit();
//}


function submitform(){

	
document.form.ins.value='I';
document.form.submit();


}

</SCRIPT>






<style>
body{background-color:#FAF5EF}
.h1{border-style: inset;}
#container{
   font-family: Arial, Helvetica, sans-serif;s
  border-collapse: collapse;
  width: 85%;
  border-style: inset;
  background-color:#FFFFFF;
}
#container td, #container tr {
  padding:6px;
  font-weight: bold;
  
 
}

#container td:hover, td:active {background-color: #ddd;} 

#container th {
  font-family: Arial black, Helvetica, sans-serif
  font-weight: bold;
  padding: 6px;
  text-align: center;
  border-style: inset;
  background-color: #8B9DC3;
  
}
input[type=text] {
  width: 80%;
  box-sizing: border-box;
}
.button{
  background-color: #3f506e;
  border: none;
  color:#FFFFFF;
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
background-color: #3f506e;
text-align: center;
color:#FFFFFF;

}
.next {
  background-color: #999999;
  color:#000000;
  font-size: 25px;
}

a {
  text-decoration: none;
  display: inline-block;
  padding: 8px 16px;
}



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
.button11 {background-color: #8B9DC3;
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
.button11 {background-color: #8B9DC3;
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
</style>
</head>
<body>

<FORM name="form" id="form" method="post">




<%
DBCon db= new DBCon();
db.connect();
List values=new ArrayList();

String app_id1=request.getParameter("app_id")==null?"":(String) request.getParameter("app_id");
String sAPP_ID=session.getAttribute("sAPP_ID")==null?"0":(String)session.getAttribute("sAPP_ID");

String iso_cert_yn="";
String gst_cert_yn="";
String udyam_cert_yn="";
String trademark_cert_yn="";
String gem_cert_yn="";
String ecom_cert_yn="";
String mob_no_n="";
String email_n="";
String unit_name="";
String est_date="";
String anl_sales_amt1="";
String anl_emp1="";
String anl_updoc1="";
String anl_sales_amt2="";
String anl_emp2="";
String anl_updoc2="";
String anl_sales_amt3="";
String anl_emp3="";
String anl_updoc3="";
String iso_updoc="";
String gst_updoc="";
String udyam_updoc="";
String trademark_updoc="";
String gem_updoc="";
String ecom_updoc="";
String final_sub_dt="";
String supply_cert_yn ="";
String supply_updoc ="";
String partic_cert_yn ="";
String partic_updoc  ="";

String anl_sales_yr1="2018-19";

String anl_sales_yr2="2019-20";

String anl_sales_yr3="2020-21";
//String partic_updoc="";

String add_update="U";
//String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");


StringBuffer poRR = new StringBuffer();

poRR.append(" select mob_no_n, email_n, unit_name, to_char(est_date,'DD-MON-YYYY')est_date, anl_sales_amt1, anl_emp1,");
poRR.append(" ANL_UPDOC1, anl_sales_amt2, anl_emp2, ANL_UPDOC2,  ");
poRR.append(" anl_sales_amt3, anl_emp3, ANL_UPDOC3,  iso_cert_yn, iso_updoc, ");
poRR.append(" gst_cert_yn, gst_updoc,  udyam_cert_yn, udyam_updoc, ");
poRR.append("trademark_cert_yn, trademark_updoc, gem_cert_yn , gem_updoc,");
poRR.append(" ecom_cert_yn, ecom_updoc, final_sub_dt, supply_cert_yn, supply_updoc, partic_cert_yn, partic_updoc from pmegp_award ");
poRR.append(" where app_id=?");

values.add(sAPP_ID);
ResultSet rsMain = db.executeSQL(poRR.toString(),values);



while (rsMain.next()){
iso_cert_yn=rsMain.getString("iso_cert_yn")==null?"":rsMain.getString("iso_cert_yn");
gst_cert_yn=rsMain.getString("gst_cert_yn")==null?"":rsMain.getString("gst_cert_yn");
udyam_cert_yn=rsMain.getString("udyam_cert_yn")==null?"":rsMain.getString("udyam_cert_yn");
trademark_cert_yn=rsMain.getString("trademark_cert_yn")==null?"":rsMain.getString("trademark_cert_yn");
gem_cert_yn=rsMain.getString("gem_cert_yn")==null?"":rsMain.getString("gem_cert_yn");
ecom_cert_yn=rsMain.getString("ecom_cert_yn")==null?"":rsMain.getString("ecom_cert_yn");
mob_no_n=rsMain.getString("mob_no_n")==null?"":rsMain.getString("mob_no_n");
email_n=rsMain.getString("email_n")==null?"":rsMain.getString("email_n");
unit_name=rsMain.getString("unit_name")==null?"":rsMain.getString("unit_name");
est_date=rsMain.getString("est_date")==null?"":rsMain.getString("est_date");
anl_sales_amt1=rsMain.getString("anl_sales_amt1")==null?"":rsMain.getString("anl_sales_amt1");
anl_emp1=rsMain.getString("anl_emp1")==null?"":rsMain.getString("anl_emp1");
anl_updoc1=rsMain.getString("anl_updoc1")==null?"":rsMain.getString("anl_updoc1");
anl_sales_amt2=rsMain.getString("anl_sales_amt2")==null?"":rsMain.getString("anl_sales_amt2");
anl_emp2=rsMain.getString("anl_emp2")==null?"":rsMain.getString("anl_emp2");
anl_updoc2=rsMain.getString("anl_updoc2")==null?"":rsMain.getString("anl_updoc2");
anl_sales_amt3=rsMain.getString("anl_sales_amt3")==null?"":rsMain.getString("anl_sales_amt3");
anl_emp3=rsMain.getString("anl_emp3")==null?"":rsMain.getString("anl_emp3");
anl_updoc3=rsMain.getString("anl_updoc3")==null?"":rsMain.getString("anl_updoc3");
iso_updoc=rsMain.getString("iso_updoc")==null?"":rsMain.getString("iso_updoc");
gst_updoc=rsMain.getString("gst_updoc")==null?"":rsMain.getString("gst_updoc");
udyam_updoc=rsMain.getString("udyam_updoc")==null?"":rsMain.getString("udyam_updoc");
trademark_updoc=rsMain.getString("trademark_updoc")==null?"":rsMain.getString("trademark_updoc");
gem_updoc=rsMain.getString("gem_updoc")==null?"":rsMain.getString("gem_updoc");
ecom_updoc=rsMain.getString("ecom_updoc")==null?"":rsMain.getString("ecom_updoc");
final_sub_dt=rsMain.getString("final_sub_dt")==null?"":rsMain.getString("final_sub_dt");
supply_cert_yn=rsMain.getString("supply_cert_yn")==null?"":rsMain.getString("supply_cert_yn");
supply_updoc=rsMain.getString("supply_updoc")==null?"":rsMain.getString("supply_updoc");
partic_cert_yn=rsMain.getString("partic_cert_yn")==null?"":rsMain.getString("partic_cert_yn");
partic_updoc=rsMain.getString("partic_updoc")==null?"":rsMain.getString("partic_updoc");

}
rsMain.close();

%>



<h1 align="center"><u>Upload Documents</u></h1>

<% if (!anl_sales_amt1.equals("")&!anl_emp1.equals("")&!anl_sales_amt2.equals("")&!anl_emp2.equals("")&&!anl_sales_amt3.equals("")&!anl_emp3.equals("")&!iso_cert_yn.equals("")&!gst_cert_yn.equals("")&!udyam_cert_yn.equals("")&!trademark_cert_yn.equals("")&!gem_cert_yn.equals("")&!ecom_cert_yn.equals("")&!supply_cert_yn.equals("")&!partic_cert_yn.equals("")) { %>
<table id="container" align="center" border="1">

<tr>
  <td width="18%" class="SR" ><div align="center">Financial Year </div></td>
  <td width="29%" class="SR" ><div align="center">2018-19*</div></td>
  <td width="27%" class="SR" ><div align="center">2019-20*</div></td>    
  
    <td width="26%" class="SR" ><div align="center">2020-21*</div></td>
    </tr>

<tr>
  <td align="center"><div align="center">CA Certificate*</div></td>
  <td align="center">  <div align="center">
   <%if (final_sub_dt.equals("") ){%>
    <input type="button" name="Submit" class="button" onClick="upload('A','<%= app_id1%>');" value="UPLOAD" /> 
	 <% }%>
    <% if (!anl_updoc1.equals("") ){ %>
    <A href="../../pmegpeportalappdoc/pmegpaward/<%= sAPP_ID %>/<%=anl_updoc1%>" target="_blank" class="button" id="uploadfile">VIEW</A>

    
    <% }%>
  </div></td>
  <td align="center"> <div align="center">
   <%if (final_sub_dt.equals("") ){%>
  <input type="button" name="Submit" class="button" onClick="upload('B','<%= app_id1%>');" value="UPLOAD"><% }%>
  <% if ((!anl_updoc2.equals("") ) ){ %>
    <A href="../../pmegpeportalappdoc/pmegpaward/<%= sAPP_ID %>/<%=anl_updoc2%>" target="_blank" class="button">VIEW</A>
    <% }%>
  </div></td>
	
	<td align="center"><div align="center">
	 <%if (final_sub_dt.equals("") ){%>
  <input type="button" name="Submit" class="button" onClick="upload('C','<%= app_id1 %>');" value="UPLOAD" ><% }%>
  <% if ((!anl_updoc3.equals("") ) ){ %>
	  <A href="../../pmegpeportalappdoc/pmegpaward/<%= sAPP_ID %>/<%=anl_updoc3%>" target="_blank" class="button">VIEW</A>
	  <% } %>	
	  </div></td>
	</tr>
</table>

<br>
<%if(!iso_cert_yn.equals("N")||!gst_cert_yn.equals("N")||!udyam_cert_yn.equals("N")||!trademark_cert_yn.equals("N")) { %>
<table id="container" align="center" border="1">

	<%if(!iso_cert_yn.equals("N")||!gst_cert_yn.equals("N")||!udyam_cert_yn.equals("N")||!trademark_cert_yn.equals("N")) { %>
	<tr></tr>
<tr>    
   <td class="SR" align="center" colspan="15">Standardization/Trademark/Quality Certification</td>
</tr>


<tr>
<%if((!iso_cert_yn.equals("N")) ){ %>
  <td align="center" width="25%" > <div align="center">ISO Certification*</div></td>  <%}%>	

<%if(gst_cert_yn.equals("null")||(!gst_cert_yn.equals("N")) ){ %>
  <td align="center" width="25%"><div align="center">GST Registration*</div></td>  <%}%>	

 <%if(udyam_cert_yn.equals("null")||(!udyam_cert_yn.equals("N")) ){ %>
  <td width="25%"><div align="center">Udyam/UAM Registration*</div></td>  <%}%>	

 <%if(trademark_cert_yn.equals("null")||(!trademark_cert_yn.equals("N")) ){ %>
  <td width="25%"><div align="center">Trademark Registration*</div></td>  <%}%>	

</tr>
<tr>
<%if((!iso_cert_yn.equals("N")) ){ %>
  <td align="center">
  
  
  
  
    <div align="center">
      
       <%if (final_sub_dt.equals("") ){%>
         <input type="button" name="Submit" class="button" onClick="upload('D','<%= app_id1 %>');" value="UPLOAD" >
       <% } %>
          <% if(iso_cert_yn.equals("Y")) { %>
        <% if ((!iso_updoc.equals("") ) ){ %>
        <A href="../../pmegpeportalappdoc/pmegpaward/<%= sAPP_ID %>/<%=iso_updoc%>" target="_blank" class="button">VIEW</A>
        <% } %>
        <%}%>	
      
      </div></td>  <%}%>	
	  
<%if(gst_cert_yn.equals("null")||(!gst_cert_yn.equals("N")) ){ %>	  
  <td align="center">
    <div align="center">
       <%if (final_sub_dt.equals("") ){%>
        <input type="button" name="Submit" class="button" onClick="upload('E','<%= app_id1 %>');" value="UPLOAD" >
       <%}%>	
        <% if(gst_cert_yn.equals("Y")) { %>
        <% if ((!gst_updoc.equals("") ) ){ %>
        <A href="../../pmegpeportalappdoc/pmegpaward/<%= sAPP_ID %>/<%=gst_updoc%>" target="_blank" class="button">VIEW</A>
        <% }%>
        <%}%>
       
      </div></td> <%}%>	
	  
 <%if(udyam_cert_yn.equals("null")||(!udyam_cert_yn.equals("N")) ){ %>
  <td>	 
    <div align="center">
       <%if (final_sub_dt.equals("") ){%>
          <input type="button" name="Submit" class="button" onClick="upload('F','<%= app_id1 %>');" value="UPLOAD" >	
		   <%}%>
        <% if(udyam_cert_yn.equals("Y")) { %>
        <% if ((!udyam_updoc.equals("") ) ){ %>
        <A href="../../pmegpeportalappdoc/pmegpaward/<%= sAPP_ID %>/<%=udyam_updoc%>" target="_blank" class="button">VIEW</A>
        <% } %>
        <%}%>
       
      </div></td> <%}%>
 
  <%if(trademark_cert_yn.equals("null")||(!trademark_cert_yn.equals("N")) ){ %>
  <td>
    <div align="center">
	<%if (final_sub_dt.equals("") ){%>
          <input type="button" name="Submit4" class="button" onClick="upload('G','<%= app_id1 %>');" value="UPLOAD" /> 
		    <%}%>
        <% if(trademark_cert_yn.equals("Y")) { %>
        <% if ((!trademark_updoc.equals("") ) ){ %>
        <A href="../../pmegpeportalappdoc/pmegpaward/<%= sAPP_ID %>/<%=trademark_updoc%>" target="_blank" class="button">VIEW</A>
        <% }}%>
      </div></td><%}%>
</tr>
</table>
<%}}%>
<br>

<%if(!gem_cert_yn.equals("N")||(!ecom_cert_yn.equals("N"))||(!supply_cert_yn.equals("N"))||(!partic_cert_yn.equals("N")) ){ %>
<table id="container" align="center" border="1">


<%if(!gem_cert_yn.equals("N")||(!ecom_cert_yn.equals("N"))||(!supply_cert_yn.equals("N"))||(!partic_cert_yn.equals("N")) ){ %>
<tr></tr>

<tr>
  
  
    <td  class="SR" colspan="15">Utilization of marketing  channels 
(local marketing ,procurement & social media)</td>
</tr><%} %>

<tr>
 <%if(gem_cert_yn.equals("null")||(!gem_cert_yn.equals("N")) ){ %>
  <td align="center" width="25%"><div align="center">Gem Registration*</div></td><%}%>
  <%if(ecom_cert_yn.equals("null")||(!ecom_cert_yn.equals("N")) ){ %>	
  <td width="25%"><div align="center">E-commerce collaboration*</div></td><%}%>
  <%if(supply_cert_yn.equals("null")||(!supply_cert_yn.equals("N")) ){ %>
  <td width="25%"><div align="center">Supply to Government/Public Offices/Corporates*</div></td><%}%>
  <%if(partic_cert_yn.equals("null")||(!partic_cert_yn.equals("N")) ){ %>
  <td width="25%"><div align="center">Participation in national/ local level exhibitions,trade fairs ect.*</div></td><%}%>
</tr>

<tr>
   <%if(gem_cert_yn.equals("null")||(!gem_cert_yn.equals("N")) ){ %>
  <td align="center">
    <div align="center">
	<%if (final_sub_dt.equals("") ){%>
        <input type="button" name="Submit" class="button" onClick="upload('H','<%= app_id1 %>');" value="UPLOAD" >
		 <% }%>
        <% if(gem_cert_yn.equals("Y")) { %>
        <% if ((!gem_updoc.equals("") ) ){ %>
        <A href="../../pmegpeportalappdoc/pmegpaward/<%= sAPP_ID %>/<%=gem_updoc%>" target="_blank" class="button">VIEW</A>
        <% }%>
      
        <%}%>
      
    </div></td>  <%}%>  
	
  <%if(ecom_cert_yn.equals("null")||(!ecom_cert_yn.equals("N")) ){ %>	
  <td >
  
    <div align="center">
	<%if (final_sub_dt.equals("") ){%>
        <input type="button" name="Submit2" class="button" onClick="upload('I','<%= app_id1 %>');" value="UPLOAD" />
		<% }%>
        <% if(ecom_cert_yn.equals("Y")) { %>
        <% if ((!ecom_updoc.equals("") ) ){ %>
        <A href="../../pmegpeportalappdoc/pmegpaward/<%= sAPP_ID %>/<%=ecom_updoc%>" target="_blank" class="button">VIEW</A>
        <% }%>
		 <% }%>  
      </div></td><%}%> 
	  
	  
   <%if(supply_cert_yn.equals("null")||(!supply_cert_yn.equals("N")) ){ %>
	  	 <td align="center">
 
    <div align="center">
	<%if (final_sub_dt.equals("") ){%>
        <input type="button" name="Submit" class="button" onClick="upload('J','<%= app_id1 %>');" value="UPLOAD" >
		 <% }%>  
        <% if(supply_cert_yn.equals("Y")) { %>
        <% if ((!supply_updoc.equals("") ) ){ %>
        <A href="../../pmegpeportalappdoc/pmegpaward/<%= sAPP_ID %>/<%=supply_updoc%>" target="_blank" class="button">VIEW</A>
        <% }%>
      
        <%}%>
       
    </div></td> <%}%>  
	<%if(partic_cert_yn.equals("null")||(!partic_cert_yn.equals("N")) ){ %>
	   <td align="center">
    <div align="center">
      
      <%if (final_sub_dt.equals("") ){%>
        <input type="button" name="Submit" class="button" onClick="upload('K','<%= app_id1 %>');" value="UPLOAD" >
		 <%}%>
        <% if(partic_cert_yn.equals("Y")) { %>
        <% if ((!partic_updoc.equals("") ) ){ %>
        <A href="../../pmegpeportalappdoc/pmegpaward/<%= sAPP_ID %>/<%=partic_updoc%>" target="_blank" class="button">VIEW</A>
        <% }%>
      
        <%}%>
    </div></td><%}%>

</tr>
</table>
<%}%>
<%}%>
</FORM>
<%
db.close();

%>	
 



</FORM>

</BODY>
</HTML>





