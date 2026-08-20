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
.style2 {
	font-size: 18;
	color: #FF0000;
}
.style3 {color: #000000}
.style4 {font-size: 18px}
-->
    </style>
</HEAD>



<BODY>

 <%
String APP_ID=request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID");
String REQID=request.getParameter("REQID")==null?"":(String) request.getParameter("REQID");
String MOB_NO1="";
String NB_APPROV="";
String REJ_NB_REASON="";
String add_update="I";





DBCon db= new DBCon(); 
db.connect(); 
List values=new ArrayList(); 
List pstm=new ArrayList(); 


StringBuffer poR = new StringBuffer();

poR.append(" SELECT AM.APP_ID "      );
poR.append(" FROM APP_MOB_CHANGE_LOG AM "      );
poR.append(" WHERE AM.APP_ID=? AND AM.REQID=?"      );

values.add(APP_ID);
values.add(REQID);



ResultSet rsMain = db.executeSQL(poR.toString(),values);

while (rsMain.next()){
APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");


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
 <table id="example" class="display"  border="1" width="60%">
 <tr>
 <td><p align="center" class="style2"><span class="style3">Reject change of mobile number for applicant id</span> </p>
   <p align="center" class="style2"><%=APP_ID%></p></td>
 </tr>
 <tr>
 <td><span class="style4">Reson of Rejection</span><br/>
       
           <div align="left">
               <textarea name="REJ_NB_REASON" id="REJ_NB_REASON" rows="5" cols="30"></textarea>
          </div></td>
 </tr>
 <tr>
 <td colspan="5"><div align="center">
  <INPUT name="ins" id="ins" type="hidden" value="">
   <INPUT type="button" name="Submit" class="buttonLogin" onClick="submitform();" value="Reject">
 </div></td>
 
 </tr>
 </table>
 
 
            <%


if ((String)request.getParameter("ins")!=null){ 
values.clear();
NB_APPROV =(String) request.getParameter("NB_APPROV")==null?"":(String) request.getParameter("NB_APPROV").trim();
REJ_NB_REASON =(String) request.getParameter("REJ_NB_REASON")==null?"":(String) request.getParameter("REJ_NB_REASON").trim();


//UPDATE LOG
StringBuffer qryUpdate = new StringBuffer();

qryUpdate.append(" UPDATE APP_MOB_CHANGE_LOG SET ");
qryUpdate.append(" NB_APPROV='N', ");
qryUpdate.append(" REJ_NB_REASON=? ");
qryUpdate.append(" WHERE APP_ID=? AND REQID=? ");


values.add(REJ_NB_REASON); pstm.add ("L");
values.add(APP_ID); pstm.add ("L");
values.add(REQID); pstm.add ("L");



db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate();

values.clear();
pstm.clear();

db.close();

}
   

%>


</FORM>
  </CENTER>
</BODY>

</HTML>
