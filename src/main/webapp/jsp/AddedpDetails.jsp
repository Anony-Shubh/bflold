<%@ page session="true"  import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<LINK rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<script type="text/javascript" src="../js/sweetalert.min.js"></script>
  <script language="javascript" src="../js/jquery-1.12.4.js"></script>  
<script type="text/javascript" src="../js/jquery-1.12.0.min.js"></script>
 <script type="text/javascript" src="../js/ModalPopupWindow.js"></script> 
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script language="javascript">
function submit_offupdate() {


var EDP=document.form.EDP.value;

//alert(EDP);
 if(EDP == "") {
	swal ( 'Note:','Select EDP Training Mode...','error');
    return false;
  }
   if ((EDP != "") && (EDP == "ON")){
   var EDP_TYPE1=document.form.EDP_TYPE1.value; 
   var DIS=document.getElementsByName("EDP_TYPE1"); 
//alert(DIS);  
	if (EDP_TYPE1 == ""){
		swal ( 'Note:','Select EDP Type....','error');
		//alert("Please Select EDP Type");
		 return false;
   }
   }
   
    if ((EDP != "") && (EDP == "OF")){
   var EDP_TYPE2=document.form.EDP_TYPE2.value; 
    var DIS=document.getElementsByName("EDP_TYPE2");
var OFF_CD=document.form.OPT_TRG_CENTER.value;
var EDP_TRG_NAME=document.form.EDP_TRG_NAME.value;
	
	if (EDP_TYPE2 ==""){
	swal ( 'Note:','Select EDP Type....','error');
		//alert("Please Select EDP Type");
		 //inlineMsg('EDP_TYPE2','Select EDP Type....',2);
		 return false;
   }
   if(OFF_CD == "" || EDP_TRG_NAME == "") {
	 swal ( 'Note:','Select EDP Center Name....','error');
    return false;
}
   
   }
   
   
document.form.ins.value='I'; 
document.form.submit(); 

 }
 

	 $(function () {
         $('input[name=EDP]').change(function () {
			//alert($(this).val());
            if ($(this).val() == "ON") {				
                $("#EDP_TY6").show() && $("#EDP_TY7").hide() && $("#EDP_TY5").hide()  ;
            }  if ($(this).val() == "OF") {
                $("#EDP_TY6").hide() &&  $("#EDP_TY7").show() && $("#EDP_TY5").show() && $("#EDP_TY8").hide();
            }
			if ($(this).val() == "") {				
                $("#EDP_TY6").hide() && $("#EDP_TY7").hide() && $("#EDP_TY5").hide() && $("#EDP_TY8").hide() ;
            } 
			
			
        });
    });

 
 
 
  $(function () {
	  $('input[name=EDP_TYPE1]').change(function () { 
	  //alert("hello");    
            if (($(this).val() == "1")){
				
                $("#EDP_TY8").show() ;
            } else {
                $("#EDP_TY8").hide() ;
            }
        });
    });
	
		
	
 
function test(){
 
  var EDP_YN=document.form.h.value;
 
	if (EDP_YN =="ON"){
		 $("#EDP_TY6").show() && $("#EDP_TY7").hide() && $("#EDP_TY5").hide() && $("#EDP_TY8").hide();
	}
	if (EDP_YN =="OF"){
	  $("#EDP_TY6").hide() &&  $("#EDP_TY7").show() && $("#EDP_TY5").show() && $("#EDP_TY8").hide();
	}
	if (EDP_YN ==""){
	  $("#EDP_TY6").hide() &&  $("#EDP_TY7").hide() && $("#EDP_TY5").hide() && $("#EDP_TY8").hide();
	}	
   
}


			

</script>
<body onLoad="test();">

<form  action="AddedpDetails.jsp" method="post" name="form" id="form" >

<% 
String vUserID=(String)session.getAttribute("user_id")==null?"":(String)session.getAttribute("user_id");
String add_update="I";
String ED_ID = "";
String APPC="";
String EDP_TYPE="";
String EDP_TYPE1="";
String EDP_TYPE2="";
String EDP_TRG_NM="";
String OFF_CD="";
String APP_ID=(String) request.getParameter("APP_ID")==null?"0":(String) request.getParameter("APP_ID").trim();;
String APP_NAME="";
String EDP_YN="";
String EDP="";
String EDP_TRG_NAME = "";
String OPT_TRG_CENTER = "";
String OFF_NAME1 = "";
String ACT_YN = "";
String DP="";
String msgStr= session.getAttribute("msgStr")==null?"":(String) session.getAttribute("msgStr");
String qry="";
String DISTRICT_CD="";	
DBCon db= new DBCon();
db.connect();
 List values=new ArrayList();
List pstm=new ArrayList();

 



 qry="SELECT APP_DIST_CD,APP_NAME FROM APP_DETAIL_ONLINE  WHERE APP_ID='"+APP_ID+"' ";
       ResultSet rs = db.execSQL(qry);
	   while(rs.next()){ 
	   DISTRICT_CD=rs.getString("APP_DIST_CD")==null?"":rs.getString("APP_DIST_CD");
	    APP_NAME=rs.getString("APP_NAME")==null?"":rs.getString("APP_NAME");
	   }
	   rs.close();





StringBuffer qrysb= new StringBuffer();

qrysb.append(" SELECT ED.ED_ID,CASE WHEN ED.EDP_TYPE IN (1,2) THEN 'ON' WHEN ED.EDP_TYPE IN (3,4) THEN 'OF' END AS EDP,  "      );
qrysb.append("   ED.EDP_TYPE,CASE WHEN ED.EDP_TYPE IN (1,2) THEN '' ELSE  ED.EDP_TRG_NAME END AS  EDP_TRG_NAME"      );
qrysb.append("   ,ED.EDPOFF_CD FROM EDP_CONDUCT_TRANS ED WHERE ED.ACT_YN='Y' AND ED.APP_ID='"+APP_ID+"' ");
ResultSet rsMain = db.execSQL(qrysb.toString());
//out.print(qrysb.toString());
while (rsMain.next()){

ED_ID=rsMain.getString("ED_ID")==null?"0":rsMain.getString("ED_ID");
EDP_TYPE=rsMain.getString("EDP_TYPE")==null?"":rsMain.getString("EDP_TYPE");
EDP_TRG_NM=rsMain.getString("EDP_TRG_NAME")==null?"":rsMain.getString("EDP_TRG_NAME");
OFF_CD=rsMain.getString("EDPOFF_CD")==null?"":rsMain.getString("EDPOFF_CD");
EDP=rsMain.getString("EDP")==null?"":rsMain.getString("EDP");
add_update="U";
//DISTRICT_CD=rsMain.getString("APP_DIST_CD")==null?"1":rsMain.getString("APP_DIST_CD");
//out.print(DISTRICT_CD);
}
rsMain.close();
if (ED_ID.equals("")){
ED_ID="0";
}
else{
ED_ID=ED_ID;
}
//out.print(ED_ID);
		%>
		<table align="center">
<tr>
  <th colspan="2"><div align="center">Applicant EDP Detail </div></th>
  </tr>
    <tr>
      <th colspan="2">&nbsp;</th>
      </tr>
    <th> Applicant ID:  
        <input name="APP_ID" type="hidden" id="APP_ID" value="<%=APP_ID%>"><input name="ED_ID" type="HIDDEN" id="ED_ID" value="<%=ED_ID%>">
		<input name="h" type="hidden" id="h" value="<%=EDP%>"><input name="APPC" type="hidden" id="APPC" value="<%=APPC%>">		</th>
  <td><%= APP_ID %></td>
</tr>  
  <tr>
    <th>Applicant Name </th>
    <td><%= APP_NAME  %></td>
  </tr>
  <tr>
  <th>Select EDP Training Mode:*
    <input name="ins" type="hidden" id="ins" value=""></th>	
 
 <td> 
   <input type="radio" name="EDP" id="ONP"  value="ON" <% if (EDP.equals("ON")) {out.print("CHECKED");} %>   />
   Online  EDP
    <input type="radio" name="EDP" id="ONP"  value="OF" <% if (EDP.equals("OF")) {out.print("CHECKED");} %>   />
	Offline EDP </td>
</tr>
  <tr id="EDP_TY6">
  <th>Select Type of EDP Training:*</th>
  <td> <input type="radio" name="EDP_TYPE1" id="ONP"  value="1" <% if (EDP_TYPE.equals("1")) {out.print("CHECKED");} %>   />
      Pre EDP(before Bank Sanction)
        <input type="radio" name="EDP_TYPE1"  id="ONF"     value="2" <% if (EDP_TYPE.equals("2")) {out.print("CHECKED");} %>   />
      Post EDP(after Bank Sanction) </td>
</tr>
<tr id="EDP_TY7">
  <th>Select Type of EDP Training:*</th>
  <td>
      <input type="radio" name="EDP_TYPE2"  id="OFP"     value="3"  <% if (EDP_TYPE.equals("3")) {out.print("CHECKED");} %>  />
     Pre EDP(before Bank Sanction)
	  <input type="radio" name="EDP_TYPE2"  id="OFF"     value="4" <% if (EDP_TYPE.equals("4")) {out.print("CHECKED");} %>   />
     Post EDP(after Bank Sanction) </td>
</tr>

<tr id="EDP_TY5">

  <th>Select EDP Training Center:* : </th>
  
  <td>
 
  <input name="EDP_TRG_NAME" id="EDP_TRG_NAME" type="text" size="50" maxlength="50" value="<%= EDP_TRG_NM %>" readonly="true">
		
        <input name="btnEDP" type="button" class="buttonBlue" id="btnEDP" value="Select  EDP Centers" onClick="ShowEdpList(<%=DISTRICT_CD%>);">
		
		<input name="OPT_TRG_CENTER" id="OPT_TRG_CENTER" type="HIDDEN" size="50" maxlength="50" value="<%= OFF_CD %>"> </td>
</tr>  
  
<tr id="EDP_TY8">
  <th colspan="2"><div align="center" class="redLebel">Note: Cost of training to be borne by the applicant</div></th>
</tr>
<tr>
  <th colspan="2"><div align="center" class="GreenLebel"></div></th>
</tr>
<tr><td colspan="2"><div align="center">
<% if (add_update.equals("I")){%>
  <input name="Button" type="button" class="button" onClick="submit_offupdate();" value="Submit">
  <%} else {%>
  <div align="center" class="redLebel">Once EDP Details Submitted it cannot be modified........Kindly Contact Agency For any modification</div>
  <%}%>
</div>
</td>
</tr>  
</table>
        <p>&nbsp;</p>
        <table align="center">
          <tr>
            <td><div align="center"><strong>Online EDP</strong></div></td>
          </tr>
          
          <tr>
            <td><div align="center"><strong><a href="https://www.udyami.org.in/" target="_blank">https://www.udyami.org.in</a></strong></div></td>
          </tr>
          <tr>
            <td>Contact Detail: <strong>07526000333/07526000555/ email: helpdesk@udyami.org.in</strong></td>
          </tr>
        </table>
  <p>&nbsp;</p>
        <div align="center"><%=msgStr%></div>
  <%
 try {
	 
 if ((String)request.getParameter("ins")!=null){
 
 
ED_ID=(String) request.getParameter("ED_ID")==null?"0":(String) request.getParameter("ED_ID").trim();
APP_ID=(String) request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID").trim();
EDP_TYPE1=(String) request.getParameter("EDP_TYPE1")==null?"":(String) request.getParameter("EDP_TYPE1").trim();
EDP_TYPE2=(String) request.getParameter("EDP_TYPE2")==null?"":(String) request.getParameter("EDP_TYPE2").trim();
ACT_YN=(String) request.getParameter("ACT_YN")==null?"Y":(String) request.getParameter("ACT_YN").trim();
EDP_TRG_NAME=(String) request.getParameter("EDP_TRG_NAME")==null?"":(String) request.getParameter("EDP_TRG_NAME").trim();
OPT_TRG_CENTER=(String) request.getParameter("OPT_TRG_CENTER")==null?"":(String) request.getParameter("OPT_TRG_CENTER").trim();
EDP=(String) request.getParameter("EDP")==null?"":(String) request.getParameter("EDP").trim();
//APPC=(String) request.getParameter("APPC")==null?"0":(String) request.getParameter("APPC").trim();
out.print(ED_ID);
out.print(APP_ID);	

if (EDP.equals("ON")){
EDP_TYPE=EDP_TYPE1;
OPT_TRG_CENTER="9246";	
EDP_TRG_NAME="ONLINE EDP (www.udyami.org.in) (9246)";
}
else{
EDP_TYPE=EDP_TYPE2;
OPT_TRG_CENTER=OPT_TRG_CENTER;	
EDP_TRG_NAME=EDP_TRG_NAME;
}
 

 
 
 StringBuffer qryUpdate= new StringBuffer();
 


if (ED_ID.equals("0"))  {

 ResultSet rsMax= db.execSQL("SELECT APPUPLOAD_SEQ.NEXTVAL AS MAX_ID FROM DUAL");
     while (rsMax.next()) {
     ED_ID=rsMax.getString(1);
     }
rsMax.close();



qryUpdate.append("INSERT INTO EDP_CONDUCT_TRANS(APP_ID, ");
qryUpdate.append("EDPOFF_CD,");
qryUpdate.append("EDP_TRG_NAME,");
qryUpdate.append("ACT_YN,");
qryUpdate.append("EDPTIMESTAMP,EDP_TYPE,AGN_APPRV,ED_ID)");
qryUpdate.append("VALUES (?,?,?,?,SYSDATE,?,sysdate,?) ");
}
else{
qryUpdate.append("  UPDATE EDP_CONDUCT_TRANS SET APP_ID=?, EDPOFF_CD=?, EDP_TRG_NAME=?, ACT_YN=?, EDPTIMESTAMP=SYSDATE, EDP_TYPE=?,AGN_APPRV=SYSDATE WHERE ED_ID=?  ");

}
//out.print(qryUpdate.toString());
values.add(APP_ID); pstm.add ("L");
values.add(OPT_TRG_CENTER); pstm.add ("L");
values.add(EDP_TRG_NAME); pstm.add ("L");
values.add(ACT_YN); pstm.add ("L");
values.add(EDP_TYPE); pstm.add ("L");
values.add(ED_ID); pstm.add ("L");

db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm); 
db.executeUpdate() ;
db.close();
values.clear();
pstm.clear();
session.setAttribute("msgStr","<center><h1>EDP Option has been sucessfully updated</h1><center>");
response.sendRedirect("save.jsp");
//out.print ("<center><h1>EDP Option has been sucessfully updated</h1><center>");
} //end ins


}
catch(Exception e)
{
out.print(e.toString());
}
finally{
//db.close();
}
  %>
  
</form>
<script language="javascript">
 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 //Uncomment below line to make look buttons as link
 //modalWin.SetButtonStyle("background:none;border:none;textDecoration:underline;cursor:pointer");

 
 
  function ShowEdpList(pdistrict){
var urlpar='edpD.jsp?DIST_CD='+pdistrict;
 modalWin.ShowURL(urlpar,700,900,'EDP LIST',null,null);
 }
 
 function getEdpName(OFFNAME,OFF_CD){
 form.EDP_TRG_NAME.value=OFFNAME;
form.OPT_TRG_CENTER.value=OFF_CD;
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




</script>
</body>
</html>
