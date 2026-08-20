<%@ include file="includeHeadercomm.jsp" %>
<link href="../css/jquery.dataTables.min.css" rel="stylesheet" type="text/css">
<link href="../css/styleradiobutton.css" rel="stylesheet" type="text/css">
<script src="../js/jquery-1.12.0.min.js"></script>
<script src="../js/jquery.dataTables.min.js"></script>
<script src="../js/ModalPopupWindow.js" type="text/javascript"></script>
<script language="javascript">


function form_submit(){
document.form.submit();
}
 var xmlHttp   
      var xmlHttp 
      function showDistrict(str){ 
	  try
    {
    // Firefox, Opera 8.0+, Safari
    xmlHttp=new XMLHttpRequest();
    }
  catch (e)
    {
    // Internet Explorer
    try
      {
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
      }
    catch (e)
      {
      try
        {
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
        }
      catch (e)
        {
        alert("Your Browser Don't Support AJAX!");
        return false;
        }
      }
    }
	 
	  
      var url="district.jsp"; 
      url +="?count=" +str;
	  
      xmlHttp.onreadystatechange = stateChange; 
      xmlHttp.open("post", url, true); 
      xmlHttp.send(null); 
      } 
	  
      function stateChange(){    
      if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){   
	   var x=document.getElementById('DISTRICT');
	   x.innerHTML=xmlHttp.responseText;
      } //statechane1 function end   
      }//main function end.

       

</script>
</head>
<body onLoad="showDistrict(this.value);">
<form name="form" id="form" class="form" method="post">
<%
DBCon db= new DBCon();
db.connect();
 String STATE="";
   String pSTATE =request.getParameter("STATE")==null?"":(String)request.getParameter("STATE"); 
  String vSTATE=(String) session.getAttribute("STATE")==null?"":(String)session.getAttribute("STATE");
  String vWherecls="";
   session.setAttribute("STATE", STATE);
  
   
   if ((pSTATE.equals("")) && (!vSTATE.equals(""))){
   STATE=vSTATE;
   }
   else if ((!pSTATE.equals("")) && (vSTATE.equals(""))){
    STATE=pSTATE;
   }
   else{
   STATE="";
   }
   
     if (!STATE.equals("")){
    vWherecls=vWherecls+" AND (MS.STATE_CD ) LIKE  ('%"+STATE+"%')  ";
}
else{
 vWherecls=vWherecls+" AND (MS.STATE_CD ) LIKE  ('-')  ";
 
}


 ResultSet rsState=db.execSQL(" SELECT MS.STATE_CD,MS.STATE_NM FROM M_STATE MS  ORDER BY MS.STATE_NM ");

  %> 
<table align="center" class="pmegpTable">
    <tr>
      <td colspan="18"><div align="center"> PMEGP MARGIN MONEY PENDING CLAIM PROCESS </div></td>
    </tr>
	 <tr><td colspan="9">SEARCH BY STATE:</td>
      <td  colspan="8"> <select name="STATE" id="STATE" onBlur="showDistrict(this.value);">
	          <option value=""> Search by State</option>
		<%
	   String sn="";
	   String st="";
	   while (rsState.next()) {
	   st=rsState.getString(1);	
	   sn=rsState.getString(2);	   
	    %>
        <option value="<%=st  %>" <% if (st.equals(STATE)){ out.print("selected");}%>><%= sn %></option>
		<%
	   }
		rsState.close();
		%>		  
      </select>	  </td>
      <td><input name="btnFind" type="button" class="button" id="btnFind" value="Search" onClick="form_submit();" ></td>
  </table>
 <% if (!VUSER_ID.equals("3")){ %>
<table align="center" cellspacing="0" class="display" id="example">
        <thead>
            <tr>
              <th nowrap>Agency</th>
              <th nowrap>Applicant ID </th>
                <th nowrap>APPLICANT NAME</th>
                <th nowrap>IFSC</th>
                <th nowrap>MM Claim Date </th>
				<th nowrap>MM Claim </th>
				<th nowrap>View </th>
				<th nowrap>Status</th>
				<th nowrap>Transient A/c No. </th>
            </tr>
        </thead>
        <tfoot>
            <tr>
              <th>&nbsp;</th>
              <th>Applicant ID </th>
                <th>APPLICANT NAME</th>
                <th>IFSC</th>
                <th>MM Claim Date </th>
				<th>MM Claim</th>
				<th>Loan Statement</th>
				<th>Status</th>
				<th>Transient A/c No. </th>
            </tr>
        </tfoot>
		        <tbody>
		<%
		try {

String OFF_CD= "";
StringBuffer qrysb = new StringBuffer();
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
qrysb.append("     MAS_OFF_MAST MOM,M_DISTRICT MD,M_STATE MS"      );
qrysb.append("   WHERE AD.APP_ID       = BD.APP_ID AND AD.UNIT_DIST_CD=MD.DISTRICT_CD AND MD.STATE_CD=MS.STATE_CD "      );
qrysb.append("   AND BD.IFSC_CODE      = BBM.BR_IFSL_CODE"      );
qrysb.append("   AND AD.OFF_CD         = MOM.OFF_CD AND AD.ACT_YN='Y' "      );
qrysb.append("   AND BD.MM_CLAIM_AMT   > 0 AND ( BD.PACT_ID IN (30,31) OR BD.APPRV_YN='R') "+vWherecls+" ");
qrysb.append("   AND BD.LOAN_DOCFNAME IS NOT NULL ORDER BY BD.MM_CLAIM_DT DESC");

//out.print(qrysb.toString());

ResultSet rsMain = db.execSQL(qrysb.toString());

String AGENCY_TYPE = "";
String OFF_NAME = "";
String APP_ID = "";
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

 


while(rsMain.next())
  { 
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
  %>
            <tr>
              <td><%= AGENCY_TYPE %></td>
              <td><%= APP_ID%></td>
                           <td> <%= APP_NAME%></td>
                            <td><%=BR_IFSL_CODE %></td>
                            <td><%= MM_CLAIM_DT %></td>
							<td><%= MM_CLAIM_AMT %></td>
                            <td>
                              <input name="btnDocument" type="button" class="buttonMerun" id="btnDocument" onClick="viewAlldocument('<%=APP_ID%>');" value="Forms / Document"></td>
                            <td><input type="button" name="Button" class="buttonOrange" value="Update" onClick=" ShowMMClaim('<%= APP_ID%>')"></td>
                            <td><%= FB_ACNO %></td>
                  </tr>
				  
				  
				  
			<%
			}
			rsMain.close();
			db.close();
			}catch (Exception e) {out.print(e.toString());}
			
			
			%>
			
			
            
        </tbody>
</table>
 <%}%>



<script>
$(document).ready(function() {
    // Setup - add a text input to each footer cell
    $('#example tfoot th').each( function () {
        var title = $(this).text();
       // $(this).html( '<input type="text" placeholder="'+title+'" />' );
    } );
 
    // DataTable
    var table = $('#example').DataTable();
 
    // Apply the search
    table.columns().every( function () {
        var that = this;
 
        $( 'input', this.footer() ).on( 'keyup change', function () {
            if ( that.search() !== this.value ) {
                that
                    .search( this.value )
                    .draw();
            }
        } );
    } );
} );



 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 
 function ShowMMClaim(pAppid){
var urlpar='StatusUpdateIstLCO.jsp?APP_ID='+pAppid;
 modalWin.ShowURL(urlpar,700,900,'PMEGP STATUS UPDATE',null,null);
 }
 
 function viewAlldocument(pAppid){
var urlpar='viewAppdocument.jsp?APP_ID='+pAppid;
 modalWin.ShowURL(urlpar,800,1200,'PMEGP View All Applicant Document',null,null);
 }
 
function HideModalWindow() {
    modalWin.HideModalPopUp();
}

function refresh_data(){
form.submit();
}

 </script>
</form>
</body>
	</html>