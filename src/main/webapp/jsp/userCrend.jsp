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
	

  <script language="javascript">
        function closeAndRefresh() {
            window.parent.refreshpage();
        }

    </script>


    
	<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />

</head>

<body >
<form method="post" action="userCrend.jsp" name="form" id="form" class="form"  >


	  <p>
	    <%
		
		String APP_ID= (String) session.getAttribute("sAPP_ID");
		String vOffcd= (String) session.getAttribute("off_cd");
        String APP_NAME="";
        String SUB_DT="";
		String MOB_NO1="";
		String E_MAIL="";
		String AADHAR_NO="";
		String APP_PWD = "";
		String UPM_CD = "";
		String DOC_NAME = "";
		String DOC_REMARKS = "";
		
		String AGE = "";
		String ACTIVITY_CD = "";
		String DOB = "";
		String ORG_CD = "";
			String APPUSERID = "";
			String sOFF_TYPE_CD=(String) session.getAttribute("sOFF_TYPE_CD");
			String sdistrict_cd =(String) session.getAttribute("sdistrict_cd");
			String sagency_type=(String) session.getAttribute("sagency_type");
			String vwhereqry="";
			String vUserID=(String)session.getAttribute("user_id");
			if (sOFF_TYPE_CD.equals("2")){
			 vwhereqry =" AND MOM.DISTRICT_CD= "+sdistrict_cd+"  AND A.APP_ID='"+APP_ID+"' ";
			}else{
			vwhereqry =" AND MOM.USER_ID= "+vUserID+"  AND A.APP_ID='"+APP_ID+"' ";
			}
        DBCon db= new DBCon();
        db.connect();

         

           StringBuffer qry = new StringBuffer();
         qry.append(" SELECT A.APP_ID, ");
		  qry.append(" UPPER(A.APP_NAME) AS APP_NAME,A.APP_PWD,substr(A.App_id,instr(A.App_id,'-')+1,length(A.app_id)) AS APPUSERID ");
		 	  qry.append(" FROM APP_DETAIL_ONLINE A,MAS_OFF_MAST MOM  ");
			  qry.append(" WHERE A.OFF_CD=MOM.OFF_CD "+vwhereqry+" ");
//out.print(qry.toString());
        ResultSet rsApp = db.execSQL(qry.toString());
		
		
        while (rsApp.next()){
		APP_ID=rsApp.getString("APP_ID")==null?"":rsApp.getString("APP_ID");
        APP_NAME=rsApp.getString("APP_NAME")==null?"":rsApp.getString("APP_NAME");
        APPUSERID=rsApp.getString("APPUSERID")==null?"":rsApp.getString("APPUSERID");
	  APP_PWD=rsApp.getString("APP_PWD")==null?"":rsApp.getString("APP_PWD");
		
		
        }
			rsApp.close();
			
        %>
  </p>
	  <table align="center">
        <tr>
          <th colspan="2" scope="col"><div align="center"><h1>ONLINE APPLICANT LOGIN CREDENTIAL</h1> </div></th>
        </tr>
        <tr>
          <td colspan="2" scope="col"><div align="center"></div></td>
        </tr>
        <tr>
          <td colspan="2" scope="col">             </td>
        </tr>
        
       
        <tr>
          <th scope="col"> Applicant ID 
          
          <input name="ins" type="hidden" id="ins" value=""></th>
          <td scope="col"><div align="center"><%= APP_ID %> </div></td>
        </tr>
        <tr>
          <th>Applicant Name </th>
          <td>
              <div align="center"><%= APP_NAME %> </div></td>
        </tr> 
       
       
		  <tr>
          <th>USERID </th>
          <td>
		    <div align="center"><%=APPUSERID%>	          </div></td>
        </tr>
		  <tr>
          <th>PASSWORD </th>
          <td><div align="center"><%=APP_PWD%></div></td>
        </tr>
		 
        <tr>
          <th colspan="2"><div align="center">
            <input name="btnUpload" type="button" class="button" id="btnUpload" value="Close" onClick="closeAndRefresh();">
          </div></th>
        </tr>
      </table>
	
	  
</form>


</body>
</html>