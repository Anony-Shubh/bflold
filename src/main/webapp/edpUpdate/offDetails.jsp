<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>

<%
    response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
    %>
<html>
<head>
<title>
</title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script src="../js/inlineMsgMain.js"></script>
<script src="../js/update_validate.js"></script>
<script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
<script src="../js/jquery.autocomplete.js"></script>
<link rel="stylesheet" type="text/css" href="../css/autolist.css" />
<script language="javascript">
function closeAndRefresh(){
     parent.modalWin.HideModalPopUp()
    }
	</script>

</head>
<body> 
 <form name="form" id="form"  class="form" method="post">
	    <%
		String OFF_CD= request.getParameter("OFF_CD")==null?"0":(String) request.getParameter("OFF_CD");
		String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");
		DBCon db= new DBCon();
        db.connect();
		
        StringBuffer qrysb = new StringBuffer();
		qrysb.append(" SELECT MD.DISTRICT_NAME,MS.STATE_NM,MD.DISTRICT_CD,MOM.OFF_ADDR1,MOM.OFF_ADDR2,MOM.CITY,MOM.PINCODE,MOM.OFF_TEL_NO,MOM.OFF_FAX_NO,MOM.OFF_EMAIL_ADDR," );
		qrysb.append(" MOM.OFF_NAME,MOM.OFF_LONG_DESC,MOM.CONT_PER1,MOM.CONT_PER2,MOM.PER1_NO,MOM.PER2_NO,MOM.PER1_EMAIL,MOM.PER2_EMAIL,MOM.LONGITUDE,");
		qrysb.append(" MOM.LATITUDE,MOM.CONT1_DESIG,MOM.JURIS_DIST_CD,MOM.ORG_CD,MOM.ACT_YN,MOM.AGENCY_TYPE FROM MAS_OFF_MAST MOM,M_DISTRICT MD,M_STATE MS");
		qrysb.append(" WHERE MOM.OFF_CD ="+OFF_CD+" AND MD.DISTRICT_CD=MOM.DISTRICT_CD AND MS.STATE_CD=MD.STATE_CD " );

		ResultSet rsMain = db.execSQL(qrysb.toString());
		
		
String STATE="";
String DISTRICT_CD="";
String DISTRICT_NAME="";
String OFF_ADDR1="";
String OFF_ADDR2="";
String CITY="";
String PINCODE="";
String OFF_TEL_NO="";
String OFF_FAX_NO="";
String OFF_EMAIL_ADDR="";
String OFF_NAME="";
String OFF_LONG_DESC="";
String CONT_PER1="";
String CONT_PER2="";
String PER1_NO="";
String PER2_NO="";
String PER1_EMAIL="";
String PER2_EMAIL="";
String JURIS_DIST_CD="";
String LATITUDE="";
String LONGITUDE=""; 
//String OFF_CD = "";
String ORG_CD="";
String ACT_YN="";
String AGENCY_TYPE="";

  while(rsMain.next())
  {			
	  //OFF_CD=rsMain.getString("OFF_CD")==null?"":rsMain.getString("OFF_CD");	
	  STATE=rsMain.getString("STATE_NM")==null?"":rsMain.getString("STATE_NM");
	  DISTRICT_CD=rsMain.getString("DISTRICT_CD")==null?"":rsMain.getString("DISTRICT_CD");
	  DISTRICT_NAME=rsMain.getString("DISTRICT_NAME")==null?"":rsMain.getString("DISTRICT_NAME");
	  OFF_ADDR1=rsMain.getString("OFF_ADDR1")==null?"":rsMain.getString("OFF_ADDR1");
	  OFF_ADDR2=rsMain.getString("OFF_ADDR2")==null?"":rsMain.getString("OFF_ADDR2");
	  CITY=rsMain.getString("CITY")==null?"":rsMain.getString("CITY");
	  PINCODE=rsMain.getString("PINCODE")==null?"":rsMain.getString("PINCODE");
	  OFF_TEL_NO=rsMain.getString("OFF_TEL_NO")==null?"":rsMain.getString("OFF_TEL_NO");
	  OFF_FAX_NO=rsMain.getString("OFF_FAX_NO")==null?"":rsMain.getString("OFF_FAX_NO");
	  OFF_EMAIL_ADDR=rsMain.getString("OFF_EMAIL_ADDR")==null?"":rsMain.getString("OFF_EMAIL_ADDR");
	  OFF_NAME=rsMain.getString("OFF_NAME")==null?"":rsMain.getString("OFF_NAME");
	  OFF_LONG_DESC=rsMain.getString("OFF_LONG_DESC")==null?"":rsMain.getString("OFF_LONG_DESC");
	  CONT_PER1=rsMain.getString("CONT_PER1")==null?"":rsMain.getString("CONT_PER1");
	  CONT_PER2=rsMain.getString("CONT_PER2")==null?"":rsMain.getString("CONT_PER2");
	  PER1_NO=rsMain.getString("PER1_NO")==null?"":rsMain.getString("PER1_NO");
	  PER2_NO=rsMain.getString("PER2_NO")==null?"":rsMain.getString("PER2_NO");
	  PER1_EMAIL=rsMain.getString("PER1_EMAIL")==null?"":rsMain.getString("PER1_EMAIL");
	  PER2_EMAIL=rsMain.getString("PER2_EMAIL")==null?"":rsMain.getString("PER2_EMAIL");
	  JURIS_DIST_CD=rsMain.getString("JURIS_DIST_CD")==null?"":rsMain.getString("JURIS_DIST_CD");
	  LATITUDE=rsMain.getString("LATITUDE")==null?"":rsMain.getString("LATITUDE");
	  LONGITUDE=rsMain.getString("LONGITUDE")==null?"":rsMain.getString("LONGITUDE");
	  ORG_CD=rsMain.getString("ORG_CD")==null?"":rsMain.getString("ORG_CD");
	  ACT_YN=rsMain.getString("ACT_YN")==null?"":rsMain.getString("ACT_YN");
	  AGENCY_TYPE=rsMain.getString("AGENCY_TYPE")==null?"":rsMain.getString("AGENCY_TYPE");
	 }
			rsMain.close();
			db.close();
        %>

  <table align="center"><tr bgcolor="#FF9E5E" >
    <td colspan="4"><div align="center">
      <h2><span class="style90 style96">EDP CENTER DETAILS </span>
            <input name="ins" type="hidden" id="ins" value="<%= ins %>">
      </h2>
    </div></td>
    </tr>
	<tr>
	
	<th >OFFICE NAME</th>
    <td>  <%=OFF_NAME%>    </td></tr>
	<tr valign="baseline" class="style60">
      <th align="right" nowrap>Address:</td>
      <td colspan="3">
         <%=OFF_LONG_DESC %> </td>
    </tr>
    <tr valign="baseline" class="style60">
      <td align="right" nowrap>&nbsp;</td>
      <td colspan="3"> <%=OFF_ADDR1 %></td>
    </tr>
    <tr valign="baseline" class="style60">
      <td align="right" nowrap>&nbsp;</td>
      <td colspan="3"><%=OFF_ADDR2 %></td>
    </tr>
	<tr>
	<th align="right" nowrap>City/Town:</th>
      <td colspan="3"><%=CITY %></td>
	  </tr>
	  <tr>
	 <th>DISTRICT </th>
	
    <td><%=DISTRICT_NAME %>
	</td></tr>
	 <tr>
	 <th>STATE</th>
	
    <td><%=STATE%>
	</td></tr>
  <tr>  
  <th >PINCODE</th>
  <td><%=PINCODE%></td></tr>
  <tr>
  <th >TELEPHONE-NO</th>
  <td><%=OFF_TEL_NO %>   </td>
</tr>
<tr>
  
  <th >FAX-NO</th>
  <td><%=OFF_FAX_NO%>    </td>
  </tr>
  <tr>
  <th >EMAIL ADDRESS</th>
  <td> <%=OFF_EMAIL_ADDR %> </td>
  </tr>
  
 
    <tr bgcolor="#FF9E5E" class="style60">
      <td colspan="4"><div align="center" class="style98">
        <h2>Contact Person Detail </h2>
      </div></td>
    </tr>
  <tr>
      <th width="58"><div align="center">Sr. No. </div></th>
      <th width="240"><div align="center">Name &amp; Designation </div></th>
      <th width="180"><div align="center">Telephone (STD)/<br>Mobile No </div></th>
      <th width="180"><div align="center">Email</div></th>
    </tr>
  
   <tr> 
      <td class="style60">(1)</td>

  <td>  <%=CONT_PER1%></td>
  
  <td><%=PER1_NO %></td>  
  
  <td><%=PER1_EMAIL%></td>
  </tr>
  <tr>
      <td class="style60">(2)</td>

  <td> <%=CONT_PER2%></td>
  
  <td><%=PER2_NO %></td>  
  
  <td><%=PER2_EMAIL%></td>
  </tr>
  
  
  
  
   
  <tr>
    <th colspan="4"> 
         <div align="center">
		  
          <input name="Button" type="button" class="button" value="CLOSE" onclick="closeAndRefresh();">          
        </div></th>
  </tr>
  </table>
	
</table>    
</form>


</body>
</html>