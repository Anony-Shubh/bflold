<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>


<%

String select = request.getParameter("select")==null?"":(String) request.getParameter("select");
String username = request.getParameter("USERNAME")==null?"":(String) request.getParameter("USERNAME");
String password = request.getParameter("PASSWORD")==null?"":(String) request.getParameter("PASSWORD");
	
	String BNF_USERID="";
	
	
String OFF_CD = "";
String FO_HO = "";
String OFF_NAME1 = "";
String STATE_NM = "";
String ZONE_NM = "";
String STATE_CD = "";
String STATEALLOWED = "";

DBCon db= new DBCon();
db.connect();
if (!username.equals("")&&!password.equals("")){

	
	StringBuffer qrysb= new StringBuffer();

qrysb.append("   SELECT BOM.OFF_CD,"      );
qrysb.append("   DECODE (BOM.OFF_CD,'9999','HO','FO') AS FO_HO,"      );
qrysb.append("     BOM.OFF_NAME1,"      );
qrysb.append("     BOM.STATE_NM,BOM.STATE_CD,"      );
qrysb.append("     BOM.ZONE_NM,  CASE WHEN BOM.OFF_CD IN (5707,5714,11,12,13,226,172,16,19,18,21,20,22,3,24,23,6466,29,27,28,26,30,31,32,6826,6761,35,36,37,2008,38,39,5,40) THEN 'Y' ELSE 'N' END AS STATEALLOWED"      );
qrysb.append("   FROM BNF_OFF_MAST BOM"      );
qrysb.append("   WHERE BOM.ACT_YN = 'Y'"      );
qrysb.append("   AND"      );
qrysb.append("     BOM.BNF_USERID=? AND BOM.BNF_PWD=?"      );


List values=new ArrayList();
  
values.add(username);
values.add(password);
  

ResultSet rsMain = db.executeSQL(qrysb.toString(),values);

    if (rsMain.next()) 
	{
OFF_CD=rsMain.getString("OFF_CD")==null?"":rsMain.getString("OFF_CD");
FO_HO=rsMain.getString("FO_HO")==null?"":rsMain.getString("FO_HO");
OFF_NAME1=rsMain.getString("OFF_NAME1")==null?"":rsMain.getString("OFF_NAME1");
STATE_NM=rsMain.getString("STATE_NM")==null?"":rsMain.getString("STATE_NM");
ZONE_NM=rsMain.getString("ZONE_NM")==null?"":rsMain.getString("ZONE_NM");
STATE_CD=rsMain.getString("STATE_CD")==null?"":rsMain.getString("STATE_CD");
STATEALLOWED=rsMain.getString("STATEALLOWED")==null?"":rsMain.getString("STATEALLOWED");

        session.setAttribute("slogin", "Y");
		session.setAttribute("SOFF_CD", OFF_CD);
		session.setAttribute("SFO_HO", FO_HO);
		session.setAttribute("SOFF_NAME1", OFF_NAME1);
		session.setAttribute("SSTATE_NM", STATE_NM);
		session.setAttribute("SZONE_NM", ZONE_NM);
		session.setAttribute("SSTATE_CD", STATE_CD);
		session.setAttribute("SSTATEALLOWED", STATEALLOWED);
		session.setAttribute("sselect", select);
		
    } 
	rsMain.close();
    
	}//end of if
	

	db.close();

	if(select.equals("2021-22")) {
response.sendRedirect("../bnf_202122/bnfHome.jsp"); 
}

else if (select.equals("2022-23")) {
response.sendRedirect("../bnf_202223/bnfHome.jsp"); 
}

else if (select.equals("2023-24")) {
response.sendRedirect("../bnf_202324/bnfHome.jsp"); 
}

else if (select.equals("2024-25")) {
response.sendRedirect("../bnf_202425/bnfHome.jsp"); 
}

else

if(!OFF_CD.equals("")) {
session.setAttribute("slogin", "Y");
response.sendRedirect("bnfHome.jsp"); 
	
	}
	
	else{			   
				   session.invalidate();
                    request.setAttribute("errorMessage", "Invalid username or password");
                    RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
                    rd.forward(request, response); 
			}	
			
			//db.close();
%>