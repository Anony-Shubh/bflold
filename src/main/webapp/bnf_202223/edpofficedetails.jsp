<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<HTML>
<HEAD>
<TITLE>Update Performance</TITLE>
<LINK rel="stylesheet" type="text/css" href="../css/main1.css">
<SCRIPT language="javascript" src="js/sweetalert.min.js"></SCRIPT>
<SCRIPT type="text/javascript">

// Popup window code
function newPopup(url) {
	popupWindow = window.open(
		url,'popUpWindow','height=600,width=1000,left=200,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no,status=yes')
}
</SCRIPT>

<SCRIPT>
  

function APRREPORT()
  {

var fromdt=document.getElementById("FROM_DT").value;
var todt=document.getElementById("TO_DT").value;
if (fromdt.length <1) {
 swal ( 'Note:','Please select Year','error');	return (false);
}
if (todt.length <1) {
 swal ( 'Note:','Please select Year','error');	return (false);
}
window.open('jasperReports/GenerateXLS_new.jsp?REPNM=edpreport&FROM_DT='+fromdt+'&TO_DT='+todt);
}
 </SCRIPT>

</HEAD>

<STYLE>
body {margin:0;}

.topnav {
  overflow: hidden;
  background-color: #f1f1f1;
}

.topnav a {
  float: right;
  display: block;
  color: black;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  font-size: 17px;
  border-bottom: 3px solid transparent;
}

.topnav a:hover {
  border-bottom: 3px solid red;
}

.myButton {
	background-color:#247839;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:13px;
	padding:10px 33px;
	text-decoration:none;
	text-shadow:0px 1px 0px #2f6627;
}

.select2-css {
    display: block;
    font-size: 16px;
    font-family: sans-serif;
    font-weight: 700;
    color: #444;
    line-height: 1.3;
    padding: .6em 1.4em .5em .8em;
    width: 15%;
    max-width: 100%; 
    box-sizing: border-box;
    margin: 0;
    border: 1px solid #aaa;
    box-shadow: 0 1px 0 1px rgba(0,0,0,.04);
    border-radius: .5em;
    -moz-appearance: none;
    -webkit-appearance: none;
    appearance: none;
    background-color: #fff;
    background-image: url('data:image/svg+xml;charset=US-ASCII,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%22292.4%22%20height%3D%22292.4%22%3E%3Cpath%20fill%3D%22%23007CB2%22%20d%3D%22M287%2069.4a17.6%2017.6%200%200%200-13-5.4H18.4c-5%200-9.3%201.8-12.9%205.4A17.6%2017.6%200%200%200%200%2082.2c0%205%201.8%209.3%205.4%2012.9l128%20127.9c3.6%203.6%207.8%205.4%2012.8%205.4s9.2-1.8%2012.8-5.4L287%2095c3.5-3.5%205.4-7.8%205.4-12.8%200-5-1.9-9.2-5.5-12.8z%22%2F%3E%3C%2Fsvg%3E'),
      linear-gradient(to bottom, #ffffff 0%,#e5e5e5 100%);
    background-repeat: no-repeat, repeat;
    background-position: right .7em top 50%, 0 0;
    background-size: .65em auto, 100%;
}

</STYLE>

<BODY>

<FORM method="post" name="form">


  <%@ include file = "sessionoutinc.jsp" %>
 
  <%
List values=new ArrayList();

//if (vlogin.equals("Y")){
 StringBuffer sb= new StringBuffer();

sb.append("SELECT BAD.PHYV_TRID,  BAD.APP_ID,  BAD.APP_NAME, BAD.BANK_NAME, BAD.UNIT_DIST_CD,BAD.IND_ACTIVITY,  BAD.BENF_CATEGORY_CD,  BAD.GENDER,  BAD.TEL_NO FROM BNF_APP_DETAIL BAD WHERE BAD.OFF_CD=?"      );

DBCon db= new DBCon();
db.connect();

values.add(SOFF_CD);
//out.print(sb.toString());
ResultSet rs = db.executeSQL(sb.toString(),values);

String PHYV_TRID="";
String APP_ID="";
String APP_NAME="";
String BENF_CATEGORY_CD="";
String GENDER="";
String TEL_NO="";
String BANK_NAME="";
String UNIT_DIST_CD="";
String IND_ACTIVITY="";


%>
<br>
<CENTER> 


<SELECT id="FROM_DT" name="FROM_DT" class="select2-css">
	<OPTION value="">From Date</OPTION>

      <%
		String MONTH_DT="";
	ResultSet staters12 =db.execSQL("select distinct(to_char(month_dt,'DD-MON-RRRR'))as MONTH_DT from bnf_onlineedp_inf boi order by month_dt");
	while (staters12.next()) {
MONTH_DT=staters12.getString(1);
	%>
	 <OPTION value="<%= MONTH_DT %>"><%= MONTH_DT %></OPTION>
      <%  }  staters12.close();//while close  
	   %>
    </SELECT>
	<br>
	
	<SELECT id="TO_DT" name="TO_DT" class="select2-css">
	<OPTION value="">To Date</OPTION>

      <%
		String MONTH_DT2="";
	ResultSet staters123 =db.execSQL("select distinct(to_char(month_dt,'DD-MON-RRRR'))as MONTH_DT from bnf_onlineedp_inf boi order by month_dt");
	while (staters123.next()) {
MONTH_DT2=staters123.getString(1);
	%>
	 <OPTION value="<%= MONTH_DT2 %>"><%= MONTH_DT2 %></OPTION>
      <%  }  staters123.close();//while close  
	   %>
    </SELECT>

	<br>
	
	<A target="_blank" onClick="APRREPORT();" class="myButton"> GENERATE REPORT</A>


 
  </CENTER>


<%
db.close();
%>

</FORM>

</BODY>
</HTML>