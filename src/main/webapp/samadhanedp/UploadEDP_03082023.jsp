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
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%><head>
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
<head>
	<title>SAMADHAN ONLINE EDP TRAINIG</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
	<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="css/style.css">
	<link rel="stylesheet" type="text/css" href="css/responsive.css">
</head>
<script type="text/javascript" src="js/datetimepicker_css.js"></script>
<script>

function totamt(){
var total_inv_amt,gst_amt;
total_inv_amt=Number(document.getElementById("total_inv_amt").value);
gst_amt= total_inv_amt*18/100;
document.getElementById("gst_amt").value= gst_amt;
total_amt= Number(total_inv_amt)+Number(gst_amt);
document.getElementById("total_amt").value= total_amt;
}

</script>
<script language="javascript">




function submitform() {

fileName = document.querySelector('#uploadfile').value;
extension = fileName.substring(fileName.lastIndexOf('.') + 1);

//alert (extension.toUpperCase());
//return (false);
 
 
  

var inv_no = form.inv_no.value; 
var inv_date = form.inv_date.value;
//var updoc_edp = form.updoc_edp.value; 
var total_inv_amt = form.total_inv_amt.value; 

var vuploadfile= form.uploadfile.value; 




 
  if (vuploadfile == "")   {	 alert ( 'please upload Invoice in PDF ',2);	return (false);} 
  
   if (!(extension.toUpperCase() == "PDF"))   {	 alert ( 'uploaded Invoice is Not a pdf file',2);	return (false);} 
   
   try {
   if (extension.toUpperCase() == "PDF") {
    const fi = document.getElementById('uploadfile');
   if (fi.files.length > 0) {
            for (const i = 0; i <= fi.files.length - 1; i++) {
  
                const fsize = fi.files.item(i).size;
                const file = Math.round((fsize / 1024));
                // The size of the file.
                if (file >= 1024) {
                    alert(
                      " file size is large, Maximum size should be 1 MB");
					  return(false);
                }
            }
        }    
		}// end  
		
		} catch(err) {
 // document.getElementById("demo").innerHTML = err.message;
}
  
  if (inv_date == "")   {	 alert ( 'please enter Invoice  date ',2);	return (false);} 
	 if (inv_no == "")  {	 alert ( 'please enter Invoice No',2);	return (false);}
	
	  //if (updoc_edp == "") {	 alert ( 'please Upload Edp Invoice ',2);	return (false);}
	 if (total_inv_amt == "") {	 alert ( 'please enter Invoice Amount',2);	return (false);}
	 
	

//alert("data save");
document.form.ins.value='I';
document.form.submit();

}
</script>




<style>

<style>
table {
  border-collapse: collapse;
  border-spacing: 0;
  width: auto;
  border: 1px solid #ddd;
}

th, td {
  text-align: left;
  padding: 4px;
}

tr:nth-child(even) {
  background-color: #f2f2f2;
}

.readonlytext {
 border: 0;
  box-shadow: none;
  background-color:#CCCCCC;
}


.style1 {font-weight: bold}
</style>
</style>


</head>
<body>
<form method="post"  name="form" id="form" class="form" enctype="multipart/form-data" >

<jsp:useBean id="upBean" scope="page" class="javazoom.upload.UploadBean" >
  <jsp:setProperty name="upBean" property="filesizelimit" value="1000000" />
    <jsp:setProperty name="upBean" property="folderstore" value="/opt/tomcat5/webapps/pmegpeportal/samadhanedp/otherdocu" />
  <jsp:setProperty name="upBean" property="overwrite" value="false" />
  <jsp:setProperty name="upBean" property="whitelist" value="*.pdf" />
  </jsp:useBean>
<%
List values=new ArrayList(); 


String off_cd=request.getParameter("off_cd")==null?"0":(String)request.getParameter("off_cd") ;
String month_dt=session.getAttribute("sInvDt")==null?"":(String) session.getAttribute("sInvDt");
String edp_no=request.getParameter("no_ofapp")==null?"0":(String)request.getParameter("no_ofapp") ;;
String state ="";
String off_name1 ="";
String invupid =request.getParameter("invupid")==null?"0":(String)request.getParameter("invupid");
String TOTAL_INV_AMT="";
String gst_amt="";
String total_inv_amt="";
String updoc_edp="";
String total_amt="";
String TOTAL_AMT="";
String UPDOC_EDP ="";
String err="";
String inv_no="";
String inv_date="";
//String off_name1="";

String add_update="I";
String ins=request.getParameter("ins")==null?"I":(String) request.getParameter("ins");



 DBCon db= new DBCon();
      db.connect(); 

if(!off_cd.equals("")){

StringBuffer qrysb = new StringBuffer();

qrysb.append("   SELECT"      );
qrysb.append("       mq.state,"      );
qrysb.append("       mq.off_name1,"      );
qrysb.append("       mq.off_cd,"      );
qrysb.append("       sq.invupid,"      );
qrysb.append("       sq.updoc_edp,"      );
qrysb.append("       sq.total_amt,"      );
qrysb.append("       sq.total_inv_amt,"      );
qrysb.append("       sq.month_dt,"      );
qrysb.append("       sq.gst_amt,"      );
qrysb.append("       NVL(sq.edp_no,"+edp_no+") AS EDP_NO,"      );
qrysb.append("       sq.inv_no,"      );
qrysb.append("       sq.inv_date"      );
qrysb.append("   FROM"      );
qrysb.append("       ("      );
qrysb.append("           SELECT"      );
qrysb.append("               ms.state_nm AS state,"      );
qrysb.append("               mom.off_name1,"      );
qrysb.append("               mom.off_cd"      );
qrysb.append("           FROM"      );
qrysb.append("               mas_off_mast   mom,"      );
qrysb.append("               m_district     md,"      );
qrysb.append("               m_state        ms"      );
qrysb.append("           WHERE"      );
qrysb.append("               mom.district_cd = md.district_cd"      );
qrysb.append("               AND md.state_cd = ms.state_cd"      );
qrysb.append("               AND mom.off_cd = ?"      );
qrysb.append("       )                                                                           mq,"      );
qrysb.append("       ("      );
qrysb.append("           SELECT"      );
qrysb.append("               boi.off_cd,"      );
qrysb.append("               boi.invupid,"      );
qrysb.append("               boi.updoc_edp,"      );
qrysb.append("               boi.total_amt,"      );
qrysb.append("               boi.total_inv_amt,"      );
qrysb.append("               TO_CHAR(boi.month_dt, 'DD-MON-RRRR') AS month_dt,"      );
qrysb.append("               boi.gst_amt,"      );
qrysb.append("               nvl(boi.edp_no, 3) AS edp_no,"      );
qrysb.append("               boi.inv_no,"      );
qrysb.append("               TO_CHAR(boi.inv_date, 'DD-MON-RRRR') AS inv_date,"      );
qrysb.append("               TO_CHAR(BOI.FORWARD_DT,'DD-MON-RRRR') AS FORWARD_DT"      );
qrysb.append("           FROM"      );
qrysb.append("               bnf_onlineedp_inf boi"      );
qrysb.append("           WHERE"      );
qrysb.append("               nvl(boi.invupid, 0) = ?"      );
qrysb.append("       ) sq"      );
qrysb.append("   WHERE"      );
qrysb.append("       mq.off_cd = sq.off_cd (+)"      );


//out.print (qrysb.toString());
//List values=new ArrayList(); 
values.add(off_cd);
values.add(invupid);

//out.print(invupid);
//out.print("<br>");
//out.print(off_cd);

ResultSet rsMain = db.executeSQL(qrysb.toString(),values);

while (rsMain.next()){
//off_name1=rsMain.getString("off_name1")==null?"0":rsMain.getString("off_name1");
invupid=rsMain.getString("invupid")==null?"0":rsMain.getString("invupid");
updoc_edp=rsMain.getString("updoc_edp")==null?"":rsMain.getString("updoc_edp");
total_amt=rsMain.getString("total_amt")==null?"":rsMain.getString("total_amt");
total_inv_amt=rsMain.getString("total_inv_amt")==null?"":rsMain.getString("total_inv_amt");
//month_dt=rsMain.getString("month_dt")==null?dt:rsMain.getString("month_dt");
state=rsMain.getString("state")==null?"":rsMain.getString("state");
off_name1=rsMain.getString("off_name1")==null?"":rsMain.getString("off_name1");
gst_amt=rsMain.getString("gst_amt")==null?"":rsMain.getString("gst_amt");
inv_no=rsMain.getString("inv_no")==null?"":rsMain.getString("inv_no");
inv_date=rsMain.getString("inv_date")==null?"":rsMain.getString("inv_date");
edp_no=rsMain.getString("edp_no")==null?"":rsMain.getString("edp_no");

if (!invupid.equals("0")) {
add_update="U";
}


}
rsMain.close();

}

%>
<body>

<table align="center" border="1" id="cont">
<div class="limiter" align="center">
		<div class="container-login100" align="center">
<div class="wrap-login100" align="center">
				<div class="login_head"><h5>Samadhan Online EDP training</h5></div>
				<form class="login100-form validate-form">
<tr>
  <td colspan="4" class="style1" align="center"><div align="center">Online EDP Upload Invoice Form </div></td>
  </tr>
<tr align="left">
  <td class="style1">Office Name:
  <input name="ins" type="hidden" id="ins" value="<%= ins %>"></td>
  <td class="style1"><%=off_name1%></td>
  <td class="style1">State:</td>
  <td class="style1"><%=state%></td>
</tr>
<tr align="left">
  <td class="style1">Month:
    <input name="edp_no" type="hidden" id="edp_no" value="<%=edp_no%>"  readonly="true" ></td>
  <td class="style1"><%= month_dt %> </td>
  <td><strong><strong>Training</strong> Completed </strong></td>
  <td class="style1"><%=edp_no%></td>
</tr>
</table>

<table  align="center" cellpadding="2" cellspacing="2"  id="cont1" >
  
  <tr>
    <td align="center">&nbsp;</td>
    <td colspan="2">Invoice Should be in pdf file and Maximum size 1 mb. </td>
    </tr>
  <tr>
    <td align="center"><strong>(1)</strong></td>
    <td><strong>Invoice Date:</strong></td>
    <td><input name="inv_date" type="text" id="inv_date" onClick="javascript:NewCssCal('inv_date','ddMMMyyyy')" value="<%=inv_date%>"readonly="true" >    </td>
    </tr>
  <tr>
    <td align="center"><strong>(2)</strong></td>
    <td><strong>Invoice No:</strong></td>
    <td><input type="text"  name="inv_no" id="inv_no"  value="<%=inv_no%>" required /></td>
    </tr>
  
  <tr>
    <td align="center"><strong>(3)</strong></td>
    <td><strong> EDP Fees*</strong></td>
    <td><input type="number"  name="total_inv_amt" id="total_inv_amt"  onChange="totamt();" value="<%=total_inv_amt%>" required></td>
    </tr>
  <tr>
    <td align="center"><strong>(4)</strong></td>
    <td><strong>GST@18%*:</strong></td>
    <td><input  type="text"  name="gst_amt" id="gst_amt" value="<%=gst_amt%>"  readonly="true" class="readonlytext" /></td>
    </tr>
  <tr>
    <td align="center"><strong>(5)</strong></td>
    <td><strong>Total :</strong></td>
    <td><input  type="text"  name="total_amt"  id="total_amt" value="<%=total_amt%>" readonly="true" class="readonlytext"/></td>
    </tr>
  <tr>
    <td align="center"><strong>(6)</strong></td>
    <td><input name="updoc_edp" type="hidden" id="updoc_edp" value="<%=updoc_edp %>">
        <input name="todo" type="hidden" value="upload"/>
        <strong>Upload Invoice</strong>: </td>
    <td><input name="uploadfile" type="file" id="uploadfile"  value="<%=updoc_edp%>" class="show" ></td>
  </tr>
  <br>
  <tr>
    <td colspan="3" class="style1" align="center"><div align="center">
      <input name="button" type="button" class="login100-form-btn"  onClick="submitform();" value="Upload Invoice" />    
    </div></td>
  </tr>
</table>
<%
  StringBuffer qryUpdate = new StringBuffer();
 
 values.clear();
      if (MultipartFormDataRequest.isMultipartFormData(request))
      {
         MultipartFormDataRequest mrequest = new MultipartFormDataRequest(request);
         String todo = null;
         if (mrequest != null) todo = mrequest.getParameter("todo");
		// DOC_REMARKS=mrequest.getParameter("DOC_REMARKS")==null?"":mrequest.getParameter("DOC_REMARKS");
	     if ( (todo != null) && (todo.equalsIgnoreCase("upload")) )
	     {
                Hashtable files = mrequest.getFiles();
							
                if ( (files != null) && (!files.isEmpty()))
                {
                    UploadFile file = (UploadFile) files.get("uploadfile");
				
					 upBean.store(mrequest, "uploadfile");
						
						Date dNow = new Date();
						SimpleDateFormat ft = new SimpleDateFormat("yyMMddhhmmssMs");
						String rnddt = ft.format(dNow);
						
						String ext="";
						try{
						ext=getExtension(file.getFileName());
						}catch(Exception e){}

					  total_inv_amt=mrequest.getParameter("total_inv_amt")==null?"0":(String)mrequest.getParameter("total_inv_amt");
					 
					  gst_amt=mrequest.getParameter("gst_amt")==null?"0":(String)mrequest.getParameter("gst_amt");
					  
					  total_amt=mrequest.getParameter("total_amt")==null?"0":(String)mrequest.getParameter("total_amt");
					  inv_no=mrequest.getParameter("inv_no")==null?"0":(String)mrequest.getParameter("inv_no");
					  inv_date=mrequest.getParameter("inv_date")==null?"0":(String)mrequest.getParameter("inv_date");
					  month_dt=session.getAttribute("sInvDt")==null?"":(String) session.getAttribute("sInvDt");
					  edp_no=mrequest.getParameter("edp_no")==null?"10":(String)mrequest.getParameter("edp_no");

						String frenNm="doc"+invupid+"_"+rnddt+"."+ext;
						
						
						File f = new File("/opt/tomcat5/webapps/pmegpeportal/samadhanedp/otherdocu/"+file.getFileName()+"");
     					
						boolean success =f.renameTo(new File("/opt/tomcat5/webapps/pmegpeportal/samadhanedp/otherdocu/"+frenNm+""));
						
						
						frenNm=ext.equals("")?UPDOC_EDP:frenNm;
			//out.print(frenNm+"edp_no:"+edp_no);			
						
						List pstm=new ArrayList();
		
		values.clear();
		
		pstm.clear();
		if (add_update.equals("I")) {
		
		
ResultSet rsMax = db.execSQL("SELECT nvl(max(invupid),0)+1 as invupid  FROM BNF_ONLINEEDP_INF");
while (rsMax.next()) {
invupid=rsMax.getString("invupid")==null?"1":rsMax.getString("invupid");
}



	rsMax.close();
	

  
qryUpdate.append(" INSERT INTO BNF_ONLINEEDP_INF ");
qryUpdate.append("(updoc_edp,");
qryUpdate.append("total_amt, ");
qryUpdate.append("total_inv_amt,");
qryUpdate.append("month_dt,");
qryUpdate.append("gst_amt,");
qryUpdate.append("inv_no,inv_date,edp_no,off_cd,"); 
qryUpdate.append("invupid ");
qryUpdate.append( ") VALUES (?,?,?,?,?,?,?,?,?,?) ");

}else {
//try{

qryUpdate.append("	UPDATE BNF_ONLINEEDP_INF SET ");
qryUpdate.append("	updoc_edp = ?, ");
qryUpdate.append("	total_amt = ?, ");
qryUpdate.append("	total_inv_amt = ?, ");
qryUpdate.append("	month_dt = ?, ");
qryUpdate.append("  gst_amt = ?, ");
qryUpdate.append("	inv_no = ?, ");
qryUpdate.append("	inv_date = ?, edp_no= ?  ");
qryUpdate.append(" WHERE  off_cd=? and  invupid = ?    ");


}
//out.print (qryUpdate.toString());



values.add(frenNm); pstm.add ("L");
values.add(total_amt); pstm.add ("L");
values.add(total_inv_amt); pstm.add ("L");
values.add(month_dt); pstm.add ("L");
values.add(gst_amt); pstm.add ("L");
values.add(inv_no); pstm.add ("L");
values.add(inv_date); pstm.add ("L");
values.add(edp_no); pstm.add ("L");
values.add(off_cd); pstm.add ("L");
values.add(invupid); pstm.add ("L");


						
		db.setSqlValue(qryUpdate.toString()); 
db.setValues(values,pstm); 
db.executeUpdate() ;				
						
		//out.print ("invupid: "+qryUpdate.toString()) ;			
						
					   
					db.close();
					response.sendRedirect("savemsg.jsp");
					
										
						}
						}
						}
		
		
		
		
		//out.print(err);
		//out.print (qryUpdate.toString());
  
  
  
  
   

 
  

%>
</form>

</body>
 
</html>


