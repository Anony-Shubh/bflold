<%@ include file="appIncludeHeaderPage.jsp" %>





<body>

<form  action="grivencesDetail.jsp" method="post" name="form1"  >

<% 
String APP_ID =vAppid;
String GR_ID = "";
String GR_SUB = "";
String GR_MATTER = "";
String EMAIL_TO="";
String APP_STATUS="";
String ACT_ID="-1";
String ACT_YN="Y";
String REMARKS="";
String ACT_DESC="";
		
DBCon db= new DBCon();
db.connect();

StringBuffer qyrSel= new StringBuffer();
qyrSel.append(" SELECT AD.ACT_ID,ad.act_yn,case when AD.ACT_ID in (3.7) then asm.act_desc when ad.act_yn='N' then 'Returned to Applicant For Fresh ");qyrSel.append(" Application Submission' else ");
qyrSel.append(" asm.act_desc end as act_desc FROM APP_DETAIL AD,  APP_STATUS_MAST ASM WHERE AD.ACT_ID = ASM.ACT_ID AND AD.APP_ID  =? ");


List values=new ArrayList();
List pstm=new ArrayList();
values.add(APP_ID);		
ResultSet rsMa = db.executeSQL(qyrSel.toString(),values);
values.clear();


  while (rsMa.next()) {  
ACT_ID=rsMa.getString("ACT_ID")==null?"":rsMa.getString("ACT_ID");
ACT_YN=rsMa.getString("ACT_YN")==null?"":rsMa.getString("ACT_YN");
ACT_DESC=rsMa.getString("ACT_DESC")==null?"":rsMa.getString("ACT_DESC");
}
rsMa.close();
//out.print(ACT_ID);

StringBuffer qrysb= new StringBuffer();



qrysb.append(" SELECT A.GR_ID,A.APP_ID,A.GR_SUB,A.EMAIL_TO,A.APP_STATUS,A.GR_TIMESTAMP, ");
qrysb.append(" CASE WHEN A.ACT_ID < =2 THEN  ");
qrysb.append(" (SELECT GD_REMARKS FROM pmegp_gri_details WHERE GD_ID=B.GD_ID)  ");
qrysb.append(" ELSE REMARKS END AS REMARKS,B.GD_ID FROM  ");
qrysb.append("   (SELECT p.GR_ID,    p.app_id,    g.sub_desc as GR_SUB,    p.EMAIL_TO,p.act_id,p.GR_TIMESTAMP,  ");
qrysb.append("     DECODE(p.ACT_ID, 0, 'Online Submitted', 1, 'Under Process', 2, 'Replied', 3, 'Closed') AS APP_STATUS, REMARKS  ");
qrysb.append("   FROM pmegp_grivences p,griv_sub_mast g where g.sub_id=p.sub_id   ) a,  ");
qrysb.append("   (SELECT MAX(gd_id) AS gd_id , MAX(GR_ID) AS  GR_ID  FROM pmegp_gri_details   ) b WHERE a.GR_ID = b.GR_ID(+)  ");
qrysb.append(" AND a.app_id = '"+APP_ID+"'  ORDER BY GR_TIMESTAMP DESC");




ResultSet rsMain = db.execSQL(qrysb.toString());

//out.print(qrysb.toString());
		 if ((ACT_ID.equals("3"))||(ACT_ID.equals("7"))||(ACT_YN.equals("N"))){
		 
		
  out.print("<div align=center class=redLebel>Your Application is"+ACT_DESC+".Kindly Apply Fresh Application.</div>");
  
 } else { %>
		 
		<table align="center" class="example">
<tr>
  <th colspan="7"><div align="center">Grivences Detail Form </div></th>
  </tr>
<tr>
  <th><div align="center">Sr.No</div></th>
  <th>Grivence ID </th>
  <th>Subject</th>
  <th>Email </th>   
  <th>Status</th>
   <th>Remarks</th>
  
  <th><a href="applicant_gri_addt.jsp?GR_ID=0" target="_parent" class="button">Add New</a> </th>
</tr> 
<% int edpcount=0;
  while (rsMain.next()){

GR_ID=rsMain.getString("GR_ID")==null?"":rsMain.getString("GR_ID");
EMAIL_TO=rsMain.getString("EMAIL_TO")==null?"":rsMain.getString("EMAIL_TO");
GR_SUB=rsMain.getString("GR_SUB")==null?"":rsMain.getString("GR_SUB");
APP_STATUS=rsMain.getString("APP_STATUS")==null?"":rsMain.getString("APP_STATUS");
REMARKS=rsMain.getString("REMARKS")==null?"":rsMain.getString("REMARKS");
edpcount=edpcount+1;
%>


<tr>
  <td><%=edpcount %></td>
  <td><%=GR_ID %></td>
  <td><%=GR_SUB %></td>
  <td><%=EMAIL_TO %></td>
  <td><%=APP_STATUS %></td>
  <td><%=REMARKS %></td>
   <td><!--<a href="applicant_gri_add.jsp?GR_ID=<%= GR_ID%>" target="_parent">Update</a>--></td>
</tr>
<%
}
rsMain.close();
%>
<tr><td colspan="7"><div align="center"></div></td>
</tr>  
</table>
  
  <%}%>
  
</form>
<script language="javascript">

var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 



function HideModalWindow() {
refreshpage();
    modalWin.HideModalPopUp();
}

function refreshpage() {
   form.submit(); 
}

function updateemail(pAppid) {
var url ='updateemail.jsp?APP_ID='+pAppid;
 modalWin.ShowURL(url,300,800,'Update',null,null);
 
}

   </script>
</body>
</html>
