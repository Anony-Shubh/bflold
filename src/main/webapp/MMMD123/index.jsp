<%@ page buffer="1000kb"  import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%@ page import="in.gov.mgov.SMSServices"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
<link rel="stylesheet" href="css/bootstrap.min.css" /> 
<link href="js/jquery.multiselect.css" rel="stylesheet" />
<SCRIPT type="text/javascript" src="../js/jquery-1.12.0.min.js"></SCRIPT>
 <!--<link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
 <script src="js/jquery.multiselect.js"></script>
<script src="js/inlinemsg.js"></script>-->
<script src="js/sweetalert.min.js"></script>
<link rel="stylesheet" href="sweetalert2.min.css">
<style>


#form{
  font-family: Arial, Helvetica, sans-serif;s
  border-collapse: collapse;
 
  border-style: ridge;
  background-color:#FAF5EF;
  padding: 2px;
  font-size:15px;
      display: inline-block;
    margin-left: auto;
    margin-right: auto;
    text-align: left;
}

#msg {display:none; position:absolute; z-index:200; background:url(../cftri/images/msg_arrow.gif) left center no-repeat; padding-left:7px}
#msgcontent {display:block; font:Arial, Helvetica, sans-serif; font-weight:bold;color: #FF0000;font-size: 16px;background:#f3e6e6; border:2px solid #FF0000; border-left:none; padding:5px; min-width:150px; max-width:250px}


</style>

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
/*var mob_no = document.form.mob_no.value;
var email_id = document.form.email_id.value;
var annual_turnover = document.form.annual_turnover.value; 
var sub_activity_cd = document.form.sub_activity_cd.value;
var trng_month = document.form.trng_month.value; 
   const myCheck = document.querySelectorAll('.myCheck:checked');
 if (mob_no == "")  {	 swal({title:"Please Enter Mobile No."}); return (false);}
	 if (email_id == "")   {	 swal({title:"Please Enter Email Id "});	return (false);} 
	 if (annual_turnover == "") {	 swal({title:"Please Select Annual turnover"});	return (false);}
	 if (sub_activity_cd == "") {swal({title: "Please Select Food processing sub-sector"});	return (false);}
	 if (trng_month == "") {swal({title:"Please Select Training Months"});	return (false);}
	  if (myCheck.length < 1){swal({title:"Please Select Training Required for"});	return (false);}
	 
*/

document.form.ins.value='I';
document.form.submit();
}
</SCRIPT>
<script>
function numbersonly(e){
var unicode=e.charCode? e.charCode : e.keyCode
if (unicode!=8){ //if the key isn't the backspace key (which we should allow)
if (unicode<46||unicode>57) //if not a number
return false //disable key press
}


}
</script>
<script>// Dealing with Input width
function textAreaAdjust(element) {
  element.style.height = "1px";
  element.style.height = (25+element.scrollHeight)+"px";
}
</script>

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
<div align="center" >

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
</div>
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
</div>
<div class="row">
<div class="col" >
<label>District:</label>
<div id ='DISTRICT'><SELECT name="DISTRICT" class="button"  >
          <OPTION value="-1" >--Select District-</OPTION>
      </SELECT></div>
</div>
</div>
<div class="row">
<div class="col" >
<label>Mobile No:</label>
<input  name="MOB_NO" type="text" class="form-control form-control-sm" id="MOB_NO"  value="<%= MOB_NO %>"/>
</div>
</div>



<div class="row">
<div class="col" >
<div>&nbsp;</div>

<div align="center">
<input class="btn btn-primary" onClick="submitform();"  type="button" value="Next">
</div>
</div>
</div>

</FORM>

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

String sms_string=" Your OTP for PMEGP AMRITMAHOTSAV Form of Final Authentication is : "+M_OTP+" Regards, KVIC ";
 SMSServices sms1=new SMSServices();
			try {
	      String smsresponse=sms1.sendSingleSMS("KVICDIT", "Panda@1974",sms_string, "KVICIT",MOB_NO,"2740939a-a79d-42ba-984c-02fb4fa0e10d","1007353226336882857");	
}catch (Exception e) {}


session.setAttribute("sMIID",MIID);
session.setAttribute("sM_OTP",M_OTP);
db.close();
response.sendRedirect("view.jsp");
}

%>


</body>
  
<script src="js/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="js/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</html>
