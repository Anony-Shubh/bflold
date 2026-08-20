<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.io.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="javazoom.upload.*"%>
<%@ page import="pkgPmegpNew.DBCon"%>

<HTML>
<HEAD>
    <%
    response.setHeader("Cache-Control", "no-cache");
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
    %>
<%! 

public static String getExtension(String s) {
    String ext = null;
    int i = s.lastIndexOf('.');
    if (i > 0 &&  i < s.length() - 1) {
        ext = s.substring(i+1).toLowerCase();
    }
    return ext;
}


 %>
    <TITLE>upload </TITLE>
<LINK rel="stylesheet" type="text/css" href="css/simple-sidebar1.css" />
<SCRIPT language="javascript">

window.onunload = refreshParent;
    function refreshParent() {
      window.opener.location.reload();
    }
	
function submit_form() {
	document.form.ins.value='I';
	document.form.submit();
	
}
</SCRIPT>
<STYLE type="text/css">
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
    width: 60%;
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
</HEAD>

<BODY>
<FORM method="post" name="form" id="form"  >

	    <%
		
		 String uploadfile="";
String UC_ID = request.getParameter("UC_ID")==null?"":request.getParameter("UC_ID");

out.print(UC_ID);

DBCon db= new DBCon();
db.connect();

List values=new ArrayList();	
List pstm=new ArrayList();

String UC_UPLOAD_NAME="";
       
           StringBuffer qrysb = new StringBuffer();
qrysb.append("   SELECT bu.UC_UPLOAD_NAME   "      );

qrysb.append("  FROM BNF_UC  BU WHERE BU.UC_ID   = '"+UC_ID+"'    "      );

			
				
			
			
				
	ResultSet rsUp = db.execSQL(qrysb.toString());		
	
	while (rsUp.next()) {
	
		 UC_UPLOAD_NAME = rsUp.getString("UC_UPLOAD_NAME")==null?"":rsUp.getString("UC_UPLOAD_NAME");
	}
			
		
        %>

<TABLE id="customers" align="center">
        <TR>
          <TH colspan="4" bgcolor="#003300"><SPAN class="style2"><DIV align="center">Document Delete Form  </DIV></SPAN></TH>
        </TR>
        <TR>
          <TD colspan="4" scope="col"><DIV align="center">Are you sure you want to delete this file?</DIV></TD>
        </TR>
        
        
        <TR HIDDEN>
          <TH colspan="3"> Application No :
          <INPUT name="UC_ID" type="hidden" id="UC_ID" value="<%=UC_ID%>">
          <INPUT name="ins" type="hidden" id="ins" value=""></TH>
          <TH scope="col"><%=UC_ID%></TH>
        </TR>
        
       
        <TR>
          <TD colspan="4"><DIV align="center">
			<a class="myButton" onClick="submit_form();">Delete</a>
          </DIV></TD>
        </TR>
      </TABLE>
	 <%
	 
	   try{
   if ((String)request.getParameter("ins")!=null){
   
StringBuffer qryUpdate = new StringBuffer();
qryUpdate.append("UPDATE BNF_UC SET UC_UPLOAD_NAME=null,UC_UPLOAD_DT=null  WHERE UC_ID=?");
values.clear();
pstm.clear();
values.add(UC_ID); pstm.add ("L");
db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate() ;
values.clear();
 pstm.clear();

db.close();
response.sendRedirect("savemsgnew.jsp");
   
 }//ins


}//try
catch(Exception e)
{out.println(e);}
finally{
//db.close();

}
	 
	   %>
	 <SCRIPT language="javascript">
function refresh_close(){
window.parent.refreshpage();
}
</SCRIPT>    
</FORM>
</BODY>
</HTML>