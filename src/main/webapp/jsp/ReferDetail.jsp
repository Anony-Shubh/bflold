<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.io.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.io.BufferedReader"%>

<%@ page import="pkgPmegpNew.DBCon"%>
<html>
<head>
    <%
    response.setHeader("Cache-Control", "no-cache");
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
    %>
	
<%!
 public String getDate(String str){
 str=str.trim();
SimpleDateFormat sdfSource = new SimpleDateFormat("dd-MM-yyyy");
try{
     Date date = sdfSource.parse(str);
	 
     SimpleDateFormat sdfDestination = new SimpleDateFormat("dd-MMM-yyyy");
	  str=sdfDestination.format(date);
	  }catch(Exception e){}
	 return(str); 
	 
}
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
    <title>upload </title>
	<SCRIPT language="javascript" src="../js/inlineMsgMain.js"></SCRIPT>
	<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
	<script src="../js/ModalPopupWindow.js" type="text/javascript"></script>
<script language="javascript">
function isDate(txtDate) {
    var objDate,  // date object initialized from the txtDate string
        mSeconds, // txtDate in milliseconds
        day,      // day
        month,    // month
        year;     // year
    // date length should be 10 characters (no more no less)
    if (txtDate.length !== 10) {
        return false;
    }
    // third and sixth character should be '/'
    if (txtDate.substring(2, 3) !== '-' || txtDate.substring(5, 6) !== '-') {
        return false;
    }
    // extract month, day and year from the txtDate (expected format is mm/dd/yyyy)
    // subtraction will cast variables to integer implicitly (needed
    // for !== comparing)
    month = txtDate.substring(3, 5) - 1; // because months in JS start from 0
    day = txtDate.substring(0, 2) - 0;
    year = txtDate.substring(6, 10) - 0;
    // test year range
    if (year < 1000 || year > 3000) {
        return false;
    }
    // convert txtDate to milliseconds
    mSeconds = (new Date(year, month, day)).getTime();
    // initialize Date() object from calculated milliseconds
    objDate = new Date();
    objDate.setTime(mSeconds);
    // compare input date and parts from Date() object
    // if difference exists then date isn't valid
    if (objDate.getFullYear() !== year ||
        objDate.getMonth() !== month ||
        objDate.getDate() !== day) {
        return false;
    }
    // otherwise return true
    return true;
}


function checkDateAge(){
	var DOB='DOB';
    var t=document.getElementById(DOB+"").value;
        if (!isDate(t)){
    inlineMsg('DOB','<Strong><U>Invalid Date</U> </strong><br>Date Format should be DD-MM-YYYY <br> Ex:30-03-2011',2);
			}else{
				var now = new Date();
				bDay=t;
				bD = bDay.split('-');
				 born = new Date(bD[2], bD[1] * 1 - 1, bD[0]);
                 years = Math.floor((now.getTime() - born.getTime()) / (365.25 * 24 * 60 * 60 * 1000));
				 if (Number(years)<18){
				     inlineMsg('AGE','<Strong><U>Under Age:</U> </strong><br> Age Must be  18 Years or above..',2);

                 }
				 document.form.AGE.value=years;
				}

}


window.onunload = refreshParent;
    function refreshParent() {
      window.opener.location.reload();
    }
	
function submit_form() {
	var numberOnly=/^[0-9]*$/;
	var ACTIVITY_CD=document.form.ACTIVITY_CD.value;

	var DOB=document.form.DOB.value;

	var MOB_NO1=document.form.MOB_NO1.value;

	


 if(DOB == "") {
	  
    inlineMsg('DOB','Enter Date of Birth in DD-MON-YYYY Format',2);
    return false;
  }

   if(MOB_NO1 == "") {
	  
    inlineMsg('MOB_NO1','Enter Mobile No',2);
    return false;
  }

  
   if(!numberOnly.test(MOB_NO1))
    {
	    inlineMsg('MOB_NO1','Enter Valid mobile No. in numbers',2);
        return false;
    }
	if(MOB_NO1.length !=10)
    {
	    inlineMsg('MOB_NO1','Enter 10 digit Mobile No.',2);
        return false;
    }

 if(ACTIVITY_CD == "" ) {
    inlineMsg('btnActList','Select the Industry & Activity from the list , In  Case No Suitable Industry Found, Select <strong> Other Industry </strong> from the List and Enter Product Description Manually',2);
    return false;
  }



	document.form.ins.value='I';
	document.form.submit();
	
}
</script>
</head>

<body onLoad="checkDateAge()";>
<form method="post" action="ReferDetail.jsp" name="form" id="form" class="form"  >


	  <p>
	    <%
		
		String APP_ID= request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID");
		String vOffcd= (String) session.getAttribute("off_cd");
        String APP_NAME="";
        String SUB_DT="";
		String MOB_NO1="";
		String E_MAIL="";
		String AADHAR_NO="";
		String UP_ID = "";
		String UPM_CD = "";
		String DOC_NAME = "";
		String DOC_REMARKS = "";
		
		String AGE = "";
		String ACTIVITY_CD = "";
		String DOB = "";
		String ORG_CD = "";
			String Activity_desc = "";
			String sOFF_TYPE_CD=(String) session.getAttribute("sOFF_TYPE_CD");
			String sdistrict_cd =(String) session.getAttribute("sdistrict_cd");
			String sagency_type=(String) session.getAttribute("sagency_type");
			String vwhereqry="";
			String vUserID=(String)session.getAttribute("user_id");
			if (sOFF_TYPE_CD.equals("2")){
			 vwhereqry =" AND MOM.DISTRICT_CD= "+sdistrict_cd+"  AND A.APP_ID='"+APP_ID+"' ";
			}else{
			vwhereqry =" AND MOM.USER_ID= "+vUserID+"  AND A.APP_ID='"+APP_ID+"' ";
			}
        DBCon db= new DBCon();
        db.connect();

         

           StringBuffer qry = new StringBuffer();
         qry.append(" SELECT A.APP_ID, ");
		  qry.append(" UPPER(A.APP_NAME) AS APP_NAME,  ");
		   qry.append("  TO_CHAR(A.ONLINE_SUBDT, 'DD-MON-RRRR HH:MI:SS') AS ONLINE_SUB_DT, TRUNC((SYSDATE-A.DOB)/365) AS AGE, ");
		    qry.append("  A.MOB_NO1,MOM.ORG_CD, ");
			 qry.append(" TO_CHAR(A.DOB,'DD-MM-RRRR') AS DOB,  A.ACTIVITY_CD,AM.ACTIVITY_NAME ");
			  qry.append(" FROM APP_DETAIL A,ACTIVITY_MAST AM,MAS_OFF_MAST MOM,BANK_DATAENTRY BD ");
			  qry.append(" WHERE A.APP_ID=BD.APP_ID AND A.ACTIVITY_CD=AM.ACTIVITY_CD AND BD.PACT_ID=30 AND BD.APPRV_YN='A' AND A.OFF_CD=MOM.OFF_CD  "+vwhereqry+" ");
//out.print(qry.toString());
        ResultSet rsApp = db.execSQL(qry.toString());
		
		
        while (rsApp.next()){
		APP_ID=rsApp.getString("APP_ID")==null?"":rsApp.getString("APP_ID");
        APP_NAME=rsApp.getString("APP_NAME")==null?"":rsApp.getString("APP_NAME");
        AGE=rsApp.getString("AGE")==null?"":rsApp.getString("AGE");
	  MOB_NO1=rsApp.getString("MOB_NO1")==null?"":rsApp.getString("MOB_NO1");
		 DOB=rsApp.getString("DOB")==null?"":rsApp.getString("DOB");
		 ACTIVITY_CD=rsApp.getString("ACTIVITY_CD")==null?"":rsApp.getString("ACTIVITY_CD");
		 Activity_desc=rsApp.getString("ACTIVITY_NAME")==null?"":rsApp.getString("ACTIVITY_NAME");
		 ORG_CD=rsApp.getString("ORG_CD")==null?"":rsApp.getString("ORG_CD");
		
        }
			rsApp.close();
			
        %>
  </p>
	  <table align="center">
        <tr>
          <th colspan="2" scope="col"><div align="center">ONLINE APPLICANT DETAIL UPDATE FORM </div></th>
        </tr>
        <tr>
          <td colspan="2" scope="col"><div align="center"></div></td>
        </tr>
        <tr>
          <td colspan="2" scope="col">
             </td>
        </tr>
        
       
        <tr>
          <th scope="col"> Applicant ID 
          
          <input name="ins" type="hidden" id="ins" value=""></th>
          <th scope="col"><%= APP_ID %> </th>
        </tr>
        <tr>
          <th>Name </th>
          <th>
              <div align="left"><%= APP_NAME %> </div></th>
        </tr> 
       
       
		  <tr>
          <th>Date Of Birth </th>
          <td>
		  <input name="DOB" type="text" class="mob"  id="DOB" onBlur="checkDateAge();" onKeyPress="return onlyDate(event);"  size="13" maxlength="10" value="<%= DOB %>" />
      Age:
      <input name="AGE" type="text" id="AGE" size="5" maxlength="3" readonly="true" 
	  />
	  
	   <input name="ORG_CD" type="hidden" id="ORG_CD" size="5" maxlength="3" value="<%=ORG_CD%>">
		  
		  
		  
		  </td>
        </tr>
		  <tr>
          <th>Mobile No </th>
          <td> <input name="MOB_NO1" type="text" class="mob"  id="MOB_NO1" onKeyPress="return numbersonly(event);"  size="14" maxlength="10" value="<%=MOB_NO1%>" /></td>
        </tr>
		  <tr>
          <th>Activity</th>
          <td> <input name="ACTIVITY_CD" type="hidden" id="ACTIVITY_CD" value="<%=ACTIVITY_CD  %>" />
		  <input name="Activity_desc" type="text" id="Activity_desc" style="background-color: #FFCCCC" value="<%= Activity_desc  %> " size="60" readonly="true" />
		   <input name="btnActList" type="button" class="button" id="btnActList"  onClick="activity();"  value="Select Industry / Activity" /></td>
        </tr>
        <tr>
          <th colspan="2"><div align="center">
            <input name="btnUpload" type="button" class="button" id="btnUpload" value="UPDATE" onClick="submit_form();">
          </div></th>
        </tr>
      
		 
	 
	 
      </table>
	 <%
	 if ((String)request.getParameter("ins")!=null){	
	
	 	
						MOB_NO1=(String) request.getParameter("MOB_NO1")==null?"":(String) request.getParameter("MOB_NO1").trim();
						APP_ID=(String) request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID").trim();
						ACTIVITY_CD=(String) request.getParameter("ACTIVITY_CD")==null?"":(String) request.getParameter("ACTIVITY_CD").trim();
						DOB=(String) request.getParameter("DOB")==null?"":(String) request.getParameter("DOB").trim();
						
						StringBuffer qryUpdate = new StringBuffer();
						
							List values=new ArrayList();
							List pstm=new ArrayList();
						
						qryUpdate.append("UPDATE APP_DETAIL SET  ");
qryUpdate.append("MOB_NO1=?,");
qryUpdate.append("ACTIVITY_CD=?,");
qryUpdate.append("DOB=? ");
qryUpdate.append("WHERE APP_ID=? ");

						
						values.add (MOB_NO1);pstm.add ("S");
						values.add (ACTIVITY_CD);pstm.add ("S");
						values.add(getDate(DOB)); pstm.add ("L");
						values.add (APP_ID);pstm.add ("S");
		               
						db.setValues(values,pstm);
						db.setSqlValue(qryUpdate.toString());
						db.executeUpdate() ;
						pstm.clear();
							values.clear();	
							db.close();
							response.sendRedirect("savemsg.jsp");
							//out.print("successfully uploaded");
						
						
			try {
			db.close();
			}catch(Exception k) {out.print (k.toString());}
						
} 
	 
	   %>
	   <input id="APP_ID" name="APP_ID" type="hidden" value="<%=APP_ID%>"> 
</form>
<script>
 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 //Uncomment below line to make look buttons as link
 //modalWin.SetButtonStyle("background:none;border:none;textDecoration:underline;cursor:pointer");

function activity(){

var AGENCY= document.form.ORG_CD.value;
 var urlpar='PMEGPlovpage.jsp?AGENCY='+AGENCY;
 var callbackFunctionArray = new Array(EnrollNow, EnrollLater);
 modalWin.ShowURL(urlpar,600,1000,'Find Bank Details',null,callbackFunctionArray);
 }//end of bank
 
 
 function EnrollNow(msg){
modalWin.HideModalPopUp();
modalWin.ShowMessage(msg,200,400,'User Information',null,null);
}


function EnrollLater(){
modalWin.HideModalPopUp();
modalWin.ShowMessage(msg,200,400,'User Information',null,null);
}

function HideModalWindow() {
    modalWin.HideModalPopUp();
}

 </script>

</body>
</html>