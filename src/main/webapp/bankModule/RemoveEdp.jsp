<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.io.*"%>
<%@ page import="pkgPmegpNew.DBCon"%>

<html>
<head>
    <%
    response.setHeader("Cache-Control", "no-cache");
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
    %>


    <title>upload View Agency</title>
	<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />

</head>

<body>
<form method="post" action="RemoveEdp.jsp" name="form" id="form" class="form">


	  <p>
	    <%
		
		String APP_ID= request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID") ;
		APP_ID=APP_ID.trim();
		APP_ID=APP_ID.toUpperCase();
		session.setAttribute("sAPP_ID",APP_ID);
        String APP_NAME="";
        String SUB_DT="";
		String MOB_NO1="";
		String E_MAIL="";
		String AADHAR_NO="";
		
		
		String UP_ID = "";
		String UPM_CD = "";
		String DOC_NAME = "";
		String DOC_REMARKS = "";
		
		
        DBCon db= new DBCon();
        db.connect();

           StringBuffer qry = new StringBuffer();
         qry.append(" SELECT A.APP_ID, ");
		  qry.append("UPPER(A.APP_NAME) AS APP_NAME,  ");
		   qry.append("  TO_CHAR(A.ONLINE_SUBDT, 'DD-MON-RRRR HH:MI:SS') AS ONLINE_SUB_DT, ");
		    qry.append("  A.MOB_NO1, ");
			 qry.append(" A.DOB,  A.E_MAIL,A.AADHAR_NO ");
			  qry.append(" FROM APP_DETAIL A ");
			  qry.append("WHERE A.APP_ID = '"+APP_ID+"' ");
		 

        ResultSet rsApp = db.execSQL(qry.toString());
      

        while (rsApp.next()){
		APP_ID=rsApp.getString("APP_ID")==null?"":rsApp.getString("APP_ID");
        APP_NAME=rsApp.getString("APP_NAME")==null?"":rsApp.getString("APP_NAME");
        SUB_DT=rsApp.getString("online_sub_dt")==null?"":rsApp.getString("online_sub_dt");
	  MOB_NO1=rsApp.getString("MOB_NO1")==null?"":rsApp.getString("MOB_NO1");
		 E_MAIL=rsApp.getString("E_MAIL")==null?"":rsApp.getString("E_MAIL");
		 AADHAR_NO=rsApp.getString("AADHAR_NO")==null?"":rsApp.getString("AADHAR_NO");
        }
			rsApp.close();
			StringBuffer qryUp = new StringBuffer();	
			
		qryUp.append("  SELECT AUT.UP_ID,");
		qryUp.append("   AUT.DOC_NAME,");
		 qryUp.append("   NVL(AUT.DOC_REMARKS,'-') AS DOC_REMARKS,");
		qryUp.append("   TO_CHAR(AUT.UPLOAD_TIMESTAMP,'DD-MON-RRRR HH:MM') AS AUT_DT,");
		qryUp.append("  AUM.DOC_DESC");
		qryUp.append("  FROM APP_UPLOAD_TRANS AUT,APP_UPLOAD_MAST AUM");
		qryUp.append("   WHERE  AUT.UPM_CD = AUM.UPM_CD AND ");
		qryUp.append("   AUT.DOC_ACTYN='Y' and AUT.UPM_CD=8  AND AUT.APP_ID='"+APP_ID+"' ");
			
	ResultSet rsUp = db.execSQL(qryUp.toString());		
        %>
	  <table align="center">
        <tr>
          <th colspan="2" nowrap><div align="right">Applicant ID:</div></th>
          <td colspan="3" nowrap><%= APP_ID %></td>
        </tr>
        <tr>
          <th colspan="2" nowrap><div align="right">Applicant Name: </div></th>
          <td colspan="3" nowrap><%= APP_NAME %></td>
        </tr>
        <tr>
          <th colspan="5" nowrap>ONLINE APPLICANT EDP CERTIFICATE VIEW FORM </th>
        </tr>
        
        <tr>
          <th nowrap>SrNo
          <input id="APP_ID" name="APP_ID" type="hidden" value="<%=APP_ID%>"></th>
          <th nowrap>Document Desc </th>
          <th nowrap>Applicant Remarks</th>
          <th nowrap><div align="center">View</div></th>
          <th nowrap><div align="center">Remove</div></th>
        </tr>
        <% 
  
  String vDOC_NAME="";
  String vDOC_DESC="";
  String vDOC_REMARKS="";
  String vUP_ID="";
  int srno=0;
  while (rsUp.next()) {
  srno=srno+1;
    vDOC_NAME=rsUp.getString("DOC_NAME");
   vDOC_DESC=rsUp.getString("DOC_DESC");
   vDOC_REMARKS=rsUp.getString("DOC_REMARKS");
   vUP_ID=rsUp.getString("UP_ID");
  
  %>
        <tr>
          <td><%= srno %></td>
          <td><%= vDOC_DESC %></td>
          <td><%= vDOC_REMARKS %></td>
          <td>
		
		  
		   <a href="../jsp/doctransfertoNas.jsp?docname=<%= vDOC_NAME %>&APP_ID=<%= APP_ID %>" class="greenButtonRound">view Document </a>  </td>
          <td>
		
		  
		   <a href="EdpAppRemove.jsp?APP_ID=<%= APP_ID %>&UP_ID=<%=vUP_ID%>" class="greenButtonRound">Remove </a>  </td>
        </tr>
        <%
  }
  rsUp.close();
  db.close();
  %>
      </table>
	  
</form>
</body>
</html>