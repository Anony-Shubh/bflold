<%@ page session="true"   import="java.io.*,java.util.Date, javax.naming.*,java.sql.*,javax.sql.*,java.util.*,net.sf.jasperreports.engine.*, net.sf.jasperreports.engine.export.*,java.math.BigDecimal"  %>
     
	       <%	
		   String myrul="";
		   String vwherecls="";


		   String vFname=request.getParameter("REPNM")==null?"edpAppDetails":(String)request.getParameter("REPNM");
		 String vsAgency=request.getParameter("AGENCY")==null?"%%":(String)request.getParameter("AGENCY");
		    String pfrom=request.getParameter("FROMDT")==null?"":(String)request.getParameter("FROMDT");
			String pto=request.getParameter("TODT")==null?"":(String)request.getParameter("TODT");
			String vQry=request.getParameter("REPTP")==null?"0":(String)request.getParameter("REPTP");
			String EDP_TYPE=request.getParameter("EDP_TYPE")==null?"":(String)request.getParameter("EDP_TYPE");
			String vsZonecd=request.getParameter("ZONECD")==null?"%%":(String)request.getParameter("ZONECD");
		 String vsStatecd=request.getParameter("STATECD")==null?"%%":(String)request.getParameter("STATECD");
		    String OFF_NAME1=request.getParameter("OFF_NAME1")==null?"%%":(String)request.getParameter("OFF_NAME1");
			String vDISTCD=request.getParameter("DISTCD")==null?"%%":(String)request.getParameter("DISTCD");
			
			//out.print(vsZonecd);
	/*		
			
String vsAgency=request.getParameter("AGENCY")==null?"%%":(String) request.getParameter("AGENCY");
vsAgency=vsAgency.trim();


String vsZonecd =request.getParameter("ZONECD")==null?"%%":(String) request.getParameter("ZONECD");
vsZonecd=vsZonecd.trim();

String vsStatecd =request.getParameter("STATECD")==null?"%%":(String) request.getParameter("STATECD");
vsStatecd=vsStatecd.trim();

String vOffice =request.getParameter("OFFNAMECD")==null?"%%":(String) request.getParameter("OFFNAMECD");
vOffice=vOffice.trim();

if (vOffice.equals("ALL")||vOffice.equals("null")||vOffice.equals("Total")||vOffice.equals("")||vOffice.equals("%%")){
vOffice="%%";
}

if (vsAgency.equals("ALL")||vsAgency.equals("null")||vsAgency.equals("Total")||vsAgency.equals("")||vsAgency.equals("%%")){
vsAgency="%%";
}
if (vsZonecd.equals("ALL")||vsZonecd.equals("null")||vsZonecd.equals("Total")||vsZonecd.equals("")||vsZonecd.equals("%%")){
vsZonecd="%%";
}

if (vsStatecd.equals("ALL")||vsStatecd.equals("null")||vsStatecd.equals("Total")||vsStatecd.equals("")||vsStatecd.equals("%%")){
vsStatecd="%%";
}
if(!(vsAgency.equals("%%"))){
vsAgency=vsAgency;
}


if(!(vsZonecd.equals("%%"))){
vsZonecd=vsZonecd;
}


if(!(vsStatecd.equals("%%"))){
vsStatecd=vsStatecd;

}*/


			
			
			String vQryCode=request.getParameter("QRYCODE")==null?"":(String)request.getParameter("QRYCODE");
			
			if(!vsAgency.equals("Total")){
				vsAgency=vsAgency;				
			}
			else{
				vsAgency="%%";	
			}
			
			if(!vsStatecd.equals("Total")){
				vsStatecd=vsStatecd;				
			}
			else if ((vsStatecd.equals("%%")) || (vsStatecd.equals("Total"))) {
				vsStatecd="%%";	
			}
			
			if(!vDISTCD.equals("Total")){
				vDISTCD=vDISTCD;				
			}
			else if ((vDISTCD.equals("%%")) || (vDISTCD.equals("Total"))) {
				vDISTCD="%%";	
			}
			
			
			 if (vsZonecd.equals("ALL")||vsZonecd.equals("null")||vsZonecd.equals("Total")||vsZonecd.equals("")||vsZonecd.equals("%%")){
				vsZonecd="%%";				
			}
			else{

					vsZonecd=vsZonecd;
			}
			
			
			
			
			
			
			
			
			if (vQry.equals("1")){
				
			if (vQryCode.equals("1")){
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE=1  ";
			}
				if (vQryCode.equals("2")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE=2  ";
			}
			
				if (vQryCode.equals("3")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE IN (1,2)  ";
			}
			
				if (vQryCode.equals("4")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE =3 ";
			}
			
				if (vQryCode.equals("5")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE = 4 ";
			}
			
			if (vQryCode.equals("6")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE IN (3,4)";
			}
			
			if (vQryCode.equals("7")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE IN (3,4,1,2)";
			}
			
				if (vQryCode.equals("8")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE=1 AND ED.EDP_CERT_DT IS NOT NULL ";
			}
			
			
				if (vQryCode.equals("9")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE=2 AND ED.EDP_CERT_DT IS NOT NULL ";
			}
			
			if (vQryCode.equals("10")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE=3 AND ED.EDP_CERT_DT IS NOT NULL ";
			}
			
			if (vQryCode.equals("11")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE=4 AND ED.EDP_CERT_DT IS NOT NULL ";
			}
			
			if (vQryCode.equals("12")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE in (1,3) AND ED.EDP_CERT_DT IS  NULL";
			}
			
			if (vQryCode.equals("13")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE=2 AND ED.EDP_CERT_DT IS  NULL ";
			}
			
			if (vQryCode.equals("14")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE in (2,4) AND ED.EDP_CERT_DT IS  NULL AND BD.ACT_ID=11 ";
			}
			
			if (vQryCode.equals("15")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE=4 AND ED.EDP_CERT_DT IS  NULL ";
			}
			
			if (vQryCode.equals("16")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ad.ACT_ID=5 ";
			}
			
			if (vQryCode.equals("17")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' AND ed.EDP_TYPE IN(1,2) AND bd.act_id=11 and ad.act_id=5  ";
			}
			
			if (vQryCode.equals("18")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' AND ed.EDP_TYPE IN(3,4) AND bd.act_id=11 and ad.act_id=5  ";
			}
			
				
				
//vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and ed.EDP_TYPE="+EDP_TYPE+" ";
			}
			else if (vQry.equals("2")){
				
			if (vQryCode.equals("1")){
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE=1 AND ZM.ZONE_NM LIKE '"+vsZonecd+"'  ";
			}
				if (vQryCode.equals("2")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE=2 AND ZM.ZONE_NM LIKE '"+vsZonecd+"'  ";
			}
			
				if (vQryCode.equals("3")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE IN (1,2) AND ZM.ZONE_NM LIKE '"+vsZonecd+"'  ";
			}
			
				if (vQryCode.equals("4")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE =3  AND ZM.ZONE_NM LIKE '"+vsZonecd+"' ";
			}
			
				if (vQryCode.equals("5")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE = 4 AND ZM.ZONE_NM LIKE '"+vsZonecd+"'  ";
			}
			
			if (vQryCode.equals("6")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE IN (3,4) AND ZM.ZONE_NM LIKE '"+vsZonecd+"' ";
			}
			
			if (vQryCode.equals("7")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE IN (3,4,1,2) AND ZM.ZONE_NM LIKE '"+vsZonecd+"' ";
			}
			
				if (vQryCode.equals("8")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE=1 AND ED.EDP_CERT_DT IS NOT NULL AND ZM.ZONE_NM LIKE '"+vsZonecd+"'  ";
			}
			
			
				if (vQryCode.equals("9")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE=2 AND ED.EDP_CERT_DT IS NOT NULL AND ZM.ZONE_NM LIKE '"+vsZonecd+"' ";
			}
			
			if (vQryCode.equals("10")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE=3 AND ED.EDP_CERT_DT IS NOT NULL AND ZM.ZONE_NM LIKE '"+vsZonecd+"'  ";
			}
			
			if (vQryCode.equals("11")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE=4 AND ED.EDP_CERT_DT IS NOT NULL AND ZM.ZONE_NM LIKE '"+vsZonecd+"'  ";
			}
			
			if (vQryCode.equals("12")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE in (1,3) AND ED.EDP_CERT_DT IS  NULL AND ZM.ZONE_NM LIKE '"+vsZonecd+"' ";
			}
			
			if (vQryCode.equals("13")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE=2 AND ED.EDP_CERT_DT IS  NULL AND ZM.ZONE_NM LIKE '"+vsZonecd+"' ";
			}
			
			if (vQryCode.equals("14")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE in (2,4) AND BD.ACT_ID=11 AND ED.EDP_CERT_DT IS  NULL AND ZM.ZONE_NM LIKE '"+vsZonecd+"' ";
			}
			
			if (vQryCode.equals("15")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE=4 AND ED.EDP_CERT_DT IS  NULL AND ZM.ZONE_NM LIKE '"+vsZonecd+"' ";
			}
				
				if (vQryCode.equals("16")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  AD.ACT_ID=5  AND ZM.ZONE_NM LIKE '"+vsZonecd+"'   ";
			}
			
			if (vQryCode.equals("17")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' AND ed.EDP_TYPE IN(1,2) AND bd.act_id=11 and ad.act_id=5  AND ZM.ZONE_NM LIKE '"+vsZonecd+"' ";
			}
			
			if (vQryCode.equals("18")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' AND ed.EDP_TYPE IN(3,4) AND bd.act_id=11 and ad.act_id=5  AND ZM.ZONE_NM LIKE '"+vsZonecd+"'  ";
			}
				
				
//vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"' AND ZM.ZONE_NM LIKE '"+vsZonecd+"' AND ed.act_yn='Y' //and ed.EDP_TYPE="+EDP_TYPE+"	 ";
			}
			else if (vQry.equals("3")){
				
					if (vQryCode.equals("1")){
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE=1 AND ZM.ZONE_NM LIKE '"+vsZonecd+"'  AND MS.STATE_NM LIKE '"+vsStatecd+"'  ";
			}
				if (vQryCode.equals("2")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE=2 AND ZM.ZONE_NM LIKE '"+vsZonecd+"'  AND MS.STATE_NM LIKE '"+vsStatecd+"'   ";
			}
			
				if (vQryCode.equals("3")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE IN (1,2) AND ZM.ZONE_NM LIKE '"+vsZonecd+"'   AND MS.STATE_NM LIKE '"+vsStatecd+"' ";
			}
			
				if (vQryCode.equals("4")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE =3  AND ZM.ZONE_NM LIKE '"+vsZonecd+"'  AND MS.STATE_NM LIKE '"+vsStatecd+"' ";
			}
			
				if (vQryCode.equals("5")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE = 4 AND ZM.ZONE_NM LIKE '"+vsZonecd+"'  AND MS.STATE_NM LIKE '"+vsStatecd+"'  ";
			}
			
			if (vQryCode.equals("6")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE IN (3,4) AND ZM.ZONE_NM LIKE '"+vsZonecd+"'  AND MS.STATE_NM LIKE '"+vsStatecd+"'  ";
			}
			
			if (vQryCode.equals("7")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE IN (3,4,1,2) AND ZM.ZONE_NM LIKE '"+vsZonecd+"'  AND MS.STATE_NM LIKE '"+vsStatecd+"' ";
			}
			
				if (vQryCode.equals("8")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE=1 AND ED.EDP_CERT_DT IS NOT NULL AND ZM.ZONE_NM LIKE '"+vsZonecd+"'   AND MS.STATE_NM LIKE '"+vsStatecd+"' ";
			}
			
			
				if (vQryCode.equals("9")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE=2 AND ED.EDP_CERT_DT IS NOT NULL AND ZM.ZONE_NM LIKE '"+vsZonecd+"'  AND MS.STATE_NM LIKE '"+vsStatecd+"' ";
			}
			
			if (vQryCode.equals("10")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE=3 AND ED.EDP_CERT_DT IS NOT NULL AND ZM.ZONE_NM LIKE '"+vsZonecd+"'   AND MS.STATE_NM LIKE '"+vsStatecd+"' ";
			}
			
			if (vQryCode.equals("11")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE=4 AND ED.EDP_CERT_DT IS NOT NULL AND ZM.ZONE_NM LIKE '"+vsZonecd+"'  AND MS.STATE_NM LIKE '"+vsStatecd+"'  ";
			}
			
				if (vQryCode.equals("12")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE in (1,3) AND ED.EDP_CERT_DT IS  NULL AND ZM.ZONE_NM LIKE '"+vsZonecd+"'  AND MS.STATE_NM LIKE '"+vsStatecd+"' ";
			}
			
			if (vQryCode.equals("13")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE=2 AND ED.EDP_CERT_DT IS  NULL AND ZM.ZONE_NM LIKE '"+vsZonecd+"'  AND MS.STATE_NM LIKE '"+vsStatecd+"' ";
			}
			
			if (vQryCode.equals("14")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE in (2,4) AND BD.ACT_ID=11 AND ED.EDP_CERT_DT IS  NULL AND ZM.ZONE_NM LIKE '"+vsZonecd+"'  AND MS.STATE_NM LIKE '"+vsStatecd+"' ";
			}
			
			if (vQryCode.equals("15")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE=4 AND ED.EDP_CERT_DT IS  NULL AND ZM.ZONE_NM LIKE '"+vsZonecd+"'  AND MS.STATE_NM LIKE '"+vsStatecd+"' ";
			}
			
			if (vQryCode.equals("16")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  AD.ACT_ID=5  AND ZM.ZONE_NM LIKE '"+vsZonecd+"'  AND MS.STATE_NM LIKE '"+vsStatecd+"' ";
			}
			
			if (vQryCode.equals("17")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' AND ed.EDP_TYPE IN(1,2) AND bd.act_id=11 and ad.act_id=5  AND ZM.ZONE_NM LIKE '"+vsZonecd+"'  AND MS.STATE_NM LIKE '"+vsStatecd+"' ";
			}
			
			if (vQryCode.equals("18")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' AND ed.EDP_TYPE IN(3,4) AND bd.act_id=11 and ad.act_id=5  AND ZM.ZONE_NM LIKE '"+vsZonecd+"'  AND MS.STATE_NM LIKE '"+vsStatecd+"' ";
			}
				
				
				
//vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"' AND MS.STATE_NM LIKE '"+vsStatecd+"' and //ed.act_yn='Y'  AND ZM.ZONE_NM LIKE '"+vsZonecd+"' and ed.EDP_TYPE="+EDP_TYPE+" ";
			}
				else if (vQry.equals("4")){
				
					if (vQryCode.equals("1")){
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE=1 AND ZM.ZONE_NM LIKE '"+vsZonecd+"'  AND MS.STATE_NM LIKE '"+vsStatecd+"'  AND udm.DISTRICT_NAME LIKE '"+vDISTCD+"' ";
			}
				if (vQryCode.equals("2")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE=2 AND ZM.ZONE_NM LIKE '"+vsZonecd+"'  AND MS.STATE_NM LIKE '"+vsStatecd+"' AND udm.DISTRICT_NAME LIKE '"+vDISTCD+"'  ";
			}
			
				if (vQryCode.equals("3")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE IN (1,2) AND ZM.ZONE_NM LIKE '"+vsZonecd+"'   AND MS.STATE_NM LIKE '"+vsStatecd+"' AND udm.DISTRICT_NAME LIKE '"+vDISTCD+"' ";
			}
			
				if (vQryCode.equals("4")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE =3  AND ZM.ZONE_NM LIKE '"+vsZonecd+"'  AND MS.STATE_NM LIKE '"+vsStatecd+"' AND udm.DISTRICT_NAME LIKE '"+vDISTCD+"' ";
			}
			
				if (vQryCode.equals("5")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE = 4 AND ZM.ZONE_NM LIKE '"+vsZonecd+"'  AND MS.STATE_NM LIKE '"+vsStatecd+"' AND udm.DISTRICT_NAME LIKE '"+vDISTCD+"'  ";
			}
			
			if (vQryCode.equals("6")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE IN (3,4) AND ZM.ZONE_NM LIKE '"+vsZonecd+"'  AND MS.STATE_NM LIKE '"+vsStatecd+"' AND udm.DISTRICT_NAME LIKE '"+vDISTCD+"' ";
			}
			
			if (vQryCode.equals("7")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE IN (3,4,1,2) AND ZM.ZONE_NM LIKE '"+vsZonecd+"'  AND MS.STATE_NM LIKE '"+vsStatecd+"' AND udm.DISTRICT_NAME LIKE '"+vDISTCD+"' ";
			}
			
				if (vQryCode.equals("8")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE=1 AND ED.EDP_CERT_DT IS NOT NULL AND ZM.ZONE_NM LIKE '"+vsZonecd+"'   AND MS.STATE_NM LIKE '"+vsStatecd+"' AND udm.DISTRICT_NAME LIKE '"+vDISTCD+"' ";
			}
			
			
				if (vQryCode.equals("9")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE=2 AND ED.EDP_CERT_DT IS NOT NULL AND ZM.ZONE_NM LIKE '"+vsZonecd+"'  AND MS.STATE_NM LIKE '"+vsStatecd+"' AND udm.DISTRICT_NAME LIKE '"+vDISTCD+"' ";
			}
			
			if (vQryCode.equals("10")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE=3 AND ED.EDP_CERT_DT IS NOT NULL AND ZM.ZONE_NM LIKE '"+vsZonecd+"'   AND MS.STATE_NM LIKE '"+vsStatecd+"' AND udm.DISTRICT_NAME LIKE '"+vDISTCD+"'";
			}
			
			if (vQryCode.equals("11")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE=4 AND ED.EDP_CERT_DT IS NOT NULL AND ZM.ZONE_NM LIKE '"+vsZonecd+"'  AND MS.STATE_NM LIKE '"+vsStatecd+"'  AND udm.DISTRICT_NAME LIKE '"+vDISTCD+"' ";
			}
			
		if (vQryCode.equals("12")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE in (1,3) AND ED.EDP_CERT_DT IS  NULL AND ZM.ZONE_NM LIKE '"+vsZonecd+"'  AND MS.STATE_NM LIKE '"+vsStatecd+"' AND udm.DISTRICT_NAME LIKE '"+vDISTCD+"' ";
			}
			
			if (vQryCode.equals("13")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE=2 AND ED.EDP_CERT_DT IS  NULL AND ZM.ZONE_NM LIKE '"+vsZonecd+"'  AND MS.STATE_NM LIKE '"+vsStatecd+"' AND udm.DISTRICT_NAME LIKE '"+vDISTCD+"' ";
			}
			
			if (vQryCode.equals("14")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE in (2,4) AND BD.ACT_ID=11 AND ED.EDP_CERT_DT IS  NULL AND ZM.ZONE_NM LIKE '"+vsZonecd+"'  AND MS.STATE_NM LIKE '"+vsStatecd+"'  AND udm.DISTRICT_NAME LIKE '"+vDISTCD+"'";
			}
			
			if (vQryCode.equals("15")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  ED.EDP_TYPE=4 AND ED.EDP_CERT_DT IS  NULL AND ZM.ZONE_NM LIKE '"+vsZonecd+"'  AND MS.STATE_NM LIKE '"+vsStatecd+"' AND udm.DISTRICT_NAME LIKE '"+vDISTCD+"' ";
			}
			
			if (vQryCode.equals("16")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' and  AD.ACT_ID=5  AND ZM.ZONE_NM LIKE '"+vsZonecd+"'  AND MS.STATE_NM LIKE '"+vsStatecd+"' AND udm.DISTRICT_NAME LIKE '"+vDISTCD+"' ";
			}
			
			if (vQryCode.equals("17")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' AND ed.EDP_TYPE IN(1,2) AND bd.act_id=11 and ad.act_id=5  AND ZM.ZONE_NM LIKE '"+vsZonecd+"'  AND MS.STATE_NM LIKE '"+vsStatecd+"' AND udm.DISTRICT_NAME LIKE '"+vDISTCD+"' ";
			}
			
			if (vQryCode.equals("18")) {
 vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"'  and ed.act_yn='Y' AND ed.EDP_TYPE IN(3,4) AND bd.act_id=11 and ad.act_id=5  AND ZM.ZONE_NM LIKE '"+vsZonecd+"'  AND MS.STATE_NM LIKE '"+vsStatecd+"' AND udm.DISTRICT_NAME LIKE '"+vDISTCD+"' ";
			}
				
				
				
//vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"' AND MS.STATE_NM LIKE '"+vsStatecd+"' and //ed.act_yn='Y'  AND ZM.ZONE_NM LIKE '"+vsZonecd+"' and ed.EDP_TYPE="+EDP_TYPE+" ";
			}
			
			
			
			
			else if (vQry.equals("0")){
			
vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"' AND MS.STATE_NM LIKE '"+vsStatecd+"' AND mom.OFF_CD = '"+OFF_NAME1+"' AND ZM.ZONE_NM LIKE  '"+vsZonecd+"' and ed.act_yn='Y'   ";
			}
			

						else if (vQry.equals("5")){
			if (vQryCode.equals("1")) {
vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"' AND MS.STATE_NM LIKE '"+vsStatecd+"' AND mom.off_cd = '"+OFF_NAME1+"' AND ZM.ZONE_NM LIKE  '"+vsZonecd+"' and ed.act_yn='Y' AND udm.DISTRICT_NAME LIKE '"+vDISTCD+"' AND ed.EDP_TYPE   IN (1,3) AND  ed.EDP_CERT_DT IS NULL ";
			}
			
			if (vQryCode.equals("2")) {
vwherecls=vwherecls + " AND MO.AGENCY_TYPE LIKE '"+vsAgency+"' and TRUNC(ED.EDPTIMESTAMP) between '"+pfrom+"' and  '"+pto+"' AND MS.STATE_NM LIKE '"+vsStatecd+"' AND mom.off_cd = '"+OFF_NAME1+"' AND ZM.ZONE_NM LIKE  '"+vsZonecd+"' and ed.act_yn='Y' AND udm.DISTRICT_NAME LIKE '"+vDISTCD+"' AND  bd.act_id=11 AND ed.EDP_TYPE   IN (2,4) AND  ed.EDP_CERT_DT IS NULL ";
			}

						}
	// 	
		  out.print(vwherecls);
		   //out.print(pto);
String vGenID=vFname;
String flag="Y";
Connection conn=null;

ServletContext context = request.getServletContext();
	String folderpath= context.getRealPath("")+"pmegpmr/jasper/";
	
	//opt/tomcat5/webapps/pmegpeportal/jasperrop/
	//String folderpath="/opt/tomcat5/webapps/pmegpeportal/jasperrop/";
	String fileName = folderpath+vFname+".jasper"; 
	Random t = new Random();
	String fnm=vFname+t+".xls";
	//String outFileName =folderpath+"jaspdf/"+edp+rnd+".pdf"; 
	
	String outFileName =folderpath+"jaspxls/"+fnm; 

	try {
   Context ctx=new InitialContext();
Context envCtx = (Context) ctx.lookup("java:comp/env");
 DataSource ds=(DataSource) envCtx.lookup("jdbc/PMEGPDSNEW");
 conn=ds.getConnection(); 
       HashMap hm = new HashMap();
			 hm.put("vcls",vwherecls);
			
			//out.print(vwherecls);
		  JRExporter  exporter = new JRXlsExporter(); 
          JasperPrint jasperPrint = JasperFillManager.fillReport(fileName, hm,conn); 
		  
			JRXlsExporter exporterXLS = new JRXlsExporter();
 exporterXLS.setParameter(JRXlsExporterParameter.JASPER_PRINT, jasperPrint);
  exporterXLS.setParameter(JRXlsExporterParameter.IGNORE_PAGE_MARGINS, Boolean.TRUE); 
 exporterXLS.setParameter(JRXlsExporterParameter.IS_ONE_PAGE_PER_SHEET, Boolean.FALSE);
 exporterXLS.setParameter(JRXlsExporterParameter.IS_DETECT_CELL_TYPE, Boolean.TRUE);
 exporterXLS.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND, Boolean.FALSE);
 exporterXLS.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_COLUMNS, Boolean.TRUE);
  exporterXLS.setParameter(JRXlsExporterParameter.IS_IGNORE_GRAPHICS, Boolean.TRUE); 
 exporterXLS.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, Boolean.TRUE);
 exporterXLS.setParameter(JRExporterParameter.OUTPUT_FILE_NAME,outFileName);
 
 exporterXLS.exportReport();
 myrul="jasper/jaspxls/"+fnm;
 response.sendRedirect(myrul);
 
 //out.print(outFileName);
			conn.close();
			
				}catch (Exception e){
				out.print (e.toString());
				}finally{ 
				try{
				conn.close();
				}catch (Exception e){
				out.print (e.toString());
				}
				}
				
%>
          