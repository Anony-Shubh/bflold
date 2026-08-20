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
<script type="text/javascript" src="../js/ModalPopupWindow.js"></script>
</head>

<body>
<form method="post" action="app_score_upload.jsp" name="form" id="form" class="form">


	  <p>
	    <%
		
		String APP_ID= request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID") ;
		APP_ID=APP_ID.trim();
		APP_ID=APP_ID.toUpperCase();
		
        String APP_NAME="";
        String SUB_DT="";
		String MOB_NO1="";
		String E_MAIL="";
		String AADHAR_NO="";
		
		
		String UP_ID = "";
		String UPM_CD = "";
		String DOC_NAME = "";
		String DOC_REMARKS = "";
		
		String DEPEN_DOC="";
String DEPEN_REMARK="";
String HOUSE_DOC="";
String HOUSE_REMARK="";
String ADDR_DOC="";
String ADDR_REMARK="";
String EXP_DOC="";
String EXP_REMARK="";
String OTHSOUR_DOC="";
String OTHSOUR_REMARK="";
String INCOME_DOC="";
String INCOME_REMARK="";
String INSU_DOC="";
String INSU_REMARK="";
String BANK_DOC="";
String BANK_REMARK="";
String SKILL_DOC="";
String SKILL_REMARK="";
String REGEGOV_DOC="";
String REGEGOV_REMARK="";
		
        DBCon db= new DBCon();
        db.connect();

           StringBuffer qry = new StringBuffer();
   	qry.append("	SELECT PSC.DEPEN_DOC,  PSC.DEPEN_REMARK,  PSC.HOUSE_DOC,AD.APP_NAME, ");
 qry.append(" PSC.HOUSE_REMARK,  PSC.ADDR_DOC,  PSC.ADDR_REMARK, ");
 qry.append(" PSC.EXP_DOC,  PSC.EXP_REMARK,  PSC.OTHSOUR_DOC,  PSC.OTHSOUR_REMARK, ");
 qry.append(" PSC.INCOME_DOC,  PSC.INCOME_REMARK,  PSC.INSU_DOC, ");
 qry.append(" PSC.INSU_REMARK,  PSC.BANK_DOC,  PSC.BANK_REMARK, ");
 qry.append(" PSC.SKILL_DOC,  PSC.SKILL_REMARK,  PSC.REGEGOV_DOC,  PSC.REGEGOV_REMARK ");
qry.append(" FROM PMEGP_SCORE_CARD PSC,APP_DETAIL AD  WHERE AD.APP_ID=PSC.APP_ID AND psc.APP_ID='"+APP_ID+"' ");
		 

        ResultSet rsMain = db.execSQL(qry.toString());
      

        while (rsMain.next()){
		APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
		DEPEN_DOC=rsMain.getString("DEPEN_DOC")==null?"":rsMain.getString("DEPEN_DOC");
DEPEN_REMARK=rsMain.getString("DEPEN_REMARK")==null?"":rsMain.getString("DEPEN_REMARK");
HOUSE_DOC=rsMain.getString("HOUSE_DOC")==null?"":rsMain.getString("HOUSE_DOC");
HOUSE_REMARK=rsMain.getString("HOUSE_REMARK")==null?"":rsMain.getString("HOUSE_REMARK");
ADDR_DOC=rsMain.getString("ADDR_DOC")==null?"":rsMain.getString("ADDR_DOC");
ADDR_REMARK=rsMain.getString("ADDR_REMARK")==null?"":rsMain.getString("ADDR_REMARK");
EXP_DOC=rsMain.getString("EXP_DOC")==null?"":rsMain.getString("EXP_DOC");
EXP_REMARK=rsMain.getString("EXP_REMARK")==null?"":rsMain.getString("EXP_REMARK");
OTHSOUR_DOC=rsMain.getString("OTHSOUR_DOC")==null?"":rsMain.getString("OTHSOUR_DOC");
OTHSOUR_REMARK=rsMain.getString("OTHSOUR_REMARK")==null?"":rsMain.getString("OTHSOUR_REMARK");
INCOME_DOC=rsMain.getString("INCOME_DOC")==null?"":rsMain.getString("INCOME_DOC");
INCOME_REMARK=rsMain.getString("INCOME_REMARK")==null?"":rsMain.getString("INCOME_REMARK");
INSU_DOC=rsMain.getString("INSU_DOC")==null?"":rsMain.getString("INSU_DOC");
INSU_REMARK=rsMain.getString("INSU_REMARK")==null?"":rsMain.getString("INSU_REMARK");
BANK_DOC=rsMain.getString("BANK_DOC")==null?"":rsMain.getString("BANK_DOC");
BANK_REMARK=rsMain.getString("BANK_REMARK")==null?"":rsMain.getString("BANK_REMARK");
SKILL_DOC=rsMain.getString("SKILL_DOC")==null?"":rsMain.getString("SKILL_DOC");
SKILL_REMARK=rsMain.getString("SKILL_REMARK")==null?"":rsMain.getString("SKILL_REMARK");
REGEGOV_DOC=rsMain.getString("REGEGOV_DOC")==null?"":rsMain.getString("REGEGOV_DOC");
REGEGOV_REMARK=rsMain.getString("REGEGOV_REMARK")==null?"":rsMain.getString("REGEGOV_REMARK");

        }
			rsMain.close();
			db.close();
			
        %>
	  <table align="center" class="pmegpTable">
        <tr>
          <th colspan="2" nowrap><div align="right">Applicant ID:</div></th>
          <td colspan="2" nowrap><%= APP_ID %></td>
        </tr>
        <tr>
          <th colspan="2" nowrap><div align="right">Applicant Name: </div></th>
          <td colspan="2" nowrap><%= APP_NAME %></td>
        </tr>
        <tr>
          <th colspan="4" nowrap>ONLINE APPLICANT DOCUMENT /CERTIFICATE UPLOAD FORM </th>
        </tr>
        
        <tr>
          <th nowrap>SrNo
          <input id="APP_ID" name="APP_ID" type="hidden" value="<%=APP_ID%>"></th>
          <th nowrap>Document Desc </th>
          <th nowrap>Applicant Remarks</th>
          <th nowrap><div align="center">View</div></th>
        </tr>
       
        <tr>
          <td>1</td>
          <td>No. of dependencies Document</td>
          <td><%= DEPEN_REMARK %></td>
		  
          <td>
		  <% if (DEPEN_DOC.equals("")){%>
  <a href="appidAgn.jsp?UPM_CD=1&APP_ID=<%=APP_ID%>" class="greenButtonRound" >Upload </a>
  <%} else{%>
		  <a href="appidAgn.jsp?docname=<%=DEPEN_DOC%>&APP_ID=<%=APP_ID%>" class="greenButtonRound">view Document </a> 
		  <%}%>
		  </td>
        </tr>
        
	 <tr>
          <td>2</td>
          <td>Owning a house/parental house Document</td>
          <td><%= HOUSE_REMARK %></td>
          <td> <% if (HOUSE_DOC.equals("")){%>
  <a href="appidAgn.jsp?UPM_CD=2" class="greenButtonRound" >Upload </a>
  <%} else{%>
		  <a href="appidAgn.jsp?docname=<%=HOUSE_DOC%>&APP_ID=<%=APP_ID%>" class="greenButtonRound">view Document </a> </td>
		  <%}%>
        </tr>
		
		 <tr>
          <td>3</td>
          <td>address / location Document</td>
          <td><%= ADDR_REMARK %></td>
          <td> <% if (ADDR_DOC.equals("")){%>
  <a href="appidAgn.jsp?UPM_CD=3" class="greenButtonRound" >Upload </a>
  <%} else{%>
		  <a href="appidAgn.jsp?docname=<%=ADDR_DOC%>&APP_ID=<%=APP_ID%>" class="greenButtonRound">view Document </a> </td>
		  <%}%>
        </tr>
		
		
		
		 <tr>
          <td>4</td>
          <td>Experience Document</td>
          <td><%= EXP_REMARK %></td>
          <td> <% if (EXP_DOC.equals("")){%>
  <a href="appidAgn.jsp?UPM_CD=4&APP_ID=<%=APP_ID%>" class="greenButtonRound" >Upload </a>
  <%} else{%>
		  <a href="appidAgn.jsp?docname=<%=EXP_DOC%>&APP_ID=<%=APP_ID%>" class="greenButtonRound">view Document </a> </td>
		  <%}%>
        </tr>
		
			 <tr>
          <td>5</td>
          <td>Source of income Document</td>
          <td><%= OTHSOUR_REMARK %></td>
          <td> <% if (OTHSOUR_DOC.equals("")){%>
  <a href="appidAgn.jsp?UPM_CD=5&APP_ID=<%=APP_ID%>" class="greenButtonRound" >Upload </a>
  <%} else{%>
		  <a href="appidAgn.jsp?docname=<%=OTHSOUR_DOC%>&APP_ID=<%=APP_ID%>" class="greenButtonRound">view Document </a> </td>
		  <%}%>
        </tr>
		
		
		
		<tr>
          <td>6</td>
          <td>Income tax Document</td>
          <td><%= INCOME_REMARK %></td>
          <td> <%if (INCOME_DOC.equals("")){%>
  <a href="appidAgn.jsp?UPM_CD=6&APP_ID=<%=APP_ID%>" class="greenButtonRound" >Upload </a>
  <%} else{%>
		  <a href="appidAgn.jsp?docname=<%=INCOME_DOC%>&APP_ID=<%=APP_ID%>" class="greenButtonRound">view Document </a> </td>
		  <%}%>
        </tr>
		
		
		<tr>
          <td>7</td>
          <td>Life Insurance policy Document</td>
          <td><%= INSU_REMARK %></td>
          <td> <%if (INSU_DOC.equals("")){%>
  <a href="appidAgn.jsp?UPM_CD=7&APP_ID=<%=APP_ID%>" class="greenButtonRound" >Upload </a>
  <%} else{%>
		  <a href="appidAgn.jsp?docname=<%=INSU_DOC%>&APP_ID=<%=APP_ID%>" class="greenButtonRound">view Document </a> </td>
		  <%}%>
        </tr>
		
		
		
		
		
		<tr>
          <td>8</td>
          <td>Lending bank Document</td>
          <td><%= BANK_REMARK %></td>
          <td> <%if (BANK_DOC.equals("")){%>
  <a href="appidAgn.jsp?UPM_CD=7&APP_ID=<%=APP_ID%>" class="greenButtonRound" >Upload </a>
  <%} else{%>
		  <a href="appidAgn.jsp?docname=<%=BANK_DOC%>&APP_ID=<%=APP_ID%>" class="greenButtonRound">view Document </a> </td>
		  <%}%>
        </tr>
		
		
			<tr>
          <td>9</td>
          <td>Skill Certification Document</td>
          <td><%= SKILL_REMARK %></td>
          <td> <%if (SKILL_DOC.equals("")){%>
  <a href="appidAgn.jsp?UPM_CD=7&APP_ID=<%=APP_ID%>" class="greenButtonRound">Upload </a>
  <%} else{%>
		  <a href="appidAgn.jsp?docname=<%=SKILL_DOC%>&APP_ID=<%=APP_ID%>" class="greenButtonRound">view Document </a> </td>
		  <%}%>
        </tr>
		
		
			<tr>
          <td>10</td>
          <td>Registered with Govt. Authorities Document</td>
          <td><%= REGEGOV_REMARK %></td>
          <td> <%if (REGEGOV_DOC.equals("")){%>
  <a href="appidAgn.jsp?UPM_CD=7&APP_ID=<%=APP_ID%>" class="greenButtonRound" >Upload </a>
  <%} else{%>
		  <a href="appidAgn.jsp?docname=<%=REGEGOV_DOC%>&APP_ID=<%=APP_ID%>" class="greenButtonRound">view Document </a> </td>
		  <%}%>
        </tr>
		
		
		
		
      </table>
	  
</form>
</body>
</html>