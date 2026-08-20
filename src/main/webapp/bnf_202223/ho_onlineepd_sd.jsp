<%@ page buffer="1000kb" session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon,java.math.BigDecimal"  %><head>
	<title>SAMADHAN ONLINE EDP TRAINIG</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="icon" type="image/png" href="../samadhanedp/images/icons/favicon.ico"/>
	<link rel="stylesheet" type="text/css" href="../samadhanedp/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="../samadhanedp/fonts/font-awesome-4.7.0/css/font-awesome.min.css">

	<link rel="stylesheet" type="text/css" href="../samadhanedp/css/responsive.css">
	<link rel="stylesheet"  type="text/css" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css">
   <SCRIPT language="javascript" src="js/ModalPopupWindow.js"></SCRIPT>
</head>
<style type="text/css">
<!--
.style1 {
	color: #F0F0F0;
	font-size: 10px;
}
-->
<!-- HTML !-->

/* CSS */
.button-7 {
  background-color: #0095ff;
  border: 1px solid transparent;
  border-radius: 3px;
  box-shadow: rgba(255, 255, 255, .4) 0 1px 0 0 inset;
  box-sizing: border-box;
  color: #fff;
  cursor: pointer;
  display: inline-block;
  font-family: -apple-system,system-ui,"Segoe UI","Liberation Sans",sans-serif;
  font-size: 13px;
  font-weight: 400;
  line-height: 1.15385;
  margin: 0;
  outline: none;
  padding: 8px .8em;
  position: relative;
  text-align: center;
  text-decoration: none;
  user-select: none;
  -webkit-user-select: none;
  touch-action: manipulation;
  vertical-align: baseline;
  white-space: nowrap;
}

.button-7:hover,
.button-7:focus {
  background-color: #07c;
}

.button-7:focus {
  box-shadow: 0 0 0 4px rgba(0, 149, 255, .15);
}

.button-7:active {
  background-color: #0064bd;
  box-shadow: none;
}
  </style>
</head>

<body bgcolor="#FFFFFF";>
		
		
<form name="form" id="form" method="post">
<%@include file="sessionoutinc.jsp" %>
<br>
<br>
<center>
<table align="center"><tr>
  <td>
  <DIV align="center">
    <h3>Select Invoice Month:*
 
      <% 
	List values=new ArrayList(); 
	
		DBCon db= new DBCon();
      db.connect();
	String off_cd=request.getParameter("SOFF_NAME")==null?"0":(String)request.getParameter("SOFF_NAME") ;

	String vdvDate=request.getParameter("INVDT")==null?"":(String)request.getParameter("INVDT") ;
	
	session.setAttribute("sInvDt", vdvDate);
out.print (vdvDate);

String sInvDt=session.getAttribute("sInvDt")==null?"":(String) session.getAttribute("sInvDt");
   	   		
				
BigDecimal sumgtotal=new BigDecimal("0"); 
BigDecimal noapp=new BigDecimal("0");
			

	   String dtdis="";
	   String DTV="";
	  
  %>
   <select name="INVDT" id="INVDT" >
    <option value="">Select Invoice Month</option>
	<%
  ResultSet rsUp=db.execSQL("select TO_CHAR(DTV,'DD-MON-RRRR') AS DTV,DTDIS||' ('||APPNO||')' AS DTDIS from edp_month");
		 
		  while (rsUp.next()){
	     dtdis=rsUp.getString("dtdis")==null?"":rsUp.getString("dtdis");
		 DTV=rsUp.getString("DTV")==null?"":rsUp.getString("DTV");
	
		 
  %>
    <option value=<%=DTV%>  <% if (DTV.equals(sInvDt)){out.print("selected");} %>> <%=dtdis%></option>
    <% } rsUp.close(); %>
  </select>
   <label></label>
  </h3>
  </DIV>
   </td>
  <td><input name="Submit3" type="submit"  value="FIND"  class="login100-form-btn"  > </td> </tr>
  </table>
  </center>
 
  
  
 <% if (sInvDt.equals("")) { out.print("<center><h2>Please Select Invoice Month</h2></center>"); }else{%>

  <table id="example" class="display" style="width:100%">
    <thead>
      <tr>
        <th width="4%">Zone Name </th>
        <th width="14%">State Name</th>
        <th width="17%">Office Name</th>
        <th width="14%"> Date</th>
        <th width="9%">TOTAL</th>
        <th width="13%">Upload Invoice</th>
        <th width="7%">Invoice No </th>
		 <th width="6%">Invoice Date </th>
		   <th width="5%">Amount</th>
		   <th width="6%">Download </th>
		   <th width="5%">Forward To Kvic</th>
      </tr>
    </thead>
    <tbody>
      <%



String SrNo="";
String state="";
String off_name1="";
String kvicedp="";
String kvibedp="";
String dicedp="";
String coir="";
String coiredp="";
String no_ofapp="";
//String noapp="";
String dt="";
String inv_no="";
String inv_date="";
String total_amt="";
String updoc_edp="";
String month_dt="";
String forward_dt="";
String  invupid="0";
String zone="";
//out.print(SOFF_NAME);


 StringBuffer qrysb = new StringBuffer();
 
qrysb.append("    SELECT   "      );
qrysb.append("    mq.srno, mq.state,mq.off_name1, mq.off_cd, mq.zone,sq.invupid, "      );
qrysb.append("    mq.dt, mq.kvicedp,mq.kvibedp, mq.dicedp, mq.coiredp, mq.no_ofapp, "      );
qrysb.append("    sq.inv_no, sq.updoc_edp,sq.total_amt, TO_CHAR(sq.inv_date,'DD-MON-YYYY')inv_date, sq.forward_dt  "      );
qrysb.append("    FROM  ( SELECT  0 AS srno, ms.state_nm      AS state,"      );
qrysb.append("    mom.off_name2 AS OFF_NAME1,mom.mis_off_cd2   AS off_cd,zm.zone_nm       AS zone,"      );
qrysb.append("    to_char(last_day(BSA.inv_date),'DD-MON-RRRR') AS dt,"      );
qrysb.append("    SUM(decode(mom.agency_type, 'KVIC', 1, 0)) AS kvicedp,"      );
qrysb.append("    SUM(decode(mom.agency_type, 'KVIB', 1, 0)) AS kvibedp,"      );
qrysb.append("    SUM(decode(mom.agency_type, 'DIC', 1, 0)) AS dicedp,"      );
qrysb.append("    SUM(decode(mom.agency_type, 'COIR', 1, 0)) AS coiredp,"      );
qrysb.append("    COUNT(*) AS no_ofapp FROM app_detail       ad, "      );
qrysb.append("      mas_off_mast mom,   m_state ms, zone_mast   zm,    "      );
qrysb.append("    m_district    md ,BNF_SAMADHANEDP_APPDETAIL BSA WHERE  ad.app_id = BSA.APP_ID  AND ad.off_cd = mom.off_cd  "      );
qrysb.append("   "      );
qrysb.append("    AND ms.zone_cd = zm.zone_cd  AND md.district_cd = mom.district_cd "      );
qrysb.append("    AND ms.state_cd = md.state_cd AND last_day(trunc(bsa.inv_date)) = ? "      );
qrysb.append("    AND mom.off_type_cd IN (2,3,22,5, 27 ) "      );
qrysb.append("    GROUP BY   ms.state_nm,mom.off_name2,mom.mis_off_cd2,zm.zone_nm, last_day(BSA.inv_date) "      );
qrysb.append("    ) mq,( SELECT  boi.off_cd,boi.inv_no,boi.updoc_edp,boi.total_amt,boi.inv_date,"      );
qrysb.append("    boi.forward_dt ,boi.invupid from  bnf_onlineedp_inf boi "      );
qrysb.append("    WHERE   last_day(trunc(boi.month_dt)) = ? )sq "      );
qrysb.append("    WHERE    mq.off_cd = sq.off_cd (+) order by state   "      );
                                                      
   
 
values.add(vdvDate);
values.add(vdvDate);
  

ResultSet rsMain = db.executeSQL(qrysb.toString(),values);

        	                                                                                                                                             // out.print(qrysb.toString());
	  


	
    int vcount=0;        
  while(rsMain.next())
{
vcount=vcount+1;
off_cd=rsMain.getString("off_cd")==null?"0":rsMain.getString("off_cd");
SrNo=rsMain.getString("SrNo")==null?"":rsMain.getString("SrNo");
state=rsMain.getString("state")==null?"":rsMain.getString("state");
off_name1=rsMain.getString("off_name1")==null?"":rsMain.getString("off_name1");
kvicedp=rsMain.getString("kvicedp")==null?"0":rsMain.getString("kvicedp");
kvibedp=rsMain.getString("kvibedp")==null?"0":rsMain.getString("kvibedp");
dicedp=rsMain.getString("dicedp")==null?"0":rsMain.getString("dicedp");
coiredp=rsMain.getString("coiredp")==null?"0":rsMain.getString("coiredp");
no_ofapp=rsMain.getString("no_ofapp")==null?"0":rsMain.getString("no_ofapp");
dt=rsMain.getString("dt")==null?"":rsMain.getString("dt");
inv_no=rsMain.getString("inv_no")==null?"":rsMain.getString("inv_no");
inv_date=rsMain.getString("inv_date")==null?"":rsMain.getString("inv_date");
total_amt=rsMain.getString("total_amt")==null?"":rsMain.getString("total_amt");
updoc_edp=rsMain.getString("updoc_edp")==null?"":rsMain.getString("updoc_edp");
forward_dt=rsMain.getString("forward_dt")==null?"":rsMain.getString("forward_dt");
invupid=rsMain.getString("invupid")==null?"0":rsMain.getString("invupid");
zone=rsMain.getString("zone")==null?"0":rsMain.getString("zone");
//noapp=0;
noapp = new BigDecimal(no_ofapp);  
sumgtotal = sumgtotal.add(noapp);

 

%>
      <tr>
        <td><%= zone %></td>
        <td><%=state%></td>
        <td><%=off_name1%></td>
        <td><%=dt%></td>
        <td><%=no_ofapp%></td>
        <td><div align="center">
            <%if(forward_dt.equals("")){%>
            <input type="button" name="Submit" class="login100-form-btn" 
		  onClick="upload('<%=off_cd%>','<%=invupid%>',<%=no_ofapp%>);" value="Upload"/>
          </div>
            <% }else { out.print("Data Locked");%>
            <%}%></td>
			<td><%=inv_no%></td>
			<td><%=inv_date%></td>
			<td><%=total_amt%></td>
		   <td><%if(!updoc_edp.equals("")){%>
        <a href="../samadhanedp/otherdocu/<%=updoc_edp%>" class="login100-form-btn">Download</a></button>
              
			
				
                 <%}%></td>
	<td>
	<%if (!updoc_edp.equals("")){%>
	<% if(forward_dt.equals("")){%>
	<input type="button" name="Submit2" class="login100-form-btn" 
		  onClick="forward('<%=invupid %>');" value="forward"/>
              <%}else{%>
		 
	    <%out.print("Forwarded");}%></td>
      </tr>
      <%}%>
	  <%}%>
    </tbody>
  </table>
  
<%
  }// end if
  %>
</form>
<p>&nbsp;</p>
<p>&nbsp;</p>
</body>
</html>


 <SCRIPT language="javascript" src="https://code.jquery.com/jquery-3.5.1.js"></SCRIPT>
 <SCRIPT language="javascript" src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></SCRIPT>
 <script language="javascript">
 $(document).ready(function() {
    $('#example').DataTable();
} );
 </script>
 <SCRIPT>
 
 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("images/loading.gif");
 modalWin.SetCloseButtonImagePath("images/remove.gif");
 //Uncomment below line to make look buttons as link
 modalWin.SetButtonStyle("background:none;border:none;textDecoration:underline;cursor:pointer");
 

function upload(off_cd,dt,no_ofapp){
//alert (off_cd+dt+no_ofapp);
var callbackFunctionArray = new Array(refreshpage);
modalWin.ShowURL("UploadEDP.jsp?off_cd="+off_cd+"&invupid="+dt+"&no_ofapp="+no_ofapp,700,700,'CERTIFICATE',callbackFunctionArray,null);
 } 
 


function forward (off_cd){
//alert (off_cd+dt+no_ofapp);
var callbackFunctionArray = new Array(refreshpage);
modalWin.ShowURL("forward.jsp?invupid="+off_cd,600,800,'Forwarded To KVIC Office',callbackFunctionArray,null);
 } 
 
function EnrollNow(msg){
modalWin.HideModalPopUp();
modalWin.ShowMessage(msg,200,400,'User Information',null,null);
}

function EnrollLater(){
modalWin.HideModalPopUp();
modalWin.ShowMessage(msg,200,400,'User Information',null,null);
}

function HideModalWindow() {
    modalWin.HideModalPopUp();
}

function refreshpage(){
form.submit();
}

 </SCRIPT>

