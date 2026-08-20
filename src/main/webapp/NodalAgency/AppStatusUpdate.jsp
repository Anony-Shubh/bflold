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

<html>
<head>
<title>PMEGP Agency Status Update Form</title>
<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<link rel="stylesheet" type="text/css" href="../css/styleradiobutton.css" />
<script type="text/javascript" src="../js/inlineMsgMain.js"></script>
<script language="javascript" src="../js/jquery-1.12.0.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script language="javascript">
function valid_ts() {
	var ACT_ID = document.form.ACT_ID.value; 
	
                if (ACT_ID == "32")
				{
                    $('#VALID').show();
				}				
				else
				{
					
					 $('#VALID').hide();
				
				}
				
				

            
}












$(document).ready(function(){
    $('.check').click(function() {
        $('.check').not(this).prop('checked', false);
    });
});


$(document).ready(function() {
    var text_max = 200;
    $('#textarea_feedback').html(text_max + ' characters remaining');
    $('#CO_REMARKS').keyup(function() {
        var text_length = $('#CO_REMARKS').val().length;
        var text_remaining = text_max - text_length;
        $('#textarea_feedback').html(text_remaining + ' characters remaining');
    });
});


	
function submit_form () {
var ACT_ID=document.form.ACT_ID.value;
var CO_REMARKS=document.form.CO_REMARKS.value;

if(ACT_ID == "") {
    inlineMsg('ACT_ID','Select Status',5);
    return false;
  }
  
  if(CO_REMARKS == "") {
    inlineMsg('CO_REMARKS','Enter Remarks.........',5);
    return false;
  }
  
 document.form.ins.value='I'; 
 document.form.submit()
}
</script>
<style type="text/css">
<!--
.style2 {color: #A0A0A0}
-->
</style>
</head>
<body>
<form   name="form" id ="form" method="post" >
<%

String  APP_ID =request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID");

String OFF_CD = (String) session.getAttribute("sOffCd");
String AGENCY_TYPE = "";
String OFF_NAME = "";
String APP_NAME = "";
String AADHAR_NO = "";
String BR_IFSL_CODE = "";
String APPLOAN_ACCNO = "";
String BR_NAME = "";
String BRANCH_NAME = "";
String MM_CLAIM_DT = "";
String MM_CLAIM_AMT = "";
String FB_ACNO = "";
String LOAN_DOCFNAME="";
String USER_ID = session.getAttribute("SUSER_ID")==null?"":(String) session.getAttribute("SUSER_ID");
String USER_TYPE = session.getAttribute("SUSER_TYPE")==null?"":(String) session.getAttribute("SUSER_TYPE");
String ACT_ID="";
String CO_REMARKS="";

String VALID_RS="";




DBCon db= new DBCon();
db.connect();
StringBuffer qrysb= new StringBuffer();

qrysb.append("   SELECT MOM.AGENCY_TYPE,"      );
qrysb.append("     MOM.OFF_NAME,"      );
qrysb.append("     AD.APP_ID,"      );
qrysb.append("     AD.APP_NAME,"      );
qrysb.append("     AD.AADHAR_NO,"      );
qrysb.append("     BBM.BR_IFSL_CODE,"      );
qrysb.append("     BD.APPLOAN_ACCNO,"      );
qrysb.append("     BBM.BR_NAME,"      );
qrysb.append("     BBM.BRANCH_NAME,"      );
qrysb.append("     TO_CHAR(BD.MM_CLAIM_DT,'DD-MON-RRRR') AS MM_CLAIM_DT,"      );
qrysb.append("     BD.MM_CLAIM_AMT,"      );
qrysb.append("     BD.FB_ACNO,BD.LOAN_DOCFNAME"      );
qrysb.append("   FROM BANK_DATAENTRY BD,"      );
qrysb.append("     APP_DETAIL AD,"      );
qrysb.append("     BANK_BR_MAST BBM,"      );
qrysb.append("     MAS_OFF_MAST MOM"      );
qrysb.append("   WHERE AD.APP_ID       = BD.APP_ID"      );
qrysb.append("   AND BD.IFSC_CODE      = BBM.BR_IFSL_CODE"      );
qrysb.append("   AND AD.OFF_CD         = MOM.OFF_CD"      );
qrysb.append("   AND BD.MM_CLAIM_AMT   > 0");
qrysb.append("   AND BD.LOAN_DOCFNAME IS NOT NULL AND BD.APP_ID=?");


List valuesq = new ArrayList();
valuesq.add(APP_ID);

   ResultSet rsMain  = db.executeSQL(qrysb.toString(),valuesq);
   valuesq.clear();

while (rsMain .next()){
AGENCY_TYPE=rsMain.getString("AGENCY_TYPE")==null?"":rsMain.getString("AGENCY_TYPE");
OFF_NAME=rsMain.getString("OFF_NAME")==null?"":rsMain.getString("OFF_NAME");
APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");
APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
AADHAR_NO=rsMain.getString("AADHAR_NO")==null?"":rsMain.getString("AADHAR_NO");
BR_IFSL_CODE=rsMain.getString("BR_IFSL_CODE")==null?"":rsMain.getString("BR_IFSL_CODE");
APPLOAN_ACCNO=rsMain.getString("APPLOAN_ACCNO")==null?"":rsMain.getString("APPLOAN_ACCNO");
BR_NAME=rsMain.getString("BR_NAME")==null?"":rsMain.getString("BR_NAME");
BRANCH_NAME=rsMain.getString("BRANCH_NAME")==null?"":rsMain.getString("BRANCH_NAME");
MM_CLAIM_DT=rsMain.getString("MM_CLAIM_DT")==null?"":rsMain.getString("MM_CLAIM_DT");
MM_CLAIM_AMT=rsMain.getString("MM_CLAIM_AMT")==null?"":rsMain.getString("MM_CLAIM_AMT");
FB_ACNO=rsMain.getString("FB_ACNO")==null?"":rsMain.getString("FB_ACNO");
LOAN_DOCFNAME=rsMain.getString("LOAN_DOCFNAME")==null?"":rsMain.getString("LOAN_DOCFNAME");
}

rsMain .close();
%>
  <div>
  <table align="center">
    <tr>
      <th colspan="4"><div align="center">PMEGP PHYSICAL VERIFICATION UNIT AT CENTRAL OFFICE
         
      </div></th>
    </tr>
    <tr>
      <th><div align="right">
          <input name="ins" type="hidden" id="ins">
      Applicant Id : </div></th>
      <th><%=APP_ID %> </th>
      <th><div align="right">Name Of Applicant :</div></th>
      <th><%=  APP_NAME %></th>
    </tr>
    <tr valign="middle">
      <th><div align="right">Agency Name(<%= AGENCY_TYPE %>): </div></th>
      <th colspan="3" nowrap ><%= OFF_NAME %></th>
    </tr>
    <tr valign="middle">
      <th><div align="right">Bank IFS Code: </div></th>
      <th nowrap ><%= BR_IFSL_CODE %></th>
      <th nowrap ><div align="right">Transient A/c No:</div></th>
      <th nowrap ><%= FB_ACNO %></th>
    </tr>
    <tr valign="middle">
      <th><div align="right">Bank Address:</div></th>
      <th colspan="3" nowrap ><%= BR_NAME %><br>
        <%= BRANCH_NAME %></th>
    </tr>
    <tr valign="middle">
      <th><div align="right">Margin Money Claim Amount: </div></th>
      <th nowrap ><%= MM_CLAIM_AMT %></th>
      <th nowrap ><div align="right">Claim Date:</div></th>
      <th nowrap ><%= MM_CLAIM_DT %></th>
    </tr>
    <tr valign="middle">
      <th rowspan="3"><div align="right">Select Current Status: * </div></th>
      <td colspan="3" nowrap ><input name="ACT_ID" id="ACT_ID" type="radio"  value="32" onChange="valid_ts();">
        <span class="GreenLebel">Recommended for MM Disbursement </span> </td>
    </tr>
    <tr>
      <td colspan="3"><input name="ACT_ID" id="option" type="radio"  value="30" onChange="valid_ts();">        
      <span class="OrangeLebel">To be referred to Implementing Agenc</span><span class="redLebel">y</span></td>
    </tr>
    <tr>
      <td colspan="3"><input name="ACT_ID" type="radio" disabled="true" id="ACT_ID"  value="31">
      <span class="redLebel">      To be returned to Financing Bank</span></td>
    </tr>
	     <tr id="VALID" style="display: none">
   
      <th>Recommended  Subject to  : </th>
      <td nowrap><input type="checkbox"  name="VALID_RS" class="check" value="EDP">
        EDP <span class="GreenLebel"></span> </td>
      <td nowrap ><input type="checkbox" name="VALID_RS" class="check" value="ADH">
        AADHAR CARD <span class="GreenLebel"></span> </td>
      <td nowrap ><input type="checkbox" name="VALID_RS"  class="check" value="EMP">
        EMPLOYEMENT <span class="GreenLebel"></span> </td>
      <td nowrap ><input type="checkbox" name="VALID_RS"  class="check" value="OTH">
        OTHERS</td>
    </tr>
	
	
	
    <tr>
      <th colspan="4"><div align="center">Remarks (if Any) (Maximum 200 Charcters including space) </div></th>
    </tr>
    <tr>
      <td colspan="4"><div align="center">
        <textarea name="CO_REMARKS" cols="40" rows="5" class="mtextarea" id="CO_REMARKS"></textarea>
      </div></td>
    </tr>
    <tr>
      <td colspan="4"><div align="center">
        <input name="btnSubmit" type="button" class="button" id="btnSubmit"  onClick="submit_form();" value="Submit">
      </div></td>
    </tr>
  </table>
  
  <%
  String refqry=  " SELECT MRT.CO_REMARKS AS CO_REMARKS1, TO_CHAR(trunc(MRT.PROC_DT),'DD-MON-RRRR') AS PROC_DT1 FROM MM_REMARKS_TRANS MRT,BANK_DATAENTRY BD WHERE BD.PACT_ID IN (30) ";
			refqry =refqry+ " AND MRT.APP_ID=BD.APP_ID AND BD.PACT_ID=MRT.PACT_ID AND BD.IFSC_CODE=MRT.IFSC_CODE AND MRT.APP_ID='"+APP_ID+"' GROUP BY  MRT.CO_REMARKS,MRT.PROC_DT  ";
			refqry =refqry+ " ";

			String CO_REMARKS1="";
			String PROC_DT1="";
			ResultSet rsRef = db.execSQL(refqry);
			while ( rsRef.next()) {
			CO_REMARKS1 =rsRef.getString("CO_REMARKS1");
			PROC_DT1 =rsRef.getString("PROC_DT1");
			out.print("<u><H3>Process Date: "+PROC_DT1+"</H3></u> :");
			out.print("<H2>Remarks "+CO_REMARKS1+"</H2>");
			
			}
			rsRef.close();
			
if ((String)request.getParameter("ins")!=null){
try {
String REMTR_ID="";
ACT_ID=(String) request.getParameter("ACT_ID")==null?"":(String) request.getParameter("ACT_ID").trim();
CO_REMARKS=(String) request.getParameter("CO_REMARKS")==null?"":(String) request.getParameter("CO_REMARKS").trim();
VALID_RS=(String) request.getParameter("VALID_RS")==null?"":(String) request.getParameter("VALID_RS").trim();
List values=new ArrayList();
List pstm=new ArrayList();
StringBuffer qryUpdate = new StringBuffer();
  ResultSet rsMax = db.execSQL(" SELECT MMPROCREMSEQ.NEXTVAL FROM DUAL ");
  while (rsMax.next()){
  REMTR_ID=rsMax.getString(1);
  }
  rsMax.close();
  
qryUpdate.append("  INSERT INTO  MM_REMARKS_TRANS (REMTR_ID,PROC_DT,USER_TYPE,PACT_ID,CO_REMARKS,APP_ID,IFSC_CODE,USER_ID,VALID_RS) ");
qryUpdate.append(" values (?,SYSDATE,?,?,?,?,?,?,?) ");

values.clear();
pstm.clear();

values.add(REMTR_ID); pstm.add ("L");
values.add(USER_TYPE); pstm.add ("L");
values.add(ACT_ID); pstm.add ("L");
values.add(CO_REMARKS); pstm.add ("L");
values.add(APP_ID); pstm.add ("L");
values.add(BR_IFSL_CODE); pstm.add ("L");
values.add(USER_ID); pstm.add ("L");
values.add(VALID_RS); pstm.add ("L");


db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate() ;
values.clear();
pstm.clear();

String Updt= "UPDATE BANK_DATAENTRY SET REMTRID=?, PACT_ID=? ,APPRV_YN='S' WHERE APP_ID=? AND IFSC_CODE=? ";
values.add(REMTR_ID); pstm.add ("L");
values.add(ACT_ID); pstm.add ("L");
values.add(APP_ID); pstm.add ("L");
values.add(BR_IFSL_CODE); pstm.add ("L");
db.setSqlValue(Updt);
db.setValues(values,pstm);
db.executeUpdate() ;
values.clear();
pstm.clear();
db.close();
response.sendRedirect("savemsg.jsp");

}catch (Exception e) {out.print (e.toString());}
}

%>

</form>
</body>
</html>
