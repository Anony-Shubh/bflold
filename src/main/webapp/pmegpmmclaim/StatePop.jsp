<%@ page session="true"  import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.SQLException"%>
<%
response.setContentType("text/html");
response.setHeader("Cache-control","no-cache");
response.setHeader("Cache-control","private");
%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />

<script>
function closeAndRefresh(){
	document.form.ins.value='I'; 
   document.form.submit();
   window.parent.refresh_data();  
    }
</script>
</head>
<body>
<form name="form" id="form" class="form" method="post">
<%
DBCon db= new DBCon();
db.connect();

   String STATE =request.getParameter("STATE")==null?"":(String)request.getParameter("STATE"); 
     String STATUS =request.getParameter("STATUS")==null?"":(String)request.getParameter("STATUS"); 
   
   session.setAttribute("STATE", STATE);
    session.setAttribute("STATUS", STATUS);
   
   


 ResultSet rsState=db.execSQL(" SELECT MS.STATE_CD,MS.STATE_NM FROM M_STATE MS  ORDER BY MS.STATE_NM ");

  %> 
<table align="center" class="pmegpTable">
    <tr>
      <td colspan="18"><div align="center">  </div></td>
    </tr><input name="ins" type="hidden" id="ins">
	 <tr><td colspan="4">SEARCH BY STATE:</td>
      <td  colspan="4"> <select name="STATE" id="STATE" onBlur="showDistrict(this.value);">
	          <option value=""> Search by State</option>
		<%
	   String sn="";
	   String st="";
	   while (rsState.next()) {
	   st=rsState.getString(1);	
	   sn=rsState.getString(2);	   
	    %>
        <option value="<%=st  %>" <% if (st.equals(STATE)){ out.print("selected");}%>><%= sn %></option>
		<%
	   }
		rsState.close();
		%>		  
      </select>	  </td>
	   <td colspan="4">Select Status:</td>
      <td  colspan="4"> <select name="STATUS" id="STATUS">
	          <option value=""> Select</option>
		<option value="31" >ALL</option>
        <option value="30" >Referred Back Case</option>
	    <option value="32" >Recommended for MM Disbursement</option>
      </select>	  </td>
	  
      <td colspan="2"><input name="btnFind" type="button" class="button" id="btnFind" value="Search" onclick="closeAndRefresh();" ></td>
  </table><%
  if ((String)request.getParameter("ins")!=null){
	  %>
	  <br><br>
	  <div align="center">
<img id="loader" src="../images/nwloading.gif" />
<br/><br/><br/><br/>
<span style="color:#0000FF;font-size:16px;font-weight:bold">Please wait...</span></div>
	 
      
  <%}%>
  </form>
  </body>
  </html>
