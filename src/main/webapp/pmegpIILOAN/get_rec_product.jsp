<%@ page session="true" buffer="500kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,kimisPackage.DBCon"  %>
<html>
<head>
<title>
Tailoring Order Add/Update Form</title>
<link rel="stylesheet" type="text/css" href="../stylesheets/pmegpNew.css" />



<style type="text/css">
<!--
.style13 {font-size: 16px}
.style4 {font-size: 14px; color: #990000; }
-->
</style>
</head>
<body>
  <%
	String ID3 = "";
String GSINV_NO = (String) request.getParameter("GSINV_NO")==null?"0":(String) request.getParameter("GSINV_NO").trim();
String CUSTCODE=(String)session.getAttribute("SCUSTCODE");
String TREC_TRID= (String) request.getParameter("TREC_TRID")==null?"0":(String) request.getParameter("TREC_TRID").trim();

String ID3_NAME="";
String ID3_STR="";
String COUNTERID = "";
String COMPUTERID = "";
String PIECES = "";
String QUANTITY = "";
String RATE = "";
String MARRATE = "";
String RESER = "";
String TCHRGS = "";
String MARGIN = "";
String ESTB = "";
String COMM = "";
String TAX = "";
String EXTRARATE = "";

String INSURANCE = "";
String CUTTING_CHRGS = "";
String IRONING_CHRGS = "";
String PACKING_CHRGS = "";
String MAINTEN_CHRGS = "";
String ELECTR_CHRGS = "";
String ACCESSORY_CHRGS = "";
String INCENTIVE_CHRGS = "";
String OTHER_CHRGS = "";

String RCVDATE = "";
String RTIMESTAMP = "";
String PTREC_TRID="";
String COUNT_MESUR="";


String GST_PER="0";
String GST_ON_AMT="0";
String GST_PER_MAX="0";

String TAXABLENET="";
String CGST_PER="";
String SGST_PER="";
String IGST_PER="";
String CGST_AMT="";
String SGST_AMT="";
String IGST_AMT="";
String PAYABLENET="";
String HSNCODE="";
String REB_MDISC="";
String TORD_DT="";
String COU_ME="";
String PCS="";
String QTY="";
String UPDINS="";
String SIZE_UNIT="";
String CONS_PER_UNIT="";
String TOT_CONS="";

DBCon db= new DBCon();
db.connect();

	 List values=new ArrayList();	

 StringBuffer sb = new StringBuffer();

sb.append("  SELECT  TO_CHAR(TORD_DT,'DD-MON-YYYY') TORD_DT ,TO_CHAR(SYSDATE,'DD-MON-YYYY') RCVDATE from TAILMAST WHERE GSINV_NO="+GSINV_NO+" "      );

 ResultSet mn = db.executeSQL(sb.toString(),values);

				while (mn.next()){

TORD_DT=mn.getString("TORD_DT")==null?"":mn.getString("TORD_DT");
RCVDATE=mn.getString("RCVDATE")==null?"":mn.getString("RCVDATE");

}
mn.close();

 StringBuffer sbqry = new StringBuffer();

sbqry.append("  SELECT  t.CONS_PER_UNIT,t.SIZE_UNIT, T.COMPUTERID,  t.pieces,     t.quantity,     t.id3,     id3.id3_name,UC.COUNT_MESUR,t.CONS_PER_UNIT *  t.pieces as TOT_CONS FROM     tail_rectrans t     ,id3 ,UQC_MAST UC WHERE     t.trec_trid = "+TREC_TRID+" AND  t.id3 = id3.id3 AND UC.UQC_ID=id3.UQC_ID	"      ); 


 ResultSet mnQry = db.executeSQL(sbqry.toString(),values);

				while (mnQry.next()){
				TOT_CONS=mnQry.getString("TOT_CONS")==null?"":mnQry.getString("TOT_CONS");
				CONS_PER_UNIT=mnQry.getString("CONS_PER_UNIT")==null?"":mnQry.getString("CONS_PER_UNIT");
SIZE_UNIT=mnQry.getString("SIZE_UNIT")==null?"":mnQry.getString("SIZE_UNIT");
PCS=mnQry.getString("pieces")==null?"":mnQry.getString("pieces");
QTY=mnQry.getString("quantity")==null?"":mnQry.getString("quantity");
ID3=mnQry.getString("id3")==null?"":mnQry.getString("id3");
ID3_NAME=mnQry.getString("id3_name")==null?"":mnQry.getString("id3_name");
COU_ME=mnQry.getString("COUNT_MESUR")==null?"":mnQry.getString("COUNT_MESUR");
COMPUTERID=mnQry.getString("COMPUTERID")==null?"":mnQry.getString("COMPUTERID");
UPDINS="1";
}
mnQry.close();



%>
  <table width="80%" align="center"  >
    <tr bgcolor="#FFFFFF">
      <th colspan="4"><div align="center"><span class="style13">Add Received Product </span></div></th>
    </tr>
    <tr bgcolor="#FFFFFF">
      <th><div align="left">Receive Date :     
     
                
            <input name="MARRATE" type="hidden" id="MARRATE" value="" >
          <input name="COU_ME" type="hidden" id="COU_ME" value="<%= COU_ME %>" />
         
        <input name="TREC_TRID" type="hidden" id="TREC_TRID" value="<%=TREC_TRID%>"  >
        <input name="GSINV_NO" type="hidden" id="GSINV_NO" value="<%=GSINV_NO%>"  >
        <input name="RTIMESTAMP" type="hidden" id="RTIMESTAMP" value="<%=RTIMESTAMP%>" >
      
       
        <input type="hidden" id="COUNTERID" value="" name="COUNTERID">
      
        <input name="COMPUTERID" type="hidden" id="COMPUTERID" value="<%=COMPUTERID%>" >
        <input name="RATE" type="hidden" id="RATE" value="<%=RATE%>">
      </div></th>
      <td colspan="3"><div align="left">
        <input name="RCVDATE" type="text" id="RCVDATE" onClick="popUpCalendar(this, this.form.RCVDATE,'dd-mmm-yyyy');return false;" value="<%=RCVDATE%>" size="10" maxlength="18" readonly="true" >
      </div></td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <th><div align="left"><span class="style4">Search by  Product Name or Code :</span>
        <input name="ID3S" type="hidden" id="ID3S" value="<%= ID3 %>" />
      </div>        <DIV id="SUP_ST_NM"></DIV></th>
      <td colspan="3"><div align="left">
        <input name="text" type="text" id="Text2"  style="width: 400px; font-size:1.6em;" onFocus="RECPROD();" value="<%= ID3_NAME %>"/>
		<div id="REC_PROD"></div>
      </div></td>
    </tr>
    
    <tr bgcolor="#FFFFFF">
      <th><div align="left">Pcs.</div></th>
      <td>
          <div align="left">
            <input name="PIECES"  type="text"  id="PIECES" value="<%=PCS%>" size="5" maxlength="10"  >
          </div></td>
      <th>Per Piece Consumption  Qty : </th>
      <td><input name="CONS_PER_UNIT"  type="text"  id="CONS_PER_UNIT" value="<%=CONS_PER_UNIT%>" size="5" maxlength="10" ></td>
    </tr>
    
    <tr bgcolor="#FFFFFF">
      <th><div align="left">Qty/Mtr/Kg</div></th>
      <td colspan="3"><div align="left">
          <input name="QUANTITY" type="TEXT" id="QUANTITY" value="<%=QTY%>" size="8" onChange="calcPU_GS();" maxlength="18" <% if (COU_ME.equals("0"))   {out.print("disabled=\"disabled\"");} %>>
      </div></td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <th>Size Unit </th>
      <td colspan="3"><input name="SIZE_UNIT" type="TEXT" id="SIZE_UNIT" value="<%=SIZE_UNIT%>" size="10"  maxlength="10" ></td>
    </tr>
    
    <tr bgcolor="#FFFFFF">
      <td colspan="4"><div align="center">
        <input name="Button" type="button" class="buttonMerun" onClick="submit_update();" value="Next">
        
      </div>      </td>
    </tr>
  </table>
  <p>&nbsp;</p>
</html>