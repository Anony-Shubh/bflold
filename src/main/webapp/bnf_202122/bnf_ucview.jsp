<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="pkgPmegpNew.DBCon"%>

<HTML>
<HEAD>
<META http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<SCRIPT language="javascript" src="../js/ModalPopupWindow.js"></SCRIPT>	
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
  padding: 10px;
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
  background-color: #f2f2f2;
  padding: 20px;
}


input:read-only {
  background-color: #ffff99;
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
.myButton {
	background-color:#2e823c;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:13px;
	padding:10px 33px;
	text-decoration:none;
	text-shadow:0px 1px 0px #2f6627;
}
.style1 {font-size: large}
</STYLE>

<BODY>

<%@ include file = "sessionoutinc.jsp" %>


 <%

DBCon db= new DBCon();
db.connect(); 

String OFF_CD=session.getAttribute("SOFF_CD")==null?"":(String)session.getAttribute("SOFF_CD");

StringBuffer qryvaln = new StringBuffer();
try {
qryvaln.append(" select FUNC_BNF_UC_UPDATE("+OFF_CD+") from dual  ");

ResultSet rsvaln=db.execSQL(qryvaln.toString());
rsvaln.close();
}catch (Exception t){}


String UC_ID="";
String UC_UPLOAD_NAME="";
String UC_UPLOAD_DT=""; 
String HO_FORW_DATE="";
String OFFICENAME=session.getAttribute("SOFF_NAME1")==null?"":(String)session.getAttribute("SOFF_NAME1");	
 
List values=new ArrayList();

//if (vlogin.equals("Y")){
 StringBuffer sb= new StringBuffer();
 
sb.append("   SELECT bu.UC_ID, bu.UC_UPLOAD_NAME, bu.UC_UPLOAD_DT, TO_CHAR(bu.HO_FORW_DATE,'DD-MON-RRRR') AS HO_FORW_DATE "      );
sb.append("         FROM bnf_uc bu WHERE bu.YEAR_ID = ? "      );
sb.append("         AND bu.OFF_CD  = ?"      );


values.add(sselect);
values.add(SOFF_CD);  


//out.print(sb.toString());
ResultSet rs = db.executeSQL(sb.toString(),values);




%>
<CENTER>
  <H1>UC for the year <%= sselect %></H1>

    
<TABLE id="customers" >
            <THEAD>
                <TR>
                  <TH><DIV align="center">OFFICE NAME</DIV></TH>
				  <TH><DIV align="center">Update UC Data </DIV> </TH>
				  <TH><DIV align="center">UC Download </DIV></TH>
				  <TH><DIV align="center">Upload Signed UC</DIV></TH>
				  <TH><DIV align="center">Forward UC to HO</DIV></TH>
    </TR>
            </THEAD>
  <%
int count=0;
while (rs.next()) {
count=count+1;
UC_ID=rs.getString("UC_ID")==null?"":rs.getString("UC_ID");
UC_UPLOAD_NAME=rs.getString("UC_UPLOAD_NAME")==null?"":rs.getString("UC_UPLOAD_NAME");
UC_UPLOAD_DT=rs.getString("UC_UPLOAD_DT")==null?"":rs.getString("UC_UPLOAD_DT");
HO_FORW_DATE=rs.getString("HO_FORW_DATE")==null?"":rs.getString("HO_FORW_DATE");
%>
            <TBODY>
             <TR> 
				 <TD><DIV align="center"><%= SOFF_NAME1 %></DIV></TD>
                 <TD><DIV align="center" ><A href="bnf_uc.jsp?UC_ID=<%= UC_ID %>" class="myButton" VALUE="Add/Update">Update UC </A></DIV></TD>
			     <TD><DIV align="center"><A target="_blank" href="jasperReports/bnfreportach.jsp?REPNM=bnf_uc&OFF_CD=<%=OFF_CD%>&YEAR_ID=<%=sselect%>&UC_ID=<%=UC_ID%>&OFFICENAME=<%= OFFICENAME %>" class="myButton" VALUE="View Report">Generate UC</A></DIV></TD>
				 <TD>
				 <%if(UC_UPLOAD_NAME.equals("")){%>
				 <DIV align="center"><A  onClick="uploaddocu('<%= UC_ID %>');"  class="myButton">Upload Signed UC </A></DIV>
				 <%}else{%>
				 <DIV align="center"><A href="../../pmegpeportalappdoc/bnf/uc_upload/<%=UC_UPLOAD_NAME %>" target="_blank" class="myButton">View UC </A>
				 
				   <%if(HO_FORW_DATE.equals("")){%>
				 <A onClick="deletedocu('<%= UC_ID %>');" class="myButton">Delete</A></DIV>
				 <%}%>

				 
				 <%}%>				 </TD>
	             <TD><DIV align="center">
				 
				 <%if(!UC_UPLOAD_NAME.equals("")){%>
				 
				 <%if(HO_FORW_DATE.equals("")){%>
				 <A onClick="forwardtoho('<%= UC_ID %>');" class="myButton" VALUE="Forward To HO">Forward To HO</A>
				 <%}else{%>
				 Forwarded on <%= HO_FORW_DATE %>
				 <%}%>
				 
				 <%}%>
				 
				 </DIV></TD>  
		      </TR>
             <TR>
               <TD colspan="5">&nbsp;</TD>
              </TR>
             <TR>
               <TD colspan="5"><p align="left"><u>Step 1</u><br>
                 Update details of interest earned  during the year and interest remittance to HO. All other details are auto  populated based on details in &ldquo;Update Performance&rdquo; Tab.</p>
                 <p align="left"><br>
                     <u>Step 2 Generate UC</u><br>
                   Generate UC &amp; Verify the details  as per account statement. In case of difference, kindly update in &ldquo;Update  Performance&rdquo; Tab.</p>
                 <p align="left"><br>
                     <u>Step 3 Upload UC</u><br>
                   Upload signed &amp; stamped UC. Check  the details under view.</p>
                 <p align="left"><br>
                     <u>Step 4</u><br>
               Forward the uploaded UC to HO.</p></TD>
              </TR>  
            </TBODY>
  </TABLE>
  <p align="left"><a name="_GoBack"></a></p>
  <p>&nbsp;</p>
</CENTER>


  <%

}
rs.close();
db.close();
%>


<SCRIPT language="javascript">
 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");

 function uploaddocu(UC_ID){
var callbackFunctionArray = new Array(refreshpage);
 modalWin.ShowURL("uc_uploaddocu.jsp?UC_ID="+UC_ID,400,900,'Upload Document',null,null);
 }//end of bank
 
  function deletedocu(UC_ID){
var callbackFunctionArray = new Array(refreshpage);
 modalWin.ShowURL("uc_deletedocu.jsp?UC_ID="+UC_ID,400,900,'Upload Document',null,null);
 }//end of bank

  function forwardtoho(UC_ID){
var callbackFunctionArray = new Array(refreshpage);
 modalWin.ShowURL("uc_forwd_ho.jsp?UC_ID="+UC_ID,400,900,'Upload Document',null,null);
 }//end of bank


  function HideModalWindow() {
  modalWin.HideModalPopUp();
}

function refreshpage() {
  location.reload();
}

</SCRIPT>
</BODY>
		
		</HTML>