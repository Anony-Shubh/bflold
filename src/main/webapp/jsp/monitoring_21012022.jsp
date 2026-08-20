
<%@ page import="java.util.*"%><%@ page import="java.sql.*,pkgPmegpNew.DBCon"%>
 <%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.io.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="javazoom.upload.*"%>
<%@ page import="globalp.*"%>

<%
    response.setHeader("Cache-Control", "no-cache");
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
    %>
<%! 

public static String getExtension(String s) {
    String ext = null;
    int i = s.lastIndexOf('.');
    if (i > 0 &&  i < s.length() - 1) {
        ext = s.substring(i+1).toLowerCase();
    }
    return ext;
}
 %>
 <html>
 <head>
 <link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
   <script type="text/javascript" src="../js/inlineMsgMain.js"></script>
   <script type="text/javascript" src="../js/datetimepicker_css.js"></script>
  <script>
  function sub_form(){
  var numberOnly=/^[0-9]*$/;
  
var PV_VER_OFF=document.form.PV_VER_OFF.value; 
 var PV_VAR_DES = document.form.PV_VAR_DES.value; 
 var PV_DT=document.form.PV_DT.value; 
 var PV_AGENCY=document.form.PV_AGENCY.value; 
 var PV_STATUS=document.form.PV_STATUS.value;
 var PHY_EMP_PT=document.form.PHY_EMP_PT.value; 
 var PHY_EMP_FT=document.form.PHY_EMP_FT.value; 
 var START_DT=document.form.START_DT.value; 
 var PRODUCT_DETAIL=document.form.PRODUCT_DETAIL.value; 
 var PHY_ANL_TO=document.form.PHY_ANL_TO.value; 
 var PV_OBSERV=document.form.PV_OBSERV.value; 

 if(PV_VER_OFF == "") {
    inlineMsg('PV_VER_OFF','Please enter officer name',2);
    return false;
      }
	  
	  if(PV_VAR_DES == "") {
    inlineMsg("PV_VAR_DES","Please enter designation",2);
    return false;
      }
	  
	   if(PV_AGENCY == "") {
    inlineMsg('PV_AGENCY','Please select Agency',2);
    return false;
      }
	  
	  	  if(PV_DT == "") {
    inlineMsg('PV_DT','Please enter physical verification Date',2);
    return false;
      }
	   
	  
	  if(PV_STATUS == "") {
    inlineMsg('PV_STATUS','Please select status',2);
    return false;
      }
	  if(PV_STATUS != "") 	  {
	  //alert(PV_STATUS);
		  
		if(PV_STATUS == "WO") {
			
		if(START_DT == "") {
    inlineMsg('START_DT','Please enter date of commencement',2);
    return false;
      }	
	  if(PRODUCT_DETAIL == "") {
    inlineMsg('PRODUCT_DETAIL','Please enter production details',2);
    return false;
      }	
		 
    if(PHY_EMP_PT == "") {
    inlineMsg('PHY_EMP_PT','Please enter part time employment',2);
    return false;
      }	 
	  if(!numberOnly.test(PHY_EMP_PT)) {
				inlineMsg('PHY_EMP_PT','Employment should be in numbers',2);
				return false;
			  }
	  
	  if(PHY_EMP_FT == "") {
    inlineMsg('PHY_EMP_FT','Please enter full time employment',2);
    return false;
      }	
 if(!numberOnly.test(PHY_EMP_FT)) {
				inlineMsg('PHY_EMP_FT','Employment should be in numbers',2);
				return false;
			  }

if(PHY_ANL_TO == "") {
    inlineMsg('PHY_ANL_TO','Please enter annual turnover',2);
    return false;
      }		  
	 if(!numberOnly.test(PHY_ANL_TO)) {
				inlineMsg('PHY_ANL_TO','Annual Turnover should be in numbers',2);
				return false;
			  }

		}	
		}    
    
     if(PV_OBSERV == "") {
    inlineMsg('PV_OBSERV','Please enter remarks',2);
    return false;
      }   
 
 
 document.form.ins.value='I'; 
					document.form.submit(); 
 
 }

function toggle() {
 if(document.getElementById("PV_STATUS").value == "WO" ) {
   document.getElementById("START_DT").disabled = false;
   //document.getElementById("PHY_PROD").disabled = false;
   //document.getElementById('PHY_SALES').disabled = false;
   document.getElementById('PHY_EMP_PT').disabled = false;
   document.getElementById('PHY_EMP_FT').disabled = false;
   document.getElementById('PRODUCT_DETAIL').disabled = false;
   document.getElementById('PHY_ANL_TO').disabled = false;
   
 }else{
   document.getElementById('START_DT').disabled = true;
 // document.getElementById('PHY_PROD').disabled = true;
  // document.getElementById('PHY_SALES').disabled = true;
   document.getElementById('PHY_EMP_PT').disabled = true;
   document.getElementById('PHY_EMP_FT').disabled = true;
   document.getElementById('PRODUCT_DETAIL').disabled = true;
   document.getElementById('PHY_ANL_TO').disabled = true;
 }
 }

 
</script>
  <style type="text/css">
<!--
.style1 {font-weight: bold}
-->
  </style>
 </head>
 <body>
 <form name="form" id="form" method="post" class="form" enctype="multipart/form-data">
<%@ include file="MonitoringRep.jsp" %>

<%
List values=new ArrayList();
     List pstm=new ArrayList();
	pstm.clear();
    values.clear();
	
 DBCon db= new DBCon();
db.connect();
String  APP_ID =  session.getAttribute("SAPP_ID")==null?"":(String) session.getAttribute("SAPP_ID");
String PHTR_ID = "";
String PV_DT = "";
String PV_VAR_OFF = "";
String PV_VAR_DES = "";
String PV_AGENCY = "";
String PHY_PROD = "";
String PHY_SALES = "";
String PHY_EMP_PT = "";
String PHY_EMP_FT = "";
String START_DT = "";
String PRODUCT_DETAIL = "";
String PHY_INV = "";
String PHY_ANL_TO = "";
String PV_STATUS = "";
String PV_VER_OFF = "";
String PV_OBSERV = "";
String REP_UPLOAD_FNM = "";
String ACT_YN_PH = "";
String PVTIME_STAMP = "";

String MACHIN_AVAIL_YN = "";
String MACHIN_AVAIL_DTL = "";
String MACHIN_AVAIL_OBS = "";
String MACHIN_AVAIL_RECOM = "";
String PROD_PROC = "";
String PROD_PROC_DTL = "";
String PROD_PROC_OBS = "";
String PROD_PROC_RECOM = "";
String QUALITY_CONTROL = "";
String QUALITY_CONTROL_DTL = "";
String QUALITY_CONTROL_OBS = "";
String QUALITY_CONTROL_RECOM = "";
String PRODUCT_PKG = "";
String PRODUCT_PKG_DTL = "";
String PRODUCT_PKG_OBS = "";
String PRODUCT_PKG_RECOM = "";
String MKTCHANL_ADPT_YN = "";
String MKTCHANL_ADPT_DTL = "";
String MKTCHANL_ADPT_OBS = "";
String MKTCHANL_ADPT_RECOM = "";
String LICEN_OBTN_YN = "";
String LICEN_OBTN_DTL = "";
String LICEN_OBTN_OBS = "";
String LICEN_OBTN_RECOM = "";
String QUALITY_CERT_YN = "";
String QUALITY_CERT_DTL = "";
String QUALITY_CERT_OBS = "";
String QUALITY_CERT_RECOM = "";


%>
<%
kvicGlobalPath sm = new kvicGlobalPath();
String a=sm.getStorage("pmegpunitmonitoring/physicalmupload/");
//out.print(a);
%>
<jsp:useBean id="upBean" scope="page" class="javazoom.upload.UploadBean" >
    <jsp:setProperty name="upBean" property="folderstore" value="<%=a%>" />
    <jsp:setProperty name="upBean" property="filesizelimit" value="1000000" />
    <jsp:setProperty name="upBean" property="overwrite" value="false" />
    <jsp:setProperty name="upBean" property="whitelist" value="*.pdf,*.jpg,*jpeg,*.png" />
   </jsp:useBean>
<table class="CSSTableGenerator" align="center">
  <tr bgcolor="#D1A476">
    <td colspan="6"><div align="center" class="style1">
      <h3>Monitoring Report</h3>
    </div></td>
  </tr>
  <tr>
    <th>&nbsp;</th>
    <td colspan="5" nowrap><div align="center" class="mtextarea">APPLICANT ID IS: <%= APP_ID  %></div></td>
  </tr>
  <tr>
    <th>(1)</th>
    <th nowrap><strong>Name of the Visiting Officer*: </strong></th>
    <td colspan="4"><input name="PV_VER_OFF" type="text"  id="PV_VER_OFF" value="<%=PV_VER_OFF%>" size="50" maxlength="50" />
    </td>
    <input type="hidden" name="todo" value="upload"/>
    <input name="ins" type="hidden" id="ins" value="">
  </tr>
  <tr>
    <th>(2)</th>
    <th><strong>Designation*:</strong></th>
    <td colspan="4"><input name="PV_VAR_DES" type="text"  id="PV_VAR_DES"   value="<%=PV_VAR_DES%>" size="50" maxlength="50"  />
    </td>
  </tr>
  <tr>
    <th>(3)</th>
    <th nowrap><strong> Agency*:</strong></th>
    <td colspan="4"><select name="PV_AGENCY" class="button" id="PV_AGENCY" >
      <option value ="-1" >--Select Agency --</option>
      <option value="KV">KVIC</option>
      <option value="KB">KVIB</option>
      <option value="DI">DIC</option>
    </select></td>
  </tr>
  <tr>
    <th>(4)</th>
    <th nowrap><strong>Date of Visit*: </strong></th>
    <td colspan="4"><input name="PV_DT" type="text"  id="PV_DT" onFocus="popUpCalendar(this, this.form.PV_DT,'dd-mmm-yyyy');return false;"  value="<%=PV_DT%>" size="15" maxlength="11"  />
        </th>
    </tr>
  <tr>
    <th>(5)</th>
    <th nowrap><strong>Present Status:*</strong></th>
    <td colspan="4"><select name="PV_STATUS" class="button" id="PV_STATUS" onChange="toggle();" >
      <option value="">--Present Status--</option>
      <option value="WO">Working</option>
      <option value="DF">Not Working</option>
      <option value="NT">Not Tracable</option>
      <option value="NS">To be Started</option>
    </select></td>
  </tr>
  <tr>
    <th>(6)
    <th>Upload Report (If any) : <br>
      (Maximum 1 mb in jpg or pdf) </th>
    <td colspan="4"><input name="uploadfile" type="file" class="button" id="uploadfile" onChange="ValidateSingleInput(this);">
              </td>
  </tr>
  <tr id="hidethis6" style="display:none;">
    <th>(7)</th>
    <th nowrap><strong>Date of Commence of Activity*: </strong></th>
    <td colspan="4"><input name="START_DT" type="text"  id="START_DT"  onFocus="popUpCalendar(this, this.form.START_DT,'dd-mmm-yyyy');return false;"   value="<%=START_DT%>" size="13" maxlength="11" />
        </th>
    </tr>
  <tr id="hidethis5" style="display:none;">
    <th>(8)</th>
    <th nowrap><strong>Product Details*: </strong></th>
    <td colspan="4"><input name="PRODUCT_DETAIL" type="text"  id="PRODUCT_DETAIL"   value="<%=PRODUCT_DETAIL%>" size="50" maxlength="100"  />
    </tr>
  <tr id="hidethis1" style="display:none;">
    <th rowspan="2">(9)  
    <th rowspan="2">No.of Employment*: 
    <th colspan="3"><div align="center">Part time </div>
    <th><div align="center">Full Time </div>
    </tr>
  <tr id="hidethis2" style="display:none;">
    <td colspan="3"><div align="center">
      <input name="PHY_EMP_PT" type="text" id="PHY_EMP_PT"  value="<%=PHY_EMP_PT%>" size="10" maxlength="4"  />
    </div>
    <td><div align="center">
      <input name="PHY_EMP_FT" type="text"  id="PHY_EMP_FT"   value="<%=PHY_EMP_FT%>" size="10" maxlength="4" />
    </div>
    </tr>
  <tr  >
    <th> 
    <th>Annual Sales     
      ( in Rs.) 
    <td><input name="MACHIN_AVAIL_DTL2"  type="text"  id="MACHIN_AVAIL_DTL2" value="<%=MACHIN_AVAIL_DTL%>" size="10" maxlength="10">
    <td colspan="2"><strong>Annual Production </strong>
    <td>
  </tr>
  <tr  >
    <th> 
    <th> 
    <td colspan="2"><div align="center"><strong>Detail </strong> </div>
    <td><div align="center"><strong>Observation </strong> </div>
    <td><div align="center"><strong>Recommandation </strong></div>
    </tr>
  <tr  >
    <th> 
    <th>Available Machienery Details: 
    <td><select name="MACHIN_AVAIL_YN" id="MACHIN_AVAIL_YN">
              <option value="NA">Not Applicable</option>
              <option value="Y">Yes</option>
              <option value="No">No</option>
            </select>
          <td><input name="MACHIN_AVAIL_DTL"  type="text"  id="MACHIN_AVAIL_DTL" value="<%=MACHIN_AVAIL_DTL%>" size="50" maxlength="300">
          <td><input name="MACHIN_AVAIL_OBS"  type="text"  id="MACHIN_AVAIL_OBS" value="<%=MACHIN_AVAIL_OBS%>" size="50" maxlength="300">
          <td><input name="MACHIN_AVAIL_RECOM"  type="text"  id="MACHIN_AVAIL_RECOM" value="<%=MACHIN_AVAIL_RECOM%>" size="50" maxlength="300">
        </tr>
  <tr  >
    <th> 
    <th>Production Process involve:
    <td><label>
            <select name="PROD_PROC">
              <option value="NA">Not Applicable</option>
              <option value="Manual">Manual</option>
              <option value="Automatic">Automatic</option>
              <option value="Semi Automatic">Semi Automatic</option>
              <option value="Fully Automatic">Fully Automatic</option>
            </select>
            </label>
          <td><input name="PROD_PROC_DTL"  type="text"  id="PROD_PROC_DTL" value="<%=PROD_PROC_DTL%>" size="50" maxlength="300">
          <td><input name="PROD_PROC_OBS"  type="text"  id="PROD_PROC_OBS" value="<%=PROD_PROC_OBS%>" size="50" maxlength="300">
          <td><input name="PROD_PROC_RECOM"  type="text"  id="PROD_PROC_RECOM" value="<%=PROD_PROC_RECOM%>" size="50" maxlength="300">
        </tr>
  <tr  >
    <th> 
    <th>Quality Control  Mechanism   followed    
    <td><select name="QUALITY_CONTROL">
              <option value="NA">Not Applicable</option>
              <option value="Y">Yes</option>
              <option value="N">No</option>
            </select>
          <td><input name="QUALITY_CONTROL_DTL"  type="text"  id="QUALITY_CONTROL_DTL" value="<%=QUALITY_CONTROL_DTL%>" size="50" maxlength="300">
          <td><input name="QUALITY_CONTROL_OBS"  type="text"  id="QUALITY_CONTROL_OBS" value="<%=QUALITY_CONTROL_OBS%>" size="50" maxlength="300">
          <td><input name="QUALITY_CONTROL_RECOM"  type="text"  id="QUALITY_CONTROL_RECOM" value="<%=QUALITY_CONTROL_RECOM%>" size="50" maxlength="300">
        </tr>
  <tr  >
    <th> 
    <th>Packaging of the Product 
    <td><select name="PRODUCT_PKG" id="PRODUCT_PKG">
              <option value="NA">Not Applicable</option>
              <option value="Manual">Manual</option>
              <option value="Machinised">Machinised</option>
            </select>
          <td><input name="PRODUCT_PKG_DTL"  type="text"  id="PRODUCT_PKG_DTL" value="<%=PRODUCT_PKG_DTL%>" size="50" maxlength="300">
          <td><input name="PRODUCT_PKG_OBS"  type="text"  id="PRODUCT_PKG_OBS" value="<%=PRODUCT_PKG_OBS%>" size="50" maxlength="300">
          <td><input name="PRODUCT_PKG_RECOM"  type="text"  id="PRODUCT_PKG_RECOM" value="<%=PRODUCT_PKG_RECOM%>" size="50" maxlength="300">
        </tr>
  <tr  >
    <th> 
    <th>Marketing channel Adopted     
    <td><select name="MKTCHANL_ADPT_YN">
              <option value="NA">Not Applicable</option>
              <option value="Y">Yes</option>
              <option value="No">No</option>
            </select>
          <td><input name="MKTCHANL_ADPT_DTL"  type="text"  id="MKTCHANL_ADPT_DTL" value="<%=MKTCHANL_ADPT_DTL%>" size="50" maxlength="300">
          <td><input name="MKTCHANL_ADPT_OBS"  type="text"  id="MKTCHANL_ADPT_OBS" value="<%=MKTCHANL_ADPT_OBS%>" size="50" maxlength="300">
          <td><input name="MKTCHANL_ADPT_RECOM"  type="text"  id="MKTCHANL_ADPT_RECOM" value="<%=MKTCHANL_ADPT_RECOM%>" size="50" maxlength="300">
        </tr>
  <tr  >
    <th> 
    <th>Mandatory  License  obtained: 
    <td><select name="LICEN_OBTN_YN" id="LICEN_OBTN_YN">
              <option value="NA">Not Applicable</option>
              <option value="Y">Yes</option>
              <option value="No">No</option>
            </select>
          <td><input name="LICEN_OBTN_DTL"  type="text"  id="LICEN_OBTN_DTL" value="<%=LICEN_OBTN_DTL%>" size="50" maxlength="300">
          <td><input name="LICEN_OBTN_OBS"  type="text"  id="LICEN_OBTN_OBS" value="<%=LICEN_OBTN_OBS%>" size="50" maxlength="300">
          <td><input name="LICEN_OBTN_RECOM"  type="text"  id="LICEN_OBTN_RECOM" value="<%=LICEN_OBTN_RECOM%>" size="50" maxlength="300">
        </tr>
  <tr  >
    <th> 
    <th> Quality Standardization Certificate obtained:     
    <td><select name="QUALITY_CERT_YN" id="QUALITY_CERT_YN">
              <option value="NA">Not Applicable</option>
              <option value="Y">Yes</option>
              <option value="No">No</option>
            </select>
          <td><input name="QUALITY_CERT_DTL"  type="text"  id="QUALITY_CERT_DTL" value="<%=QUALITY_CERT_DTL%>" size="50" maxlength="300">
          <td><input name="QUALITY_CERT_OBS"  type="text"  id="QUALITY_CERT_OBS" value="<%=QUALITY_CERT_OBS%>" size="50" maxlength="300">
          <td><input name="QUALITY_CERT_RECOM"  type="text"  id="QUALITY_CERT_RECOM" value="<%=QUALITY_CERT_RECOM%>" size="50" maxlength="300">
        </tr>
  <tr  >
    <th>(11)  
    <th>Remark (if any) :         
    <td colspan="4"><textarea name="PV_OBSERV"  value="<%=PV_OBSERV%>  "cols="50" rows="10"  id="PV_OBSERV" ></textarea>
        </tr>
  <tr>
    <td colspan="6"><div align="center">
      <input name="ins" type="hidden" id="ins">
      <input name="Submit" type="submit" class="button"   value="Save Data"/>
    </div></td>
  </tr>
</table>
<%
	 
	 
	 try {
      if (MultipartFormDataRequest.isMultipartFormData(request))
      {
	  
         MultipartFormDataRequest mrequest = new MultipartFormDataRequest(request);
         String todo = null;
         if (mrequest != null) todo = mrequest.getParameter("todo");
	     if ( (todo != null) && (todo.equalsIgnoreCase("upload")) )
	     {
                Hashtable files = mrequest.getFiles();
							
                if ( (files != null) && (!files.isEmpty()))
                {
                    UploadFile file = (UploadFile) files.get("uploadfile");
					
					String ext=getExtension(file.getFileName());
					
					if (ext.equals("jpg")||ext.equals("jpeg")||ext.equals("pdf")) {
					 upBean.store(mrequest, "uploadfile");
						String maxID="";
						 ResultSet rsMax = db.execSQL("SELECT APPUPLOAD_SEQ.NEXTVAL AS MAX_ID FROM DUAL");
						 
						 while (rsMax.next()) {
						 maxID=rsMax.getString(1);
						 }
						
						rsMax.close();
						
						String frenNm="PHYV"+maxID+"."+ext;
						
						
						File f = new File(a+file.getFileName()+"");
						
						boolean success =f.renameTo(new File(a+frenNm+""));
						//update data in database
						
						

						PHTR_ID=(String) mrequest.getParameter("PHTR_ID")==null?"":(String) mrequest.getParameter("PHTR_ID").trim();
PV_DT=(String) mrequest.getParameter("PV_DT")==null?"":(String) mrequest.getParameter("PV_DT").trim();
PV_VAR_OFF=(String) mrequest.getParameter("PV_VAR_OFF")==null?"":(String) mrequest.getParameter("PV_VAR_OFF").trim();
PV_VAR_DES=(String) mrequest.getParameter("PV_VAR_DES")==null?"":(String) mrequest.getParameter("PV_VAR_DES").trim();
PV_AGENCY=(String) mrequest.getParameter("PV_AGENCY")==null?"":(String) mrequest.getParameter("PV_AGENCY").trim();
PHY_PROD=(String) mrequest.getParameter("PHY_PROD")==null?"":(String) mrequest.getParameter("PHY_PROD").trim();
PHY_SALES=(String) mrequest.getParameter("PHY_SALES")==null?"":(String) mrequest.getParameter("PHY_SALES").trim();
PHY_EMP_PT=(String) mrequest.getParameter("PHY_EMP_PT")==null?"":(String) mrequest.getParameter("PHY_EMP_PT").trim();
PHY_EMP_FT=(String) mrequest.getParameter("PHY_EMP_FT")==null?"":(String) mrequest.getParameter("PHY_EMP_FT").trim();
START_DT=(String) mrequest.getParameter("START_DT")==null?"":(String) mrequest.getParameter("START_DT").trim();
PRODUCT_DETAIL=(String) mrequest.getParameter("PRODUCT_DETAIL")==null?"":(String) mrequest.getParameter("PRODUCT_DETAIL").trim();
PHY_INV=(String) mrequest.getParameter("PHY_INV")==null?"":(String) mrequest.getParameter("PHY_INV").trim();
PHY_ANL_TO=(String) mrequest.getParameter("PHY_ANL_TO")==null?"":(String) mrequest.getParameter("PHY_ANL_TO").trim();
PV_STATUS=(String) mrequest.getParameter("PV_STATUS")==null?"":(String) mrequest.getParameter("PV_STATUS").trim();
PV_VER_OFF=(String) mrequest.getParameter("PV_VER_OFF")==null?"":(String) mrequest.getParameter("PV_VER_OFF").trim();
PV_OBSERV=(String) mrequest.getParameter("PV_OBSERV")==null?"":(String) mrequest.getParameter("PV_OBSERV").trim();
REP_UPLOAD_FNM=(String) mrequest.getParameter("REP_UPLOAD_FNM")==null?"":(String) mrequest.getParameter("REP_UPLOAD_FNM").trim();
ACT_YN_PH=(String) mrequest.getParameter("ACT_YN_PH")==null?"":(String) mrequest.getParameter("ACT_YN_PH").trim();

		MACHIN_AVAIL_YN=(String) request.getParameter("MACHIN_AVAIL_YN")==null?"":(String) request.getParameter("MACHIN_AVAIL_YN").trim();
MACHIN_AVAIL_DTL=(String) request.getParameter("MACHIN_AVAIL_DTL")==null?"":(String) request.getParameter("MACHIN_AVAIL_DTL").trim();
MACHIN_AVAIL_OBS=(String) request.getParameter("MACHIN_AVAIL_OBS")==null?"":(String) request.getParameter("MACHIN_AVAIL_OBS").trim();
MACHIN_AVAIL_RECOM=(String) request.getParameter("MACHIN_AVAIL_RECOM")==null?"":(String) request.getParameter("MACHIN_AVAIL_RECOM").trim();
PROD_PROC=(String) request.getParameter("PROD_PROC")==null?"":(String) request.getParameter("PROD_PROC").trim();
PROD_PROC_DTL=(String) request.getParameter("PROD_PROC_DTL")==null?"":(String) request.getParameter("PROD_PROC_DTL").trim();
PROD_PROC_OBS=(String) request.getParameter("PROD_PROC_OBS")==null?"":(String) request.getParameter("PROD_PROC_OBS").trim();
PROD_PROC_RECOM=(String) request.getParameter("PROD_PROC_RECOM")==null?"":(String) request.getParameter("PROD_PROC_RECOM").trim();
QUALITY_CONTROL=(String) request.getParameter("QUALITY_CONTROL")==null?"":(String) request.getParameter("QUALITY_CONTROL").trim();
QUALITY_CONTROL_DTL=(String) request.getParameter("QUALITY_CONTROL_DTL")==null?"":(String) request.getParameter("QUALITY_CONTROL_DTL").trim();
QUALITY_CONTROL_OBS=(String) request.getParameter("QUALITY_CONTROL_OBS")==null?"":(String) request.getParameter("QUALITY_CONTROL_OBS").trim();
QUALITY_CONTROL_RECOM=(String) request.getParameter("QUALITY_CONTROL_RECOM")==null?"":(String) request.getParameter("QUALITY_CONTROL_RECOM").trim();
PRODUCT_PKG=(String) request.getParameter("PRODUCT_PKG")==null?"":(String) request.getParameter("PRODUCT_PKG").trim();
PRODUCT_PKG_DTL=(String) request.getParameter("PRODUCT_PKG_DTL")==null?"":(String) request.getParameter("PRODUCT_PKG_DTL").trim();
PRODUCT_PKG_OBS=(String) request.getParameter("PRODUCT_PKG_OBS")==null?"":(String) request.getParameter("PRODUCT_PKG_OBS").trim();
PRODUCT_PKG_RECOM=(String) request.getParameter("PRODUCT_PKG_RECOM")==null?"":(String) request.getParameter("PRODUCT_PKG_RECOM").trim();
MKTCHANL_ADPT_YN=(String) request.getParameter("MKTCHANL_ADPT_YN")==null?"":(String) request.getParameter("MKTCHANL_ADPT_YN").trim();
MKTCHANL_ADPT_DTL=(String) request.getParameter("MKTCHANL_ADPT_DTL")==null?"":(String) request.getParameter("MKTCHANL_ADPT_DTL").trim();
MKTCHANL_ADPT_OBS=(String) request.getParameter("MKTCHANL_ADPT_OBS")==null?"":(String) request.getParameter("MKTCHANL_ADPT_OBS").trim();
MKTCHANL_ADPT_RECOM=(String) request.getParameter("MKTCHANL_ADPT_RECOM")==null?"":(String) request.getParameter("MKTCHANL_ADPT_RECOM").trim();
LICEN_OBTN_YN=(String) request.getParameter("LICEN_OBTN_YN")==null?"":(String) request.getParameter("LICEN_OBTN_YN").trim();
LICEN_OBTN_DTL=(String) request.getParameter("LICEN_OBTN_DTL")==null?"":(String) request.getParameter("LICEN_OBTN_DTL").trim();
LICEN_OBTN_OBS=(String) request.getParameter("LICEN_OBTN_OBS")==null?"":(String) request.getParameter("LICEN_OBTN_OBS").trim();
LICEN_OBTN_RECOM=(String) request.getParameter("LICEN_OBTN_RECOM")==null?"":(String) request.getParameter("LICEN_OBTN_RECOM").trim();
QUALITY_CERT_YN=(String) request.getParameter("QUALITY_CERT_YN")==null?"":(String) request.getParameter("QUALITY_CERT_YN").trim();
QUALITY_CERT_DTL=(String) request.getParameter("QUALITY_CERT_DTL")==null?"":(String) request.getParameter("QUALITY_CERT_DTL").trim();
QUALITY_CERT_OBS=(String) request.getParameter("QUALITY_CERT_OBS")==null?"":(String) request.getParameter("QUALITY_CERT_OBS").trim();
QUALITY_CERT_RECOM=(String) request.getParameter("QUALITY_CERT_RECOM")==null?"":(String) request.getParameter("QUALITY_CERT_RECOM").trim();				
						
						
						
						
						
						
						
						
						StringBuffer qryUpdate = new StringBuffer();
	pstm.clear();
    values.clear();
	
	
		



	ResultSet rs1=db.execSQL("select PVMON_SEQ.NEXTVAL from DUAL");
	while (rs1.next()) {
PHTR_ID=rs1.getString(1);
}
rs1.close();
 qryUpdate.append("INSERT INTO MONITORING_PV_DETAIL ( ");
qryUpdate.append("PVTIME_STAMP,");
qryUpdate.append("APP_ID,");
qryUpdate.append("PV_DT,");
//qryUpdate.append("PV_VAR_OFF,");
qryUpdate.append("PV_VAR_DES,");
qryUpdate.append("PV_AGENCY,");

//qryUpdate.append("PHY_PROD,");
//qryUpdate.append("PHY_SALES,");
qryUpdate.append("PHY_EMP_PT,");
qryUpdate.append("PHY_EMP_FT,");
qryUpdate.append("START_DT,");
qryUpdate.append("PRODUCT_DETAIL,");

//qryUpdate.append("PHY_INV,");
qryUpdate.append("PHY_ANL_TO,");
qryUpdate.append("PV_STATUS,");
qryUpdate.append("PV_VER_OFF,");

qryUpdate.append("PV_OBSERV,");
qryUpdate.append("REP_UPLOAD_FNM,");
qryUpdate.append("ACT_YN_PH,");

qryUpdate.append("MACHIN_AVAIL_YN,");
qryUpdate.append("MACHIN_AVAIL_DTL,");
qryUpdate.append("MACHIN_AVAIL_OBS,");
qryUpdate.append("MACHIN_AVAIL_RECOM,");
qryUpdate.append("PROD_PROC,");
qryUpdate.append("PROD_PROC_DTL,");
qryUpdate.append("PROD_PROC_OBS,");
qryUpdate.append("PROD_PROC_RECOM,");
qryUpdate.append("QUALITY_CONTROL,");
qryUpdate.append("QUALITY_CONTROL_DTL,");
qryUpdate.append("QUALITY_CONTROL_OBS,");
qryUpdate.append("QUALITY_CONTROL_RECOM,");
qryUpdate.append("PRODUCT_PKG,");
qryUpdate.append("PRODUCT_PKG_DTL,");
qryUpdate.append("PRODUCT_PKG_OBS,");
qryUpdate.append("PRODUCT_PKG_RECOM,");
qryUpdate.append("MKTCHANL_ADPT_YN,");
qryUpdate.append("MKTCHANL_ADPT_DTL,");
qryUpdate.append("MKTCHANL_ADPT_OBS,");
qryUpdate.append("MKTCHANL_ADPT_RECOM,");
qryUpdate.append("LICEN_OBTN_YN,");
qryUpdate.append("LICEN_OBTN_DTL,");
qryUpdate.append("LICEN_OBTN_OBS,");
qryUpdate.append("LICEN_OBTN_RECOM,");
qryUpdate.append("QUALITY_CERT_YN,");
qryUpdate.append("QUALITY_CERT_DTL,");
qryUpdate.append("QUALITY_CERT_OBS,");
qryUpdate.append("QUALITY_CERT_RECOM,");

 qryUpdate.append("PHTR_ID)");
qryUpdate.append(" VALUES (SYSDATE,?,?,?,? ,?,?,?,?,? ,?,?,?,?,? ,?,?,?,?,?,  ?,?,?,?,?,?,?,?,?,?, ?,?,?,?,?,?,?,?,?,?, ?,?,?,?,?,?,?,?) ");



 

values.add(APP_ID); pstm.add ("L");
values.add(PV_DT); pstm.add ("L");
//values.add(PV_VAR_OFF); pstm.add ("L");
values.add(PV_VAR_DES); pstm.add ("L");
values.add(PV_AGENCY); pstm.add ("L");

//values.add(PHY_PROD); pstm.add ("L");
//values.add(PHY_SALES); pstm.add ("L");
values.add(PHY_EMP_PT); pstm.add ("L");
values.add(PHY_EMP_FT); pstm.add ("L");
values.add(START_DT); pstm.add ("L");
values.add(PRODUCT_DETAIL); pstm.add ("L");

//values.add(PHY_INV); pstm.add ("L");
values.add(PHY_ANL_TO); pstm.add ("L");
values.add(PV_STATUS); pstm.add ("L");
values.add(PV_VER_OFF); pstm.add ("L");

values.add(PV_OBSERV); pstm.add ("L");
values.add(frenNm); pstm.add ("L");
//values.add(ACT_YN_PH); pstm.add ("L");

values.add(MACHIN_AVAIL_YN); pstm.add ("L");
values.add(MACHIN_AVAIL_DTL); pstm.add ("L");
values.add(MACHIN_AVAIL_OBS); pstm.add ("L");
values.add(MACHIN_AVAIL_RECOM); pstm.add ("L");
values.add(PROD_PROC); pstm.add ("L");
values.add(PROD_PROC_DTL); pstm.add ("L");
values.add(PROD_PROC_OBS); pstm.add ("L");
values.add(PROD_PROC_RECOM); pstm.add ("L");
values.add(QUALITY_CONTROL); pstm.add ("L");
values.add(QUALITY_CONTROL_DTL); pstm.add ("L");
values.add(QUALITY_CONTROL_OBS); pstm.add ("L");
values.add(QUALITY_CONTROL_RECOM); pstm.add ("L");
values.add(PRODUCT_PKG); pstm.add ("L");
values.add(PRODUCT_PKG_DTL); pstm.add ("L");
values.add(PRODUCT_PKG_OBS); pstm.add ("L");
values.add(PRODUCT_PKG_RECOM); pstm.add ("L");
values.add(MKTCHANL_ADPT_YN); pstm.add ("L");
values.add(MKTCHANL_ADPT_DTL); pstm.add ("L");
values.add(MKTCHANL_ADPT_OBS); pstm.add ("L");
values.add(MKTCHANL_ADPT_RECOM); pstm.add ("L");
values.add(LICEN_OBTN_YN); pstm.add ("L");
values.add(LICEN_OBTN_DTL); pstm.add ("L");
values.add(LICEN_OBTN_OBS); pstm.add ("L");
values.add(LICEN_OBTN_RECOM); pstm.add ("L");
values.add(QUALITY_CERT_YN); pstm.add ("L");
values.add(QUALITY_CERT_DTL); pstm.add ("L");
values.add(QUALITY_CERT_OBS); pstm.add ("L");
values.add(QUALITY_CERT_RECOM); pstm.add ("L");





values.add(PHTR_ID); pstm.add ("L");
db.setSqlValue(qryUpdate.toString());

db.setValues(values,pstm);
db.executeUpdate() ;
db.close();
response.sendRedirect("savemsg.jsp");
			}//end of validation if
						
						

						}
						}
						}
	 }
			
						
 catch (Exception e) {
out.print (e.toString());
}finally{

}
	 
	   %>


</form>
</body>
</html>
