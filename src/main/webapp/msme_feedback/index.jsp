<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="pkgPmegpNew.DBCon"%>
<%@ page buffer="200kb" %>

<html>
<head>
<title>PMEGP FEEDBACK</title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<link rel="stylesheet" type="text/css" href="../css/jquery.dataTables.min.css" />
<script type="text/javascript" src="../js/pmegpOnlinemessages.js"></script>
<script type="text/javascript" src="../js/ModalPopupWindow.js"></script>
<script language="javascript" src="../js/jquery-1.12.4.js"></script>
<script language="javascript" src="../js/jquery.dataTables.min.js"></script>
<script language="javascript">
$(document).ready(function() {
    $('#example').DataTable( {
    } );
} );


function submitfun(){
document.form.ins.value='I';
document.form.submit();
}



</script>
<style type="text/css">
<!--
.style1 {
	color: #CC6600;
	font-size: 24px;
	font-weight:bolder;
}
-->
</style>
</head>

<body >

<form name="form" id="form"  class="form" method="post">

<img src="../images/pmegponline.jpg" width="100%" height="150" >
<%


 DBCon db= new DBCon();
db.connect();
 List values=new ArrayList();


String SRNO = "";

String APP_ID = "";

String APP_NAME = "";
String OFF_NAME = "";
String AGENCY_TYPE = "";
String DISTRICT_NAME = "";
String SUB_DT="";

StringBuffer qrysb= new StringBuffer();

//qrysb.append("	select p.*,rownum as srno from ( "      );

qrysb.append("	SELECT  "      );
qrysb.append("	 ROWNUM AS SRNO,   ad.app_id, "      );
qrysb.append("	    ad.app_name, "      );
qrysb.append("	    mom.off_name1 as off_name, "      );
qrysb.append("	    mom.agency_type, "      );
qrysb.append("	    md.district_name , to_char( mfo.time_stamp,'dd-MON-yyyy') AS SUB_DT "      );
qrysb.append("	FROM "      );
qrysb.append("	    app_detail               ad, "      );
qrysb.append("	    bank_dataentry           bd, "      );
qrysb.append("	    mas_off_mast             mom, "      );
qrysb.append("	    m_district               md, "      );
qrysb.append("	    m_state                  ms, "      );
qrysb.append("	    msme_feedback_form_one   mfo "      );
qrysb.append("	WHERE "      );
qrysb.append("	    ad.app_id = bd.app_id "      );
qrysb.append("	    AND ad.off_cd = mom.off_cd "      );
qrysb.append("	    AND md.district_cd = ad.unit_dist_cd "      );
qrysb.append("	    AND ad.app_id = mfo.app_id "      );
qrysb.append("	    AND md.state_cd = ms.state_cd "      );
qrysb.append("	    AND MFO.ACT_YN='Y' order by  to_date(mfo.time_stamp) desc "      );


	%>



<div align="center">
  <input type="hidden" name="ins" id="ins">
  <br>
  <span ><strong><span class="style1">MSME FEEBACK</span><br>
 
  </strong> </span></div>


          <table  align="center"  class="display" id="example" width="100%">
            <thead>
              <tr>
                <th>Srno.</th>
                <th>Agency </th>
                <th>Office Name </th>
                <th>Application Id </th>
                <th>Applicant Name </th>
                <th bgcolor="#FFCCFF">District</th>
                <th bgcolor="#FFCCFF">Submission Date </th>
                <th bgcolor="#FFCCFF"><a href="GenRep.jsp?APP_ID=<%= APP_ID %>" target="_blank" class="buttonOrange">View All Feedback</a></th>
              </tr>
            </thead>
            <tbody>
              <%

	
	 ResultSet rsMain = db.executeSQL(qrysb.toString(),values);
		values.clear();	
		
		while (rsMain.next()){ 
		SRNO=rsMain.getString("SRNO")==null?"":rsMain.getString("SRNO");
APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");
APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
OFF_NAME=rsMain.getString("OFF_NAME")==null?"":rsMain.getString("OFF_NAME");
AGENCY_TYPE=rsMain.getString("AGENCY_TYPE")==null?"":rsMain.getString("AGENCY_TYPE");
DISTRICT_NAME=rsMain.getString("DISTRICT_NAME")==null?"":rsMain.getString("DISTRICT_NAME");
SUB_DT=rsMain.getString("SUB_DT")==null?"":rsMain.getString("SUB_DT");

	%>
              <tr>
                <td><%= SRNO %></td>
                <td><%= AGENCY_TYPE %></td>
                <td><%= OFF_NAME %></td>
                <td><%= APP_ID %></td>
                <td><%= APP_NAME %></td>
                <td><%= DISTRICT_NAME %></td>
                <td><%= SUB_DT %></td>
                <td><a href="GenRep.jsp?APP_ID=<%= APP_ID %>" target="_blank" class="buttonMerun">View Feedback</a></td>
              </tr>
              <%
	}
	rsMain.close();
	db.close();
	
	%>
            </tbody>
          </table>
</form>
 

</body>
</html>
