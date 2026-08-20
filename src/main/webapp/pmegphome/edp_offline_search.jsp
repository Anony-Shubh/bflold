<%@ page session="true" buffer="500kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon" %>


<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>EDP Offline</title>



<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.12.1/js/dataTables.bootstrap4.min.js"></script>

<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.2/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.12.1/css/dataTables.bootstrap4.min.css">


<style>
.buttonedpsearch {
  background-color: #4CAF50; /* Green */
  border: 1px solid black;
  color: white;
  padding: 4px 10px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;

  cursor: pointer;
}
.buttonedpsearch2 {background-color: #e7e7e7; color: black;} /* Gray */ 
</style>
<script>
 var xmlHttp   
      var xmlHttp 
      function showProdtwo(){ 
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
	 
	   i=document.form.STATE_NM.selectedIndex; 
      vID1=document.form.STATE_NM.options[i].value;
	  
      var url="districtselectedp.jsp"; 
      url +="?count=" +vID1;
	  
      xmlHttp.onreadystatechange = ProductTwoChange; 
      xmlHttp.open("post", url, true); 
      xmlHttp.send(null); 
      } 
	  
      function ProductTwoChange(){    
      if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){   
	   var x=document.getElementById('DISTRICT_NAME');
	  x.innerHTML=xmlHttp.responseText;
	// alert (xmlHttp.responseText);
      } //statechane1 function end   
      }//main function
</script>

<SCRIPT>	
  
/*	    function getpost_subgroup(val) {
	$.ajax({
	type: "GET",
	url: "districtselect.jsp",
	data:'STATE_CDC='+val,
	success: function(data){
		$("#DISTRICT_NAME").html(data);
	}
	});
}*/
</SCRIPT>


<script language="javascript">

function submitform(){
document.form.submit();
}


$(document).ready(function () {
$('#example').DataTable();
});

</script>
</head>

<body>
<IMG src="img/pmegp_banner_v2.jpg" style="margin: 10px auto; width: 100%;">
<FORM  name="form" id="form" method="post" >
<% 
DBCon db= new DBCon();
db.connect();
List values=new ArrayList();

//String  = "";  

String DISTRICT_NAME = "";
String OFF_NAME = "";
String OFF_ADDRS = "";
String OFF_EMAIL_ADDR = "";
String OFF_TEL_NO = "";


String add_update="I";
String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");



String STATE_CD = request.getParameter("STATE_NM")==null?"":(String)request.getParameter("STATE_NM");
String OFF_TYPE_CD = request.getParameter("OFF_TYPE_LONG_DESC")==null?"":(String)request.getParameter("OFF_TYPE_LONG_DESC");
String DISTRICT_CD = request.getParameter("DISTRICT_NAME")==null?"":(String)request.getParameter("DISTRICT_NAME");

String vWhereclss="";

if (STATE_CD !="") {
vWhereclss = " AND MS.STATE_CD="+"'"+STATE_CD+"'";
}
if (DISTRICT_CD !="") {
vWhereclss = " AND MOM.DISTRICT_CD="+"'"+DISTRICT_CD+"'";
} 

  if (!OFF_TYPE_CD.equals("")) {
vWhereclss =vWhereclss+" AND MOM.OFF_TYPE_CD="+"'"+OFF_TYPE_CD+"'";
}


StringBuffer qrysb = new StringBuffer();

qrysb.append("SELECT MOM.OFF_CD,MOM.OFF_TYPE_CD,MOM.ACT_YN, MOM.OFF_LONG_DESC,MOM.OFF_NAME,MOM.CITY,MD.DISTRICT_NAME, ");
qrysb.append("MD.DISTRICT_CD ,MOM.PINCODE,MS.STATE_NM,MOM.OFF_TEL_NO,MOM.OFF_EMAIL_ADDR , ");
qrysb.append("mom.off_addr1 ||' '|| MOM.OFF_ADDR2 AS OFF_ADDRS,MTC.OFF_TYPE_LONG_DESC ");
qrysb.append("FROM MAS_OFF_MAST MOM, M_DISTRICT MD,M_STATE MS, MAS_OFF_TYPE_CDMAST  MTC WHERE ");
qrysb.append(" MD.DISTRICT_CD=MOM.DISTRICT_CD ");
qrysb.append("AND MD.STATE_CD=MS.STATE_CD AND MOM.ACT_YN='Y' AND MTC.OFF_CATEGORY=100 AND MOM.OFF_TYPE_CD=MTC.OFF_TYPE_CD "+vWhereclss+"  ");



//out.print (qrysb.toString());

ResultSet rsMain = db.execSQL(qrysb.toString());


%>
<h3 align="center">EDP TRAINING CENTER</h3>

<table class="table table-striped table-bordered" style="width:100%"><tr>
<td><strong> Select State: </strong>
       <select   name="STATE_NM" id="STATE_NM" style="font-size:100%"; onChange="showProdtwo();">
        <option value="">All State</option>
        <% 
		String STATE_NM="";
  
	  String STATE_CDC="";
  
  ResultSet rsUp=db.execSQL("SELECT STATE_CD, STATE_NM FROM M_STATE");
		 
		  while (rsUp.next()){
	     STATE_NM=rsUp.getString("STATE_NM")==null?"":rsUp.getString("STATE_NM");
		STATE_CDC=rsUp.getString("STATE_CD")==null?"":rsUp.getString("STATE_CD");
		 
		 
  %>
        <option value="<%=STATE_CDC%>" <% if (STATE_CD.equals(STATE_CDC)){out.print("selected");} %>><%= STATE_NM %></option>
        <% } rsUp.close(); %>
      </select></td>
	  
	  
	  
<td><strong> Select District: </strong>

   
<SELECT name="DISTRICT_NAME" id="DISTRICT_NAME">
	 <%
	ResultSet rsDist =db.execSQL("SELECT DISTRICT_CD,  DISTRICT_NAME FROM   M_DISTRICT where DISTRICT_STATUS='A' and STATE_CD='"+STATE_CD+"'  ");
	%>
        <option value=""> -Select-</option>
        <%
		  String cmbDist="";
while (rsDist.next()) {

if ( rsDist.getObject(1).toString().equals(DISTRICT_CD) ){

cmbDist="Selected";
}else{
cmbDist="";
}
%>
        <option value="<%=((rsDist.getObject(1)!=null)?rsDist.getObject(1):"")%>" <%=cmbDist%>><%=((rsDist.getObject(2)!=null)?rsDist.getObject(2):"")%></option>
        <%  }  rsDist.close();//while close  
	   %>
    </SELECT>

	
	
	
</td>
	
	
	
	
<td><strong> Select Training Center Type: </strong>
       <select  name="OFF_TYPE_LONG_DESC" id="OFF_TYPE_LONG_DESC" style="font-size:100%";>
         <option value="">All Center</option>
         <% 

String OFF_TYPE_LONG_DESC="";
	  String OFF_TYPE_CDC="";
  
  ResultSet rsP=db.execSQL("SELECT OFF_TYPE_CD, OFF_TYPE_LONG_DESC FROM MAS_OFF_TYPE_CDMAST WHERE OFF_CATEGORY=100");
		
		  while (rsP.next()){
	     OFF_TYPE_LONG_DESC=rsP.getString("OFF_TYPE_LONG_DESC")==null?"":rsP.getString("OFF_TYPE_LONG_DESC");
		 OFF_TYPE_CDC=rsP.getString("OFF_TYPE_CD")==null?"":rsP.getString("OFF_TYPE_CD");
		
		 
		 
  %>
         <option value="<%=OFF_TYPE_CDC%>" <% if (OFF_TYPE_CD.equals(OFF_TYPE_CDC)){out.print("selected");} %>><%= OFF_TYPE_LONG_DESC %></option>
         <% } rsP.close(); %>
       </select></td>
<td><INPUT name="btnFind" type="button" onClick="submitform();" class="myButton2" id="btnFind" value="Search" /></td>
<td><a href="index.jsp" class="buttonedpsearch buttonedpsearch2">Home</a></td>

</tr>
</table>


<table id="example" class="table table-striped table-bordered" style="width:100%">

  <thead>
    <tr>
      <th><center>SR NO.</center></th>
      <th><center>STATE </center></th>
      <th><center>DISTRICT</center></th>
	  <th><center>ADDRESS</center></th>
	  <th><center>TRAINING TYPE CENTER</center></th>
      <th ><center>OFFICE NAME</center></th>
	  <th><center>CONTACT NO.</center></th>
	  <th ><center>EMAIL-ID</center></th>
    </tr>
  </thead>
<%




//values.clear();
int sr_no=0;
while (rsMain.next()){
sr_no=sr_no+1;
STATE_NM=rsMain.getString("STATE_NM")==null?"":rsMain.getString("STATE_NM");
DISTRICT_NAME=rsMain.getString("DISTRICT_NAME")==null?"":rsMain.getString("DISTRICT_NAME");
OFF_TEL_NO=rsMain.getString("OFF_TEL_NO")==null?"":rsMain.getString("OFF_TEL_NO");
OFF_EMAIL_ADDR=rsMain.getString("OFF_EMAIL_ADDR")==null?"":rsMain.getString("OFF_EMAIL_ADDR");
OFF_NAME=rsMain.getString("OFF_NAME")==null?"":rsMain.getString("OFF_NAME");
OFF_ADDRS=rsMain.getString("OFF_ADDRS")==null?"":rsMain.getString("OFF_ADDRS");
OFF_TYPE_LONG_DESC=rsMain.getString("OFF_TYPE_LONG_DESC")==null?"":rsMain.getString("OFF_TYPE_LONG_DESC");


%>



    <tr>
      <td><center><%= sr_no %></center></td>
      <td><center><%=STATE_NM%></center></td>
      <td><center><%=DISTRICT_NAME%></center></td>
	  <td><center><%=OFF_ADDRS%></center></td>
	  <td><center><%= OFF_TYPE_LONG_DESC %></center></td>
      <td><center><%=OFF_NAME%></center></td>
	  <td><center><%=OFF_TEL_NO%></center></td>
	  <td><center><%=OFF_EMAIL_ADDR%></center></td>
    </tr>

<%

 }
  rsMain.close();
  db.close();
%>
</table>
</FORM>

</body>


</html>	
			
			
			
			
			





