<%@ page session="true"  import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.SQLException"%>
<%
response.setContentType("text/html");
response.setHeader("Cache-control","no-cache");
response.setHeader("Cache-control","private");
%>

<HTML>
<HEAD>
<TITLE>PMEGP Agency Status Update Form</TITLE>

<STYLE>
div.gallery {
  margin: 16px;
  border: 1px solid #ccc;
  float: left;
  width: 16%;
}

div.gallery:hover {
  border: 1px solid #777;
}

div.gallery img {
  width: 100%;
  height: 250px;
}

div.desc {
  padding: 15px;
  text-align: center;
}

#customers {
  font-family: Arial, Helvetica, sans-serif;
  border-collapse: collapse;
}

#customers td, #customers th {
  border: 1px solid #ddd;
  padding: 8px;
}

#customers tr:nth-child(even){background-color: #f2f2f2;}

#customers tr:hover {background-color: #ddd;}

#customers th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: #002e6e;
  color: white;
}  


.buttonGREEN {
  background-color: #464277;
  border: none;
  color: white;
  padding: 10px 16px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
}
</STYLE>


</HEAD>
<BODY>

<% 
String ins = "";
ins = (String) request.getParameter("ins")==null?"":(String) request.getParameter("ins").trim();
String  APP_ID =request.getParameter("APP_ID")==null?"DIAP17182092-5559474":(String)request.getParameter("APP_ID");
String  APP_NAME ="";
DBCon db= new DBCon();
db.connect();

String ATTACHMENT_NAME="";
String MEDIA_TYPE="";
String UNIT_NAME="";
String IND_TYPE="";

String ACTIVITY_NAME="";
String PRJ_COST="";
ResultSet  rs;
ResultSet  rst;

  StringBuffer qry= new StringBuffer();
	
qry.append(" SELECT gd.APP_ID,gd.APP_NAME, ga.unit_name,  decode(gd.IND_TYPE,'M','MANUFACTURING','T','TRADEING','S','SERVICE')  AS IND_TYPE, ");
qry.append("   gd.ACTIVITY_NAME ||'-'||gd.PROD_DESC as ACTIVITY_NAME ,  NVL(gd.PRJ_CE,0)+NVL(gd.PRJ_WC,0) AS PRJ_COST ");
qry.append("  FROM geotag_trans ga, GEOTAGAPIDATA gd WHERE gd.APP_ID = ga.APP_ID AND ga.APP_ID=? ");

   List values=new ArrayList();
   
   values.add(APP_ID);
   
    rst = db.executeSQL(qry.toString(),values);
   values.clear();
  
while (rst.next()){

	UNIT_NAME=rst.getString("UNIT_NAME")==null?"":rst.getString("UNIT_NAME");
	IND_TYPE=rst.getString("IND_TYPE")==null?"":rst.getString("IND_TYPE");	
	ACTIVITY_NAME=rst.getString("ACTIVITY_NAME")==null?"":rst.getString("ACTIVITY_NAME");
	PRJ_COST=rst.getString("PRJ_COST")==null?"":rst.getString("PRJ_COST");
APP_NAME=rst.getString("APP_NAME")==null?"":rst.getString("APP_NAME");
}


   
   
    StringBuffer qrysb= new StringBuffer();
	

qrysb.append("   SELECT ga.ATTACHMENT_NAME, ga.MEDIA_TYPE, ga.APP_ID FROM geotag_attch ga  where  ga.APP_ID=?"      );

int count=0;



values.add(APP_ID);
  
   rs = db.executeSQL(qrysb.toString(),values);
   values.clear();
 
 
	
%>

<DIV align="center">
  <A href="GTAppSearchLOV.jsp" style="float:right;" class="buttonGREEN">Back</A>
<TABLE align="center" id="customers">
  <TR>
    <TH colspan="4" scope="row"><DIV align="center">PMEGP </DIV></TH>
  </TR>
  <TR>
    <TD scope="row">Applicant ID: </TD>
    <TD><%= APP_ID %></TD><TD>Applcant Name: </TD>
    <TD><%= APP_NAME %></TD>
   
  </TR>
   <TR>
    <TD scope="row">Project Cost: </TD>
    <TD><%= PRJ_COST %></TD>
    <TD>Industry Type: </TD>
    <TD><%= IND_TYPE %></TD>
  </TR>
   <TR>
    <TD>Unit Name: </TD>
    <TD><%= UNIT_NAME %></TD>
    <TD scope="row">Activity: </TD>
    <TD><%= ACTIVITY_NAME %></TD>
    
  </TR>
  </TABLE>
  

       </DIV>

  <DIV align="center">     
       
<%
while (rs.next()){	
ATTACHMENT_NAME=rs.getString("ATTACHMENT_NAME")==null?"":rs.getString("ATTACHMENT_NAME");
MEDIA_TYPE=rs.getString("MEDIA_TYPE")==null?"":rs.getString("MEDIA_TYPE");	
count=count+1;
%>
   <DIV class="gallery">
  <A target="_blank" href="<%=MEDIA_TYPE%>">
    <IMG src="<%=MEDIA_TYPE%>" width="600" height="400" onError="this.onerror=null;this.src='../images/videothumbnail.jpg';" >
  </A>
 <!-- <DIV class="desc"><%=ATTACHMENT_NAME%></DIV>-->

      
</DIV>
  <%} rs.close();%>  


</DIV>


</BODY>
</HTML>
