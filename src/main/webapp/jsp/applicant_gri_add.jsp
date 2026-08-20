<%@ include file="appIncludeHeaderPage.jsp" %>
<script language="javascript">

function submit_offupdate() {

var GR_SUB=document.form1.GR_SUB.value;

var GR_MATTER=document.form1.GR_MATTER.value;



 if(GR_SUB == "") {
    inlineMsg('GR_SUB','Enter Subject....',2);
    return false;
  }else if(GR_MATTER == "") {
    inlineMsg('GR_MATTER','Enter Matter......',2);
    return false;
  }else {
document.form1.ins.value='I'; 
document.form1.submit(); 

 }
}//end of function
</script>




<body >

<form  action="applicant_gri_add.jsp" method="post" name="form1"  >

<% 

String GR_ID = "";
String GR_SUB = "";
String GR_MATTER = "";
String ACT_YN = "Y";
String EMAIL_SENT = "";
String GR_TIMESTAMP = "";
String APP_ID =vAppid;
String APP_NAME=vAppName;


String OFF_EMAIL_ADDR = "";
String AGENCY_TYPE = "";
String OFF_NAME1 = "";
String E_MAIL = "";

	
DBCon db= new DBCon();
db.connect();

StringBuffer qrysb= new StringBuffer();


qrysb.append("   SELECT MOM.OFF_EMAIL_ADDR,AD.OFF_CD,"      );
qrysb.append("     MOM.AGENCY_TYPE,"      );
qrysb.append("     MOM.OFF_NAME1,"      );
qrysb.append("     AD.E_MAIL"      );
qrysb.append("   FROM APP_DETAIL AD,"      );
qrysb.append("     MAS_OFF_MAST MOM"      );
qrysb.append("   WHERE AD.OFF_CD = MOM.OFF_CD"      );
qrysb.append("   AND AD.APP_ID   = '"+APP_ID+"'"      );


ResultSet rsMain = db.execSQL(qrysb.toString());

while (rsMain.next()){

OFF_EMAIL_ADDR=rsMain.getString("OFF_EMAIL_ADDR")==null?"":rsMain.getString("OFF_EMAIL_ADDR");
AGENCY_TYPE=rsMain.getString("AGENCY_TYPE")==null?"":rsMain.getString("AGENCY_TYPE");
OFF_NAME1=rsMain.getString("OFF_NAME1")==null?"":rsMain.getString("OFF_NAME1");
E_MAIL=rsMain.getString("E_MAIL")==null?"":rsMain.getString("E_MAIL");


}
rsMain.close();
		%>
		<table align="center">
<tr>
  <th colspan="2"><div align="center">Applicant Grievance Form </div></th>
  </tr>
<tr>
  <th colspan="2"><div align="center"><span class="GreenLebel">( Email will be sent on Submit Your Grievance and a copy of grievance will also sent to your mail : <%= E_MAIL %> ) </span></div></th>
  </tr>
<tr>
  <th> From:  </th>
  <th>ID:<%= APP_ID %>, Name:<%= APP_NAME  %></th>
</tr>  
<tr>
  <th>To
    <input name="ins" type="hidden" id="ins" value=""></th>
  <td><%= AGENCY_TYPE %>,<%= OFF_NAME1 %> :&lt; <%= OFF_EMAIL_ADDR %>&gt;</td>
</tr>
<tr>
  <th>Copy to: </th>
  <td>PMEGP, KVIC, Mumbai &lt;pmegp.kvic@gov.in&gt; </td>
</tr>

<tr>
  <th>  Subject :  </th><td>  <input name="GR_SUB"  type="text"  id="GR_SUB" value="<%=GR_SUB%>" size="70" maxlength="70">
  <input name="GR_ID" type="hidden" id="GR_ID" value="<%=GR_ID%>">
  <input name="ACT_YN" type="hidden" id="ACT_YN" value="<%=ACT_YN%>">
  <input name="EMAIL_SENT" type="hidden" id="EMAIL_SENT" value="<%=EMAIL_SENT%>">
  <input name="GR_TIMESTAMP" type="hidden" id="GR_TIMESTAMP" value="<%=GR_TIMESTAMP%>"></td>
</tr>  
<tr>
  <th>  Matter (Maximum 400 character) </th><td>  <textarea name="GR_MATTER" cols="100" rows="6" id="GR_MATTER" maxlength="370" ><%=GR_MATTER%></textarea>  </td></tr>  
  
<tr>
  <th colspan="2"><div align="center" class="GreenLebel"></div></th>
</tr>
<tr><td colspan="2"><div align="center">
  <input name="Button" type="button" class="button" onClick="submit_offupdate();" value="Submit Grievance">
</div></td>
</tr>  
</table>
  <%
 try {
 if ((String)request.getParameter("ins")!=null){
 
 
 	GR_ID=(String) request.getParameter("GR_ID")==null?"":(String) request.getParameter("GR_ID").trim();
GR_SUB=(String) request.getParameter("GR_SUB")==null?"":(String) request.getParameter("GR_SUB").trim();
GR_MATTER=(String) request.getParameter("GR_MATTER")==null?"":(String) request.getParameter("GR_MATTER").trim();
ACT_YN=(String) request.getParameter("ACT_YN")==null?"":(String) request.getParameter("ACT_YN").trim();
EMAIL_SENT=(String) request.getParameter("EMAIL_SENT")==null?"":(String) request.getParameter("EMAIL_SENT").trim();

	
 
 
 

 List values=new ArrayList();
List pstm=new ArrayList();
 qrysb= new StringBuffer();

qrysb.append("INSERT INTO PMEGP_GRI ( GR_ID,");
qrysb.append("GR_SUB,");
qrysb.append("GR_MATTER,");
qrysb.append("ACT_YN,");
qrysb.append("EMAIL_SENT,");
qrysb.append("GR_TIMESTAMP,");
qrysb.append("APP_ID ) VALUES (GRIDSEQ.nextval,?,?,?,?,SYSDATE,?) ");



values.add(GR_SUB); pstm.add ("L");
values.add(GR_MATTER); pstm.add ("L");
values.add(ACT_YN); pstm.add ("L");
values.add(EMAIL_SENT); pstm.add ("L");
values.add(APP_ID); pstm.add ("L");

db.setSqlValue(	qrysb.toString());
db.setValues(values,pstm); 
db.executeUpdate() ;

 values.clear();
 pstm.clear();
 
db.close();
out.print ("<center><h1>Your Grievance has been successfully sent, Please verify your email ID for confirmation...........</h1><center>");
} //end ins


}//try
catch(Exception e)
{
out.println(e);
}
finally{
//db.close();
}
  %>
  
</form>
</body>
</html>
