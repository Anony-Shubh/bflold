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
<script src="../js/validaterrb.js"></script>

<script>
function populateValue(vname,vname1) {
var str=document.getElementsByName(""+vname+"")[0].value
var fn=str.indexOf("("); 
var fnLast=str.indexOf(")"); 
fnLast=fnLast;
fn=fn+1;
//var len=str.length;
//len=len-1;
var getcd=str.substring(fn,fnLast);
getcd =getcd.replace(/^\s+|\s+$/gm,'');

if (fn=='0') {
document.getElementsByName(""+vname+"")[0].value='';

}else {
document.getElementsByName(""+vname1+"")[0].value=getcd;
}

}
</script>
 


</head>
<body> 
 <form name="form" id="form"  class="form" >
	    <%
		String BR_CODE = request.getParameter("BR_CODE")==null?"":(String) request.getParameter("BR_CODE");
		//out.print(BR_CODE);		
		String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");
		DBCon db= new DBCon();
        db.connect();
		
        StringBuffer qrysb = new StringBuffer();
		qrysb.append("  SELECT BRCODE,IFSC_CODE,MICR_CODE,BANK_CODE,  ");
		qrysb.append("  IFSCID,NEFT_IFSC,BANK_NAME,BRANCHNAME,ADDRESS,CENTRE,STATE_CD,DISTRICT,DISTRICT_CD,BANK_PINCD,  "); 
		qrysb.append("  TEL_NO,FAX_NO,EMAIL,CONT_NAME,MOBNO,DESIG FROM RBIBANKLIST_RRB WHERE BRCODE='"+BR_CODE+"'  "); 

		ResultSet rsMain = db.execSQL(qrysb.toString());
		
		
//String BR_CODE="";
String IFSC_CODE="";
String MICR_CODE="";
String BANK_CODE="";
String IFSC_ID="";
String NEFT_IFSC="";
String BANK_NAME="";
String ADDRESS="";
String BRANCHNAME="";
String CENTRE="";
String STATE="";
String DISTRICT="";
String BANK_PINCD="";
String TEL_NO="";
String FAX_NO="";
String EMAIL="";
String CONT_NAME="";
String MOBNO="";
String DESIG="";
String DISTRICT_CD="";


  while(rsMain.next())
  {			
	  //BRCODE=rsMain.getString("BRCODE")==null?"":rsMain.getString("BRCODE");	
	  IFSC_CODE=rsMain.getString("IFSC_CODE")==null?"":rsMain.getString("IFSC_CODE");
	  MICR_CODE=rsMain.getString("MICR_CODE")==null?"":rsMain.getString("MICR_CODE");
	  BANK_CODE=rsMain.getString("BANK_CODE")==null?"":rsMain.getString("BANK_CODE");
	  IFSC_ID=rsMain.getString("IFSCID")==null?"":rsMain.getString("IFSCID");	  
	  NEFT_IFSC=rsMain.getString("NEFT_IFSC")==null?"":rsMain.getString("NEFT_IFSC");	  
	  BANK_NAME=rsMain.getString("BANK_NAME")==null?"":rsMain.getString("BANK_NAME");
	  BRANCHNAME=rsMain.getString("BRANCHNAME")==null?"":rsMain.getString("BRANCHNAME");
	  ADDRESS=rsMain.getString("ADDRESS")==null?"":rsMain.getString("ADDRESS");
	  CENTRE=rsMain.getString("CENTRE")==null?"":rsMain.getString("CENTRE");
	  STATE=rsMain.getString("STATE_CD")==null?"":rsMain.getString("STATE_CD");
	  DISTRICT=rsMain.getString("DISTRICT")==null?"":rsMain.getString("DISTRICT");
	  BANK_PINCD=rsMain.getString("BANK_PINCD")==null?"":rsMain.getString("BANK_PINCD");
	  TEL_NO=rsMain.getString("TEL_NO")==null?"":rsMain.getString("TEL_NO");
	  FAX_NO=rsMain.getString("FAX_NO")==null?"":rsMain.getString("FAX_NO");
	  EMAIL=rsMain.getString("EMAIL")==null?"":rsMain.getString("EMAIL");
	  CONT_NAME=rsMain.getString("CONT_NAME")==null?"":rsMain.getString("CONT_NAME");
	  MOBNO=rsMain.getString("MOBNO")==null?"":rsMain.getString("MOBNO");
	  DESIG=rsMain.getString("DESIG")==null?"":rsMain.getString("DESIG");
	  
	 }
			rsMain.close();
			

ResultSet rsSTATE=db.execSQL("SELECT STATE_CD,STATE_NM FROM M_STATE ");		
        %>

        <table align="center">
  <th colspan="4"><div align="center">REGINOL RURAL BANK UPDATE              
        <input name="ins" type="hidden" id="ins" value="<%= ins %>">
    </div></th>
  <tr bgcolor="#FF9E5E" >
    <td colspan="4">&nbsp;</td>
  </tr>
  <tr>
    <th>BR_CODE</th>
    <td ><input name="BR_CODE" type="text" id="BR_CODE"  value="<%=BR_CODE%>" size="20" maxlength="20" readonly="true" ></td>
    <th>NEFT_IFSC</th>
    <td><input name="NEFT_IFSC" type="text" id="NEFT_IFSC"  value="<%=NEFT_IFSC%>" size="20" maxlength="20" readonly="true" ></td>  
  </tr>
   <tr>
    <th >BANK_NAME</th>
    <td><input name="BANK_NAME" type="text" id="BANK_NAME" value="<%=BANK_NAME%>"  size="50" maxlength="40" readonly="true">
    </td>
	<th >IFSC_CODE</th>
    <td><input name="IFSC_CODE" type="text" id="IFSC_CODE" value="<%=IFSC_CODE%>" size="20" maxlength="11" readonly="true"></td>
  </tr>
   <tr valign="baseline" class="style60">
     <th>BRANCHNAME</th>
     <td colspan="3"><input name="BRANCHNAME" type="text" id="BRANCHNAME" value="<%=BRANCHNAME %>" size="30" maxlength="30"></td>
   </tr>
   <tr valign="baseline" class="style60">
    <th align="right" nowrap>ADDRESS: </th>
    <td colspan="3"><input name="ADDRESS" type="text" id="ADDRESS" value="<%=ADDRESS%>" size="50" maxlength="40">
    </td>
  </tr>
  <tr valign="baseline" class="style60">
    <th>CITY</th>
    <td colspan="3"><input name="CENTRE" type="text" id="CENTRE" value="<%=CENTRE%>" size="30" maxlength="30">
        <div align="right"></div></td>
  </tr>
  <tr>
    <th align="right" nowrap>STATE:</th>
    <td colspan="3"><select name="STATE" id="STATE" >	
       <option value="0">Select State</option>

      <% 
   
   
String v_statecd="";
String v_statenm="";
   while(rsSTATE.next())
  {
   v_statecd=rsSTATE.getString("STATE_CD")==null?"":rsSTATE.getString("STATE_CD");
   v_statenm=rsSTATE.getString("STATE_NM")==null?"":rsSTATE.getString("STATE_NM");
  
  %>
     <option value="<%=v_statecd %>" <% if (v_statecd.equals(STATE)){out.print("selected");} %>><%= v_statenm %></option>
	 
	 
<% }
rsSTATE.close();
%>
     </select>
    </td>
  </tr>
  <th>DISTRICT </th>
      <td><input name="DISTRICT_NAME" type="text" id="DISTRICT_NAME" value="<%=DISTRICT %>" onBlur="populateValue('DISTRICT_NAME','DISTRICT_CD');" size="35" maxlength="40">
          <input name="DISTRICT_CD" type="hidden" id="DISTRICT_CD" value="<%=DISTRICT_CD%>" readonly="readonly" ></td>
      <th >PINCODE</th>
      <td><input name="BANK_PINCD" type="text" id="BANK_PINCD" value="<%=BANK_PINCD%>" maxlength="6"></td>
  </tr>
  <tr>
    <th >TELEPHONE-NO</th>
    <td><input name="TEL_NO" type="text" id="TEL_NO" value="<%=TEL_NO %>" maxlength="30">
    </td>
    <th >FAX-NO</th>
    <td><input name="FAX_NO" type="text" id="FAX_NO" value="<%=FAX_NO%>" maxlength="30">
    </td>
  </tr>
  <tr>
    <th >EMAIL ADDRESS</th>
    <td><input name="EMAIL" type="text" id="EMAIL" value="<%=EMAIL%>" size="50" maxlength="30">
    </td>
    
  </tr>
        </table>
   <table width="880" border="1" align="center" bordercolor="#000066" bgcolor="#FFFFFF">
    <tr bgcolor="#BC3F52" class="style60">
      <td colspan="4"><div align="center" class="style98">Contact Person Detail </div></td>
    </tr>
  <tr>
      <td width="58"><div align="center">Sr.No.</div></td>
      <td width="240"><div align="center">Name   </div></td>
	  <td width="180"><div align="center">Designation</div></td>
      <td width="180"><div align="center">Telephone (STD)/<br>Mobile No </div></td>
     
	  
    </tr>
  
   <tr> 
      <td class="style60">(1)</td>

  <td>  <input name="CONT_NAME" type="text" id="CONT_NAME" value="<%=CONT_NAME%>" maxlength="30"></td>
  <td>  <input name="DESIG" type="text" id="DESIG" value="<%=DESIG%>" maxlength="50"> </td>
  <td>  <input name="MOBNO" type="text" id="MOBNO" value="<%=MOBNO %>" maxlength="30">    </td>  
   
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
			
	 // BR_CODE=request.getParameter("BR_CODE")==null?"":request.getParameter("BR_CODE");	  	  
	  BANK_NAME=request.getParameter("BANK_NAME")==null?"":request.getParameter("BANK_NAME");
	  BRANCHNAME=request.getParameter("BRANCHNAME")==null?"":request.getParameter("BRANCHNAME");
	  ADDRESS=request.getParameter("ADDRESS")==null?"":request.getParameter("ADDRESS");
	  CENTRE=request.getParameter("CENTRE")==null?"":request.getParameter("CENTRE");
	  STATE=request.getParameter("STATE")==null?"":request.getParameter("STATE");
	  DISTRICT=request.getParameter("DISTRICT_NAME")==null?"":request.getParameter("DISTRICT_NAME");
	  DISTRICT_CD=request.getParameter("DISTRICT_CD")==null?"":request.getParameter("DISTRICT_CD");
	  BANK_PINCD=request.getParameter("BANK_PINCD")==null?"":request.getParameter("BANK_PINCD");
	  TEL_NO=request.getParameter("TEL_NO")==null?"":request.getParameter("TEL_NO");
	  FAX_NO=request.getParameter("FAX_NO")==null?"":request.getParameter("FAX_NO");
	  EMAIL=request.getParameter("EMAIL")==null?"":request.getParameter("EMAIL");
	  CONT_NAME=request.getParameter("CONT_NAME")==null?"":request.getParameter("CONT_NAME");
	  MOBNO=request.getParameter("MOBNO")==null?"":request.getParameter("MOBNO");
	  DESIG=request.getParameter("DESIG")==null?"":request.getParameter("DESIG");
	  
			 List values=new ArrayList();
             List pstm=new ArrayList();
             StringBuffer sb= new StringBuffer();



 		
             

sb.append("   UPDATE RBIBANKLIST_RRB SET ");
sb.append("   BANK_NAME=?, BRANCHNAME=?, ADDRESS=?, CENTRE=?, STATE_CD=?, DISTRICT=?, DISTRICT_CD=?, ");
sb.append("   BANK_PINCD=?,TEL_NO=?, FAX_NO=?, EMAIL=?, CONT_NAME=?, MOBNO=?, DESIG=?  ");
sb.append("   WHERE BRCODE=?  ");


db.setSqlValue(sb.toString());
db.setValues(values,pstm); 
 


  
 values.add (BANK_NAME);pstm.add ("D");
 values.add (BRANCHNAME);pstm.add ("D");
 values.add (ADDRESS);pstm.add ("D");
 values.add (CENTRE);pstm.add ("D");
 values.add (STATE);pstm.add ("D");
 values.add (DISTRICT);pstm.add ("D");
 values.add (DISTRICT_CD);pstm.add ("D");
 values.add (BANK_PINCD);pstm.add ("D");
 values.add (TEL_NO);pstm.add ("D");
 values.add (FAX_NO);pstm.add ("D");
 values.add (EMAIL);pstm.add ("D");
 values.add (CONT_NAME);pstm.add ("D");
 values.add (MOBNO);pstm.add ("D");
 values.add (DESIG);pstm.add ("D");
 values.add (BR_CODE);pstm.add ("D");
 
	db.executeUpdate() ;
	db.close();
	
	 values.clear();
    pstm.clear();
out.print(sb.toString());
	response.sendRedirect("savemsg.jsp");
			
			}
			}
			
			
			catch (Exception e) {
				out.print(e);
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