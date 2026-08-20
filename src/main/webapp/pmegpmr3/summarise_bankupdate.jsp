<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPMEGP.DBCon"  %>

<html>

<%! 

public double getPer ( double tot,double div1) {
double retval=0.0;
retval=Math.round(((div1/tot)*100) );
return (retval);
}

public String getTit(String p_val) {

if (p_val.equals("%%")){
p_val="ALL";
}
return (p_val);
  }
  
 %>
 <head>
 </head>
<body>
  <%
  
  String vUsrnm= (String) session.getAttribute("suser_detail");
String vsZonecd =session.getAttribute("szone")=="ALL"?"%%":(String) session.getAttribute("szone");
String vsAgency=session.getAttribute("sagency")=="ALL"?"%%":(String) session.getAttribute("sagency");
String vsStatecd =session.getAttribute("sstate_cd")=="ALL"?"%%":(String) session.getAttribute("sstate_cd");
vsAgency=vsAgency.equals("ALL")?"%%":vsAgency;
vsZonecd=vsZonecd.equals("ALL")?"%%":vsZonecd;
vsStatecd=vsStatecd.equals("ALL")?"%%":vsStatecd;
  
  String txtSearch=" AND MOM.AGENCY_TYPE LIKE '"+vsAgency+"' AND ZM.ZONE_NM LIKE '"+vsZonecd+"' AND MS.STATE_NM LIKE '"+vsStatecd+"'  ";

  
 DBCon db= new DBCon();
db.connect();
 int srn =0;

 StringBuffer sb1= new StringBuffer();

String FromDt=(String) request.getParameter("FROMDT");
String ToDt=(String) request.getParameter("TODT");
 
 sb1.append(" SELECT  NVL(InitCap(AD.BANK_NAME),'Total:') AS BANK_NAME,count(*) as app_no_update, " ).
append("  sum(CASE WHEN BDE.act_id>0 THEN " ).
append("  ROUND(MMINVOLVE(BDE.app_id)/100000,2) ELSE 0 END) MMINOVLE," ).
append("  sum(CASE WHEN BDE.act_id=8 THEN 1 ELSE 0 END) NO_UP, " ).
append("  sum(CASE WHEN BDE.act_id=8 THEN ROUND(MMINVOLVE(BDE.app_id)/100000,2) ELSE 0 END) MMINOVLE_UP," ).
append("  sum(CASE WHEN BDE.act_id=3 THEN 1 ELSE 0 END) NO_REJ," ).
append("  sum(CASE WHEN BDE.act_id=3 THEN ROUND(MMINVOLVE(BDE.app_id)/100000,2) ELSE 0 END) MMINOVLE_REJ," ).
append("  sum(CASE WHEN BDE.act_id>10 THEN 1 ELSE 0 END) NO_SANC," ).
append("  sum(CASE WHEN BDE.act_id>10 THEN ROUND(MMINVOLVEBANK(BDE.app_id)/100000,2) ELSE 0 END) MMINOVLE_SANC," ).
 append("  sum(CASE WHEN BDE.act_id>22 THEN 1 ELSE 0 END) MM_CLAIM_NO," ).
 append("  sum(CASE WHEN BDE.act_id>22 THEN ROUND(BDE.mm_claim_amt/100000,2) ELSE 0 END) MM_CLAIM_AMT," ).
 append("  sum(CASE WHEN BDE.act_id>23 THEN 1 ELSE 0 END) MM_REL_NO, " ).
append("   sum(CASE WHEN BDE.act_id>23 THEN ROUND(BDE.mm_claim_amt/100000,2) ELSE 0 END) MM_REL_AMT " ).
append("   FROM bank_dataentry BDE,BANK_DETAIL ABD,app_detail ad , mas_off_mast mom, m_district md ,m_state ms,zone_mast zm where ad.app_id=abd.app_id " ).
append("   and ABD.app_id=BDE.app_id (+) and mom.off_cd=ad.off_cd  and mom.district_cd=md.district_cd and md.state_cd=ms.state_cd and ms.zone_cd=zm.zone_cd " ).
 append("  "+txtSearch+" and  trunc(bde.time_stamp) between '"+FromDt+"' and '"+ToDt+"' " ).
 append("   group by rollup(AD.BANK_NAME)" );
 
 //out.print(sb1.toString());
ResultSet rs1= db.execSQL(sb1.toString());

%>
  <table align="center">
    <tr>
      <th colspan="10">User Name:-<%= vUsrnm %></th>
    </tr>
    <tr>
      <td colspan="10"><div align="center">PMEGP e-Tracking Bank Data Updatation by Branch </div></td>
    </tr>
    <tr>
      <th>Agency</th>
      <td><%= getTit(vsAgency)  %></td>
      <th>KVIC Zone</th>
      <td><%=getTit(vsZonecd)  %></td>
      <th>State</th>
      <td><%= getTit(vsStatecd) %></td>
      <th>Branch Updation Date From </th>
      <td><%=FromDt  %></td>
      <th>To </th>
      <td><%=ToDt  %></td>
    </tr>
  </table>
</p>Note: Click on <strong>BANK UPDATE</strong> button to Refress Data entered by Financing Branches, Data can be altered by Branch untill MM claimed by FB, <br>
So Confirm the Detail from Financing Branch and Update in e-Tracking System so that the same will reflect in  Progress Report of Concerned Office.
<form>
<table width="900" border="2" cellpadding="2" cellspacing="2" bordercolor="#CCCCCC">
  <tr>
      <th rowspan="4">Row Id </th>
      <th rowspan="4">Bank Name </th>
      <th colspan="15">Data Updated by Bank  During Period from <%= FromDt %> to  <%=  ToDt %>  including previous year Projects) </th>
  </tr>
  <tr>
    <th colspan="15">*MM in Lakh and (%) Based on Total Project Updated </th>
  </tr>
  <tr>
    <th colspan="2">Total Projects Updated by Branch </th>
    <th colspan="3">Under Process at Bank </th>
    <th colspan="3">Rejected By bank </th>
    <th colspan="3">Sanctioned By Bank </th>
    <th colspan="2">MM Claimed by Financing Branch</th>
    <th colspan="2">MM Disbursed by Nodal Branch</th>
  </tr>
  <tr>
    <th>In No. </th>
    <th>MM Involve</th>
    <th>In No. </th>
    <th>MM Involve</th>
    <th>%</th>
    <th>In No. </th>
    <th>MM Involve </th>
    <th>%</th>
    <th>In No. </th>
    <th>MM Involve </th>
    <th>%</th>
    <th>In No. </th>
    <th>MM  </th>
    <th>In No. </th>
    <th>MM </th>
  </tr>
   <%
   String addurl="";
  while (rs1.next()) {

  addurl="?FROMDT="+FromDt+"&TODT="+ToDt+"&BANKNAME="+rs1.getString("BANK_NAME");
  srn=srn+1;
  %>
  <tr>
    <td nowrap><%=srn%></td>
    <th nowrap><div align="left"><a href="pmegpBankwiseupdate.jsp<%=addurl  %>" target="_blank"><%=rs1.getString("BANK_NAME")%></a></div></th>
    <td nowrap><div align="right"><%=rs1.getString("APP_NO_UPDATE")%></div></td>
    <td nowrap><div align="right"><%=rs1.getString("MMINOVLE")%></div></td>
    <td nowrap><div align="right"><%=rs1.getString("NO_UP")%></div></td>
    <td nowrap><div align="right"><%=rs1.getDouble("MMINOVLE_UP")%></div></td>
    <td nowrap>
      <div align="right">
        <%out.print (getPer(rs1.getDouble("APP_NO_UPDATE"),rs1.getDouble("NO_UP")));%>
    %</div></td>
    <td nowrap><div align="right"><%=rs1.getString("NO_REJ")%></div></td>
    <td nowrap><div align="right"><%=rs1.getDouble("MMINOVLE_REJ")%></div></td>
    <td nowrap> <div align="right">
        <%out.print (getPer(rs1.getDouble("APP_NO_UPDATE"),rs1.getDouble("NO_REJ")));%>
    %</div></td>
    <td nowrap><div align="right"><%=rs1.getString("NO_SANC")%></div></td>
    <td nowrap><div align="right"><%=rs1.getDouble("MMINOVLE_SANC")%></div></td>
    <td nowrap> <div align="right">
        <%out.print (getPer(rs1.getDouble("APP_NO_UPDATE"),rs1.getDouble("NO_SANC")));%>
    %</div></td>
    <td nowrap><div align="right"><%=rs1.getString("MM_CLAIM_NO")%></div></td>
    <td nowrap><div align="right"><%=rs1.getDouble("MM_CLAIM_AMT")%></div></td>
    <td nowrap><div align="right"><%=rs1.getString("MM_REL_NO")%></div></td>
    <td nowrap><div align="right"><%=rs1.getDouble("MM_REL_AMT")%></div></td>
  </tr>
  <%
  }
 rs1.close();
  
  %>
</table>
</form>
</body>
</html>
  
