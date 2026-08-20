<%@ page session="true" import="java.sql.*,java.math.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%
    response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
    %>
	<html>
<head>
<script src="https://code.jquery.com/jquery-1.12.3.js"></script>
<link href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="../css/dis.css">
<script type="text/javascript" src="../js/ModalPopupWindow.js"></script>
<script type="text/javascript">
function totprj() {
    var sum = 0;
    var cost = document.getElementsByName('PRJ_NO_TGT');
    for (var i = 0; i < cost.length; i++)
    {
        sum += parseFloat(cost[i].value);
    }
    document.getElementById('TOT_PRJ').value = sum;
	
}
function totmm() {
    var sum = 0;
    var cost = document.getElementsByName('MM_TGT');
    for (var i = 0; i < cost.length; i++)
    {
        sum += parseFloat(cost[i].value);
    }
    document.getElementById('TT_MM').value  = sum;
	
}
</script>
</head>
<body>
 
<form name="form" id="form" action="" class="form" method="post">  

<img src="../images/pmegponline.jpg" width="100%" height="150">

 <%@ include file="AppIncludePage.jsp" %>

  
		
    <center>
</p>

<%
String OFF_NM=request.getParameter("OFF_NAME")==null?"0":request.getParameter("OFF_NAME");
DBCon db= new DBCon();
db.connect();
int srn =0;
int vTotal_Prj=0;
BigDecimal vTotal_MM = new BigDecimal(0);
StringBuffer qrysb = new StringBuffer();
qrysb.append(" SELECT OFF_NAME1," );
qrysb.append(" DISTRICT_CD, " );
qrysb.append(" DISTRICT_NAME," );
qrysb.append(" sum((NVL(KVIC_PRJ_NO_TGT,0))+(NVL(KVIB_PRJ_NO_TGT,0))+(NVL(DIC_PRJ_NO_TGT,0)))" );
qrysb.append(" AS TOT_PRJ_NO_TGT, sum((NVL(KVIC_MM_TGT,0))+(NVL(KVIB_MM_TGT,0))+(NVL(DIC_MM_TGT,0)))" );
qrysb.append(" AS TOT_MM_TGT FROM ( SELECT OFF_NAME1, OFF_CD, DISTRICT_NAME,DISTRICT_CD," );
qrysb.append(" CASE WHEN AGENCY_TYPE='KVIC' THEN PRJ_NO_TGT ELSE 0 END KVIC_PRJ_NO_TGT, " );
qrysb.append(" CASE WHEN AGENCY_TYPE='KVIC' THEN MM_TGT ELSE 0 END KVIC_MM_TGT," );
qrysb.append(" CASE WHEN AGENCY_TYPE='KVIB' THEN PRJ_NO_TGT ELSE 0 END KVIB_PRJ_NO_TGT, " );
qrysb.append(" CASE WHEN AGENCY_TYPE='KVIB' THEN MM_TGT ELSE 0 END KVIB_MM_TGT, " );
qrysb.append(" CASE WHEN AGENCY_TYPE='DIC' THEN PRJ_NO_TGT ELSE 0 END DIC_PRJ_NO_TGT, " );
qrysb.append(" CASE WHEN AGENCY_TYPE='DIC' THEN MM_TGT ELSE 0 END DIC_MM_TGT " );
qrysb.append(" FROM(SELECT MOM.OFF_NAME1, MOM.AGENCY_TYPE, MD.DISTRICT_NAME, MOM.OFF_CD, MOM.DISTRICT_CD, " );
qrysb.append(" PMT.MM_TGT, PMT.PRJ_NO_TGT FROM MAS_OFF_MAST MOM, M_DISTRICT MD," );
qrysb.append(" M_STATE MS, PMEGP_MMTARGET PMT WHERE MOM.OFF_CD = PMT.OFF_CD(+) " );
qrysb.append(" AND MOM.DISTRICT_CD = MD.DISTRICT_CD AND MS.STATE_CD = MD.STATE_CD " );
qrysb.append(" AND MOM.ACT_YN = 'Y' AND MOM.OFF_TYPE_CD IN (2, 3, 5, 22) ) " );
qrysb.append(" WHERE OFF_NAME1= '"+OFF_NM+"' GROUP BY OFF_NAME1,AGENCY_TYPE,  DISTRICT_NAME," );
qrysb.append(" DISTRICT_CD, PRJ_NO_TGT,MM_TGT,OFF_CD ORDER BY " );
qrysb.append(" DISTRICT_NAME )GROUP BY DISTRICT_NAME,DISTRICT_CD,OFF_NAME1 ORDER BY OFF_NAME1 ASC" );

//out.print(qrysb.toString());
ResultSet rsMain = db.execSQL(qrysb.toString());


%>
<p></p>
<p></p>
<p></p>
<p></p>


<br/>
<input name="ins" type="hidden" id="ins" value="">

<br/>
<table id="example" class="display" cellspacing="0" width="100%">
        <thead>
            <tr>
			    <th>SR.NO</th>	
				<th>OFF_NAME</th>			
				<th>DISTRICT NAME</th>				
				<th>DISTRICT_CD</th>
				<th>TOTAL_NO_OF_PROJECT</th> 
				<th>TOTAL_MARGIN_MONEY</th>
				<th>UPDATE</th>
            </tr>
			
        </thead> 
        
		        <tbody>
		
       <% 
	  String OFF_CD="";	 
	  String OFF_NAME= ""; 
	  String DISTRICT_NAME= "";
	  String DISTRICT_CD= "";
	  String KVIC_PRJ_NO_TGT= "";
	  String KVIC_MM_TGT= "";
	  String KVIB_PRJ_NO_TGT= ""; 
	  String KVIB_MM_TGT= "";
	  String DIC_PRJ_NO_TGT= ""; 
	  String DIC_MM_TGT= "";
      String MMTGT_ID="";	
	  String TOT_PRJ_NO_TGT="";
	  String TOT_MM_TGT="";
	  while (rsMain.next()){
	   srn=srn+1;	  
	  OFF_NAME=rsMain.getString("OFF_NAME1")==null?"":rsMain.getString("OFF_NAME1");
	  DISTRICT_NAME =rsMain.getString("DISTRICT_NAME")==null?"":rsMain.getString("DISTRICT_NAME");
	  DISTRICT_CD=rsMain.getString("DISTRICT_CD")==null?"":rsMain.getString("DISTRICT_CD");	  
	  TOT_PRJ_NO_TGT=rsMain.getString("TOT_PRJ_NO_TGT")==null?"TOTAL":rsMain.getString("TOT_PRJ_NO_TGT");
	  TOT_MM_TGT=rsMain.getString("TOT_MM_TGT")==null?"0":rsMain.getString("TOT_MM_TGT");
	  vTotal_Prj=vTotal_Prj+Integer.parseInt(rsMain.getString("TOT_PRJ_NO_TGT")==null?"0":rsMain.getString("TOT_PRJ_NO_TGT"));
	  vTotal_MM=vTotal_MM.add(new BigDecimal(TOT_MM_TGT));
	  %>
      <tr>
			
                <td><div align="center"><%=srn%></div></td>
				<td><div align="center"><%= OFF_NAME  %></div></td>               
                <td><div align="center"><%= DISTRICT_NAME  %></div></td>						
				<td><div align="center"><%= DISTRICT_CD %></div></td>
				<td><div align="center"><%= TOT_PRJ_NO_TGT %></div></td>
                <td><div align="center"><%= TOT_MM_TGT %></div></td>
				<td><div align="center"><input name="btnBank3" type="button" class="button" id="btnBank3" onClick="update('<%= DISTRICT_CD %>','prod_Tar_update.jsp','<%= OFF_NAME%>','<%= DISTRICT_NAME%>');"  value="UPDATE" /></div></td>
				
            </tr>
			
			
			<%
			}
			rsMain.close();
			db.close();
			//out.print(vTotal_Prj);
			%>
            
        </tbody>
		<tr>
			<th colspan="4"><div align="right">Total</div></th>
			<td><div align="center"><input name="TOT_PRJ" type="text" id="TOT_PRJ" value="<%=vTotal_Prj%>" size="10" maxlength="6" readonly="readonly" ></div></td>
	        <td><div align="center"> <input name="TT_MM" type="text" id="TT_MM" value="<%=vTotal_MM%>" size="10" maxlength="6" readonly="readonly"></div></td> 
			</tr>
    </table>


  <p>&nbsp;</p>
  <p>&nbsp;</p>
 
			 
  <table class="pmegpTable"><br>
<tr>

<th>
 <center> <h2>For Technical issues contact email: pmegpeportal@kvic.gov.in and PMEGP Scheme related queries contact email: pmegp@kvic.gov.in</h2>
 </center>
  </th>
  </tr>
  </table>
 

</form>
<script language="javascript">
 var modalWin = new CreateModalPopUpObject();
 //var CERT_ID= form.CERT_ID.value;
 modalWin.SetLoadingImagePath("../images/loading.gif");
 modalWin.SetCloseButtonImagePath("../images/remove.gif");
 //Uncomment below line to make look buttons as link
 //modalWin.SetButtonStyle("background:none;border:none;textDecoration:underline;cursor:pointer");
//end of bank


function update(dis_cd,filename,off_nm,dis_nm){
var urlpar=filename+'?DISTRICT_CD='+dis_cd+'&OFF_NAME='+off_nm+'&DISTRICT_NAME='+dis_nm;
 var callbackFunctionArray = new Array(refresh_data);

 modalWin.ShowURL(urlpar,600,900,'View Application',null,callbackFunctionArray);
 }//end of bank



function HideModalWindow() {
    modalWin.HideModalPopUp();
}

function refresh_data(){
form.submit();
}


</script>
</body>
</html>
