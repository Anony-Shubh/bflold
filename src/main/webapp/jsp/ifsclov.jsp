<%@ page  language="java" import="java.sql.*,pkgPmegpNew.DBCon" %>
    <% 
String IFSC_CODE =request.getParameter("IFSC_CODE_SER")==null?"":(String) request.getParameter("IFSC_CODE_SER");
int recount=0;
String BANK_NAME="";
String BRANCHNAME = "";
String ADDRESS = "";
String DISTRICT = "";
String BANK_PINCD="";
  
  DBCon db= new DBCon();
  db.connect();
  StringBuffer qrysb = new StringBuffer();
qrysb.append(" SELECT RBI.BANK_NAME, " );
qrysb.append("RBI.IFSC_CODE,  " );
qrysb.append("RBI.BRANCHNAME, " );
qrysb.append(" RBI.ADDRESS, " );
qrysb.append("  RBI.CENTRE,  " );
qrysb.append(" RBI.DISTRICT,  " );
qrysb.append(" RBI.DISTRICT_CD,RBI.BANK_PINCD " );
qrysb.append(" FROM RBIBANKLIST RBI " );
qrysb.append(" WHERE ACT_YN='Y' AND UPPER(IFSC_CODE)=UPPER('"+IFSC_CODE+"') " );
 ResultSet rsMain = db.execSQL(qrysb.toString());
	while (rsMain.next()){
BANK_NAME=rsMain.getString("BANK_NAME")==null?"":rsMain.getString("BANK_NAME");
IFSC_CODE=rsMain.getString("IFSC_CODE")==null?"":rsMain.getString("IFSC_CODE");
BRANCHNAME=rsMain.getString("BRANCHNAME")==null?"":rsMain.getString("BRANCHNAME");
ADDRESS=rsMain.getString("ADDRESS")==null?"":rsMain.getString("ADDRESS");
DISTRICT=rsMain.getString("DISTRICT")==null?"":rsMain.getString("DISTRICT");
recount=recount+1;
	}
	rsMain.close();
     db.close();
	 if ( recount>0) {
	%>
	
	<table>
	<tr>
    <td width="15%">IFS Code: </td>
      <td><input name="IFSC_CODE" type="text" id="IFSC_CODE" size="11" maxlength="11" readonly="true" value="<%= IFSC_CODE %>"></td>
      </tr>
      <tr>
        <td width="15%">Financing Bank Name: </td>
        <td><input name="BANK_NAME" type="text" id="BANK_NAME" size="100" maxlength="100" readonly="true" value="<%= BANK_NAME %>"></td>
      </tr>
      <tr>
        <td width="15%">Branch Name: </td>
        <td><input name="BRANCH_NAME" type="text" id="BRANCH_NAME" size="100" maxlength="100" value="<%= BRANCHNAME %>" ></td>
      </tr>
      <tr>
        <td width="15%">Address:</td>
        <td><input name="BANK_POST_ADDR" type="text" id="BANK_POST_ADDR" size="100" maxlength="200" value="<%= ADDRESS %>"></td>
      </tr>
      <tr>
        <td width="15%">District:</td>
        <td><input name="BANK_DISTRICT" type="text" id="BANK_DISTRICT" size="30" maxlength="25" value="<%= DISTRICT %>"   /></td>
		
	  </tr>
      <tr>
        <td colspan="2"><div align="center">
          <input type="button" name="Button" value="Forward to Bank" class="buttonBlue" onClick="reforward();">
        </div></td>
      </tr>
		 
	</table>
	<p>
      <% } else {
	out.print ("<center><h2>Incorrect IFS Code, Please ensure that 5th place of IFS Code is Zero...</h2></center>");
	}
	
	 %>
    </p>
    