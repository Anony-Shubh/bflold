<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.io.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="javazoom.upload.*"%>
<%@ page import="pkgPmegpNew.DBCon"%>

<html>
<head>
    <%
    response.setHeader("Cache-Control", "no-cache");
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
    %>
<%! 

public static String getExtension(String s) {
    String ext = null;
    int i = s.lastIndexOf('.');
    if (i > 0 &&  i < s.length() - 1) {
        ext = s.substring(i+1).toLowerCase();
    }
    return ext;
}


 %>
    <title>upload </title>
	<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script language="javascript">

window.onunload = refreshParent;
    function refreshParent() {
      window.opener.location.reload();
    }
	
function submit_form() {
	document.form.ins.value='I';
	document.form.submit();
	
}
</script>
</head>

<body>
<form method="post" name="form" id="form"  >
	  <p>
	    <%
		
		String APP_ID= request.getParameter("APP_ID")==null?"0":(String) request.getParameter("APP_ID");
		String UP_ID = request.getParameter("UP_ID");

if (UP_ID !=null ) {

        String APP_NAME="";
        String SUB_DT="";
		String MOB_NO1="";
		String E_MAIL="";
		String AADHAR_NO="";
		String UPM_CD = "";
		String DOC_NAME = "";
		String DOC_REMARKS = "";
		String DOC_TYPE = "";
		String DOC_DESC = "";
		
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
		 qryUp.append("   AUT.DOC_REMARKS,");
		qryUp.append("   TO_CHAR(AUT.UPLOAD_TIMESTAMP,'DD-MON-RRRR HH:MM') AS AUT_DT,");
		qryUp.append("  AUM.DOC_DESC");
		qryUp.append("  FROM APP_UPLOAD_TRANS AUT,APP_UPLOAD_MAST AUM");
		qryUp.append("   WHERE  AUT.UPM_CD = AUM.UPM_CD AND ");
		qryUp.append("   AUT.DOC_ACTYN='Y' AND AUT.UP_ID="+UP_ID+" ");
			
	ResultSet rsUp = db.execSQL(qryUp.toString());		
	
	while (rsUp.next()) {
	
		 UP_ID = rsUp.getString("UP_ID")==null?"":rsUp.getString("UP_ID");
		 DOC_NAME = rsUp.getString("DOC_NAME")==null?"":rsUp.getString("DOC_NAME");
		 DOC_REMARKS = rsUp.getString("DOC_REMARKS")==null?"":rsUp.getString("DOC_REMARKS");
		 DOC_DESC = rsUp.getString("DOC_DESC")==null?"":rsUp.getString("DOC_DESC");
	
	}
		rsUp.close();	
		
        %>
  </p>
	  <table align="center">
        <tr>
          <th colspan="2" scope="col"><div align="center">Document Delete Form  </div></th>
        </tr>
        <tr>
          <td colspan="2" scope="col"><div align="center"></div></td>
        </tr>
        
        
        <tr>
          <th scope="col"> Applicant ID 
          
          <input name="ins" type="hidden" id="ins" value=""></th>
          <th scope="col"><%= APP_ID %> </th>
        </tr>
        <tr>
          <th>Name </th>
          <th><div align="left">
              <div align="left"><%= APP_NAME %> </div></th>
        </tr>
        <tr>
          <th>Upload Type: </th>
          <th><%= DOC_DESC %></th>
        </tr>
        <tr>
          <td colspan="2"><div align="center"><img src="../pmegpappupload/<%= DOC_NAME %>" width="20%">
            <div align="center">		  
          </div></td>
        </tr>
        <tr>
          <th>Remarks</th>
          <td><%=  DOC_REMARKS %></td>
        </tr>
        <tr>
          <th colspan="2"><div align="center">
            <input name="btnClose" type="button" class="button" id="btnClose" value="Cancel" onClick="window.parent.HideModalWindow();">
            <input name="btnUpload" type="button" class="button" id="btnUpload" value="Delete" onClick="submit_form();">
          </div></th>
        </tr>
      </table>
	 <%
	 
	   try{
   if ((String)request.getParameter("ins")!=null){
   
   List values=new ArrayList();
		List pstm=new ArrayList();
		StringBuffer qryUpdate = new StringBuffer();
		qryUpdate.append("DELETE FROM  APP_UPLOAD_TRANS  WHERE UP_ID=?");
		values.clear();
        pstm.clear();
values.add(UP_ID); pstm.add ("L");
String insData="INSERT INTO APP_UPLOAD_TRANS_DEL SELECT * FROM APP_UPLOAD_TRANS WHERE UP_ID=?";
ResultSet rsUp1 = db.executeSQL(insData,values);
rsUp1.close();

db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate() ;
db.close();
response.sendRedirect("savemsgDelAgency.jsp");
   
 }//ins


}//try
catch(Exception e)
{out.println(e);}
finally{
//db.close();
}
}// end of if
%>
</form>
</body>
</html>