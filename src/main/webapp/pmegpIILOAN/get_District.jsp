<%@ page contentType="text/html; charset=iso-8859-1" buffer="200kb" language="java" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon" %>
<%
String state = request.getParameter("state");
DBCon db= new DBCon();
db.connect();

StringBuffer qrysb = new StringBuffer();
		 qrysb.append("  Select district_cd, initCap(district_name) as district_name from m_district where state_cd='"+state+"' and district_status='A'  order by district_name");
		
         ResultSet rsDistrict = db.execSQL(qrysb.toString());	

		    String vdistrictcd = "";
	        String vdistrictname= "";  
			%>
			<option value="">--Select--</option>
			<%
		    while (rsDistrict.next()){	 
	
			  vdistrictcd =rsDistrict.getString("DISTRICT_CD");
	          vdistrictname= rsDistrict.getString("DISTRICT_NAME");
		 %>  
 <option value="<%= vdistrictcd%>"><%= vdistrictname%></option> 
<% 
		}
		rsDistrict.close();
		 %>
