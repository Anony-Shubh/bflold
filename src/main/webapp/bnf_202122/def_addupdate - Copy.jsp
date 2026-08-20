<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<html>
<head>
<title>PROPOSED ACTION PLAN</title>
<link rel="stylesheet" type="text/css" href="../css/bnfstylesheet.css">
<style type="text/css">
<!--
.style1 {color: #FFFFFF}
-->
</style>
</head>

<style>
body {margin:0;}

.topnav {
  overflow: hidden;
  background-color: #f1f1f1;
}

.topnav a {
  float: right;
  display: block;
  color: black;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  font-size: 17px;
  border-bottom: 3px solid transparent;
}

.topnav a:hover {
  border-bottom: 3px solid red;
}


</style>

<body>

<form method="post" name="form">

<p>
  <%@ include file = "sessionoutinc.jsp" %>
   
  <%
  
List values=new ArrayList();

//if (vlogin.equals("Y")){
StringBuffer qrysb= new StringBuffer();
qrysb.append("   SELECT BFT.OFF_CD,"      );
qrysb.append("     BFT.BNF_TRID,"      );
qrysb.append("     BFT.BUD_ID,"      );
qrysb.append("     BFT.TR_DATE,"      );
qrysb.append("      BFT.FIN_KVIC+BFT.FIN_KVIB+ BFT.FIN_DIC AS FIN_TOTAL,"      );
qrysb.append("     BFT.PH_KVIB+ BFT.PH_KVIC+BFT.PH_DIC AS PH_TOTAL,"      );
qrysb.append("    "      );
qrysb.append("     BFT.CB_FNO,"      );
qrysb.append("     BFT.BNF_PLACE,"      );
qrysb.append("     BFT.ADD_RMRK,"      );
qrysb.append("     BFT.TIMESTAMP"      );
qrysb.append("   FROM BNF_FO_TRANS BFT"      );



DBCon db= new DBCon();
db.connect();


ResultSet rs=db.execSQL(qrysb.toString());

String BNF_TRID = "";
String OFF_CD = "";

String TR_DATE = "";
String PH_KVIC = "";
String PH_KVIB = "";
String PH_DIC = "";
String FIN_KVIC = "";
String FIN_KVIB = "";
String FIN_DIC = "";
String CB_FNO = "";
String BNF_PLACE = "";
String TIMESTAMP = "";
%>
</p>

  <table>
    <tr>
      <td colspan="9"><div align="center">B&amp;F  2018-19 </div></td>
    </tr>
    <tr>
      <td width="24%"> BNF TRID : </td>
      <td width="76%" colspan="8"><%= BNF_TRID %></td>
    </tr>
    <tr>
      <td> Office Code: </td>
      <td colspan="8"><%= OFF_CD %></td>
    </tr>
    
    <tr>
      <td>Total Physical No</td>
      <td colspan="8"><%= TR_DATE %></td>
    </tr>
    <tr>
      <td>Total Financial Amt</td>
      <td colspan="8"><%= PH_KVIC %></td>
    </tr>
    <tr>
      <td>CB FNO</td>
      <td colspan="8"><%= PH_KVIB %></td>
    </tr>
    <tr>
      <td>Date</td>
      <td colspan="8"><%= PH_DIC %></td>
    </tr>
    <tr>
      <td>Place</td>
      <td colspan="8"><%= FIN_KVIC %></td>
    </tr>
    <tr>
      <td>Timestamp</td>
      <td colspan="8"><%= FIN_KVIB %></td>
    </tr>
    
    
    <tr>
      <td colspan="9"><label>
          <div align="center">
            <input name="Button" type="button" class="button" onClick="submitform();" value="SAVE">
          </div>
        </label></td>
    </tr>
  </table>
    <%
int count=0;
while (rs.next()) {
count=count+1;
BNF_TRID=rs.getString("BNF_TRID");
OFF_CD=rs.getString("OFF_CD");

TR_DATE=rs.getString("TR_DATE");
PH_KVIC=rs.getString("PH_KVIC");
PH_KVIB=rs.getString("PH_KVIB");
PH_DIC=rs.getString("PH_DIC");
FIN_KVIC=rs.getString("FIN_KVIC");
FIN_KVIB=rs.getString("FIN_KVIB");
FIN_DIC=rs.getString("FIN_DIC");
CB_FNO=rs.getString("CB_FNO");
BNF_PLACE=rs.getString("BNF_PLACE");
TIMESTAMP=rs.getString("TIMESTAMP");





%>
  <%

}
rs.close();
db.close();
%>

</form>
</body>
</html>