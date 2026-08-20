
<%@ page session="true" buffer="50kb" import="java.sql.*,java.util.*,java.io.*, pkgPmegpNew.DBCon"  %>
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
String vlent =request.getParameter("lent")==null?"":(String) request.getParameter("lent") ;
DBCon db= new DBCon();
db.connect();
List values=new ArrayList();
List pstm=new ArrayList();
String bid="";
 values.add (vlent); 
ResultSet rsMain = db.executeSQL("SELECT FB_IFSC_REQ FROM FB_REQUESTUD_LOG WHERE DATAVALID_YN='Y' AND (TRUNC(SYSDATE)-TRUNC(FB_REQ_DT))<2 AND FB_EMAIL_CONF='N' AND FB_RND_NO=?",values);
while (rsMain.next()){
bid=rsMain.getString(1);
session.setAttribute("bid",bid);
session.setAttribute("slent",vlent);
response.sendRedirect ("bankModule/rsp.jsp");
}
rsMain.close();
db.close();
if (bid.equals("")) {
out.print (" Invlalid Request......");

}
 %>