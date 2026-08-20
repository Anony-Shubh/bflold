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

</head>
<body> 

 <form name="form" id="form"  class="form" method="post">
	    <%
		  String OFF_TY_CD=(String) session.getAttribute("sOFF_TYPE_CD");
		  String STATE =(String) session.getAttribute("state_cd"); 
		String OFF_CD= request.getParameter("OFF_CD")==null?"0":(String) request.getParameter("OFF_CD");
		  if (!(OFF_TY_CD.equals("2")))
		  {
		  %>
		   <table align="center">
  <th colspan="4"><div align="center"> 
     
      Accrediated /APPROVED EDP CENTER UPDATE FORM 
     
  </div></th>

<tr  >
    <td colspan="4">Note: Only State Office of KVIC can UPdate/Add New EDP Training Center </td>
    </tr>

 <tr>
   <th colspan="4" class="redLebel"><div align="center">( In Case Training Center are Accrediated/Approved by Cental Office but <br>
      Not Showing in the List Please Contact State Office of KVIC to Add or Update the same.</div></th>
   </tr>
   </table>
		  
		  <%
		  //out.print("EDP Training Center is authorised to be added by State Director Only");
		  }else{
		  
		  
		String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");
		DBCon db= new DBCon();
        db.connect();
		
        StringBuffer qrysb = new StringBuffer();
		qrysb.append(" SELECT MOM.OFF_CD,MOM.OFF_TYPE_CD,MD.DISTRICT_NAME|| ' '|| MS.STATE_NM||' ('||MD.DISTRICT_CD ||')' AS DISTRICT_NAME,MD.DISTRICT_CD,MOM.OFF_ADDR1,MOM.OFF_ADDR2,MOM.CITY,MOM.PINCODE,MOM.OFF_TEL_NO,MOM.OFF_FAX_NO,MOM.OFF_EMAIL_ADDR," );
		qrysb.append(" MOM.OFF_NAME,MOM.OFF_LONG_DESC,MOM.CONT_PER1,MOM.CONT_PER2,MOM.PER1_NO,MOM.PER2_NO,MOM.PER1_EMAIL,MOM.PER2_EMAIL,MOM.LONGITUDE,");
		qrysb.append(" MOM.LATITUDE,MOM.CONT1_DESIG,MOM.JURIS_DIST_CD,MOM.ORG_CD,MOM.ACT_YN,MOM.AGENCY_TYPE FROM MAS_OFF_MAST MOM,M_DISTRICT MD,M_STATE MS");
		qrysb.append(" WHERE MOM.OFF_CD ="+OFF_CD+" AND MD.DISTRICT_CD=MOM.DISTRICT_CD AND MS.STATE_CD=MD.STATE_CD " );

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
String ORG_CD="";
String ACT_YN="";
String AGENCY_TYPE="";

  while(rsMain.next())
  {			
	  //OFF_CD=rsMain.getString("OFF_CD")==null?"":rsMain.getString("OFF_CD");	
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
	 }
			rsMain.close();
			
        %>

  <table align="center">
  <th colspan="4"><div align="center"> 
     
      <span class="style90 style96">Accrediated /APPROVED EDP CENTER UPDATE FORM </span>
      <input name="ins" type="hidden" id="ins" value="<%= ins %>">
  </div></th>

<tr bgcolor="#FF9E5E" >
    <td colspan="4">Note: Only State Office of KVIC can UPdate/Add New EDP Training Center </td>
    </tr>

 <tr>
   <th colspan="4" class="redLebel"><div align="center">( In Case Training Center are Accrediated/Approved by Cental Office but <br>
      Not Showing in the List Please Contact State Office of KVIC to Add or Update the same.</div></th>
   </tr>
 <tr>
 <th>EDP Center ID: </th>
    <th ><input name="OFF_CD" type="hidden" id="OFF_CD" value="<%=OFF_CD %>"> 
    <%= OFF_CD  %></th>
    <th >EDP CENTER TYPE </th>
   
    <td ><select name="OFF_TYPE_CD"  id="OFF_TYPE_CD">
        <option value="">Select EDP Center Type</option>

      <% 
	   String vOFF_TYPE_CD = "";
		  String vOFF_TYPE_LONG_DESC= "";
  
          ResultSet rsUp= db.execSQL("SELECT OFF_TYPE_CD ,OFF_TYPE_LONG_DESC FROM MAS_OFF_TYPE_CDMAST WHERE OFF_TYPE_CD IN (26,17,18)");
		 
		  while (rsUp.next()){
	      vOFF_TYPE_CD =rsUp.getString("OFF_TYPE_CD")==null?"":rsUp.getString("OFF_TYPE_CD");
		  vOFF_TYPE_LONG_DESC =rsUp.getString("OFF_TYPE_LONG_DESC")==null?"":rsUp.getString("OFF_TYPE_LONG_DESC");
		 
  %>
     <option value="<%=vOFF_TYPE_CD %>" <% if (vOFF_TYPE_CD.equals(OFF_TYPE_CD)){out.print("selected");} %>><%= vOFF_TYPE_LONG_DESC%></option>
<% }
rsUp.close();
%>
     </select></td>
	 </tr>
	<tr valign="baseline" class="style60">
      <th align="right" nowrap>EDP Center Short Name:       
      <td colspan="3">        </span>
        <input name="OFF_NAME" type="text" id="OFF_NAME" value="<%=OFF_NAME%>" size="40" maxlength="50">
      </span></td>
    </tr>
    <tr valign="baseline" class="style60">
      <th align="right" nowrap>Full Name of the EDP Center </th>
      <td colspan="3"><input name="OFF_LONG_DESC" type="text" id="OFF_LONG_DESC" value="<%=OFF_LONG_DESC %>" size="50" maxlength="50"></td>
    </tr>
    <tr valign="baseline" class="style60">
      <th align="right" nowrap>Address:</th>
      <td colspan="3"><input name="OFF_ADDR1" type="text" id="OFF_ADDR1" value="<%=OFF_ADDR1 %>" size="80" maxlength="80"></td>
    </tr>
    <tr valign="baseline" class="style60">
      <td align="right" nowrap>&nbsp;</td>
      <td colspan="3"><input name="OFF_ADDR2" type="text" id="OFF_ADDR2" value="<%=OFF_ADDR2 %>" size="80" maxlength="80">        <div align="right"></div></td>
    </tr>
	<tr>
	<th align="right" nowrap>City/Town:</th>
      <td colspan="3"><input name="CITY" type="text" id="CITY" value="<%=CITY %>" size="40" maxlength="40"></td>
	  </tr>
	  
	 <th>DISTRICT </th>
	
    <td><select name="DISTRICT_CD"  id="DISTRICT_CD">
        <option value="">Select DISTRICT</option>

      <% 
	   String vDISTRICT_CD = "";
		  String vDISTRICT_NAME= "";
  
          ResultSet rs= db.execSQL("SELECT DISTRICT_CD,DISTRICT_NAME FROM M_DISTRICT WHERE STATE_CD='"+STATE+"' ");
		 
		  while (rs.next()){
	      vDISTRICT_CD=rs.getString("DISTRICT_CD")==null?"":rs.getString("DISTRICT_CD");
		  vDISTRICT_NAME =rs.getString("DISTRICT_NAME")==null?"":rs.getString("DISTRICT_NAME");
		 
  %>
     <option value="<%=vDISTRICT_CD %>" <% if ( vDISTRICT_CD.equals(DISTRICT_CD)){out.print("selected");} %>><%=vDISTRICT_NAME%></option>
<% }
rs.close();
%>
     </select></td>
  
	 
   
  
  <th >PINCODE</th>
  <td>  <input name="PINCODE" type="text" id="PINCODE" value="<%=PINCODE%>" size="10" maxlength="6">    </td></tr>
  <tr>
  <th >TELEPHONE-NO</th>
  <td>  <input name="OFF_TEL_NO" type="text" id="OFF_TEL_NO" value="<%=OFF_TEL_NO %>" size="25" maxlength="25">    </td>


  
  <th >FAX-NO
    <input name="JURIS_DIST_CD" id="JURIS_DIST_CD" type="hidden" value="">
    <input name="LONGITUDE" type="hidden" id="LONGITUDE" value="<%=LONGITUDE %>">
    <input name="LATITUDE" type="hidden" id="LATITUDE" value="<%=LATITUDE%>"></th>
  <td>  <input name="OFF_FAX_NO" type="text" id="OFF_FAX_NO" value="<%=OFF_FAX_NO%>" size="25" maxlength="25">    </td>
  </tr>
  <tr>
  <th >EMAIL ADDRESS</th>
  <td colspan="3">  <input name="OFF_EMAIL_ADDR" type="text" id="OFF_EMAIL_ADDR" value="<%=OFF_EMAIL_ADDR %>" size="50" maxlength="50"> </td>
  </tr>
  </table>
   <table border="1" align="center" bordercolor="#000066" bgcolor="#FFFFFF">
    <tr bgcolor="#BC3F52" class="style60">
      <td colspan="4"><div align="center" class="style98">Contact Person Detail </div></td>
    </tr>
  <tr>
      <td><div align="center">Sr. No. </div></td>
      <td><div align="center">Name &amp; Designation </div></td>
      <td><div align="center">        Mobile No </div></td>
      <td><div align="center">Email</div></td>
    </tr>
  
   <tr> 
      <td class="style60">(1)</td>

  <td>  <input name="CONT_PER1" type="text" id="CONT_PER1" value="<%=CONT_PER1%>" size="30" maxlength="50">    </td>
  
  <td>  <input name="PER1_NO" type="text" id="PER1_NO" value="<%=PER1_NO %>" size="20" maxlength="10">    </td>  
  
  <td>  <input name="PER1_EMAIL" type="text" id="PER1_EMAIL" value="<%=PER1_EMAIL%>" size="40" maxlength="50"> </td>
  </tr>
  <tr>
      <td class="style60">(2)</td>

  <td>  <input name="CONT_PER2" type="text" id="CONT_PER2" value="<%=CONT_PER2%>" size="30" maxlength="50">    </td>
  
  <td>  <input name="PER2_NO" type="text" id="PER2_NO" value="<%=PER2_NO %>" size="20" maxlength="10">    </td>  
  
  <td>  <input name="PER2_EMAIL" type="text" id="PER2_EMAIL" value="<%=PER2_EMAIL%>" size="40" maxlength="50"> </td>
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
			//out.print (ins);
			//out.print ("<br> offcd:");
			//out.print (OFF_CD);
			
			try {
			
			if (ins.equals("I")){
			
	  OFF_CD = request.getParameter("OFF_CD")==null?"0":request.getParameter("OFF_CD");	
	  OFF_TYPE_CD =request.getParameter("OFF_TYPE_CD")==null?"":request.getParameter("OFF_TYPE_CD");
	  DISTRICT_CD=request.getParameter("DISTRICT_CD")==null?"":request.getParameter("DISTRICT_CD");
	  OFF_ADDR1=request.getParameter("OFF_ADDR1")==null?"":request.getParameter("OFF_ADDR1");
	  OFF_ADDR2=request.getParameter("OFF_ADDR2")==null?"":request.getParameter("OFF_ADDR2");
	  CITY=request.getParameter("CITY")==null?"":request.getParameter("CITY");
	  PINCODE=request.getParameter("PINCODE")==null?"":request.getParameter("PINCODE");
	  OFF_TEL_NO=request.getParameter("OFF_TEL_NO")==null?"":request.getParameter("OFF_TEL_NO");
	  OFF_FAX_NO=request.getParameter("OFF_FAX_NO")==null?"":request.getParameter("OFF_FAX_NO");
	  OFF_EMAIL_ADDR=request.getParameter("OFF_EMAIL_ADDR")==null?"":request.getParameter("OFF_EMAIL_ADDR");
	  OFF_NAME=request.getParameter("OFF_NAME")==null?"":request.getParameter("OFF_NAME");
	  OFF_LONG_DESC=request.getParameter("OFF_LONG_DESC")==null?"":request.getParameter("OFF_LONG_DESC");
	  CONT_PER1=request.getParameter("CONT_PER1")==null?"":request.getParameter("CONT_PER1");
	  CONT_PER2=request.getParameter("CONT_PER2")==null?"":request.getParameter("CONT_PER2");
	  PER1_NO=request.getParameter("PER1_NO")==null?"":request.getParameter("PER1_NO");
	  PER2_NO=request.getParameter("PER2_NO")==null?"":request.getParameter("PER2_NO");
	  PER1_EMAIL=request.getParameter("PER1_EMAIL")==null?"":request.getParameter("PER1_EMAIL");
	  PER2_EMAIL=request.getParameter("PER2_EMAIL")==null?"":request.getParameter("PER2_EMAIL");
	  JURIS_DIST_CD=request.getParameter("JURIS_DIST_CD")==null?"":request.getParameter("JURIS_DIST_CD");
	  LATITUDE=request.getParameter("LATITUDE")==null?"":request.getParameter("LATITUDE");
	  LONGITUDE=request.getParameter("LONGITUDE")==null?"":request.getParameter("LONGITUDE");
	  
			 List values=new ArrayList();
             List pstm=new ArrayList();
             StringBuffer sb= new StringBuffer();



 if (OFF_CD.equals("0"))
{
ResultSet rsMax = db.execSQL("select NVL(Max(OFF_CD),0) +1 FROM MAS_OFF_MAST");
while (rsMax.next()) {
OFF_CD=rsMax.getString(1);
}
rsMax.close();

 sb.append("  INSERT INTO MAS_OFF_MAST( OFF_TYPE_CD,DISTRICT_CD,OFF_ADDR1,OFF_ADDR2,  ");
 sb.append("  CITY,PINCODE,OFF_TEL_NO,OFF_FAX_NO,OFF_EMAIL_ADDR,OFF_NAME,OFF_LONG_DESC,  "); 
 sb.append("  CONT_PER1,CONT_PER2,PER1_NO,PER2_NO,PER1_EMAIL,PER2_EMAIL,JURIS_DIST_CD,LATITUDE,LONGITUDE,ACT_YN,TIME_STAMP,OFF_CD) VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,'Y',SYSDATE,?)"); 
}
else
{
sb.append("   UPDATE MAS_OFF_MAST SET ");
sb.append("   OFF_TYPE_CD=?,DISTRICT_CD=?,OFF_ADDR1=?,OFF_ADDR2=?,CITY=?,");
sb.append("   PINCODE=?,OFF_TEL_NO=?,OFF_FAX_NO=?,OFF_EMAIL_ADDR=?,OFF_NAME=?,OFF_LONG_DESC=?,CONT_PER1=?,");
sb.append("   CONT_PER2=?,PER1_NO=?,PER2_NO=?,PER1_EMAIL=?,PER2_EMAIL=?,JURIS_DIST_CD=?,LATITUDE=?,LONGITUDE=?,ACT_YN='Y',TIME_STAMP=SYSDATE ");
sb.append("   WHERE OFF_CD = ?");
}
db.setSqlValue(sb.toString());
db.setValues(values,pstm); 
 

 values.add (OFF_TYPE_CD);pstm.add ("D");
 values.add (DISTRICT_CD);pstm.add ("D");
 values.add (OFF_ADDR1);pstm.add ("D");
 values.add (OFF_ADDR2);pstm.add ("D");
 values.add (CITY);pstm.add ("D");
 values.add (PINCODE);pstm.add ("D");
 values.add (OFF_TEL_NO);pstm.add ("D");
 values.add (OFF_FAX_NO);pstm.add ("D");
 values.add (OFF_EMAIL_ADDR);pstm.add ("D");
 values.add (OFF_NAME);pstm.add ("D");
 values.add (OFF_LONG_DESC);pstm.add ("D");
 values.add (CONT_PER1);pstm.add ("D");
 values.add (CONT_PER2);pstm.add ("D");
 values.add (PER1_NO);pstm.add ("D");
 values.add (PER2_NO);pstm.add ("D");
 values.add (PER1_EMAIL);pstm.add ("D");
 values.add (PER2_EMAIL);pstm.add ("D");
 values.add (JURIS_DIST_CD);pstm.add ("D");
 values.add (LATITUDE);pstm.add ("D");
 values.add (LONGITUDE);pstm.add ("D");
 values.add (OFF_CD);pstm.add ("D");
  
	db.executeUpdate() ;
	db.close();
	
	 values.clear();
    pstm.clear();

	response.sendRedirect("../jsp/savemsg.jsp");

			
			}
			}catch (Exception e) {}
			
			%>


	
</table>    
<%}
%>
</form>

</body>
</html>