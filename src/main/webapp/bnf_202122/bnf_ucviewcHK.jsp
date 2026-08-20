<%@ page session="true"  import="java.sql.*"  %>
<%@ page import="pkgPmegpNew.DBCon" %>
<%@ page import="java.util.*" %>
<%
response.setContentType("text/html");
response.setHeader("Cache-Control", "no-cache,must-revalidate");
response.addHeader("Cache-Control", "post-check=0,pre-check=0");
response.addHeader("Cache-Control", "proxy-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", -1);
response.addHeader("X-XSS-Protection", "1; mode=block");
response.addHeader("X-Content-Type-Options", "nosniff");
response.addHeader("X-Frame-Options", "DENY");
%>



<% 
String SOFF_CD =session.getAttribute("SOFF_CD")==null?"": (String)session.getAttribute("SOFF_CD");
DBCon db= new DBCon();
db.connect();
  List values=new ArrayList();	
    List pstm=new ArrayList();
String UC_ID="";
StringBuffer qrysb = new StringBuffer();
values.add(SOFF_CD);
qrysb.append(" SELECT UC_ID FROM bnf_uc WHERE OFF_CD=? ");

ResultSet Mainrs = db.executeSQL(qrysb.toString(),values);

values.clear();

while (Mainrs.next()) {

UC_ID=Mainrs.getString("UC_ID")==null?"":Mainrs.getString("UC_ID");

}
Mainrs.close();
db.close();
response.sendRedirect ("bnf_ucview.jsp?UC_ID="+UC_ID);


 %>