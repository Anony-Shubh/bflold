
<p><img src="../images/pmegponlineN.jpg" width="100%"></p>
<%
String USER_NM= session.getAttribute("username")==null?"":(String) session.getAttribute("username");
//String USER_DESC= session.getAttribute("sUSER_DESC")==null?"":(String) session.getAttribute("sUSER_DESC");
//String IFSL_CODE= session.getAttribute("sIFSL_CODE")==null?"":(String) session.getAttribute("sIFSL_CODE");

if (USER_NM.equals(null)||USER_NM.equals("")) {
response.sendRedirect("index.jsp");
}

%>
<table align="center" class="pmegpTable">
  <tr>
    <td colspan="8" nowrap><div align="center">INDIAN BANK( <%= USER_NM  %>) </div></td>
  </tr>
<tr>
<td height="41" nowrap><div align="center"><a href="bankHomePage.jsp" class="button">HOME</a></div></td>
<td nowrap><div align="center"><a href="ibhome.jsp" class="button">PROCESS FAIL CASE</a></div></td>
<td nowrap><div align="center"><a href="ibIfscPage.jsp" class="button">SEARCH BY IFSC</a></div></td>
<td nowrap><div align="center"><a href="ibviewPv.jsp" class="button">PV Adjustment Letter</a></div></td>
<td nowrap><div align="center"><a href="appDetail.jsp" class="button">App Detail</a></div></td>
<td nowrap><div align="center"><a href="report.jsp" class="button">REPORT</a></div></td>
<td nowrap><div align="center"><a href="KvicGenChaln.jsp" class="button">CHALLAN</a></div></td>
<td nowrap><div align="center"><a href="logout.jsp" class="button">LOGOUT</a></div></td>
</tr>
</table>


