
<p><img src="../images/pmegponlineN.jpg" width="100%"></p>
<%
String USER_NM= session.getAttribute("sUSER_NM")==null?"":(String) session.getAttribute("sUSER_NM");
String USER_DESC= session.getAttribute("sUSER_DESC")==null?"":(String) session.getAttribute("sUSER_DESC");
String IFSL_CODE= session.getAttribute("sIFSL_CODE")==null?"":(String) session.getAttribute("sIFSL_CODE");

if (USER_NM.equals(null)||USER_NM.equals("")) {
response.sendRedirect("index.jsp");
}

%>
<table align="center" class="pmegpTable">
  <tr>
    <td colspan="6" nowrap><div align="center">BANK NODAL OFFICER ( <%= USER_DESC  %>) </div></td>
  </tr>
<tr>
<td height="41" nowrap><div align="center"><a href="bankHomePage.jsp" class="button">HOME</a></div></td>
<td nowrap><div align="center"><a href="updateFBProfile.jsp" class="button">RESET FINANCING BRANCH PASSWORD</a></div></td>
<td nowrap><div align="center"><a href="pmegpbankmr.jsp" class="button">REPORTS</a></div></td>
<td nowrap><div align="center"><a href="../pmegpeportaltutorialdoc/new_financing_branch.pdf" class="button">USER MANUAL FOR FINANCING BRANCH</a> </div></td>
<td nowrap><div align="center"> <a href="../pmegpeportaltutorialdoc/nodal_bank_usermanual.pdf" class="button">USER MANUAL FOR BANK NODAL OFFICER</a> </div></td>
<td nowrap><div align="center"><a href="logout.jsp" class="button">LOGOUT</a></div></td>
</tr>
</table>


