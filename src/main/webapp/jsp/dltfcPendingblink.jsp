<%@ page contentType="text/html; charset=iso-8859-1"  language="java" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,claimPackage.DBCon,pkgPmegpNew.DBCon" %>

<html>
<head>
<link rel="stylesheet" href="css/rop.css">
<script type="text/javascript" src="js/inlinemessages.js"></script>
<script type="text/javascript" src="../js/popcalendar.js"></script>

<script language="JavaScript">
function SubmitForm() {
	CHQ_NO =document.upform.CHQ_NO.value;  
	CHQ_DT =document.upform.CHQ_DT.value; 
	
	 var onlyNumber = /^\d+$/; 
  
   if  (CHQ_DT=="") {
  inlineMsg('CHQ_DT','Enter Cheque Date in dd-mmm-yyyy (Ex:01-APR-2016)',2);
    return false;
  }
  
   if  (CHQ_NO=="") {
  inlineMsg('CHQ_NO','Please Enter Cheque No',2);
    return false;
  }
 
  if  (Number(CHQ_NO.length) <6) {
  inlineMsg('CHQ_NO','Cheque No Should not Less then 6 digit',2);
    return false;
  }
 
   if  (CHQ_NO=="") {
  inlineMsg('CHQ_NO','Please Enter Cheque No',2);
    return false;
  }
  
   if  (!onlyNumber.test(CHQ_NO)) {
  inlineMsg('CHQ_NO','Only Number Should be entered.....',2);
    return false;
  }
  
 document.upform.ins.value='I';
 document.upform.submit();
 //alert ('hiiiii')
 // EnrollLaterClick();
}//end of function


</script>


<style type="text/css">
<!--
.style1 {font-size: 18px}
-->
</style>
</head>

<form id="upform" name="upform"  method="post">
    
<%



String [] vBillid=request.getParameterValues("billid");
if (vBillid == null) {
out.print ("<center><h1> No Bill Has been Selected..............<br> <br> Please Select Bill NO...........</h1></center>");
}else{
String vwhercls ="";
 DBCon db= new DBCon();
 db.connect(); 


if (vBillid != null && vBillid.length != 0) {
for (int i = 0; i < vBillid.length; i++) {
vwhercls=vBillid[i]+","+vwhercls ; 
}//end of for loop


vwhercls=vwhercls+"1000000000000";


}//end of if



//out.print (vwhercls);


String STAT_ID="8";
	
	
String CLAIM_APPROVED = "";
String CO_BATCH_ID = "";
String CHQ_REC_DT = "";
String CHQ_NO = "";
String CHQ_DT = "";
String CHQ_BID ="";

	
	 StringBuffer qrysb = new StringBuffer();
qrysb.append("SELECT MA.CO_BATCH_ID , SUM( nvl(RECOM_AMT,0)) AS CLAIM_APPROVED  from  ");
 qrysb.append(" MDA_ADDINFO MA, MAS.MH_BENEFICIARY MB,  MDA_PERIOD MP, MDA_RECOM_SO MR, MAS.OFF_MAST OM ");
 qrysb.append(" WHERE MB.BEN_CD=ma.BEN_CD AND MP.PER_ID=MA.PER_ID AND MA.STAT_ID between 8  and 9 AND MA.CLAIM_ID=MR.CLAIM_ID AND OM.OFF_CD=MB.REG_OFF_CD ");
 qrysb.append("  AND MA.CO_BATCH_ID IN ("+vwhercls+") GROUP BY  MA.CO_BATCH_ID,OM.OFF_NAME ,MA.CO_BATCH_ID");	 
	 
ResultSet rs = db.execSQL(qrysb.toString());
    
	%>
<table border="1" align="center">
               <tr>
                 <th colspan="5"><div align="center">MDA Claims  Selected for Payment 
                     <input name="ins" type="hidden" id="ins" value="">
                 </div></th>
               <tr>
                 <th>Sr No. </th>
                 <th>Pay Order No.</th>         
	             <th>Payable Amount( in Rs.) </th>
				<%
	 String c="";
	 int cnt=0;
	  BigDecimal vPayAmtTotal= new BigDecimal("0");
	 while (rs.next()){

	 cnt=cnt+1;
	 
CLAIM_APPROVED=rs.getString("CLAIM_APPROVED")==null?"":rs.getString("CLAIM_APPROVED");
CO_BATCH_ID=rs.getString("CO_BATCH_ID")==null?"":rs.getString("CO_BATCH_ID");

vPayAmtTotal=vPayAmtTotal.add(new BigDecimal(CLAIM_APPROVED)); 
	 %>
	 <tr>
	   <td ><%= cnt %></td>
         <td ><%= CO_BATCH_ID  %></td>  
   <td ><div class="redLebel">
    <div align="right"><%=new BigDecimal(CLAIM_APPROVED) %></div>
  </div></td>
  </tr>
	<%}
   rs.close();
 
   %> 	
   
    <tr>
      <th colspan="5" >&nbsp;</th>
    </tr>
    <tr>
      <th colspan="3" ><div class="number">
        <div align="right" class="GreenLebel">Total Cheque Amount Rs.: </div>
      </div></th>
      <td bordercolor="#000066" ><div align="right" class="GreenLebel"><%= vPayAmtTotal %></div></td>
      <th >&nbsp;</th>
    </tr>
    
    <tr>
	   <th colspan="3" nowrap >Enter Cheque Date:
       <input name="CHQ_DT" type="text" class="input_text" id="CHQ_DT" value="<%=CHQ_DT %>" size="12" maxlength="12" placeholder="DD-MON-YYYY" onClick="scwShow(this,event);"></th>
      <th nowrap ><input name="CHQ_NO" type="text" class="input_text" id="CHQ_NO" value="<%= CHQ_NO %>" size="30" maxlength="50"></th>
  <th nowrap >&nbsp;</th>
  </tr>
    <tr>
      <th colspan="5" nowrap ><div align="center">
        <input name="Button" type="button" class="button" value="Process for Payment" onClick="SubmitForm();">
      </div></th>
    </tr> 
</table>
<%

 if ((String)request.getParameter("ins")!=null){
  
  try {
  List values=new ArrayList();
List pstm=new ArrayList();
CHQ_NO=(String)request.getParameter("CHQ_NO")==null?"":(String)request.getParameter("CHQ_NO").trim();
CHQ_DT=(String)request.getParameter("CHQ_DT")==null?"":(String)request.getParameter("CHQ_DT").trim();


ResultSet rsMax = db.execSQL("SELECT SEQMDACHEQUEBATCHID.nextval AS CHQ_BID from dual");

while (rsMax.next()) {
CHQ_BID= rsMax.getString(1);
}


String vqry="UPDATE MDA_ADDINFO SET STAT_ID=11,AC_DISB_DT=SYSDATE,CHQ_NO=?,CHQ_DT=?,CHQ_BID=? WHERE CO_BATCH_ID IN ("+vwhercls+")";

 
values.add (CHQ_NO);pstm.add ("L");
values.add (CHQ_DT);pstm.add ("L");
values.add (CHQ_BID);pstm.add ("L");

db.setSqlValue( vqry);
db.setValues(values,pstm);
db.executeUpdate() ;
 values.clear();
  pstm.clear();
  
response.sendRedirect("calldbtProc.jsp?CHQ_BID="+CHQ_BID);

}catch (Exception e){
out.print (e.toString());

}
  
  
  }//end of ins.
  
db.close();

%>
</form>
<% } %>
</html>