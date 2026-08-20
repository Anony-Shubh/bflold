<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page  import="java.sql.*,pkgPMEGP.DBCon" %>
<HTML>
<head>
<title> export to excel </title>
<body>
  <%
  DBCon db= new DBCon();
  db.connect();
%>
<FORM METHOD="POST">
<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="+ "bankStatusexcel.xls");
StringBuffer sbTr= new StringBuffer();

sbTr.append("SELECT b.app_id,OM.off_name AS AGENCY,UPPER(b.app_name) AS APP_NAME,b.fh_name,b.gender,C.benf_category_desc,").
append("d.edu_desc||' (Tech: '||b.tech_quali ||')' as quali, DECODE(B.ind_type,'M','Manufacturing','Service') as ind_type,").
append("(nvl(B.workshed_cost,0)+nvl(B.pre_ope_exp,0)+nvl(B.machinary_cost,0)+nvl(B.working_capital,0)) as Proj_cost,").
append("b.unit_loc,b.unit_post_addr||' , '|| b.unit_taluk_block ||' , '|| b.unit_pin as UNIT_ADDR,UD.district_name AS UNIT_DIST, UST.state_nm AS UNIT_STATE,").
append(" to_char(b.bank_f_date,'DD-MON-YYYY') as bank_f_date ,b.br_code, BM.br_name||' , '||BM.br_addr||' , '||BM.district AS BRANCH_NAME, BM.state as br_state, a.act_id AS STATUS_CODE ,NVL(BAS.act_desc,'Forwarded to Bank') as CURRENT_STATUS,  to_char(a.bank_rec_dt,'DD-MON-YYYY') AS  bank_rec_dt, bank_remarks AS REJ_REASON, ").
append(" to_char(a.loan_sanc_dt,'DD-MON-YYYY') AS loan_sanc_dt, ").
append(" a.workshed_cost,  a.machinary_cost, a.pre_ope_cost,").
append(" nvl(a.workshed_cost,0)+ nvl( a.machinary_cost,0)+ nvl( a.pre_ope_cost,0) As TOTAL_CE,").
append("  a.working_capital, nvl(a.workshed_cost,0)+ nvl( a.machinary_cost,0)+ nvl( a.pre_ope_cost,0)+ NVL(a.working_capital,0) As TOTAL_LOAN,").
append(" a.own_contribution, to_char(a.own_cont_dt,'DD-MON-YYYY') AS own_cont_dt, ").
append(" to_char(a.ist_loan_dt,'DD-MON-YYYY') AS loan_rel_dt, a.ist_loan_amt as loan_rel_amt, a.cgtsi,").
append(" a.mm_claim_lrno, to_char(a.mm_claim_dt,'DD-MON-YYYY') AS  mm_claim_dt, a.mm_claim_amt,").
append(" to_char(a.mm_rel_dt,'DD-MON-YYYY') as  mm_rel_dt, a.mm_rel_amt,   a.emp, a.prod, a.sales,"). 
append(" to_char(a.tdr_adj_dt,'DD-MON-YYYY') as tdr_adj_dt, a.tdr_adj_amt,").
append(" a.bank_comment as REMARKS,  to_char(a.time_stamp,'DD-MON-YYYY:HH:MM:SS') as LAST_UPDATE_DT ").
append(" FROM bank_dataentry a, app_detail b,BENF_CATEGORY_MAST C,education_mast d, M_DISTRICT UD, M_STATE UST, BANK_APP_STATUS BAS , bank_br_mast BM ,MAS_OFF_MAST OM WHERE ").
append("  b.app_id=a.app_id(+) and b.benf_catagory_cd=C.benf_category_cd and b.aca_quali=d.edu_id AND B.unit_dist_cd=UD.district_cd  AND B.off_cd=OM.off_cd ").
append("  AND UD.state_cd=UST.state_cd AND A.act_id=BAS.act_id(+) AND B.BR_CODE=BM.BR_IFSL_CODE  ").
append("  AND b.bank_f_date BETWEEN '01-APR-2013' AND '3-DEC-2013'");

try {
ResultSet rsData = db.execSQL(sbTr.toString());
%>
           
</p>
          <TABLE>
            
            <TBODY>
            <tr>
                <TD rowspan="2">Sr No </div></TD>
                <TD rowspan="2">Applicant ID </div>
                DetailReport</TD>
                <TD rowspan="2" ></div>Applicant Name </TD>
                <TD rowspan="2">Total Project Cost </div></TD>
                <TD rowspan="2" >Forwarding Date to Bank </div></TD>
                <TD colspan="3" >Financing Branch </div></TD>
                <TD colspan="2"></div>                  
                  Loan Sanction </div></TD>
                <TD colspan="2" >Own Contribution Deposit</div></TD>
                <TD colspan="2" >Loan Release Detail </div></TD>
                <TD colspan="2" >Govt. Subsidy(MM) Claim</div></TD>
                <TD colspan="2" >Govt. Subsidy Release</div></TD>
                <TD colspan="2" >Govt. Subsidy Final Adjustment against TDR </div></TD>
              </TR>
              <tr>
                <TD >code</TD>
                <TD >Addr.</TD>
                <TD >State</TD>
                <TD> Date </div></TD>
                <TD >Amount</TD>
                <TD >Date</div></TD>
                <TD>Amount</div></TD>
                <TD >Date </TD>
                <TD >Amount</div></TD>
                <TD>Date</div></TD>
                <TD >Amount</div></TD>
                <TD >Date</div></TD>
                <TD >Amount</div></TD>
                <TD >Date</div></TD>
                <TD >Amount</div></TD>
              </TR>
              <tr>
                <TD>1</div></TD>
                <TD>2</div></TD>
                <TD >3</div></TD>
                <TD>5</div></TD>
                <TD >6</div></TD>
                <TD colspan="3" >8</div></TD>
                <TD>9</div></TD>
                <TD >10</div></TD>
                <TD>11</div></TD>
                <TD >12</div></TD>
                <TD >13</div></TD>
                <TD >14</div></TD>
                <TD >15</div></TD>
                <TD >16</div></TD>
                <TD >17</div></TD>
                <TD >18</div></TD>
                <TD >19</div></TD>
                <TD >20</div></TD>
              </TR>
			  <% 
			  int srNo=0;
			  while (rsData.next()){
			  srNo +=1;
			  String fValue="";
			  String APP_ID= (rsData.getString("APP_ID")==null || rsData.wasNull())?"":rsData.getString("APP_ID");
			  %>
              <tr><TD><%=srNo%> </TD>
                <TD><%=APP_ID%></TD>
                <TD ><%=(((fValue = rsData.getString("APP_NAME"))==null || rsData.wasNull())?"-":rsData.getString("APP_NAME"))%>
                <%=(((fValue = rsData.getString("FH_NAME"))==null || rsData.wasNull())?"-":rsData.getString("FH_NAME"))%>                <br></TD>
                <TD><%=(((fValue = rsData.getString("PROJ_COST"))==null || rsData.wasNull())?"-":rsData.getString("PROJ_COST"))%></TD>
                <TD ><%=(((fValue = rsData.getString("BANK_F_DATE"))==null || rsData.wasNull())?"-":rsData.getString("BANK_F_DATE"))%></TD>
                <TD ><%=(((fValue = rsData.getString("BR_CODE"))==null || rsData.wasNull())?"-":rsData.getString("BR_CODE"))%>                </TD>
                <TD><%=(((fValue = rsData.getString("BRANCH_NAME"))==null || rsData.wasNull())?"-":rsData.getString("BRANCH_NAME"))%></TD>
                <TD ><%=(((fValue = rsData.getString("BR_STATE"))==null || rsData.wasNull())?"-":rsData.getString("BR_STATE"))%></TD>
                <TD><%=(((fValue = rsData.getString("LOAN_SANC_DT"))==null || rsData.wasNull())?"-":rsData.getString("LOAN_SANC_DT"))%></TD>
                <TD ><%=(((fValue = rsData.getString("TOTAL_LOAN"))==null || rsData.wasNull())?"-":rsData.getString("TOTAL_LOAN"))%></TD>
                <TD ><%=(((fValue = rsData.getString("OWN_CONT_DT"))==null || rsData.wasNull())?"-":rsData.getString("OWN_CONT_DT"))%></TD>
                <TD><%=(((fValue = rsData.getString("OWN_CONTRIBUTION"))==null || rsData.wasNull())?"-":rsData.getString("OWN_CONTRIBUTION"))%></TD>
                <TD ><%=(((fValue = rsData.getString("LOAN_REL_DT"))==null || rsData.wasNull())?"-":rsData.getString("LOAN_REL_DT"))%></TD>
                <TD ><%=(((fValue = rsData.getString("LOAN_REL_AMT"))==null || rsData.wasNull())?"-":rsData.getString("LOAN_REL_AMT"))%></TD>
                <TD><%=(((fValue = rsData.getString("MM_CLAIM_DT"))==null || rsData.wasNull())?"-":rsData.getString("MM_CLAIM_DT"))%></TD>
                <TD ><%=(((fValue = rsData.getString("MM_CLAIM_AMT"))==null || rsData.wasNull())?"-":rsData.getString("MM_CLAIM_AMT"))%></TD>
                <TD ><%=(((fValue = rsData.getString("MM_REL_DT"))==null || rsData.wasNull())?"-":rsData.getString("MM_REL_DT"))%></TD>
                <TD ><%=(((fValue = rsData.getString("MM_REL_AMT"))==null || rsData.wasNull())?"-":rsData.getString("MM_REL_AMT"))%></TD>
                <TD ><%=(((fValue = rsData.getString("TDR_ADJ_DT"))==null || rsData.wasNull())?"-":rsData.getString("TDR_ADJ_DT"))%></TD>
                <TD ><%=(((fValue = rsData.getString("TDR_ADJ_AMT"))==null || rsData.wasNull())?"-":rsData.getString("TDR_ADJ_AMT"))%></TD>
              </TR>
			  <%}%>
  </TABLE>
         <%
		 rsData.close();
		 db.close();	
		 }catch (Exception e){
		 out.print(e.toString());
		 }		 
		  %>
</FORM>
</body>
</HTML>
