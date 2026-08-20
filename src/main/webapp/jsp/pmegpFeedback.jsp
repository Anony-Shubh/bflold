<%@ include file="appIncludeHeaderPage.jsp" %>
		
<SCRIPT>

function submitform(){
document.form.ins.value='I';
document.form.submit();
	
}

 function blockSpecialChar(e) {
var k;
document.all ? k = e.keyCode : k = e.which;
return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32 ||  (k >= 48 && k <= 57) || k == 190 || k == 188);
//return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32 ||  (k >= 48 && k <= 57) || k == 190 || k == 188);
}

</SCRIPT>


</HEAD>
<BODY>

<FORM name="form" id="form"  class="form" method="post">

<%
	String APP_ID=  (String) session.getAttribute("sAPP_ID");
		String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");
String FB_BEFORE_LOAN = "";
String FB_AFT_SETTING_UNIT = "";
String FB_IMPRV_SUGG = "";
String MM_REL_AMT="0";

String APP_NAME="";
String MF_APP_ID="";


String ACT_YN = "";
String update="";
String SUCCMSG = request.getParameter("SUCCMSG")==null?"N":(String) request.getParameter("SUCCMSG");

DBCon db= new DBCon();
db.connect();
List values=new ArrayList();	
List pstm=new ArrayList();

StringBuffer qrysb = new StringBuffer();


qrysb.append("   SELECT"      );
qrysb.append("       kd.app_id,"      );
qrysb.append("       kd.app_name,"      );
qrysb.append("       kd.mm_rel_amt,"      );
qrysb.append("       kd.mm_rel_dt,"      );
qrysb.append("       kd.utrn_no,"      );
qrysb.append("       kd.fb_aft_setting_unit,"      );
qrysb.append("       kd.fb_imprv_sugg,"      );
qrysb.append("       kd.act_yn,"      );
qrysb.append("       kd.mf_app_id,"      );
qrysb.append("       kd.fb_before_loan"      );
qrysb.append("   FROM"      );
qrysb.append("       ("      );
qrysb.append("           SELECT"      );
qrysb.append("               bd.app_id,"      );
qrysb.append("               ad.app_name,"      );
qrysb.append("               bd.mm_rel_amt,"      );
qrysb.append("               TO_CHAR(bd.mm_rel_dt, 'DD-MON-RRRR') AS mm_rel_dt,"      );
qrysb.append("               bd.utrn_no,"      );
qrysb.append("               mf.fb_before_loan,"      );
qrysb.append("               mf.fb_aft_setting_unit,"      );
qrysb.append("               mf.fb_imprv_sugg,"      );
qrysb.append("               mf.act_yn,"      );
qrysb.append("               mf.app_id AS mf_app_id,"      );
qrysb.append("               mf.time_stamp"      );
qrysb.append("           FROM"      );
qrysb.append("               app_detail               ad,"      );
qrysb.append("               bank_dataentry           bd,"      );
qrysb.append("               msme_feedback_form_one   mf"      );
qrysb.append("           WHERE"      );
qrysb.append("               ad.app_id = bd.app_id"      );
qrysb.append("               AND bd.app_id = mf.app_id (+)"      );
qrysb.append("               AND bd.pact_id = 34"      );
qrysb.append("               AND ad.app_id = ?"      );
qrysb.append("       ) kd"      );
qrysb.append("   WHERE"      );
qrysb.append("       kd.app_id = ? "      );



 values.add (APP_ID); 
  values.add (APP_ID); 
 ResultSet rsSmast = db.executeSQL(qrysb.toString(),values); 
 
 
		values.clear();	  
  while (rsSmast.next()) {
  
APP_ID=rsSmast.getString("APP_ID")==null?"":rsSmast.getString("APP_ID");
FB_BEFORE_LOAN=rsSmast.getString("FB_BEFORE_LOAN")==null?"":rsSmast.getString("FB_BEFORE_LOAN");
FB_AFT_SETTING_UNIT=rsSmast.getString("FB_AFT_SETTING_UNIT")==null?"":rsSmast.getString("FB_AFT_SETTING_UNIT");
FB_IMPRV_SUGG=rsSmast.getString("FB_IMPRV_SUGG")==null?"":rsSmast.getString("FB_IMPRV_SUGG");
ACT_YN=rsSmast.getString("ACT_YN")==null?"":rsSmast.getString("ACT_YN");
 APP_NAME=rsSmast.getString("APP_NAME")==null?"":rsSmast.getString("APP_NAME");
 MF_APP_ID=rsSmast.getString("MF_APP_ID")==null?"":rsSmast.getString("MF_APP_ID");
 
 MM_REL_AMT=rsSmast.getString("MM_REL_AMT")==null?"0":rsSmast.getString("MM_REL_AMT");
 
update=MF_APP_ID.equals("")?"":"UPDT";
  }
rsSmast.close();

%>

<% if  ( !MM_REL_AMT.equals("0") ) {%>
<INPUT name="ins" type="hidden" id="ins" value=""  />
     <DIV align="center"></DIV>

<TABLE  align="center" border="1" width="70%">

  <TR>
    <TH colspan="2"><span class="style4"><h1>Feedback from PMEGP Beneficiary for impprovement in PMEGP Scheme</h1></span></TH>
    </TR>
  <TR>
    <TH>(1)</TH>
    <TH><DIV align="left"><h1>Name of the Beneficiary :<%= APP_NAME %> </h1></DIV></TH>
    </TR>
  
  
  <TR>
    <TH>(2)</TH>
    <TH><div align="left"><h1> PMEGP Application ID : <%= APP_ID %></h1></div></TH>
    </TR>
  <TR>
    <TH>3)</TH>
    <TH><DIV align="left">Which are the major problems faced by you before getting the loan and after setting up of the units under PMEGP particularly in terms of use of Technology, Market Access, and Availability of Finance.  </DIV></TH>
    </TR>
  
  <TR>
    <TH>&nbsp;</TH>
    <TH>Note: Except full stop and comma no special character are allowed </TH>
    </TR>
  <TR>
    <TH>(a)</TH>
    <TH><div align="left"><h1>Before getting the loan (up to 1000 characters) </h1></div></TH>
    </TR>
  <TR>
    <TH>&nbsp;</TH>
    <TH><div align="left">
      <textarea rows="4" cols="50" name="FB_BEFORE_LOAN" id="FB_BEFORE_LOAN" onKeyPress="return blockSpecialChar(event)"  maxlength="999"><%= FB_BEFORE_LOAN %></textarea>
    </div></TH>
    </TR>
  <TR>
    <TH>(b)</TH>
    <TH><div align="left"><h2>After Setting up of the unit (up to 1000 characters) </h2></div></TH>
    </TR>
  <TR>
    <TH>&nbsp;</TH>
    <TH><div align="left">
      <textarea rows="4" cols="50" name="FB_AFT_SETTING_UNIT" id="FB_AFT_SETTING_UNIT" maxlength="999"> <%= FB_AFT_SETTING_UNIT %></textarea>
    </div></TH>
    </TR>
  <TR>
    <TH>(4)</TH>
    <TH><div align="left"><h1>Please provide suggestions for making further improvement in PMEGP Scheme for setting up of Successful Enterprises (up to 1000 characters) </h1></div></TH>
    </TR>
  <TR>
    <TH>&nbsp;</TH>
    <TH><textarea rows="4" cols="50" name="FB_IMPRV_SUGG" id="FB_IMPRV_SUGG"  maxlength="999"><%= FB_IMPRV_SUGG %></textarea></TH>
  </TR>
  <TR>
    <TH>&nbsp;</TH>
    <TH>
      <div align="center">
        <INPUT name="BtnSave" type="button" class="buttongrey" id="BtnSave" onClick="submitform();" value="Save Data">
      </div></TH>
    </TR>
</TABLE>
<DIV align="center"><BR>
       <%
   if (ins.equals("I")){

//APP_ID=(String) request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID").trim();
FB_BEFORE_LOAN=(String) request.getParameter("FB_BEFORE_LOAN")==null?"":(String) request.getParameter("FB_BEFORE_LOAN").trim();
FB_AFT_SETTING_UNIT=(String) request.getParameter("FB_AFT_SETTING_UNIT")==null?"":(String) request.getParameter("FB_AFT_SETTING_UNIT").trim();
FB_IMPRV_SUGG=(String) request.getParameter("FB_IMPRV_SUGG")==null?"":(String) request.getParameter("FB_IMPRV_SUGG").trim();

StringBuffer qryUpdate = new StringBuffer();


if ( !update.equals("UPDT") ) {

out.print ("I");
		      
qryUpdate.append(" INSERT INTO MSME_FEEDBACK_FORM_ONE ");
qryUpdate.append("(");
qryUpdate.append("FB_BEFORE_LOAN,");
qryUpdate.append("FB_AFT_SETTING_UNIT,");
qryUpdate.append("FB_IMPRV_SUGG,");


qryUpdate.append("APP_ID)");


qryUpdate.append("  VALUES (?,?,?,?)");
}else{
out.print ("U");
qryUpdate.append(" UPDATE MSME_FEEDBACK_FORM_ONE SET  ");
qryUpdate.append("FB_BEFORE_LOAN=?,");
qryUpdate.append("FB_AFT_SETTING_UNIT=?,");
qryUpdate.append("FB_IMPRV_SUGG=?");
qryUpdate.append("WHERE APP_ID=?");


}
values.add(FB_BEFORE_LOAN); pstm.add ("L");
values.add(FB_AFT_SETTING_UNIT); pstm.add ("L");
values.add(FB_IMPRV_SUGG); pstm.add ("L");
values.add(APP_ID); pstm.add ("L");


//FIN_YR
try{
db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate() ;
values.clear();
pstm.clear();

db.close();
response.sendRedirect("pmegpFeedback.jsp?SUCCMSG=Y");
}catch(Exception e){
out.print(e.toString());
}

}//ins

		

if(SUCCMSG.equals("Y")){
 %>
<center>
<DIV align="center" class="success" style="width:40%">Updated Successfully...</DIV>
<% } %>


       
  </DIV>


    
  </div>
</FORM>
</BODY>

<SCRIPT language="javascript">
 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("images/loading.gif");
 modalWin.SetCloseButtonImagePath("images/remove.gif");
 
</SCRIPT>

</HTML>
<% } else {

out.print ("<center><h1>MSME feedback is for those applicants whose margin Money Released.....</h1></center>");

}
 %>