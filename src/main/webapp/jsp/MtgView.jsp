<%@ include file="includeHeaderPageDLTFC.jsp" %>
<p>
<p>
<p>
<p>

<form  method="post" name="form1" >
  <%
	 String id;
	 String dist;
	String mtgDate;
	 String mtgPlace;
			String OFF_CD= (String) session.getAttribute("sOffCd");

try {
DBCon db= new DBCon();
db.connect();
  
			
		StringBuffer qrysb= new StringBuffer();
		
		
qrysb.append("   SELECT A.MTG_ID,to_Char(A.MT_DATE,'dd-mon-yyyy') as mt_date,"      );
qrysb.append("   A.MTG_PLACE,B.DISTRICT_NAME,"      );
qrysb.append("   SUM(DECODE(AD.MTG_ID,NULL,0,1)) AS FORD_DLTFC,"      );
qrysb.append("   SUM(CASE WHEN AD.ACT_ID IN (4,5) THEN 1 ELSE 0 END) AS APPROVED,"      );
qrysb.append("   SUM(CASE WHEN AD.ACT_ID NOT IN (4,5,7) THEN 1 ELSE 0 END) AS PENDING_AR,"      );
qrysb.append("   SUM(DECODE(AD.ACT_ID,7,1,0)) AS REJECTED"      );
qrysb.append("   FROM APP_MEETING_MAST A,M_DISTRICT B,APP_DETAIL AD"      );
qrysb.append("   WHERE A.DISTRICT_CD=B.DISTRICT_CD AND A.OFF_CD=?"      );
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
          <td colspan="12" ><div align="center">Task Force Committee Meeting wise data Update Updation </div></td>
        </tr>
        <tr bgcolor="#99CCCC" >
          <td rowspan="2" ><div align="center">Meeting ID </div></td>
          <td rowspan="2" ><div align="center">Meeting Date </div></td>
          <td rowspan="2" ><div align="center">Place</div></td>
          <td rowspan="2" ><div align="center">District</div></td>
          <td rowspan="2" ><div align="center"><a class="greenButtonRound" href="javascript: mypopup('mtg_add.jsp','','850','500');" >Add Meeting  </a> </div></td>
          <td colspan="7" ><div align="center">District Level Task Force Committee (DLTFC) </div></td>
        </tr>
        <tr bgcolor="#99CCCC" >
          <td ><div align="center">Forwarded to DLTFC </div></td>
          <td >Pending </td>
          <td > <div align="center">Approved </div></td>
          <td > <div align="center">Rejected</div></td>
          <td ><div align="center">Status Update </div></td>
          <td colspan="2" ><div align="center">DLTFC Minutes of Meeting </div></td>
        </tr>
  <% 
  String param="";
  while (rs.next()){
  param="MTG_ID="+rs.getString("MTG_ID");
  %>
   <tr >
          <td ><%=  rs.getString("MTG_ID")%></td>
          <td ><%= rs.getString("mt_date") %></td>
          <td ><%= rs.getString("MTG_PLACE") %></td>
          <td ><%=rs.getString("DISTRICT_NAME")  %></td>
          <td ><div align="center"><a href="javascript: mypopup('mtg_add.jsp','<%= param %>','850','600');" class="greenButtonRound">Update</a></div></td>
          <td ><div align="center"><a href="#"><%=rs.getString("FORD_DLTFC")  %></a></div></td>
          <td ><a href="#"><%=rs.getString("PENDING_AR")  %></a></td>
      <td ><div align="center"><a href="#"><%=rs.getString("APPROVED")  %></a></div></td>
          <td ><div align="center"><a href="#"><%=rs.getString("REJECTED")  %></a></div></td>
          <td ><a href="dltfcAppwiseUpdate.jsp?MTG_ID=<%= rs.getString("MTG_ID") %>" class="greenButtonRound">Update</a></td>
          <td >
		  
		    <a href="PMEGPGenAppForm.jsp?RNAME=DLTFC_MINUTES&APP_ID=<%= rs.getString("MTG_ID") %>" class="greenButtonRound">View  </a>
		  </td>
          <td ><div align="center"><a href="#" class="greenButtonRound">Send eMail  </a></div></td>
   </tr>
  <%
   }//end while
   
    rs.close();
  db.close();
    %>
  <tr >
    <th colspan="12" >&nbsp;</th>
  </tr>
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
