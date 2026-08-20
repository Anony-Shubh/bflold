<%@ page session="true" buffer="500kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>SECOND lOAN</title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />

<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script language="javascript" src="../js/ModalPopupWindow.js"></script>
<script type="text/javascript" src="../js/inlinemsg.js"></script>
<script language="javascript" src="../js/popcalendarN.js"></script>
  <script language="javascript" src="../js/jquery-1.12.4.js"></script>  
<script type="text/javascript" src="../js/jquery-1.12.0.min.js"></script>
<script src="../js/jquery-customselect.js"></script>
<script type="text/javascript" src="../js/Pmegpsecondloan.js"></script>
<script src="../js/jquery.autocomplete.js"></script>
<link rel="stylesheet" type="text/css" href="../css/autolist.css" />
<html>
<head>
<script type="text/javascript">
function Popup(url, title, w, h) {
// Fixes dual-screen position Most browsers Firefox
var dualScreenLeft = window.screenLeft != undefined ? window.screenLeft : screen.left;
var dualScreenTop = window.screenTop != undefined ? window.screenTop : screen.top;
width = window.innerWidth ? window.innerWidth : document.documentElement.clientWidth ? document.documentElement.clientWidth : screen.width;
height = window.innerHeight ? window.innerHeight : document.documentElement.clientHeight ? document.documentElement.clientHeight : screen.height;

var left = ((width / 2) - (w / 2)) + dualScreenLeft;
var top = ((height / 2) - (h / 2)) + dualScreenTop;
var newWindow = window.open(url, title, 'scrollbars=yes, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);

// Puts focus on the newWindow
if (window.focus) {
newWindow.focus();
}
}
function logout(){
 window.location.href='logout.jsp'
}

</script>
</head>
<body>
<form method="post" action="upload.jsp" name="form" id="form" >
<%
String Appid=  session.getAttribute("sAPP_ID")==null?"":(String) session.getAttribute("sAPP_ID");;
//out.print(Appid);
//if (Appid.equals("")||Appid.equals(null)){
 DBCon db= new DBCon();
db.connect();
String DIS = request.getParameter("DIS")==null?"N":(String) request.getParameter("DIS");
String APP_ID=(String) request.getParameter("app_id")==null?"":(String) request.getParameter("app_id").trim();
	APP_ID=APP_ID.trim();
		APP_ID=APP_ID.toUpperCase();	
		
       String APP_NAME = "";
String AADHAR_NO = "";
String PAN_NO = "";
String UAD="";
String UNIT_LOC="";
		String UP_ID = "";
		String UPM_CD = "";
		String DOC_NAME = "";
		String DOC_REMARKS = "";


ResultSet rsRd = db.execSQL("SELECT AD.APP_ID,  AD.APP_NAME,  AD.UNIT_LOC,  AD.AADHAR_NO,  AD.UAD,  AD.PAN_NO FROM APP_DETAIL_ONLINE_SECOND AD WHERE AD.APP_ID ='"+APP_ID+"' ");
		
		while (rsRd.next()){
		  APP_NAME=rsRd.getString("APP_NAME")==null?"":rsRd.getString("APP_NAME");
		  AADHAR_NO=rsRd.getString("AADHAR_NO")==null?"":rsRd.getString("AADHAR_NO");
		  UNIT_LOC=rsRd.getString("UNIT_LOC")==null?"":rsRd.getString("UNIT_LOC");
		  UAD=rsRd.getString("UAD")==null?"":rsRd.getString("UAD");
		  PAN_NO=rsRd.getString("PAN_NO")==null?"":rsRd.getString("PAN_NO");
		}
		
		
		rsRd.close();
		
		StringBuffer qryUp = new StringBuffer();	
			
qryUp.append("	SELECT * FROM (   ");
qryUp.append("SELECT AUM.UPM_CD, AUT.UP_ID, AUT.DOC_NAME, AUT.DOC_REMARKS, ");
qryUp.append(" TO_CHAR(AUT.UPLOAD_TIMESTAMP,'DD-MON-RRRR HH:MM') AS AUT_DT, ");
qryUp.append(" AUM.DOC_DESC FROM APP_UPLOAD_TRANS_SECOND AUT,APP_UPLOAD_MAST_SECOND AUM ");
qryUp.append(" WHERE AUT.UPM_CD = AUM.UPM_CD AND AUM.USR_TYPE='I' AND AUT.APP_ID=? ");
qryUp.append(" UNION SELECT AUM.UPM_CD,NULL UP_ID, NULL AS DOC_NAME, NULL AS DOC_REMARKS, ");
qryUp.append(" NULL AS AUT_DT, AUM.DOC_DESC FROM APP_UPLOAD_MAST_SECOND AUM WHERE AUM.USR_TYPE='I' AND  ");
qryUp.append(" AUM.UPM_CD NOT IN (SELECT UPM_CD FROM APP_UPLOAD_TRANS_SECOND ");
qryUp.append(" WHERE APP_ID=?)) ");
//out.print(qryUp.toString());


			 List values=new ArrayList();
				

      values.add (APP_ID); 	
	    values.add (APP_ID); 	
	ResultSet rsUp = db.executeSQL(qryUp.toString(),values);
	values.clear();	
		
	
		 
		   if (DIS.equals("N")) {%>	
		    <img src="../images/04_01.png" width="100%" height="150" >	
		  <BR><table align="center">
  <tr><input name="FLAG" type="hidden" id="FLAG" value="1">
    <td colspan="3"><div align="left">
	
      <input name="Button"  type="button" disabled="true"  class="buttonOrange" id="CHR"  onclick="index();" value="Personal Details" />
      <input name="Button2" type="button" disabled="true" class="buttonOrange" id="REC"  onclick="sanction();" value="Previous Sanction Details" />
      <input name="Button3" type="button" disabled="true" class="buttonOrange" id="CON"  onclick="charges();" value="Apply Online" />
	  <input name="Button3" type="button" disabled="true" class="buttonOrange" id="EDIT"  onclick="finalCalc();" value="Edit Application" />
     <input name="Button3" type="button" disabled="true" class="buttonGreen" id="CAL"  onclick="finalCalc();" value="Upload Documents" />
	 <input name="Button3" type="button" disabled="true" class="buttonOrange" id="up"  onclick="finalCalc();" value="Final Submit" />
	
	 <input name="Button3" type="button"  class="buttonOrange" id="LG"  onclick="logout();"  value="Logout" />
	
    </div></td>
    </tr>
	
</table>

<BR>


 
<%} else{%>

<%@ include file="appIncludeHeaderPage.jsp" %>

<%}%>
	 
	  <table align="center">
        <tr>
          <th colspan="5" nowrap><div align="center">ONLINE APPLICATION  FOR SECOND LOAN SUBSIDY FOR UPGRADING OF EXISTING UNIT</div></th>
        </tr>
        <tr>
          <th colspan="2" nowrap>ID:</th>
          <th nowrap><%=APP_ID%></th>
          <th nowrap>Aadhaar No: </th>
          <th nowrap><%=AADHAR_NO%></th>
        </tr>
        <tr>
          <th colspan="2" nowrap>Name:</th>
          <th nowrap><%=APP_NAME%></th>
          <th nowrap>PAN No. </th>
          <th nowrap><%=PAN_NO%></th>
        </tr>
       
        <tr>
          <th colspan="2" nowrap>Udyog Aadhar Registration No:</th>
          <th nowrap><%=UAD%></th>
          <th nowrap>Unit Location: </th>
          <th nowrap><%=UNIT_LOC%></th>
        </tr>
       
        <tr>
          <td colspan="5" nowrap class="redLebel"><div align="center">Upload all valid  Documents </div></td>
        </tr>
        <tr>
          <th nowrap>SrNo</th>
          <th nowrap>Document Desc </th>
          <th nowrap>Remarks</th>
          <th nowrap>View</th>
          <th nowrap>delete</th>
        </tr>
		    <% 
  
  String vDOC_NAME="";
  String vDOC_DESC="";
  String vDOC_REMARKS="";
  int srno=0;
  while (rsUp.next()) {
  srno=srno+1;
    vDOC_NAME=rsUp.getString("DOC_NAME")==null?"":rsUp.getString("DOC_NAME");
   vDOC_DESC=rsUp.getString("DOC_DESC")==null?"":rsUp.getString("DOC_DESC");
   vDOC_REMARKS=rsUp.getString("DOC_REMARKS")==null?"":rsUp.getString("DOC_REMARKS");
   UP_ID = rsUp.getString("UP_ID")==null?"0":rsUp.getString("UP_ID");
		 UPM_CD = rsUp.getString("UPM_CD")==null?"":rsUp.getString("UPM_CD");
  
  %>
        
         <tr>
          <td><%= srno %></td>
          <td><%= vDOC_DESC %></td>
          <td><%= vDOC_REMARKS %></td><input name="APP_ID" type="hidden" id="APP_ID" value="<%=APP_ID%>" size="30" maxlength="25" />
          <td>
		  <% if (!UP_ID.equals("0")) {%>
		  <a href="../jsp/docView.jsp?docname=<%= vDOC_NAME %>" class="greenButtonRound">view </a>
		  <% }else{%>
		  <a href="upload_app_doc_puf.jsp?UPM_CD=<%= UPM_CD %>" class="greenButtonRound" onClick="javascript:Popup(this.href, 'Upload Document', 800, 350);return (false);">Upload </a>
		  <% } %>		   </td>
          <td>
		  
		  
		  <% if (!UP_ID.equals("0")) {%>
		  <a href="upload_app_doc_del.jsp?UP_ID=<%= UP_ID %>" class="greenButtonRound" onClick="javascript:Popup(this.href, 'Upload Document', 800, 500);return (false);">delete</a></td>
		  <% } %><input name="FLAG" type="hidden" id="FLAG" value="5">
		
        </tr>
		
        <%
  }
  rsUp.close();
  
  db.close();
 
 %>


      </table>
	  <% if (DIS.equals("N")) {%>		
<div align="center">  <a href="validateBeforeSubmit.jsp?app_id=<%= APP_ID %>" class="greenButtonRound"/>Final Submit</a>	</div>	
<%}%>
 
 
</form>
</body>
</html>