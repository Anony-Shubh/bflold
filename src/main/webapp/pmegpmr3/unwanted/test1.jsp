
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<title>PMEGP new page loader</title>
	<script type="text/javascript" src="js/prototype.js"></script>
	<script type="text/javascript">
	// <![CDATA[
	// In my tutorial I wrote = window.onload = function() { init() };
	// This method Event.observe is better. It makes the DOM, and thus our classes & id's available before the images start to load! The previous function just waits
	// for the whole shabang to load
	
   document.observe('dom:loaded', function () {
		var newsCat = document.getElementsByClassName('newsCat');
		for (var i = 0; i < newsCat.length; i++) {
			$(newsCat[i].id).onclick = function () {
				getCatPage(this.id);
			}
		}
	});
	
	
	function dateChange(){
vYR=document.getElementsByName("SEL_YEAR")[0].value
var todaydt=new Date();
var dd=todaydt.getDate();
var mm=todaydt.getMonth()+1;
var yr=todaydt.getFullYear();
var months=['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
var showdt=dd+'-'+months[mm-1]+'-'+yr;
showdt=showdt.toUpperCase();

if (vYR=='2008-09'){
document.getElementsByName("RFROMDT")[0].value='01-APR-2008';
document.getElementsByName("RTODATE")[0].value='31-MAR-2009';
}else if  (vYR=='2009-10'){
document.getElementsByName("RFROMDT")[0].value='01-APR-2009';
document.getElementsByName("RTODATE")[0].value='31-MAR-2010';
}else if  (vYR=='2010-11'){
document.getElementsByName("RFROMDT")[0].value='01-APR-2010';
document.getElementsByName("RTODATE")[0].value='31-MAR-2011';
}else if  (vYR=='2011-12'){
document.getElementsByName("RFROMDT")[0].value='01-APR-2011';
document.getElementsByName("RTODATE")[0].value='31-MAR-2012';

}else if  (vYR=='2012-13'){
document.getElementsByName("RFROMDT")[0].value='01-APR-2012';
document.getElementsByName("RTODATE")[0].value='31-MAR-2013';
}else if  (vYR=='2013-14'){
document.getElementsByName("RFROMDT")[0].value='01-APR-2013';
document.getElementsByName("RTODATE")[0].value=showdt;
}
}
	
	
	
	
	
	function getCatPage(id) {
		var url = id+'.jsp';
        var vagency=document.getElementsByName("AGENCY")[0].value;
		var vfrdt=document.getElementsByName("RFROMDT")[0].value;
		var vtodt=document.getElementsByName("RTODATE")[0].value;
		
		var pars   = 'AGENCY=' + vagency + '&FROMDT=' + vfrdt+ '&TODT=' + vtodt;
		var myAjax = new Ajax.Request( url, {method: 'post', parameters: pars, onLoading: showLoad, onComplete: showResponse} );
	}
	
	function showLoad () {
		$('newsContent').style.display = 'none';
		$('newsLoading').style.display = 'block';
	}
	
	function showResponse (originalRequest) {
		var newData = originalRequest.responseText;
		$('newsLoading').style.display = 'none';
		$('newsContent').style.display = 'block';		
		$('newsContent').innerHTML = newData;
	}
	// ]]>
	</script>	
	<link rel="stylesheet" type="text/css" href="css/indexr.css">
	
	<style type="text/css" media="screen">
	<!--
	body {
		font: 1em Verdana, Arial, Helvetica, sans-serif;		
		}
	
	#tagLine {		
		color: #d39819;
		margin: 0 0 15px 0;
		font-style: italic;
		font-size: 1.05em;
		font-family: georgia, arial, helvetica;
		}	
			
	#credits {
		font: normal 66% verdana, helvetica, arial; 
		padding: 0.5em 0;
		margin: 2em 0; 
		border-top: 1px dotted #c0c0c0;
		border-bottom: 1px dotted #c0c0c0;
		}	
	
	h1 {
		font: normal 2em georgia, arial, helvetica;
		margin: 0;
		padding: 0;
		color: #D35619;
		}
	h2 {
		font: normal 1.5em georgia, arial, helvetica;
		margin: 0;
		padding: 0;
		color: #CCCC66;
		}
	
	h3 {
		font-weight: normal;
		text-align:center;
		}
			
	
	#newsContainer {
		background-color:white;
		width:auto;
		height:auto;
		margin: 0 auto; /* we center our container div */
		border: 1px solid #99CC00;
		padding: 1px;
		}
	
	#newsCategoriesContainer {
		
		height:30px;
		background-color:#990000;
	}
	
	#newsCategoriesContainer .newsCat{
		margin: 1px;
		padding: 2px;
		text-align:center;
		display: block;
		cursor:pointer;
		border:1px solid #ccc;
		width: auto;
	}
	
	#newsCategoriesContainer .newsCat:hover{
		background-color:#669900;
	}
	
	#newsContent {
		padding: 20px;
	}
	
	#newsLoading {
		margin-top: 100px;
		text-align:center;
		display:none;
	}
	-->
	</style>
</head>
<body onLoad="dateChange()">
 <form name="form1">


<table align="center">
    <tr>
      <th colspan="12">PMEGP e-Tracking Montoring Report </th>
      
    </tr>
    <tr>
      <th colspan="12">&nbsp;</th>
     
    </tr>
    <tr>
      <th>Select Agency</th>
      <th><select name="AGENCY">
        <option value="ALL" selected>ALL</option>
        <option value="KVIC">KVIC</option>
        <option value="KVIB">KVIB</option>
        <option value="DIC">DIC</option>
      </select></th>
      <th>Year</th>
      <th><select name="SEL_YEAR"  id="SEL_YEAR" onChange="dateChange();">
        <option value="2013-14" selected>2013-14</option>
        <option value="2012-13">2012-13</option>
        <option value="2011-12">2011-12</option>
        <option value="2010-11">2010-11</option>
        <option value="2009-10">2009-10</option>
        <option value="2008-09">2008-09</option>
                  </select></th>
      <th></th>
      <th> From: </th>
      <th>
        <input name="RFROMDT" type="text"  id="RFROMDT" size="13" maxlength="11"> </th>
      <th>To</th>
      <th colspan="4">
      <input name="RTODATE" type="text"  id="RTODATE" size="14" maxlength="11"></th>
    </tr>
  </table>	
  </form>	
 
		<center><div id="newsContainer">
<div id="newsCategoriesContainer">
		<table>
		<tr>
		<th><div class="newsCat" id="pmegpdashboardmr1">PMEGP Dash board</div></th>
		<th><div class="newsCat" id="newsCat2">Biweekly-Performance</div></th>
		<th><div class="newsCat" id="newsCat3">Cross-Tab Reports</div></th>
		<th><div class="newsCat" id="newsCat4">Beneficiary Detail</div></th>
		<th><div class="newsCat" id="newsCat5">Bank-wise Drilldown</div></th>
		</tr>
		</table>
		</div>
		<div id="newsLoading"><strong>Please Wait Page Loading ..........</strong><br /><br /><br /><br /><img src="img/loading.gif" title="Loading..." alt="Loading..." border="0" /></div>
		</div>
		
		<div id="newsContent">
		
		</div>
		</center>
</body>

</html>