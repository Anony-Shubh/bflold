<%
String vAppid=  session.getAttribute("slogin")==null?"":(String) session.getAttribute("slogin");
//out.print(vAppid);
if (vAppid.equals("")||vAppid.equals(null)){

%>
<jsp:forward page="indexlogin.jsp" />
<%}%>