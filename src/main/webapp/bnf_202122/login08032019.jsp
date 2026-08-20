<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>


<%

String username = request.getParameter("USERNAME")==null?"":(String) request.getParameter("USERNAME");
String password = request.getParameter("PASSWORD")==null?"":(String) request.getParameter("PASSWORD");
	
	String BNF_USERID="";
	
	
String OFF_CD = "";
String FO_HO = "";
String OFF_NAME1 = "";
String STATE_NM = "";
String ZONE_NM = "";
if (!username.equals("")&&!password.equals("")){
   DBCon db= new DBCon();
db.connect();
	
	StringBuffer qrysb= new StringBuffer();

 qrysb.append("   SELECT BOM.OFF_CD,"      );
qrysb.append("   DECODE (BOM.OFF_CD,'9999','HO','FO') AS FO_HO,"      );
qrysb.append("     BOM.OFF_NAME1,"      );
qrysb.append("     BOM.STATE_NM,"      );
qrysb.append("     BOM.ZONE_NM"      );
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

        session.setAttribute("slogin", "Y");
		session.setAttribute("SOFF_CD", OFF_CD);
		session.setAttribute("SFO_HO", FO_HO);
		session.setAttribute("SOFF_NAME1", OFF_NAME1);
		session.setAttribute("SSTATE_NM", STATE_NM);
		session.setAttribute("SZONE_NM", ZONE_NM);
		
		
    } 
	rsMain.close();
	db.close();
	}//end of if
if(!OFF_CD.equals("")) {
session.setAttribute("slogin", "Y");
response.sendRedirect("bnfHome.jsp"); 
	
	}else{			   
				   session.invalidate();
                    request.setAttribute("errorMessage", "Invalid username or password");
                    RequestDispatcher rd = request.getRequestDispatcher("index111.jsp");
                    rd.forward(request, response); 
			}	
%>