<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>

<%
    response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
    %>
	<html>
	<head>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script src="../js/inlineMsgMain.js"></script>

<script language="javascript">

function submit_offupdate(){
var ACT_ID=document.form.ACT_ID.value;
var GD_REMARKS=document.form.GD_REMARKS.value;
//alert(ACT_ID);
//alert(GD_REMARKS);

if (ACT_ID== "0") {inlineMsg ('ACT_ID','Select Status',2);	return (false);}

if (GD_REMARKS== "") {inlineMsg ('GD_REMARKS','Enter Remarks',2);	return (false);}
	document.form.ins.value='I';
	document.form.submit();
}


function closeAndRefresh(){
     parent.modalWin.HideModalPopUp()
    }
	
	function sendemail()
  {	  
  var GR_ID= document.getElementById("GR_ID").value;
window.location.href = 'sendemail.jsp?GR_ID='+GR_ID;
}
</script>
</head>
<body> 
 <form name="form" id="form"  class="form" method="post">
	    <%
		String vUserID=(String) session.getAttribute("bank_id")==null?"":(String)session.getAttribute("bank_id");
		String GR_ID= request.getParameter("GR_ID")==null?"":(String) request.getParameter("GR_ID");
		//out.print(GR_ID);
		String DISTRICT_NAME="";
		String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");
		String APP_NAME="";
		DBCon db= new DBCon();
        db.connect();
		
        StringBuffer qrysb = new StringBuffer();
		
qrysb.append(" SELECT MOM.OFF_EMAIL_ADDR,AD.OFF_CD,P.act_id,AD.IFSC_CODE,p.gr_matter,G.SUB_DESC AS gr_sub,p.gr_id,AD.APP_ID,AD.APP_NAME,MD.DISTRICT_NAME, ");
qrysb.append(" MOM.AGENCY_TYPE||'('|| MOM.OFF_NAME1 ||')' AS AGENCY,DECODE(p.ACT_ID,0,'Online Submitted',1,'Under Process',2,'Replied',3,'Closed') as app_status, ");
qrysb.append(" AD.E_MAIL,BRM.EMAIL,BRM.BR_NAME FROM APP_DETAIL_online AD,M_DISTRICT MD,BANK_BR_MAST BRM , MAS_OFF_MAST MOM,PMEGP_GRIVENCES P,GRIV_SUB_MAST G WHERE P.SUB_ID=G.SUB_ID AND AD.OFF_CD = MOM.OFF_CD AND AD.UNIT_DIST_CD=MD.DISTRICT_CD  ");
qrysb.append(" AND AD.IFSC_CODE=BRM.BR_IFSL_CODE AND AD.APP_ID(+)=P.APP_ID  AND P.GR_ID="+GR_ID+"  ");

		
		
		
		ResultSet rsMain = db.execSQL(qrysb.toString());
		
		
String OFF_EMAIL_ADDR="";
String ACT_ID="";
String IFSC_CODE="";
String GR_MATTER="";
String GR_SUB="";
String OFF_CD="";
String AGENCY="";
String app_status="";
String E_MAIL="";
String EMAIL="";
String REMARKS="";
String OFF_NAME="";
String BR_NAME="";
String APP_ID="";
String APP_STATUS="";
String GD_ID="0";
String GD_REMARKS="";
String UPLOAD_PIC="";
  while(rsMain.next())
  {			

	  ACT_ID=rsMain.getString("ACT_ID")==null?"":rsMain.getString("ACT_ID");
	  IFSC_CODE=rsMain.getString("IFSC_CODE")==null?"":rsMain.getString("IFSC_CODE");
	  GR_MATTER=rsMain.getString("GR_MATTER")==null?"":rsMain.getString("GR_MATTER");
	  GR_SUB=rsMain.getString("GR_SUB")==null?"":rsMain.getString("GR_SUB");
	  OFF_CD=rsMain.getString("OFF_CD")==null?"":rsMain.getString("OFF_CD");
	  AGENCY=rsMain.getString("AGENCY")==null?"":rsMain.getString("AGENCY");
	  APP_STATUS=rsMain.getString("APP_STATUS")==null?"":rsMain.getString("APP_STATUS");
	  E_MAIL=rsMain.getString("E_MAIL")==null?"":rsMain.getString("E_MAIL");
	  APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");
	  OFF_EMAIL_ADDR=rsMain.getString("OFF_EMAIL_ADDR")==null?"":rsMain.getString("OFF_EMAIL_ADDR");
	  DISTRICT_NAME=rsMain.getString("DISTRICT_NAME")==null?"":rsMain.getString("DISTRICT_NAME");
	  BR_NAME=rsMain.getString("BR_NAME")==null?"":rsMain.getString("BR_NAME");
	  APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
	
	 }
			rsMain.close();
			 session.setAttribute("sAPP_ID",APP_ID);
			
        %>

  <table align="center" cellpadding="4" cellspacing="4">
  <th colspan="8"><div align="center"> 
     
      <span class="style90 style96">GRIVENCE UPDATE FORM </span>
      <input name="ins" type="hidden" id="ins" value="<%= ins %>">
	   <input name="GR_ID" type="hidden" id="GR_ID" value="<%= GR_ID %>">
	   <input name="GD_ID" type="hidden" id="GD_ID" value="<%= GD_ID %>">
  </div></th>

<tr>
    <th colspan="8" nowrap><H1 align="center">Grivence ID : <%=GR_ID %></H1></th>
    </tr>

 <tr>
 <th>Application id   </th>
    <th ><%=APP_ID%></th>
    <th >Applicant Name </th>
   
    <th ><%=APP_NAME%></th>
    <th >Agency: </th>
    <th ><%= AGENCY  %></th>
    <th >District:</th>
    <th ><%=DISTRICT_NAME%></th>
    </tr>
	<tr valign="baseline" >
      <th align="right" nowrap>subject:        </td>
      <td colspan="7"><%=GR_SUB%>
	  <input name="GR_SUB" type="hidden" id="GR_SUB" value="<%=GR_SUB %>" size="50" maxlength="50" readonly="true">
      </span></span></td>
    </tr>
    <tr valign="baseline" >
      <th align="right" nowrap>Matter</th>
      <td colspan="7"><%=GR_MATTER%>
	  <input name="GR_MATTER" type="hidden" id="GR_MATTER" value="<%=GR_MATTER %>" size="79" maxlength="79" readonly="true">
        <div align="right"></div></td>
    </tr>
    
	<tr>
	<th align="right" nowrap>Status:</th>
      <td colspan="7"><select name="ACT_ID"  id="ACT_ID" >
        <option value="0" >Select Status</option>
        <option value="1" <% if (ACT_ID.equals("1")){ out.println("selected");}%>>Under Process</option>
		 <option value="2" <% if (ACT_ID.equals("2")){ out.println("selected");}%>>Replied</option>
		  <option value="3"<% if (ACT_ID.equals("3")){ out.println("selected");}%>>Closed</option>
      </option>
      
      </select></td>
    </tr>
	       <th>Remarks: </th>
	
         <td colspan="7"><textarea name="GD_REMARKS" cols="100" rows="6" id="GD_REMARKS" maxlength="500" ><%=GD_REMARKS%></textarea>		</td>
  
  </tr>
        
   
  <tr>
  <th colspan="8" ><div align="center">
    <input name="Button2" type="button" class="button" onClick="submit_offupdate();" value="Save Record">
    <input name="Button" type="button" class="button" value="Cancel" onClick="closeAndRefresh();">
	 <!--if (ins.equals("I")){
	   <input name="Button2" type="button" class="button" onClick="sendemail();" value="Send Mail">
       <input name="Button2" type="button" class="button" onClick="sendsms();" value="Send sms">
	   -->
  </div></th>
  </tr>
  </table>
  <%
  if (ins.equals("I")){
				
				
GD_ID=request.getParameter("GD_ID")==null?"":request.getParameter("GD_ID");					
GR_ID=request.getParameter("GR_ID")==null?"":request.getParameter("GR_ID");				
GD_REMARKS=request.getParameter("GD_REMARKS")==null?"":request.getParameter("GD_REMARKS");
ACT_ID=request.getParameter("ACT_ID")==null?"":request.getParameter("ACT_ID");





List values=new ArrayList();
        List pstm=new ArrayList();	
		
		
		if(!ACT_ID.equals("3")){
     
  qrysb= new StringBuffer();

qrysb.append("INSERT INTO PMEGP_GRI_DETAILS (GD_ID,GD_REMARKS,");
qrysb.append("ACT_YN,");
qrysb.append("GD_TIMESTAMP,");
qrysb.append("GR_ID,UPDATE_DL )");
qrysb.append(" VALUES (PMEGPGRSEQ.nextval,?,'Y',SYSDATE,?,?) ");



values.add(GD_REMARKS); pstm.add ("L");
values.add(GR_ID); pstm.add ("L");
values.add(vUserID); pstm.add ("L");

db.setSqlValue(qrysb.toString());
db.setValues(values,pstm); 
db.executeUpdate() ;

  values.clear();
 pstm.clear();
 
 String vqry="UPDATE PMEGP_GRIVENCES SET ACT_ID="+ACT_ID+" WHERE  GR_ID="+GR_ID+"  ";
db.setSqlValue(vqry);
db.setValues(values,pstm);
db.executeUpdate() ;
 

 

  
  
  }
  
  else{
	  
	  String vqry="UPDATE PMEGP_GRIVENCES SET ACT_ID="+ACT_ID+",UPDATE_DL='"+vUserID+"',REMARKS='"+GD_REMARKS+"',GRCL_TIMESTAMP=SYSDATE WHERE  GR_ID="+GR_ID+"  ";
db.setSqlValue( vqry);
db.setValues(values,pstm);
db.executeUpdate() ;
  
	  
	  
	  
  }
  
  
  
  
  response.sendRedirect("savepage.jsp");	
  
  
  
  }
  

  
        StringBuffer qry = new StringBuffer();
		
qry.append("  SELECT PG.GD_ID, PG.GD_REMARKS,PG.UPLOAD_PIC,to_char(PG.GD_TIMESTAMP,'DD-MON-RRRR') AS GD_DATE FROM pmegp_gri_details PG WHERE  PG.GR_ID="+GR_ID+"  ");

		
		
		
		ResultSet rsM = db.execSQL(qry.toString());
		
String PGR_ID="";		
String PGD_ID="";
String PGD_REMARKS="";
String PGD_DATE="";
String PUPLOAD_PIC="";  
  int count=0;
  %>
  
   <table align="center">
    <tr bgcolor="#BC3F52" >
      <td colspan="6"><div align="center" class="style98">GRIVENCE DETAIL ACTION</div></td>
    </tr>
  <tr>
      <td><div align="center">Sr. No. </div></td>
      <td><div align="center">ID</div></td>
      <td><div align="center">Remarks</div></td>
      <td><div align="center">Date</div></td>
	  <td colspan="2"><div align="center">Upload(if any)</div></td>
    </tr>
  <%
   while(rsM.next())
  {			

	  PGD_ID=rsM.getString("GD_ID")==null?"":rsM.getString("GD_ID");
	  PGD_REMARKS=rsM.getString("GD_REMARKS")==null?"":rsM.getString("GD_REMARKS");
	  PGD_DATE=rsM.getString("GD_DATE")==null?"":rsM.getString("GD_DATE");
	   PUPLOAD_PIC=rsM.getString("UPLOAD_PIC")==null?"":rsM.getString("UPLOAD_PIC");
  count=count+1;	
  
  %>
   <tr> 
      <td ><%=count%></td>

  <td><%=PGD_ID%>      </td>
  
  <td> <%=PGD_REMARKS%>   </td>  
  
  <td> <%=PGD_DATE%> </td>
  <td colspan="2"><% if (PUPLOAD_PIC.equals("")){ %>
  <a href="../GrivancesMS/UploadDoc.jsp?GD_ID=<%=PGD_ID%>&GR_ID=<%=GR_ID%>">Upload</a>
  <% } else {%>
  
   <a href="docViewScore.jsp?docname=<%=PUPLOAD_PIC%>">View</a>
  
  <%}%>
  </td>
  </tr>
  
  <%
  }
  
  rsM.close();
  db.close();
  %>
  
   
  <tr>
    <th colspan="6"> 
        <div align="center"></div></th>
  </tr>
  </table>



	
  
</form>


</body>
</html>