<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%
response.setContentType("text/html");
response.setHeader("Cache-Control", "no-cache,must-revalidate");
response.addHeader("Cache-Control", "post-check=0,pre-check=0");
response.addHeader("Cache-Control", "proxy-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", -1);


%>
<html>
<head> 
<link rel="stylesheet" type="text/css" href="../css/kieportal.css" />
 <script src="../js/inlineMsgMain.js"></script>
 <script>
 function form_submit(){
 
var OP_PASS= document.form.OP_PASS.value; 
var NP_WORD = document.form.NP_WORD.value; 
var CP_WORD = document.form.CP_WORD.value; 

if(OP_PASS == "") {
    inlineMsg('OP_PASS','You Must Enter Old Password',2);
    return false;
	}
 if(NP_WORD == "") {
    inlineMsg('NP_WORD','You Must Enter New Password',2);
    return false;
	}
if(CP_WORD == "") {
    inlineMsg('CP_WORD','You Must Enter Confirm Password',2);
    return false;
	}	
if(NP_WORD.length < 8) { 
    inlineMsg('NP_WORD','Enter Atleast 8 character As Password',2);
    return false;
    }
if(CP_WORD != NP_WORD) { 
    inlineMsg('CP_WORD','Password Does Not Match',2);
    return false;
    }

    document.form.ins.value='I';
	document.form.submit();

}
 </script>
   <style type="text/css">
<!--
.style1 {color: #FF0000}
-->
   </style>
</head>
   <body>
     

   <%
	   String USER_NM= session.getAttribute("sUSER_NM")==null?"":(String) session.getAttribute("sUSER_NM");	  
	   String USER_DESC= session.getAttribute("sUSER_DESC")==null?"":(String) session.getAttribute("sUSER_DESC");
       String IFSL_CODE= session.getAttribute("sIFSL_CODE")==null?"":(String) session.getAttribute("sIFSL_CODE");
	   String OP_PASS=request.getParameter("OP_PASS")==null?"":request.getParameter("OP_PASS");	   	   
	   String NP_WORD=request.getParameter("NP_WORD")==null?"":request.getParameter("NP_WORD");
	   String CP_WORD=request.getParameter("CP_WORD")==null?"":request.getParameter("CP_WORD");
	   String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");
	   DBCon db= new DBCon();
        db.connect();
		     List values=new ArrayList();
             List pstm=new ArrayList();
		%>
         
   <form method="post" action="resetPass.jsp" name="form" id="form">

   <p>&nbsp;</p>
   <p>&nbsp;</p>
   <p>&nbsp;</p>
   <table align="center">
  <th colspan="3"><div align="center"> 
     
      <span class="style90 style96">CHANGE PASSWORD FOR NODAL OFFICER</span>
      <input name="ins" type="hidden" id="ins" value="<%= ins %>">
  </div></th>

<tr bgcolor="#FF9E5E" >
    <td colspan="3">&nbsp;</td>
    </tr>


		<tr>
<th>ENTER OLD PASSWORD*</th>
   <td>
      <input name="OP_PASS" type="password" id="OP_PASS"  value="<%=OP_PASS %>" size="20" maxlength="20">
      </td>
    </tr>
	<tr>
<th>ENTER NEW PASSWORD*</th>
    <td ><input name="NP_WORD" type="password" id="NP_WORD"  value="<%= NP_WORD %>" size="20" maxlength="20"></td>	
</tr>
<tr>
<th>CONFIRM NEW PASSWORD*</th>
    <td ><input name="CP_WORD" type="password" id="CP_WORD"  value="<%= CP_WORD %>" size="20" maxlength="20"></td>	
</tr>
<tr>
<th colspan="3"> 
          <div align="center">
		    <p>
            <input name="Button" type="button" class="button" onClick="form_submit();" value="CHANGE PASSWORD">
                   
      </p>
		    <p>* <span class="style1">NOTE - Passwords are Case Sensitive</span>       </p>
        </div>
</th>
</tr>
   </table>
   <%
  // out.print(ins);
  
   try {
     
			if (ins.equals("I")) {	
       				
		
		StringBuffer qryB = new StringBuffer();
		qryB.append(" SELECT nvl(COUNT(*),0) FROM BU_USERMAST WHERE IFSL_CODE=? AND PASSWD=? " );
         values.add (IFSL_CODE);pstm.add ("D");		
		 values.add (OP_PASS);pstm.add ("D");		 
        ResultSet rsUP = db.executeSQL(qryB.toString(),values);
		String cnt="0";
		while(rsUP.next()){	 
		cnt=rsUP.getString(1);
		}rsUP.close();
		
		values.clear();
         pstm.clear();
		 
		 //out.print(cnt);
		 if (cnt.equals("0")){
		 out.print ("INCORRECT OLD PASSWORD");
		 }
if (cnt.equals("1")) {
         StringBuffer qrysb = new StringBuffer();
		 qrysb.append(" UPDATE BU_USERMAST SET PASSWD=? WHERE PASSWD=? AND IFSL_CODE=?  " );

db.setSqlValue(qrysb.toString());
db.setValues(values,pstm); 
         values.add (CP_WORD);pstm.add ("D");        
		 values.add (OP_PASS);pstm.add ("D");
		 values.add (IFSL_CODE);pstm.add ("D");
	db.executeUpdate() ;
    values.clear();
    pstm.clear();
	
  response.sendRedirect("savemsgPass.jsp");
  }
	
	db.close();
   }
   }
  catch (Exception e) {
	  out.print(e);
	  
  }
	
	
	
   
   
   %>
</form>

</body>
</html>