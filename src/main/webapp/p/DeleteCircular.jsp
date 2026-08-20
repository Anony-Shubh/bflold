<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.io.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.io.BufferedReader"%>

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
	<script type="text/javascript" src="../js/datetimepicker_css.js"></script>
	<script type="text/javascript" src="../js/inlineMsgMain.js"></script>
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

<form method="post" action="DeleteCircular.jsp" name="form" id="form" class="form"  >
<%

String vUserID=(String) session.getAttribute("userid")==null?"":(String)session.getAttribute("userid");

//out.print(vUserID);


if (vUserID.equals("")){
response.sendRedirect("index.jsp");
}


%>

	  <p>
	    <%
		
		
		
String CIR_ID=request.getParameter("CIR_ID")==null?"0":(String) request.getParameter("CIR_ID");
String CIR_SUB="";
String CIR_DATE="";
String KVIC_MSME="";
String FILE_NM="";
String ACT_YN="";
String CIRTIMESTAMP="";
String CIR_NO="";
		

		
		
        DBCon db= new DBCon();
        db.connect();
		
		StringBuffer qry = new StringBuffer();
       
	   
	   qry.append("   SELECT c.CIR_ID, c.CIR_SUB,  to_char(c.CIR_DATE,'DD-MON-RRRR') AS  CIR_DATE,  c.FILE_NM,  c.CIR_NO FROM PMEGPONLINE.CIRCULARS c WHERE c.CIR_ID=?   "      );
		
		

			 List values=new ArrayList();
				 values.add (CIR_ID); 

        ResultSet rsApp =db.executeSQL(qry.toString(),values);
 					 values.clear();	

        while (rsApp.next()){
	CIR_ID=rsApp.getString("CIR_ID")==null?"":rsApp.getString("CIR_ID");
CIR_SUB=rsApp.getString("CIR_SUB")==null?"":rsApp.getString("CIR_SUB");
CIR_DATE=rsApp.getString("CIR_DATE")==null?"":rsApp.getString("CIR_DATE");
CIR_NO=rsApp.getString("CIR_NO")==null?"":rsApp.getString("CIR_NO");


        }
			rsApp.close();
		
		
		
		
		

           %>
  </p>
	  <table align="center">
        <tr>
          <th colspan="2" scope="col"><div align="center">Online Circular Delete Form </div></th>
        </tr>
        <tr>
          <td colspan="2" scope="col"><div align="center"></div></td>
        </tr>
        <tr>
          <td colspan="2" scope="col"><div align="center">
            <input id="CIR_ID" name="CIR_ID" type="hidden" value="<%=CIR_ID%>"> 
            <span class="redLebel">(Delete Circular)</span> </div></td>
        </tr>
        
        <tr>
          <th scope="col"> Circular ID 
            <input type="hidden" name="todo" value="upload"/>
          <input name="ins" type="hidden" id="ins" value="">
          (Auto Generated) </th>
          <th scope="col"><%= CIR_ID %> </th>
        </tr>
        <tr>
          <th>Subject</th>
          <th><div align="left">
              <div align="left">
                <input name="CIR_SUB" type="text" id="CIR_SUB" size="50" maxlength="50" value="<%=CIR_SUB%>" readonly="true">
              </div></th>
        </tr>
        <tr>
          <th>Date</th>
          <th><input name="CIR_DATE" type="text" id="CIR_DATE" size="50" maxlength="50" value="<%=CIR_DATE%>" readonly="true" placeholder="DD-MON-YYYY" ></th>
        </tr>
        <tr>
          <th>Circular No </th>
          <th><input name="CIR_NO" type="text" id="CIR_NO" size="50" maxlength="50" value="<%=CIR_NO%>" readonly="true"></th>
        </tr>

       
        <tr>
          <th colspan="2"><div align="center">
            <input name="btnUpload" type="button" class="button" id="btnUpload" value="Delete" onClick="submit_form();">
            <input name="btnClose" type="button" class="button" id="btnClose" value="Cancel" onClick="self.close();">
          </div></th>
        </tr>
      </table>
	
	 <% if ((String)request.getParameter("ins")!=null){ 

CIR_ID=(String) request.getParameter("CIR_ID")==null?"0":(String) request.getParameter("CIR_ID").trim();

						StringBuffer qryUpdate = new StringBuffer();
						
						
							List pstm=new ArrayList();
						
						qryUpdate.append(" UPDATE PMEGPONLINE.CIRCULARS SET ACT_YN='N',CIRTIMESTAMP=SYSDATE  WHERE  CIR_ID=?  ");
						
						
						
						
		                values.add (CIR_ID);pstm.add ("S");
						db.setValues(values,pstm);
						db.setSqlValue(qryUpdate.toString());
						db.executeUpdate() ;
						pstm.clear();
							values.clear();	
							db.close();
							response.sendRedirect("savemsg.jsp");
						
	}
	 
	   %>
</form>
</body>
</html>
