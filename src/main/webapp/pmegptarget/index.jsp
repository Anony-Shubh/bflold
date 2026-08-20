<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%
    response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
    %>
	<html>
<head>
<script src="https://code.jquery.com/jquery-1.12.3.js"></script>
<link href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css">
<script src="https://cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>
<script src="../js/dis.js"></script>
<link rel="stylesheet" type="text/css" href="../css/dis.css">
</head>
<body>

<form name="form" id="form" action="" class="form" method="post">  

<img src="../images/pmegponline.jpg" width="100%" height="150">
  <%@ include file="AppIncludePage.jsp" %>


  
		
    <center>
</p>
<div id = "view"  >
<%
DBCon db= new DBCon();
db.connect();
 int srn =0;
 
StringBuffer qrysb = new StringBuffer();
 qrysb.append("  SELECT OFF_NAME1,STATE_NM, " ); 
 qrysb.append("  COUNT(DISTINCT( DISTRICT_CD)) AS NO_OF_DISTRICT, " ); 
 qrysb.append("  SUM(NVL(PRJ_NO_TGT,0)) AS PRJ_NO_TGT,  " );
 qrysb.append("  SUM(NVL(MM_TGT,0)) AS MM_TGT FROM  " );
 qrysb.append("  (SELECT MS.STATE_NM, " );
 qrysb.append("   MOM.OFF_NAME, " );
 qrysb.append("  MOM.OFF_NAME1, " );
 qrysb.append("  MD.DISTRICT_NAME, " );
 qrysb.append(" MOM.AGENCY_TYPE, " );
 qrysb.append(" MOM.OFF_CD, " );
 qrysb.append("  MOM.DISTRICT_CD, " );
 qrysb.append(" PMT.MMTGT_ID,  " );
 qrysb.append(" PMT.TGT_YR,  " );
 qrysb.append(" PMT.MM_TGT,  " );
 qrysb.append(" PMT.PRJ_NO_TGT  " );
 qrysb.append(" FROM MAS_OFF_MAST MOM,  " );
 qrysb.append(" M_DISTRICT MD,  " );
 qrysb.append("  M_STATE MS,  " );
 qrysb.append("  PMEGP_MMTARGET PMT  " );
 qrysb.append(" WHERE MOM.OFF_CD     = PMT.OFF_CD(+)  " );
 qrysb.append("AND MOM.DISTRICT_CD  = MD.DISTRICT_CD " );
 qrysb.append("AND MS.STATE_CD      = MD.STATE_CD  " );
 qrysb.append(" AND MOM.ACT_YN       = 'Y'" );
 qrysb.append("AND MOM.OFF_TYPE_CD IN (2, 3, 5, 22)  )  GROUP BY OFF_NAME1, STATE_NM " );


ResultSet rsMain = db.execSQL(qrysb.toString());


%>
<p></p>
<p></p>
<p></p>
<p></p>


<br/>
<input name="ins" type="hidden" id="ins" value="">

<br/>
<table id="example" class="display" cellspacing="0" width="100%">
        <thead>
            <tr>
			    <th>SR.NO</th>	
				<th>STATE NAME</th>
                <th>OFFICE NAME</th> 
				<th>NO_OF_DISTRICT</th>
                <th>TOTAL_PROJECT</th>               
				<th>TOTAL MM TARGET  </th>
                <th>REPORT</th>
            </tr>
        </thead>
       
		        <tbody>
				
				
                
            
       <% 
	  String STATE_NM= ""; 	 
	  String OFF_NAME= ""; 
	  String NO_OF_DISTRICT= "";
	  String PRJ_NO_TGT= "";
	  String MM_TGT= "";
	  
	  while (rsMain.next()){
		  srn=srn+1;
	 
	  STATE_NM=rsMain.getString("STATE_NM")==null?"":rsMain.getString("STATE_NM");	  
	  OFF_NAME=rsMain.getString("OFF_NAME1")==null?"":rsMain.getString("OFF_NAME1");
	  NO_OF_DISTRICT =rsMain.getString("NO_OF_DISTRICT")==null?"":rsMain.getString("NO_OF_DISTRICT");
	  PRJ_NO_TGT=rsMain.getString("PRJ_NO_TGT")==null?"":rsMain.getString("PRJ_NO_TGT");
	  MM_TGT=rsMain.getString("MM_TGT")==null?"":rsMain.getString("MM_TGT");
	   %>
      <tr>
			
                <td><%=srn%></td>
                <td><%= STATE_NM%></td>	
                <td><div align="center"><a href="prodTarDistWise.jsp?OFF_NAME=<%= OFF_NAME%>" target="_parent"><%= OFF_NAME%></a></div></td>				
                <td><div align="center"><%= NO_OF_DISTRICT  %></div></td>
				<td><div align="center"><%= PRJ_NO_TGT%></div></td>
				<td><div align="center"><%= MM_TGT%></div></td>
				<td><a href="officewise_repo.jsp?OFF_NAME=<%= OFF_NAME %>" target="_parent" class="button">View Report</a></td>
               
	           
        </td>
                
            </tr>
			<%
			}
			rsMain.close();
			db.close();
			%>
            
        </tbody>
    </table>
</div>

  <p>&nbsp;</p>
  <p>&nbsp;</p>
 
			 
  <table class="pmegpTable"><br>
<tr>

<th>
 <center> <h2>For Technical issues contact email: pmegpeportal@kvic.gov.in and PMEGP Scheme related queries contact email: pmegp@kvic.gov.in</h2>
 </center>
  </th>
  </tr>
  </table>
 

</form>
</body>
</html>
