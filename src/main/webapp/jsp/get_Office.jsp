<%@ page contentType="text/html; charset=iso-8859-1" buffer="200kb" language="java" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon" %>
<%
String DIS_CD = request.getParameter("UNIT_DIST_CD");
DBCon db= new DBCon();
db.connect();

StringBuffer qrysb = new StringBuffer();
		qrysb.append("   SELECT MOM.OFF_NAME,MOM.OFF_CD FROM MAS_OFF_MAST MOM ");
		 qrysb.append("   WHERE MOM.OFF_TYPE_CD IN (2, 3, 5, 22,27) AND  " );
		 qrysb.append("   MOM.DISTRICT_CD= " + DIS_CD +" AND MOM.ACT_YN='Y'  ");
		
		 
         ResultSet rsDistrict = db.execSQL(qrysb.toString());	

		    String voffcd = "";
	        String voffname= "";  
			%>
			<option value="">--Select--</option>
			<%
		    while (rsDistrict.next()){	 
	
			  voffcd =rsDistrict.getString("OFF_CD");
	          voffname= rsDistrict.getString("OFF_NAME");
		 %>  
 <option value="<%= voffcd%>"><%= voffname%></option> 
<% 
		}
		rsDistrict.close();
		db.close();
		 %>
