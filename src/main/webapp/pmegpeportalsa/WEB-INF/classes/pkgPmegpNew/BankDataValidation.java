package pkgPmegpNew;

import java.io.*;
import pkgPmegpNew.BDVbean;

public class BankDataValidation{

private String recNo ;               
private String appId;
private String appName;
private String actId;
private String bankRecDt;
private String bankRemarks;
private String loanSancDt;
private String workshedCost;
private String machinaryCost;
private String workingCapital;
private String preOpeCost;
private String ownContribution;
private String ownContDt;
private String istLoanAmt;
private String istLoanDt;
private String cgtsi;
private String mmClaimlrNo;
private String mmClaimDt;
private String mmClaimAmt;
private String mmRelDt;
private String mmRelAmt;
private String offCd;
private String emp;
private String prod;
private String sales;
private String tdrAdjDt;
private String tdrAdjAmt;
private String Stage;

//extra variable
private String appStatus="";
private String err_msg="";
private String  bdt_length="";
private int vappStatus=0;


public void setRecNo(String recNo){
this.recNo=recNo.trim();
}
						
	                    
public void setAppId (String appId){
this.appId=appId.trim();
}

public void setAppName (String appName){
this.appName=appName.trim();
}



public void setActId (String actId){
this.actId=actId.trim();
}

public void setBankRecDt (String bankRecDt ){
this.bankRecDt=bankRecDt.trim();

}


public void setBankRemarks (String bankRemarks){
this.bankRemarks=bankRemarks.trim();
}

public void setLoanSancDt (String loanSancDt){
this.loanSancDt=loanSancDt.trim();
}
public void setWorkshedCost (String workshedCost){
this.workshedCost=workshedCost.trim();
}

public void setMachinaryCost(String machinaryCost){
this.machinaryCost=machinaryCost.trim();
}

public void setWorkingCapital(String workingCapital){
this.workingCapital=workingCapital.trim();
}

public void setPreOpeCost(String preOpeCost){
this.preOpeCost=preOpeCost.trim();
}

public void setOwnContribution(String ownContribution){
this.ownContribution=ownContribution.trim();
}

public void setOwnContDt(String ownContDt){
this.ownContDt=ownContDt.trim();
}

public void setIstLoanAmt(String istLoanAmt){
this.istLoanAmt=istLoanAmt.trim();
}

public void setIstLoanDt(String istLoanDt){
this.istLoanDt=istLoanDt.trim();
}

public void setCgtsi(String cgtsi){
this.cgtsi=cgtsi.trim();
}

public void setMmClaimlrNo(String mmClaimlrNo){
this.mmClaimlrNo=mmClaimlrNo.trim();
}

public void setMmClaimDt(String mmClaimDt){
this.mmClaimDt=mmClaimDt.trim();
}

public void setMmClaimAmt(String mmClaimAmt){
this.mmClaimAmt=mmClaimAmt.trim();
}

public void setMmRelDt(String mmRelDt){
this.mmRelDt=mmRelDt.trim();
}

public void setMmRelAmt(String mmRelAmt){
this.mmRelAmt=mmRelAmt.trim();
}

public void setOffCd(String offCd){
this.offCd=offCd.trim();
}

public void setEmp(String emp){
this.emp=emp.trim();
}

public void setProd(String prod){
this.prod=prod.trim();
}

public void setSales(String sales){
this.sales=sales.trim();
}

public void setTdrAdjDt(String tdrAdjDt){
this.tdrAdjDt=tdrAdjDt.trim();
}

public void setTdrAdjAmt(String tdrAdjAmt){
this.tdrAdjAmt=tdrAdjAmt.trim();
}

public String BDVErrMessage(){

try{
	
bdt_length=appName.length()>100?err_msg=err_msg+"Applicant Name  Size exceeded (Mamimum 100 Charcters)<br>":appName.trim();
bdt_length=bankRemarks.length()>99?err_msg=err_msg+"Bank Remarks  Size Exceeded (Maximum 90 Charcters)<br>":bankRemarks.trim();
bdt_length=appId.length()>20?err_msg=err_msg+"Applicant ID :"+appId+" Size Exceeded (Maximum 20 Charcters)<br>":appId.trim();
bdt_length=mmClaimlrNo.length()>29?err_msg=err_msg+"Govt. Subsidy (MM) claim Letter No  size Exceeded (Maximum 30 Charcter)<br>":mmClaimlrNo.trim();


 // Checking the  Mendotory Fields Data
					   
//Application ID or  Office CD is entered or Not
					   
if (  ( appId.equals("")||appId.equals(null) ) && (offCd.equals("")||offCd.equals(null)) ){					    
err_msg=err_msg+"Applicant ID or Office CD Blank<br>";					
	}
					   
					   
//Mandatory Field APP_NAME
if (  ( appName.equals("") || appName.equals(null)  ) ){
err_msg=err_msg+"**Applicant Name Should not Blank<br>";
}


//Mandatory Field Applicant Status
if ( actId.equals("")||actId.equals("0")  ){
err_msg=err_msg+"** Select Applicant Status <br>";
}else if ( ! ( actId.equals("")||actId.equals(null)  ) ){
actId=actId.toUpperCase();

// if sanction is 11 not entered sanction Date and amount then..............
try{
vappStatus=Integer.parseInt(actId);
}catch(Exception e){
err_msg=err_msg+"**Invalid Applicant Status<br>";
}
}//end else

//Own Contribution

ownContribution=(ownContribution.equals("")||ownContribution.equals(null))?"0": ownContribution.trim();
if (!ownContDt.equals("")){
vappStatus=21;
}else if (!ownContribution.equals("0") ){
try{
int vown=Integer.parseInt(ownContribution);
vappStatus=21;
}catch(Exception e){
err_msg=err_msg+"**Invalid Own Contribution Amount ("+ownContribution+"<br>";
}
}

// LOAN RELEASE VALIDATION

istLoanAmt = istLoanAmt.trim();
					   
istLoanAmt=(istLoanAmt.equals("")||istLoanAmt.equals(null))?"0": istLoanAmt.trim();

if (!istLoanDt.equals("")){
vappStatus=22;

}else if (!istLoanAmt.equals("0") ){
try{
int vown=Integer.parseInt(istLoanAmt);
vappStatus=22;
}catch(Exception e){
err_msg=err_msg+"Invalid Loan Release Amount ("+istLoanAmt+")<br>";
}//catch
}//main if

//out.print(vappStatus+ istLoanDt+ istLoanAmt);

if ( vappStatus>21 && ( istLoanDt.equals("")|| istLoanAmt.equals("0") ) ){
err_msg=err_msg+"Loan Release Date and Amount should not blank<br>";

}

// MM CLAIM Receive
												   
mmClaimAmt=(mmClaimAmt.equals("")||mmClaimAmt.equals(null))?"0": mmClaimAmt.trim();

if (!mmClaimDt.equals("")){
vappStatus=23;

}else if (!mmClaimAmt.equals("0") ){
try{
int vown=Integer.parseInt(mmClaimAmt);
vappStatus=23;
}catch(Exception e){
err_msg=err_msg+"Invalid Govt. Subsidy Claimed Amount ("+mmClaimAmt+")<br>";
}//catch
}//main if

if ( vappStatus>22 && ( mmClaimDt.equals("")|| mmClaimAmt.equals("0") ) ){
err_msg=err_msg+"Govt. Subsidy Claimed Amount and Date should not blank<br>"; 
}
//MARGIN MONEY RELEASE STATE

 mmRelAmt=(mmRelAmt.equals("")||mmRelAmt.equals(null))?"0":mmRelAmt.trim();
 
 emp=(emp.equals("")||emp.equals(null))?"0":emp.trim();
 prod=(prod.equals("")||prod.equals(null))?"0":prod.trim();
  sales=(prod.equals("")||sales.equals(null))?"0":sales.trim();

tdrAdjAmt=(tdrAdjAmt.equals("")||tdrAdjAmt.equals(null))?"0":tdrAdjAmt.trim();


if (!tdrAdjDt.equals("")){
vappStatus=25;

}else if (!tdrAdjAmt.equals("0") ){
try{
int vown=Integer.parseInt(tdrAdjAmt);
vappStatus=25;
}catch(Exception e){
err_msg=err_msg+"Invalid Govt. Subsidy Adjustment Amount:("+tdrAdjAmt+")<br>";
}//catch
}//main if



if (!mmRelDt.equals("")){
vappStatus=24;

}else if (!mmRelAmt.equals("0") ){
try{
int vown=Integer.parseInt(mmRelAmt);
vappStatus=24;
}catch(Exception e){
err_msg=err_msg+"Invalid Govt. Subsidy Release Amount ("+mmRelAmt+")<br>";
}//catch
}//main if

if ( vappStatus>23 && ( mmRelDt.equals("")|| mmRelAmt.equals("0")||emp.equals("0")||prod.equals("0")||sales.equals("0") ) ){
err_msg=err_msg+"Govt. Subsidy Release Amount and Date,Employment,Production & Sales should not blank<br>"; 
}
if ( vappStatus>20 && (( ownContDt.equals("")|| ownContribution.equals("0")) ) ){
err_msg=err_msg+"Own Contribution Date or  Amount should not blank<br>";

}


if ( vappStatus>24 && (( tdrAdjDt.equals("")|| tdrAdjAmt.equals("0")) ) ){
err_msg=err_msg+"TDR Adjustment Date or  Amount should not blank<br>";

}


if  (vappStatus>10){
bdt_length=cgtsi.length()>1?err_msg=err_msg+"<br>CGTSI field size Exceeded (Maximum 1 Charcter)<br>":cgtsi.trim();
bdt_length=!(cgtsi.equals("N")||cgtsi.equals("Y"))?err_msg=err_msg+"Select CGTSI<br>":cgtsi.trim();

//validating Sanction date

if (  (  loanSancDt.equals("") || loanSancDt.equals(null)  ) ){
err_msg=err_msg+"Sanction Date is blank (date format is DD-MON-RRRR (ex 01-APR-2010)) <br>";
}else if (!(  ( loanSancDt.equals("") || loanSancDt.equals(null)  ) ) ){
loanSancDt=loanSancDt.toUpperCase();

int position1=loanSancDt.indexOf("-");
int position2=loanSancDt.lastIndexOf("-");

if (loanSancDt.length() !=11 && position1 !=2 && position2 !=6){
err_msg=err_msg+"Invalid Sanction Date ("+loanSancDt+")(Date format is DD-MON-YYYY (ex 01-APR-2010)) <br>";
}else{
String vmon=loanSancDt.substring(position1+1,position2).toUpperCase();

if (!(  vmon.equals("JAN")|| vmon.equals("FEB")|| vmon.equals("MAR")|| vmon.equals("APR")|| vmon.equals("MAY")|| vmon.equals("JUN")|| vmon.equals("JUL")|| vmon.equals("AUG")|| vmon.equals("SEP")|| vmon.equals("OCT")|| vmon.equals("NOV")|| vmon.equals("DEC") )){
err_msg=err_msg+"Invalid Sanction Date- Month ("+loanSancDt+")(Date format is DD-MON-YYYY (ex 01-APR-2010)) <br>";
}
}
}

workingCapital=(workingCapital.equals("")||workingCapital.equals(null))?"0": workingCapital.trim();
workshedCost=(workshedCost.equals("")||workshedCost.equals(null))?"0": workshedCost.trim();
machinaryCost =(machinaryCost.equals("")||machinaryCost.equals(null))?"0": machinaryCost.trim();
preOpeCost=(preOpeCost.equals("")||preOpeCost.equals(null))?"0": preOpeCost.trim();

try{ 

int tot_sanc=Integer.parseInt(workingCapital)+Integer.parseInt(workshedCost)+Integer.parseInt(machinaryCost)+Integer.parseInt(preOpeCost);

if (tot_sanc>2500000 || tot_sanc<1) {
err_msg=err_msg+"Total Sanctioned Amount is ("+tot_sanc+") Sanction Amount Should not exceed 25 lakhs or Zero<br>";
}

}catch(Exception e){
err_msg=err_msg+"Invalid Sanctioned Amount Please Check the Detail:-Should be in Rupees (ex:25 lakhs)<br>";
}   

}



//receive Date validation
bankRecDt=bankRecDt.trim();
 BDVbean v= new BDVbean();
 v.setDt(bankRecDt);
 String bdt=v.getVDate();
bdt=bdt.equals("N")?err_msg=err_msg+"** Invalid Receive Date "+bankRecDt+" --Date format Should be DD-MON-YYYY (Ex:01-APR-2010) <br>":bankRecDt.trim();
bdt=bankRecDt.length()<1?err_msg=err_msg+"** Receive Date  Blank<br>":bankRecDt.trim();

try {
vappStatus=vappStatus;
}catch(Exception e){
vappStatus=0;
}

}catch(Exception e){
err_msg=err_msg+"Error in saving Data";
}					
return(err_msg);
}//DBTEST constructor

                            public String getStage(){

                              if (vappStatus==0){
					 Stage="Select Applicant Status";
					}else if (vappStatus==3){
					Stage="Rejected By Bank";
					}else if (vappStatus==8){
					Stage="Under Process/Pending";
					}else if (vappStatus==11){
					Stage="Sanctioned by Bank";
					}else if (vappStatus==21){
					Stage="Own Contribution Deposited";
					}else if (vappStatus==22){
					Stage="Loan Released to Beneficiary";
					}else if (vappStatus==23){
					Stage="Govt. Subsidy(MM) Claim Received";
					}else if (vappStatus==24){
					Stage="Govt. Subsidy(MM) Released by Nodal Bank";
					}else if (vappStatus==25){
					Stage="Govt. Subsidy TDR Adjusted";
					}
                            return(Stage);
                            }

//get method

public int getAppStatus(){
return (vappStatus);
}

public String getRecNo(){
return(recNo);
}
                    
public String getAppId (){
return(appId);
}

public String getAppName (){
return(appName);
}

public String getActId (){
return(actId);
}

public String getBankRecDt ( ){
return(bankRecDt);
}


public String getBankRemarks (){
return(bankRemarks);
}

public String getLoanSancDt (){
return(loanSancDt);
}
public String getWorkshedCost (){
return(workshedCost);
}

public String getMachinaryCost(){
return(machinaryCost);
}

public String getWorkingCapital(){
return(workingCapital);
}

public String getPreOpeCost(){
return(preOpeCost);
}

public String getOwnContribution(){
return(ownContribution);
}

public String getOwnContDt(){
return(ownContDt);
}

public String getIstLoanAmt(){
return(istLoanAmt);
}

public String getIstLoanDt(){
return(istLoanDt);
}

public String getCgtsi(){
return(cgtsi);
}

public String getMmClaimlrNo(){
return(mmClaimlrNo);
}

public String getMmClaimDt(){
return(mmClaimDt);
}

public String getMmClaimAmt(){
return(mmClaimAmt);
}

public String getMmRelDt(){
return(mmRelDt);
}

public String getMmRelAmt(){
return(mmRelAmt);
}

public String getOffCd(){
return(offCd);
}

public String getEmp(){
return(emp);
}

public String getProd(){
return(prod);
}

public String getSales(){
return(sales);
}

public String getTdrAdjDt(){
return(tdrAdjDt);
}

public String getTdrAdjAmt(){
return(tdrAdjAmt);
}

}//end of class