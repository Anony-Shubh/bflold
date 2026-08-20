<%

String BNF_TRID=request.getParameter("PBNF_TRID")==null?"":(String)request.getParameter("PBNF_TRID");
String PBNF_DESC=request.getParameter("PBNF_DESC")==null?"":(String)request.getParameter("PBNF_DESC");	
String BUD_ID = request.getParameter("PBUDID")==null?"0":(String)request.getParameter("PBUDID");
out.print(BNF_TRID);
out.print(PBNF_DESC);
out.print(BUD_ID);
session.setAttribute("PBUD_ID",BUD_ID);	
session.setAttribute("PBNF_DESC",PBNF_DESC);	
session.setAttribute("PBNF_TRID",BNF_TRID);	
if ((BUD_ID.equals("3"))||(BUD_ID.equals("4"))||(BUD_ID.equals("5"))||(BUD_ID.equals("6"))||(BUD_ID.equals("7"))||(BUD_ID.equals("8"))||(BUD_ID.equals("9"))||(BUD_ID.equals("10"))||(BUD_ID.equals("11"))) {
response.sendRedirect("bnfdis.jsp");
}
else if (BUD_ID.equals("12")){
response.sendRedirect("tadapmegp.jsp");
}
else if (BUD_ID.equals("13")){
response.sendRedirect("publicityactv.jsp");
}
else{
response.sendRedirect("edpdetails.jsp");
}
%>




