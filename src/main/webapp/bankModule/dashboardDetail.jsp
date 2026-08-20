<%@ page language="java" import="java.sql.*,pkgPmegpNew.DBCon" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
	<title>PMEGP e-Portal Bank Dashboard</title>
	
	
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.22/css/jquery.dataTables.min.css">
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.6.4/css/buttons.dataTables.min.css">
	
	
	<script type="text/javascript" language="javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
	<script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.22/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.6.4/js/dataTables.buttons.min.js"></script>
	<script type="text/javascript" language="javascript" src="https://cdn.datatables.net/buttons/1.6.4/js/buttons.print.min.js"></script>
	
	<style>
	@-webkit-keyframes invalid {
  from { background-color: red; }
  to { background-color: inherit; }
}
@-moz-keyframes invalid {
  from { background-color: red; }
  to { background-color: inherit; }
}
@-o-keyframes invalid {
  from { background-color: red; }
  to { background-color: inherit; }
}
@keyframes invalid {
  from { background-color: red; }
  to { background-color: inherit; }
}
.invalid {
  -webkit-animation: invalid 3s infinite; /* Safari 4+ */
  -moz-animation:    invalid 3s infinite; /* Fx 5+ */
  -o-animation:      invalid 3s infinite; /* Opera 12+ */
  animation:         invalid 3s infinite; /* IE 10+ */
}

td {
    padding: 1em;
}
}
</style>

	<script type="text/javascript" class="init">
	


$(document).ready(function() {
	$('#example').DataTable( {
		dom: 'Bfrtip',
		buttons: [
			{
				extend: 'print',
				customize: function ( win ) {
					$(win.document.body)
						.css( 'font-size', '10pt' )
						

					$(win.document.body).find( 'table' )
						.addClass( 'compact' )
						.css( 'font-size', 'inherit' );
				}
			}
		]
	} );
} );



	</script>
</head>
<body>

	<%

String user_id=(String) session.getAttribute("bank_id"); 
String T =request.getParameter("T")==null?"":(String)request.getParameter("T");
DBCon db= new DBCon();
db.connect();
String vcls="";
if (T.equals("ALL")) {
vcls= vcls+" AND TRUNC(ad.BANK_F_DATE) BETWEEN '01-APR-2016' AND SYSDATE AND ad.ACT_YN='Y' ";
}
if (T.equals("UP")) {
vcls= vcls+" AND  NVL(bd.ACT_ID, 0) in( 0,8) AND SysDate - TRUNC(ad.BANK_F_DATE) <= 30 AND ad.ACT_YN='Y' "; 
}
if (T.equals("RJ")) {
vcls= vcls+" AND bd.ACT_ID = 3 AND ad.ACT_YN='Y'  ";
}
if (T.equals("BS")) {
vcls= vcls+"  AND bd.ACT_ID > 10  AND ad.ACT_YN='Y' ";
}
if (T.equals("MC")) {
vcls= vcls+" AND bd.MM_CLAIM_AMT > 0 AND bd.LOAN_DOCFNAME IS NOT NULL AND bd.ACT_ID  >= 11  AND ad.ACT_YN='Y'";
}
if (T.equals("PD")) {
vcls= vcls+"  AND  nvl(bd.ACT_ID,0) IN( 0,8) AND SYSDATE-TRUNC(ad.BANK_F_DATE) > 30 AND ad.ACT_YN='Y' ";
}
if (T.equals("PC")) {
vcls= vcls+" AND  BD.ACT_ID=11 AND BD.LOAN_DOCFNAME IS NULL AND BD.MM_CLAIM_DT IS NULL  AND ad.ACT_YN='Y'";
}





StringBuffer qrysb= new StringBuffer();
qrysb.append("   SELECT AD.APP_ID,"      );
qrysb.append("     AD.APP_NAME,nvl(ad.MACHINARY_COST,0)+nvl(ad.WORKING_CAPITAL,0) PRJ_COST,TRUNC(SYSDATE)-TRUNC(ad.BANK_F_DATE) AS NO_OF_DAYS,  "      );
qrysb.append("      CASE"      );
qrysb.append("       WHEN AD.ACT_ID = 5"      );
qrysb.append("       THEN ROUND(mminvolve(AD.APP_ID) / 100000, 2)"      );
qrysb.append("       WHEN BD.ACT_ID >= 11"      );
qrysb.append("       THEN ROUND(MM_AMT_BANKSANC(BD.APP_ID) / 100000, 2)"      );
qrysb.append("       WHEN BD.MM_CLAIM_AMT  > 0"      );
qrysb.append("       AND BD.LOAN_DOCFNAME IS NOT NULL"      );
qrysb.append("       AND BD.ACT_ID        >= 11"      );
qrysb.append("       THEN ROUND(BD.MM_CLAIM_AMT / 100000, 2)"      );
qrysb.append("       WHEN BD.MM_REL_DT IS NOT NULL"      );
qrysb.append("       AND BD.ACT_ID     >= 11"      );
qrysb.append("       AND BD.PACT_ID     = 34"      );
qrysb.append("       AND BD.APPRV_YN    = 'A'"      );
qrysb.append("       THEN ROUND(BD.MM_REL_AMT / 100000, 2)"      );
qrysb.append("     END AS MM_INVOLVE,"      );
qrysb.append("      CASE"      );
qrysb.append("       WHEN AD.IND_TYPE = 'M'"      );
qrysb.append("       THEN 'MANUFACTURING'"      );
qrysb.append("       WHEN AD.IND_TYPE = 'T'"      );
qrysb.append("       THEN 'TRADING'"      );
qrysb.append("       WHEN AD.IND_TYPE = 'S'"      );
qrysb.append("       THEN 'SERVICING'"      );
qrysb.append("     END AS IND_TYPE,"      );
qrysb.append("    am.ACTIVITY_NAME"      );
qrysb.append("     || ' / '"      );
qrysb.append("     || ad.PROD_DESC AS ACTIVITY_NAME"      );
qrysb.append("   FROM APP_DETAIL AD,"      );
qrysb.append("     BANK_DATAENTRY BD,activity_mast am,"      );
qrysb.append("     ind_grp_mast igm"      );
qrysb.append("   WHERE AD.APP_ID   = BD.APP_ID(+)"      );
qrysb.append("   AND ad.ACTIVITY_CD      = am.ACTIVITY_CD"      );
qrysb.append("   AND am.IND_GRP_CD       = igm.IND_GRP_CD"      );
qrysb.append("   AND AD.ACT_ID=5 "+vcls+"  "      );
qrysb.append("        AND AD.IFSC_CODE='"+user_id+"' "      );
qrysb.append("   "      );

out.print("Query  -"+qrysb.toString());
ResultSet rsApp = db.execSQL(qrysb.toString());
String APP_ID="";
String APP_NAME="";
String MMINV="";
String MOB_NO1="";
String PRJ_COST="";

String IFSC_CODE="";
String DISTRICT_NAME="";
String BENF_TYPE_DESC="";
String BENF_CATEGORY_DESC="";
String IND_GRP_LONG_DESC="";
String ACTIVITY_NAME="";
String NO_OF_DAYS="";




	int edpcount=0;




%>
		<div align="center"><a href="BankHomePage.jsp"  class="greenButtonRound">Back</a></div>
		
					<table id="example" class="display" style="width:100%">
						<thead>
							<tr>
								 <th>Sr.No</th>
                <th>ID</th>
                <th>Name</th>               
                <th>Project cost</th>
<% if (T.equals("PD")){%>
				<th>Days Since Pending</th>
				<%}%>				
				 <th>Industry Type</th>
                <th>Activity</th>
							</tr>
						</thead>
						<tbody>
						<%
		while (rsApp.next()){
APP_ID=rsApp.getString("APP_ID")==null?"":rsApp.getString("APP_ID");
APP_NAME=rsApp.getString("APP_NAME")==null?"":rsApp.getString("APP_NAME");
MMINV=rsApp.getString("MM_INVOLVE")==null?"":rsApp.getString("MM_INVOLVE");
//MOB_NO1=rsApp.getString("MOB_NO1")==null?"":rsApp.getString("MOB_NO1");
PRJ_COST=rsApp.getString("PRJ_COST")==null?"":rsApp.getString("PRJ_COST");

NO_OF_DAYS=rsApp.getString("NO_OF_DAYS")==null?"":rsApp.getString("NO_OF_DAYS");
//DISTRICT_NAME=rsApp.getString("DISTRICT_NAME")==null?"":rsApp.getString("DISTRICT_NAME");
//BENF_TYPE_DESC=rsApp.getString("BENF_TYPE_DESC")==null?"":rsApp.getString("BENF_TYPE_DESC");
//BENF_CATEGORY_DESC=rsApp.getString("BENF_CATEGORY_DESC")==null?"":rsApp.getString("BENF_CATEGORY_DESC");
IND_GRP_LONG_DESC=rsApp.getString("IND_TYPE")==null?"":rsApp.getString("IND_TYPE");
ACTIVITY_NAME=rsApp.getString("ACTIVITY_NAME")==null?"":rsApp.getString("ACTIVITY_NAME");
edpcount=edpcount+1;
%><tr>
			 <td><%=edpcount%></td>
                <td><%=APP_ID%></td>
                <td><%=APP_NAME%></td>                
                <td><%=PRJ_COST%></td> 
<% if (T.equals("PD")){%>
				<td class="invalid"><%= NO_OF_DAYS%></td>
				<%}%>				
				 <td><%=IND_GRP_LONG_DESC%></td>
                <td><%=ACTIVITY_NAME%></td>
               
				
             
            </tr>
			
		<% } rsApp.close();db.close();%>
</tbody>
							
					
						<tfoot>
						<tr>
							 <th>Sr.No</th>
                <th>ID</th>
                <th>Name</th>               
                <th>Project cost</th>
<% if (T.equals("PD")){%>
				<th>Days Since Pending</th>
				<%}%>				
				 <th>Industry Type</th>
                <th>Activity</th>
							</tr>
						</tfoot>
					</table>
				</div>
				
				
				
				

	<script type="text/javascript">
				  var _gaq = _gaq || [];
				  _gaq.push(['_setAccount', 'UA-365466-5']);
				  _gaq.push(['_trackPageview']);

				  (function() {
					var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
					ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
					var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
				  })();
	</script>
</body>
</html>