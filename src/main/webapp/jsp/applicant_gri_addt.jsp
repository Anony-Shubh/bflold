<%@ include file="appIncludeHeaderPage.jsp" %>
<script language="javascript">

function submit_offupdate() {
 var emailRegex = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/;
var GR_SUB=document.form1.GR_SUB.value;
var GR_MATTER=document.form1.GR_MATTER.value;
var EMAIL_TO=document.form1.EMAIL_TO.value;
var EMAIL_YN=document.form1.EMAIL_YN.value;
if (EMAIL_YN== "N" || EMAIL_YN==""){
	var EMAIL_FROM=document.form1.EMAIL_FROM.value;
	if(EMAIL_FROM == "") {
    inlineMsg('EMAIL_FROM','Enter EMAIL....',2);
    return false;
	}
	
	if(!EMAIL_FROM.match(emailRegex) && !EMAIL_FROM == "") {
    inlineMsg('EMAIL_FROM','<strong>Invalid e_Mail</strong><br />You have entered an invalid email.',2);
    return false;
  }
	
	
}
   if(GR_SUB == "0") {
    inlineMsg('GR_SUB','Enter Subject....',2);
    return false;
  }else if(EMAIL_TO == "-1") {
    inlineMsg('EMAIL_TO','Select EMAIL TO ......',2);
    return false;
  }
  
  else if(GR_MATTER == "") {
    inlineMsg('GR_MATTER','Enter Matter......',2);
    return false;
  }else {
document.form1.ins.value='I'; 
document.form1.submit(); 

 }
}//end of function

function show(str){ 

     try
    {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
    }
  catch (e)
    {
    // Internet Explorer
    try
      {
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
      }
    catch (e)
      {
      try
        {
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
        }
      catch (e)
        {
        alert("Your Browser Don't Support AJAX!");
        return false;
        }
      }
    }
	  appid=document.getElementById("APP_ID").value;
	 
	  i=document.form1.GR_SUB.selectedIndex; 
      vorgcd=document.form1.GR_SUB.options[i].value; 
  
      var url="Address.jsp"; 
      
	  url +="?subid="+vorgcd+"&appid="+appid;
	  
      xmlHttp.onreadystatechange = districtChange; 
      xmlHttp.open("post", url, true); 
      xmlHttp.send(null); 
      } 

  function districtChange(){    
      if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){   
	   var x=document.getElementById('DISTRICT');
	   x.innerHTML=xmlHttp.responseText;
      } //statechane1 function end   
      }//main function end.







</script>




<body >

<form  action="applicant_gri_addt.jsp" method="post" name="form1" id="form1"  >

<% 

String GR_ID = request.getParameter("GR_ID")==null?"0":(String)request.getParameter("GR_ID");
String GR_SUB = "";
String GR_MATTER = "";
String ACT_YN = "Y";
String EMAIL_SENT = "";
String GR_TIMESTAMP = "";
String APP_ID =vAppid;
String APP_NAME=vAppName;
String C_EMAIL="pmegp.kvic@gov.in";
String D_EMAIL="pmegpeportal.kvic@gov.in";

String OFF_EMAIL_ADDR = "";
String AGENCY_TYPE = "";
String OFF_NAME1 = "";
String E_MAIL = "";
String BR_NAME="";
String EMAIL="";
String ACT_ID="";
String IFSC_CODE="";
String OFF_CD="";

String MAIL="";
String EMAIL_TO="";
String ASSIGN_TO="";
String EMAIL_FROM ="";
String MOB_NO="";
String EMAIL_YN="";		
DBCon db= new DBCon();
db.connect();

StringBuffer qrysb= new StringBuffer();


qrysb.append("   SELECT MOM.OFF_EMAIL_ADDR,AD.OFF_CD,ad.act_id,AD.IFSC_CODE,AD.MOB_NO1,"      );
qrysb.append("     MOM.AGENCY_TYPE,AD.E_MAIL,decode(AD.E_MAIL,null,'N','Y') AS EMAIL_YN,"      );
qrysb.append("     MOM.OFF_NAME1,"      );
qrysb.append("     AD.E_MAIL,BRM.EMAIL,BRM.BR_NAME "      );
qrysb.append("   FROM APP_DETAIL AD,BANK_BR_MAST BRM ,"      );
qrysb.append("     MAS_OFF_MAST MOM "      );
qrysb.append("   WHERE AD.OFF_CD = MOM.OFF_CD AND AD.IFSC_CODE=BRM.BR_IFSL_CODE "      );
qrysb.append("   AND AD.APP_ID   = '"+APP_ID+"'   "      );

//out.print(qrysb.toString());
ResultSet rsMain = db.execSQL(qrysb.toString());

while (rsMain.next()){

OFF_EMAIL_ADDR=rsMain.getString("OFF_EMAIL_ADDR")==null?"":rsMain.getString("OFF_EMAIL_ADDR");
AGENCY_TYPE=rsMain.getString("AGENCY_TYPE")==null?"":rsMain.getString("AGENCY_TYPE");
OFF_NAME1=rsMain.getString("OFF_NAME1")==null?"":rsMain.getString("OFF_NAME1");
E_MAIL=rsMain.getString("E_MAIL")==null?"":rsMain.getString("E_MAIL");
BR_NAME=rsMain.getString("BR_NAME")==null?"":rsMain.getString("BR_NAME");
EMAIL=rsMain.getString("EMAIL")==null?"":rsMain.getString("EMAIL");
ACT_ID=rsMain.getString("ACT_ID")==null?"":rsMain.getString("ACT_ID");
OFF_CD=rsMain.getString("OFF_CD")==null?"":rsMain.getString("OFF_CD");
IFSC_CODE=rsMain.getString("IFSC_CODE")==null?"":rsMain.getString("IFSC_CODE");
MOB_NO=rsMain.getString("MOB_NO1")==null?"":rsMain.getString("MOB_NO1");
EMAIL_YN=rsMain.getString("EMAIL_YN")==null?"":rsMain.getString("EMAIL_YN");
}
rsMain.close();
		%>
		<table align="center">
<tr>
  <th colspan="3"><div align="center">Applicant Grievance Form </div></th>
  </tr><input name="APP_ID" type="hidden" id="APP_ID" value="<%=APP_ID%>" >
<tr>
  <th colspan="3"><div align="center"><span class="GreenLebel">( Email will be sent on Submit Your Grievance and a copy of grievance will also sent to your mail : <%= E_MAIL %> ) </span></div></th>
  </tr>
<tr>
  <th colspan="2"><div align="center">APPLICATION ID:<%= APP_ID %>, APPLICANT NAME:<%= APP_NAME  %><br/>
  </div></th>
  </tr> <input name="EMAIL_YN" type="hidden" id="EMAIL_YN" value="<%=EMAIL_YN%>">
<tr>
  <th>From: </th>
  <th colspan="2"><% if (!E_MAIL.equals("")){%>
  <%=E_MAIL%>
    <input name="E_MAIL" type="hidden" id="E_MAIL" value="<%=E_MAIL%>" >
	 <% } else {%>
  <input name="EMAIL_FROM" type="text" id="EMAIL_FROM" value="<%=EMAIL_FROM%>" maxlength="50">
  </th>
 
 <%}%>
</tr>  
<tr>
<th> Mobile No:  </th>

<th colspan="2"> <%=MOB_NO %>  </th>
</tr>
<tr>
  <th>  Subject :  </th><td colspan="2"><select name="GR_SUB" id="GR_SUB" onChange="show(this.value);">
   <option value="0">Select Subject</option>
    <option value="1">Issues related to Implementing Agency</option>
    <option value="2">Issues related to Financing Branch</option>
    <option value="3">Other Issues</option>
    <option value="4">Technical Issues</option>
  </select>
    <input name="GR_ID" type="hidden" id="GR_ID" value="<%=GR_ID%>">
    <input name="ACT_YN" type="hidden" id="ACT_YN" value="<%=ACT_YN%>">
    <input name="OFF_EMAIL_ADDR" type="hidden" id="OFF_EMAIL_ADDR" value="<%=OFF_EMAIL_ADDR%>">
    <input name="C_EMAIL" type="hidden" id="C_EMAIL" value="<%=C_EMAIL%>">
    <input name="D_EMAIL" type="hidden" id="D_EMAIL" value="<%=D_EMAIL%>">
    <input name="EMAIL" type="hidden" id="EMAIL" value="<%=EMAIL%>">
    <input name="GR_TIMESTAMP" type="hidden" id="GR_TIMESTAMP" value="<%=GR_TIMESTAMP%>">
    <input name="OFF_CD" type="hidden" id="OFF_CD" value="<%=OFF_CD%>">
    <input name="IFSC_CODE" type="hidden" id="IFSC_CODE" value="<%=IFSC_CODE%>">
  
</tr>  
<tr>
  <th>To
    <input name="ins" type="hidden" id="ins" value=""></th>
  <td id ='DISTRICT' colspan="2"></td>
</tr>



<tr>
  <th>  Matter (Maximum 1000 character) </th><td colspan="2">  <textarea name="GR_MATTER" cols="100" rows="6" id="GR_MATTER" maxlength="1000" ><%=GR_MATTER%></textarea>  </td></tr>  
  
<tr>
  <th colspan="3"><div align="center" class="GreenLebel"></div></th>
</tr>
<tr><td colspan="3"><div align="center">
  <input name="Button" type="button" class="button" onClick="submit_offupdate();" value="Submit Grievance">
</div></td>
</tr>  
</table>
  <%
 try {
 if ((String)request.getParameter("ins")!=null){
 
 
GR_ID=(String) request.getParameter("GR_ID")==null?"":(String) request.getParameter("GR_ID").trim();
GR_SUB=(String) request.getParameter("GR_SUB")==null?"":(String) request.getParameter("GR_SUB").trim();
GR_MATTER=(String) request.getParameter("GR_MATTER")==null?"":(String) request.getParameter("GR_MATTER").trim();
ACT_YN=(String) request.getParameter("ACT_YN")==null?"":(String) request.getParameter("ACT_YN").trim();
C_EMAIL=(String) request.getParameter("C_EMAIL")==null?"":(String) request.getParameter("C_EMAIL").trim();
D_EMAIL=(String) request.getParameter("D_EMAIL")==null?"":(String) request.getParameter("D_EMAIL").trim();
OFF_EMAIL_ADDR=(String) request.getParameter("OFF_EMAIL_ADDR")==null?"":(String) request.getParameter("OFF_EMAIL_ADDR").trim();
EMAIL=(String) request.getParameter("EMAIL")==null?"":(String) request.getParameter("EMAIL").trim();
EMAIL_FROM=(String) request.getParameter("EMAIL_FROM")==null?"":(String) request.getParameter("EMAIL_FROM").trim();	
EMAIL_TO=(String) request.getParameter("EMAIL_TO")==null?"":(String) request.getParameter("EMAIL_TO").trim();	
E_MAIL=(String) request.getParameter("E_MAIL")==null?"":(String) request.getParameter("E_MAIL").trim();	

OFF_CD=(String) request.getParameter("OFF_CD")==null?"":(String) request.getParameter("OFF_CD").trim();	
IFSC_CODE=(String) request.getParameter("IFSC_CODE")==null?"":(String) request.getParameter("IFSC_CODE").trim();	
 
 if (E_MAIL.equals("")){
	MAIL=EMAIL_FROM;
}
 else{
	 MAIL=E_MAIL;
 }
 
 
 
if (EMAIL_TO.equals("AG")){
	EMAIL_SENT=OFF_EMAIL_ADDR;
}
if (EMAIL_TO.equals("CO")){
	EMAIL_SENT=C_EMAIL;
}
if (EMAIL_TO.equals("DIT")){
	EMAIL_SENT=D_EMAIL;
}
if (EMAIL_TO.equals("BK")){
	EMAIL_SENT=EMAIL;
}
 
 
 
 
 List values=new ArrayList();
List pstm=new ArrayList();
 qrysb= new StringBuffer();

qrysb.append("INSERT INTO PMEGP_GRIVENCES ( GR_ID,");
qrysb.append("SUB_ID,");
qrysb.append("GR_MATTER,");
qrysb.append("ACT_YN,");
qrysb.append("EMAIL_TO,");
qrysb.append("EMAIL_FROM,");
qrysb.append("ASSIGN_TO,");
qrysb.append("GR_TIMESTAMP,");
//qrysb.append("OFF_CD,");
//qrysb.append("IFSC_CODE,");
qrysb.append("APP_ID,ACT_ID ) VALUES (GRIDSEQ.nextval,?,?,'Y',?,?,?,SYSDATE,?,0) ");



values.add(GR_SUB); pstm.add ("L");
values.add(GR_MATTER); pstm.add ("L");
values.add(EMAIL_SENT); pstm.add ("L");
values.add(MAIL); pstm.add ("L");
values.add(EMAIL_TO); pstm.add ("L");
//values.add(OFF_CD); pstm.add ("L");
//values.add(IFSC_CODE); pstm.add ("L");
values.add(APP_ID); pstm.add ("L");

db.setSqlValue(qrysb.toString());
db.setValues(values,pstm); 
db.executeUpdate() ;

 values.clear();
 pstm.clear();
 
db.close();
out.print ("<center><h1>Your Grievance has been successfully sent, Please verify your email ID for confirmation...........</h1><center>");
} //end ins


}//try
catch(Exception e)
{
out.println(e);
}
finally{
//db.close();
}
  %>
  
</form>

</body>
</html>
