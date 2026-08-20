<%@ page session="true" buffer="1000kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon,java.math.*"   %>


<HTML>
<HEAD>
    <%
    response.setHeader("Cache-Control", "no-cache");
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
    %>

    <TITLE>upload </TITLE>

<SCRIPT language="javascript">

	
	
function submit_form() {
	document.form.ins.value='I';
	document.form.submit();
	
}

</SCRIPT>
<%@ include file="pmegp_menu.jsp"%>
<style type="text/css">
body{background-color:#FAF5EF}
.h1{border-style: inset;}
#container{
  font-family: Arial, Helvetica, sans-serif;
  width: 85%;
  background-color:#FFFFFF;
  border-style: inset;
  border-collapse: collapse;
  
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
<!--

-->
</style>
<BODY>
<FORM method="post" name="form" id="form"  >

<%

List values=new ArrayList();
List pstm=new ArrayList();

String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");

String FINAL_SUB_DT="";

String add_update="I";
String app_id1="KVTN16176970-1222110";
//String app_id=request.getParameter("app_id")==null?"":(String) request.getParameter("app_id");

String app_name= "";

StringBuffer poR = new StringBuffer();


poR.append(" select mob_no_n, email_n, unit_name,est_date,anl_sales_amt1, anl_emp1, ANL_UPDOC1, anl_sales_amt2, anl_emp2, ANL_UPDOC2,  ");
poR.append(" anl_sales_amt3, anl_emp3, ANL_UPDOC3, decode(iso_cert_yn,'Y','YES','N','NO')AS iso_cert_yn, iso_updoc,  gst_updoc,   "); 
poR.append(" udyam_updoc ,decode(gst_cert_yn,'Y','YES','N','NO') gst_cert_yn ,decode(udyam_cert_yn,'Y','YES','N','NO') udyam_cert_yn ,");
poR.append(" decode(trademark_cert_yn,'Y','YES','N','NO') trademark_cert_yn, trademark_updoc, decode(gem_cert_yn,'Y','YES','N','NO') gem_cert_yn ,gem_updoc,");
poR.append("  decode(ecom_cert_yn,'Y','YES','N','NO')ecom_cert_yn, ecom_updoc from pmegp_award ");
poR.append(" where app_id='KVTN16176970-1222110'");

ResultSet rsMain = db.execSQL(poR.toString());

while (rsMain.next()){

iso_cert_yn=rsMain.getString("iso_cert_yn")==null?"":rsMain.getString("iso_cert_yn");
gst_cert_yn=rsMain.getString("gst_cert_yn")==null?"":rsMain.getString("gst_cert_yn");
udyam_cert_yn=rsMain.getString("udyam_cert_yn")==null?"":rsMain.getString("udyam_cert_yn");
trademark_cert_yn=rsMain.getString("trademark_cert_yn")==null?"":rsMain.getString("trademark_cert_yn");
gem_cert_yn=rsMain.getString("gem_cert_yn")==null?"":rsMain.getString("gem_cert_yn");
ecom_cert_yn=rsMain.getString("ecom_cert_yn")==null?"":rsMain.getString("ecom_cert_yn");


}
rsMain.close();

%>
<h1></h1>
<table id="container"  >
  <tr>
    <th colspan="9"><h2 align="center">Verify Data</h2></th>
  </tr>
  <tr>
  <tr>
    <td  align="center">1)
    <td width="475"><strong>Applicant ID</strong>: <%=app_id %></td>
    <td width="109"><div align="center">2) 
    <td colspan="3" ><strong>Applicant Name:</strong><%=unit_name %></td>
  </tr>
  <tr>
    <td  align="center">3)
    <td width="475"><strong>Mobile Number</strong>:<%= mob_no_n %></td>
    <td width="109"><div align="center">4)
    <td colspan="3"><strong>Email ID:</strong><%= email_n %></td>
  </tr>
  <tr>
    <td  align="center">5)
    <td colspan="2"><strong>Unit Establishment Date</strong>: <%= est_date %></td>
  </tr>
  <tr>
    <td align="center">6)</td>
    <td colspan="16"><strong>Annual  Sales Turnover/Employment Generated:</strong></td>
  </tr>
  <tr>
    <th >Sr No.</th>
    <th width="261" >Year</th>
    <th  colspan="2">Annual Sales Turnover (In Rs.)*:</th>
    <th colspan="2" >Employment Generation*:</th>
  </tr>
  <tr>
    <td align="center">1)</td>
    <td align="center">2018-19*</td>
    <td align="center" colspan="2"><%=anl_sales_amt1%>
    <td align="center" colspan="2"><%=anl_emp1%> 
  </tr>
  <tr>
    <td align="center">2)</td>
    <td align="center">2019-20*</td>
    <td  align="center" colspan="2" ><%=anl_sales_amt2%></td>
    <td  align="center" colspan="2"><%=anl_emp2%></td>
  </tr>
  <tr>
    <td align="center">3)</td>
    <td align="center">2020-21*</td>
    <td  align="center" colspan="2"><%=anl_sales_amt3%>
    <td align="center" colspan="2"><%=anl_emp3%> 
  </tr>
  <tr>
    <td align="center">7)</td>
    <td colspan="14"><strong>Standardization/Trademark/Quality Certification:</strong></td>
  </tr>
  <tr>
    <th class="SR" >Sr No.</th>
    <th class="SR" colspan="2" >Certificates</th>
    <th class="SR" colspan="4"></th>
  </tr>
  <tr>
    <td align="center">1)</td>
    <td colspan="2">ISO /Standard Certification*: </td>
    <td align="center" colspan="3"><%=iso_cert_yn%> </td>
  </tr>
  <tr>
    <td align="center">2)</td>
    <td colspan="2">GST Registration*:</td>
    <td align="center" colspan="3"><%=gst_cert_yn%> </td>
  </tr>
  <tr>
    <td align="center">3)</td>
    <td colspan="2">Udyam Registration*: </td>
    <td align="center" colspan="3"><%=udyam_cert_yn%> </td>
  </tr>
  <tr>
    <td align="center">3)</td>
    <td colspan="2">Trademark Registration*: </td>
    <td align="center" colspan="4"><%=trademark_cert_yn%> 
  </tr>
  <tr>
    <td align="center">8)</td>
    <td colspan="14"><strong>Utilization of marketing  channels 
      (local marketing ,procurement & social media)*:</strong></td>
  </tr>
  <tr>
    <th  >Sr No.</th>
    <th colspan="2" >Certificates
    <th colspan="4"></th>
  </tr>
  <tr>
    <td align="center">1)</td>
    <td colspan="2">Gem/ CPP Registration*: </td>
    <td align="center" colspan="4"><%=gem_cert_yn%> </td>
  </tr>
  <tr>
    <td align="center">2)</td>
    <td colspan="2">E-commerce collaboration*: </td>
    <td align="center" colspan="4"><%=ecom_cert_yn%> </td>
  </tr>
  <tr>
</table>
</form>
<div><input type="button"  name="Forwarded To Bank" class="button" id="Forwarded To Bank" value="Forwarded To Bank"></div>
</BODY>
</HEAD>
</HTML>