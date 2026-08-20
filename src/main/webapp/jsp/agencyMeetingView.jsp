<%@ include file="includeHeaderPage.jsp" %>
<form  method="post" name="form1" >
 <%
			  String id;
	 String dist;
	String mtgDate;
	 String mtgPlace;
			String OFF_CD= (String) session.getAttribute("off_cd");

try {
DBCon db= new DBCon();
db.connect();
  
			
		StringBuffer qrysb= new StringBuffer();
		
		
		qrysb.append("   SELECT A.MTG_ID,to_Char(A.MT_DATE,'dd-mon-yyyy') as mt_date,"      );
qrysb.append("   A.MTG_PLACE,B.DISTRICT_NAME,"      );
qrysb.append("   SUM(DECODE(AD.MTG_ID,NULL,0,1)) AS FORD_DLTFC,"      );
qrysb.append("   SUM(DECODE(AD.ACT_ID,4,1,0)+DECODE(AD.ACT_ID,5,1,0)) AS APPROVED,"      );
qrysb.append("   SUM(DECODE(AD.ACT_ID,7,1,0)) AS REJECTED,"      );
qrysb.append("   SUM(DECODE(AD.ACT_ID,5,1,0)) AS FORWARDED"      );
qrysb.append("   FROM APP_MEETING_MAST A,M_DISTRICT B,APP_DETAIL AD"      );
qrysb.append("   WHERE A.DISTRICT_CD=B.DISTRICT_CD AND AD.OFF_CD=?"      );
qrysb.append("   AND A.MTG_ID=AD.MTG_ID (+)"      );
qrysb.append("   GROUP BY"      );
qrysb.append("   A.MTG_ID,A.MT_DATE ,"      );
qrysb.append("   A.MTG_PLACE,B.DISTRICT_NAME"      );
qrysb.append("   ORDER BY A.MT_DATE DESC"      );

List values = new ArrayList();
values.add(OFF_CD);
   ResultSet rs = db.executeSQL(qrysb.toString(),values);
   values.clear();
  %>
  <table border="4" align="center" cellpadding="3" cellspacing="3" bordercolor="#CCCCCC" class="pmegpTable" >
        <tr >
          <td colspan="11" ><div align="center">DLTFC Meeting Detail and Forwarding to Financing Branch Detail </div></td>
        </tr>
        
        <tr >
          <td rowspan="2" ><div align="center">Meeting ID </div></td>
          <td rowspan="2" ><div align="center">Meeting Date </div></td>
          <td rowspan="2" ><div align="center">Place</div></td>
         <!-- <td rowspan="2" ><div align="center">District</div></td>-->
          <td ><div align="center"> Forwarded to   DLTFC </div></td>
          <td >Proposal For DLTFC Meeting </td>
          <td ><div align="center">Approved by DLTFC</div></td>
          <td ><div align="center">Rejected by DLTFC</div></td>
          <td ><div align="center">Forwarded to Bank </div></td>
          <td colspan="2" rowspan="2" >&nbsp;</td>
        </tr>
 
   <tr >
     <th colspan="5" ><div align="center">(Click on blue Color link  to download the List of Applicant/beneficiary ) </div></th>
    </tr>
    <% 
  String param="";
   String FORWARDED="";
  while (rs.next()){
  param="MTG_ID="+rs.getString("MTG_ID");
  FORWARDED=rs.getString("FORWARDED");
  %>
   <tr >
          <td ><%=  rs.getString("MTG_ID")%></td>
          <td ><%= rs.getString("mt_date") %></td>
          <td ><%= rs.getString("MTG_PLACE") %></td>
          <!--<td ><%//=rs.getString("DISTRICT_NAME")  %></td>-->
          <td ><div align="center"><%=rs.getString("FORD_DLTFC")  %></div></td>
      <td ><div align="center"><a href="MeetingWiseRepGen.jsp?<%= param %>" class="button">Download</a></div></td>
          <td ><div align="center"><%=rs.getString("APPROVED")  %></div></td>
          <td ><div align="center"><%=rs.getString("REJECTED")  %></div></td>
          <td ><div align="center"><%=FORWARDED  %></div></td>
		  <% if (!FORWARDED.equals("0")){ %>
          <td >&nbsp;</td>
          <td >&nbsp;</td>
		  <%}else{  %>
		  <td>-</td>
		   <td>-</td>
		  <%} %>
   </tr>
  <%
   }//end while
   
    rs.close();
  db.close();
    %>
  </table>
		<%
   

   }//try
catch(Exception e)
{out.println(e);}
finally{
//db.close();
}%>
       
      
  
</form>
</body>
</html>
