<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<html>
<head>
<title>
</title>
<link rel="stylesheet" type="text/css" href="../css/bnfstylesheet.css">
<script language="javascript" src="../js/inlinemsg.js"></script>
<script language="javascript" src="../js1/popcalendar.js"></script>
<script language="javascript">
/*
function days_between(date1, date2) {
	
	

    // The number of milliseconds in one day
    var ONE_DAY = 1000 * 60 * 60 * 24

    // Convert both dates to milliseconds
    var date1_ms = date1.getTime()
    var date2_ms = date2.getTime()

    // Calculate the difference in milliseconds
    var difference_ms = Math.abs(date1_ms - date2_ms)

    // Convert back to days and return
    return Math.round(difference_ms/ONE_DAY)

}*/


/*
function days(){
var BNF_ATOURDYS= document.form.BNF_ATOURDYS.value;
var BNF_AFROMDT = document.form.BNF_AFROMDT.value;
var BNF_ATODT = document.form.BNF_ATODT.value;
var startDate = Date.parse(BNF_AFROMDT);
            var endDate = Date.parse(BNF_ATODT );
            var timeDiff = endDate - startDate;
            daysDiff = Math.floor(timeDiff / (1000 * 60 * 60 * 24));
            document.form.BNF_ATOURDYS.value=daysDiff;
}*/





function submitform() {
var	BNF_ATARGET=form.BNF_ATARGET.value;
var BNF_ASTFFNME=form.BNF_ASTFFNME.value;
var BNF_ASTFFDSGNTN=form.BNF_ASTFFDSGNTN.value;
var BNF_ASTFFCNTCT= document.form.BNF_ASTFFCNTCT.value;
var BNF_APLACE= document.form.BNF_APLACE.value;
var BNF_APROGDTLS= document.form.BNF_APROGDTLS.value;
var BNF_ATOURDYS= document.form.BNF_ATOURDYS.value;
var BNF_AFROMDT = document.form.BNF_AFROMDT.value;
var BNF_ATODT = document.form.BNF_ATODT.value;
var BNF_TYPPUBLICITY = document.form.BNF_TYPPUBLICITY.value;
var BNF_NOOFPARTCPNTS = document.form.BNF_NOOFPARTCPNTS.value;
var BNF_ACLBNAME = document.form.BNF_ACLBNAME.value;
var BNF_ATA = document.form.BNF_ATA.value;
var BNF_ADA = document.form.BNF_ADA.value;
var BNF_AGENCY = document.form.BNF_AGENCY.value;
var REMARK_ADD = document.form.REMARK_ADD.value;


if (BNF_ATARGET == "") {
			 inlineMsg('BNF_ATARGET',"Please enter Target.",2);
            return (false);
			}
if (BNF_ASTFFNME == "") {
			 inlineMsg('BNF_ASTFFNME',"Please enter staff name.",2);
            return (false);
			}



if (BNF_ASTFFDSGNTN == "") {
			 inlineMsg('BNF_ASTFFDSGNTN',"Please enter staff designation",2);
            return (false);
			}
			
if (BNF_ASTFFCNTCT == "") {
			 inlineMsg('BNF_ASTFFCNTCT',"Please enter staff contact no",2);
            return (false);
			}
						
			
if (BNF_APLACE == "") {
			 inlineMsg('BNF_APLACE',"Please enter Place of Visit",2);
            return (false);
			}	
			
	if (BNF_APROGDTLS == "") {
			 inlineMsg('BNF_APROGDTLS',"Please enter Prgogramme Details",2);
            return (false);
			}			
			
			if (BNF_ATOURDYS == "") {
			 inlineMsg('BNF_ATOURDYS',"Please enter days",2);
            return (false);
			}
			
			
		
			if (BNF_AFROMDT == "") {
			 inlineMsg('BNF_AFROMDT',"Please select from date",2);
            return (false);
			}		
			
			if (BNF_ATODT == "") {
			 inlineMsg('BNF_ATODT',"Please select to date",2);
            return (false);
			}
			if (BNF_TYPPUBLICITY == "") {
			 inlineMsg('BNF_TYPPUBLICITY',"Please enter type of publicity",2);
            return (false);
			}
	if (BNF_AGENCY == "") {
			 inlineMsg('BNF_AGENCY',"Please enter agency",2);
            return (false);
			}			
			

		if (BNF_NOOFPARTCPNTS == "") {
			 inlineMsg('BNF_NOOFPARTCPNTS',"Please select no of participants",2);
            return (false);
			}	
					
			
	if (BNF_ACLBNAME == "") {
			 inlineMsg('BNF_ACLBNAME',"Please enter name of the celebrity",2);
            return (false);
			}			
			
		
			if (BNF_ATA == "") {
			 inlineMsg('BNF_ATA',"Please enter TA",2);
            return (false);
			}	

			if (BNF_ADA == "") {
			 inlineMsg('BNF_ADA',"Please enter DA ",2);
            return (false);
			}				
			
				
			
document.form.ins.value='I';
document.form.submit();
}

</script>

<style type="text/css">
<!--
.style1 {color: #FFFFFF}
-->
</style>

</head>
<body>
<form  name="form" id="form" method="post" >


<%@ include file = "sessionoutincforeditform.jsp" %>
<%

List values=new ArrayList();

String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");
String POFF_NAME1=SOFF_NAME1;
String BNF_TRID=request.getParameter("PBNF_TRID")==null?"":(String)request.getParameter("PBNF_TRID");

String OFF_CD = SOFF_CD;
String OFF_NAME1 = POFF_NAME1;
String BUD_ID = request.getParameter("PBUDID")==null?"0":(String)request.getParameter("PBUDID");

String BNF_ASTFFNME = "";
String BNF_ASTFFDSGNTN = "";
String BNF_ASTFFCNTCT = "";
String BNF_APLACE = "";
String BNF_APROGDTLS = "";
String BNF_ATOURDYS = "";
String BNF_AFROMDT = "";
String BNF_ATODT = "";
String BNF_TYPPUBLICITY = "";
String BNF_NOOFPARTCPNTS = "";
String BNF_ACLBNAME = "";
String BNF_ATA = "";
String BNF_ADA = "";
String BNF_AGENCY = "";
String REMARK_ADD = "";
String BNF_ATARGET = "";

String BNF_HDID ="";
String BNF_SUB_HEAD_LONG_DESC="";
String add_update="I";

DBCon db= new DBCon();
db.connect();


  out.print (BNF_TRID+" "+OFF_CD);


if (!BNF_TRID.equals("")) {

 StringBuffer qrysb = new StringBuffer();

qrysb.append("   SELECT BFT.BNF_TRID,"      );
qrysb.append("     BFT.OFF_CD,"      );
qrysb.append("     BFT.BUD_ID,"      );
qrysb.append("     BFT.BNF_ASTFFNME,"      );
qrysb.append("     BFT.BNF_ASTFFDSGNTN,"      );
qrysb.append("     BFT.BNF_ASTFFCNTCT,"      );
qrysb.append("     BFT.BNF_APLACE,"      );
qrysb.append("     BFT.BNF_APROGDTLS,"      );
qrysb.append("     BFT.BNF_ATOURDYS,"      );
qrysb.append("     BFT.BNF_AFROMDT,"      );
qrysb.append("     BFT.BNF_ATODT,"      );
qrysb.append("     BFT.BNF_TYPPUBLICITY,"      );
qrysb.append("     BFT.BNF_NOOFPARTCPNTS,"      );
qrysb.append("     BFT.BNF_ACLBNAME,"      );
qrysb.append("     BFT.BNF_ATA,"      );
qrysb.append("     BFT.BNF_ADA,"      );
qrysb.append("     BFT.REMARK_ADD,"      );
qrysb.append("     BFT.BNF_AGENCY"      );
qrysb.append("   FROM BNF_FO_TRANS BFT"      );
qrysb.append("   WHERE BFT.BNF_TRID = ?"      );
qrysb.append("   AND BFT.OFF_CD     = ?"      );

  values.add(BNF_TRID);
  values.add(OFF_CD);
  

ResultSet rsMain = db.executeSQL(qrysb.toString(),values);

values.clear();

while (rsMain.next()){

BNF_TRID=rsMain.getString("BNF_TRID")==null?"":rsMain.getString("BNF_TRID");
BUD_ID=rsMain.getString("BUD_ID")==null?"":rsMain.getString("BUD_ID");
//OFF_CD=rsMain.getString("OFF_CD")==null?"":rsMain.getString("OFF_CD");
BNF_ASTFFNME=rsMain.getString("BNF_ASTFFNME")==null?"":rsMain.getString("BNF_ASTFFNME");
BNF_ASTFFDSGNTN=rsMain.getString("BNF_ASTFFDSGNTN")==null?"":rsMain.getString("BNF_ASTFFDSGNTN");
BNF_ASTFFCNTCT=rsMain.getString("BNF_ASTFFCNTCT")==null?"":rsMain.getString("BNF_ASTFFCNTCT");
BNF_APLACE=rsMain.getString("BNF_APLACE")==null?"":rsMain.getString("BNF_APLACE");
BNF_APROGDTLS=rsMain.getString("BNF_APROGDTLS")==null?"":rsMain.getString("BNF_APROGDTLS");
BNF_ATOURDYS=rsMain.getString("BNF_ATOURDYS")==null?"":rsMain.getString("BNF_ATOURDYS");
BNF_AFROMDT=rsMain.getString("BNF_AFROMDT")==null?"":rsMain.getString("BNF_AFROMDT");
BNF_ATODT=rsMain.getString("BNF_ATODT")==null?"":rsMain.getString("BNF_ATODT");
BNF_TYPPUBLICITY=rsMain.getString("BNF_TYPPUBLICITY")==null?"":rsMain.getString("BNF_TYPPUBLICITY");
BNF_NOOFPARTCPNTS=rsMain.getString("BNF_NOOFPARTCPNTS")==null?"":rsMain.getString("BNF_NOOFPARTCPNTS");
BNF_ACLBNAME=rsMain.getString("BNF_ACLBNAME")==null?"":rsMain.getString("BNF_ACLBNAME");
BNF_ATA=rsMain.getString("BNF_ATA")==null?"":rsMain.getString("BNF_ATA");
BNF_ADA=rsMain.getString("BNF_ADA")==null?"":rsMain.getString("BNF_ADA");
REMARK_ADD=rsMain.getString("REMARK_ADD")==null?"":rsMain.getString("REMARK_ADD");
BNF_AGENCY=rsMain.getString("BNF_AGENCY")==null?"":rsMain.getString("BNF_AGENCY");


add_update="U";
}
rsMain.close();

}

out.print (BUD_ID);
%>

<table>
<tr>
  <td colspan="9"><div align="center">Data Entry Form 2018-19 </div></td>
  </tr>
<tr>
  <td width="24%"> Budget / Target Head : </td>
  <td colspan="8"><span class="style1">
    <input name="BNF_TRID" type="hidden" id="BNF_TRID" value="<%= BNF_TRID %>">
  </span></td>
</tr>
<tr><td>  Budget ID  
  <input name="ins" type="hidden" id="ins"></td>
<td colspan="8"><%= BUD_ID %></td>
</tr>  
  
<tr>
  <td>Office Code
    
    
    :</td>
  <td colspan="8"><%= OFF_CD %></td>
</tr>
<tr>
  <td>Target Allocated : </td>
  <td colspan="8"><input name="BNF_ATARGET" type="text" id="BNF_ATARGET" value="<%= BNF_ATARGET %>" >  </tr>
<tr>
  <td>Name of the staff and designation : </td>
  <td colspan="8">Name :
    <label>
    <input name="BNF_ASTFFNME" type="text" id="BNF_ASTFFNME" value="<%= BNF_ASTFFNME %>" />
    </label>
Designation :
<input name="BNF_ASTFFDSGNTN" type="text" id="BNF_ASTFFDSGNTN" value="<%= BNF_ASTFFDSGNTN %>" />
Contact no. :
<input name="BNF_ASTFFCNTCT" type="text" id="BNF_ASTFFCNTCT" value="<%= BNF_ASTFFCNTCT %>" ></td>
</tr>
<tr>
  <td>Place of visit : </td>
  <td colspan="8"><input name="BNF_APLACE" type="text" id="BNF_APLACE" value="<%= BNF_APLACE %>" ></td>
</tr>

<tr>
  <td>Programme detail : </td>
  <td colspan="8"><input name="BNF_APROGDTLS" type="textarea" id="BNF_APROGDTLS" value="<%= BNF_APROGDTLS %>" ></td>
</tr>
<tr>
  <td>Tour sanctioned for No. of days : </td>
  <td colspan="8"><input name="BNF_ATOURDYS" type="textarea" id="BNF_ATOURDYS" value="<%= BNF_ATOURDYS %>"  ></td>
</tr>
<tr>
  <td>Date (from to) : </td>
  <td colspan="8">From :
    <input name="BNF_AFROMDT" type="text" id="BNF_AFROMDT" value="<%= BNF_AFROMDT %>"  onClick="popUpCalendar(this, this.form.BNF_AFROMDT,'dd-mmm-yyyy');return false;" >
To :
<input name="BNF_ATODT" type="text" id="BNF_ATODT" value="<%= BNF_ATODT %>"  onClick="popUpCalendar(this, this.form.BNF_ATODT,'dd-mmm-yyyy');return false;" ></td>
</tr>
<tr>
  <td>Type of Publicity : </td>
  <td colspan="8"><input name="BNF_TYPPUBLICITY" type="text" id="BNF_TYPPUBLICITY" value="<%= BNF_TYPPUBLICITY %>" ></td>
</tr>
<tr>
  <td>Agency Type: </td>
  <td colspan="8"><input name="BNF_AGENCY" type="text" id="BNF_AGENCY" value="<%= BNF_AGENCY %>" ></td>
</tr>
<tr>
  <td>No. of participants : </td>
  <td colspan="8"><input name="BNF_NOOFPARTCPNTS" type="text" id="BNF_NOOFPARTCPNTS" value="<%= BNF_NOOFPARTCPNTS %>" ></td>
</tr>
<tr>
  <td>Name of main celebrity : </td>
  <td colspan="8"><input name="BNF_ACLBNAME" type="text" id="BNF_ACLBNAME" value="<%= BNF_ACLBNAME %>" ></td>
</tr>
<tr>
  <td>Expenditure incurred  : </td>
  <td colspan="8">TA:
    <input name="BNF_ATA" type="text" id="BNF_ATA" value="<%= BNF_ATA %>" >
DA:
<input name="BNF_ADA" type="text" id="BNF_ADA" value="<%= BNF_ADA %>" ></td>
</tr>
<tr>
  <td>Remark : </td>
  <td colspan="8"><input name="REMARK_ADD" type="textarea" id="REMARK_ADD" value="<%= REMARK_ADD %>" ></td>
</tr>

 
</table><br/>
<div align="center">
  <input name="Button" type="button" class="button" onClick="submitform();" value="SAVE">
</div>
<%
//out.print (ins);
if (ins.equals("I")) {

BNF_TRID=(String) request.getParameter("BNF_TRID")==null?"0":(String) request.getParameter("BNF_TRID").trim();
//OFF_CD=(String) request.getParameter("OFF_CD")==null?"":(String) request.getParameter("OFF_CD").trim();
//BUD_ID=(String) request.getParameter("BUD_ID")==null?"":(String) request.getParameter("BUD_ID").trim();
BNF_ASTFFNME=(String) request.getParameter("BNF_ASTFFNME")==null?"":(String) request.getParameter("BNF_ASTFFNME").trim();
BNF_ASTFFDSGNTN=(String) request.getParameter("BNF_ASTFFDSGNTN")==null?"":(String) request.getParameter("BNF_ASTFFDSGNTN").trim();
BNF_ASTFFCNTCT=(String) request.getParameter("BNF_ASTFFCNTCT")==null?"":(String) request.getParameter("BNF_ASTFFCNTCT").trim();
BNF_APLACE=(String) request.getParameter("BNF_APLACE")==null?"":(String) request.getParameter("BNF_APLACE").trim();
BNF_APROGDTLS=(String) request.getParameter("BNF_APROGDTLS")==null?"":(String) request.getParameter("BNF_APROGDTLS").trim();
BNF_ATOURDYS=(String) request.getParameter("BNF_ATOURDYS")==null?"":(String) request.getParameter("BNF_ATOURDYS").trim();
BNF_AFROMDT=(String) request.getParameter("BNF_AFROMDT")==null?"":(String) request.getParameter("BNF_AFROMDT").trim();
BNF_ATODT=(String) request.getParameter("BNF_ATODT")==null?"":(String) request.getParameter("BNF_ATODT").trim();
BNF_TYPPUBLICITY=(String) request.getParameter("BNF_TYPPUBLICITY")==null?"":(String) request.getParameter("BNF_TYPPUBLICITY").trim();
BNF_NOOFPARTCPNTS=(String) request.getParameter("BNF_NOOFPARTCPNTS")==null?"":(String) request.getParameter("BNF_NOOFPARTCPNTS").trim();
BNF_ACLBNAME=(String) request.getParameter("BNF_ACLBNAME")==null?"":(String) request.getParameter("BNF_ACLBNAME").trim();
BNF_ATA=(String) request.getParameter("BNF_ATA")==null?"":(String) request.getParameter("BNF_ATA").trim();
BNF_ADA=(String) request.getParameter("BNF_ADA")==null?"":(String) request.getParameter("BNF_ADA").trim();
BNF_AGENCY=(String) request.getParameter("BNF_AGENCY")==null?"":(String) request.getParameter("BNF_AGENCY").trim();
REMARK_ADD=(String) request.getParameter("REMARK_ADD")==null?"":(String) request.getParameter("REMARK_ADD").trim();




		List pstm=new ArrayList();
		StringBuffer qryUpdate = new StringBuffer();
		values.clear();
		pstm.clear();
		if (add_update.equals("I")) {
		
String maxId="SELECT NVL(MAX(BNF_TRID),0)+1 AS BNF_TRID FROM BNF_FO_TRANS" ;
ResultSet rsMax=db.execSQL(maxId);
while (rsMax.next()){
BNF_TRID=rsMax.getString("BNF_TRID")==null?"":rsMax.getString("BNF_TRID");
}


rsMax.close();

qryUpdate.append("INSERT INTO BNF_FO_TRANS ( ");
qryUpdate.append("BNF_ASTFFNME,");
qryUpdate.append("BNF_ASTFFDSGNTN,");
qryUpdate.append("BNF_ASTFFCNTCT,");
qryUpdate.append("BNF_APLACE,");
qryUpdate.append("BNF_APROGDTLS,");
qryUpdate.append("BNF_ATOURDYS,");
qryUpdate.append("BNF_AFROMDT,");
qryUpdate.append("BNF_ATODT,");
qryUpdate.append("BNF_TYPPUBLICITY,");
qryUpdate.append("BNF_NOOFPARTCPNTS,");
qryUpdate.append("BNF_ACLBNAME,");
qryUpdate.append("BNF_ATA,");
qryUpdate.append("BNF_ADA,");
qryUpdate.append("BNF_AGENCY,");
qryUpdate.append("REMARK_ADD,OFF_CD,BUD_ID,BNF_TRID");
qryUpdate.append(" ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
}



else {

qryUpdate.append("UPDATE BNF_FO_TRANS SET ");
qryUpdate.append("BNF_ASTFFNME=?,");
qryUpdate.append("BNF_ASTFFDSGNTN=?,");
qryUpdate.append("BNF_ASTFFCNTCT=?,");
qryUpdate.append("BNF_APLACE=?,");
qryUpdate.append("BNF_APROGDTLS=?,");
qryUpdate.append("BNF_ATOURDYS=?,");
qryUpdate.append("BNF_AFROMDT=?,");
qryUpdate.append("BNF_ATODT=?,");
qryUpdate.append("BNF_TYPPUBLICITY=?,");
qryUpdate.append("BNF_NOOFPARTCPNTS=?,");
qryUpdate.append("BNF_ACLBNAME=?,");
qryUpdate.append("BNF_ATA=?,");
qryUpdate.append("BNF_ADA=?,");
qryUpdate.append("BNF_AGENCY=?,");
qryUpdate.append("REMARK_ADD=?");

qryUpdate.append(" WHERE OFF_CD=? AND BUD_ID=? AND BNF_TRID=?");

out.print ("In oupdate"+BNF_TRID);

}

out.print (qryUpdate.toString());

values.add(BNF_ASTFFNME); pstm.add ("L");
values.add(BNF_ASTFFDSGNTN); pstm.add ("L");
values.add(BNF_ASTFFCNTCT); pstm.add ("L");
values.add(BNF_APLACE); pstm.add ("L");
values.add(BNF_APROGDTLS); pstm.add ("L");
values.add(BNF_ATOURDYS); pstm.add ("L");
values.add(BNF_AFROMDT); pstm.add ("L");
values.add(BNF_ATODT); pstm.add ("L");
values.add(BNF_TYPPUBLICITY); pstm.add ("L");
values.add(BNF_NOOFPARTCPNTS); pstm.add ("L");
values.add(BNF_ACLBNAME); pstm.add ("L");
values.add(BNF_ATA); pstm.add ("L");
values.add(BNF_ADA); pstm.add ("L");
values.add(BNF_AGENCY); pstm.add ("L");
values.add(REMARK_ADD); pstm.add ("L");
values.add(OFF_CD); pstm.add ("L");
values.add(BUD_ID); pstm.add ("L");
values.add(BNF_TRID); pstm.add ("L");


db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate();
db.close();

response.sendRedirect("savemsg.jsp");
}

%>


</form>
</body>
</html>