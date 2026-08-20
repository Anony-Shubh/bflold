<%@ page buffer="1000kb"  import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%@ page import="in.gov.mgov.SMSServices"%>
<!DOCTYPE html>
<html lang="en">
  <head>
  <script src="../js/sweetalert.min.js"></script>
  <script>

      var xmlHttp   
      var xmlHttp 
      function showDistrict(str){ 
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
	 
	  
      var url="district.jsp"; 
      url +="?count=" +str;
	  
      xmlHttp.onreadystatechange = stateChange; 
      xmlHttp.open("post", url, true); 
      xmlHttp.send(null); 
      } 
	  
      function stateChange(){    
      if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){   
	   var x=document.getElementById('DISTRICT');
	   x.innerHTML=xmlHttp.responseText;
      } //statechane1 function end   
      }//main function end.
function submitform() {
var MNAME = document.form.MNAME.value;
var STATE = document.form.STATE.value;
var DISTRICT = document.form.DISTRICT.value; 
var MOB_NO = document.form.MOB_NO.value;
 var numberOnly=/^[0-9]*$/;

 
	 if (MNAME == "")   {	 swal({title:"Please Enter Applicant Name "});	return (false);} 
	 if (STATE == "") {	 swal({title:"Please Select State"});	return (false);}
	 if (DISTRICT == "") {swal({title: "Please Select District"});	return (false);}
	 if (MOB_NO == "")  {	 swal({title:"Please Enter Mobile No."}); return (false);}
	  if(Number(MOB_NO.length)!=10) {
	 swal({title:"Please Enter Correct Mobile No "});
				return false;
	}
  


document.form.ins.value='I';
document.form.submit();
}
</SCRIPT>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <link rel="stylesheet" href="css/style.css" />
  </head>
  <body>
 
  
<%
 DBCon db= new DBCon();
db.connect();

List values=new ArrayList();

 
 String state_cd = "";
String qrystr="";
String MNAME = "";
String STATE = "";
String DISTRICT = "";
String MOB_NO = "";
String MPASSWORD="";
String M_OTP="";

String add_update="I";
String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");


%>
    <div class="background-image">
      <img src="images/meri_mathi_mera_desh-blankbg.jpg" alt="" />
    </div>
    <div class="main-container">
      <div class="container">
       <FORM  name="form" id="form" method="post">
        <table height="38" align="center"  id="container" >
  <th height="32"  ><center>
    <h3>Application Form</h3>
  </center></th>
</table>

<FORM  name="form" id="form" method="post" class="container">
<input type="hidden" id="ins" name="ins">



<div class="row">
<div class="col" >
<label>Applicant Name :</label>
<input  name="MNAME" type="text" class="form-control form-control-sm" id="MNAME"  value="<%= MNAME %>"/>
</div>
</div><br/><br/><br/>
<div class="row">
<div class="col" >
<label>State:</label>
<SELECT name="STATE" class="form-control form-control-sm"  id="STATE" onChange="showDistrict(this.value);">
          <OPTION value="-1">--Select State--</OPTION>
          <%
	    qrystr="SELECT  ms.state_cd, initCap(ms.state_nm) as state_nm FROM m_state ms  order by ms.state_nm";
       ResultSet rs = db.execSQL(qrystr);
	   while(rs.next()){ 
	   state_cd=rs.getString("state_cd");
	   %>
          <OPTION value="<%=rs.getString("state_cd")%>"><%=rs.getString("state_nm")%></OPTION>
          <% } 
	  rs.close();
	   %>
        </SELECT>
</div>
</div><br/><br/>
<div class="row">
<div class="col" >
<label>District:</label>
<div id ='DISTRICT'><SELECT name="DISTRICT" class="button"  >
          <OPTION value="-1" >--Select District-</OPTION>
      </SELECT></div>
</div>
</div><br/><br/>
<div class="row">
<div class="col" >
<label>Mobile No:</label>
<input  name="MOB_NO" type="text" class="form-control form-control-sm" id="MOB_NO"  value="<%= MOB_NO %>"/>
</div>
</div><br/><br/>



<div class="row">
<div class="col" >
<div>&nbsp;</div>

<div align="center">
<input class="btn btn-primary" onClick="submitform();"  type="button" value="Next">
</div>
</div>
</div>
        </form>
      </div>
    </div>
	<%

out.print (ins);
if (ins.equals("I")) {
//MIID=(String) request.getParameter("MIID")==null?"":(String) request.getParameter("MIID").trim();
MOB_NO=(String) request.getParameter("MOB_NO")==null?"":(String) request.getParameter("MOB_NO").trim();
MNAME=(String) request.getParameter("MNAME")==null?"":(String) request.getParameter("MNAME").trim();
STATE=(String) request.getParameter("STATE")==null?"":(String) request.getParameter("STATE").trim();
DISTRICT=(String) request.getParameter("DISTRICT")==null?"":(String) request.getParameter("DISTRICT").trim();

String MIID="";
						 ResultSet rsMax = db.execSQL("SELECT MMMD_SEQ.NEXTVAL AS MAX_ID FROM DUAL");
						 
						 while (rsMax.next()) {
						 MIID=rsMax.getString(1);
						 }
						
						rsMax.close();


ResultSet rsRd = db.execSQL("select round(dbms_random.value(100000,999999),0) MPASSWORD from dual ");
		
		while (rsRd.next()){
		  MPASSWORD=rsRd.getString(1);
		}
		rsRd.close();
		
		ResultSet rsRdOTP = db.execSQL("select round(dbms_random.value(10000000,99999999),0) M_OTP from dual ");
		
		while (rsRdOTP.next()){
		  M_OTP=rsRdOTP.getString(1);
		}
		rsRdOTP.close();

        List pstm=new ArrayList();
		StringBuffer qryUpdate = new StringBuffer();
		values.clear();
		pstm.clear();
		
	
if (add_update.equals("I")) {
qryUpdate.append(" INSERT INTO MMMD_DETAIL (");
qryUpdate.append("MIID,");
qryUpdate.append("MNAME,");
qryUpdate.append("STATE,");
qryUpdate.append("DISTRICT,");
qryUpdate.append("MOB_NO,");
qryUpdate.append("MPASSWORD,");
qryUpdate.append("M_OTP,");

qryUpdate.append("TIMESTAMP");


qryUpdate.append( ") VALUES (?,?,?,?,?,?,?,SYSDATE) ");
}



values.add(MIID); pstm.add ("L");
values.add(MNAME); pstm.add ("L");
values.add(STATE); pstm.add ("L");
values.add(DISTRICT); pstm.add ("L");
values.add(MOB_NO); pstm.add ("L");
values.add(MPASSWORD); pstm.add ("L");
values.add(M_OTP); pstm.add ("L");




db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate() ;

String sms_string=" Your OTP for PMEGP KHADI MAHOTSAV Form of Final Authentication is : "+M_OTP+" Regards, KVIC ";
 SMSServices sms1=new SMSServices();
			try {
	      String smsresponse=sms1.sendSingleSMS("KVICDIT", "Panda@1974",sms_string, "KVICIT",MOB_NO,"2740939a-a79d-42ba-984c-02fb4fa0e10d","1007353226336882857");	
}catch (Exception e) {}


session.setAttribute("sMIID",MIID);
session.setAttribute("sM_OTP",M_OTP);
db.close();
response.sendRedirect("upload.jsp");
}


%>


  </body>
</html>
