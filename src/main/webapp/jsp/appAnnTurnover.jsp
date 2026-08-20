<%@ include file="appIncludeHeaderPage.jsp" %>
<script language="javascript">

function submit_offupdate() {
var numberOnly= /^[0-9 \.-]+$/;
var MOB_NO1=document.form1.MOB_NO1.value;
var UNIT_NAME=document.form1.UNIT_NAME.value;
var UNIT_POST_ADDR=document.form1.UNIT_POST_ADDR.value;

var ESTB_MN=document.form1.ESTB_MN.value;
var ESTB_YR=document.form1.ESTB_YR.value;




   if(MOB_NO1 == "") {
    inlineMsg('MOB_NO1','Enter MObile No....',2);
    return false;
  }
  if(MOB_NO1 !="" && MOB_NO1.length < 10 ) {
				inlineMsg('MOB_NO1','Enter Valid Mobile No...',2);
				return false;
			  }
  
   if (!numberOnly.test(Number(MOB_NO1))) { inlineMsg ( 'MOB_NO1','INVALID MOBILE NO',2);	return (false);}
   
  if(UNIT_NAME == "") {
    inlineMsg('UNIT_NAME','Enter Unit Name......',2);
    return false;
  } 
  
     if(UNIT_POST_ADDR == "") {
    inlineMsg('UNIT_POST_ADDR','Enter Unit Address....',2);
    return false;
  }
  if(ESTB_MN == "") {
    inlineMsg('ESTB_MN','Enter Unit Establishment Month......',2);
    return false;
  } 
  
     if(ESTB_YR == "") {
    inlineMsg('ESTB_YR','Enter Establishment Year...',2);
    return false;
  }
 
document.form1.ins.value='I'; 
document.form1.submit(); 

 }
//end of function

 

</script>




<body >

<form  action="appAnnTurnover.jsp" method="post" name="form1" id="form1"  >

<% 



String ACT_YN = "Y";
String EMAIL_SENT = "";
String GR_TIMESTAMP = "";
String APP_ID =vAppid;
String APP_NAME=vAppName;

String msg="";
String OFF_EMAIL_ADDR = "";
String AGENCY_TYPE = "";
String OFF_NAME1 = "";
String E_MAIL = "";
String BR_NAME="";
String EMAIL="";
String ACT_ID="";
String IFSC_CODE="";
String OFF_CD="";
String PROD_DESC="";
String UNIT_NAME="";

String ACTIVITY_NAME="";
String ACTIVITY_CD="";
String UNIT_POST_ADDR="";
String IND_TYPE ="";
String MOB_NO1="";
String EMAIL_YN="";	
String Activity_desc="";
 String ESTB_MN=""; 
 String ESTB_YR="";

String ATO_16="";
String ATO_17="";
String ATO_18="";
String ATO_19="";
String ATO_20="";
String ATO_21="";

String IND_DESC="";
	
DBCon db= new DBCon();
db.connect();

StringBuffer qrysb= new StringBuffer();


qrysb.append("   SELECT AD.ACTIVITY_CD,DECODE(PAT.MOB_NO,NULL,AD.MOB_NO1,PAT.MOB_NO) AS MOB_NO1,  DECODE(PAT.UNIT_ADDRS,NULL,ad.UNIT_POST_ADDR ");
qrysb.append("  || ' '");
qrysb.append("  || ad.UNIT_TALUK_BLOCK");
qrysb.append("  || ' Dist:'");
 qrysb.append(" || MD.DISTRICT_NAME");
 qrysb.append(" || ' Pin:'");
 qrysb.append(" || ad.UNIT_PIN ,   PAT.UNIT_ADDRS)                                   AS unit_addr,AM.ACTIVITY_NAME,");
 qrysb.append(" UPPER(ad.UNIT_TALUK_BLOCK)                           AS UNIT_TALUK_BLOCK,");
 qrysb.append("  DECODE(ad.IND_TYPE, 'S', 'Service', 'Manufacturing') AS IND_DESC,AD.IND_TYPE,DECODE(PAT.PROD_DESC,NULL,AD.PROD_DESC,PAT.PROD_DESC) AS PROD_DESC, "      );
qrysb.append("     DECODE(PAT.EMAIL,NULL,AD.E_MAIL,PAT.EMAIL) AS E_MAIL ,PAT.UNIT_NAME,  PAT.UNIT_ADDRS,  PAT.ATO_16,  PAT.ATO_18,  PAT.ATO_17,  PAT.ATO_19,  PAT.ATO_20, PAT.ESTB_MN,  PAT.ESTB_YR"      );
qrysb.append("   FROM APP_DETAIL AD,M_DISTRICT MD,PMEGP_ANNUAL_TURNOVER PAT,"      );
qrysb.append("   ACTIVITY_MAST AM "      );
qrysb.append("   WHERE AD.UNIT_DIST_CD = MD.DISTRICT_CD AND AD.ACTIVITY_CD=AM.ACTIVITY_CD AND  AD.APP_ID     = PAT.APP_ID(+)"      );
qrysb.append("   AND AD.APP_ID   = '"+APP_ID+"'   "      );

//out.print(qrysb.toString());
ResultSet rsMain = db.execSQL(qrysb.toString());

while (rsMain.next()){

ACTIVITY_CD=rsMain.getString("ACTIVITY_CD")==null?"":rsMain.getString("ACTIVITY_CD");
MOB_NO1=rsMain.getString("MOB_NO1")==null?"":rsMain.getString("MOB_NO1");
UNIT_POST_ADDR=rsMain.getString("unit_addr")==null?"":rsMain.getString("unit_addr");
E_MAIL=rsMain.getString("E_MAIL")==null?"":rsMain.getString("E_MAIL");
ACTIVITY_NAME=rsMain.getString("ACTIVITY_NAME")==null?"":rsMain.getString("ACTIVITY_NAME");
PROD_DESC=rsMain.getString("PROD_DESC")==null?"":rsMain.getString("PROD_DESC");
IND_DESC=rsMain.getString("IND_DESC")==null?"":rsMain.getString("IND_DESC");
IND_TYPE=rsMain.getString("IND_TYPE")==null?"":rsMain.getString("IND_TYPE");
UNIT_NAME=rsMain.getString("UNIT_NAME")==null?"":rsMain.getString("UNIT_NAME");
ATO_16=rsMain.getString("ATO_16")==null?"":rsMain.getString("ATO_16");
ATO_17=rsMain.getString("ATO_17")==null?"":rsMain.getString("ATO_17");
ATO_18=rsMain.getString("ATO_18")==null?"":rsMain.getString("ATO_18");
ATO_19=rsMain.getString("ATO_19")==null?"":rsMain.getString("ATO_19");
ATO_20=rsMain.getString("ATO_20")==null?"":rsMain.getString("ATO_20");
ESTB_MN=rsMain.getString("ESTB_MN")==null?"":rsMain.getString("ESTB_MN");
ESTB_YR=rsMain.getString("ESTB_YR")==null?"":rsMain.getString("ESTB_YR");
}

rsMain.close();
		%>
		<table align="center">
<tr>
  <th colspan="5"><div align="center">Statement of Annual Turnover of PMEGP Units </div></th>
  </tr>
<tr>
  <th colspan="5"><div align="center"></div></th>
  </tr>
<tr>  </tr><input name="APP_ID" type="hidden" id="APP_ID" value="<%=APP_ID%>" >
<input name="APP_NAME" type="hidden" id="APP_NAME" value="<%=APP_NAME%>" >
  <tr>
    <th width="245">Application Id: </th>
    <th width="168"><%= APP_ID %></th>
    <th width="218">Applicant Name : </th>
    <th colspan="2"><%= APP_NAME  %></th>
    </tr>
  <tr> 
  <th>Email: </th>
  <th colspan="2">
    <input name="E_MAIL" type="text" id="E_MAIL" value="<%=E_MAIL%>" size="60" maxlength="60" >
	  </th>
 
  <th width="216">Mobile No:* </th>
  <th width="35"><input name="MOB_NO1" type="text" id="MOB_NO1" value="<%=MOB_NO1%>" maxlength="10" ></th>
</tr>
<tr>
  <th > Unit Name:* </th>
  <td colspan="4"><input name="UNIT_NAME" type="text" id="UNIT_NAME" value="<%=UNIT_NAME%>" size="50" maxlength="50" ></tr>  
<tr>
  <th>Unit Address:* </th>
  <td colspan="4"><input name="UNIT_POST_ADDR" type="text" id="UNIT_POST_ADDR" value="<%=UNIT_POST_ADDR%>" size="100" maxlength="100" ></td>
</tr>
<tr>
  <th>Unit Establishment Month:*</th>
  <td colspan="2"><select name="ESTB_MN" class="button" id="ESTB_MN" >
          <option value="" selected>Select</option>
          <option value="01" <% if (ESTB_MN.equals("1")){out.print("selected");}%>>JAN</option>
          <option value="02" <% if (ESTB_MN.equals("2")){out.print("selected");}%>>FEB</option>
		  <option value="03" <% if (ESTB_MN.equals("3")){out.print("selected");}%>>MAR</option>
          <option value="04" <% if (ESTB_MN.equals("4")){out.print("selected");}%>>APR</option>
		  <option value="05" <% if (ESTB_MN.equals("5")){out.print("selected");}%>>MAY</option>
		  <option value="06" <% if (ESTB_MN.equals("6")){out.print("selected");}%>>JUN</option>
          <option value="07" <% if (ESTB_MN.equals("7")){out.print("selected");}%>>JUL</option>
		  <option value="08" <% if (ESTB_MN.equals("8")){out.print("selected");}%>>AUG</option>
          <option value="09" <% if (ESTB_MN.equals("9")){out.print("selected");}%>>SEP</option>
		  <option value="10" <% if (ESTB_MN.equals("10")){out.print("selected");}%>>OCT</option>
          <option value="11 "<% if (ESTB_MN.equals("11")){out.print("selected");}%>>NOV</option>
		  <option value="12" <% if (ESTB_MN.equals("12")){out.print("selected");}%>>DEC</option>
        </select></td>
  <td>Unit Establishment Year* </td>
  <td><select name="ESTB_YR" class="button" id="ESTB_YR" >
          <option value="" selected>Select</option>
          <option value="2016" <% if (ESTB_YR.equals("2016")){out.print("selected");}%>>2016</option>
          <option value="2017" <% if (ESTB_YR.equals("2017")){out.print("selected");}%>>2017</option>
		  <option value="2018" <% if (ESTB_YR.equals("2018")){out.print("selected");}%>>2018</option>
          <option value="2019" <% if (ESTB_YR.equals("2019")){out.print("selected");}%>>2019</option>
		  <option value="2020" <% if (ESTB_YR.equals("2020")){out.print("selected");}%>>2020</option>
		  <option value="2021" <% if (ESTB_YR.equals("2021")){out.print("selected");}%>>2021</option>
        </select></td>
</tr>


<tr>
  <th>Industry Type : </th>
  <td colspan="4"><%=IND_DESC%> <input name="IND_TYPE" type="hidden" id="IND_TYPE" value="<%=IND_TYPE%>" /></td>
</tr>
<tr>
  <th>Activity:</th>
  <td colspan="4"> <!--<input name="btnActList" type="button" class="button" id="btnActList"  onClick="activity();"  value="Select Industry / Activity" />-->
        <input name="ACTIVITY_CD" type="hidden" id="ACTIVITY_CD" value="<%=ACTIVITY_CD%>" />

    <input name="ACTIVITY_NAME" type="text" id="ACTIVITY_NAME" style="background-color: #FFCCCC" value="<%= ACTIVITY_NAME%> " size="60" readonly="true" /></td>
</tr>
<tr>
  <th>Product Description (if Any) </th>
  <td colspan="4"><input name="PROD_DESC" type="text" id="PROD_DESC"  size="50" maxlength="50" onKeyPress="return RestrictSpecialChar(event);" value="<%=PROD_DESC  %>"/></td>
</tr>
<tr> <input type="hidden" name="ins" id="ins" value="" />
  <th colspan="5">&nbsp;</th>
  </tr>
<tr>
  <th colspan="5"><div align="center">Annual Turn Over (in Rs.) </div></th>
  </tr>
<tr>
  <th><div align="center">2016-17</div></th>
  <th><div align="center">2017-18</div></th>
  <th><div align="center">2018-19</div></th>
  <th><div align="center">2019-20</div></th>
  <th><div align="center">2020-21</div></th>
</tr>
<tr>
  <th><input name="ATO_16" type="text" id="ATO_16" value="<%=ATO_16%>" maxlength="10"></th>
  <th><input name="ATO_17" type="text" id="ATO_17" value="<%=ATO_17%>" maxlength="10"></th>
  <th><input name="ATO_18" type="text" id="ATO_18" value="<%=ATO_18%>" maxlength="10" ></th>
  <th><input name="ATO_19" type="text" id="ATO_19" value="<%=ATO_19%>" maxlength="10" ></th>
  <th><input name="ATO_20" type="text" id="ATO_20" value="<%=ATO_20%>" maxlength="10" ></th>
</tr>  
  
<tr>
  <th colspan="5"><div align="center" class="GreenLebel"></div></th>
</tr>
<tr><td colspan="5"><div align="center">
  <input name="Button" type="button" class="button" onClick="submit_offupdate();" value="Submit">
</div></td>
</tr>  
</table>
<%

try {
 if ((String)request.getParameter("ins")!=null){

 
APP_ID=(String) request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID").trim();
APP_NAME=(String) request.getParameter("APP_NAME")==null?"":(String) request.getParameter("APP_NAME").trim();
UNIT_NAME=(String) request.getParameter("UNIT_NAME")==null?"":(String) request.getParameter("UNIT_NAME").trim();
UNIT_POST_ADDR=(String) request.getParameter("UNIT_POST_ADDR")==null?"":(String) request.getParameter("UNIT_POST_ADDR").trim();
ACTIVITY_CD=(String) request.getParameter("ACTIVITY_CD")==null?"":(String) request.getParameter("ACTIVITY_CD").trim();
IND_TYPE=(String) request.getParameter("IND_TYPE")==null?"":(String) request.getParameter("IND_TYPE").trim();
PROD_DESC=(String) request.getParameter("PROD_DESC")==null?"":(String) request.getParameter("PROD_DESC").trim();
ESTB_MN=(String) request.getParameter("ESTB_MN")==null?"":(String) request.getParameter("ESTB_MN").trim();	

ESTB_YR=(String) request.getParameter("ESTB_YR")==null?"":(String) request.getParameter("ESTB_YR").trim();
E_MAIL=(String) request.getParameter("E_MAIL")==null?"":(String) request.getParameter("E_MAIL").trim();
MOB_NO1=(String) request.getParameter("MOB_NO1")==null?"":(String) request.getParameter("MOB_NO1").trim();
ATO_16=(String) request.getParameter("ATO_16")==null?"":(String) request.getParameter("ATO_16").trim();
ATO_17=(String) request.getParameter("ATO_17")==null?"":(String) request.getParameter("ATO_17").trim();
ATO_18=(String) request.getParameter("ATO_18")==null?"":(String) request.getParameter("ATO_18").trim();	

ATO_19=(String) request.getParameter("ATO_19")==null?"":(String) request.getParameter("ATO_19").trim();
ATO_20=(String) request.getParameter("ATO_20")==null?"":(String) request.getParameter("ATO_20").trim();
ATO_21=(String) request.getParameter("ATO_21")==null?"":(String) request.getParameter("ATO_21").trim();	

String NO_OF_APP="";

ResultSet rsMax = db.execSQL("select COUNT(*) AS NO_OF_APP  FROM PMEGP_ANNUAL_TURNOVER where app_id='"+APP_ID+"' ");
while (rsMax.next()) {
NO_OF_APP=rsMax.getString("NO_OF_APP")==null?"0":rsMax.getString("NO_OF_APP");
}
rsMax.close();

 List values=new ArrayList();
List pstm=new ArrayList();

   StringBuffer sb= new StringBuffer();
			 
if (NO_OF_APP.equals("0"))
{


 sb.append("  INSERT INTO PMEGP_ANNUAL_TURNOVER(APP_NAME,UNIT_NAME,  ");
 sb.append("  UNIT_ADDRS,ACTIVITY_CD,IND_TYPE,PROD_DESC,ESTB_MN,ESTB_YR,EMAIL,MOB_NO,  "); 
 sb.append("  ATO_16,ATO_17,ATO_18,ATO_19,ATO_20,TIME_STAMP,APP_ID) VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,SYSDATE,?)"); 
}
else
{
	  sb.append("   UPDATE  PMEGP_ANNUAL_TURNOVER SET APP_NAME=?, UNIT_NAME=?, UNIT_ADDRS=?,   ").
      append("    ACTIVITY_CD=?,  IND_TYPE=?,  PROD_DESC=?,  ESTB_MN=?, ESTB_YR=? ,EMAIL=?,   ").
	  append("    MOB_NO=?,  ATO_16=?,  ATO_17=?, ATO_18=? ,ATO_19=?,ATO_20=?,TIME_STAMP=SYSDATE WHERE  APP_ID=?      ");
}
        db.setSqlValue(sb.toString());
        db.setValues(values,pstm); 
		
  values.add(APP_NAME);pstm.add("D");
  values.add(UNIT_NAME);pstm.add("D");
  values.add(UNIT_POST_ADDR);pstm.add("D");
  values.add(ACTIVITY_CD);pstm.add("D");
  values.add(IND_TYPE);pstm.add("D");
  values.add(PROD_DESC);pstm.add("D");
  values.add(ESTB_MN);pstm.add("D");
  values.add(ESTB_YR);pstm.add("D");
  values.add(E_MAIL);pstm.add("D");
  values.add(MOB_NO1);pstm.add("D");
  
  values.add(ATO_16);pstm.add("D");
  values.add(ATO_17);pstm.add("D");  
  values.add(ATO_18);pstm.add("D");
	 values.add(ATO_19);pstm.add("D");
  values.add(ATO_20);pstm.add("D");  
  values.add(APP_ID);pstm.add("D");
db.executeUpdate();
  db.close();
  values.clear();
  pstm.clear();
db.close();
response.sendRedirect("appAnnTurnover.jsp");
//out.print ("<center><h1>Your Grievance has been successfully sent, Please verify your email ID for confirmation...........</h1><center>");
} //end ins


}//try
catch(Exception e)
{
out.println(e);
}
finally{
//db.close();
}





%>



















</form>

</body>
</html>
