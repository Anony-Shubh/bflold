<%@ include file="appIncludeHeaderPage.jsp" %>
<script type="text/javascript">
function Popup(url, title, w, h) {
// Fixes dual-screen position Most browsers Firefox
var dualScreenLeft = window.screenLeft != undefined ? window.screenLeft : screen.left;
var dualScreenTop = window.screenTop != undefined ? window.screenTop : screen.top;
width = window.innerWidth ? window.innerWidth : document.documentElement.clientWidth ? document.documentElement.clientWidth : screen.width;
height = window.innerHeight ? window.innerHeight : document.documentElement.clientHeight ? document.documentElement.clientHeight : screen.height;

var left = ((width / 2) - (w / 2)) + dualScreenLeft;
var top = ((height / 2) - (h / 2)) + dualScreenTop;
var newWindow = window.open(url, title, 'scrollbars=yes, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);

// Puts focus on the newWindow
if (window.focus) {
newWindow.focus();
}
}
</script>
<body>
<form method="post" action="upload_app_doc111.jsp" name="form" id="form" >

	    <%
		
		String APP_ID= (String) session.getAttribute("sAPP_ID");
		APP_ID=APP_ID.trim();
		APP_ID=APP_ID.toUpperCase();
		 session.setAttribute("sAPP_ID",APP_ID);
       String APP_NAME = "";
String SOC_CAT = "";
String GENDER = "";
String E_MAIL = "";
String EDU_DESC = "";
String UNIT_LOC = "";
String AADHAR_NO = "";
String REGD_NO = "";
String TAN_NO = "";
String PAN_NO = "";
String SPE_CAT = "";
String BENF_TYPE_DESC = "";
String FH_NAME = "";
 String EDP_YN = "";

		String UP_ID = "";
		String UPM_CD = "";
		String DOC_NAME = "";
		String DOC_REMARKS = "";

		
        DBCon db= new DBCon();
        db.connect();

        //  String docStr="SELECT UPM_CD,DOC_DESC FROM APP_UPLOAD_MAST WHERE USR_TYPE='I' AND ACT_YN='Y'";
		  
		  //  ResultSet rsDoc = db.execSQL(docStr);

           StringBuffer qry = new StringBuffer();
       
	   
	   qry.append("   SELECT AD.APP_NAME,"      );
		qry.append("    BCMCAT.BENF_CATEGORY_DESC AS SOC_CAT ,"      );
		qry.append("     AD.GENDER,"      );
		qry.append("     AD.E_MAIL,"      );
		qry.append("     EM.EDU_DESC,"      );
		qry.append("     AD.UNIT_LOC, DECODE(AD.EDP_YN,'N','No','Yes') AS EDP_YN, "      );
		qry.append("     AD.AADHAR_NO,"      );
		qry.append("     AD.REGD_NO,"      );
		qry.append("     AD.TAN_NO,"      );
		qry.append("     AD.PAN_NO,"      );
		qry.append("     BCMSCAT.BENF_CATEGORY_DESC AS SPE_CAT,"      );
		qry.append("     BTM.BENF_TYPE_DESC,"      );
		qry.append("     AD.APP_ID,"      );
		qry.append("     AD.FH_NAME"      );
		qry.append("   FROM APP_DETAIL_ONLINE AD, APP_DETAIL AFD,"      );
		qry.append("     EDUCATION_MAST EM,"      );
		qry.append("     BENF_CATEGORY_MAST BCMCAT,"      );
		qry.append("     BENF_TYPE_MAST BTM,  "      );
		qry.append("     BENF_CATEGORY_MAST BCMSCAT  "      );
		qry.append("   WHERE AD.EDU_ID              = EM.EDU_ID AND AD.APP_ID=AFD.APP_ID (+) "      );
		qry.append("   AND AD.BENF_TYPE_CD          = BTM.BENF_TYPE_CD"      ); 
		qry.append("   AND AD.BENF_CATAGORY_CD      = BCMCAT.BENF_CATEGORY_CD"      );
		qry.append("   AND BCMSCAT.BENF_CATEGORY_CD = AD.BENF_SPECAT_CD AND AD.APP_ID=?"      );

			 List values=new ArrayList();
				 values.add (APP_ID); 

        ResultSet rsApp =db.executeSQL(qry.toString(),values);
 					 values.clear();	

        while (rsApp.next()){
	APP_NAME=rsApp.getString("APP_NAME")==null?"":rsApp.getString("APP_NAME");
SOC_CAT=rsApp.getString("SOC_CAT")==null?"":rsApp.getString("SOC_CAT");
GENDER=rsApp.getString("GENDER")==null?"":rsApp.getString("GENDER");
E_MAIL=rsApp.getString("E_MAIL")==null?"":rsApp.getString("E_MAIL");
EDU_DESC=rsApp.getString("EDU_DESC")==null?"":rsApp.getString("EDU_DESC");
UNIT_LOC=rsApp.getString("UNIT_LOC")==null?"":rsApp.getString("UNIT_LOC");
AADHAR_NO=rsApp.getString("AADHAR_NO")==null?"":rsApp.getString("AADHAR_NO");
REGD_NO=rsApp.getString("REGD_NO")==null?"":rsApp.getString("REGD_NO");
TAN_NO=rsApp.getString("TAN_NO")==null?"":rsApp.getString("TAN_NO");
PAN_NO=rsApp.getString("PAN_NO")==null?"":rsApp.getString("PAN_NO");
SPE_CAT=rsApp.getString("SPE_CAT")==null?"":rsApp.getString("SPE_CAT");
BENF_TYPE_DESC=rsApp.getString("BENF_TYPE_DESC")==null?"":rsApp.getString("BENF_TYPE_DESC");
APP_ID=rsApp.getString("APP_ID")==null?"":rsApp.getString("APP_ID");
FH_NAME=rsApp.getString("FH_NAME")==null?"":rsApp.getString("FH_NAME");
EDP_YN=	rsApp.getString("EDP_YN")==null?"":rsApp.getString("EDP_YN");	
        }
			rsApp.close();
			
				StringBuffer qryUp = new StringBuffer();	
			
qryUp.append("	SELECT * FROM (   ");
qryUp.append("SELECT AUM.UPM_CD, AUT.UP_ID, AUT.DOC_NAME, AUT.DOC_REMARKS, ");
qryUp.append(" TO_CHAR(AUT.UPLOAD_TIMESTAMP,'DD-MON-RRRR HH:MM') AS AUT_DT, ");
qryUp.append(" AUM.DOC_DESC FROM APP_UPLOAD_TRANS AUT,APP_UPLOAD_MAST AUM ");
qryUp.append(" WHERE AUT.UPM_CD = AUM.UPM_CD AND AUT.APP_ID=? ");
qryUp.append(" UNION SELECT AUM.UPM_CD,NULL UP_ID, NULL AS DOC_NAME, NULL AS DOC_REMARKS, ");
qryUp.append(" NULL AS AUT_DT, AUM.DOC_DESC FROM APP_UPLOAD_MAST AUM WHERE ");
qryUp.append(" AUM.UPM_CD NOT IN (SELECT UPM_CD FROM APP_UPLOAD_TRANS ");
qryUp.append(" WHERE APP_ID=?)) ");
qryUp.append(" WHERE UPM_CD IN ");
qryUp.append(" (SELECT * FROM TABLE(FUPLOAD_DOC(?))) ");
      values.add (APP_ID); 
	  values.add (APP_ID); 
	  values.add (APP_ID); 
	ResultSet rsUp = db.executeSQL(qryUp.toString(),values);
	values.clear();	
		
        %>
  </p>
	  <table align="center">
        <tr>
          <th colspan="5" nowrap>ONLINE APPLICANT DOCUMENT /CERTIFICATE UPLOAD FORM </th>
        </tr>
        <tr>
          <th colspan="2" nowrap>ID:</th>
          <th nowrap>-</th>
          <th nowrap>Aadhaar No: </th>
          <th nowrap><%= AADHAR_NO %></th>
        </tr>
        <tr>
          <th colspan="2" nowrap>Name:</th>
          <th nowrap><%= APP_NAME %>&nbsp;</th>
          <th nowrap>PAN No. </th>
          <th nowrap><%= PAN_NO %></th>
        </tr>
        <tr>
          <th colspan="2" nowrap>Category: </th>
          <th nowrap><%= SOC_CAT %></th>
          <th nowrap>Special Category : </th>
          <th nowrap><%= SPE_CAT %></th>
        </tr>
        <tr>
          <th colspan="2" nowrap>Education:</th>
          <th nowrap><%= EDU_DESC %></th>
          <th nowrap>Unit Location: </th>
          <th nowrap><%= UNIT_LOC %></th>
        </tr>
        <tr>
          <th colspan="2" nowrap>EDP Training: </th>
          <th colspan="3" nowrap><%= EDP_YN %></th>
        </tr>
        <tr>
          <td colspan="5" nowrap class="redLebel"><div align="center">Upload all valid  Documents </div></td>
        </tr>
        <tr>
          <th nowrap>SrNo</th>
          <th nowrap>Document Desc </th>
          <th nowrap>Remarks</th>
          <th nowrap>View</th>
          <th nowrap>delete</th>
        </tr>
        <% 
  
  String vDOC_NAME="";
  String vDOC_DESC="";
  String vDOC_REMARKS="";
  int srno=0;
  while (rsUp.next()) {
  srno=srno+1;
    vDOC_NAME=rsUp.getString("DOC_NAME")==null?"":rsUp.getString("DOC_NAME");
   vDOC_DESC=rsUp.getString("DOC_DESC")==null?"":rsUp.getString("DOC_DESC");
   vDOC_REMARKS=rsUp.getString("DOC_REMARKS")==null?"":rsUp.getString("DOC_REMARKS");
   UP_ID = rsUp.getString("UP_ID")==null?"0":rsUp.getString("UP_ID");
		 UPM_CD = rsUp.getString("UPM_CD")==null?"":rsUp.getString("UPM_CD");
  
  %>
        <tr>
          <td><%= srno %></td>
          <td><%= vDOC_DESC %></td>
          <td><%= vDOC_REMARKS %></td>
          <td>
		  <% if (!UP_ID.equals("0")) {%>
		  <a href="doctransfertoNas_31072019.jsp?docname=<%= vDOC_NAME %>" class="greenButtonRound">view </a>
		  <% }else{%>
		  <a href="upload_app_doc_puf.jsp?UPM_CD=<%= UPM_CD %>" class="greenButtonRound" onClick="javascript:Popup(this.href, 'Upload Document', 800, 350);return (false);">Upload </a>
		  <% } %>		   </td>
          <td>
		  
		  
		  <% if (!UP_ID.equals("0")) {%>
		  <a href="upload_app_doc_del.jsp?UP_ID=<%= UP_ID %>" class="greenButtonRound" onClick="javascript:Popup(this.href, 'Upload Document', 800, 500);return (false);">delete</a></td>
		  <% } %>
		</td>
        </tr>
        <%
  }
  rsUp.close();
  db.close();
  %>
      </table>
	 
</form>
</body>
</html>