 <%@ page session="true" buffer="300kb"  import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.SQLException"%>
<%
response.setContentType("text/html");
response.setHeader("Cache-control","no-cache");
response.setHeader("Cache-control","private");
%>

<HTML>
<HEAD>
<TITLE>PMEGP Agency Status Update Form</TITLE>

<LINK rel="stylesheet" type="text/css" href="css/pmegpTable.css">

<SCRIPT language="javascript" src="../js/sweetalert.min.js"></SCRIPT>
<script>
function form_submit(){
document.form.ins.value='I';
document.form.submit();
}

</script>
<style type="text/css">
<!--
.style1 {font-size: 24px}
-->
</style>
</HEAD>
<BODY>
<form   name="form" id ="form" method="post" >
<%
DBCon db= new DBCon();
db.connect();
String ins = "";
ins = (String) request.getParameter("ins")==null?"":(String) request.getParameter("ins").trim();
String  APP_ID =(String) session.getAttribute("SAPP_ID");
String  PMEGPGEOTAGID =(String) session.getAttribute("SPGID");
String  APP_NAME =request.getParameter("APP_NAME")==null?"":(String)request.getParameter("APP_NAME");
String REM_MAX_AMT=request.getParameter("MAX_AMT")==null?"0":(String)request.getParameter("MAX_AMT");
String  MM_REL_AMT =request.getParameter("MM_REL_AMT")==null?"0":(String)request.getParameter("MM_REL_AMT");
String DIS_AMT=request.getParameter("DIS_AMT")==null?"0":(String)request.getParameter("DIS_AMT");
String NODAL_OFFICER_REMARK=request.getParameter("NODAL_OFFICER_REMARK")==null?"":(String)request.getParameter("NODAL_OFFICER_REMARK");
String MM_ADJUSTMENT_STATUS=request.getParameter("MM_ADJUSTMENT_STATUS")==null?"":(String)request.getParameter("MM_ADJUSTMENT_STATUS");
String MM_ADJUSTMENT_AMT_S=request.getParameter("MAX_AMT")==null?"0":(String)request.getParameter("MAX_AMT");
//out.print(APP_NAME);
String MAX_AMT="";
String VALID_DATA="Y";


String MM_STATUS="";
 if (MM_ADJUSTMENT_STATUS.equals("RM")){
 MM_STATUS="Recommended For MM Adjustment";
 }
 else
 {
 MM_STATUS="Recommended For Reverification";
 }
ArrayList aerror = new ArrayList();


StringBuffer qrysb= new StringBuffer();
	

qrysb.append("    SELECT GT.PMEGPGEOTAGID,to_char(trunc(bd.ist_loan_dt)+1095,'DD-MON-RRRR') AS MM_LOAN_DT,CASE WHEN trunc(sysdate)-trunc(bd.ist_loan_dt) < 1094 THEN 'N' ELSE 'Y' END AS MM_ADJ_YN,bd.MM_REL_AMT,GEOALLOWAMT(GT.PMEGPGEOTAGID) AS MAX_AMT,NVL(BD.MM_REL_AMT,0)-GEOALLOWAMT(GT.PMEGPGEOTAGID) AS DIS_AMT,GT.pending_loan_amount FROM APP_DETAIL AD ,BANK_DATAENTRY BD,GEOTAG_TRANS GT WHERE AD.APP_ID=BD.APP_ID AND  AD.APP_ID       = GT.APP_ID  AND BD.PACT_ID      = 34 AND AD.APP_ID =? AND GT.PMEGPGEOTAGID=?"      );
qrysb.append("   UNION   ");
qrysb.append("    SELECT GT.PMEGPGEOTAGID,to_char(trunc(bd.ist_loan_dt)+1095,'DD-MON-RRRR') AS MM_LOAN_DT,CASE WHEN trunc(sysdate)-trunc(bd.ist_loan_dt) < 1094 THEN 'N' ELSE 'Y' END AS MM_ADJ_YN,bd.MM_REL_AMT,GEOALLOWAMT(GT.PMEGPGEOTAGID) AS MAX_AMT,NVL(BD.MM_REL_AMT,0)-GEOALLOWAMT(GT.PMEGPGEOTAGID) AS DIS_AMT,GT.pending_loan_amount FROM APP_DETAIL_SECOND AD ,BANK_DATAENTRY_SECOND BD,GEOTAG_TRANS GT WHERE AD.APP_ID=BD.APP_ID AND  AD.APP_ID       = GT.APP_ID  AND BD.PACT_ID      = 34 AND AD.APP_ID =? AND GT.PMEGPGEOTAGID=?"      );

List values=new ArrayList();

values.add(APP_ID);
values.add(PMEGPGEOTAGID);
values.add(APP_ID);
values.add(PMEGPGEOTAGID);



   ResultSet rs = db.executeSQL(qrysb.toString(),values);
   values.clear();


String MM_ADJ_YN="";
String MM_LOAN_DT="";

String pending_loan_amount="";


	while (rs.next()){
	
	MAX_AMT=rs.getString("MAX_AMT")==null?"":rs.getString("MAX_AMT");
DIS_AMT=rs.getString("DIS_AMT")==null?"":rs.getString("DIS_AMT");
MM_REL_AMT=rs.getString("MM_REL_AMT")==null?"":rs.getString("MM_REL_AMT");
pending_loan_amount=rs.getString("pending_loan_amount")==null?"":rs.getString("pending_loan_amount");	
	MM_ADJ_YN=rs.getString("MM_ADJ_YN")==null?"":rs.getString("MM_ADJ_YN");
  MM_LOAN_DT=rs.getString("MM_LOAN_DT")==null?"":rs.getString("MM_LOAN_DT");
  }
 rs.close();


%>

<TABLE align="center" style="z-index:auto;">

  <TR>
    <TH colspan="9"> 
      <INPUT name="APP_ID" type="hidden" id="APP_ID" value="<%= APP_ID %>">
      
      <DIV align="center">Margin Money Adjustment Update Form</DIV></TH>
  </TR>
  <TR>
    <TD colspan="2" ><STRONG>Geo Tagging Id:</STRONG> <%= PMEGPGEOTAGID %> </TD>
    <TD colspan="2" ><DIV align="left">
      <INPUT name="ins" type="hidden" id="ins" value="<%=ins%>"><INPUT name="APP_ID" type="hidden" value="<%=APP_ID%>" id="APP_ID">
	  <INPUT name="PMEGPGEOTAGID" type="hidden" value="<%=PMEGPGEOTAGID%>" id="PMEGPGEOTAGID">
      <STRONG>Applicant Id</span> :</STRONG> <%=APP_ID %></DIV></TD>
    <TD colspan="5" ><STRONG>Beneficiary Name  :</STRONG> <%=APP_NAME%></TD>
    </TR>
 
 <TR>
	  <TD colspan="2" ><DIV align="left"><STRONG>MM Released: </STRONG></DIV></TD>
	  <TD ><%= MM_REL_AMT %></TD>
      <TD ><STRONG> MM Eligible* : </STRONG></TD>
      <TD > <SPAN class="GreenLebel style1"><%= MAX_AMT%></SPAN></TD>
      <TD colspan="3" ><STRONG>Call Back Amount: </STRONG></TD>
	  <TD > <SPAN class="redLebel" style1><%= DIS_AMT%></SPAN></TD>
	</TR>
	<TR >
	  <TD colspan="3"><STRONG>Balance Loan*:</STRONG> </TD>
	  <TD colspan="6"><SPAN class="redLebel" style1><%=pending_loan_amount%></SPAN></TD>
    </TR>
	<TR >
    <TD colspan="3"><DIV align="left"><STRONG>MM Adjustment Status </STRONG>*</DIV></TD>
	 <TD colspan="6"><% if (MM_ADJUSTMENT_STATUS.equals("RM")){%>
	 <SPAN class="GreenLebel style1"><%=MM_STATUS%></SPAN>
	 <%} else{%>
	  <SPAN class="redLebel style1"><%=MM_STATUS%></SPAN>
	  <%}%>	 </TD>
	 </TR>
	 
	  <INPUT name="MM_REL_AMT" type="hidden" id="MM_REL_AMT"  size="10" maxlength="7"  value="<%= MM_REL_AMT %>" >
		<INPUT name="REM_MAX_AMT" type="HIDDEN" id="REM_MAX_AMT"  size="10" maxlength="7"  value="<%=REM_MAX_AMT%>"  >
		 <INPUT name="DIS_AMT" type="hidden" id="DIS_AMT"  size="10" maxlength="7"  value="<%= DIS_AMT %>" >
		<INPUT name="MM_ADJUSTMENT_STATUS" type="hidden" id="MM_ADJUSTMENT_STATUS"  size="10" maxlength="7"  value="<%= MM_ADJUSTMENT_STATUS %>" >
		
		 
	 
	   <TR >
    <TD colspan="2" ><div align="left"><strong>MM Adjustemnt Amount </strong></div></TD>
    <TD ><DIV align="left"> <SPAN class="GreenLebel style1"><%= REM_MAX_AMT %></SPAN><INPUT name="MAX_AMT" type="hidden" id="MAX_AMT"  size="10" maxlength="7"  value="<%= MAX_AMT %>"  ></DIV></TD>
    <TD colspan="3"><STRONG>Nodal Officer Remarks*</STRONG></TD>
    <TD colspan="6" ><%=NODAL_OFFICER_REMARK%><input name="NODAL_OFFICER_REMARK"   type="hidden"  value="<%=NODAL_OFFICER_REMARK%>" id="NODAL_OFFICER_REMARK">	</TD>
	<INPUT name="pending_loan_amount" type="hidden" id="pending_loan_amount"  size="10" maxlength="7"  value="<%= pending_loan_amount %>"  >
    </TR>
	 <TR>
    <TD colspan="9"> 
        <DIV align="center">
		 <INPUT name="Button" type="button" class="button" onClick="form_submit()" value="Confirm">

         <a href="GTStatusUpdate1.jsp" type="button" class="button">Back</a>
          <!--<INPUT name="Button" type="button" class="button" value="Back" onClick="history.back()">  -->        
      </DIV></TD>
  </TR>
</TABLE>

 
 <% if (ins.equals("I")){
VALID_DATA="Y";
NODAL_OFFICER_REMARK=(String) request.getParameter("NODAL_OFFICER_REMARK")==null?"":(String) request.getParameter("NODAL_OFFICER_REMARK").trim();
MM_ADJUSTMENT_AMT_S=(String) request.getParameter("REM_MAX_AMT")==null?"0":(String) request.getParameter("REM_MAX_AMT").trim();
MM_ADJUSTMENT_STATUS=(String) request.getParameter("MM_ADJUSTMENT_STATUS")==null?"":(String) request.getParameter("MM_ADJUSTMENT_STATUS").trim();
DIS_AMT=(String) request.getParameter("DIS_AMT")==null?"":(String) request.getParameter("DIS_AMT").trim();
MM_REL_AMT=(String) request.getParameter("MM_REL_AMT")==null?"":(String) request.getParameter("MM_REL_AMT").trim();
MAX_AMT=(String) request.getParameter("MAX_AMT")==null?"":(String) request.getParameter("MAX_AMT").trim();
   
 pending_loan_amount=(String) request.getParameter("pending_loan_amount")==null?"0":(String) request.getParameter("pending_loan_amount").trim();
    
    
int i=Integer.parseInt(MM_ADJUSTMENT_AMT_S); 

int j=Integer.parseInt(MAX_AMT); 


int k= Integer.parseInt(MM_REL_AMT);


 if(MM_ADJUSTMENT_STATUS.equals("RM")){
 
 try {
  if ((i>j) || (i<0)) {
   aerror.add("MM Amt cannot be greater than :"+j+"  OR Less than zero");
    
  }
  }catch (Exception n){
    aerror.add("MM Amt cannot be greater than :"+j+" OR Less than zero");
   }
  
   %>

<table align="center"  class="pmegpTable">
 <tr>
    <td colspan="4" class="warning" scope="row"><h2 class="error">  Submission failed due to following reason: </h2></td>
  </tr>
  <%
   ListIterator itr=aerror.listIterator();
   int cnterro=0;
   while(itr.hasNext()){ VALID_DATA="N"; 
cnterro=cnterro+1;   %>

  <tr class="redLebel">
    <td class="OrangeLebel" scope="row">
	
	  <div align="right"><%= cnterro %></div></td>
    <td colspan="3" class="warning" scope="row"><h3><%= itr.next()%></h3></td>
  </tr>
 
<%			
        }}
 if (VALID_DATA.equals("Y")){


String agnclbk="";
if (MM_ADJUSTMENT_STATUS.equals("RU")){
MM_ADJUSTMENT_AMT_S="0";
agnclbk="0";
out.print(agnclbk);
}
else{
MM_ADJUSTMENT_AMT_S=MM_ADJUSTMENT_AMT_S;
int MA=Integer.parseInt(MM_ADJUSTMENT_AMT_S); 
int agn_callbk=(k-MA);
agnclbk=String.valueOf(agn_callbk);
out.print(agnclbk);
}


 StringBuffer qryUpdate = new StringBuffer();
 
qryUpdate.append("UPDATE GEOTAG_TRANS SET  ");
qryUpdate.append("NODAL_OFFICER_REMARK=?,");
qryUpdate.append("MM_ADJUSTMENT_AMT_S=?,");
qryUpdate.append("MM_ADJUSTMENT_STATUS=?,ACT_ID=NULL,REMTRID=null,MM_ADJ_DATE=SYSDATE,LAST_UPDATE_DT=SYSDATE,AGN_CALLBACK=? ");
qryUpdate.append("WHERE APP_ID=? AND PMEGPGEOTAGID=?");

//List values=new ArrayList();
List pstm=new ArrayList();



values.add(NODAL_OFFICER_REMARK); pstm.add ("L");
values.add(MM_ADJUSTMENT_AMT_S); pstm.add ("L");
values.add(MM_ADJUSTMENT_STATUS); pstm.add ("L");
values.add(agnclbk); pstm.add ("L");
values.add(APP_ID); pstm.add ("L");
values.add(PMEGPGEOTAGID); pstm.add ("L");
try{
db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate();
db.close();}
catch (Exception e) {
	
	out.print (e.toString());
	}	
values.clear();
pstm.clear();
response.sendRedirect("savepage.jsp");
}
//out.print(qryUpdate.toString());
}
 %>
</form>
</body>
</html>