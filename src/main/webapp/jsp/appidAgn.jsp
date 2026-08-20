
<%@ page session="true" import="java.sql.*"  %>
<%
response.setContentType("text/html");
response.setHeader("Cache-Control", "no-cache,must-revalidate");
response.addHeader("Cache-Control", "post-check=0,pre-check=0");
response.addHeader("Cache-Control", "proxy-revalidate");

%>



<% 
String APP_ID =request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID") ;
String UPM_CD =request.getParameter("UPM_CD")==null?"":(String) request.getParameter("UPM_CD") ;
String docname=request.getParameter("docname")==null?"":(String) request.getParameter("docname") ;
String TYPE=request.getParameter("TYPE")==null?"":(String) request.getParameter("TYPE") ;
session.setAttribute("sAPP_ID",APP_ID);

out.print(APP_ID);
out.print(UPM_CD);
out.print(docname);

if ((!APP_ID.equals("")) &&(!UPM_CD.equals("")) && (TYPE.equals(""))){
response.sendRedirect ("Upload_score_app.jsp?UPM_CD="+UPM_CD);
}
else if ((!APP_ID.equals("")) &&(!UPM_CD.equals("")) && (!TYPE.equals(""))){
response.sendRedirect ("Upload_score_app_del.jsp?UPM_CD="+UPM_CD);
}else{
response.sendRedirect ("docViewScore.jsp?docname="+docname);
}

 %>