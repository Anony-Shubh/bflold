<%@ include file="includeHeaderPage.jsp" %>
 <p>
  <link rel="stylesheet" type="text/css" href="../css/pmegpNew.css">
 

   <script src="../js/inlineMsgMain.js"></script>
   <script>
 function form_submit(){ 
 
var OP_PASS= document.form.OP_PASS.value; 
var NP_WORD = document.form.NP_WORD.value; 
var CP_WORD = document.form.CP_WORD.value; 

if(OP_PASS == "") {
    inlineMsg('OP_PASS','You Must Enter Old  Password',2);
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
	
	 if(NP_WORD.length <= 8) { 
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
       String USER_ID =vUserID;
		 String msg="";  
      
	   String CP_WORD=request.getParameter("CP_WORD")==null?"":request.getParameter("CP_WORD");
	   String OP_PASS=request.getParameter("OP_PASS")==null?"":request.getParameter("OP_PASS");
	   String NP_WORD=request.getParameter("NP_WORD")==null?"":request.getParameter("NP_WORD");
	   String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");
   
		
   %>
</p>
 <p>&nbsp;</p>
 <p>&nbsp;</p>
 <form method="post" name="form" id="form">
   <p></p>
   <table align="center">
  <th colspan="4"><div align="center"> 
     
      <span class="style90 style96"> PASSWORD CHANGE FOR AGENCY FORM </span>
      <input name="ins" type="hidden" id="ins" value="">
  </div></th>

<tr bgcolor="#FF9E5E" >
    <td colspan="4">&nbsp;</td>
    </tr>

 
	<tr>
<th><div align="right">ENTER OLD PASSWORD*</div></th>
   
    <td ><input name="OP_PASS" type="password" id="OP_PASS"  value="" size="20" maxlength="10"></td>
	</tr>
	<tr>
<th><div align="right">ENTER NEW PASSWORD*</div></th>
    <td ><input name="NP_WORD" type="password" id="NP_WORD"  value="" size="20" maxlength="10"></td>	
</tr>
<tr>
<th><div align="right">CONFIRM NEW PASSWORD*</div></th>
    <td ><input name="CP_WORD" type="password" id="CP_WORD"  value="" size="20" maxlength="10"></td>	
</tr>
<tr>
<th colspan="4"> 
          <div align="center">
		    <p>
            <input name="Button" type="button" class="button" onClick="form_submit();" value="Save Record">
            <input name="Button" type="button" class="button" value="Cancel" onClick="self.close();">          
      </p>
		    <p>* <span class="style1">NOTE : Passwords Are Case-Sensitive</span>       </p>
        </div>
</th>
</tr>

   <%
      
       if (ins.equals("I")) {
		
		     List values=new ArrayList();
             List pstm=new ArrayList();
			 
			 DBCon db= new DBCon();
        db.connect();
		StringBuffer qry = new StringBuffer();
		qry.append(" SELECT nvl(COUNT(*),0) FROM  DATAENTRY_USER WHERE USER_ID=? AND PASSWORD=? AND ACT_YN='Y' " );
         values.add (USER_ID);pstm.add ("D");
		 values.add (OP_PASS);pstm.add ("D");
        ResultSet rsUP = db.executeSQL(qry.toString(),values);
		String cnt="0";
		while(rsUP.next()){	 
		cnt=rsUP.getString(1);
		}rsUP.close();
		
		values.clear();
         pstm.clear();
		 
		
	   
		 if (cnt.equals("0")){
		 msg="Incorrect Old Password...........<br> Please ensure capsLock..........";
		 }
if (cnt.equals("1")) {
         StringBuffer qrysb = new StringBuffer();
		 qrysb.append("  UPDATE DATAENTRY_USER SET PASSWORD=? WHERE USER_ID=? AND ACT_YN='Y' " );

db.setSqlValue(qrysb.toString());
db.setValues(values,pstm); 
 values.add (CP_WORD);pstm.add ("D");
 values.add (USER_ID);pstm.add ("D");
	db.executeUpdate() ;
	db.close();
    values.clear();
    pstm.clear();
	
  response.sendRedirect("loginPage.jsp");
  }
	
	db.close();
   }
   
   
   %>
   <tr>
  <td colspan="4"><h1 align="center" class="blinker"><%= msg %></h1></td>
</tr>
   </table>
</form>
</body>
</html>