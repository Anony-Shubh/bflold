<%@ page session="true" buffer="300kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon" %>
<html>
<head>
<title>PMEGP Performance Report</title>
<script language="javascript" src="../js1/jquery-1.12.0.min.js"></script>

<link rel="stylesheet" type="text/css" href="css/indexr.css">
<style type="text/css">
<!--
.style1 {color: #CC3333}
-->
</style>
</head>

<body>	

<form name="form1" method="post" action="">
<p>
  <%
 DBCon db= new DBCon();
 int srn =0;
db.connect();
String txtSearch="";

String vUsrnm= (String) session.getAttribute("suser_detail");
String vsZonecd =session.getAttribute("szone")=="ALL"?"%%":(String) session.getAttribute("szone");
String vsAgency=session.getAttribute("sagency")=="ALL"?"%%":(String) session.getAttribute("sagency");
String vsStatecd =session.getAttribute("sstate_cd")=="ALL"?"%%":(String) session.getAttribute("sstate_cd");
vsAgency=vsAgency.equals("ALL")?"%%":vsAgency;
vsZonecd=vsZonecd.equals("ALL")?"%%":vsZonecd;
vsStatecd=vsStatecd.equals("ALL")?"%%":vsStatecd;


String vAgencytit="";
String vsZonetit="";
String vsStatetit="";


txtSearch=" AND MOM.AGENCY_TYPE LIKE '"+vsAgency+"' AND ZM.ZONE_NM LIKE '"+vsZonecd+"' AND MS.STATE_NM LIKE '"+vsStatecd+"'";
//out.print(vsStatecd);

String vAgency=request.getParameter("AGENCY")==null?"%%":(String) request.getParameter("AGENCY");
//out.print (vAgency);
vAgency=vAgency.trim();
String vfields =request.getParameter("REPTP")==null?"0":(String) request.getParameter("REPTP");

//FOR AGENCY WISE LOGIN
vfields=(vsAgency.equals("DIC")||vsAgency.equals("KVIB"))?"3":vfields;
//vfields=vsAgency.equals("KVIC")?"4":vfields;

//out.print(vfields);
vfields=vfields.trim();
String vZonecd =request.getParameter("ZONECD")==null?"%%":(String) request.getParameter("ZONECD");
vZonecd=vZonecd.trim();
String vStatecd =request.getParameter("STATECD")==null?"%%":(String) request.getParameter("STATECD");
vStatecd=vStatecd.trim();

String vOffice =request.getParameter("OFFNAMECD")==null?"%%":(String) request.getParameter("OFFNAMECD");
vOffice=vOffice.trim();

if (vOffice.equals("ALL")||vOffice.equals("null")||vOffice.equals("Total")||vOffice.equals("")||vOffice.equals("%%")){
vOffice="%%";
}




if (vAgency.equals("ALL")||vAgency.equals("null")||vAgency.equals("Total")||vAgency.equals("")||vAgency.equals("%%")){
vAgency="%%";
vAgencytit="ALL";
}else {
vAgencytit=vAgency;
}

if (vZonecd.equals("ALL")||vZonecd.equals("null")||vZonecd.equals("Total")||vZonecd.equals("")||vZonecd.equals("%%")){
vZonecd="%%";
vsZonetit="ALL";
}else {
vsZonetit=vZonecd;
}

if (vStatecd.equals("ALL")||vStatecd.equals("null")||vStatecd.equals("Total")||vStatecd.equals("")||vStatecd.equals("%%")){
vStatecd="%%";
vsStatetit="ALL";
}else {
vsStatetit=vStatecd;
}
if(!(vsAgency.equals("%%"))){
vAgency=vsAgency;
vAgencytit=vsAgency;
}


if(!(vsZonecd.equals("%%"))){
vZonecd=vsZonecd;
vsZonetit=vsZonecd;
}


if(!(vsStatecd.equals("%%"))){
vStatecd=vsStatecd;
vsStatetit=vStatecd;
}

String FromDt=(String) request.getParameter("FROMDT");
String STATECD=(String) request.getParameter("state");
String ToDt=(String) request.getParameter("TODT");
String repnm="pmegpdashboardmr1.jsp";
// 
String vWherecls1="";
String flagC="Y";
String p1="";
String p2="";
String p3="";
String rowcol="";
int lrow=0;
String vnmdw="";
String ReportName="";
String qryField="";
String qryGroup="";
String urladd="";
String urlrep="";
String vWherecls2="";
String vtitle="";
urlrep ="edp.jsp?TODT="+ToDt+"&FROMDT="+FromDt;
 

String ReportDesc="  " ; 
String EDPOFF_CD="";
String STATE_NM="";
String OFF_NAME="";
String PREON_EDP="";

String TOTOF_EDP="";
String TOT_EDP="";
String COMON_EDP="";
String COMOF_EDP="";
String PENON_EDP="";
String PENOF_EDP="";
 
String POSTON_EDP="";
String TOTON_EDP="";
String PREOF_EDP="";
String POSTOF_EDP="";

 StringBuffer qrysb= new StringBuffer();
 
 
 qrysb.append("   SELECT  MS.STATE_NM,MS.STATE_CD,ED.EDPOFF_CD,mom.off_name,"      );
qrysb.append("   "      );
qrysb.append("     SUM(CASE WHEN ED.EDP_TYPE=1 AND TRUNC(ED.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' THEN 1 ELSE 0 END) AS PREON_EDP,"      );
qrysb.append("     SUM(CASE WHEN ED.EDP_TYPE=2 AND TRUNC(ED.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' THEN 1 ELSE 0 END) AS POSTON_EDP,"      );
qrysb.append("      SUM(CASE WHEN ED.EDP_TYPE IN (1,2) AND TRUNC(ED.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' THEN 1 ELSE 0 END) AS TOTON_EDP,"      );
qrysb.append("     SUM(CASE WHEN ED.EDP_TYPE=3 AND TRUNC(ED.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' THEN 1 ELSE 0 END) AS PREOF_EDP,"      );
qrysb.append("     SUM(CASE WHEN ED.EDP_TYPE=4 AND TRUNC(ED.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' THEN 1 ELSE 0 END) AS POSTOF_EDP,"      );
qrysb.append("     SUM(CASE WHEN ED.EDP_TYPE IN (3,4) AND TRUNC(ED.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' THEN 1 ELSE 0 END) AS TOTOF_EDP,"      );
qrysb.append("     SUM(CASE WHEN ED.EDP_TYPE IN (1,2,3,4) AND TRUNC(ED.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"' THEN 1 ELSE 0 END) AS TOT_EDP,"      );
qrysb.append("     SUM(CASE WHEN ED.EDP_TYPE IN (1,2) AND ED.EDP_CERT_DT IS NOT NULL AND TRUNC(ED.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  THEN 1 ELSE 0 END) AS COMON_EDP,"      );
qrysb.append("     SUM(CASE WHEN ED.EDP_TYPE IN (3,4) AND ED.EDP_CERT_DT IS NOT NULL AND TRUNC(ED.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  THEN 1 ELSE 0 END) AS COMOF_EDP,"      );
qrysb.append("     SUM(CASE WHEN ED.EDP_TYPE IN (1,2) AND ED.EDP_CERT_DT IS  NULL AND TRUNC(ED.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  THEN 1 ELSE 0 END) AS PENON_EDP,"      );
qrysb.append("     SUM(CASE WHEN ED.EDP_TYPE IN (3,4) AND ED.EDP_CERT_DT IS  NULL AND TRUNC(ED.EDPTIMESTAMP) BETWEEN '"+FromDt+"' AND '"+ToDt+"'  THEN 1 ELSE 0 END) AS PENOF_EDP"      );
qrysb.append("   FROM app_detail_online ado,"      );
qrysb.append("     edp_conduct_trans ed,"      );
qrysb.append("     m_district md,"      );
qrysb.append("     m_state ms,"      );
qrysb.append("     mas_off_mast mom"      );
qrysb.append("   WHERE ado.APP_ID     = ed.APP_ID"      );
qrysb.append("   AND ado.UNIT_DIST_CD = md.DISTRICT_CD(+)"      );
qrysb.append("   AND md.STATE_CD      = ms.STATE_CD(+)"      );
qrysb.append("   AND ed.EDPOFF_CD     = mom.OFF_CD(+)"      );
qrysb.append("   AND (ed.ACT_YN       = 'Y') and ms.state_cd='"+STATECD+"'  "      );
qrysb.append("   GROUP BY (MS.STATE_NM,ED.EDPOFF_CD,MOM.OFF_NAME,MS.STATE_CD)"      );
qrysb.append("   order by MS.STATE_NM,ED.EDPOFF_CD"      );
 

 

//ResultSet rsinst = db.execSQL(qrysb.toString());
//out.print (qrysb.toString());


// out.print(qrysb.toString());

String ZONE_NM="";
String OFF_NM = "";
String NO_OF_INSTN = "";
String STATE_CD ="";
String off_cd="";





ResultSet rsMain = db.execSQL(qrysb.toString());
%>

 <table align="center">
<tr>
<th colspan="10">User Name:-<%= vUsrnm %></th>
</tr>
<tr>
  <td colspan="10"><div align="center">PMEGP e-Portal online EDP Report </div></td>
</tr>
<tr>
<th>Agency</th>
<td><%=vAgencytit  %></td>
<th>KVIC Zone</th>
<td><%=vsZonetit  %></td>
<th>State</th>
<td><%= vsStatetit %></td>
<th>From Date </th>
<td><%=FromDt  %></td>
<th>To Date </th>
<td><%=ToDt  %></td>
</tr>
</table>


<table border="1" align="center" cellpadding="1" cellspacing="1" bordercolor="#E5E5E5">
<thead>
<tr>
  <th rowspan="2">Row ID</th>
  <th rowspan="2" >State Nane </th>
   <th rowspan="2"  >Training Center Name  </th>
  <th colspan="2"  >Online EDP </th>
  <th rowspan="2" >Total   </th>
  <th colspan="2" >Offline EDP </th>
  <th rowspan="2" >Total   </th>
  <th rowspan="2" >Grand Total  </th>
  <th colspan="2">Completed EDP </th>
  <th colspan="2">Pending EDP </th>
</tr>
<tr>
  <th  >Pre</th>
  <th  >Post</th>
  <th >Pre</th>
  <th >Post</th>
  <th>Online</th>
  <th>Offline</th>
  <th  >ONline</th>
  <th  >offline</th>
</tr>
</thead>
<tbody>
	<%	
	int srno=0;	
	String GROUP1_OLD="";
	String flag="N";
	  while (rsMain.next()) { 	
	 
	  

	  
		STATE_NM=rsMain.getString("STATE_NM")==null?"":rsMain.getString("STATE_NM");
	
	if (!GROUP1_OLD.equals("")){
	flag=	 (!GROUP1_OLD.equals(STATE_NM))?"Y":"N";
	}
EDPOFF_CD=rsMain.getString("EDPOFF_CD")==null?"":rsMain.getString("EDPOFF_CD");
OFF_NAME=rsMain.getString("OFF_NAME")==null?"":rsMain.getString("OFF_NAME");
PENOF_EDP=rsMain.getString("PENOF_EDP")==null?"":rsMain.getString("PENOF_EDP");
PENON_EDP=rsMain.getString("PENON_EDP")==null?"":rsMain.getString("PENON_EDP");
COMOF_EDP=rsMain.getString("COMOF_EDP")==null?"":rsMain.getString("COMOF_EDP");
PREOF_EDP=rsMain.getString("PREOF_EDP")==null?"":rsMain.getString("PREOF_EDP");
PREON_EDP=rsMain.getString("PREON_EDP")==null?"":rsMain.getString("PREON_EDP");
COMON_EDP=rsMain.getString("COMON_EDP")==null?"":rsMain.getString("COMON_EDP");
POSTOF_EDP=rsMain.getString("POSTOF_EDP")==null?"":rsMain.getString("POSTOF_EDP");
POSTON_EDP=rsMain.getString("POSTON_EDP")==null?"":rsMain.getString("POSTON_EDP");
TOTOF_EDP=rsMain.getString("TOTOF_EDP")==null?"":rsMain.getString("TOTOF_EDP");
TOTON_EDP=rsMain.getString("TOTON_EDP")==null?"":rsMain.getString("TOTON_EDP");
TOT_EDP=rsMain.getString("TOT_EDP")==null?"":rsMain.getString("TOT_EDP");
STATE_CD=rsMain.getString("STATE_CD")==null?"":rsMain.getString("STATE_CD");
	
%>	


 <tr>
      </tr>
<% if (flag.equals("Y")){ 

%>
 <tr>
  <td colspan="3"><div align="right"> Total:</div></td>
  <td class="subtotal">&nbsp;</td>
    <td class="subtotal">&nbsp;</td>
    <td class="subtotal">&nbsp;</td>
	 <td class="subtotal">&nbsp;</td>
	  <td class="subtotal">&nbsp;</td>
	   <td class="subtotal">&nbsp;</td>
	    <td class="subtotal">&nbsp;</td> <td class="subtotal">&nbsp;</td> <td class="subtotal">&nbsp;</td>
		 <td class="subtotal">&nbsp;</td>
		  <td class="subtotal">&nbsp;</td>
  </tr>
<%
}//end of if
 GROUP1_OLD=STATE_NM;
srno=srno+1;
%>


<tr>
 <td><div align="center"><%= srno 	 %></div></td>
 <td>	<div align="center"><%=STATE_NM  %>	</div></td>
<td><div align="center"><a href="<%=urlrep%>&state=<%=STATE_CD%>&off_cd=<%=EDPOFF_CD%>"><%=OFF_NAME %></a></div> </td>
<td class="sum"><%=PREON_EDP  %></td>
<td class="sum">	<%=POSTON_EDP  %>	</td>
<td  class="sum"><%=TOTON_EDP  %></td>
<td class="sum">	<%=PREOF_EDP  %>	</td>
<td class="sum"><%=POSTOF_EDP  %></td>
<td  class="sum">	<%=TOTOF_EDP  %>	</td>
<td  class="sum"><%=TOT_EDP  %></td>
<td class="sum">	<%=COMON_EDP  %>	</td>
<td class="sum">	<%=COMOF_EDP  %>	</td>
<td class="sum">	<%=PENON_EDP  %>	</td>
<td class="sum">	<%=PENOF_EDP  %>	</td>
<%
 } //end of while
 rsMain.close();
 db.close();
 
 %>	
 <tr>
  <td colspan="3"><div align="right"> Total:</div></td>
  <td class="subtotal">&nbsp;</td>
    <td class="subtotal">&nbsp;</td>
    <td class="subtotal">&nbsp;</td>
	 <td class="subtotal">&nbsp;</td>
	  <td class="subtotal">&nbsp;</td>
	   <td class="subtotal">&nbsp;</td>
	    <td class="subtotal">&nbsp;</td> <td class="subtotal">&nbsp;</td> <td class="subtotal">&nbsp;</td>
		 <td class="subtotal">&nbsp;</td>
		  <td class="subtotal">&nbsp;</td>
  
  </tr>
 
 	
 </tbody>

</table>

 <script language="javascript" src="../js1/drilldowntotal.js"></script>

</form>


</body>
</html>
