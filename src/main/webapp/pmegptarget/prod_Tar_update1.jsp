<%@ page contentType="text/html; charset=iso-8859-1"  language="java" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"%>

<%
    response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
    %>
	
	
	<%!
public List<HashMap<String,Object>> convertResultSetToList(ResultSet rs) throws SQLException {
    ResultSetMetaData md = rs.getMetaData();
    int columns = md.getColumnCount();
    List<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();

    while (rs.next()) {
        HashMap<String,Object> row = new HashMap<String, Object>(columns);
        for(int i=1; i<=columns; ++i) {
            row.put(md.getColumnName(i),rs.getObject(i));
        }
        list.add(row);
    }

    return list;
}

	
	
	
	
	 %>
<html>
<head>
<title>Institution Khadi Sewa Home Page
</title>

<link rel="stylesheet" type="text/css" href="../css/pmegpNew.css">
<script type="text/javascript" src="../js/inlinemsg.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.3.js"></script>
<script type="text/javascript">
function abc(){
	/*var numberOnly = /^[0-9 \.-]+$/;
	
	var PRJ_NO_TGT = document.form.PRJ_NO_TGT.value; 
	var MM_TGT = document.form.MM_TGT.value; 
	
	if(PRJ_NO_TGT != "") {
    if (!numberOnly.test(PRJ_NO_TGT)) {
	inlineMsg ('PRJ_NO_TGT','Invalid PRJ_NO_TGT',2);	
	return (false);
    }
	
}
if(MM_TGT != "") {
    if (!numberOnly.test(MM_TGT)) {
	inlineMsg ('MM_TGT','Invalid MM_TGT',2);	
	return (false);
    }
	
}*/
	document.form.ins.value='I';
	document.form.submit();
}

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
<style type="text/css">
<!--
.style1 {color: #FF0000}
-->
</style>
</head>
<body onload="totprj();totmm();" >
<%
String DIS_CD= (String)request.getParameter("DISTRICT_CD")==null?"":request.getParameter("DISTRICT_CD");
String OFF_NM= (String)request.getParameter("OFF_NAME")==null?"":request.getParameter("OFF_NAME");	
String DIS_NM= (String)request.getParameter("DISTRICT_NAME")==null?"":request.getParameter("DISTRICT_NAME");	


String ins=request.getParameter("ins")==null?"":(String) request.getParameter("ins");
DBCon db= new DBCon();
        db.connect();
		List values=new ArrayList();
        List pstm=new ArrayList();
		int srn =0;
		
	  
	  
        StringBuffer qrysb = new StringBuffer();
		qrysb.append(" SELECT MOM.OFF_NAME,MOM.DISTRICT_CD,MOM.OFF_CD,MOM.AGENCY_TYPE,PMT.MMTGT_ID,nvl(PMT.PRJ_NO_TGT,0) as PRJ_NO_TGT,  " );
		qrysb.append(" NVL(PMT.MM_TGT,0) AS MM_TGT FROM MAS_OFF_MAST MOM,M_DISTRICT MD,PMEGP_MMTARGET PMT  " );
		qrysb.append(" WHERE  MD.DISTRICT_CD=MOM.DISTRICT_CD AND MOM.OFF_CD=PMT.OFF_CD(+) AND MOM.ACT_YN='Y' AND MOM.OFF_TYPE_CD IN (2, 3, 5, 22) AND  " );
		qrysb.append(" MOM.DISTRICT_CD=? AND MOM.OFF_NAME1=? ");
		
		values.add (DIS_CD);pstm.add ("D");
		values.add (OFF_NM);pstm.add ("D");
		
		ResultSet rsUP = db.executeSQL(qrysb.toString(),values);
		values.clear();
        pstm.clear(); 
		
		
List <HashMap<String,Object>> Listdis=  convertResultSetToList(rsUP);
	
	   
		%>

<form method="post" action="prod_Tar_update.jsp" name="form" id="form" class="form" >

<table align="center">
  <tr>
    <th colspan="5" scope="col"><div align="center">MARGIN MONEY TARGET FOR THE YEAR 2016-17 </div></th>
    <input name="ins" type="hidden" id="ins" value="<%= ins %>">
  </tr>
  <tr>
    <th>OFF_NAME:</th>
    <th width="184" colspan="2"><span class="style1"><%=OFF_NM%></span></th>
    <th width="237">DISTRICT_NAME</th>
    <th width="242"><span class="style1"><%=DIS_NM%></span>
        
  </tr>
  <tr>
    <td height="26" colspan="7" scope="col"></td>
  </tr>
  <br/>
  <tr><th width="178" scope="col">Office</th>
      <th width="91" scope="col">Agency</th>
      <th width="91" scope="col">OFF_CD</th>
      <th width="237" scope="col">No of Project </th>
      <th width="242" scope="col">Margin Money Target ( In Lakhs) </th>
  </tr>
  <% 
  for (int i=0;i<Listdis.size();i++) {
 
		 
		 %>
  <tr>
    <th nowrap><div align="center"><%=Listdis.get(i).get("OFF_NAME")%></div></th>
    <th nowrap><div align="center"><%=Listdis.get(i).get("AGENCY_TYPE")%>
            <input type="hidden" name="DISTRICT_CD" id="DISTRICT_CD" value="<%=Listdis.get(i).get("DISTRICT_CD")%>">
            <input type="hidden" name="MMTGT_ID" id="MMTGT_ID" value="<%=Listdis.get(i).get("MMTGT_ID")%>">            
    </div></th>
    <th nowrap><%=Listdis.get(i).get("OFF_CD")%></th>
    <th nowrap><div align="center">
        <input name="PRJ_NO_TGT" type="text" id="PRJ_NO_TGT" onblur="totprj();" value="<%=Listdis.get(i).get("PRJ_NO_TGT")%>" size="10" maxlength="6">
    </div></th>
    <th nowrap><div align="center">
        <input name="MM_TGT" type="text" id="MM_TGT" onblur="totmm();" value="<%=Listdis.get(i).get("MM_TGT")%>" size="10" maxlength="6">
    </div></th>
    
  </tr>
   <% 
  }
		%>
  <tr>
    
    <th nowrap></th> 
    <th colspan="2">TOTAL</th>
    <td><div align="center"><input name="TOT_PRJ" type="text" id="TOT_PRJ"  size="10" maxlength="6" readonly="readonly" ></div></td>
	<td><div align="center"> <input name="TT_MM" type="text" id="TT_MM"  size="10" maxlength="6" readonly="readonly"></div></td> 
  </tr>
 
  <tr>
    <th colspan="7"> <div align="center">
        <input name="Button" type="button" class="button" onClick="abc();" value="SAVE FORM">
        <input name="Submit" type="submit" class="button" value="Cancel" onClick="self.close();">
    </div></th>
  </tr>
</table>
<%
try {
     
			if (ins.equals("I")) {
				
	for (int i=0;i<Listdis.size();i++) {	

String  [] DISTRICT_CD=request.getParameterValues("DISTRICT_CD");
//out.print(DISTRICT_CD[i]);
String  [] MMTGT_ID= request.getParameterValues("MMTGT_ID");
//out.print(MMTGT_ID[i]);
String  [] OFF_CD= request.getParameterValues("OFF_CD");
//out.print(OFF_CD[i]);
String  [] PRJ_NO_TGT= request.getParameterValues("PRJ_NO_TGT");


String  [] MM_TGT= request.getParameterValues("MM_TGT");
//out.print(MM_TGT[i]);

    StringBuffer sb = new StringBuffer();		
			 
		if (MMTGT_ID[i].equals("null"))
{
ResultSet rsMax = db.execSQL(" select  MMTGT_SEQ.NEXTVAL FROM DUAL ");
while (rsMax.next()) {
MMTGT_ID[i]=rsMax.getString(1);
}
rsMax.close();



 sb.append(" INSERT INTO PMEGP_MMTARGET(TIMESTAMP_TGT,DISTRICT_CD,PRJ_NO_TGT,MM_TGT,TGT_YR,OFF_CD,MMTGT_ID) ");
 sb.append(" VALUES (SYSDATE,?,?,?,'2016-17',?,?) ");
}

 else
{
sb.append(" UPDATE PMEGP_MMTARGET SET  ");
sb.append(" TIMESTAMP_TGT=SYSDATE, DISTRICT_CD=?, PRJ_NO_TGT=?, MM_TGT=? , TGT_YR='2016-17' WHERE OFF_CD=? AND MMTGT_ID=?   ");
}

//out.print(sb.toString());
db.setSqlValue(sb.toString());
db.setValues(values,pstm); 
 


 values.add (DISTRICT_CD[i]);pstm.add ("D");
 values.add (PRJ_NO_TGT[i]);pstm.add ("D");
 values.add (MM_TGT[i]);pstm.add ("D");
 values.add (OFF_CD[i]);pstm.add ("D"); 
 values.add (MMTGT_ID[i]);pstm.add ("D");
 
 //out.print (MMTGT_ID[i]);
 db.executeUpdate();
 values.clear();
  pstm.clear();
			}//loop end
  
	db.close(); 
	
	response.sendRedirect("savemsg.jsp");
			
			}
			
			} 
			
			catch (Exception e) {
		out.print (e.toString());
		}
			
			%>
	        
</body>
</html>