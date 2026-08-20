<%@ include file="../jsp/includeHeaderPage.jsp" %>
<HEAD>
<META http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
 <link rel="stylesheet" type="text/css" href="../css/pmegpNew.css" />
<link rel="stylesheet" type="text/css" href="../css/jquery.dataTables.min.css" />
 <script language="javascript" src="../js/jquery-1.12.4.js"></script>
<script language="javascript" src="../js/jquery.dataTables.min.js"></script>
<script language="javascript" src="../js/ModalPopupWindow.js"></script>
    <SCRIPT>
        $(document).ready(function() {
            $('#example').DataTable();
        });

    </SCRIPT>

<TITLE>
       
</TITLE>

   
    <style type="text/css">
<!--
.style2 {font-size: 18}
-->
    </style>
</HEAD>




 <%
 String SOFF_CD =(String) session.getAttribute("off_cd"); 

String APP_ID="";
String REQID="";
String APP_NAME="";
String NEW_MOB_NO="";
String REQ_DATE="";
String CURRENT_STATUS="";
String CHANGE_REASON="";





DBCon db= new DBCon(); 
db.connect(); 
List values=new ArrayList(); 
List pstm=new ArrayList(); 


StringBuffer poR = new StringBuffer();

poR.append(" SELECT AM.APP_ID, "      );
poR.append(" AM.REQID, "      );
poR.append(" AD.APP_NAME,"      );
poR.append(" TO_CHAR(AM.REQ_DATE,'DD-MON-RRRR') AS REQ_DATE, "      );
poR.append(" AM.NEW_MOB_NO, "      );
poR.append(" AM.CHANGE_REASON, "      );
poR.append(" FUNC_GETCURRENTSTATUS(AD.APP_ID) AS CURRENT_STATUS "      );  
poR.append(" FROM APP_DETAIL AD, APP_MOB_CHANGE_LOG AM "      );
poR.append(" WHERE AD.APP_ID=AM.APP_ID    ");
poR.append(" AND  AM.REQ_DATE IS NOT NULL ");
poR.append(" AND  AM.NB_APPROV IS NULL AND AD.OFF_CD=?  ");

values.add(SOFF_CD);

ResultSet rsMain = db.executeSQL(poR.toString(),values);
%>


<BODY>
 <CENTER>
        <TABLE width="79%" class="table table-striped table-bordered" id="example" style="width:80%">
            <THEAD>
                <TR>

                    <TH width="9%" align="center" valign="middle">Applicant Id</TH>
                    <TH width="18%" align="center" valign="middle">Applicant Name</TH>
                    <TH width="28%" align="center" valign="middle">Request Date</TH>
                    <TH width="14%" align="center" valign="middle">New Mobile Number</TH>
					<TH width="14%" align="center" valign="middle">Reason of Change</TH>
                    <TH width="14%" align="center" valign="middle">Current Application Status</TH>
                    <TH width="17%"  align="center" >Update</TH>
                </TR>
            </THEAD>
            <TBODY>

<%
while (rsMain.next()){
APP_ID=rsMain.getString("APP_ID")==null?"":rsMain.getString("APP_ID");
REQID=rsMain.getString("REQID")==null?"":rsMain.getString("REQID");
APP_NAME=rsMain.getString("APP_NAME")==null?"":rsMain.getString("APP_NAME");
REQ_DATE=rsMain.getString("REQ_DATE")==null?"":rsMain.getString("REQ_DATE");
NEW_MOB_NO=rsMain.getString("NEW_MOB_NO")==null?"":rsMain.getString("NEW_MOB_NO");
CHANGE_REASON=rsMain.getString("CHANGE_REASON")==null?"":rsMain.getString("CHANGE_REASON");
CURRENT_STATUS=rsMain.getString("CURRENT_STATUS")==null?"":rsMain.getString("CURRENT_STATUS");
%>
 <TR>

                    <TD>
                        <div align="center"><%=APP_ID%></div>
                    </TD>
                    <TD><%=APP_NAME%></TD>
                    <TD><div align="center"><%=REQ_DATE%></div></TD>
                    <TD><div align="center"><%=NEW_MOB_NO%></div></TD>
					 <TD><div align="center"><%=CHANGE_REASON%></div></TD>
                    <TD><%=CURRENT_STATUS%></TD>
					<TD>
                        <div align="center"><A onClick="approve('<%=APP_ID%>','<%=REQID%>')" class="buttonMerun">Approve</A>
						<hr>
                            <A onClick="reject('<%=APP_ID%>','<%=REQID%>')" class="buttonMerun">Reject</A> </div>
                    </TD>
                </TR>


                <%

}
rsMain.close();
db.close();
%>
            </TBODY>
            <TFOOT>
                <TR>
                    <TH width="9%" align="center" valign="middle">Applicant Id</TH>
                    <TH width="18%" align="center" valign="middle">Applicant Name</TH>
                    <TH width="28%" align="center" valign="middle">Request Date</TH>
                    <TH width="14%" align="center" valign="middle">New Mobile Number</TH>
					<TH width="14%" align="center" valign="middle">Reason of Change</TH>
                    <TH width="14%" align="center" valign="middle">Current Application Status</TH>
                    <TH width="17%"  align="center" >Update</TH>
                </TR>
            </TFOOT>
        </TABLE>



  </CENTER>
  <SCRIPT>
            var modalWin = new CreateModalPopUpObject();
            modalWin.SetLoadingImagePath("images/loading.gif");
            modalWin.SetCloseButtonImagePath("images/remove.gif");

            function approve(APP_ID, REQID) {
                var callbackFunctionArray = new Array(refreshpage);
                modalWin.ShowURL("approvereq.jsp?APP_ID=" + APP_ID + "&REQID=" + REQID, 600, 800, 'Approve Request', callbackFunctionArray, null);
            }


            function reject(APP_ID, REQID) {
                var callbackFunctionArray = new Array(refreshpage);
                modalWin.ShowURL("rejreq.jsp?APP_ID=" + APP_ID + "&REQID=" + REQID, 600, 800, 'Reject Request', callbackFunctionArray, null);
            }


            function HideModalWindow() {
                modalWin.HideModalPopUp();
            }

            function refreshpage() {
                location.reload();
            }

        </SCRIPT>

</BODY>

</HTML>
