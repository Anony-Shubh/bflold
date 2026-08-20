<%@ page session="true" buffer="500kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon,java.math.*"  %>

<HTML>
<HEAD>
<TITLE>
</TITLE>
<LINK rel="stylesheet" type="text/css" href="../css/bnfstylesheet.css">
<SCRIPT language="javascript" src="../../HRD/js/inlinemsg.js"></SCRIPT>
<SCRIPT language="javascript" src="js/datetimepicker_css.js"></SCRIPT>

</HEAD>
<STYLE type="text/css">
.myButton {
	background-color:#50c73e;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:13px;
	padding:10px 33px;
	text-decoration:none;
	text-shadow:0px 1px 0px #2f6627;
}

* {
  box-sizing: border-box;
}

input[type=text], select, textarea {
  width: 100%;
  padding: 4px;
  border: 1px solid #ccc;
  border-radius: 4px;
  resize: vertical;
}

label {
  padding: 12px 12px 12px 0;
  display: inline-block;
}

input[type=submit] {
  background-color: #4CAF50;
  color: white;
  padding: 12px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  float: right;
}

input[type=submit]:hover {
  background-color: #45a049;
}

.container {
  border-radius: 5px;
  background-color: white;
  padding: 20px;
}


input:read-only {
  background-color: #ffff99;
}

#customers2 {
    font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
    border-collapse: collapse;
    width: 20%;
}

#customers {
    font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
    border-collapse: collapse;
    width: 90%;
}



#customers td, #customers th {
    border: 1px solid #000000;
    padding: 4px;
	font-size:13px;
	font-weight:bold;
}

#customers tr:nth-child(even){background-color: #f2f2f2;}

#customers tr:hover {background-color: #ddd;}

#customers th {
    padding-top: 6px;
    padding-bottom: 6px;
    text-align: left;
    background-color: #2e7d22;
    color: white;
}
/* Clear floats after the columns */
.row:after {
  content: "";
  display: table;
  clear: both;
}

/* Responsive layout - when the screen is less than 600px wide, make the two columns stack on top of each other instead of next to each other */
@media screen and (max-width: 600px) {
  .col-25, .col-75, input[type=submit] {
    width: 100%;
    margin-top: 0;
  }
}
.style1 {color: #FF0000}</STYLE>
<BODY>

   <%@ include file="sessionoutinc.jsp" %>
<%
DBCon db= new DBCon();
db.connect();
List values=new ArrayList();	
%>


    <%

  String vWherecls="";
  String APP_ID = request.getParameter("APP_ID")==null?"":(String)request.getParameter("APP_ID");
  String APP_NAME="";
  String BENF_CATAGORY_CD="";
  String GENDER="";
  String TEL_NO="";
  String E_MAIL="";
  String UNIT_LOC="";
  String UNIT_POST_ADDR="";
  String UNIT_TALUK_BLOCK="";
  String UNIT_DIST_CD="";
  String UNIT_PIN="";
  String EMP_ENV="";
  String BANK_NAME="";
  String IND_TYPE="";
  String IND_ACTIVITY="";
  String PROD_DESC="";
  String BR_CODE="";
  String TOT="";
  //out.print(SSTATE_CD);
  
     
  if (!APP_ID.equals("")) {
  vWherecls=vWherecls+ " AND APP_ID='"+APP_ID+"' ";
  }
  

//out.print(vWherecls);
	
StringBuffer qrysb= new StringBuffer();

if(!APP_ID.equals("")){
qrysb.append("SELECT PAD.APP_ID,  PAD.APP_NAME,  NVL(PAD.WORKSHED_COST, 0) + NVL(PAD.MACHINARY_COST, 0) + NVL(PAD.PRE_OPE_EXP, 0) + NVL(PAD.WORKING_CAPITAL, 0) AS TOT,"      );
qrysb.append("PAD.BENF_CATAGORY_CD,  PAD.BR_CODE,  PAD.GENDER,  PAD.TEL_NO,  PAD.E_MAIL,  PAD.UNIT_LOC,  PAD.UNIT_POST_ADDR,"      );
qrysb.append("PAD.UNIT_TALUK_BLOCK,  PAD.UNIT_DIST_CD,  PAD.UNIT_PIN,  PAD.EMP_ENV,PAD.BANK_NAME,  PAD.IND_TYPE,  PAD.IND_ACTIVITY,"      );
qrysb.append("PAD.PROD_DESC,  PAD.WORKSHED_COST,  PAD.MACHINARY_COST,  PAD.PRE_OPE_EXP,  PAD.WORKING_CAPITAL FROM PMEGPONLINE.APP_DETAIL PAD,"      );
qrysb.append("BNF_OFF_MAST BOM WHERE PAD.OFF_CD     = BOM.OFF_CD(+) AND BOM.STATE_CD='"+SSTATE_CD+"' AND PAD.APP_ID IS NOT NULL "+vWherecls+""      );
qrysb.append("GROUP BY PAD.APP_ID,  PAD.APP_NAME,PAD.BENF_CATAGORY_CD,  PAD.BR_CODE,  PAD.GENDER,  PAD.TEL_NO,  PAD.E_MAIL,  PAD.UNIT_LOC,  PAD.UNIT_POST_ADDR,"      );
qrysb.append("PAD.UNIT_TALUK_BLOCK, PAD.UNIT_DIST_CD, PAD.UNIT_PIN, PAD.EMP_ENV, PAD.BANK_NAME, PAD.IND_TYPE, PAD.IND_ACTIVITY,"      );
qrysb.append(" PAD.PROD_DESC, PAD.WORKSHED_COST, PAD.MACHINARY_COST,PAD.PRE_OPE_EXP, PAD.WORKING_CAPITAL"      );


} else {
qrysb.append("SELECT PAD.APP_ID,  PAD.APP_NAME,  NVL(PAD.WORKSHED_COST, 0) + NVL(PAD.MACHINARY_COST, 0) + NVL(PAD.PRE_OPE_EXP, 0) + NVL(PAD.WORKING_CAPITAL, 0) AS TOT,"      );
qrysb.append("PAD.BENF_CATAGORY_CD,  PAD.BR_CODE,  PAD.GENDER,  PAD.TEL_NO,  PAD.E_MAIL,  PAD.UNIT_LOC,  PAD.UNIT_POST_ADDR,"      );
qrysb.append("PAD.UNIT_TALUK_BLOCK,  PAD.UNIT_DIST_CD,  PAD.UNIT_PIN,  PAD.EMP_ENV,PAD.BANK_NAME,  PAD.IND_TYPE,  PAD.IND_ACTIVITY,"      );
qrysb.append("PAD.PROD_DESC,  PAD.WORKSHED_COST,  PAD.MACHINARY_COST,  PAD.PRE_OPE_EXP,  PAD.WORKING_CAPITAL FROM PMEGPONLINE.APP_DETAIL PAD,"      );
qrysb.append("BNF_OFF_MAST BOM WHERE PAD.OFF_CD     = BOM.OFF_CD(+) AND BOM.STATE_CD='"+SSTATE_CD+"' AND PAD.APP_ID IS NULL "+vWherecls+""      );
qrysb.append("GROUP BY PAD.APP_ID,  PAD.APP_NAME,PAD.BENF_CATAGORY_CD,  PAD.BR_CODE,  PAD.GENDER,  PAD.TEL_NO,  PAD.E_MAIL,  PAD.UNIT_LOC,  PAD.UNIT_POST_ADDR,"      );
qrysb.append("PAD.UNIT_TALUK_BLOCK, PAD.UNIT_DIST_CD, PAD.UNIT_PIN, PAD.EMP_ENV, PAD.BANK_NAME, PAD.IND_TYPE, PAD.IND_ACTIVITY,"      );
qrysb.append(" PAD.PROD_DESC, PAD.WORKSHED_COST, PAD.MACHINARY_COST,PAD.PRE_OPE_EXP, PAD.WORKING_CAPITAL"      );

}

//out.print (qrysb.toString());

// values.add (BASEID); 

ResultSet rs = db.executeSQL(qrysb.toString(),values);
values.clear();	

%>

   <div class="container">

<BR />
<center>
          <FORM action="#" method="post">
         
		 <TABLE width="49%" id="customers2">
		 <TR>
		 <TD width="22%">APP ID: </TD>
		 <TD width="34%"><INPUT name="APP_ID" type="text" id="APP_ID"  maxlength="18" value="<%=APP_ID %>"/ ></TD>
		 <TD width="44%"> <INPUT name="btnFind" type="submit" class="myButton" id="btnFind" value="Search" /></TD>
		 </TR>
		 </TABLE>
		 
</FORM>
          <DIV align="center"><SPAN class="style1">Note: Applicant Id searched should be within the state.</SPAN>
            <center>
            <BR>
            <BR>
          </DIV>
          <TABLE width="1238" border="1" id="customers">
  <TR>
    <TH><DIV align="center">App Id</DIV></TH>
    <TH><DIV align="center">Beneficiary Name</DIV></TH>
    <TH><DIV align="center">Gender</DIV></TH>
    <TH><DIV align="center">Bank Name</DIV></TH>
    <TH><DIV align="center">IFSC Code </DIV></TH>
    <TH><DIV align="center">Activity</DIV></TH>
    <TH><DIV align="center">Phy Date </DIV></TH>
    <TH><DIV align="center">Phy Status </DIV></TH>
    <TH><DIV align="center">Update</DIV></TH>
  </TR>
  
  <% 
		int srno=0;
		while (rs.next()) {

APP_ID=rs.getString("APP_ID")==null?"":rs.getString("APP_ID");
APP_NAME=rs.getString("APP_NAME")==null?"":rs.getString("APP_NAME");
BENF_CATAGORY_CD=rs.getString("BENF_CATAGORY_CD")==null?"":rs.getString("BENF_CATAGORY_CD");
GENDER=rs.getString("GENDER")==null?"":rs.getString("GENDER");
TEL_NO=rs.getString("TEL_NO")==null?"":rs.getString("TEL_NO");
E_MAIL=rs.getString("E_MAIL")==null?"":rs.getString("E_MAIL");
UNIT_LOC=rs.getString("UNIT_LOC")==null?"":rs.getString("UNIT_LOC");
UNIT_POST_ADDR=rs.getString("UNIT_POST_ADDR")==null?"":rs.getString("UNIT_POST_ADDR");
UNIT_TALUK_BLOCK=rs.getString("UNIT_TALUK_BLOCK")==null?"":rs.getString("UNIT_TALUK_BLOCK");
UNIT_DIST_CD=rs.getString("UNIT_DIST_CD")==null?"":rs.getString("UNIT_DIST_CD");
UNIT_PIN=rs.getString("UNIT_PIN")==null?"":rs.getString("UNIT_PIN");
EMP_ENV=rs.getString("EMP_ENV")==null?"":rs.getString("EMP_ENV");
BANK_NAME=rs.getString("BANK_NAME")==null?"":rs.getString("BANK_NAME");
IND_TYPE=rs.getString("IND_TYPE")==null?"":rs.getString("IND_TYPE");
IND_ACTIVITY=rs.getString("IND_ACTIVITY")==null?"":rs.getString("IND_ACTIVITY");
PROD_DESC=rs.getString("PROD_DESC")==null?"":rs.getString("PROD_DESC");
BR_CODE=rs.getString("BR_CODE")==null?"":rs.getString("BR_CODE");
TOT=rs.getString("TOT")==null?"":rs.getString("TOT");


srno=srno+1;
			 
			 %>
  
  <TR>
    <TD><DIV align="center"><%= APP_ID %></DIV></TD>
    <TD><DIV align="center"><%= APP_NAME %></DIV></TD>
    <TD><DIV align="center"><%= GENDER %></DIV></TD>
    <TD><DIV align="center"><%= BANK_NAME %></DIV></TD>
    <TD><DIV align="center"><%= BR_CODE %></DIV></TD>
    <TD>&nbsp;</TD>
    <TD>&nbsp;</TD>
    <TD>&nbsp;</TD>
    <TD><DIV align="center"><A href="applicant_add_up.jsp?PAPP_ID=<%= APP_ID %>&PAPP_NAME=<%= APP_NAME %>&PBENF_CATAGORY_CD=<%= BENF_CATAGORY_CD %>&PGENDER=<%= GENDER %>&PTEL_NO=<%= TEL_NO %>&PE_MAIL=<%= E_MAIL %>&PUNIT_LOC=<%= UNIT_LOC %>&PUNIT_POST_ADDR=<%= UNIT_POST_ADDR %>&PUNIT_TALUK_BLOCK=<%= UNIT_TALUK_BLOCK %>&PUNIT_DIST_CD=<%= UNIT_DIST_CD %>&PUNIT_PIN=<%= UNIT_PIN %>&PEMP_ENV=<%= EMP_ENV %>&PBANK_NAME=<%= BANK_NAME %>&PIND_TYPE=<%= IND_TYPE %>&PIND_ACTIVITY=<%= IND_ACTIVITY %>&PPROD_DESC=<%= PROD_DESC %>&BR_CODE=<%= BR_CODE %>&PTOT=<%= TOT %>" class="myButton">Update</A></DIV></TD>
  </TR>
  
   <%

}
rs.close();
db.close();
%>
</TABLE>
 		
	

   
</BODY>
</HTML>
