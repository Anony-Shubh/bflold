<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>

<%@ page import="pkgPmegpNew.DBCon"%>
<%@ page buffer="500kb" %>
<%@ include file="responseheaderinclude.jsp" %>

<body>
<form method="post" action="upload_app_doc.jsp" name="form" id="form" >

<% 
String APP_ID=(String) session.getAttribute("sAPP_ID");
//out.print(APP_ID);
if (APP_ID.equals("")||APP_ID.equals(null)){
%>
<jsp:forward page="index.jsp" />
<%
}else{


//out.print(APP_ID);
	APP_ID=APP_ID.trim();
		APP_ID=APP_ID.toUpperCase();	
		
       String APP_NAME = "";
String AADHAR_NO = "";
String PAN_NO = "";
String UAD="";
String UNIT_LOC="";
		String UP_ID = "";
		String UPM_CD = "";
		String DOC_NAME = "";
		String DOC_REMARKS = "";
		String APP_PWD="";

 DBCon db= new DBCon();
db.connect();
ResultSet rsRd = db.execSQL("SELECT AD.APP_ID,AD.APP_PWD, AD.APP_NAME,  AD.UNIT_LOC,  AD.AADHAR_NO,  AD.UAD,  AD.PAN_NO FROM APP_DETAIL_ONLINE_SECOND AD WHERE AD.APP_ID ='"+APP_ID+"' ");
		
		while (rsRd.next()){
		  APP_NAME=rsRd.getString("APP_NAME")==null?"":rsRd.getString("APP_NAME");
		  AADHAR_NO=rsRd.getString("AADHAR_NO")==null?"":rsRd.getString("AADHAR_NO");
		  UNIT_LOC=rsRd.getString("UNIT_LOC")==null?"":rsRd.getString("UNIT_LOC");
		  UAD=rsRd.getString("UAD")==null?"":rsRd.getString("UAD");
		  PAN_NO=rsRd.getString("PAN_NO")==null?"":rsRd.getString("PAN_NO");
		  APP_PWD=rsRd.getString("APP_PWD")==null?"":rsRd.getString("APP_PWD");
		}
		
		
		rsRd.close();
		
		StringBuffer qryUp = new StringBuffer();	
			
qryUp.append("	SELECT * FROM (   ");
qryUp.append("SELECT AUM.UPM_CD, AUT.UP_ID, AUT.DOC_NAME, AUT.DOC_REMARKS, ");
qryUp.append(" TO_CHAR(AUT.UPLOAD_TIMESTAMP,'DD-MON-RRRR HH:MM') AS AUT_DT, ");
qryUp.append(" AUM.DOC_DESC FROM APP_UPLOAD_TRANS_SECOND AUT,APP_UPLOAD_MAST_SECOND AUM ");
qryUp.append(" WHERE AUT.UPM_CD = AUM.UPM_CD AND AUM.USR_TYPE='I' AND AUT.APP_ID=? ");
qryUp.append(" UNION SELECT AUM.UPM_CD,NULL UP_ID, NULL AS DOC_NAME, NULL AS DOC_REMARKS, ");
qryUp.append(" NULL AS AUT_DT, AUM.DOC_DESC FROM APP_UPLOAD_MAST_SECOND AUM WHERE  AUM.USR_TYPE='I' AND ");
qryUp.append(" AUM.UPM_CD NOT IN (SELECT UPM_CD FROM APP_UPLOAD_TRANS_SECOND ");
qryUp.append(" WHERE APP_ID=?)) ");
//out.print(qryUp.toString());


			 List values=new ArrayList();
				

      values.add (APP_ID); 	
	    values.add (APP_ID); 	
	ResultSet rsUp = db.executeSQL(qryUp.toString(),values);
	values.clear();	
		
	
		  %>
		  
		  
	   
 
	  <table align="center">
        <tr>
          <th colspan="5" nowrap>ONLINE APPLICATION  FOR SECOND LOAN SUBSIDY FOR UPGRADING OF EXISTING UNIT</th>
        </tr>
        <tr>
          <th colspan="2" nowrap>ID:</th>
          <th nowrap><%=APP_ID%></th>
          <th nowrap>Aadhaar No: </th>
          <th nowrap><%=AADHAR_NO%></th>
        </tr>
        <tr>
          <th colspan="2" nowrap>Name:</th>
          <th nowrap><%=APP_NAME%></th>
          <th nowrap>PAN No. </th>
          <th nowrap><%=PAN_NO%></th>
        </tr>
       
        <tr>
          <th colspan="2" nowrap>Udyog Aadhar Registration No:</th>
          <th nowrap><%=UAD%></th>
          <th nowrap>Unit Location: </th>
          <th nowrap><%=UNIT_LOC%></th>
        </tr>
        <tr>
         <td colspan="5" nowrap><h1 align="center" > Your Application Id is:<font color="red"><%=APP_ID%></font> And Password is :<font color="red"><%=APP_PWD%></font>	</h1></td>
        </tr>
        <tr>
          <td colspan="5"><div align="center"><h3><strong>(Note:Please note your application id for future refrence .Your Appliaction Will not be Considered Valid Until it is Finally Submitted to The Concerned Office)</strong></div></td>
        </tr>
        <tr>
          <td colspan="5" nowrap class="redLebel"><div align="center">Upload all valid  Documents </div></td>
        </tr>
        <tr>
          <th nowrap>SrNo</th>
          <th nowrap>Document Desc </th>
          <th nowrap>Remarks</th>
          <th nowrap>View</th>
          <th nowrap>delete</th>
        </tr>
		    <% 
  
  String vDOC_NAME="";
  String vDOC_DESC="";
  String vDOC_REMARKS="";
  int srno=0;
  while (rsUp.next()) {
  srno=srno+1;
    vDOC_NAME=rsUp.getString("DOC_NAME")==null?"":rsUp.getString("DOC_NAME");
   vDOC_DESC=rsUp.getString("DOC_DESC")==null?"":rsUp.getString("DOC_DESC");
   vDOC_REMARKS=rsUp.getString("DOC_REMARKS")==null?"":rsUp.getString("DOC_REMARKS");
   UP_ID = rsUp.getString("UP_ID")==null?"0":rsUp.getString("UP_ID");
		 UPM_CD = rsUp.getString("UPM_CD")==null?"":rsUp.getString("UPM_CD");
  
  %>
        
         <tr>
          <td><%= srno %></td>
          <td><%= vDOC_DESC %></td>
          <td><%= vDOC_REMARKS %></td>
          <td>
		  <% if (!UP_ID.equals("0")) {%>
		  <a href="../jsp/docView.jsp?docname=<%= vDOC_NAME %>" class="greenButtonRound">view </a>
		  <% }else{%>
		  <a href="upload_app_doc_puf.jsp?UPM_CD=<%= UPM_CD %>" class="greenButtonRound" onClick="javascript:Popup(this.href, 'Upload Document', 800, 350);return (false);">Upload </a>
		  <% } %>		   </td>
          <td>
		  
		  
		  <% if (!UP_ID.equals("0")) {%>
		  <a href="upload_app_doc_del.jsp?UP_ID=<%= UP_ID %>" class="greenButtonRound" onClick="javascript:Popup(this.href, 'Upload Document', 800, 500);return (false);">delete</a></td>
		  <% } %><input name="FLAG" type="hidden" id="FLAG" value="5">
		</td>
        </tr>
		
        <%
  }
  rsUp.close();
  db.close();
  %>


      </table>
	<div align="center"> <input name="btnCnf" id="btnCnf" type="button" onClick="getfrequenttab(5)"; class="button" value="Final Submit" /></div>
</form>
<%}%>
</body>
</html>