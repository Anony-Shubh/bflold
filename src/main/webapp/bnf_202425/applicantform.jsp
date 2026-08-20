<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<html>
<head>
<title>
</title>
<link rel="stylesheet" type="text/css" href="../css/bnfstylesheet.css">

<script language="javascript">

function submitform() {
var PH_KVIC= document.form.PH_KVIC.value;
var FIN_KVIC= document.form.FIN_KVIC.value;
var PH_KVIB= document.form.PH_KVIB.value;
var FIN_KVIB= document.form.FIN_KVIB.value;
var PH_DIC= document.form.PH_DIC.value;
var FIN_DIC= document.form.FIN_DIC.value;
var BNF_PLACE = document.form.BNF_PLACE.value;
var ADD_RMRK = document.form.ADD_RMRK.value;
var TR_DATE = document.form.TR_DATE.value;

document.form.ins.value='I';
alert ("Save");
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
String BUD_ID = request.getParameter("PBUDID")==null?"0":(String)request.getParameter("PBUDID");;

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
String REMARK = "";
String BNF_ATARGET = "";

String BNF_HDID ="";
String BNF_SUB_HEAD_LONG_DESC="";
String add_update="I";

DBCon db= new DBCon();
db.connect();

if (!BNF_AID.equals("")) {

 StringBuffer qrysb = new StringBuffer();
 
 qrysb.append("   SELECT BA.BNF_AID,"      );
qrysb.append("     BA.BNF_ASTFFNME,"      );
qrysb.append("     BA.BNF_ASTFFDSGNTN,"      );
qrysb.append("     BA.BNF_ASTFFCNTCT,"      );
qrysb.append("     BA.BNF_APLACE,"      );
qrysb.append("     BA.BNF_APROGDTLS,"      );
qrysb.append("     BA.BNF_ATOURDYS,"      );
qrysb.append("     BA.BNF_AFROMDT,"      );
qrysb.append("     BA.BNF_ATODT,"      );
qrysb.append("     BA.BNF_TYPPUBLICITY,"      );
qrysb.append("     BA.BNF_NOOFPARTCPNTS,"      );
qrysb.append("     BA.BNF_ACLBNAME,"      );
qrysb.append("     BA.BNF_ADA,"      );
qrysb.append("     BA.BNF_ATA,"      );
qrysb.append("     BA.BNF_ATARGET,"      );
qrysb.append("     BA.BNF_AGENCY,"      );
qrysb.append("     BA.REMARK"      );
qrysb.append("   FROM BNF_APPLICANTS BA"      );
qrysb.append("   WHERE BA.BNF_AID=?;"      );

 values.add(BNF_AID);

ResultSet rsMain = db.executeSQL(qrysb.toString(),values);

values.clear();

while (rsMain.next()){

BNF_AID=rsMain.getString("BNF_AID")==null?"":rsMain.getString("BNF_AID");
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
BNF_AGENCY=rsMain.getString("BNF_AGENCY")==null?"":rsMain.getString("BNF_AGENCY");
REMARK=rsMain.getString("REMARK")==null?"":rsMain.getString("REMARK");
BNF_ATARGET=rsMain.getString("BNF_ATARGET")==null?"":rsMain.getString("BNF_ATARGET");

add_update="U";
}
rsMain.close();

}

out.print (BUD_ID);
%>

  <table>
<tr>
  <td colspan="2"><div align="center">Data Entry Form 2018-19 </div></td>
  </tr>
<tr>
  <td width="24%"> Budget / Target Head : </td>
  <td><label>
    <input type="text" name="textfield6">
  </label></td>
</tr>
<tr><td>  Budget ID  
   <input name="ins" type="hidden" id="ins"></td>
</td>
<td><input type="text" name="textfield62"></td>
</tr>  
  
<tr>
  <td>Office Code
    
    
    :</td>
  <td><input type="text" name="textfield63"></td>
</tr>
<tr>
  <td>Target Allocated : </td>
  <td><input name="BNF_ATARGET" type="text" id="BNF_ATARGET" value="<%= BNF_ATARGET %>" ></tr>
<tr>
  <td>Name of the staff and designation : </td>
  <td>Name : 
    <label>
    <input name="BNF_ASTFFNME" type="text" id="BNF_ASTFFNME" value="<%= BNF_ASTFFNME %>" >
    </label>
    Designation :
    <input name="BNF_ASTFFDSGNTN" type="text" id="BNF_ASTFFDSGNTN" value="<%= BNF_ASTFFDSGNTN %>" >
Contact no. :
   <input name="BNF_ASTFFCNTCT" type="text" id="BNF_ASTFFCNTCT" value="<%= BNF_ASTFFCNTCT %>" > </tr>
<tr>
  <td>Place of visit : </td>
  <td><input name="BNF_APLACE" type="text" id="BNF_APLACE" value="<%= BNF_APLACE %>" ></tr>
<tr>
  <td>Programme detail : </td>
  <td><label>
   <input name="BNF_APROGDTLS" type="textarea" id="BNF_APROGDTLS" value="<%= BNF_APROGDTLS %>" >
  </label></td>
</tr>
<tr>
  <td><p>Tour sanctioned for No. of days : </p>    </td>
  <td><input name="BNF_ATOURDYS" type="textarea" id="BNF_ATOURDYS" value="<%= BNF_ATOURDYS %>" ></td>
</tr>
<tr>
  <td>Date (from to) : </td>
  <td>From : 
   <input name="BNF_AFROMDT" type="date" id="BNF_AFROMDT" value="<%= BNF_AFROMDT %>" >
    To : 
    <input name="BNF_ATODT" type="date" id="BNF_ATODT" value="<%= BNF_ATODT %>" ></td>
</tr>
<tr>
  <td>Type of Publicity : </td>
  <td> <input name="BNF_TYPPUBLICITY" type="text" id="BNF_TYPPUBLICITY" value="<%= BNF_TYPPUBLICITY %>" ></td>
</tr>


<tr>
  <td>Agency Type: </td>
  <td><table width="200">
    <tr>
      <td><label>
        <input name="BNF_AGENCY" type="radio" name="Agency type" value="BNF_AGENCY">
        KVIC</label></td>
    </tr>
    <tr>
      <td><label>
        <input name="BNF_AGENCY" type="radio" name="Agency type" value="BNF_AGENCY">
        KVIB</label></td>
    </tr>
    <tr>
      <td><label>
        <input name="BNF_AGENCY" type="radio" name="Agency type" value="BNF_AGENCY">  DIC</label></td>
    </tr>
  </table>
  </td>
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
  <td>Expenditure incurred  : </td>
  <td>TA: 
    <input name="BNF_ADA" type="text" id="BNF_ADA" value="<%= BNF_ADA %>" >
     DA: 
     <input name="BNF_ATA" type="text" id="BNF_ATA" value="<%= BNF_ATA %>" ></td>
</tr>

<tr>
  <td>Remark : </td>
  <td><label>
  <input name="REMARK" type="textarea" id="REMARK" value="<%= REMARK %>" >
  </label></td>
  </tr>
<tr> <td colspan="2"><label>
<div align="center">
  <input name="Button" type="button" class="button" onClick="submitform();" value="SAVE">
</div>
</label></td> </tr>  
</table>

<%
//out.print (ins);
if (ins.equals("I")) {

BNF_AID=(String) request.getParameter("BNF_AID")==null?"0":(String) request.getParameter("BNF_AID").trim();
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
BNF_ADA=(String) request.getParameter("BNF_ADA")==null?"":(String) request.getParameter("BNF_ADA").trim();
BNF_ATA=(String) request.getParameter("BNF_ATA")==null?"":(String) request.getParameter("BNF_ATA").trim();
BNF_ATARGET=(String) request.getParameter("BNF_ATARGET")==null?"":(String) request.getParameter("BNF_ATARGET").trim();
BNF_AGENCY=(String) request.getParameter("BNF_AGENCY")==null?"":(String) request.getParameter("BNF_AGENCY").trim();
REMARK=(String) request.getParameter("REMARK")==null?"":(String) request.getParameter("REMARK").trim();

		List pstm=new ArrayList();
		StringBuffer qryUpdate = new StringBuffer();
		values.clear();
		pstm.clear();
		if (add_update.equals("I")) {
		
String maxId="SELECT NVL(MAX(BNF_AID),0)+1 AS BNF_AID FROM BNF_APPLICANTS" ;
ResultSet rsMax=db.execSQL(maxId);
while (rsMax.next()){
BNF_AID=rsMax.getString("BNF_AID")==null?"":rsMax.getString("BNF_AID");
}


rsMax.close();

qryUpdate.append("INSERT INTO BNF_APPLICANTS ( ");
qryUpdate.append("BNF_AID,");
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
qryUpdate.append("BNF_ADA,");
qryUpdate.append("BNF_ATA,");
qryUpdate.append("BNF_ATARGET,");
qryUpdate.append("BNF_AGENCY,");
qryUpdate.append("REMARK");
qryUpdate.append(" ) VALUES (?,?,?,?, ?,?,?,?,?,?,?,?,?,?,?,?,?)");
}


//out.print (qryUpdate.toString());
values.add(BNF_AID); pstm.add ("L");
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
values.add(BNF_ADA); pstm.add ("L");
values.add(BNF_ATA); pstm.add ("L");
values.add(BNF_ATARGET); pstm.add ("L");
values.add(BNF_AGENCY); pstm.add ("L");
values.add(REMARK); pstm.add ("L");


db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.close();

response.sendRedirect("savemsg.jsp");
}

%>
</form>
</body>
</html>