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
//var	BNF_ATARGET=form.BNF_ATARGET.value;
/*var BNF_ASTFFNME=form.BNF_ASTFFNME.value;
var BNF_ASTFFDSGNTN=form.BNF_ASTFFDSGNTN.value;
var BNF_ASTFFCNTCT= document.form.BNF_ASTFFCNTCT.value;
var BNF_APLACE= document.form.BNF_APLACE.value;
var BNF_APROGDTLS= document.form.BNF_APROGDTLS.value;
var BNF_ATOURDYS= document.form.BNF_ATOURDYS.value;
var BNF_AFROMDT = document.form.BNF_AFROMDT.value;
var BNF_ATODT = document.form.BNF_ATODT.value;
//var BNF_TYPPUBLICITY = document.form.BNF_TYPPUBLICITY.value;
var BNF_NOOFPARTCPNTS = document.form.BNF_NOOFPARTCPNTS.value;
var BNF_ACLBNAME = document.form.BNF_ACLBNAME.value;
var BNF_ATA = document.form.BNF_ATA.value;
//var BNF_ADA = document.form.BNF_ADA.value;
var BNF_AGENCY = document.form.BNF_AGENCY.value;
var REMARK_ADD = document.form.REMARK_ADD.value;



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

							
			
		*/		
			
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
//String BNF_TRID=request.getParameter("PBNF_TRID")==null?"":(String)request.getParameter("PBNF_TRID");
//String PBNF_DESC=request.getParameter("PBNF_DESC")==null?"":(String)request.getParameter("PBNF_DESC");
String OFF_CD = SOFF_CD;
String OFF_NAME1 = POFF_NAME1;
//String BUD_ID = request.getParameter("PBUDID")==null?"0":(String)request.getParameter("PBUDID");
//out.print(BUD_ID);
String BNF_TRID=session.getAttribute("PBNF_TRID")==null?"0":(String)session.getAttribute("PBNF_TRID");	
out.print(BNF_TRID);
String PBNF_DESC=session.getAttribute("PBNF_DESC")==null?"":(String)session.getAttribute("PBNF_DESC");
String BUD_ID=session.getAttribute("PBUD_ID")==null?"":(String)session.getAttribute("PBUD_ID");
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


  //out.print (BNF_TRID+" "+OFF_CD);


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
qrysb.append("     TO_CHAR(BFT.BNF_AFROMDT,'DD-MON-RRRR') AS BNF_AFROMDT,"      );
qrysb.append("     TO_CHAR(BFT.BNF_ATODT,'DD-MON-RRRR') AS BNF_ATODT, "      );
qrysb.append("     BFT.BNF_TYPPUBLICITY,"      );
qrysb.append("     BFT.BNF_NOOFPARTCPNTS,"      );
qrysb.append("     BFT.BNF_ACLBNAME,"      );
qrysb.append("      CASE WHEN BFT.BNF_AGENCY='KB'  THEN FIN_KVIB  WHEN BFT.BNF_AGENCY='KV'  "      );
qrysb.append("      THEN FIN_KVIC  WHEN BFT.BNF_AGENCY='DI'  THEN FIN_DIC END AS BNF_ATA , "      );
qrysb.append("     BFT.REMARK_ADD,"      );
qrysb.append("     BFT.BNF_AGENCY"      );
qrysb.append("   FROM BNF_FO_TRANS BFT"      );
qrysb.append("   WHERE BFT.BNF_TRID = ?"      );
qrysb.append("   AND BFT.OFF_CD     = ?"      );

  values.add(BNF_TRID);
  values.add(OFF_CD);
  //out.print(qrysb.toString());

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
REMARK_ADD=rsMain.getString("REMARK_ADD")==null?"":rsMain.getString("REMARK_ADD");
BNF_AGENCY=rsMain.getString("BNF_AGENCY")==null?"":rsMain.getString("BNF_AGENCY");


add_update="U";
}
rsMain.close();

}

//out.print (BUD_ID);
%>
<strong><h2><center><%=PBNF_DESC%></center></h2></strong>
<table>
<tr>
  <td colspan="2"><div align="center">Data Entry Form 2018-19 </div></td>
  </tr>

 
<tr>
  <td >Name of the staff and designation : </td>
  <td><input name="BNF_ASTFFNME" type="text" id="BNF_ASTFFNME" value="<%= BNF_ASTFFNME %>" />    </td>
</tr><input name="BNF_TRID" type="hidden" id="BNF_TRID" value=<%= BNF_TRID %> />
<input name="BUD_ID" type="hidden" id="BUD_ID" value=<%= BUD_ID %> />
<input name="OFF_CD" type="hidden" id="OFF_CD" value=<%= OFF_CD %> />
<tr>
  <td>Designation : </td>
  <td><input name="BNF_ASTFFDSGNTN" type="text" id="BNF_ASTFFDSGNTN" value="<%= BNF_ASTFFDSGNTN %>" /></td>
</tr>
<tr>
  <td> Contact no. : </td> <input name="ins" type="hidden" id="ins">
  <td><input name="BNF_ASTFFCNTCT" type="text" id="BNF_ASTFFCNTCT" value="<%= BNF_ASTFFCNTCT %>" ></td>
</tr>
<tr>
  <td>Place of visit : </td>
  <td><input name="BNF_APLACE" type="text" id="BNF_APLACE" value="<%= BNF_APLACE %>" ></td>
</tr>

<tr>
  <td>Programme detail : </td>
  <td><input name="BNF_APROGDTLS" type="textarea" id="BNF_APROGDTLS" value="<%= BNF_APROGDTLS %>" ></td>
</tr>
<tr>
  <td>From :</td>
  <td><input name="BNF_AFROMDT" type="text" id="BNF_AFROMDT" value="<%= BNF_AFROMDT %>"  onClick="popUpCalendar(this, this.form.BNF_AFROMDT,'dd-mmm-yyyy');return false;" >    </td>
  </tr>
<tr>
  <td>To :</td>
  <td><input name="BNF_ATODT" type="text" id="BNF_ATODT" value="<%= BNF_ATODT %>"  onClick="popUpCalendar(this, this.form.BNF_ATODT,'dd-mmm-yyyy');return false;" ></td>
</tr>
<tr>
  <td>Tour sanctioned for No. of days : </td>
  <td><input name="BNF_ATOURDYS" type="textarea" id="BNF_ATOURDYS" value="<%= BNF_ATOURDYS %>"  ></td>
  </tr>
<tr>
  <td>No. of participants : </td>
  <td><input name="BNF_NOOFPARTCPNTS" type="text" id="BNF_NOOFPARTCPNTS" value="<%= BNF_NOOFPARTCPNTS %>" ></td>
</tr>
<tr>
  <td>Name of main celebrity : </td>
  <td><input name="BNF_ACLBNAME" type="text" id="BNF_ACLBNAME" value="<%= BNF_ACLBNAME %>" ></td>
</tr>
<tr>
  <td>Agency Type: </td>
  <td>
  <select name="BNF_AGENCY" class="button" id="BNF_AGENCY" >
          <option value ="-1" >--Select Agency --</option>
          <option value="KV" <% if (BNF_AGENCY.equals("KV")){out.print("selected");}%>>KVIC</option>
          <option value="KB" <% if (BNF_AGENCY.equals("KB")){out.print("selected");}%>>KVIB</option>
          <option value="DI" <% if (BNF_AGENCY.equals("DI")){out.print("selected");}%>>DIC</option>
		  </select>
  
  </td>
</tr>
<tr>
  <td>Expenditure incurred  : </td>
  <td><input name="BNF_ATA" type="text" id="BNF_ATA" value="<%= BNF_ATA %>" ></td>
</tr>
<tr>
  <td>Remark : </td>
  <td><input name="REMARK_ADD" type="textarea" id="REMARK_ADD" value="<%= REMARK_ADD %>" ></td>
</tr>

 
</table>
<br/>
<div align="center">
  <input name="Button" type="button" class="button" onClick="submitform();" value="SAVE">
</div>
<%
//out.print (ins);
if (ins.equals("I")) {

BNF_TRID=(String) request.getParameter("BNF_TRID")==null?"0":(String) request.getParameter("BNF_TRID").trim();
OFF_CD=(String) request.getParameter("OFF_CD")==null?"":(String) request.getParameter("OFF_CD").trim();
BUD_ID=(String) request.getParameter("BUD_ID")==null?"":(String) request.getParameter("BUD_ID").trim();
BNF_ASTFFNME=(String) request.getParameter("BNF_ASTFFNME")==null?"":(String) request.getParameter("BNF_ASTFFNME").trim();
BNF_ASTFFDSGNTN=(String) request.getParameter("BNF_ASTFFDSGNTN")==null?"":(String) request.getParameter("BNF_ASTFFDSGNTN").trim();
BNF_ASTFFCNTCT=(String) request.getParameter("BNF_ASTFFCNTCT")==null?"":(String) request.getParameter("BNF_ASTFFCNTCT").trim();
BNF_APLACE=(String) request.getParameter("BNF_APLACE")==null?"":(String) request.getParameter("BNF_APLACE").trim();
BNF_APROGDTLS=(String) request.getParameter("BNF_APROGDTLS")==null?"":(String) request.getParameter("BNF_APROGDTLS").trim();
BNF_ATOURDYS=(String) request.getParameter("BNF_ATOURDYS")==null?"":(String) request.getParameter("BNF_ATOURDYS").trim();
BNF_AFROMDT=(String) request.getParameter("BNF_AFROMDT")==null?"":(String) request.getParameter("BNF_AFROMDT").trim();
BNF_ATODT=(String) request.getParameter("BNF_ATODT")==null?"":(String) request.getParameter("BNF_ATODT").trim();
//BNF_TYPPUBLICITY=(String) request.getParameter("BNF_TYPPUBLICITY")==null?"":(String) request.getParameter("BNF_TYPPUBLICITY").trim();
BNF_NOOFPARTCPNTS=(String) request.getParameter("BNF_NOOFPARTCPNTS")==null?"":(String) request.getParameter("BNF_NOOFPARTCPNTS").trim();
BNF_ACLBNAME=(String) request.getParameter("BNF_ACLBNAME")==null?"":(String) request.getParameter("BNF_ACLBNAME").trim();
BNF_ATA=(String) request.getParameter("BNF_ATA")==null?"":(String) request.getParameter("BNF_ATA").trim();
//BNF_ADA=(String) request.getParameter("BNF_ADA")==null?"":(String) request.getParameter("BNF_ADA").trim();
BNF_AGENCY=(String) request.getParameter("BNF_AGENCY")==null?"":(String) request.getParameter("BNF_AGENCY").trim();
REMARK_ADD=(String) request.getParameter("REMARK_ADD")==null?"":(String) request.getParameter("REMARK_ADD").trim();
//out.print(BNF_TRID);
//out.print(OFF_CD);
//out.print(BUD_ID);

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
try{
if (BNF_AGENCY.equals("KV")){
qryUpdate.append("INSERT INTO BNF_FO_TRANS ( ");
qryUpdate.append("BNF_ASTFFNME,");
qryUpdate.append("BNF_ASTFFDSGNTN,");
qryUpdate.append("BNF_ASTFFCNTCT,");
qryUpdate.append("BNF_APLACE,");
qryUpdate.append("BNF_APROGDTLS,");
qryUpdate.append("BNF_ATOURDYS,");
qryUpdate.append("BNF_AFROMDT,");
qryUpdate.append("BNF_ATODT,");
//qryUpdate.append("BNF_TYPPUBLICITY,");
qryUpdate.append("BNF_NOOFPARTCPNTS,");
qryUpdate.append("BNF_ACLBNAME,");
qryUpdate.append("FIN_KVIC,");
qryUpdate.append("TR_DATE,");
//qryUpdate.append("BNF_ADA,");
qryUpdate.append("BNF_AGENCY,");
qryUpdate.append("REMARK_ADD,OFF_CD,BUD_ID,BNF_TRID");
qryUpdate.append(" ) VALUES (?,?,?,?,?,?,?,?,?,?,?,SYSDATE,?,?,?,?,?)");
}
if (BNF_AGENCY.equals("KB")){
qryUpdate.append("INSERT INTO BNF_FO_TRANS ( ");
qryUpdate.append("BNF_ASTFFNME,");
qryUpdate.append("BNF_ASTFFDSGNTN,");
qryUpdate.append("BNF_ASTFFCNTCT,");
qryUpdate.append("BNF_APLACE,");
qryUpdate.append("BNF_APROGDTLS,");
qryUpdate.append("BNF_ATOURDYS,");
qryUpdate.append("BNF_AFROMDT,");
qryUpdate.append("BNF_ATODT,");
//qryUpdate.append("BNF_TYPPUBLICITY,");
qryUpdate.append("BNF_NOOFPARTCPNTS,");
qryUpdate.append("BNF_ACLBNAME,");
qryUpdate.append("FIN_KVIB,");
qryUpdate.append("TR_DATE,");
//qryUpdate.append("BNF_ADA,");
qryUpdate.append("BNF_AGENCY,");
qryUpdate.append("REMARK_ADD,OFF_CD,BUD_ID,BNF_TRID");
qryUpdate.append(" ) VALUES (?,?,?,?,?,?,?,?,?,?,?,SYSDATE,?,?,?,?,?)");
}
if (BNF_AGENCY.equals("DI")){
qryUpdate.append("INSERT INTO BNF_FO_TRANS ( ");
qryUpdate.append("BNF_ASTFFNME,");
qryUpdate.append("BNF_ASTFFDSGNTN,");
qryUpdate.append("BNF_ASTFFCNTCT,");
qryUpdate.append("BNF_APLACE,");
qryUpdate.append("BNF_APROGDTLS,");
qryUpdate.append("BNF_ATOURDYS,");
qryUpdate.append("BNF_AFROMDT,");
qryUpdate.append("BNF_ATODT,");
//qryUpdate.append("BNF_TYPPUBLICITY,");
qryUpdate.append("BNF_NOOFPARTCPNTS,");
qryUpdate.append("BNF_ACLBNAME,");
qryUpdate.append("FIN_DIC,");
qryUpdate.append("TR_DATE,");
//qryUpdate.append("BNF_ADA,");
qryUpdate.append("BNF_AGENCY,");
qryUpdate.append("REMARK_ADD,OFF_CD,BUD_ID,BNF_TRID");
qryUpdate.append(" ) VALUES (?,?,?,?,?,?,?,?,?,?,?,SYSDATE,?,?,?,?,?)");
		}
	}
catch(Exception e){
out.print(e.toString());
}	
		
		
		}

else{
	try{
if(BNF_AGENCY.equals("KV")){
qryUpdate.append("UPDATE BNF_FO_TRANS SET ");
qryUpdate.append("BNF_ASTFFNME=?,");
qryUpdate.append("BNF_ASTFFDSGNTN=?,");
qryUpdate.append("BNF_ASTFFCNTCT=?,");
qryUpdate.append("BNF_APLACE=?,");
qryUpdate.append("BNF_APROGDTLS=?,");
qryUpdate.append("BNF_ATOURDYS=?,");
qryUpdate.append("BNF_AFROMDT=?,");
qryUpdate.append("BNF_ATODT=?,");
//qryUpdate.append("BNF_TYPPUBLICITY=?,");
qryUpdate.append("BNF_NOOFPARTCPNTS=?,");
qryUpdate.append("BNF_ACLBNAME=?,");
qryUpdate.append("FIN_KVIC=?,");
qryUpdate.append("TR_DATE=SYSDATE,");
//qryUpdate.append("BNF_ADA=?,");
qryUpdate.append("BNF_AGENCY=?,");
qryUpdate.append("REMARK_ADD=?");

qryUpdate.append(" WHERE OFF_CD=? AND BUD_ID=? AND BNF_TRID=?");

//out.print ("In oupdate"+BNF_TRID);

}
if(BNF_AGENCY.equals("KB")){
qryUpdate.append("UPDATE BNF_FO_TRANS SET ");
qryUpdate.append("BNF_ASTFFNME=?,");
qryUpdate.append("BNF_ASTFFDSGNTN=?,");
qryUpdate.append("BNF_ASTFFCNTCT=?,");
qryUpdate.append("BNF_APLACE=?,");
qryUpdate.append("BNF_APROGDTLS=?,");
qryUpdate.append("BNF_ATOURDYS=?,");
qryUpdate.append("BNF_AFROMDT=?,");
qryUpdate.append("BNF_ATODT=?,");
//qryUpdate.append("BNF_TYPPUBLICITY=?,");
qryUpdate.append("BNF_NOOFPARTCPNTS=?,");
qryUpdate.append("BNF_ACLBNAME=?,");
qryUpdate.append("FIN_KVIB=?,");
qryUpdate.append("TR_DATE=SYSDATE,");
//qryUpdate.append("BNF_ADA=?,");
qryUpdate.append("BNF_AGENCY=?,");
qryUpdate.append("REMARK_ADD=?");

qryUpdate.append(" WHERE OFF_CD=? AND BUD_ID=? AND BNF_TRID=?");

//out.print ("In oupdate"+BNF_TRID);

}
if(BNF_AGENCY.equals("DI")){
qryUpdate.append("UPDATE BNF_FO_TRANS SET ");
qryUpdate.append("BNF_ASTFFNME=?,");
qryUpdate.append("BNF_ASTFFDSGNTN=?,");
qryUpdate.append("BNF_ASTFFCNTCT=?,");
qryUpdate.append("BNF_APLACE=?,");
qryUpdate.append("BNF_APROGDTLS=?,");
qryUpdate.append("BNF_ATOURDYS=?,");
qryUpdate.append("BNF_AFROMDT=?,");
qryUpdate.append("BNF_ATODT=?,");
//qryUpdate.append("BNF_TYPPUBLICITY=?,");
qryUpdate.append("BNF_NOOFPARTCPNTS=?,");
qryUpdate.append("BNF_ACLBNAME=?,");
qryUpdate.append("FIN_DIC=?,");
qryUpdate.append("TR_DATE=SYSDATE,");
//qryUpdate.append("BNF_ADA=?,");
qryUpdate.append("BNF_AGENCY=?,");
qryUpdate.append("REMARK_ADD=?");

qryUpdate.append(" WHERE OFF_CD=? AND BUD_ID=? AND BNF_TRID=?");

//out.print ("In oupdate"+BNF_TRID);

	}	}	
	catch(Exception e){
out.print(e.toString());
}}

//out.print (qryUpdate.toString());

values.add(BNF_ASTFFNME); pstm.add ("L");
values.add(BNF_ASTFFDSGNTN); pstm.add ("L");
values.add(BNF_ASTFFCNTCT); pstm.add ("L");
values.add(BNF_APLACE); pstm.add ("L");
values.add(BNF_APROGDTLS); pstm.add ("L");
values.add(BNF_ATOURDYS); pstm.add ("L");
values.add(BNF_AFROMDT); pstm.add ("L");
values.add(BNF_ATODT); pstm.add ("L");
//values.add(BNF_TYPPUBLICITY); pstm.add ("L");
values.add(BNF_NOOFPARTCPNTS); pstm.add ("L");
values.add(BNF_ACLBNAME); pstm.add ("L");
values.add(BNF_ATA); pstm.add ("L");
//values.add(BNF_ADA); pstm.add ("L");
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