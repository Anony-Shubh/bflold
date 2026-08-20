<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="pkgPmegpNew.DBCon"%>
<HTML>

<HEAD>
<META http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
   <LINK rel="stylesheet" type="text/css" href="css/pmegpNew.css">
    <SCRIPT src="js/inlinemsg.js"></SCRIPT>

<TITLE>
       
</TITLE>
	<SCRIPT>
        function submitform() {	
            document.form.ins.value = 'I';
            document.form.submit();
        }

    </SCRIPT>
   
    <style type="text/css">
<!--
.style1 {
	font-size: 18px;
	color: #FF0000;
}
.style3 {font-size: 18px; color: #000000; }
.style5 {font-size: 18}
-->
    </style>
</HEAD>



<BODY>

 <%
String APP_ID=request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID");
String REQID=request.getParameter("REQID")==null?"":(String) request.getParameter("REQID");
String MOB_NO1="";
String NB_APPROV="";
String APPROV_DT="";
String PREV_MOB_NO="";
String NEW_MOB_NO="";
String add_update="I";





DBCon db= new DBCon(); 
db.connect(); 
List values=new ArrayList(); 
List pstm=new ArrayList(); 


StringBuffer poR = new StringBuffer();

poR.append(" SELECT AM.APP_ID, "      );
poR.append(" AM.REQID, "      );
poR.append(" AD.APP_NAME,"      );
poR.append(" TO_CHAR(AM.REQ_DATE,'DD-MON-RRRR') AS REQ_DATE, "      );
poR.append(" AM.PREV_MOB_NO, "      );
poR.append(" AM.NEW_MOB_NO, "      );
poR.append(" FUNC_GETCURRENTSTATUS(AD.APP_ID) AS CURRENT_STATUS "      );  
poR.append(" FROM APP_DETAIL AD, APP_MOB_CHANGE_LOG AM "      );
poR.append(" WHERE AD.APP_ID=AM.APP_ID AND  AM.APP_ID=? AND AM.REQID=?   ");

values.add(APP_ID);
values.add(REQID);


ResultSet rsMain = db.executeSQL(poR.toString(),values);

while (rsMain.next()){
APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");
REQID=rsMain.getString("REQID")==null?"":rsMain.getString("REQID");
PREV_MOB_NO=rsMain.getString("PREV_MOB_NO")==null?"":rsMain.getString("PREV_MOB_NO");
NEW_MOB_NO=rsMain.getString("NEW_MOB_NO")==null?"":rsMain.getString("NEW_MOB_NO");


}
rsMain.close();


%>

<br>
<br>
<br>
<br>
<br>
<CENTER>
  <FORM method="post" name="form" id="form">		
 <table id="example" class="display"  border="1">
 <tr>
 <td><p><span class="style3">Approve change of mobile number for applicant id</span> </p>
   <p align="center"><span class="style1"><%=APP_ID%></span></p>
   <p align="center"><br/>
     <span class="style5">From mobile number '<%=PREV_MOB_NO%>' to '<%=NEW_MOB_NO%>'</span></p></td>
 </tr>
 <tr>
 <td colspan="5"><div align="center">
  <INPUT name="ins" id="ins" type="hidden" value="">
   <INPUT type="button" name="Submit" class="buttonLogin" onClick="submitform();" value="Approve">
 </div></td>
 
 </tr>
 </table>
 
 
            <%


if ((String)request.getParameter("ins")!=null){ 
values.clear();
NB_APPROV =(String) request.getParameter("NB_APPROV")==null?"":(String) request.getParameter("NB_APPROV").trim();
APPROV_DT =(String) request.getParameter("APPROV_DT")==null?"":(String) request.getParameter("APPROV_DT").trim();
MOB_NO1 =(String) request.getParameter("MOB_NO1")==null?"":(String) request.getParameter("MOB_NO1").trim();


//UPDATE LOG
StringBuffer qryUpdate = new StringBuffer();

qryUpdate.append(" UPDATE APP_MOB_CHANGE_LOG SET ");
qryUpdate.append(" NB_APPROV='Y', ");
qryUpdate.append(" APPROV_DT=SYSDATE ");
qryUpdate.append(" WHERE APP_ID=? AND REQID=? ");


values.add(APP_ID); pstm.add ("L");
values.add(REQID); pstm.add ("L");




db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate();

values.clear();
pstm.clear();


values.add(APP_ID);

ResultSet rschd = db.executeSQL("SELECT FUNC_MOBNOUPDT(?) AS MOBUPDT FROM DUAL",values);
values.clear();

while (rschd.next()) {
//out.print("SUCCESS");
}

rschd.close();

db.close();
response.sendRedirect("savemsg.jsp");
}
   

%>


</FORM>
  </CENTER>
</BODY>

</HTML>
