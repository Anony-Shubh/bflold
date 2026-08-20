<%@ page import = "pmegponline.main.pmegpAadharValidationModel,pkgPmegpNew.DBCon,java.util.*" %>
<%@ include file="appIncludeHeaderPage.jsp" %>

<%
String APP_ID=  vAppid;
 String an=request.getParameter("AADHAR_NO")==null?"":(String) request.getParameter("AADHAR_NO");
	 String nm=request.getParameter("APP_NAME")==null?"":(String) request.getParameter("APP_NAME");
	String gn=request.getParameter("GENDER")==null?"":(String) request.getParameter("GENDER");
		String dob=request.getParameter("DOB")==null?"":(String) request.getParameter("DOB");
		String MOBILENO=request.getParameter("MOBILENO")==null?"":(String) request.getParameter("MOBILENO");
	out.print(an);
	out.print(nm);
	out.print(gn);
	out.print(dob);
	
	
	
	pmegpAadharValidationModel pam=new pmegpAadharValidationModel(an,nm,gn,MOBILENO,dob);
	
	DBCon db= new DBCon();
		db.connect(); 
		List values=new ArrayList();
        List pstm=new ArrayList();
	
	String ATRID="";

	if (pam.errlist().size()>0) {
		out.print(pam.errlist());
		// request.setAttribute("errorMessage", "Please Verifiy Aadhar Details.....");
		}else {
		// request.setAttribute("errorMessage", "S"); 
			out.print("pass");        
			out.print(pam.errlist());
		}
	/*	
		ResultSet rs1=db.execSQL("select PMEGPGRSEQ.nextval from DUAL");
	while (rs1.next()) {
 ATRID=rs1.getString(1);
}
rs1.close();*/
		
		
	try {
			
			String ret=pam.getVret()==null?"":pam.getVret();
			String code=pam.getVcode()==null?"":pam.getVcode();
			String txn=pam.getVtxn()==null?"":pam.getVtxn();
			
			String info=pam.getVinfo()==null?"":pam.getVinfo();
			String ts=pam.getVts()==null?"":pam.getVts();
			String err=pam.getVerr()==null?"":pam.getVerr();
		
		out.print(ret);
		out.print(code);
        StringBuffer  qrysb= new StringBuffer();
		
		
		
		qrysb.append(" INSERT INTO AADHAR_VERI_LOG (ATRID ,ANO,ANAME, AGENDER,RET,CODE ,TXN,INFO , TS ,ERR ,LASTUPDATETIMESTAMP,DOB,MOBNO)  VALUES (PMEGPGRSEQ.nextval ,?,?,?, ?,?,?, ?,?,?, SYSDATE,?,? ) ");
		
		
		//values.add(ATRID); pstm.add ("L");
		values.add(an); pstm.add ("L");
        values.add(nm); pstm.add ("L");
        values.add(gn); pstm.add ("L");
		
		values.add(ret); pstm.add ("L");
        values.add(code); pstm.add ("L");
        values.add(txn); pstm.add ("L");
		
		values.add(info); pstm.add ("L");
        values.add(ts); pstm.add ("L");
        values.add(err); pstm.add ("L");
		values.add(dob); pstm.add ("L");
		 values.add(MOBILENO); pstm.add ("L");
		   
		   

db.setSqlValue(qrysb.toString());
db.setValues(values,pstm); 
db.executeUpdate() ;
 values.clear();
 pstm.clear();
//db.close();	

StringBuffer qryUpdate = new StringBuffer();



/*
qryUpdate.append("  UPDATE APP_DETAIL_ONLINE SET ATRID=?,RET_YN=? WHERE APP_ID=? ");


values.clear();
pstm.clear();

values.add(ATRID); pstm.add ("L");
values.add(ret); pstm.add ("L");
values.add(APP_ID); pstm.add ("L");

db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate() ;
db.close();
		
*/

		}catch(Exception e) {
			
			out.print (e.toString());
			
		}
		
		
		
		
		
	//
	  // RequestDispatcher rd = request.getRequestDispatcher("adhValidAppLogn.jsp");
     //  rd.forward(request, response); 
	 
%>
