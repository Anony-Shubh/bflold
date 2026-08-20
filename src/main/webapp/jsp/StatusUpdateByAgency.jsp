<%@ page session="true"  import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="cdacuidai.VerifyAadhaarByID"%>
<%
response.setContentType("text/html");
response.setHeader("Cache-control","no-cache");
response.setHeader("Cache-control","private");
%>

<%
String vOffcd= (String) session.getAttribute("off_cd");
String vUserID="";
if  (session.getAttribute("user_id") !=null){
vUserID=(String)session.getAttribute("user_id");

}

if (vUserID.equals("")){
response.sendRedirect("AgencyloginPageNew.jsp");
}
DBCon db= new DBCon();
db.connect();

StringBuffer av= new StringBuffer();

String  APP_ID =request.getParameter("APP_ID")==null?"":(String)request.getParameter("APP_ID");
String adhvalid="F";

try {
VerifyAadhaarByID v= new VerifyAadhaarByID();	
adhvalid=v.VerifyAad(APP_ID, "AG");
}catch (Exception e) {}
//out.print(adhvalid);

String CLIENT_IP= (String)session.getAttribute("SCLIENTIP") ;
String APP_NAME="";
String APP_REC_DATE="";
String MT_DATE="";
String REMARKS="";
String MOB_NO1="";
String MTG_ID="";
String TIME_STAMP="";
String ACT_ID="";
String E_MAIL="";
String ONLINE_SUBDT="";
String MOB_NO2="";
String TODAYDT="";
String FORD_DT_DLTFC="";
String MSG="";
String MTGIDTE="-1";
String SCOREVALID="N";
String REJ_ID="";
String AADHAR_NO="";
String GENDER="";
String DOB="";


int TOTAL_SCORE=0;

av.append(" SELECT ad.APP_ID, ad.REJ_ID, FUN_LOCKUPDATE_REJ(ad.APP_ID) AS MSG, TO_CHAR(AD.ONLINE_SUBDT,'DD-MON-RRRR HH:MM:SS') AS ONLINE_SUBDT, ").
 append(" ad.APP_NAME,ad.MOB_NO1, ad.MTG_ID,TO_CHAR(AD.ONLINE_SUBDT, 'DD-MON-RRRR') AS APP_REC_DATE, TO_CHAR(SYSDATE,'DD-MON-RRRR') AS TODAYDT, TO_CHAR(FORD_DT_DLTFC,'DD-MON-RRRR') AS FORD_DT_DLTFC ,TO_CHAR(ad.DOB,'DD-MON-RRRR') AS DOB, ad.AADHAR_NO,ad.GENDER, ").
 append(" ad.ACT_ID,ad.E_MAIL,ad.REMARKS , NVL( (SELECT TOTAL_SCORE FROM PMEGP_SCORE_CARD PSC WHERE PSC.APP_ID=AD.APP_ID),0) AS TOTAL_SCORE,FUNC_SCORECARDVALIDATION(AD.APP_ID) AS SCOREVALID  FROM app_detail ad ").
append(" WHERE ad.APP_ID = '"+APP_ID+"'");
ResultSet rsApp = db.execSQL(av.toString());

while (rsApp.next()){
APP_NAME=rsApp.getString("APP_NAME")==null?"":rsApp.getString("APP_NAME");
 APP_REC_DATE=rsApp.getString("APP_REC_DATE")==null?"":rsApp.getString("APP_REC_DATE");
 REMARKS=rsApp.getString("REMARKS")==null?"":rsApp.getString("REMARKS");
 MOB_NO1=rsApp.getString("MOB_NO1")==null?"":rsApp.getString("MOB_NO1");
MTG_ID=rsApp.getString("MTG_ID")==null?"":rsApp.getString("MTG_ID");
ACT_ID=rsApp.getString("ACT_ID")==null?"":rsApp.getString("ACT_ID");
E_MAIL=rsApp.getString("E_MAIL")==null?"":rsApp.getString("E_MAIL");
ONLINE_SUBDT=rsApp.getString("ONLINE_SUBDT")==null?"":rsApp.getString("ONLINE_SUBDT");
FORD_DT_DLTFC=rsApp.getString("FORD_DT_DLTFC")==null?"":rsApp.getString("FORD_DT_DLTFC");
TODAYDT=rsApp.getString("TODAYDT")==null?"":rsApp.getString("TODAYDT");
MSG=rsApp.getString("MSG")==null?"":rsApp.getString("MSG");
SCOREVALID=rsApp.getString("SCOREVALID")==null?"":rsApp.getString("SCOREVALID");
REJ_ID=rsApp.getString("REJ_ID")==null?"":rsApp.getString("REJ_ID");
 GENDER=rsApp.getString("GENDER")==null?"":rsApp.getString("GENDER");
   AADHAR_NO=rsApp.getString("AADHAR_NO")==null?"":rsApp.getString("AADHAR_NO");
  DOB = rsApp.getString("DOB")==null?"":rsApp.getString("DOB");

TOTAL_SCORE=rsApp.getInt("TOTAL_SCORE");

}

rsApp.close();
%>

<HTML>
<HEAD>
<TITLE>PMEGP Agency Status Update Form</TITLE>
<LINK rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<SCRIPT language="javascript" src="../js/inlineMsgMain.js"></SCRIPT>
<SCRIPT language="javascript">

 function Checkradiobutton()
 {
   var ACT_ID=form.elements["ACT_ID"].value;
  // alert(ACT_ID);
 // if(document.getElementById('ACT_ID1').checked || document.getElementById('ACT_ID3').checked)
 if ((ACT_ID == "1") || (ACT_ID == "4") || (ACT_ID == "0"))
 {

        document.getElementById('REJ_ID').disabled=true; 
		document.getElementById("REJ_ID").value = '';
   }
   if (ACT_ID == "3"){
 // if(document.getElementById('ACT_ID2').checked ){
   //alert("hello");
                    document.getElementById('REJ_ID').disabled = false;
                }
 }


function submit_form() {
//var ID1 = document.form.ACT_ID.value; 
var ACT_ID=form.elements["ACT_ID"].value;

var REMARKS = document.form.REMARKS.value; 
var REJ_ID = document.form.REJ_ID.value; 
//alert(ACT_ID);
if(ACT_ID == "0") {
   alert("Please Select Status");
    return false;
  }

 if(ACT_ID == "3") {
   
  if(REJ_ID == "") {
    inlineMsg('REJ_ID','Select Rejection Reason.........',2);
    return false;
  }
   
  } 
  if(REMARKS == "") {
    inlineMsg('REMARKS','Enter Remarks',2);
    return false;
  }
 
    document.form.ins.value='I'; 
              document.form.submit()
			   
}

</SCRIPT>
</HEAD>
<BODY onLoad="Checkradiobutton()">
<FORM  method="post" name="form" id="form">


<% if(MSG.equals("U")){%>

<INPUT name="TOTAL_SCORE" type="hidden" id="TOTAL_SCORE" value="<%= TOTAL_SCORE %>">

  <TABLE align="center">
    <TR>
      <TH colspan="4"><DIV align="center">APPLICANT CURRENT STATUS UPDATE FORM BY AGENCY </DIV></TH>
    </TR>
    <TR>
      <TH><INPUT name="ins" type="hidden" id="ins">
      Applicant Id :
        <INPUT name="ACT_ID" type="radio" disabled value="0" <% if (ACT_ID.equals("0")){out.print("Checked");}%>></TH>
      <TH><%=APP_ID %> </TH>
      <TH><DIV align="right">Name Of Applicant :</DIV></TH>
      <TH><%=  APP_NAME %></TH>
    </TR>
    <TR >
      <TH nowrap>Online Submission Date and Time: </TH>
	  <TH><%= ONLINE_SUBDT %></TH>
      <TH nowrap><DIV align="right">Date of Birth:</DIV></TH>
	  <TH><%= DOB %> </th>
   
    </TR>
    <TR >
      <TH nowrap>eMail:</TH>
      <TH nowrap><%= E_MAIL %></TH>
	   <TH nowrap><DIV align="right">Gender:</DIV></TH>
	  <th><%= GENDER %> </th>
    </TR>
    <TR >
      
	  <TH colspan=3 nowrap><DIV align="right">AAdhar No:</DIV></TH>
	  <TH><%= AADHAR_NO %> </TH>
    </TR>
	<TR>
	
	 <TH colspan=3 nowrap><DIV align="right">Mobile No</DIV></TH>
	  <TH><%= MOB_NO1 %> </TH>
	</TR>
	
    
    <TR >
      <TD colspan="4"></TD>
    </TR>
    <TR >
      <TH>Score Card Mark </TH>
      <TH colspan="3" ><H1><%= TOTAL_SCORE %></H1></TH>
    </TR>
	<%
	
	if (!adhvalid.equals("S") ){%>
		<TR >
      <TD colspan="4"></TD>
    </TR>
	 </TR>
    <TR >
     
      <TH colspan="4" ><SPAN class="redLebel">Aadhaar Details are invalid! Please ensure Aadhaar No, Name, Date Of Birth , Gender and mobile No Details are as per Aadhaar Card....... ! Update Correct  Details in Applicant Data form</SPAN></TH>
    </TR>
	<%}%>
 
 

	
	
	
    <TR >
      <TH><DIV align="right">Select Current Status: * </DIV></TH>
      <TH colspan="3" >	
	  <div id="ID1">
	  <INPUT name="ACT_ID" id="ACT_ID1" type="radio" value="1" onClick="Checkradiobutton()" <% if (ACT_ID.equals("1")){out.print("Checked");}%>>
      Under Process
        <INPUT name="ACT_ID"  id="ACT_ID2" type="radio" onClick="Checkradiobutton()" value="3" <% if (ACT_ID.equals("3")){out.print("Checked");}%>>
        <SPAN class="redLebel">Returned by Agency</SPAN>
		<%if(SCOREVALID.equals("Y")){%>
		 <INPUT name="ACT_ID"  id="ACT_ID3" type="radio" onClick="Checkradiobutton()" value="4" <% if (ACT_ID.equals("4")){out.print("Checked");}%>> 
		  <SPAN class="GreenLebel">Score Card Verified and to be forwarded to Bank</SPAN>
		 <%}else {%>
		  <INPUT name="ACT_ID"  id="ACT_ID4" type="radio" onClick="Checkradiobutton()" disabled> 
		   <SPAN class="GreenLebel">Score Card Verified and to be forwarded to Bank</SPAN> (Cannot be verified)
		 <%}%>		
		 </div>		</TH>
    </TR>


   <TR >
      <TH><DIV align="right">Select Rejection Reason : </DIV></TH>
      <TD colspan="3" class="GreenLebel" >
	  <select name="REJ_ID" id="REJ_ID" value=<%=REJ_ID%> >
	   <option value="">--Select Rejection Reason--</option>
      <%
	  String qrystr="";
	  String REJID="";
		String REJDESC="";
	    qrystr="SELECT REJ_ID,REJ_DESC FROM REJECTION_MAST WHERE ACT_YN='Y' AND REL_TP IN ('A','C') ORDER BY REJ_ID";
       ResultSet rs = db.execSQL(qrystr);
	   while(rs.next()){ 
	   REJID=rs.getString(1);
REJDESC=rs.getString(2);
	   %>
      <option value="<%=rs.getString("REJ_ID")%>" <% if (REJID.equals(REJ_ID)){out.print("selected");}%>><%=rs.getString("REJ_DESC")%></option>
      <% } 
	  rs.close();
	   %>
       
      </select></TD>
    </TR>

    <TR >
      <TD colspan="4" class="GreenLebel" ><DIV align="center" class="redLebel">Note: Score Card Marks Implemented for the year 2020-21 onward. </DIV></TD>
    </TR>
    <TR >
      <TH ><DIV align="right">Agency Remarks*:
              
      </DIV></TH>
      <TD colspan="3" ><input name="REMARKS" type="text" id="REMARKS" value="<%= REMARKS %>" size="50" maxlength="200"> 
      (Maximum 200 charcters) </TD>
    </TR>
    <TR>
      <TH colspan="4"> <DIV align="center">
          <INPUT name="Button2" type="button" class="button"  value="Cancel" onClick="javascript:window.close();">
          <INPUT name="Button" type="button" class="button"  onClick="submit_form();" value="Save  Record">
      </DIV></TH>
    </TR>
  </TABLE>
  <%} else {%>
	<TABLE align="center">
    <TR>
      <TH colspan="4"><DIV align="center">APPLICANT CURRENT STATUS UPDATE FORM BY AGENCY </DIV></TH>
    </TR>
    <TR>
      <TH><INPUT name="ins" type="hidden" id="ins">
      Applicant Id :
        <INPUT name="ACT_ID" type="radio" disabled value="0" <% if (ACT_ID.equals("0")){out.print("Checked");}%>></TH>
      <TH><%=APP_ID %> </TH>
      <TH><DIV align="right">Name Of Applicant :</DIV></TH>
      <TH><%=  APP_NAME %></TH>
    </TR>
    <TR >
      <TH nowrap>Online Submission Date and Time: <%= ONLINE_SUBDT %></TH>
      <TH colspan="3" nowrap><DIV align="right">DLTFC Fordwarding Date:<%= FORD_DT_DLTFC  %></DIV></TH>
    </TR>
    <TR >
      <TH nowrap>eMail:</TH>
      <TH colspan="3" nowrap><%= E_MAIL %></TH>
    </TR>
    <TR >
      <TH nowrap>Mobile No</TH>
      <TH colspan="3" nowrap>1st Mobile No:<%= MOB_NO1 %> and alternative Mobile No: <%= MOB_NO2 %> </TH>
    </TR>
	  <TR >
      <TH colspan="4"><DIV align="center" class="redLebel"><%=MSG%> </DIV></TH>
	  </TR>
	  <TR>
	  <TH colspan="4"> <DIV align="center"><INPUT name="Button2" type="button" class="button"  value="Cancel" onClick="javascript:window.close();"> </DIV></TH>
    </TR>
    <TR >
  </TABLE>
  <%}%>
  <%

if ((String)request.getParameter("ins")!=null){
REMARKS=(String) request.getParameter("REMARKS")==null?"":(String) request.getParameter("REMARKS").trim();
ACT_ID=(String) request.getParameter("ACT_ID")==null?"":(String) request.getParameter("ACT_ID").trim();
REJ_ID=(String) request.getParameter("REJ_ID")==null?"":(String) request.getParameter("REJ_ID").trim();

//String vtoDate=ACT_ID.equals("2")?TODAYDT:"";
String vtoDate=ACT_ID.equals("4")?TODAYDT:"";

String mtgidt=ACT_ID.equals("4")?MTGIDTE:"";

	List values=new ArrayList();
		List pstm=new ArrayList();
		StringBuffer qryUpdate = new StringBuffer();
//out.print (vtoDate);
//qryUpdate.append(" UPDATE APP_DETAIL SET REMARKS=?,APP_REC_DATE=?,");
//qryUpdate.append("  ACT_ID=?,FORD_DT_DLTFC=? ,MTG_ID=? ,CLIENT_IP=? WHERE APP_ID=? AND ACT_ID IN (0,1,3,2,4) AND MTG_ID IS NULL AND DLTFC_PROC_DT IS NULL");

qryUpdate.append(" UPDATE APP_DETAIL SET REMARKS= SUBSTR(?,1,200) , APP_REC_DATE=SYSDATE,");
qryUpdate.append("  ACT_ID=?, REJ_ID=?, FORD_DT_DLTFC=? ,MTG_ID=? ,CLIENT_IP=? WHERE APP_ID=? AND  ACT_ID NOT IN (7,5) ");





values.add(REMARKS); pstm.add ("L");
//values.add(APP_REC_DATE); pstm.add ("L");
values.add(ACT_ID); pstm.add ("L");
values.add(REJ_ID); pstm.add ("L");
values.add(vtoDate); pstm.add ("L");
values.add(mtgidt); pstm.add ("L");
values.add(CLIENT_IP); pstm.add ("L");

values.add(APP_ID); pstm.add ("L");

db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate() ;
values.clear();
pstm.clear();


if(ACT_ID.equals("4")){
try {
values.add(APP_ID); pstm.add ("L");
db.setSqlValue("UPDATE PMEGP_SCORE_CARD SET HO_VERIFY_YN='Y', HO_VERIFY_DT=SYSDATE WHERE APP_ID =? ");
db.setValues(values,pstm);
db.executeUpdate() ;
}catch (Exception e) {}
}



db.close();
response.sendRedirect("savemsg.jsp");

}//ins
%>
</FORM>
</BODY>
</HTML>
