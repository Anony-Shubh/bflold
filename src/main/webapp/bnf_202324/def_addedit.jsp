<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<html>
<head>
<title>
</title>
<link rel="stylesheet" type="text/css" href="../css/bnfstylesheet.css">
<script language="javascript" src="../js1/popcalendar.js"></script>
<script type="text/javascript" src="../js1/inlinemsg.js"></script>
<script type="text/javascript" src="../js1/bnf.js"></script>

<style type="text/css">
<!--
.style1 {color: #FFFFFF}
-->
</style>

</head>
<body onload="calculate_phytotal();calculate_amttotal();">
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

String TR_DATE = "";
String FIN_KVIC = "";
String PH_KVIC = "";
String FIN_KVIB = "";
String FIN_DIC = "";
String PH_KVIB = "";
String PH_DIC = "";
String CB_FNO = "";
String BNF_PLACE = "";
String ADD_RMRK = "";
String TIMESTAMP = "";

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
qrysb.append("     TO_CHAR(BFT.TR_DATE,'DD-MON-RRRR') AS TR_DATE,"      );
qrysb.append("     BFT.PH_KVIC,"      );
qrysb.append("     BFT.FIN_KVIC,"      );
qrysb.append("     BFT.PH_KVIB,"      );
qrysb.append("     BFT.FIN_KVIB,"      );
qrysb.append("     BFT.PH_DIC,"      );
qrysb.append("     BFT.FIN_DIC,"      );
qrysb.append("     BFT.CB_FNO,"      );
qrysb.append("     BFT.BNF_PLACE,"      );
qrysb.append("     BFT.ADD_RMRK,"      );
qrysb.append("     BFT.TIMESTAMP"      );
qrysb.append("   FROM BNF_FO_TRANS BFT"      );
qrysb.append("   WHERE  BFT.BNF_TRID=? AND BFT.OFF_CD=?"      );



  values.add(BNF_TRID);
  values.add(OFF_CD);
 // out.print(qrysb.toString());

ResultSet rsMain = db.executeSQL(qrysb.toString(),values);

values.clear();

while (rsMain.next()){

BNF_TRID=rsMain.getString("BNF_TRID")==null?"":rsMain.getString("BNF_TRID");
BUD_ID=rsMain.getString("BUD_ID")==null?"":rsMain.getString("BUD_ID");
//OFF_CD=rsMain.getString("OFF_CD")==null?"":rsMain.getString("OFF_CD");
TR_DATE=rsMain.getString("TR_DATE")==null?"":rsMain.getString("TR_DATE");
PH_KVIC=rsMain.getString("PH_KVIC")==null?"":rsMain.getString("PH_KVIC");
FIN_KVIC=rsMain.getString("FIN_KVIC")==null?"":rsMain.getString("FIN_KVIC");
PH_KVIB=rsMain.getString("PH_KVIB")==null?"":rsMain.getString("PH_KVIB");
FIN_KVIB=rsMain.getString("FIN_KVIB")==null?"":rsMain.getString("FIN_KVIB");
PH_DIC=rsMain.getString("PH_DIC")==null?"":rsMain.getString("PH_DIC");
FIN_DIC=rsMain.getString("FIN_DIC")==null?"":rsMain.getString("FIN_DIC");
CB_FNO=rsMain.getString("CB_FNO")==null?"":rsMain.getString("CB_FNO");
BNF_PLACE=rsMain.getString("BNF_PLACE")==null?"":rsMain.getString("BNF_PLACE");
ADD_RMRK=rsMain.getString("ADD_RMRK")==null?"":rsMain.getString("ADD_RMRK");
TIMESTAMP=rsMain.getString("TIMESTAMP")==null?"":rsMain.getString("TIMESTAMP");

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
  <td>Transaction Date : </td>
  <td colspan="8"><input name="TR_DATE"  type="text" id="TR_DATE" value="<%=TR_DATE%>" autocomplete="off" onClick="popUpCalendar(this, this.form.TR_DATE,'dd-mmm-yyyy');return false;"/>  
 
</tr>
<tr>
  <td> BNF Place : </td>
  <td colspan="8"><input name="BNF_PLACE"  type="text" id="BNF_PLACE" value="<%=BNF_PLACE%>" autocomplete="off" onKeyPress="return onlyAlphabets(event,this);"></td>
</tr>

<tr>
  <td> Remark : </td>
  <td colspan="8"><input name="ADD_RMRK"  type="text" id="ADD_RMRK" value="<%=ADD_RMRK%>" autocomplete="off"></td>
</tr>

<tr>
  <td hidden> Timestamp : </td>
  <td hidden></td>
</tr>
  
<tr>
  <td rowspan="3">Physical and Financial Target/Budget: </td>
  <td colspan="8">(Amount in Lakhs) </td>
  </tr>
<tr>
  <th colspan="2">KVIC  </th>
  <th colspan="2">KVIB</th>
  <th colspan="2">DIC</th>
  <th colspan="2">TOTAL</th>
  </tr>
<tr>
  <th width="9%">In No. </th>
  <th width="10%">Amount</th>
  <th width="9%">In No. </th>
  <th width="10%">Amount</th>
  <th width="9%">In No. </th>
  <th width="10%">Amount</th>
  <th width="9%">In No. </th>
  <th width="10%">Amount</th>
</tr>
<tr>
  <td>  KVIC Financial Amount :  </td>
  <td><div align="center">
  <input name="PH_KVIC"  type="text" id="PH_KVIC" value="<%=PH_KVIC%>" onKeyPress="return isNumberNoDec(event)"   size="8" maxlength="8" onBlur="calculate_phytotal();" > 
</div></td>
 <td><input name="FIN_KVIC"  type="text"   id="FIN_KVIC" value="<%=FIN_KVIC%>" onKeyPress="javascript:return isNumber(event)" size="10" maxlength="15" onBlur="calculate_amttotal();" ></td>
  
  <td><input name="PH_KVIB"  type="text"  id="PH_KVIB" value="<%=PH_KVIB%>" onKeyPress="return isNumberNoDec(event)" size="8" maxlength="8" onBlur="calculate_phytotal();"></td>
   <td><input name="FIN_KVIB"  type="text"   id="FIN_KVIB" value="<%=FIN_KVIB%>" onKeyPress="javascript:return isNumber(event)" size="10" maxlength="13" onBlur="calculate_amttotal();"></td>
 
  <td><input name="PH_DIC"  type="text"  id="PH_DIC" value="<%=PH_DIC%>" onKeyPress="return isNumberNoDec(event)" size="8" maxlength="8" onBlur="calculate_phytotal();"></td>
  <td><input name="FIN_DIC"  type="text" id="FIN_DIC" value="<%=FIN_DIC%>" onKeyPress="javascript:return isNumber(event)" size="10" maxlength="13" onBlur="calculate_amttotal();"></td>
  <td><input name="PH_TOTAL" type="text" readonly="" id="PH_TOTAL" size="10" maxlength="10" ></td>
  <td> <input name="FIN_TOTAL" type="text" readonly="" id="FIN_TOTAL" size="10" ></td>
</tr>
<tr> <td colspan="9"><label>

</label></td> </tr>  
<tr></tr>
</table>
<br/><div align="center">
  <input name="Button" type="button" class="button" onClick="submitform();" value="SAVE"/>
</div>
<%
//out.print (ins);
if (ins.equals("I")) {

BNF_TRID=(String) request.getParameter("BNF_TRID")==null?"0":(String) request.getParameter("BNF_TRID").trim();
//OFF_CD=(String) request.getParameter("OFF_CD")==null?"":(String) request.getParameter("OFF_CD").trim();
//BUD_ID=(String) request.getParameter("BUD_ID")==null?"":(String) request.getParameter("BUD_ID").trim();
TR_DATE=(String) request.getParameter("TR_DATE")==null?"":(String) request.getParameter("TR_DATE").trim();
PH_KVIC=(String) request.getParameter("PH_KVIC")==null?"":(String) request.getParameter("PH_KVIC").trim();
FIN_KVIC=(String) request.getParameter("FIN_KVIC")==null?"":(String) request.getParameter("FIN_KVIC").trim();
PH_KVIB=(String) request.getParameter("PH_KVIB")==null?"":(String) request.getParameter("PH_KVIB").trim();
FIN_KVIB=(String) request.getParameter("FIN_KVIB")==null?"":(String) request.getParameter("FIN_KVIB").trim();
PH_DIC=(String) request.getParameter("PH_DIC")==null?"":(String) request.getParameter("PH_DIC").trim();
FIN_DIC=(String) request.getParameter("FIN_DIC")==null?"":(String) request.getParameter("FIN_DIC").trim();
CB_FNO=(String) request.getParameter("CB_FNO")==null?"":(String) request.getParameter("CB_FNO").trim();
BNF_PLACE=(String) request.getParameter("BNF_PLACE")==null?"":(String) request.getParameter("BNF_PLACE").trim();
ADD_RMRK=(String) request.getParameter("ADD_RMRK")==null?"":(String) request.getParameter("ADD_RMRK").trim();
//TIMESTAMP=(String) request.getParameter("TIMESTAMP")==null?"":(String) request.getParameter("TIMESTAMP").trim();



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
qryUpdate.append("TR_DATE,");
qryUpdate.append("PH_KVIC,");
qryUpdate.append("FIN_KVIC,");
qryUpdate.append("PH_KVIB,");
qryUpdate.append("FIN_KVIB,");
qryUpdate.append("PH_DIC,");
qryUpdate.append("FIN_DIC,");
qryUpdate.append("CB_FNO,");
qryUpdate.append("BNF_PLACE,");
qryUpdate.append("ADD_RMRK,");
qryUpdate.append("TIMESTAMP,OFF_CD,BUD_ID,BNF_TRID");
qryUpdate.append(" ) VALUES (?,?,?,?, ?,?,?,?,?, ?,sysdate,?,?,?)");
}

else {

qryUpdate.append("UPDATE BNF_FO_TRANS SET ");
qryUpdate.append("TR_DATE=?,");
qryUpdate.append("PH_KVIC=?,");
qryUpdate.append("FIN_KVIC=?,");
qryUpdate.append("PH_KVIB=?,");
qryUpdate.append("FIN_KVIB=?,");
qryUpdate.append("PH_DIC=?,");
qryUpdate.append("FIN_DIC=?,");
qryUpdate.append("CB_FNO=?,");
qryUpdate.append("BNF_PLACE=?,");
qryUpdate.append("ADD_RMRK=?,");
qryUpdate.append("TIMESTAMP=sysdate");
qryUpdate.append(" WHERE OFF_CD=? AND BUD_ID=? AND BNF_TRID=?");

//out.print ("In oupdate"+BNF_TRID);

}

//out.print (qryUpdate.toString());
values.add(TR_DATE); pstm.add ("L");
values.add(PH_KVIC); pstm.add ("L");
values.add(FIN_KVIC); pstm.add ("L");
values.add(PH_KVIB); pstm.add ("L");
values.add(FIN_KVIB); pstm.add ("L");
values.add(PH_DIC); pstm.add ("L");
values.add(FIN_DIC); pstm.add ("L");
values.add(CB_FNO); pstm.add ("L");
values.add(BNF_PLACE); pstm.add ("L");
values.add(ADD_RMRK); pstm.add ("L");
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