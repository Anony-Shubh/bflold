<%@ page buffer="600kb" session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<head>
<script type="text/javascript" src="../js/datetimepicker_css.js"></script>
<script src="../js/sweetalert.min.js"></script>
<style>
.h1{border-style: inset;}
#container{
  font-family: Arial, Helvetica, sans-serif;s
  border-collapse: collapse;
  width: 85%;
  border-style: inset;
  background-color:#FFFFFF;
 
}
#container td,container tr{
  border: 1px solid black;
  border-collapse: collapse;
 background-color:#FFFFFF;
}
#container td:hover, td:active {text-decoration: underline; background-color: #ddd;} 

#container th {
  font-family: Arial black, Helvetica, sans-serif;
  padding: 6px;
  text-align: center;
  border-style: inset;
  background-color: #3f506e;
  color:#FFFFFF;
}
input[type=text] {
  width: 80%;
  box-sizing: border-box;
}
.button{
  background-color: #8B9DC3;
  border: none;
  color: black;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
  border: 1px solid #221F1F;
}
.next1 {
  background-color: #999999;
  color:#000000;
  font-size: 25px;
}
a {
  text-decoration: none;
  display: inline-block;
  padding: 8px 16px;
}

a:hover {
  background-color: #ddd;
  color: black;
}
.button1 {  background-color: #3f506e;
  border: none;
  color: #FFFFFF;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
  border: 1px solid #221F1F;
}

.btnnew {
  background:linear-gradient(#ffc477, #fb9e25);
  background-image: -webkit-linear-gradient(top, #3498db, #2980b9);
  background-image: -moz-linear-gradient(top, #3498db, #2980b9);
  background-image: -ms-linear-gradient(top, #3498db, #2980b9);
  background-image: -o-linear-gradient(top, #3498db, #2980b9);
  background-image: linear-gradient(to bottom, #3498db, #2980b9);
  -webkit-border-radius: 28;
  -moz-border-radius: 28;
  border-radius: 28px;
  font-family: Arial;
  color: #ffffff;
  font-size: 20px;
  padding: 10px 20px 10px 20px;
  text-decoration: none;
}

.btnnew:hover {
  background: #3cb0fd;
  background-image: -webkit-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -moz-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -ms-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -o-linear-gradient(top, #3cb0fd, #3498db);
  background-image: linear-gradient(to bottom, #3cb0fd, #3498db);
  text-decoration: none;
}
      .marquee {
            height: 50px;
            overflow: hidden;
            position: relative;
            background: #fefefe;
            color: #FF3300;
			font-size:24px;
            border: 1px solid #4a4a4a;
        }
        
        .marquee p {
            position: absolute;
            width: 100%;
            height: 100%;
            margin: 0;
            line-height: 50px;
            text-align: center;
            -moz-transform: translateX(100%);
            -webkit-transform: translateX(100%);
            transform: translateX(100%);
            -moz-animation: scroll-left 2s linear infinite;
            -webkit-animation: scroll-left 2s linear infinite;
            animation: scroll-left 20s linear infinite;
        }
        
        @-moz-keyframes scroll-left {
            0% {
                -moz-transform: translateX(100%);
            }
            100% {
                -moz-transform: translateX(-100%);
            }
        }
        
        @-webkit-keyframes scroll-left {
            0% {
                -webkit-transform: translateX(100%);
            }
            100% {
                -webkit-transform: translateX(-100%);
            }
        }
        
        @keyframes scroll-left {
            0% {
                -moz-transform: translateX(100%);
                -webkit-transform: translateX(100%);
                transform: translateX(100%);
            }
            100% {
                -moz-transform: translateX(-100%);
                -webkit-transform: translateX(-100%);
                transform: translateX(-100%);
            }
        }

</style>


<SCRIPT language="javascript">

function submitform(){
var DCO_APPROV_YN = form.DCO_APPROV_YN.value; 
var DCO_REMARK = form.DCO_REMARK.value;

	 if (DCO_APPROV_YN == "")  {	 swal({title:"Please select status"}); return (false);}
	 if (DCO_REMARK == "")   {	 swal({title:"Please Enter Remarks "});	return (false);} 
	

document.form.ins.value='I';
document.form.submit();
}
</script>
</head>
<body>



<%
DBCon db= new DBCon();
db.connect();
List values=new ArrayList();

String surl="";
String app_id1=request.getParameter("app_id")==null?"":(String) request.getParameter("app_id");
String UNIT_NAME=request.getParameter("UNIT_NAME")==null?"":(String) request.getParameter("UNIT_NAME");

String DCO_APPROV_YN="";
String DCO_APPROV_DATE="";
String DCO_REMARK="";

String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");

String add_update="I";

if(!app_id1.equals("")){

StringBuffer poR = new StringBuffer();

poR.append(" SELECT DCO_APPROV_YN,DCO_APPROV_DATE,DCO_REMARK FROM PMEGP_AWARD WHERE app_id = ? ");

values.add(app_id1);


try (ResultSet rsMain = db.executeSQL(poR.toString(),values);) {

while (rsMain.next()){

DCO_APPROV_YN=rsMain.getString("DCO_APPROV_YN")==null?"":rsMain.getString("DCO_APPROV_YN");
DCO_APPROV_DATE=rsMain.getString("DCO_APPROV_DATE")==null?"":rsMain.getString("DCO_APPROV_DATE");
DCO_REMARK=rsMain.getString("DCO_REMARK")==null?"":rsMain.getString("DCO_REMARK");


if (!app_id1.equals("") ) {
add_update="U";
}
rsMain.close();
}

}catch (Exception e){}finally {

}


}
%>

<TABLE align="center" class="pmegpTable">
    <TR>
      <TD colspan="19"><DIV align="center">PMEGP AWARD NOMINATION STATUS CHANGE</DIV></TD>
    </TR>
  </TABLE>
  <br>
<center>
<em><strong>Applicant ID : <%= app_id1 %> Applicant Name: <%= UNIT_NAME %></strong></em>
</center>  
<br>
<FORM name="form" id="form" method="post">

<table id="container" align="center">
<input name="ins" type="hidden" id="ins" >

    <tr>
      <td width="494"><strong>Status *:</strong></td>
    <td width="493"><input type="radio" id="radio" name="DCO_APPROV_YN" value="Y" <% if (DCO_APPROV_YN.equals("Y")) {out.print("checked");}%>>
      Recommend to Approve
      <input type="radio" id="radio" name="DCO_APPROV_YN" value="N" <% if (DCO_APPROV_YN.equals("N")) {out.print("checked");}%>>
      Rejected</td>
    </tr>
	  <tr>
	    <td><strong>DCO Remarks *:</strong></td>
    <td>
	<textarea id="DCO_REMARK" name="DCO_REMARK" rows="4" cols="50">
<%=DCO_REMARK%>
</textarea>
	</td>
  </tr>
  
   <% if(!DCO_APPROV_YN.equals("Y")) { %>
  <tr>
    <td colspan="17">
      <center>
        
        <input name="button" type="button" class="button1" onClick="submitform();" value="Save">
      </center></td>
    </tr>
	
<%}%>	
</table>
</FORM>

 <% if(DCO_APPROV_YN.equals("Y")) { %>
  <div class="marquee" align="center">
        <p>Status cannot be updated once Recommended to Approver</p>
    </div>

<%}%>
<% 

  if (ins.equals("I")){
try {
out.print ("insde");
 
app_id1=(String) request.getParameter("app_id")==null?"":(String) request.getParameter("app_id").trim();
DCO_APPROV_YN=(String) request.getParameter("DCO_APPROV_YN")==null?"":(String) request.getParameter("DCO_APPROV_YN").trim();
DCO_REMARK=(String) request.getParameter("DCO_REMARK")==null?"":(String) request.getParameter("DCO_REMARK").trim();



        List pstm=new ArrayList();
		StringBuffer qryUpdate = new StringBuffer();
		values.clear();
		pstm.clear();
		
	



qryUpdate.append("	UPDATE pmegp_award SET ");
qryUpdate.append("	DCO_APPROV_YN = ?, ");
qryUpdate.append("	DCO_REMARK = ? , DCO_APPROV_DATE=SYSDATE ");
qryUpdate.append("  WHERE app_id = ? ");

out.print (qryUpdate.toString());

values.add(DCO_APPROV_YN); pstm.add ("L");
values.add(DCO_REMARK); pstm.add ("L");
values.add(app_id1); pstm.add ("L");

db.setSqlValue(qryUpdate.toString()); 
db.setValues(values,pstm); 
db.executeUpdate() ; 

values.clear();
pstm.clear();

surl="save_page.jsp";

}catch (Exception e) {

out.print (e.toString());
}
}

try {
 db.close();
 }catch (Exception e) {}finally {
 //db.close();
 }
 
if (surl !="") {response.sendRedirect("savepage.jsp");}

%>
</FORM>

</BODY>
</HTML>
