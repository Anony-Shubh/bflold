<%@ include file="includeHeaderPage.jsp" %>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script src="../js/inlineMsgMain.js"></script>
<script src="../js/validateAgency.js"></script>
</head>
<body> 
 <form name="form" id="form"  class="form" method="post">
	    <%
		
		String OFF_CD= "";
		String STATE_CD="";
		String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");
		DBCon db= new DBCon();
        db.connect();
		
        StringBuffer qrysb = new StringBuffer();
		qrysb.append(" SELECT MOM.OFF_CD,MOM.OFF_TYPE_CD,MD.DISTRICT_NAME AS DISTRICT_NAME,MD.STATE_CD,MD.DISTRICT_CD,MOM.OFF_ADDR1,MOM.OFF_ADDR2,MOM.CITY,MOM.PINCODE,MOM.OFF_TEL_NO,MOM.OFF_FAX_NO,MOM.OFF_EMAIL_ADDR," );
		qrysb.append(" MOM.OFF_NAME,MOM.OFF_LONG_DESC,MOM.CONT_PER1,MOM.CONT_PER2,MOM.PER1_NO,MOM.PER2_NO,MOM.PER1_EMAIL,MOM.PER2_EMAIL,MOM.LONGITUDE,");
		qrysb.append(" MOM.LATITUDE,MOM.CONT1_DESIG,MOM.JURIS_DIST_CD,MOM.ORG_CD,MOM.ACT_YN,MOM.AGENCY_TYPE FROM MAS_OFF_MAST MOM,M_DISTRICT MD,M_STATE MS");
		qrysb.append(" WHERE MOM.USER_ID ="+vUserID+" AND MD.DISTRICT_CD=MOM.DISTRICT_CD AND MS.STATE_CD=MD.STATE_CD " );

		ResultSet rsMain = db.execSQL(qrysb.toString());
		
		
String OFF_TYPE_CD="";
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
String OFF_DIS_CD = "";
String ORG_CD="";
String ACT_YN="";
String AGENCY_TYPE="";

  while(rsMain.next())
  {			
	  OFF_CD=rsMain.getString("OFF_CD")==null?"":rsMain.getString("OFF_CD");	
	  OFF_TYPE_CD=rsMain.getString("OFF_TYPE_CD")==null?"":rsMain.getString("OFF_TYPE_CD");
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
	  STATE_CD=rsMain.getString("STATE_CD")==null?"":rsMain.getString("STATE_CD");
	 }
			rsMain.close();
			
        %>

  <table align="center" cellpadding="4" cellspacing="4">
  <th colspan="4"><div align="center"> 
     
      <span class="style90 style96">AGENCY POFILE UPDATE FORM </span>
      <input name="ins" type="hidden" id="ins" value="<%= ins %>">
  </div></th>

<tr>
    <th colspan="4" nowrap><H1 align="center"> Jursdiction District Name: <%=DISTRICT_NAME %></H1></th>
    </tr>

 <tr>
 <th>Office ID 
   <input name="OFF_CD" type="hidden" id="OFF_CD" value="<%=OFF_CD %>">
   <input name="OFF_NAME" type="hidden" id="OFF_NAME" value="<%=OFF_NAME%>" maxlength="30"  ></th>
    <th ><%=OFF_NAME%></th>
    <th >Agency Type: </th>
   
    <th ><input name="OFF_TYPE_CD"  type="hidden" id="OFF_TYPE_CD" readonly="true" value="<%=OFF_TYPE_CD%>">
<%= AGENCY_TYPE  %>       

      </th>
    </tr>
	<tr valign="baseline" >
      <th align="right" nowrap>Office Name:        </td>
      <td colspan="3">
      <input name="OFF_LONG_DESC" type="text" id="OFF_LONG_DESC" value="<%=OFF_LONG_DESC %>" size="50" maxlength="50">      
      </span></span></td>
    </tr>
    <tr valign="baseline" >
      <th align="right" nowrap>Office Address </th>
      <td colspan="3"><input name="OFF_ADDR1" type="text" id="OFF_ADDR1" value="<%=OFF_ADDR1 %>" size="79" maxlength="79"></td>
    </tr>
    <tr valign="baseline" >
      <th align="right" nowrap>&nbsp;</th>
      <td colspan="3"><input name="OFF_ADDR2" type="text" id="OFF_ADDR2" value="<%=OFF_ADDR2 %>" size="75" maxlength="75">        <div align="right"></div></td>
    </tr>
	<tr>
	<th align="right" nowrap>City/Town:</th>
      <td><input name="CITY" type="text" id="CITY" value="<%=CITY %>" size="30" maxlength="40"></td>
      <th>Office District: </th>
      <td><select name="JURIS_DIST_CD"  id="JURIS_DIST_CD" >
        <option value="0">SELECT</option>
        <% 
	   String DIS_CD = "";
		  String DIS_NM= "";
  
          ResultSet rsDown= db.execSQL("SELECT MD.DISTRICT_CD,MD.DISTRICT_NAME FROM M_DISTRICT MD,M_STATE MS WHERE MD.STATE_CD=MS.STATE_CD AND MD.STATE_CD='"+STATE_CD+"' ");
		 
		  while (rsDown.next()){
	      DIS_CD =rsDown.getString("DISTRICT_CD")==null?"":rsDown.getString("DISTRICT_CD");
		  DIS_NM=rsDown.getString("DISTRICT_NAME")==null?"":rsDown.getString("DISTRICT_NAME");
		 
  %>
        <option value="<%= DIS_CD %>" <% if ( DIS_CD.equals(JURIS_DIST_CD)){out.print("selected");} %>><%= DIS_NM%></option>
        <% }
rsDown.close();
%>
      </select></td>
	</tr>
	     <th>Jurisdiction District: </th>
	
         <td><input name="DISTRICT_NAME" type="hidden" id="DISTRICT_NAME"  value="<%=DISTRICT_NAME %>">
	<input name="DISTRICT_CD" type="hidden" id="DISTRICT_CD" value="<%=DISTRICT_CD%>" >
	<%=DISTRICT_NAME %></td>
  
	 
   
  
  <th nowrap >PINCODE</th>
  <td>  <input name="PINCODE" type="text" id="PINCODE" value="<%=PINCODE%>" size="10" maxlength="6">    </td></tr>
  <tr>
  <th >TELEPHONE-NO</th>
  <td>  <input name="OFF_TEL_NO" type="text" id="OFF_TEL_NO" value="<%=OFF_TEL_NO %>" maxlength="25">    </td>


  
  <th nowrap >FAX-NO</th>
  <td>  <input name="OFF_FAX_NO" type="text" id="OFF_FAX_NO" value="<%=OFF_FAX_NO%>" maxlength="30">    </td>
  </tr>
  <tr>
  <th >EMAIL ADDRESS</th>
  <td colspan="3">  <input name="OFF_EMAIL_ADDR" type="text" id="OFF_EMAIL_ADDR" value="<%=OFF_EMAIL_ADDR %>" size="50" maxlength="50"> </td>
  </tr>
 
  </table>
   <table align="center">
    <tr bgcolor="#BC3F52" >
      <td colspan="4"><div align="center" class="style98">Contact Person Detail </div></td>
    </tr>
  <tr>
      <td><div align="center">Sr. No. </div></td>
      <td><div align="center">Name &amp; Designation </div></td>
      <td><div align="center">Telephone (STD)/<br>Mobile No </div></td>
      <td><div align="center">Email</div></td>
    </tr>
  
   <tr> 
      <td >(1)</td>

  <td>  <input name="CONT_PER1" type="text" id="CONT_PER1" value="<%=CONT_PER1%>" maxlength="30">    </td>
  
  <td>  <input name="PER1_NO" type="text" id="PER1_NO" value="<%=PER1_NO %>" maxlength="30">    </td>  
  
  <td>  <input name="PER1_EMAIL" type="text" id="PER1_EMAIL" value="<%=PER1_EMAIL%>" maxlength="50"> </td>
  </tr>
  <tr>
      <td >(2)</td>

  <td>  <input name="CONT_PER2" type="text" id="CONT_PER2" value="<%=CONT_PER2%>" maxlength="30">    </td>
  
  <td>  <input name="PER2_NO" type="text" id="PER2_NO" value="<%=PER2_NO %>" maxlength="30">    </td>  
  
  <td>  <input name="PER2_EMAIL" type="text" id="PER2_EMAIL" value="<%=PER2_EMAIL%>" maxlength="50"> </td>
  </tr>
  
  
  
  
   
  <tr>
    <th colspan="4"> 
         <div align="center">
		  <input name="Button" type="button" class="button" onClick="form_submit();" value="Save Record">
          <input name="Button" type="button" class="button" value="Cancel" onClick="self.close();">          
        </div></th>
  </tr>
  </table>
<%
			
			
			try {
			
			if (ins.equals("I")){
			
	  OFF_CD = request.getParameter("OFF_CD")==null?"0":request.getParameter("OFF_CD");		 
	  OFF_ADDR1=request.getParameter("OFF_ADDR1")==null?"":request.getParameter("OFF_ADDR1");
	  OFF_ADDR2=request.getParameter("OFF_ADDR2")==null?"":request.getParameter("OFF_ADDR2");
	  CITY=request.getParameter("CITY")==null?"":request.getParameter("CITY");
	  PINCODE=request.getParameter("PINCODE")==null?"":request.getParameter("PINCODE");
	  OFF_TEL_NO=request.getParameter("OFF_TEL_NO")==null?"":request.getParameter("OFF_TEL_NO");
	  OFF_FAX_NO=request.getParameter("OFF_FAX_NO")==null?"":request.getParameter("OFF_FAX_NO");
	  OFF_EMAIL_ADDR=request.getParameter("OFF_EMAIL_ADDR")==null?"":request.getParameter("OFF_EMAIL_ADDR");	  
	  OFF_LONG_DESC=request.getParameter("OFF_LONG_DESC")==null?"":request.getParameter("OFF_LONG_DESC");
	  CONT_PER1=request.getParameter("CONT_PER1")==null?"":request.getParameter("CONT_PER1");
	  CONT_PER2=request.getParameter("CONT_PER2")==null?"":request.getParameter("CONT_PER2");
	  PER1_NO=request.getParameter("PER1_NO")==null?"":request.getParameter("PER1_NO");
	  PER2_NO=request.getParameter("PER2_NO")==null?"":request.getParameter("PER2_NO");
	  PER1_EMAIL=request.getParameter("PER1_EMAIL")==null?"":request.getParameter("PER1_EMAIL");
	  PER2_EMAIL=request.getParameter("PER2_EMAIL")==null?"":request.getParameter("PER2_EMAIL");
	  JURIS_DIST_CD=request.getParameter("JURIS_DIST_CD")==null?"":request.getParameter("JURIS_DIST_CD");
	  
	  
			 List values=new ArrayList();
             List pstm=new ArrayList();
             StringBuffer sb= new StringBuffer();



 
sb.append("   UPDATE MAS_OFF_MAST SET ");
sb.append("   OFF_ADDR1=?,OFF_ADDR2=?,CITY=?,");
sb.append("   PINCODE=?,OFF_TEL_NO=?,OFF_FAX_NO=?,OFF_EMAIL_ADDR=?,OFF_LONG_DESC=?,CONT_PER1=?,");
sb.append("   CONT_PER2=?,PER1_NO=?,PER2_NO=?,PER1_EMAIL=?,PER2_EMAIL=?,JURIS_DIST_CD=? ");
sb.append("   WHERE OFF_CD = ?");

db.setSqlValue(sb.toString());
db.setValues(values,pstm); 
 

 
 values.add (OFF_ADDR1);pstm.add ("D");
 values.add (OFF_ADDR2);pstm.add ("D");
 values.add (CITY);pstm.add ("D");
 values.add (PINCODE);pstm.add ("D");
 values.add (OFF_TEL_NO);pstm.add ("D");
 values.add (OFF_FAX_NO);pstm.add ("D");
 values.add (OFF_EMAIL_ADDR);pstm.add ("D");
 values.add (OFF_LONG_DESC);pstm.add ("D");
 values.add (CONT_PER1);pstm.add ("D");
 values.add (CONT_PER2);pstm.add ("D");
 values.add (PER1_NO);pstm.add ("D");
 values.add (PER2_NO);pstm.add ("D");
 values.add (PER1_EMAIL);pstm.add ("D");
 values.add (PER2_EMAIL);pstm.add ("D");
 values.add (JURIS_DIST_CD);pstm.add ("D"); 
 values.add (OFF_CD);pstm.add ("D");
  
	db.executeUpdate() ;
	db.close();
	
	 values.clear();
    pstm.clear();
	
	

	response.sendRedirect("agencyProfileUpdate.jsp");

			
			}
			}catch (Exception e) {
			out.print (e.toString());
			
			}
			
			%>


	
</table>    
</form>
<script>
jQuery(function(){
$("#DISTRICT_NAME").autocomplete("itemlov.jsp");
});
   </script>

</body>
</html>