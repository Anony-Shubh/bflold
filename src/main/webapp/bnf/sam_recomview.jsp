<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="pkgPmegpNew.DBCon"%>

<HTML>
<HEAD> 
<meta name="viewport" content="width=device-width, initial-scale=1">
<SCRIPT language="javascript" src="../js/sweetalert.min.js"></SCRIPT>
<script src="../js/ModalPopupWindow.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.2/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap4.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<SCRIPT language="javascript" src="https://code.jquery.com/jquery-3.7.0.js"></SCRIPT>
 <SCRIPT language="javascript" src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></SCRIPT>
 <SCRIPT language="javascript"src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap4.min.js"></SCRIPT>
      <LINK rel="stylesheet" type="text/css" href="main1.css">

<script>

$(document).ready(function() {
             $('#example').DataTable(); 
         } );
		 
        function submitform(){
         document.form.submit();
         }
		 
		 
		 function viewR()
  {

  var MONTH_DT= document.getElementById("MONTH_DT").value;
if(MONTH_DT == "") {
	  
  swal ( 'Note:','Please Select Month','error');	
    return false;
  }
//  alert("hello");
window.location.href = 'jasperReports/GenerateXLS.jsp?REPNM=samrecomamount&MONTH_DT='+MONTH_DT;
} 
		 
		 
      </SCRIPT>
	  <style>
.class{
background-color:#2e823c;
color: white;
}
</style>
	  
</HEAD>
	
<body>

<form method="post"  name="form" id="form" onLoad="changetype()">
 
<%@include file = "sessionoutinc.jsp" %>
 
	  
        <%
String MONTH_DT=request.getParameter("MONTH_DT")==null?"":(String)request.getParameter("MONTH_DT");
out.print(MONTH_DT);
//String month_dt=session.getAttribute("sInvDt")==null?"":(String) session.getAttribute("sInvDt");
String edp_no=request.getParameter("no_ofapp")==null?"0":(String)request.getParameter("no_ofapp");
String INV_NO="";
String STATE_NM="";
String OFF_NAME="";
String GST_AMT="";
String TOTAL_INV_AMT="";
String TOTAL_AMT="";
String FOPAY_AMT="";
//String MONTH_DT="";
String TOTALEDPRECOMNO="";
String TOTALEDPRECOMAMT="";
String DISALLOW_REASON="";
String INVUPID ="";
String INV_DATE="";
String EDP_NO="";
String RECOM_LET_UPLOAD="";
String UPDOC_EDP ="";



     DBCon db= new DBCon();
      db.connect();  

 
 StringBuffer qrysb = new StringBuffer();




 qrysb.append("SELECT rownum as srno, boi.INVUPID,  ");
 qrysb.append(" ms.STATE_NM, ");
 qrysb.append(" mom.OFF_NAME1 as OFF_NAME, ");
 qrysb.append(" boi.OFF_CD, boi.INV_NO, ");
 qrysb.append(" boi.GST_AMT, ");
 qrysb.append(" boi.TOTAL_INV_AMT, ");
 qrysb.append(" boi.TOTAL_AMT, ");
 qrysb.append(" boi.FOPAY_AMT, ");
 qrysb.append("TO_CHAR(boi.MONTH_DT,'MON-RRRR')MONTH_DT, ");
 qrysb.append(" boi.UPDOC_EDP, ");
 qrysb.append(" boi.EDP_NO, ");
 qrysb.append(" boi.FIVEDAYTRGRECOMNO, ");
 qrysb.append(" boi.TENDAYTRGRECOMNO, ");
 qrysb.append(" boi.FIVEDAYTRGRECOMAMT, ");
 qrysb.append(" boi.TENDAYTRGRECOMAMT, ");
 qrysb.append("  boi.FIVEDAYTRGRECOMNO_OLD, ");
 qrysb.append("  boi.TENDAYTRGRECOMNO_OLD, ");
 qrysb.append(" boi.TENDAYTRGRECOMAMT_OLD, ");
 qrysb.append(" boi.FIVEDAYTRGRECOMAMT_OLD, ");
  qrysb.append("boi.DISALLOW_REASON, ");
 qrysb.append(" boi.TOTALEDPRECOMNO, ");
 qrysb.append(" boi.TOTALEDPRECOMAMT,RECOM_LET_UPLOAD, ");
 qrysb.append(" to_char(boi.INV_DATE,'DD-MON-RRRR')INV_DATE ");
 qrysb.append(" FROM bnf_onlineedp_inf boi, ");
 qrysb.append(" mas_off_mast mom, ");
 qrysb.append(" m_district md,  ");
 qrysb.append(" m_state ms  ");
 qrysb.append(" WHERE mom.DISTRICT_CD = md.DISTRICT_CD  ");
 qrysb.append(" AND md.STATE_CD       = ms.STATE_CD  ");
 qrysb.append(" AND mom.OFF_CD        = boi.OFF_CD  and recom_let_upload is not null ");
 qrysb.append(" AND boi.MONTH_DT  ='"+MONTH_DT+"' ");

 
 

ResultSet rs=db.execSQL(qrysb.toString());  

  
%> 
  
  
 <h3>
	  <div align="center">SAMADHANEDP RECOMMENDED DETAILS</div>
  </h3><BR><table align="center">
  <tr align="center">
 <td align="center"><strong>Select Month</strong> <select name="MONTH_DT" id="MONTH_DT" class="class">
     <option value="">--Select Month--</option>
     <%
ResultSet rso =db.execSQL(" select TO_CHAR(month_dt,'DD-MON-RRRR') AS INV_VAL,TO_CHAR(month_dt,'MON-RRRR') AS DISPLAYMON from  bnf_onlineedp_inf where getfinyr(month_dt) ='"+sselect+"' AND UPDOC_EDP IS NOT NULL GROUP BY  month_dt,month_dt ");
 
   	String vINV_VAL="";
	String vDISPLAYMON="";
	String INV_VAL="";


	   while(rso.next()){ 
	   vINV_VAL=rso.getString("INV_VAL");
	   vDISPLAYMON=rso.getString("DISPLAYMON");
	    
	   %>
     <option value="<%=vINV_VAL%>" <%if(MONTH_DT.equals(INV_VAL)){out.print("Selected");}%> > <%=vDISPLAYMON %></option>
     <% } 
	// out.print("hello"+vINV_VAL);
	  rso.close();
	   %>
   </select> 
   
   <input name="btn" type="submit" class="class" value="View"> </td> 
   <td align="center">&nbsp;</td>
   <td><div align="center"> <input type="button" class="class" onClick="viewR();" value="Download Report" >
    </div></td><td align="center">&nbsp;</td>
  </tr>
  </table>
 <table id="example" class="table table-striped table-bordered" style="width:100%">
          <thead>
            <tr>   
             <td class="class"><div align="center"><strong>Sr.No</strong></div></td> 
	       <td class="class"><div align="center"><strong>Invoice No:</strong></div></td> 
               <td class="class"><div align="center"><strong>invoice Date</strong></div></td>   
		<td class="class"><div align="center"><strong>Month/Year</strong></div></td>
		<td class="class"><div align="center"><strong>State Name</strong></div></td>
		<td class="class"><div align="center"><strong>Office Name</strong></div></td>
		<td class="class"><div align="center"><strong>No of edp completed</strong></div></td>
		<td class="class"><div align="center"><strong>Invoice  Amt(In Rs.)</strong></div></td>
		<td class="class"><div align="center"><strong>Gst Amount(In Rs.)</strong></div></td>
		<td class="class"><div align="center"><strong>Total Invoice Amt(in Rs.)</strong></div></td>
		<td class="class"><div align="center"><strong>Total Recommanded Edp No</strong></div></td>
		<td class="class"><div align="center"><strong>Total Recommanded Edp Amt(In Rs.)</strong></div></td>
		<td class="class"><div align="center"><strong> Disallow Reason</strong></div></td>
		<td class="class"><div align="center"><strong> Download</strong></div></td>
		<td class="class"><DIV align="center"><strong>Recom Letter</strong></DIV></TD>
					   
					
            </tr> 
          </thead>
          <tbody>
            <%
			
int count=0; 
while(rs.next())
{
count=count+1;
INV_DATE=rs.getString("INV_DATE")==null?"":rs.getString("INV_DATE");
INVUPID=rs.getString("INVUPID")==null?"":rs.getString("INVUPID");
STATE_NM=rs.getString("STATE_NM")==null?"":rs.getString("STATE_NM");
OFF_NAME=rs.getString("OFF_NAME")==null?"":rs.getString("OFF_NAME");
EDP_NO=rs.getString("EDP_NO")==null?"":rs.getString("EDP_NO");
GST_AMT=rs.getString("GST_AMT")==null?"":rs.getString("GST_AMT");
TOTAL_INV_AMT=rs.getString("TOTAL_INV_AMT")==null?"":rs.getString("TOTAL_INV_AMT");
TOTAL_AMT=rs.getString("TOTAL_AMT")==null?"":rs.getString("TOTAL_AMT");
FOPAY_AMT=rs.getString("FOPAY_AMT")==null?"":rs.getString("FOPAY_AMT");
MONTH_DT=rs.getString("MONTH_DT")==null?"":rs.getString("MONTH_DT");
TOTALEDPRECOMNO=rs.getString("TOTALEDPRECOMNO")==null?"":rs.getString("TOTALEDPRECOMNO");
TOTALEDPRECOMAMT=rs.getString("TOTALEDPRECOMAMT")==null?"":rs.getString("TOTALEDPRECOMAMT");
DISALLOW_REASON=rs.getString("DISALLOW_REASON")==null?"":rs.getString("DISALLOW_REASON");
INV_NO=rs.getString("INV_NO")==null?"":rs.getString("INV_NO");
RECOM_LET_UPLOAD=rs.getString("RECOM_LET_UPLOAD")==null?"":rs.getString("RECOM_LET_UPLOAD");
UPDOC_EDP=rs.getString("UPDOC_EDP")==null?"":rs.getString("UPDOC_EDP");
%>
            <tr>
              <td><div align="center" ><%=count %></div></td> 
			  <td><div align="center" ><%=INV_NO %></div></td>
			   <td><div align="center" ><%=INV_DATE %></div></td>
			   <td><div align="center"><%=MONTH_DT %></div></td>
			 <td><div align="center" ><%=STATE_NM %></div></td>
              <td><div align="center" ><%=OFF_NAME %></div></td>
			    <td><div align="center"><%=EDP_NO %></div></td>
			 
              <td><div align="center"><%=TOTAL_INV_AMT %></div></td>
			   <td><div align="center" ><%=GST_AMT %></div></td>
			  <td><div align="center"><%=TOTAL_AMT %></div></td>
              <td><div align="center"><%=TOTALEDPRECOMNO %></div></td>
			  <td><div align="center"><%=TOTALEDPRECOMAMT %></div></td>
			  <td><div align="center"><%=DISALLOW_REASON %></div></td>
			  <TD><DIV align="center"><A download href="../../pmegpeportal/samadhanedp/otherdocu/<%= UPDOC_EDP %>" class="myButton">Invoice</A></DIV></TD>
			  <TD> <% if  (!RECOM_LET_UPLOAD.equals("")) {%>
	<DIV align="center"><A onClick="view('<%= RECOM_LET_UPLOAD %>');"  class="myButton">View</A></DIV>
	<%}%>	</TD>
			   
		   
	        
            </tr> 
            <% 
 
  }
  rs.close();
  db.close();
  %>
          </tbody>
  </table>
</form>
  <script>
 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 
 
  
function view(DOC_NAME){
var callbackFunctionArray = new Array(refreshpage);
 modalWin.ShowURL("docViewRe.jsp?docname="+DOC_NAME,720,1350,'Status',null,null);
 }
 function refresh_close() {
  location.reload();
}

function refreshpage() {
  location.reload();
}
 
function HideModalWindow() {
    modalWin.HideModalPopUp();
}

function refresh_data(){
form.submit();
}
</script>
  	
</body>
		
</HTML>




