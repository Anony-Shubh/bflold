<%@ page buffer="600kb" session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%@ include file="includeHeaderPage.jsp" %>
<SCRIPT language="javascript" src="js/jquery-1.4.2.min.js"></SCRIPT>
    <SCRIPT language="javascript" src="js/ModalPopupWindow.js"></SCRIPT>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
<style>

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
background-color: #3cb0fd;
text-align: center;
color:#000000;

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




.btn {
font-size:15px;
  font-family:Arial;
  width:70px;
  height:20px;
  border-width:1px;
  color:#fff;
  border-color:#d02718;
  font-weight:bold;
  border-top-left-radius:18px;
  border-top-right-radius:18px;
  border-bottom-left-radius:18px;
  border-bottom-right-radius:18px;
  box-shadow: 3px 4px 0px 0px #8a2a21;
  text-shadow: 0px 1px 0px #810e05;
  background:linear-gradient(#c62d1f, #f24437);
}

.btn:hover {
  background: linear-gradient(#f24437, #c62d1f);
}


.btnnew {
  background:linear-gradient(#ffc477, #fb9e25);
  background-image: -webkit-linear-gradient(top, #3498db, #2980b9);
  background-image: -moz-linear-gradient(top, #3498db, #2980b9);
  background-image: -ms-linear-gradient(top, #3498db, #2980b9);
  background-image: -o-linear-gradient(top, #3498db, #2980b9);
  background-image: linear-gradient(to bottom, #3498db, #2980b9);
  -webkit-border-radius: 28;
  -moz-border-radius: 28;
  border-radius: 28px;
  font-family: Arial;
  color: #ffffff;
  font-size: 20px;
  padding: 10px 20px 10px 20px;
  text-decoration: none;
}

.btnnew:hover {
  background: #3cb0fd;
  background-image: -webkit-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -moz-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -ms-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -o-linear-gradient(top, #3cb0fd, #3498db);
  background-image: linear-gradient(to bottom, #3cb0fd, #3498db);
  text-decoration: none;
}

        .marquee {
            height: 50px;
            overflow: hidden;
            position: relative;
            background: #fefefe;
            color: #FF3300;
			font-size:24px;
            border: 1px solid #4a4a4a;
        }
        
        .marquee p {
            position: absolute;
            width: 100%;
            height: 100%;
            margin: 0;
            line-height: 50px;
            text-align: center;
            -moz-transform: translateX(100%);
            -webkit-transform: translateX(100%);
            transform: translateX(100%);
            -moz-animation: scroll-left 2s linear infinite;
            -webkit-animation: scroll-left 2s linear infinite;
            animation: scroll-left 20s linear infinite;
        }
        
        @-moz-keyframes scroll-left {
            0% {
                -moz-transform: translateX(100%);
            }
            100% {
                -moz-transform: translateX(-100%);
            }
        }
        
        @-webkit-keyframes scroll-left {
            0% {
                -webkit-transform: translateX(100%);
            }
            100% {
                -webkit-transform: translateX(-100%);
            }
        }
        
        @keyframes scroll-left {
            0% {
                -moz-transform: translateX(100%);
                -webkit-transform: translateX(100%);
                transform: translateX(100%);
            }
            100% {
                -moz-transform: translateX(-100%);
                -webkit-transform: translateX(-100%);
                transform: translateX(-100%);
            }
        }
</style>
</head>

<body>
  
<%
DBCon db= new DBCon();
db.connect();
List values=new ArrayList();

String username=session.getAttribute("username")==null?"0":(String)session.getAttribute("username");


String app_id=request.getParameter("app_id")==null?"":(String) request.getParameter("app_id");
String app_name=request.getParameter("app_name")==null?"":(String) request.getParameter("app_name");

String iso_cert_yn="";
String gst_cert_yn="";
String udyam_cert_yn="";
String trademark_cert_yn="";
String gem_cert_yn="";
String ecom_cert_yn="";
String state_cd="";
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
String unit_state="";
String DCO_APPROV_YN="";
String APP_APPROV_YN="";
String anl_sales_yr1="2018-19";

String anl_sales_yr2="2019-20";

String anl_sales_yr3="2020-21";

StringBuffer poRR = new StringBuffer();

poRR.append(" SELECT ms.state_cd, ms.state_nm as unit_state,  pa.app_id  AS app_id, pa.final_sub_dt, ad.app_name as unit_name, md.district_name, pa.anl_updoc1, ");
poRR.append(" pa.anl_updoc2, pa.anl_updoc3,pa.iso_updoc, pa.gst_updoc,pa.udyam_updoc, pa.trademark_updoc, pa.gem_updoc,  pa.ecom_updoc, pa.ecom_cert_yn, pa.gem_cert_yn, ");
poRR.append(" pa.trademark_cert_yn, pa.udyam_cert_yn,pa.gst_cert_yn, pa.iso_cert_yn, pa.supply_cert_yn,  pa.supply_updoc, pa.partic_cert_yn, pa.partic_updoc, pa.DCO_APPROV_YN, PA.APP_APPROV_YN ");
poRR.append(" FROM m_district   md,m_state      ms,app_detail   ad, pmegp_award  pa ");
poRR.append(" WHERE md.district_cd = ad.unit_dist_cd AND md.state_cd = ms.state_cd AND ad.app_id = pa.app_id AND pa.app_id = ? ");

/*poRR.append(" select pa.mob_no_n, pa.email_n, pa.unit_name, to_char(pa.est_date,'DD-MON-YYYY') as est_date, pa.anl_sales_amt1, pa.anl_emp1, ");
poRR.append(" pa.ANL_UPDOC1, pa.anl_sales_amt2, pa.anl_emp2, pa.ANL_UPDOC2,  ");
poRR.append(" pa.anl_sales_amt3, pa.anl_emp3, ANL_UPDOC3,  pa.iso_cert_yn, pa.iso_updoc, ");
poRR.append(" pa.gst_cert_yn, pa.gst_updoc,  pa.udyam_cert_yn, pa.udyam_updoc, ");
poRR.append(" pa.trademark_cert_yn, pa.trademark_updoc, pa.gem_cert_yn , pa.gem_updoc, ");
poRR.append(" pa.ecom_cert_yn, pa.ecom_updoc, pa.final_sub_dt, pa.supply_cert_yn, pa.supply_updoc, pa.partic_cert_yn, pa.partic_updoc , pv.unit_state ");
poRR.append(" FROM pmegp_award pa, pmegpaward_view pv ");
poRR.append(" where PA.APP_ID=PV.APP_ID AND PA.app_id=? ");
*/

values.add(app_id);
ResultSet rsMain = db.executeSQL(poRR.toString(),values);



while (rsMain.next()){
state_cd=rsMain.getString("state_cd")==null?"":rsMain.getString("state_cd");
unit_state=rsMain.getString("unit_state")==null?"":rsMain.getString("unit_state");
iso_cert_yn=rsMain.getString("iso_cert_yn")==null?"":rsMain.getString("iso_cert_yn");
gst_cert_yn=rsMain.getString("gst_cert_yn")==null?"":rsMain.getString("gst_cert_yn");
udyam_cert_yn=rsMain.getString("udyam_cert_yn")==null?"":rsMain.getString("udyam_cert_yn");
trademark_cert_yn=rsMain.getString("trademark_cert_yn")==null?"":rsMain.getString("trademark_cert_yn");
gem_cert_yn=rsMain.getString("gem_cert_yn")==null?"":rsMain.getString("gem_cert_yn");
ecom_cert_yn=rsMain.getString("ecom_cert_yn")==null?"":rsMain.getString("ecom_cert_yn");
DCO_APPROV_YN=rsMain.getString("DCO_APPROV_YN")==null?"":rsMain.getString("DCO_APPROV_YN");
//mob_no_n=rsMain.getString("mob_no_n")==null?"":rsMain.getString("mob_no_n");
//email_n=rsMain.getString("email_n")==null?"":rsMain.getString("email_n");
unit_name=rsMain.getString("unit_name")==null?"":rsMain.getString("unit_name");
//est_date=rsMain.getString("est_date")==null?"":rsMain.getString("est_date");
//anl_sales_amt1=rsMain.getString("anl_sales_amt1")==null?"":rsMain.getString("anl_sales_amt1");
//anl_emp1=rsMain.getString("anl_emp1")==null?"":rsMain.getString("anl_emp1");
anl_updoc1=rsMain.getString("anl_updoc1")==null?"":rsMain.getString("anl_updoc1");
//anl_sales_amt2=rsMain.getString("anl_sales_amt2")==null?"":rsMain.getString("anl_sales_amt2");
//anl_emp2=rsMain.getString("anl_emp2")==null?"":rsMain.getString("anl_emp2");
anl_updoc2=rsMain.getString("anl_updoc2")==null?"":rsMain.getString("anl_updoc2");
//anl_sales_amt3=rsMain.getString("anl_sales_amt3")==null?"":rsMain.getString("anl_sales_amt3");
//anl_emp3=rsMain.getString("anl_emp3")==null?"":rsMain.getString("anl_emp3");
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
APP_APPROV_YN=rsMain.getString("APP_APPROV_YN")==null?"":rsMain.getString("APP_APPROV_YN");
}
rsMain.close();

%>

<TABLE align="center" class="pmegpTable">
    <TR>
      <TD colspan="19"><DIV align="center">PMEGP AWARD VIEW DOCUMENTS</DIV></TD>
    </TR>
</TABLE>
<br>
<center>
<a href="GTAppSearchLOV_award.jsp" class="btnnew">Back</a>
<br><br>
<em><strong>Applicant ID : <%= app_id %> Applicant Name: <%= app_name %></strong></em>
</center>
<br>
<table id="container" align="center" border="1" width="50%">
<tr>
  <td width="18%" class="SR" ><div align="center">Financial Year </div></td>
  <td width="29%" class="SR" ><div align="center">2018-19*</div></td>
  <td width="27%" class="SR" ><div align="center">2019-20*</div></td>    
  
    <td width="26%" class="SR" ><div align="center">2020-21*</div></td>
</tr>
<tr>
<td align="center"><div align="center">CA Certificate*</div></td>
<td><div align="center">

 
  <% if((!DCO_APPROV_YN.equals("Y"))||(APP_APPROV_YN.equals("N")) ){ %>

<input type="button" name="Submit" class="button" onClick="upload('A','<%= app_id%>');" value="UPLOAD" />
<%}%>
 <A href="../../../pmegpeportalappdoc/pmegpaward/<%= app_id %>/<%=anl_updoc1%>" target="_blank" class="btn"  id="uploadfile">VIEW</A></div></td>
<td><div align="center">
 <% if((!DCO_APPROV_YN.equals("Y"))||(APP_APPROV_YN.equals("N")) ){ %>
<input type="button" name="Submit" class="button" onClick="upload('B','<%= app_id%>');" value="UPLOAD">
<%}%>
<A href="../../../pmegpeportalappdoc/pmegpaward/<%= app_id %>/<%=anl_updoc2%>" target="_blank" class="btn">VIEW</A></div></td>
<td><div align="center">
 <% if((!DCO_APPROV_YN.equals("Y"))||(APP_APPROV_YN.equals("N")) ){ %>
<input type="button" name="Submit" class="button" onClick="upload('C','<%= app_id %>');" value="UPLOAD" >
<%}%>
<A href="../../../pmegpeportalappdoc/pmegpaward/<%= app_id %>/<%=anl_updoc3%>" target="_blank" class="btn">VIEW</A></div></td></tr></table><br>  

<%if(!iso_cert_yn.equals("N")||!gst_cert_yn.equals("N")||!udyam_cert_yn.equals("N")||!trademark_cert_yn.equals("N")) { %>
<table id="container" align="center" border="1" width="50%">

	<%if(!iso_cert_yn.equals("N")||!gst_cert_yn.equals("N")||!udyam_cert_yn.equals("N")||!trademark_cert_yn.equals("N")) { %>
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
 <% if(iso_cert_yn.equals("Y")) { %>
 <% if((!DCO_APPROV_YN.equals("Y"))||(APP_APPROV_YN.equals("N")) ){ %>
 <input type="button" name="Submit" class="button" onClick="upload('D','<%= app_id %>');" value="UPLOAD" >
 <% } %>
        <% if ((!iso_updoc.equals("") ) ){ %>
        <A href="../../../pmegpeportalappdoc/pmegpaward/<%= app_id %>/<%=iso_updoc%>" target="_blank" class="btn">VIEW</A>
        <% } %>
        <%}%>	
</td><%}%>	
<%if(gst_cert_yn.equals("null")||(!gst_cert_yn.equals("N")) ){ %>
<td align="center">
 <% if(gst_cert_yn.equals("Y")) { %>
   <% if((!DCO_APPROV_YN.equals("Y"))||(APP_APPROV_YN.equals("N")) ){ %>
 <input type="button" name="Submit" class="button" onClick="upload('E','<%= app_id %>');" value="UPLOAD" >
 <% } %>
        <% if ((!gst_updoc.equals("") ) ){ %>
        <A href="../../../pmegpeportalappdoc/pmegpaward/<%= app_id %>/<%=gst_updoc%>" target="_blank" class="btn">VIEW</A>
        <% }%>
        <%}%>
       
      </div></td> <%}%>
 <%if(udyam_cert_yn.equals("null")||(!udyam_cert_yn.equals("N")) ){ %>
<td align="center">
  <% if((!DCO_APPROV_YN.equals("Y"))||(APP_APPROV_YN.equals("N")) ){ %>
 <input type="button" name="Submit" class="button" onClick="upload('F','<%= app_id %>');" value="UPLOAD" >	
  <% } %>
  <% if(udyam_cert_yn.equals("Y")) { %>
        <% if ((!udyam_updoc.equals("") ) ){ %>
        <A href="../../../pmegpeportalappdoc/pmegpaward/<%= app_id %>/<%=udyam_updoc%>" target="_blank" class="btn">VIEW</A>
        <% } %>
        <%}%>
       
      </div></td><%}%>
	  <%if(trademark_cert_yn.equals("null")||(!trademark_cert_yn.equals("N")) ){ %>
<td align="center">
    <% if(trademark_cert_yn.equals("Y")) { %>
	 <% if((!DCO_APPROV_YN.equals("Y"))||(APP_APPROV_YN.equals("N")) ){ %>
	  <input type="button" name="Submit4" class="button" onClick="upload('G','<%= app_id %>');" value="UPLOAD" /> 
	   <% } %>
        <% if ((!trademark_updoc.equals("") ) ){ %>
        <A href="../../../pmegpeportalappdoc/pmegpaward/<%= app_id %>/<%=trademark_updoc%>" target="_blank" class="btn">VIEW</A>
        <% }}%>
      </div></td><%}%>

</tr>
</table>
<%}}%>
<br>   
<%if(!gem_cert_yn.equals("N")||(!ecom_cert_yn.equals("N"))||(!supply_cert_yn.equals("N"))||(!partic_cert_yn.equals("N")) ){ %>
<table id="container" align="center" border="1" width="50%">
  <%if(!gem_cert_yn.equals("N")||(!ecom_cert_yn.equals("N"))||(!supply_cert_yn.equals("N"))||(!partic_cert_yn.equals("N")) ){ %>
  <tr></tr>
  <tr>
    <td  class="SR" colspan="15">Utilization of marketing  channels 
      (local marketing ,procurement & social media)</td>
  </tr>
  <%} %>
  <tr>
    <%if(gem_cert_yn.equals("null")||(!gem_cert_yn.equals("N")) ){ %>
    <td align="center" width="25%"><div align="center">Gem Registration*</div></td>
    <%}%>
    <%if(ecom_cert_yn.equals("null")||(!ecom_cert_yn.equals("N")) ){ %>
    <td width="25%"><div align="center">E-commerce collaboration*</div></td>
    <%}%>
    <%if(supply_cert_yn.equals("null")||(!supply_cert_yn.equals("N")) ){ %>
    <td width="25%"><div align="center">Supply to Government/Public Offices/Corporates*</div></td>
    <%}%>
    <%if(partic_cert_yn.equals("null")||(!partic_cert_yn.equals("N")) ){ %>
    <td width="25%"><div align="center">Participation in national/ local level exhibitions,trade fairs ect.*</div></td>
    <%}%>
  </tr>
  <tr>
    <%if(gem_cert_yn.equals("null")||(!gem_cert_yn.equals("N")) ){ %>
    <td align="center"><% if(gem_cert_yn.equals("Y")) { %>
	 <% if((!DCO_APPROV_YN.equals("Y"))||(APP_APPROV_YN.equals("N")) ){ %>
	<input type="button" name="Submit" class="button" onClick="upload('H','<%= app_id %>');" value="UPLOAD" >
	<% }%>
        <% if ((!gem_updoc.equals("") ) ){ %>
        <a href="../../../pmegpeportalappdoc/pmegpaward/<%= app_id %>/<%=gem_updoc%>" target="_blank" class="btn">VIEW</a>
        <% }%>
        <%}%>
    </td>
    <%}%>
    <%if(ecom_cert_yn.equals("null")||(!ecom_cert_yn.equals("N")) ){ %>
    <td ><div align="center">
      <% if(ecom_cert_yn.equals("Y")) { %>
	   <% if((!DCO_APPROV_YN.equals("Y"))||(APP_APPROV_YN.equals("N")) ){ %>
	  <input type="button" name="Submit2" class="button" onClick="upload('I','<%= app_id %>');" value="UPLOAD" />
	   <%}%>
      <% if ((!ecom_updoc.equals("") ) ){ %>
      <a href="../../../pmegpeportalappdoc/pmegpaward/<%= app_id %>/<%=ecom_updoc%>" target="_blank" class="btn">VIEW</a>
      <% }%>
      <% }%>
    </div></td>
    <%}%>
    <%if(supply_cert_yn.equals("null")||(!supply_cert_yn.equals("N")) ){ %>
    <td align="center"><div align="center">
      <% if(supply_cert_yn.equals("Y")) { %>
	   <% if((!DCO_APPROV_YN.equals("Y"))||(APP_APPROV_YN.equals("N")) ){ %>
	  <input type="button" name="Submit" class="button" onClick="upload('J','<%= app_id %>');" value="UPLOAD" >
	  <% }%>
      <% if ((!supply_updoc.equals("") ) ){ %>
      <a href="../../../pmegpeportalappdoc/pmegpaward/<%= app_id %>/<%=supply_updoc%>" target="_blank" class="btn">VIEW</a>
      <% }%>
      <%}%>
    </div></td>
    <%}%>
    <%if(partic_cert_yn.equals("null")||(!partic_cert_yn.equals("N")) ){ %>
    <td align="center"><div align="center">
      <% if(partic_cert_yn.equals("Y")) { %>
	   <% if((!DCO_APPROV_YN.equals("Y"))||(APP_APPROV_YN.equals("N")) ){ %>
	  <input type="button" name="Submit" class="button" onClick="upload('K','<%= app_id %>');" value="UPLOAD" >
	  <%}%>
      <% if ((!partic_updoc.equals("") ) ){ %>
      <a href="../../../pmegpeportalappdoc/pmegpaward/<%= app_id %>/<%=partic_updoc%>" target="_blank" class="btn">VIEW</a>
      <% }%>
      <%}%>
    </div></td>
    <%}%>
</table>

 <% if(DCO_APPROV_YN.equals("Y")) { %>
  <div class="marquee" align="center">
        <p>Documents cannot be uploaded once Recommended to Approver</p>
    </div>

<%}%>


<%}%>
<%
db.close();

%>

<SCRIPT>

 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 //Uncomment below line to make look buttons as link
 modalWin.SetButtonStyle("background:none;border:none;textDecoration:underline;cursor:pointer");
 

function upload(TYPE,app_id1){
var callbackFunctionArray = new Array(refreshpage);
 modalWin.ShowURL("../pmegpaward/upload_doc.jsp?TYPE="+TYPE+"&app_id1="+app_id1,600,900,'CERTIFICATE',callbackFunctionArray,null);
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

</body>
	
</html>
