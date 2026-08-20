<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<html>
<head>
<title>REPORT</title>
<link rel="stylesheet" type="text/css" href="../css/bnfstylesheet.css">
</head>



<body>

<img src="../images/04_01.png" width="1001" height="135">


<form method="post" name="form">
<p>
  <%@ include file = "sessionoutinc.jsp" %>
  
  <%



 StringBuffer sb= new StringBuffer();
 
qrysb.append("   SELECT BBM.OFF_CD,"      );
qrysb.append("       NVL(BBM.FIN_AMT_KVIC, 0) AS FIN_AMT_KVIC,"      );
qrysb.append("       NVL(BBM.PHY_NO_KVIC, 0)  AS PHY_NO_KVIC, "      );
qrysb.append("        NVL(BBM.FIN_AMT_KVIB, 0) AS FIN_AMT_KVIB,"      );
qrysb.append("       NVL(BBM.PHY_NO_KVIB, 0)  AS PHY_NO_KVIB, "      );
qrysb.append("        NVL(BBM.FIN_AMT_DIC, 0) AS FIN_AMT_DIC,"      );
qrysb.append("       NVL(BBM.PHY_NO_DIC, 0)  AS PHY_NO_DIC,"      );
qrysb.append("       BBM.BNF_HDID,"      );
qrysb.append("       BBM.BNF_BUDID,"      );
qrysb.append("       BHM.BNF_SUB_HEAD_SH_DESC"      );
qrysb.append("     FROM BNF_BUDGET_MAST BBM,"      );
qrysb.append("       BNF_HEAD_MAST BHM"      );
qrysb.append("     WHERE BBM.BNF_HDID = BHM.BNF_HDID"      );


DBCon db= new DBCon();
db.connect();
ResultSet rs = db.execSQL(sb.toString());
String FIN_AMT_KVIC="";
String PHY_NO_KVIC="";
String FIN_AMT_KVIB="";
String PHY_NO_KVIB="";
String FIN_AMT_DIC="";
String PHY_NO_DIC="";

%>
</p>


</form>

</body>
</html>