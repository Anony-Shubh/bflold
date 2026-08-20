<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPMEGP.DBCon"  %>
<%!  
public String getTit(String p_val) {

if (p_val.equals("%%")){
p_val="ALL";
}
return (p_val);
  }
  %>
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/indexr.css">
</head>

<body>
<p>
  <%
 DBCon db= new DBCon();
db.connect();
 int srn =0;

 StringBuffer sb= new StringBuffer();
  StringBuffer sb1= new StringBuffer();

 DecimalFormat dfd = new DecimalFormat("##.## ");

  String vUsrnm= (String) session.getAttribute("suser_detail");
String vsZonecd =session.getAttribute("szone")=="ALL"?"%%":(String) session.getAttribute("szone");
String vsAgency=session.getAttribute("sagency")=="ALL"?"%%":(String) session.getAttribute("sagency");
String vsStatecd =session.getAttribute("sstate_cd")=="ALL"?"%%":(String) session.getAttribute("sstate_cd");
vsAgency=vsAgency.equals("ALL")?"%%":vsAgency;
vsZonecd=vsZonecd.equals("ALL")?"%%":vsZonecd;
vsStatecd=vsStatecd.equals("ALL")?"%%":vsStatecd;
  
  String txtSearch=" AND MOM.AGENCY_TYPE LIKE '"+vsAgency+"' AND ZM.ZONE_NM LIKE '"+vsZonecd+"' AND MS.STATE_NM LIKE '"+vsStatecd+"'  ";



String FromDt=(String) request.getParameter("FROMDT");
String ToDt=(String) request.getParameter("TODT");
String vbankname=(String) request.getParameter("BANKNAME");
vbankname=(vbankname.equals("null")||vbankname.equals("")||vbankname.equals("ALL")||vbankname.equals("Total:"))?"%%":vbankname;
String vbanknametit=vbankname.equals("%%")?"ALL":vbankname;

 
  sb.append(" SELECT  BDE.app_id,BDE.ifsc_code,to_char(bde.bank_rec_dt,'DD-MON-RR') AS BANK_REC, " ).
   append(" (trunc(SYSDATE)-trunc(bde.bank_rec_dt)+1) AS DAYS_ELAPSED, " ).
  append("  mom.agency_type||'-'||mom.off_name1 as off_name, " ).
  append("  bde.act_id,bas.act_desc,BDE.time_stamp, " ).
  append("  CASE WHEN BDE.act_id>0 THEN ROUND(MMINVOLVE(BDE.app_id)/100000,2) ELSE 0 END MMINOVLE, " ). 
  append(" CASE WHEN BDE.act_id>22 THEN ROUND(BDE.mm_claim_amt/100000,2) ELSE 0 END MM_CLAIM_AMT, " ).
   append(" CASE WHEN BDE.act_id>23 THEN ROUND(BDE.mm_claim_amt/100000,2) ELSE 0 END MM_CLAIM_REL " ).
  append(" FROM bank_dataentry BDE,BANK_DETAIL ABD,app_detail ad , " ).
 append("  bank_app_status bas, mas_off_mast mom, m_district md ,m_state ms,zone_mast zm where ad.app_id=abd.app_id and " ).
  append(" ABD.app_id=BDE.app_id (+)  and bde.act_id=bas.act_id " ).
  append(" and mom.off_cd=ad.off_cd and mom.district_cd=md.district_cd and md.state_cd=ms.state_cd and ms.zone_cd=zm.zone_cd " ).
  append(" "+txtSearch+" and trunc(bde.time_stamp) between '"+FromDt+"' and '"+ToDt+"' and InitCap(AD.BANK_NAME) like '"+vbankname+"' " ).
append("   order by bde.time_stamp desc " );
 
// out.print(sb.toString());
ResultSet rs= db.execSQL(sb.toString());



%>
<form name="form1" method="post" action="">
  <div align="right">
    <input name="Submit" type="submit" class="button" onClick="window.print();" value="Print this page">
    <input name="Submit" type="submit" class="button" onClick="window.close();" value="Close">
    <table align="center">
      <tr>
        <th colspan="10">User Name:-<%= vUsrnm %></th>
      </tr>
      <tr>
        <td colspan="10"><div align="center">PMEGP e-Tracking Bank Data Updatation by Branch Detail Report </div></td>
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
  <P></P>
</div>


  <table border="1" cellpadding="2" cellspacing="2" bordercolor="#CCCCCC">
  <tr>
    <th colspan="11" scope="col">Name of the Bank: <%= vbanknametit %> (Data Updated by Bank  During Period from <%= FromDt %> to <%=  ToDt %> ) </th>
  </tr>
  <tr>
    <th scope="col">Sr no </th>
    <th scope="col">Appicant ID </th>
    <th scope="col">IFSC CODE </th>
    <th scope="col">Application Receive Date by Bank </th>
    <th scope="col">No of Days from Date of Receive </th>
    <th scope="col">Sponsored Office / Agency Name </th>
    <th scope="col">Current Status As per Branch Updating </th>
    <th scope="col">MM Involve on Project Cost ( In Lakh) </th>
    <th scope="col">MM Claimed by Financing Branch (In Lakh) </th>
    <th scope="col">MM Disbursed by Nodal Branch (In Lakh) </th>
    <th scope="col">Last Update Date and Time </th>
  </tr>
  <%
  while (rs.next()) {
  srn=srn+1;
  %>
  <tr>
    <td nowrap><%=srn%></td>
    <td nowrap><a href="../uploadbean/bankStatusWiseReportInd.jsp?APP_ID=<%=rs.getString("APP_ID")%>" target="_blank"><%=rs.getString("APP_ID")%></a></td>
    <td nowrap><%=rs.getString("IFSC_CODE")%></td>
    <td nowrap><%=rs.getString("BANK_REC")%></td>
    <td nowrap><%=rs.getString("DAYS_ELAPSED")%></td>
    <td nowrap><%=rs.getString("OFF_NAME")%></td>
    <td nowrap><%=rs.getString("ACT_DESC")%></td>
    <td nowrap><div align="right">
        <% out.print(dfd.format(rs.getDouble("MMINOVLE")));%>
    </div></td>
    <td nowrap><div align="right"> <% out.print(dfd.format(rs.getDouble("MM_CLAIM_AMT")));%></div></td>
    <td nowrap><div align="right"><% out.print(dfd.format(rs.getDouble("MM_CLAIM_REL")));%></div></td>
    <td nowrap><%=rs.getString("TIME_STAMP")%></td>
  </tr>
  <%
  }
 rs.close();
db.close(); 
  
  %>
</table>
</form>
</body>
</html>
  