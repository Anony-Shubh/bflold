function dateChange(){
i=document.form1.SEL_YEAR.selectedIndex; 
vYR=document.form1.SEL_YEAR.options[i].value;

if (vYR=='2008-09'){
document.form1.RFROMDT.value='01-APR-2008';
document.form1.RTODATE.value='31-MAR-2009';

}else if  (vYR=='2009-10'){
document.form1.RFROMDT.value='01-APR-2009';
document.form1.RTODATE.value='31-MAR-2010';
}else if  (vYR=='2010-11'){
document.form1.RFROMDT.value='01-APR-2010';
document.form1.RTODATE.value='31-MAR-2011';
}else if  (vYR=='2011-12'){
document.form1.RFROMDT.value='01-APR-2011';
document.form1.RTODATE.value='31-MAR-2012';
}else if  (vYR=='2012-13'){
document.form1.RFROMDT.value='01-APR-2012';
document.form1.RTODATE.value='31-MAR-2013';
}else if  (vYR=='2013-14'){
document.form1.RFROMDT.value='01-APR-2013';
document.form1.RTODATE.value='19-AUG-2013';
}


}

function getDateObject(dateString,dateSeperator)
{
var curValue=dateString;
var sepChar=dateSeperator;
var curPos=0;
var cDate,cMonth,cYear;
//extract day portion
curPos=dateString.indexOf(sepChar);
cDate=dateString.substring(0,curPos);
//extract month portion 
endPos=dateString.indexOf(sepChar,curPos+1); 
cMonth=dateString.substring(curPos+1,endPos);
cMonth=cMonth.toUpperCase();
if (cMonth=="JAN"){cMonth="01";}
if (cMonth=="FEB"){cMonth="02";}
if (cMonth=="MAR"){cMonth="03";}
if (cMonth=="APR"){cMonth="04";}
if (cMonth=="MAY"){cMonth="05";}
if (cMonth=="JUN"){cMonth="06";}
if (cMonth=="JUL"){cMonth="07";}
if (cMonth=="AUG"){cMonth="08";}
if (cMonth=="SEP"){cMonth="09";}
if (cMonth=="OCT"){cMonth="10";}
if (cMonth=="NOV"){cMonth="11";}
if (cMonth=="DEC"){cMonth="12";}

//extract year portion 
curPos=endPos;
endPos=curPos+5; 
cYear=curValue.substring(curPos+1,endPos);

//Create Date Object
dtObject=new Date(cYear,cMonth,cDate); 
return dtObject;
}

function dtComp(startDt,endDt){
	//dtComp(document.form1.startDate.value,document.form1.endDate.value)
var startDate = getDateObject(startDt,"-");
var endDate = getDateObject(endDt,"-");
if(startDate < endDate){
return true;
}else{
return false;
}
}

function pmegpReport(preport){
i=document.form1.AGENCY.selectedIndex; 
vagency=document.form1.AGENCY.options[i].value; 

j=document.form1.REPTYPE.selectedIndex; 
vReptype=document.form1.REPTYPE.options[j].value; 

msg='';
var vFromDt=document.form1.RFROMDT.value;
var vToDt=document.form1.RTODATE.value;
	if (vFromDt==''||vToDt==''){
	msg='Please Select From Date and To Date';
	alert(msg);
	return false;
	}else{
	sd=dtComp(vFromDt,vToDt);
	
	if ((!sd)){
	alert('From Date Should not greater than To Date');
    return(false);}
								}
	parent.location.href='./'+ preport+'?FROMDT='+vFromDt+'&TODT='+vToDt+'&AGENCY='+vagency+'&REPTYPE='+vReptype;
	return (true);
	}
	
	function pmegpReportParam(preport,param){
i=document.form1.AGENCY.selectedIndex; 
vagency=document.form1.AGENCY.options[i].value; 
//1-No of Project,2-for Margin Money,3-employment,4-production,5-earning,6-sales

msg='';
var vFromDt=document.form1.RFROMDT.value;
var vToDt=document.form1.RTODATE.value;
	if (vFromDt==''||vToDt==''){
	msg='Please Select From Date and To Date';
	alert(msg);
	return false;
	}else{
	sd=dtComp(vFromDt,vToDt);
	
	if ((!sd)){
	alert('From Date Should not greater than To Date');
    return(false);}
								}
	parent.location.href='./'+ preport+'?FROMDT='+vFromDt+'&TODT='+vToDt+'&AGENCY='+vagency+'&REPORTFLD='+param;
	return (true);
	}
	
	function pmegpReportParamCat(preport){
i=document.form1.AGENCY.selectedIndex; 
vagency=document.form1.AGENCY.options[i].value; 

i=document.form1.GENDER.selectedIndex; 
vgender=document.form1.GENDER.options[i].value; 

i=document.form1.CAT.selectedIndex; 
vcat=document.form1.CAT.options[i].value;
vcatDesc=document.form1.CAT.options[i].text; 
 


msg='';
var vFromDt=document.form1.RFROMDT.value;
var vToDt=document.form1.RTODATE.value;
	if (vFromDt==''||vToDt==''){
	msg='Please Select From Date and To Date';
	alert(msg);
	return false;
	}else{
	sd=dtComp(vFromDt,vToDt);
	
	if ((!sd)){
	alert('From Date Should not greater than To Date');
    return(false);}
								}
	parent.location.href='./'+ preport+'?FROMDT='+vFromDt+'&TODT='+vToDt+'&AGENCY='+vagency+'&PGENDER='+vgender+'&PCAT='+vcat+'&PCATDESC='+vcatDesc;
	return (true);
	}
	
	////// PMEGP BIWEEKLY REPORTS
	
		
	function pmegpbiweeklyReport(fld){
i=document.form1.AGENCY.selectedIndex; 
vagency=document.form1.AGENCY.options[i].value;

j=document.form1.CATEGORY.selectedIndex; 
vCategory=document.form1.CATEGORY.options[j].value; 

C=document.form1.GENDER1.selectedIndex; 
vGender1=document.form1.GENDER1.options[C].value; 
 
msg='';
var vFromDt=document.form1.RFROMDT.value;
var vToDt=document.form1.RTODATE.value;
	if (vFromDt==''||vToDt==''){
	msg='Please Select From Date and To Date';
	alert(msg);
	return false;
	}else{
	sd=dtComp(vFromDt,vToDt);
	
	if ((!sd)){
	alert('From Date Should not greater than To Date');
    return(false);}
								}
								
								if (vCategory !='ALL' || vGender1 !='ALL'){
								
	parent.location.href='./pmegpPerformancewocat.jsp'+'?FROMDT='+vFromDt+'&TODT='+vToDt+'&AGENCY='+vagency+'&CATEGORY='+vCategory+'&GENDER='+vGender1+'&REPTP='+fld;
	}else{
		parent.location.href='./pmegpstatusdeailreportco.jsp'+'?FROMDT='+vFromDt+'&TODT='+vToDt+'&AGENCY='+vagency+'&CATEGORY='+vCategory+'&GENDER='+vGender1+'&REPTP='+fld;

	}
	return (true);
	}
