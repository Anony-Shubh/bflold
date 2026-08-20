
<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>



<html>
<head>


<STYLE>
.buttongreen {
  background-color: #4CAF50;
  border: none;
  color: white;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
}

</STYLE>



<script>
function submit_offupdate() {



   
document.form.ins.value='I'; 
document.form.submit(); 

 }
 
</script>
</head>

<body>
<form name="form"  method="Post">

<%
 String APP_ID =  (String) session.getAttribute("sAPP_ID");
 String GPV_ID =  (String) session.getAttribute("sGPV_ID");
 //out.print(APP_ID);
 // out.print(GPV_ID);
  List values=new ArrayList();
List pstm=new ArrayList();
DBCon db= new DBCon();
         db.connect();
%>

  <br/>
   <br/>
    <br/>
	 <br/>
	  <br/> <input name="ins" type="hidden" id="ins" value="">
  <div align="center" class="redLebel"><h2>Do you want to final Submit.</h2>
     <p>note:Once Final Submited ,You cannot modify the data.....</p>
    
	
	  <input name="Button" type="button" class="buttongreen" onClick="submit_offupdate();" value="Submit">
   
		</div>
	
<%
try {
	 
 if ((String)request.getParameter("ins")!=null){
 
 

 
 
 StringBuffer qryUpdate= new StringBuffer();
 

qryUpdate.append(" UPDATE GEOTAG_PVBANKFORM SET ACT_ID=0,UPDATE_TIMESTAMPDT=SYSDATE WHERE APP_ID=? AND GPV_ID=?  ");



values.add(APP_ID); pstm.add ("L");
values.add(GPV_ID); pstm.add ("L");


db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm); 
db.executeUpdate() ;
db.close();
values.clear();
pstm.clear();

response.sendRedirect("pvBankForm.jsp");

}


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
</body>
</html>

