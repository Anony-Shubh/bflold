<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>

<%@ page import="pkgPmegpNew.DBCon"%>
<%@ page buffer="200kb" %>

<html>
<head>
<title>PMEGP Online Application Registration</title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />

<script type="text/javascript" src="../js/pmegpOnlinemessages.js"></script>
<script type="text/javascript" src="../js/ModalPopupWindow.js"></script>


<link rel="stylesheet" type="text/css" href="../css/jquery.dataTables.min.css" />
<script language="javascript" src="../js/jquery-1.12.4.js"></script>
<script language="javascript" src="../js/jquery.dataTables.min.js"></script>
<script language="javascript">
$(document).ready(function() {
    $('#example').DataTable( {
    } );
} );


function submitfun(){
document.form.ins.value='I';
document.form.submit();
}


 var xmlHttp   
      var xmlHttp 
      function ShowTab(){ 
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
	 
	  
	//  var vID1=document.getElementById("P_CUSTCODE").value;
	  
      var url="getDetail.jsp"; 
     
	  
      xmlHttp.onreadystatechange = ProductTwoChange; 
      xmlHttp.open("post", url, true); 
      xmlHttp.send(null); 
      } 
	  
      function ProductTwoChange(){    
      if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){   
	   var x=document.getElementById('SUP_ST_NM');
	  x.innerHTML=xmlHttp.responseText;
	// alert (xmlHttp.responseText);
      } //statechane1 function end   
      }//main function end.

	  

</script>
<style type="text/css">
<!--
.style8 {color: #000000; font-size: 14; }
.style9 {
	font-size: 18px;
	font-weight: bold;
}
-->
</style>
</head>

<body >

<form name="form" id="form"  class="form" method="post">

<img src="../pmegponline.jpg" width="100%" height="150" >
<%


 DBCon db= new DBCon();
db.connect();
 List values=new ArrayList();

String USER =(String)session.getAttribute("SUSER")==null?"":(String)session.getAttribute("SUSER");


 
		if(USER==null || USER==""){
%>

<h2 style="color:#990000 " align="center">Session Expired Please Login again.....<a href="../index.jsp" class="buttonBlue">Login</a></h2>

<%
}else{
String SRNO = "";
String PBATCHID = "";
String AUTHORISED_DATE = "";
String NO_OF_PRG = "";
String NO_OF_PRGI = "";
String NO_OF_PRGII = "";
String MM_CLAIMED_AMT = "";
String MM_CLAIMED_AMT_I = "";
String MM_CLAIMED_AMT_II = "";
String IRG_AMT = "";
String IRG_AMT_I = "";
String IRG_AMT_II = "";
String ACTUAL_MM_DISB_AMT = "";
String ACTUAL_MM_DISB_AMT_I = "";
String ACTUAL_MM_DISB_AMT_II = "";
String PBATCH_ID="";

StringBuffer qrysb= new StringBuffer();

qrysb.append("	select p.*,rownum as srno from ( "      );
qrysb.append(" SELECT "      );
qrysb.append(" PBATCHID, "      );
qrysb.append(" TO_CHAR(AUTHORISED_DATE,'DD-MON-YYYY') AUTHORISED_DATE, "      );
qrysb.append(" COUNT(*) NO_OF_PRG, "      );
qrysb.append(" COUNT(CASE WHEN LOAN_TYPE='I' THEN 1 END) NO_OF_PRGI, "      );
qrysb.append(" COUNT(CASE WHEN LOAN_TYPE='II' THEN 1 END) NO_OF_PRGII, "      );
qrysb.append(" sum(MARGIN_MONEY_CLAIMED_AMOUNT) MM_CLAIMED_AMT, "      );
qrysb.append(" sum(CASE WHEN LOAN_TYPE='I' THEN MARGIN_MONEY_CLAIMED_AMOUNT ELSE 0 END) MM_CLAIMED_AMT_I, "      );
qrysb.append(" sum(CASE WHEN LOAN_TYPE='II' THEN MARGIN_MONEY_CLAIMED_AMOUNT ELSE 0 END)MM_CLAIMED_AMT_II, "      );
qrysb.append(" sum(IRG_AMT) IRG_AMT, "      );
qrysb.append(" sum(CASE WHEN LOAN_TYPE='I' THEN IRG_AMT ELSE 0 END) IRG_AMT_I, "      );
qrysb.append(" sum(CASE WHEN LOAN_TYPE='II' THEN IRG_AMT ELSE 0 END) IRG_AMT_II, "      );
qrysb.append(" sum(ACTUAL_MM_DISB_AMT) ACTUAL_MM_DISB_AMT, "      );
qrysb.append(" sum(CASE WHEN LOAN_TYPE='I' THEN ACTUAL_MM_DISB_AMT ELSE 0 END) ACTUAL_MM_DISB_AMT_I, "      );
qrysb.append(" sum(CASE WHEN LOAN_TYPE='II' THEN ACTUAL_MM_DISB_AMT ELSE 0 END) ACTUAL_MM_DISB_AMT_II "      );
qrysb.append(" FROM CORPDATA_SENT_DETAIL GROUP BY AUTHORISED_DATE,PBATCHID order by pbatchid desc)p "      );


ResultSet rsTYPE = db.execSQL(" SELECT MAX(BD.PBATCH_ID)+1 PBATCH_ID FROM BANK_DATAENTRY BD"); 	
	
	 
	  String vBR_STATE="";
	  
	  while ( rsTYPE.next()) {
	  
	    PBATCH_ID=rsTYPE.getString("PBATCH_ID")==null?"":rsTYPE.getString("PBATCH_ID");

	  } 
	  rsTYPE.close();
	%>

<table width="100%" border="1" align="center">
  <tr>
    <th><div align="center">User Mob no.  :  *******<%= USER.substring(7,10) %></div></th>
    <th><div align="center"><a href="CORPBANK_UploadExcel.jsp" class="button">Sent to Corp bank</a></div></th>
    <th><div align="center" ><a href="../index.jsp" class="button">Logout</a></div></th>
  </tr>
</table>

<div align="center">
  <input type="hidden" name="ins" id="ins">
  <br>
  <span class="style9">Corp Data Generate Form  </span><br><br>
</div>
<table border="1" align="center">
  <tr>
    <th><div align="center"> Generate Excel File for Disbursement </div></th>
    <th><div align="center"><input name="button" type="button" class="buttonMerun" id="button" onClick="ShowTab();" value="Generate"></div></th>
    </tr>
</table>

<DIV id="SUP_ST_NM"></DIV>

          <%
		  

   if ((String)request.getParameter("ins")!=null){
out.print(PBATCH_ID);
	
		  Connection conn = null;
	try{
  Class.forName("oracle.jdbc.OracleDriver");
                conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.50.86:1521:iasdb", "pmegpnew", "PMEGP_1239");

CallableStatement cs = conn.prepareCall("{call  PROC_GENE_CORPDATAFILE (?)}");

cs.setString(1,PBATCH_ID); 
cs.execute();
}catch(Exception e){
out.print(e.toString());
}
   conn.close();

	
}

   %><BR>
          <table  align="center"  class="display" id="example" width="100%">
            <thead>
              <tr>
                <th>Srno.</th>
                <th>Batch Id </th>
                <th>File send dt </th>
                <th colspan="3" bgcolor="#FFFFCC"><div align="center">No. of project </div></th>
                <th colspan="3" bgcolor="#CCCCCC"><div align="center">Actual MM Claimed Amt </div></th>
                <th colspan="3" bgcolor="#99FFFF"><div align="center">MM to be disbursed after IRG </div></th>
                <th colspan="3" bgcolor="#FFCCFF"><div align="center">IRG Amt </div></th>
                <th bgcolor="#FFCCFF">&nbsp;</th>
              </tr>
              <tr>
                <th>&nbsp;</th>
                <th>&nbsp;</th>
                <th>&nbsp;</th>
                <th bgcolor="#FFFFCC">1st Loan </th>
                <th bgcolor="#FFFFCC">2nd Loan</th>
                <th bgcolor="#FFFFCC">Tot</th>
                <th bgcolor="#CCCCCC">1st Loan </th>
                <th bgcolor="#CCCCCC">2nd Loan</th>
                <th bgcolor="#CCCCCC">Tot</th>
                <th bgcolor="#99FFFF">1st Loan </th>
                <th bgcolor="#99FFFF">2nd Loan</th>
                <th bgcolor="#99FFFF">Tot</th>
                <th bgcolor="#FFCCFF">1st Loan </th>
                <th bgcolor="#FFCCFF">2nd Loan</th>
                <th bgcolor="#FFCCFF">Tot</th>
                <th bgcolor="#FFCCFF">&nbsp;</th>
              </tr>
            </thead>
            <tbody>
              <%

	
	 ResultSet rsMain = db.executeSQL(qrysb.toString(),values);
		values.clear();	
		
		while (rsMain.next()){ 
		SRNO=rsMain.getString("SRNO")==null?"":rsMain.getString("SRNO");
		PBATCHID=rsMain.getString("PBATCHID")==null?"":rsMain.getString("PBATCHID");
		AUTHORISED_DATE=rsMain.getString("AUTHORISED_DATE")==null?"":rsMain.getString("AUTHORISED_DATE");
		NO_OF_PRG=rsMain.getString("NO_OF_PRG")==null?"":rsMain.getString("NO_OF_PRG");
		NO_OF_PRGI=rsMain.getString("NO_OF_PRGI")==null?"":rsMain.getString("NO_OF_PRGI");
		NO_OF_PRGII=rsMain.getString("NO_OF_PRGII")==null?"":rsMain.getString("NO_OF_PRGII");
		MM_CLAIMED_AMT=rsMain.getString("MM_CLAIMED_AMT")==null?"":rsMain.getString("MM_CLAIMED_AMT");
		MM_CLAIMED_AMT_I=rsMain.getString("MM_CLAIMED_AMT_I")==null?"":rsMain.getString("MM_CLAIMED_AMT_I");
		MM_CLAIMED_AMT_II=rsMain.getString("MM_CLAIMED_AMT_II")==null?"":rsMain.getString("MM_CLAIMED_AMT_II");
		IRG_AMT=rsMain.getString("IRG_AMT")==null?"":rsMain.getString("IRG_AMT");
		IRG_AMT_I=rsMain.getString("IRG_AMT_I")==null?"":rsMain.getString("IRG_AMT_I");
		IRG_AMT_II=rsMain.getString("IRG_AMT_II")==null?"":rsMain.getString("IRG_AMT_II");
		ACTUAL_MM_DISB_AMT=rsMain.getString("ACTUAL_MM_DISB_AMT")==null?"":rsMain.getString("ACTUAL_MM_DISB_AMT");
		ACTUAL_MM_DISB_AMT_I=rsMain.getString("ACTUAL_MM_DISB_AMT_I")==null?"":rsMain.getString("ACTUAL_MM_DISB_AMT_I");
		ACTUAL_MM_DISB_AMT_II=rsMain.getString("ACTUAL_MM_DISB_AMT_II")==null?"":rsMain.getString("ACTUAL_MM_DISB_AMT_II");
	%>
              <tr>
                <td><%= SRNO %></td>
                <td><%= PBATCHID %></td>
                <td><%= AUTHORISED_DATE %></td>
                <td bgcolor="#FFFFCC"><%= NO_OF_PRGI %></td>
                <td bgcolor="#FFFFCC"><%= NO_OF_PRGII %></td>
                <td bgcolor="#FFFFCC"><%= NO_OF_PRG %></td>
                <td bgcolor="#C0EAA8"><span class="style8"><%= ACTUAL_MM_DISB_AMT_I %></span></td>
                <td bgcolor="#C0EAA8"><span class="style8"><%= ACTUAL_MM_DISB_AMT_II %></span></td>
                <td bgcolor="#C0EAA8"><span class="style8"><%= ACTUAL_MM_DISB_AMT %></span></td>
                <td bgcolor="#99FFFF"><%= MM_CLAIMED_AMT_I %></td>
                <td bgcolor="#99FFFF"><%= MM_CLAIMED_AMT_II %></td>
                <td bgcolor="#99FFFF"><%= MM_CLAIMED_AMT %></td>
                <td bgcolor="#FFCCFF"><%= IRG_AMT_I %></td>
                <td bgcolor="#FFCCFF"><%= IRG_AMT_II %></td>
                <td bgcolor="#FFCCFF"><%= IRG_AMT %></td>
                <td bgcolor="#FFCCFF"><A href="../GenerateXLS.jsp?REPNAME=CORPDATA_GENERATE&PBATCHID=<%= PBATCHID %>&AUTHORISED_DATE=<%= AUTHORISED_DATE %>" class="buttonGreen">Download Excel</A></td>
              </tr>
              <%
	}
	rsMain.close();
	db.close();
	}
	%>
            </tbody>
          </table>
</form>
 

</body>
</html>
