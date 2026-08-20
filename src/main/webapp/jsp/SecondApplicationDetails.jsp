<%@ include file="includeHeaderPage.jsp" %>
<style type="text/css">
<!--
.style2 {color: #FF0000; font-weight: bold; }
.style3 {color: #0000FF}
-->
</style>


<form  method="post" name="lov1">
  
      <% 
	  String txtSearch="";
	  String str= "";
 String APP_ID =request.getParameter("APP_ID");
String APP_NAME = "";
String DISTRICT_NAME = "";
String INT_TIME = "";
String APP_REC_DATE = "";
String ACT_ID = "";
String ONLINE_SUBDT = "";
String ACT_DESC = "";
String ACT_YN = "";
 String txt="";
 

if (request.getParameter("txtSearch") != null || txtSearch !=""){
			txtSearch ="%"+(String) request.getParameter("txtSearch")+"%";
			txt=(String)request.getParameter("txtSearch");
			}else{
			txtSearch ="%%";
			txt="";
			}

 
 int count=0;
 String vOffcd= (String) session.getAttribute("off_cd");
	
	 if (vOffcd !=null) {	
	
    StringBuffer qrysb= new StringBuffer();
	
	
	qrysb.append("   SELECT ad.APP_ID,'' AS INT_TIME,ad.ACT_YN,"      );
qrysb.append("     UPPER(ad.APP_NAME) AS APP_NAME,"      );
qrysb.append("     MD.DISTRICT_NAME,"      );
qrysb.append("     TO_CHAR(ad.APP_REC_DATE, 'DD-MON-RRRR') AS APP_REC_DATE,"      );
qrysb.append("     ad.ACT_ID,"      );
qrysb.append("     TO_CHAR(ad.ONLINE_SUBDT, 'DD-MON-RRRR') AS ONLINE_SUBDT,"      );
qrysb.append("     asm.ACT_DESC"      );
qrysb.append("   FROM APP_DETAIL_SECOND ad,"      );
qrysb.append("     app_status_mast asm,"      );
qrysb.append("     M_DISTRICT MD"      );
qrysb.append("   WHERE ad.ACT_ID     = asm.ACT_ID "      );
qrysb.append("   AND ad.UNIT_DIST_CD = MD.DISTRICT_CD"      );
qrysb.append("   AND UPPER(ad.APP_ID"      );
qrysb.append("     || ' '"      );
qrysb.append("     || TRIM(ad.APP_NAME)) LIKE TRIM(UPPER(?))"      );
qrysb.append("   AND AD.OFF_CD=? ORDER BY ad.ONLINE_SUBDT DESC"      );

List values=new ArrayList();

  values.add(txtSearch);
  values.add(vOffcd);
  
  DBCon db= new DBCon();
db.connect();
  
  
ResultSet   rs = db.executeSQL(qrysb.toString(),values);
   values.clear();
    %>
  <table align="center" class="pmegpTable">
   
    <tr>
      <td colspan="14"><div align="center">Applicantion Status Update For Second Loan </div></td>
    </tr>
    <tr>
      <td colspan="12"><div align="right">Enter Applicant ID or  Applicant Name:</div></td>
      <td><input name="txtSearch" type="text"  id="txtSearch" size="25" maxlength="25" value="<%= txt %>"></td>
      <td ><input name="btnSearch" type="submit" class="button" id="btnSearch"  onClick="strFind()" value="Search Applicant"></td>
    </tr>
    <tr>
      <td rowspan="2">Srno</td>
      <td rowspan="2">ID
        <input name="APP_ID" type="hidden" id="BANKCODE" value="<%=APP_ID %>"></td>
      <td rowspan="2">Change Unit District and Agecny </td>
      <td rowspan="2">Name </td>
      <td rowspan="2">Date of Submission </td>
      <td colspan="5"><div align="center">Online Application </div></td>
      <td rowspan="2"><div align="center">Interaction Detail</div></td>
      <td rowspan="2"><div align="center"> Update Date</div></td>
      <td rowspan="2">Current Status</td>
      <td rowspan="2" >Applicant Status </td>
    </tr>
    <tr>
      <td><div align="center">Form</div></td>
      <td>Documents</td>
      <td colspan="3">Applicant Form </td>
    </tr>
    <%
	
	String param="";
	while (rs.next()){
	APP_ID=rs.getString("APP_ID")==null?"":rs.getString("APP_ID");
	param="APP_ID="+APP_ID;
	APP_NAME=rs.getString("APP_NAME")==null?"":rs.getString("APP_NAME");
	DISTRICT_NAME=rs.getString("DISTRICT_NAME")==null?"":rs.getString("DISTRICT_NAME");
	INT_TIME=rs.getString("INT_TIME")==null?"":rs.getString("INT_TIME");
	APP_REC_DATE=rs.getString("APP_REC_DATE")==null?"":rs.getString("APP_REC_DATE");
	ACT_ID=rs.getString("ACT_ID")==null?"":rs.getString("ACT_ID");
	ONLINE_SUBDT=rs.getString("ONLINE_SUBDT")==null?"":rs.getString("ONLINE_SUBDT");
	ACT_DESC=rs.getString("ACT_DESC")==null?"":rs.getString("ACT_DESC");
    ACT_DESC=rs.getString("ACT_DESC")==null?"":rs.getString("ACT_DESC");
	ACT_YN=rs.getString("ACT_YN")==null?"":rs.getString("ACT_YN");
	count=count+1;
	if (ACT_YN.equals("Y"))
{
	 %>
    <tr  >
      <td > <%= count %></td>
      <td  > <%=APP_ID %></td>
      <td  > <a href="javascript: mypopup('appOffTransferSec.jsp','<%= param %>','1000','490');" class="greenButtonRound">Update</td>
      <td  ><%=APP_NAME%><br>
      <br>
      District:<%=DISTRICT_NAME%></td>
      <td  >
      <%=ONLINE_SUBDT %></td>
      <td  ><a href="../pmegpIILOAN/PMEGPGenAppForm.jsp?APP_ID=<%= APP_ID %>" class="button">View</a></td>
      <td  >
	  
	   <div align="center"><a href="javascript: mypopup('app_upload_sec_view.jsp','<%= param %>','1000','490');" class="greenButtonRound">View  </a>        </div>	</td>
      <td  ><a href="appUpdatebyAgencySec.jsp?APP_ID=<%= APP_ID %>" class="button">Edit</a></td>
      <td  ><a href="upload_app_doc_sec_agency.jsp?APP_ID=<%= APP_ID %>" class="greenButtonRound">Upload</a></td>
       <td  >
	 
	  <div align="center">
	  <% if (ACT_ID.equals("5")) {%>
	  <a href="javascript: mypopup('AgnSignUplSec.jsp','<%= param %>','1000','490');" class="greenButtonRound">SignBoard Upload  </a>
	  <%} else {%>
	  -
	  <%}%>
	  
	  
	          </div>
	  
	  </td>
    
      <td  >
	  
	    <div align="center"><a href="javascript: mypopup('InteractionDetailUpdateSec.jsp','<%= param %>','1000','490');" class="greenButtonRound">Update  </a>        </div></td>
      <td  ><div align="center"><%=APP_REC_DATE %></div>
        <div align="center"><br />
		  <% if (!APP_REC_DATE.equals("")) {%>
       <a href="../pmegpIILOAN/PMEGPGenAppForm.jsp?RNAME=AcknowledgementLetter&APP_ID=<%= APP_ID %>" class="greenButtonRound">Acknowledgement	  </a>
	    <% }%>	   </td>
      <td  ><%=ACT_DESC %></td>
      <td  >
	    <div align="center">
	    
		<% if (ACT_ID.equals("5")) { %>
		 <a href="../pmegpIILOAN/PMEGPGenAppForm.jsp?RNAME=SecondBankForwardingLetter&APP_ID=<%= APP_ID %>" class="greenButtonRound"> Print Bank Forwarding Letter</a>
			
		 <%}else { %>
	          <a href="javascript: mypopup('statusUpdateSecondByAgency.jsp','<%= param %>','1000','490');" class="greenButtonRound">Update </a>
          <%}%>
        </div></td>
    </tr>
	
	 <%
	 } else{
		 %>
		 
		<tr> 
		 <td > <%= count %></td>
          <td  > <%=APP_ID %></td>
		   <td><span class="style2">Locked </span></td>
		    <td  ><%=APP_NAME%><br>
      <br>
      District:<%=DISTRICT_NAME%></td>
      <td  >
      <%=ONLINE_SUBDT %></td>
			  <td  ><a href="PMEGPGenAppForm.jsp?APP_ID=<%= APP_ID %>" class="button">View</a></td>
     <td><a href="javascript: mypopup('app_upload_sec_view.jsp','<%= param %>','1000','490');" class="greenButtonRound">View</a></td>
	  <td colspan="3">
	  
	    <div align="center" class="style2">Locked        </div></td>
	 <td><a href="javascript: mypopup('InteractionDetailUpdate.jsp','<%= param %>','1000','490');" class="greenButtonRound">Update </a> </td>
	  <td><div align="center"><%=APP_REC_DATE %></div>
	    <div align="center"><br />
            <% if (!APP_REC_DATE.equals("")) {%>
            <a href="PMEGPGenAppForm.jsp?RNAME=AcknowledgementLetter&APP_ID=<%= APP_ID %>" class="greenButtonRound">Acknowledgement </a>
            <% }%>
        </div></td>

			 		<td> <div align="center" class="style2">Returned</div></td>
		<td  >
	    <div align="center" class="style3">
   		  Forwarded to Bank But Returned to applicant for fresh application submission.		 </div></td>
    </tr>
		 
		 
	<%	 
	 }
	}
	  rs.close();
   db.close();
	 }// END
	 %>
  </table> 
</form>
</body>
</html>
