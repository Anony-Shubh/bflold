<%@ page session="true" buffer="1000kb"  %>
<%@ include file = "bradmintopmenuinc.jsp" %>

<%@ page import="java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.ParseException"%>
<%@ page import="globalp.*"%>
<%@ page import="pkgsafal.DBCon"%>
<%@ page import="java.io.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="javazoom.upload.*"%>
<%@ page import="java.text.SimpleDateFormat"%>


<style>
						
.tooltip {
    position: relative;
    display: inline-block;   
}

.tooltip .tooltiptext {
    visibility: hidden;
    width: 100%;
    background-color: #FFCCCC;
    color: #000000;
    text-align: center;
    border-radius: 6px;
    padding: 5px 5px;
    position: absolute;
    z-index: 1;
    top: -5px;
    left: 110%;
}

.tooltip .tooltiptext::after {
    content: " ";
    position: absolute;
    top: 50%;
    right: 100%; /* To the left of the tooltip */
    margin-top: -5px;
    border-width: 5px;
    border-style: solid;
    border-color: transparent #CCCCCC transparent transparent;
}
.tooltip:hover .tooltiptext {
    visibility: visible;
}


.tooltip_left {
    position: relative;
    display: inline-block;
   
}

.tooltip_left .tooltiptext_left {
 visibility: hidden;
    width: 450%;
    background-color: #CCCCCC;
    color: #000000;
    text-align: center;
    border-radius: 6px;
    padding: 5px 0;
    position: absolute;
    z-index: 1;
    top: -5px;
    right: 110%;
}

.tooltip_left .tooltiptext_left::after {
      content: "";
    position: absolute;
    top: 50%;
    left: 100%;
    margin-top: -5px;
    border-width: 5px;
    border-style: solid;
    border-color: transparent transparent transparent #CCCCCC;
}
.tooltip_left:hover .tooltiptext_left {
    visibility: visible;
}
        </style> 
		  <link href="css/pmegpNew.css" rel="stylesheet">

		<script language="javascript" src="js/ModalPopupWindow.js"></script>
<script language="javascript" src="js/inlinemsg.js"></script>
<script type="text/javascript" src="js/datetimepicker_css.js"></script>
  <script language="javascript" src="js/jquery-1.12.4.js"></script>
<link rel="stylesheet" type="text/css" href="css/tautocomplete.css" />
    
<script src="js/tautocomplete.js" type="text/javascript"></script>
		
<script>

    	

     function   showProductList1(){
	 var str = document.getElementById("STATE_CD").value;
	 
                var text2 = $("#Text1").tautocomplete({
                    width: "500px",
                    columns: ['BEN CODE','NAME'],
                    ajax: {
                        url: "jsontest.jsp?STATE_CD="+str,
                        type: "GET",
                        data: function () {
                            return [{ test: text2.searchdata() }];
                        },
                        success: function (data) {
                            
                            var filterData = [];

                            var searchData = eval("/" + text2.searchdata() + "/gi");

                            $.each(data, function (i, v) {
                                if ((v.BEN_CD.search(new RegExp(searchData)) != -1)   ||  (v.NAME.search(new RegExp(searchData)) != -1)   ) {
                                    filterData.push(v);
                                }
                            });
                            return filterData;
                        }
                    },
                    onchange: function () {
                        $("#ta-txt").html(text2.text());
                        $("#taid").html(text2.text());
						$('#BEN_CD1').val(text2.id());
					//showProduct();
                    }
                });
           }
		   
		   
		     function   showProductList2(){
			  var str = document.getElementById("STATE_CD").value;
	 
                var text2 = $("#Text2").tautocomplete({
                    width: "500px",
                    columns: ['BEN CODE','NAME'],
                    ajax: {
                        url: "jsontest.jsp?STATE_CD="+str,
                        type: "GET",
                        data: function () {
                            return [{ test: text2.searchdata() }];
                        },
                        success: function (data) {
                            
                            var filterData = [];

                            var searchData = eval("/" + text2.searchdata() + "/gi");

                            $.each(data, function (i, v) {
                                if ((v.BEN_CD.search(new RegExp(searchData)) != -1)   ||  (v.NAME.search(new RegExp(searchData)) != -1)   ) {
                                    filterData.push(v);
                                }
                            });
                            return filterData;
                        }
                    },
                    onchange: function () {
                        $("#ta-txt").html(text2.text());
                        $("#taid").html(text2.text());
						$('#BEN_CD2').val(text2.id());
					//showProduct();
                    }
                });
           }

	   
		     function   showProductList3(){
			  var str = document.getElementById("STATE_CD").value;
                var text2 = $("#Text3").tautocomplete({
                    width: "500px",
                    columns: ['BEN CODE','NAME'],
                    ajax: {
                          url: "jsontest.jsp?STATE_CD="+str,
                        type: "GET",
                        data: function () {
                            return [{ test: text2.searchdata() }];
                        },
                        success: function (data) {
                            
                            var filterData = [];

                            var searchData = eval("/" + text2.searchdata() + "/gi");

                            $.each(data, function (i, v) {
                                if ((v.BEN_CD.search(new RegExp(searchData)) != -1)   ||  (v.NAME.search(new RegExp(searchData)) != -1)   ) {
                                    filterData.push(v);
                                }
                            });
                            return filterData;
                        }
                    },
                    onchange: function () {
                        $("#ta-txt").html(text2.text());
                        $("#taid").html(text2.text());
						$('#BEN_CD3').val(text2.id());
					//showProduct();
                    }
                });
           }

	   
		     function   showProductList4(){
			  var str = document.getElementById("STATE_CD").value;
                var text2 = $("#Text4").tautocomplete({
                    width: "500px",
                    columns: ['BEN CODE','NAME'],
                    ajax: {
                         url: "jsontest.jsp?STATE_CD="+str,
                        type: "GET",
                        data: function () {
                            return [{ test: text2.searchdata() }];
                        },
                        success: function (data) {
                            
                            var filterData = [];

                            var searchData = eval("/" + text2.searchdata() + "/gi");

                            $.each(data, function (i, v) {
                                if ((v.BEN_CD.search(new RegExp(searchData)) != -1)   ||  (v.NAME.search(new RegExp(searchData)) != -1)   ) {
                                    filterData.push(v);
                                }
                            });
                            return filterData;
                        }
                    },
                    onchange: function () {
                        $("#ta-txt").html(text2.text());
                        $("#taid").html(text2.text());
						$('#BEN_CD4').val(text2.id());
					//showProduct();
                    }
                });
           }


		     function   showProductList5(){
			  var str = document.getElementById("STATE_CD").value;
                var text2 = $("#Text5").tautocomplete({
                    width: "500px",
                    columns: ['BEN CODE','NAME'],
                    ajax: {
                          url: "jsontest.jsp?STATE_CD="+str,
                        type: "GET",
                        data: function () {
                            return [{ test: text2.searchdata() }];
                        },
                        success: function (data) {
                            
                            var filterData = [];

                            var searchData = eval("/" + text2.searchdata() + "/gi");

                            $.each(data, function (i, v) {
                                if ((v.BEN_CD.search(new RegExp(searchData)) != -1)   ||  (v.NAME.search(new RegExp(searchData)) != -1)   ) {
                                    filterData.push(v);
                                }
                            });
                            return filterData;
                        }
                    },
                    onchange: function () {
                        $("#ta-txt").html(text2.text());
                        $("#taid").html(text2.text());
						$('#BEN_CD5').val(text2.id());
					//showProduct();
                    }
                });
           }

		     function   showProductList6(){
			  var str = document.getElementById("STATE_CD").value;
                var text2 = $("#Text6").tautocomplete({
                    width: "500px",
                    columns: ['BEN CODE','NAME'],
                    ajax: {
                          url: "jsontest.jsp?STATE_CD="+str,
                        type: "GET",
                        data: function () {
                            return [{ test: text2.searchdata() }];
                        },
                        success: function (data) {
                            
                            var filterData = [];

                            var searchData = eval("/" + text2.searchdata() + "/gi");

                            $.each(data, function (i, v) {
                                if ((v.BEN_CD.search(new RegExp(searchData)) != -1)   ||  (v.NAME.search(new RegExp(searchData)) != -1)   ) {
                                    filterData.push(v);
                                }
                            });
                            return filterData;
                        }
                    },
                    onchange: function () {
                        $("#ta-txt").html(text2.text());
                        $("#taid").html(text2.text());
						$('#BEN_CD6').val(text2.id());
					//showProduct();
                    }
                });
           }



		     function   showProductList7(){
			  var str = document.getElementById("STATE_CD").value;
                var text2 = $("#Text7").tautocomplete({
                    width: "500px",
                    columns: ['BEN CODE','NAME'],
                    ajax: {
                          url: "jsontest.jsp?STATE_CD="+str,
                        type: "GET",
                        data: function () {
                            return [{ test: text2.searchdata() }];
                        },
                        success: function (data) {
                            
                            var filterData = [];

                            var searchData = eval("/" + text2.searchdata() + "/gi");

                            $.each(data, function (i, v) {
                                if ((v.BEN_CD.search(new RegExp(searchData)) != -1)   ||  (v.NAME.search(new RegExp(searchData)) != -1)   ) {
                                    filterData.push(v);
                                }
                            });
                            return filterData;
                        }
                    },
                    onchange: function () {
                        $("#ta-txt").html(text2.text());
                        $("#taid").html(text2.text());
						$('#BEN_CD7').val(text2.id());
					//showProduct();
                    }
                });
           }



		     function   showProductList8(){
			  var str = document.getElementById("STATE_CD").value;
                var text2 = $("#Text8").tautocomplete({
                    width: "500px",
                    columns: ['BEN CODE','NAME'],
                    ajax: {
                          url: "jsontest.jsp?STATE_CD="+str,
                        type: "GET",
                        data: function () {
                            return [{ test: text2.searchdata() }];
                        },
                        success: function (data) {
                            
                            var filterData = [];

                            var searchData = eval("/" + text2.searchdata() + "/gi");

                            $.each(data, function (i, v) {
                                if ((v.BEN_CD.search(new RegExp(searchData)) != -1)   ||  (v.NAME.search(new RegExp(searchData)) != -1)   ) {
                                    filterData.push(v);
                                }
                            });
                            return filterData;
                        }
                    },
                    onchange: function () {
                        $("#ta-txt").html(text2.text());
                        $("#taid").html(text2.text());
						$('#BEN_CD8').val(text2.id());
					//showProduct();
                    }
                });
           }


		     function   showProductList9(){
			  var str = document.getElementById("STATE_CD").value;
                var text2 = $("#Text9").tautocomplete({
                    width: "500px",
                    columns: ['BEN CODE','NAME'],
                    ajax: {
                         url: "jsontest.jsp?STATE_CD="+str,
                        type: "GET",
                        data: function () {
                            return [{ test: text2.searchdata() }];
                        },
                        success: function (data) {
                            
                            var filterData = [];

                            var searchData = eval("/" + text2.searchdata() + "/gi");

                            $.each(data, function (i, v) {
                                if ((v.BEN_CD.search(new RegExp(searchData)) != -1)   ||  (v.NAME.search(new RegExp(searchData)) != -1)   ) {
                                    filterData.push(v);
                                }
                            });
                            return filterData;
                        }
                    },
                    onchange: function () {
                        $("#ta-txt").html(text2.text());
                        $("#taid").html(text2.text());
						$('#BEN_CD9').val(text2.id());
					//showProduct();
                    }
                });
           }


		     function   showProductList10(){
			  var str = document.getElementById("STATE_CD").value;
                var text2 = $("#Text10").tautocomplete({
                    width: "500px",
                    columns: ['BEN CODE','NAME'],
                    ajax: {
                         url: "jsontest.jsp?STATE_CD="+str,
                        type: "GET",
                        data: function () {
                            return [{ test: text2.searchdata() }];
                        },
                        success: function (data) {
                            
                            var filterData = [];

                            var searchData = eval("/" + text2.searchdata() + "/gi");

                            $.each(data, function (i, v) {
                                if ((v.BEN_CD.search(new RegExp(searchData)) != -1)   ||  (v.NAME.search(new RegExp(searchData)) != -1)   ) {
                                    filterData.push(v);
                                }
                            });
                            return filterData;
                        }
                    },
                    onchange: function () {
                        $("#ta-txt").html(text2.text());
                        $("#taid").html(text2.text());
						$('#BEN_CD10').val(text2.id());
					//showProduct();
                    }
                });
           }




function FUN_IFMS_YN(){


		 var IFMS_YN=document.getElementById("IFMS_YN").value;
	  //   var IFMS_YN=document.getElementById("IFMS_YN").value;

if(IFMS_YN=='YES'){
			   document.getElementById("IFMS_CODE1").readOnly=false;
			   document.getElementById("IFMS_CODE2").readOnly=false;
			   document.getElementById("IFMS_CODE3").readOnly=false;
			   document.getElementById("IFMS_CODE4").readOnly=false;
				  document.getElementById("IFMS_CODE5").readOnly=false;
				  document.getElementById("IFMS_CODE6").readOnly=false;
					document.getElementById("IFMS_CODE7").readOnly=false;
					document.getElementById("IFMS_CODE8").readOnly=false;
					document.getElementById("IFMS_CODE9").readOnly=false;
					document.getElementById("IFMS_CODE10").readOnly=false;
}else {

			   document.getElementById("IFMS_CODE1").readOnly=true;
			   document.getElementById("IFMS_CODE2").readOnly=true;
			   document.getElementById("IFMS_CODE3").readOnly=true;
			   document.getElementById("IFMS_CODE4").readOnly=true;
				  document.getElementById("IFMS_CODE5").readOnly=true;
				  document.getElementById("IFMS_CODE6").readOnly=true;
					document.getElementById("IFMS_CODE7").readOnly=true;
					document.getElementById("IFMS_CODE8").readOnly=true;
					document.getElementById("IFMS_CODE9").readOnly=true;
					document.getElementById("IFMS_CODE10").readOnly=true;
					
					
			document.getElementById("IFMS_CODE1").value='';
			   document.getElementById("IFMS_CODE2").value='';
			   document.getElementById("IFMS_CODE3").value='';
			   document.getElementById("IFMS_CODE4").value='';
				  document.getElementById("IFMS_CODE5").value='';
				  document.getElementById("IFMS_CODE6").value='';
					document.getElementById("IFMS_CODE7").value='';
					document.getElementById("IFMS_CODE8").value='';
					document.getElementById("IFMS_CODE9").value='';
					document.getElementById("IFMS_CODE10").value='';

}
}



function convertNumberToWords(amount) {
    var words = new Array();
    words[0] = '';
    words[1] = 'One';
    words[2] = 'Two';
    words[3] = 'Three';
    words[4] = 'Four';
    words[5] = 'Five';
    words[6] = 'Six';
    words[7] = 'Seven';
    words[8] = 'Eight';
    words[9] = 'Nine';
    words[10] = 'Ten';
    words[11] = 'Eleven';
    words[12] = 'Twelve';
    words[13] = 'Thirteen';
    words[14] = 'Fourteen';
    words[15] = 'Fifteen';
    words[16] = 'Sixteen';
    words[17] = 'Seventeen';
    words[18] = 'Eighteen';
    words[19] = 'Nineteen';
    words[20] = 'Twenty';
    words[30] = 'Thirty';
    words[40] = 'Forty';
    words[50] = 'Fifty';
    words[60] = 'Sixty';
    words[70] = 'Seventy';
    words[80] = 'Eighty';
    words[90] = 'Ninety';
    amount = amount.toString();
    var atemp = amount.split(".");
    var number = atemp[0].split(",").join("");
    var n_length = number.length;
    var words_string = "";
    if (n_length <= 9) {
        var n_array = new Array(0, 0, 0, 0, 0, 0, 0, 0, 0);
        var received_n_array = new Array();
        for (var i = 0; i < n_length; i++) {
            received_n_array[i] = number.substr(i, 1);
        }
        for (var i = 9 - n_length, j = 0; i < 9; i++, j++) {
            n_array[i] = received_n_array[j];
        }
        for (var i = 0, j = 1; i < 9; i++, j++) {
            if (i == 0 || i == 2 || i == 4 || i == 7) {
                if (n_array[i] == 1) {
                    n_array[j] = 10 + parseInt(n_array[j]);
                    n_array[i] = 0;
                }
            }
        }
        value = "";
        for (var i = 0; i < 9; i++) {
            if (i == 0 || i == 2 || i == 4 || i == 7) {
                value = n_array[i] * 10;
            } else {
                value = n_array[i];
            }
            if (value != 0) {
                words_string += words[value] + " ";
            }
            if ((i == 1 && value != 0) || (i == 0 && value != 0 && n_array[i + 1] == 0)) {
                words_string += "Crores ";
            }
            if ((i == 3 && value != 0) || (i == 2 && value != 0 && n_array[i + 1] == 0)) {
                words_string += "Lakhs ";
            }
            if ((i == 5 && value != 0) || (i == 4 && value != 0 && n_array[i + 1] == 0)) {
                words_string += "Thousand ";
            }
            if (i == 6 && value != 0 && (n_array[i + 1] != 0 && n_array[i + 2] != 0)) {
                words_string += "Hundred and ";
            } else if (i == 6 && value != 0) {
                words_string += "Hundred ";
            }
        }
        words_string = words_string.split("  ").join(" ");
    }
    return words_string;
}


function addTotAmt(){

		 var AMT1=document.getElementById("AMT1").value;
		 var AMT2=document.getElementById("AMT2").value;
		 var AMT3=document.getElementById("AMT3").value;
		 var AMT4=document.getElementById("AMT4").value;
		 var AMT5=document.getElementById("AMT5").value;
		 var AMT6=document.getElementById("AMT6").value;
		 var AMT7=document.getElementById("AMT7").value;
		 var AMT8=document.getElementById("AMT8").value;
		 var AMT9=document.getElementById("AMT9").value;
		 var AMT10=document.getElementById("AMT10").value;

var tot_amt=0;

tot_amt=Number(AMT1) + Number(AMT2) + Number(AMT3) + Number(AMT4) + Number(AMT5) + Number(AMT6) + Number(AMT7) + Number(AMT8) + Number(AMT9) + Number(AMT10);
document.getElementById("tot_amt").innerHTML=tot_amt;
}

/*
function myFunction() {

var array1 = ['10176546023'	,
'30692913112'	,
'30692959963'	,
'30692978294'	,
'30692979990'	,
'30692987118'	,
'31004343738'	,
'31004367181'	,
'32579018105'	,
'32579025338'	,
'32579027787'	,
'32627812890'	,
'32627813203'	,
'35952382577'	,
'36294666738'	,
'36295078111'	,
'37921193413'	,
];

var ACC_TO=document.form.ACC_TO.value;
var found = false;
for (var i = 0; i < array1.length && !found; i++) {
  if (array1[i] === ACC_TO) {
    found = true;
    break;
  }
}

if( found == false && ACC_TO!="") {
    inlineMsg('ACC_TO','Incorrect Account No. Please Verify',2);
    return false;
    }
}


*/

function submitform(){
 var rupeesonly=/^\d+\.\d{0,2}$/;
 var numberOnly=/^[0-9]*$/;



	 var NARRATION1=document.getElementById("NARRATION1").value;
	  var NARRATION2=document.getElementById("NARRATION2").value;
	   var NARRATION3=document.getElementById("NARRATION3").value;
	    var NARRATION4=document.getElementById("NARRATION4").value;
		 var NARRATION5=document.getElementById("NARRATION5").value;
		  var NARRATION6=document.getElementById("NARRATION6").value;
		   var NARRATION7=document.getElementById("NARRATION7").value;
		    var NARRATION8=document.getElementById("NARRATION8").value;
			 var NARRATION9=document.getElementById("NARRATION9").value;
			  var NARRATION10=document.getElementById("NARRATION10").value;
			  
			   var AMT1=document.getElementById("AMT1").value;
			   var AMT2=document.getElementById("AMT2").value;
			   var AMT3=document.getElementById("AMT3").value;
			   var AMT4=document.getElementById("AMT4").value;
			   var AMT5=document.getElementById("AMT5").value;
			   var AMT6=document.getElementById("AMT6").value;
			   var AMT7=document.getElementById("AMT7").value;
			   var AMT8=document.getElementById("AMT8").value;
			   var AMT9=document.getElementById("AMT9").value;
			   var AMT10=document.getElementById("AMT10").value;
			   
			   var ACC_HEAD1=document.getElementById("ACC_HEAD1").value;
			   var ACC_HEAD2=document.getElementById("ACC_HEAD2").value;
			   var ACC_HEAD3=document.getElementById("ACC_HEAD3").value;
			   var ACC_HEAD4=document.getElementById("ACC_HEAD4").value;
			   var ACC_HEAD5=document.getElementById("ACC_HEAD5").value;
			   var ACC_HEAD6=document.getElementById("ACC_HEAD6").value;
			   var ACC_HEAD7=document.getElementById("ACC_HEAD7").value;
			   var ACC_HEAD8=document.getElementById("ACC_HEAD8").value;
			   var ACC_HEAD9=document.getElementById("ACC_HEAD9").value;
			   var ACC_HEAD10=document.getElementById("ACC_HEAD10").value;
			   
			   var IFMS_CODE1=document.getElementById("IFMS_CODE1").value;
			    var IFMS_CODE2=document.getElementById("IFMS_CODE2").value;
				 var IFMS_CODE3=document.getElementById("IFMS_CODE3").value;
				  var IFMS_CODE4=document.getElementById("IFMS_CODE4").value;
				   var IFMS_CODE5=document.getElementById("IFMS_CODE5").value;
				    var IFMS_CODE6=document.getElementById("IFMS_CODE6").value;
					 var IFMS_CODE7=document.getElementById("IFMS_CODE7").value;
					  var IFMS_CODE8=document.getElementById("IFMS_CODE8").value;
					   var IFMS_CODE9=document.getElementById("IFMS_CODE9").value;
					    var IFMS_CODE10=document.getElementById("IFMS_CODE10").value;
						
				
				var BEN_CD1=document.getElementById("BEN_CD1").value;
				var BEN_CD2=document.getElementById("BEN_CD2").value;
				var BEN_CD3=document.getElementById("BEN_CD3").value;
				var BEN_CD4=document.getElementById("BEN_CD1").value;
				var BEN_CD5=document.getElementById("BEN_CD1").value;
				var BEN_CD6=document.getElementById("BEN_CD1").value;
				var BEN_CD7=document.getElementById("BEN_CD1").value;
				var BEN_CD8=document.getElementById("BEN_CD1").value;
				var BEN_CD9=document.getElementById("BEN_CD1").value;
				var BEN_CD10=document.getElementById("BEN_CD1").value;
				var IFMS_YN=document.getElementById("IFMS_YN").value;
				
				var ACC_FROM=document.getElementById("ACC_FROM").value;
				var ACC_TO=document.getElementById("ACC_TO").value;
				var IFSC_CODE=document.getElementById("IFSC_CODE").value;
				var PAYMENT_MODE=document.getElementById("PAYMENT_MODE").value;
				var TRANS_DATE=document.getElementById("TRANS_DATE").value;
				var UTRN_NO=document.getElementById("UTRN_NO").value;
				var COUNTFOIL_UP=document.getElementById("COUNTFOIL_UP").value;
					var TO_OFF_CD=document.getElementById("TO_OFF_CD").value;
				
				   if( ( TO_OFF_CD== "" || TO_OFF_CD == "0") ) {
				inlineMsg('TO_OFF_CD','Please Select ',2);
				return false;
			  }
			  
				
		  if( ( COUNTFOIL_UP== "" || COUNTFOIL_UP == "0") ) {
		  		  	
var uploadfile = document.form.uploadfile.value;
if(uploadfile == ""){
 inlineMsg('uploadfile','Choose File',2);
return false;
} 

}
				
           if( ( ACC_FROM== "" || ACC_FROM == "0") ) {
				inlineMsg('ACC_FROM','Enter Select ',2);
				return false;
			  }
			  
			  	 if(ACC_FROM.length < 9 &&  ACC_FROM != "" ) {
    inlineMsg('ACC_FROM','ACCOUNT SHOULD NOT BE LESS THEN 9 DIGIT',2);
    return false;
  }
  
    
	 		 if(ACC_FROM.length > 18 &&  ACC_FROM != "" ) {
    inlineMsg('ACC_FROM','ACCOUNT SHOULD NOT BE MORE THEN 18 DIGIT',2);
    return false;
  }
			  
	       if( ( ACC_TO== "" || ACC_TO == "0") ) {
				inlineMsg('ACC_TO','Enter Select ',2);
				return false;
			  }
			  
			   if(ACC_TO.length < 9 &&  ACC_TO != "" ) {
    inlineMsg('ACC_TO','ACCOUNT SHOULD NOT BE LESS THEN 9 DIGIT',2);
    return false;
  }
  
    
	 		 if(ACC_TO.length > 18 &&  ACC_TO != "" ) {
    inlineMsg('ACC_TO','ACCOUNT SHOULD NOT BE MORE THEN 18 DIGIT',2);
    return false;
  }
			  
		   if( ( IFSC_CODE== "" || IFSC_CODE == "0") ) {
				inlineMsg('IFSC_CODE','Please Enter  ',2);
				return false;
			  }
			  
			  	   if( ( PAYMENT_MODE== "" || PAYMENT_MODE == "0") ) {
				inlineMsg('PAYMENT_MODE','Enter Select ',2);
				return false;
			  }
			  
			  	   if( ( TRANS_DATE== "" || TRANS_DATE == "0") ) {
				inlineMsg('TRANS_DATE','Enter Select ',2);
				return false;
			  }
			  
			  	   if( ( UTRN_NO== "" || UTRN_NO == "0") ) {
				inlineMsg('UTRN_NO','Please Enter ',2);
				return false;
			  }
		  
			  /////////////////////////
			   
	          if( ( AMT1== "" || AMT1 == "0") ) {
				inlineMsg('AMT1','Amount Should not be zero or null',2);
				return false;
			  }
			  
			  	   if( ( ACC_HEAD1== "" || ACC_HEAD1 == "0") ) {
				inlineMsg('DACC_HEAD1','Select Account Head..........',2);
				return false;
			  }
			  
			  
	 		
  
	 if( IFMS_YN == 'YES' ){
	   if( ( IFMS_CODE1== "" || IFMS_CODE1 == "0") ) {
				inlineMsg('IFMS_CODE1','Enter IFMS CODE',2);
				return false;
		}
	 }
	 
	    if( ( AMT2== "" || AMT2 == "0") && !( ACC_HEAD2== "" || ACC_HEAD2 == "0") ) {
				inlineMsg('AMT2','Enter AMT',2);
				return false;
	   }
	 
	    if( ( AMT3== "" || AMT3 == "0") && !( ACC_HEAD3== "" || ACC_HEAD3 == "0") ) {
				inlineMsg('AMT3','Enter AMT',2);
				return false;
	   }
	 
	    if( ( AMT4== "" || AMT4 == "0") && !( ACC_HEAD4== "" || ACC_HEAD4 == "0") ) {
				inlineMsg('AMT4','Enter AMT',2);
				return false;
	   }
	 
	    if( ( AMT5== "" || AMT5 == "0") && !( ACC_HEAD5== "" || ACC_HEAD5 == "0") ) {
				inlineMsg('AMT5','Enter AMT',2);
				return false;
	   }
	 
	    if( ( AMT6== "" || AMT6 == "0") && !( ACC_HEAD6== "" || ACC_HEAD6 == "0") ) {
				inlineMsg('AMT6','Enter AMT',2);
				return false;
	   }

	    if( ( AMT7== "" || AMT7 == "0") && !( ACC_HEAD7== "" || ACC_HEAD7 == "0") ) {
				inlineMsg('AMT7','Enter AMT',2);
				return false;
	   }

	    if( ( AMT8== "" || AMT8 == "0") && !( ACC_HEAD8== "" || ACC_HEAD8 == "0") ) {
				inlineMsg('AMT8','Enter AMT',2);
				return false;
	   }

	    if( ( AMT9== "" || AMT9 == "0") && !( ACC_HEAD9== "" || ACC_HEAD9 == "0") ) {
				inlineMsg('AMT9','Enter AMT',2);
				return false;
	   }
	   
	    if( ( AMT10== "" || AMT10 == "0") && !( ACC_HEAD10== "" || ACC_HEAD10 == "0") ) {
				inlineMsg('AMT10','Enter AMT',2);
				return false;
	   }

	 ////////////////////////////////////////
	 
	   if( !( AMT2== "" || AMT2 == "0") && ( ACC_HEAD2== "" || ACC_HEAD2 == "0") ) {
				inlineMsg('ACC_HEAD2','Enter AMT',2);
				return false;
	   }
	 
	    if( !( AMT3== "" || AMT3 == "0") && ( ACC_HEAD3== "" || ACC_HEAD3 == "0") ) {
				inlineMsg('ACC_HEAD3','Enter AMT',2);
				return false;
	   }
	 
	    if( !( AMT4== "" || AMT4 == "0") && ( ACC_HEAD4== "" || ACC_HEAD4 == "0") ) {
				inlineMsg('ACC_HEAD4','Enter AMT',2);
				return false;
	   }
	 
	    if( !( AMT5== "" || AMT5 == "0") && ( ACC_HEAD5== "" || ACC_HEAD5 == "0") ) {
				inlineMsg('ACC_HEAD5','Enter AMT',2);
				return false;
	   }
	 
	    if( !( AMT6== "" || AMT6 == "0") && ( ACC_HEAD6== "" || ACC_HEAD6 == "0") ) {
				inlineMsg('ACC_HEAD6','Enter AMT',2);
				return false;
	   }

	    if( !( AMT7== "" || AMT7 == "0") && ( ACC_HEAD7== "" || ACC_HEAD7 == "0") ) {
				inlineMsg('ACC_HEAD7','Enter AMT',2);
				return false;
	   }

	    if( !( AMT8== "" || AMT8 == "0") && ( ACC_HEAD8== "" || ACC_HEAD8 == "0") ) {
				inlineMsg('ACC_HEAD8','Enter AMT',2);
				return false;
	   }

	    if( !( AMT9== "" || AMT9 == "0") && ( ACC_HEAD9== "" || ACC_HEAD9 == "0") ) {
				inlineMsg('ACC_HEAD9','Enter AMT',2);
				return false;
	   }
	   
	    if( !( AMT10== "" || AMT10 == "0") && ( ACC_HEAD10== "" || ACC_HEAD10 == "0") ) {
				inlineMsg('ACC_HEAD10','Enter AMT',2);
				return false;
	   }


/////////////////////////
	 
	 if( IFMS_YN == 'YES' ){
	   if( ( IFMS_CODE2== "" || IFMS_CODE2 == "0") && ( !( ACC_HEAD2== "" || ACC_HEAD2 == "0") || !( AMT2== "" || AMT2 == "0") )) {
				inlineMsg('IFMS_CODE2','Enter IFMS CODE',2);
				return false;
	   }
	   
	     if( ( IFMS_CODE3== "" || IFMS_CODE3 == "0") && ( !( ACC_HEAD3== "" || ACC_HEAD3 == "0") || !( AMT3== "" || AMT3 == "0") )) {
				inlineMsg('IFMS_CODE3','Enter IFMS CODE',2);
				return false;
	   }
	   
	     if( ( IFMS_CODE4== "" || IFMS_CODE4 == "0") && ( !( ACC_HEAD4== "" || ACC_HEAD4 == "0") || !( AMT4== "" || AMT4 == "0") )) {
				inlineMsg('IFMS_CODE4','Enter IFMS CODE',2);
				return false;
	   }
	   
	     if( ( IFMS_CODE5== "" || IFMS_CODE5 == "0") && ( !( ACC_HEAD5== "" || ACC_HEAD5 == "0") || !( AMT5== "" || AMT5 == "0") )) {
				inlineMsg('IFMS_CODE5','Enter IFMS CODE',2);
				return false;
	   }
	   
	     if( ( IFMS_CODE6== "" || IFMS_CODE6 == "0") && ( !( ACC_HEAD6== "" || ACC_HEAD6 == "0") || !( AMT6== "" || AMT6 == "0") )) {
				inlineMsg('IFMS_CODE6','Enter IFMS CODE',2);
				return false;
	   }
	   
	     if( ( IFMS_CODE7== "" || IFMS_CODE7 == "0") && ( !( ACC_HEAD7== "" || ACC_HEAD7 == "0") || !( AMT7== "" || AMT7 == "0") )) {
				inlineMsg('IFMS_CODE7','Enter IFMS CODE',2);
				return false;
	   }
	   
	     if( ( IFMS_CODE8== "" || IFMS_CODE8 == "0") && ( !( ACC_HEAD8== "" || ACC_HEAD8 == "0") || !( AMT8== "" || AMT8 == "0") )) {
				inlineMsg('IFMS_CODE8','Enter IFMS CODE',2);
				return false;
	   }
	   
	     if( ( IFMS_CODE9== "" || IFMS_CODE9 == "0") && ( !( ACC_HEAD9== "" || ACC_HEAD9 == "0") || !( AMT9== "" || AMT9 == "0") )) {
				inlineMsg('IFMS_CODE9','Enter IFMS CODE',2);
				return false;
	   }
	   
	     if( ( IFMS_CODE10== "" || IFMS_CODE10 == "0") && ( !( ACC_HEAD10== "" || ACC_HEAD10 == "0") || !( AMT10== "" || AMT10 == "0") )) {
				inlineMsg('IFMS_CODE10','Enter IFMS CODE',2);
				return false;
	   }
	 }

	 
	 
      if(!(rupeesonly.test(AMT1)||numberOnly.test(AMT1)) && (AMT1 != "" || AMT1 != "0") ) {
				inlineMsg('AMT1','Enter Only Numbers....',2);
				return false;
			  }
			  
			  if(!(rupeesonly.test(AMT2)||numberOnly.test(AMT2)) && !(AMT2 == "" || AMT2 == "0") ) {
				inlineMsg('AMT2','Enter Only Numbers....',2);
				return false;
			  }
			  if(!(rupeesonly.test(AMT3)||numberOnly.test(AMT3)) && !(AMT3 == "" || AMT3 == "0") ) {
				inlineMsg('AMT3','Enter Only Numbers....',2);
				return false;
			  }
			  			  if(!(rupeesonly.test(AMT4)||numberOnly.test(AMT4)) && !(AMT4 == "" || AMT4 == "0") ) {
				inlineMsg('AMT4','Enter Only Numbers....',2);
				return false;
			  }
			  
			  			  if(!(rupeesonly.test(AMT5)||numberOnly.test(AMT5)) && !(AMT5 == "" || AMT5 == "0") ) {
				inlineMsg('AMT5','Enter Only Numbers....',2);
				return false;
			  }
			  
			  			  if(!(rupeesonly.test(AMT6)||numberOnly.test(AMT6)) && !(AMT6 == "" || AMT6 == "0") ) {
				inlineMsg('AMT6','Enter Only Numbers....',2);
				return false;
			  }
			  
	 		  if(!(rupeesonly.test(AMT7)||numberOnly.test(AMT7)) && !(AMT7 == "" || AMT7 == "0") ) {
				inlineMsg('AMT7','Enter Only Numbers....',2);
				return false;
			  }
			  
			  		  if(!(rupeesonly.test(AMT8)||numberOnly.test(AMT8)) && !(AMT8 == "" || AMT8 == "0") ) {
				inlineMsg('AMAMT8T6','Enter Only Numbers....',2);
				return false;
			  }
			  
			  		  if(!(rupeesonly.test(AMT9)||numberOnly.test(AMT9)) && !(AMT9 == "" || AMT9 == "0") ) {
				inlineMsg('AMT9','Enter Only Numbers....',2);
				return false;
			  }
			  
			  		  if(!(rupeesonly.test(AMT10)||numberOnly.test(AMT10)) && !(AMT10 == "" || AMT10 == "0") ) {
				inlineMsg('AMT10','Enter Only Numbers....',2);
				return false;
			  }
			  
			  
	// NARRATION1.length
	

	 if(NARRATION1.length>200 &&  NARRATION1 != "" ) {
    inlineMsg('NARRATION1','Narration Should Not Exceed 200 Characters',2);
    return false;
  }
  
  	 if(NARRATION2.length>200 &&  NARRATION2 != "" ) {
    inlineMsg('NARRATION2','Narration Should Not Exceed 200 Characters',2);
    return false;
  }
  
  	 if(NARRATION3.length>200 &&  NARRATION3 != "" ) {
    inlineMsg('NARRATION3','Narration Should Not Exceed 200 Characters',2);
    return false;
  }
  
  	 if(NARRATION4.length>200 &&  NARRATION4 != "" ) {
    inlineMsg('NARRATION4','Narration Should Not Exceed 200 Characters',2);
    return false;
  }
  
  	 if(NARRATION5.length>200 &&  NARRATION5 != "" ) {
    inlineMsg('NARRATION5','Narration Should Not Exceed 200 Characters',2);
    return false;
  }
  
  	 if(NARRATION6.length>200 &&  NARRATION6 != "" ) {
    inlineMsg('NARRATION6','Narration Should Not Exceed 200 Characters',2);
    return false;
  }
  
  	 if(NARRATION7.length>200 &&  NARRATION7 != "" ) {
    inlineMsg('NARRATION7','Narration Should Not Exceed 200 Characters',2);
    return false;
  }
  
  	 if(NARRATION8.length>200 &&  NARRATION8 != "" ) {
    inlineMsg('NARRATION8','Narration Should Not Exceed 200 Characters',2);
    return false;
  }
  
  	 if(NARRATION9.length>200 &&  NARRATION9 != "" ) {
    inlineMsg('NARRATION9','Narration Should Not Exceed 200 Characters',2);
    return false;
  }
  
  	 if(NARRATION10.length>200 &&  NARRATION10 != "" ) {
    inlineMsg('NARRATION10','Narration Should Not Exceed 200 Characters',2);
    return false;
  }
  


document.form.INS.value='I';

document.form.submit();
	
}

</script>

<style type="text/css">
<!--
.style1 {
	color: #990000;
	font-size: 12;
}
.style2 {font-size: 18px}
.style3 {
	color: #FF0000;
	font-weight: bold;
}
-->
</style>
</head>
<body onLoad="addTotAmt();FUN_IFMS_YN();">

<%! 
public static String getExtension(String s) {
    String ext = null;
//	if( s.lastIndexOf('.')!= null ){
    int i = s.lastIndexOf('.');
	System.out.print( s.lastIndexOf('.'));
    if (i > 0 &&  i < s.length() - 1) {
        ext = s.substring(i+1).toLowerCase();
    }
	//}
    return ext;
	
}
 %>	
 <%

kvicGlobalPath sm = new kvicGlobalPath();
String globalpath=sm.getStorage("safal/upload/");
		//String b=sm.getStorage("KIMISKVICV2/uploadLogo/");

%>
<form method="post"  name="form" id="form" class="form"  enctype="multipart/form-data" >
 <jsp:useBean id="upBean" scope="page" class="javazoom.upload.UploadBean" >
  <jsp:setProperty name="upBean" property="folderstore" value="<%= globalpath %>" />
  <jsp:setProperty name="upBean" property="filesizelimit" value="5000000" />
   <jsp:setProperty name="upBean" property="overwrite" value="false" />
   <jsp:setProperty name="upBean" property="whitelist" value="*.jpg,*.jpeg,*.pdf" />
 </jsp:useBean>
<%

String SUSMID =request.getParameter("SUSMID")==null?"":(String) request.getParameter("SUSMID");
String COUNTFOIL_UP = "";

	String IFMS_YN=(String)session.getAttribute("SIFMS_YN")==null?"":(String)session.getAttribute("SIFMS_YN");
String INS=request.getParameter("INS")==null?"":(String) request.getParameter("INS");
String USER_TYPE="O";

String OFF_CD =SOFF_CD;

String TO_OFF_CD="";
String BEN_CD1 = ""; //request.getParameter("USER_TYPE")==null?"":(String) request.getParameter("USER_TYPE");
String BEN_CD2 = "";
String BEN_CD3 = "";
String BEN_CD4 = "";
String BEN_CD5 = "";
String BEN_CD6 = "";
String BEN_CD7 = "";
String BEN_CD8 = "";
String BEN_CD9 = "";
String BEN_CD10 = "";
String TOT_AMT = "";


String ACC_FROM = "";
String ACC_TO = "";
String IFSC_CODE = "";
String PAYMENT_MODE = "";
String TRANS_DATE = "";
String UTRN_NO = "";
String DOC_UP1 = "";
String DOC_UP2 = "";
String REMARK = "";
String UPDT_TIMESTAMP = "";
String ACT_YN = "";
String SUB_MODE = "";
String IFMS_CODE1 = "";
String NARRATION1 = "";
String ACC_HEAD1 = "";
String AMT1 = "";
String IFMS_CODE2 = "";
String NARRATION2 = "";
String ACC_HEAD2 = "";
String AMT2 = "";
String IFMS_CODE3 = "";
String NARRATION3 = "";
String ACC_HEAD3 = "";
String AMT3 = "";
String IFMS_CODE4 = "";
String NARRATION4 = "";
String ACC_HEAD4 = "";
String AMT4 = "";
String IFMS_CODE5 = "";
String NARRATION5 = "";
String ACC_HEAD5 = "";
String AMT5 = "";
String IFMS_CODE6 = "";
String NARRATION6 = "";
String ACC_HEAD6 = "";
String AMT6 = "";
String IFMS_CODE7 = "";
String NARRATION7 = "";
String ACC_HEAD7 = "";
String AMT7 = "";
String IFMS_CODE8 = "";
String NARRATION8 = "";
String ACC_HEAD8 = "";
String AMT8 = "";
String IFMS_CODE9 = "";
String NARRATION9 = "";
String ACC_HEAD9 = "";
String AMT9 = "";
String IFMS_CODE10 = "";
String NARRATION10 = "";
String ACC_HEAD10 = "";
String AMT10 = "";
String ins="";
String UDT="I";


String ACC_NAME1="";
String ACC_NAME2="";
String ACC_NAME3="";
String ACC_NAME4="";
String ACC_NAME5="";
String ACC_NAME6="";
String ACC_NAME7="";
String ACC_NAME8="";
String ACC_NAME9="";
String ACC_NAME10="";



String STATE_CD="";
String OFF_NAME="";
String WHRCLS="";
String BEN_NM="";

String BEN_NM1="";
String BEN_NM2="";
String BEN_NM3="";
String BEN_NM4="";
String BEN_NM5="";
String BEN_NM6="";
String BEN_NM7="";
String BEN_NM8="";
String BEN_NM9="";
String BEN_NM10="";
String err="";


 DBCon db= new DBCon();
db.connect();
	 List values=new ArrayList();	
    List pstm=new ArrayList();


if(USER_TYPE.equals("I")){
WHRCLS=" AND MH.BEN_CD="+BEN_CD1+"";
}




  StringBuffer qrysb = new StringBuffer();

qrysb.append(" SELECT MS.STATE_CD,OM.OFF_NAME  FROM MAS.ECOM_USERMAST EC,MAS.OFF_MAST OM,M_DISTRICT MD,M_STATE MS WHERE EC.OFF_CD=OM.OFF_CD AND OM.DISTRICT_CD=MD.DISTRICT_CD AND MD.STATE_CD=MS.STATE_CD AND OM.OFF_CD=? " );
 values.add (OFF_CD);   //
//out.print (qrysb.toString());


  ResultSet rsMain = db.executeSQL(qrysb.toString(),values);

   	values.clear();

	while (rsMain.next()){
	
STATE_CD=rsMain.getString("STATE_CD")==null?"":rsMain.getString("STATE_CD");
OFF_NAME=rsMain.getString("OFF_NAME")==null?"":rsMain.getString("OFF_NAME");

}
rsMain.close();




  StringBuffer qrysb1 = new StringBuffer();

qrysb1.append(" select TO_OFF_CD,DECODE(IFMS_CODE1,NULL,'NO',0,'NO','YES') IFMS_YN,SUSMID, COUNTFOIL_UP, OFF_CD, ACC_FROM, ACC_TO, IFSC_CODE, PAYMENT_MODE, TOT_AMT, TO_CHAR(TRANS_DATE,'DD-MON-YYYY') TRANS_DATE, UTRN_NO, DOC_UP1, DOC_UP2, REMARK, UPDT_TIMESTAMP, ACT_YN, SUB_MODE, IFMS_CODE1, NARRATION1, ACC_HEAD1, AMT1, BEN_CD1, IFMS_CODE2, NARRATION2, ACC_HEAD2, AMT2, BEN_CD2, IFMS_CODE3, NARRATION3, ACC_HEAD3, AMT3, BEN_CD3, IFMS_CODE4, NARRATION4, ACC_HEAD4, AMT4, BEN_CD4, IFMS_CODE5, NARRATION5, ACC_HEAD5, AMT5, BEN_CD5, IFMS_CODE6, NARRATION6, ACC_HEAD6, AMT6, BEN_CD6, IFMS_CODE7, NARRATION7, ACC_HEAD7, AMT7, BEN_CD7, IFMS_CODE8, NARRATION8, ACC_HEAD8, AMT8, BEN_CD8, IFMS_CODE9, NARRATION9,  ACC_HEAD9, AMT9, BEN_CD9, IFMS_CODE10, NARRATION10, ACC_HEAD10, AMT10, BEN_CD10, USER_TYPE,     (select ACC_NAME from SAFAL.ACC_HEAD_MASTER_SUS where  acc_head=ACC_HEAD1) ACC_NAME1,     (select ACC_NAME from SAFAL.ACC_HEAD_MASTER_SUS where  acc_head=ACC_HEAD2) ACC_NAME2,     (select ACC_NAME from SAFAL.ACC_HEAD_MASTER_SUS where  acc_head=ACC_HEAD3) ACC_NAME3,     (select ACC_NAME from SAFAL.ACC_HEAD_MASTER_SUS where  acc_head=ACC_HEAD4) ACC_NAME4,     (select ACC_NAME from SAFAL.ACC_HEAD_MASTER_SUS where  acc_head=ACC_HEAD5) ACC_NAME5,     (select ACC_NAME from SAFAL.ACC_HEAD_MASTER_SUS where  acc_head=ACC_HEAD6) ACC_NAME6,     (select ACC_NAME from SAFAL.ACC_HEAD_MASTER_SUS where  acc_head=ACC_HEAD7) ACC_NAME7,     (select ACC_NAME from SAFAL.ACC_HEAD_MASTER_SUS where  acc_head=ACC_HEAD8) ACC_NAME8,     (select ACC_NAME from SAFAL.ACC_HEAD_MASTER_SUS where  acc_head=ACC_HEAD9) ACC_NAME9,     (select ACC_NAME from SAFAL.ACC_HEAD_MASTER_SUS where  acc_head=ACC_HEAD10) ACC_NAME10,  (select '('||BEN_cD||')'||BEN_NM from MAS.MH_BENEFICIARY where  ben_cd=BEN_CD1) BEN_NM1,    (select '('||BEN_cD||')'||BEN_NM from MAS.MH_BENEFICIARY where  ben_cd=ben_cd2) BEN_NM2,     (select '('||BEN_cD||')'||BEN_NM from MAS.MH_BENEFICIARY where  ben_cd=ben_cd3) BEN_NM3,     (select '('||BEN_cD||')'||BEN_NM from MAS.MH_BENEFICIARY where  ben_cd=ben_cd4) BEN_NM4,     (select '('||BEN_cD||')'||BEN_NM from MAS.MH_BENEFICIARY where  ben_cd=ben_cd5) BEN_NM5,     (select '('||BEN_cD||')'||BEN_NM from MAS.MH_BENEFICIARY where  ben_cd=ben_cd6) BEN_NM6,     (select '('||BEN_cD||')'||BEN_NM from MAS.MH_BENEFICIARY where  ben_cd=ben_cd7) BEN_NM7,    (select '('||BEN_cD||')'||BEN_NM from MAS.MH_BENEFICIARY where  ben_cd=ben_cd8) BEN_NM8,    (select '('||BEN_cD||')'||BEN_NM from MAS.MH_BENEFICIARY where  ben_cd=ben_cd9) BEN_NM9,    (select '('||BEN_cD||')'||BEN_NM from MAS.MH_BENEFICIARY where  ben_cd=BEN_CD10) BEN_NM10   from SAFAL.SUSPENSE_HO_MAST where  SUSMID=? " ); 

 values.add (SUSMID);   //
//out.print (qrysb.toString());


  ResultSet rsMain1 = db.executeSQL(qrysb1.toString(),values);

   	values.clear();

	while (rsMain1.next()){
	TO_OFF_CD=rsMain1.getString("TO_OFF_CD")==null?"":rsMain1.getString("TO_OFF_CD");
IFMS_YN=rsMain1.getString("IFMS_YN")==null?"":rsMain1.getString("IFMS_YN");
SUSMID=rsMain1.getString("SUSMID")==null?"":rsMain1.getString("SUSMID");
COUNTFOIL_UP=rsMain1.getString("COUNTFOIL_UP")==null?"":rsMain1.getString("COUNTFOIL_UP");
OFF_CD=rsMain1.getString("OFF_CD")==null?"":rsMain1.getString("OFF_CD");
ACC_FROM=rsMain1.getString("ACC_FROM")==null?"":rsMain1.getString("ACC_FROM");
ACC_TO=rsMain1.getString("ACC_TO")==null?"":rsMain1.getString("ACC_TO");
IFSC_CODE=rsMain1.getString("IFSC_CODE")==null?"":rsMain1.getString("IFSC_CODE");
PAYMENT_MODE=rsMain1.getString("PAYMENT_MODE")==null?"":rsMain1.getString("PAYMENT_MODE");
TOT_AMT=rsMain1.getString("TOT_AMT")==null?"":rsMain1.getString("TOT_AMT");
TRANS_DATE=rsMain1.getString("TRANS_DATE")==null?"":rsMain1.getString("TRANS_DATE");
UTRN_NO=rsMain1.getString("UTRN_NO")==null?"":rsMain1.getString("UTRN_NO");
DOC_UP1=rsMain1.getString("DOC_UP1")==null?"":rsMain1.getString("DOC_UP1");
DOC_UP2=rsMain1.getString("DOC_UP2")==null?"":rsMain1.getString("DOC_UP2");
REMARK=rsMain1.getString("REMARK")==null?"":rsMain1.getString("REMARK");
UPDT_TIMESTAMP=rsMain1.getString("UPDT_TIMESTAMP")==null?"":rsMain1.getString("UPDT_TIMESTAMP");
ACT_YN=rsMain1.getString("ACT_YN")==null?"":rsMain1.getString("ACT_YN");
SUB_MODE=rsMain1.getString("SUB_MODE")==null?"":rsMain1.getString("SUB_MODE");
IFMS_CODE1=rsMain1.getString("IFMS_CODE1")==null?"":rsMain1.getString("IFMS_CODE1");
NARRATION1=rsMain1.getString("NARRATION1")==null?"":rsMain1.getString("NARRATION1");
ACC_HEAD1=rsMain1.getString("ACC_HEAD1")==null?"":rsMain1.getString("ACC_HEAD1");
AMT1=rsMain1.getString("AMT1")==null?"":rsMain1.getString("AMT1");
BEN_CD1=rsMain1.getString("BEN_CD1")==null?"":rsMain1.getString("BEN_CD1");
IFMS_CODE2=rsMain1.getString("IFMS_CODE2")==null?"":rsMain1.getString("IFMS_CODE2");
NARRATION2=rsMain1.getString("NARRATION2")==null?"":rsMain1.getString("NARRATION2");
ACC_HEAD2=rsMain1.getString("ACC_HEAD2")==null?"":rsMain1.getString("ACC_HEAD2");
AMT2=rsMain1.getString("AMT2")==null?"":rsMain1.getString("AMT2");
BEN_CD2=rsMain1.getString("BEN_CD2")==null?"":rsMain1.getString("BEN_CD2");
IFMS_CODE3=rsMain1.getString("IFMS_CODE3")==null?"":rsMain1.getString("IFMS_CODE3");
NARRATION3=rsMain1.getString("NARRATION3")==null?"":rsMain1.getString("NARRATION3");
ACC_HEAD3=rsMain1.getString("ACC_HEAD3")==null?"":rsMain1.getString("ACC_HEAD3");
AMT3=rsMain1.getString("AMT3")==null?"":rsMain1.getString("AMT3");
BEN_CD3=rsMain1.getString("BEN_CD3")==null?"":rsMain1.getString("BEN_CD3");
IFMS_CODE4=rsMain1.getString("IFMS_CODE4")==null?"":rsMain1.getString("IFMS_CODE4");
NARRATION4=rsMain1.getString("NARRATION4")==null?"":rsMain1.getString("NARRATION4");
ACC_HEAD4=rsMain1.getString("ACC_HEAD4")==null?"":rsMain1.getString("ACC_HEAD4");
AMT4=rsMain1.getString("AMT4")==null?"":rsMain1.getString("AMT4");
BEN_CD4=rsMain1.getString("BEN_CD4")==null?"":rsMain1.getString("BEN_CD4");
IFMS_CODE5=rsMain1.getString("IFMS_CODE5")==null?"":rsMain1.getString("IFMS_CODE5");
NARRATION5=rsMain1.getString("NARRATION5")==null?"":rsMain1.getString("NARRATION5");
ACC_HEAD5=rsMain1.getString("ACC_HEAD5")==null?"":rsMain1.getString("ACC_HEAD5");
AMT5=rsMain1.getString("AMT5")==null?"":rsMain1.getString("AMT5");
BEN_CD5=rsMain1.getString("BEN_CD5")==null?"":rsMain1.getString("BEN_CD5");
IFMS_CODE6=rsMain1.getString("IFMS_CODE6")==null?"":rsMain1.getString("IFMS_CODE6");
NARRATION6=rsMain1.getString("NARRATION6")==null?"":rsMain1.getString("NARRATION6");
ACC_HEAD6=rsMain1.getString("ACC_HEAD6")==null?"":rsMain1.getString("ACC_HEAD6");
AMT6=rsMain1.getString("AMT6")==null?"":rsMain1.getString("AMT6");
BEN_CD6=rsMain1.getString("BEN_CD6")==null?"":rsMain1.getString("BEN_CD6");
IFMS_CODE7=rsMain1.getString("IFMS_CODE7")==null?"":rsMain1.getString("IFMS_CODE7");
NARRATION7=rsMain1.getString("NARRATION7")==null?"":rsMain1.getString("NARRATION7");
ACC_HEAD7=rsMain1.getString("ACC_HEAD7")==null?"":rsMain1.getString("ACC_HEAD7");
AMT7=rsMain1.getString("AMT7")==null?"":rsMain1.getString("AMT7");
BEN_CD7=rsMain1.getString("BEN_CD7")==null?"":rsMain1.getString("BEN_CD7");
IFMS_CODE8=rsMain1.getString("IFMS_CODE8")==null?"":rsMain1.getString("IFMS_CODE8");
NARRATION8=rsMain1.getString("NARRATION8")==null?"":rsMain1.getString("NARRATION8");
ACC_HEAD8=rsMain1.getString("ACC_HEAD8")==null?"":rsMain1.getString("ACC_HEAD8");
AMT8=rsMain1.getString("AMT8")==null?"":rsMain1.getString("AMT8");
BEN_CD8=rsMain1.getString("BEN_CD8")==null?"":rsMain1.getString("BEN_CD8");
IFMS_CODE9=rsMain1.getString("IFMS_CODE9")==null?"":rsMain1.getString("IFMS_CODE9");
NARRATION9=rsMain1.getString("NARRATION9")==null?"":rsMain1.getString("NARRATION9");
ACC_HEAD9=rsMain1.getString("ACC_HEAD9")==null?"":rsMain1.getString("ACC_HEAD9");
AMT9=rsMain1.getString("AMT9")==null?"":rsMain1.getString("AMT9");
BEN_CD9=rsMain1.getString("BEN_CD9")==null?"":rsMain1.getString("BEN_CD9");
IFMS_CODE10=rsMain1.getString("IFMS_CODE10")==null?"":rsMain1.getString("IFMS_CODE10");
NARRATION10=rsMain1.getString("NARRATION10")==null?"":rsMain1.getString("NARRATION10");
ACC_HEAD10=rsMain1.getString("ACC_HEAD10")==null?"":rsMain1.getString("ACC_HEAD10");
AMT10=rsMain1.getString("AMT10")==null?"":rsMain1.getString("AMT10");
BEN_CD10=rsMain1.getString("BEN_CD10")==null?"":rsMain1.getString("BEN_CD10");
USER_TYPE=rsMain1.getString("USER_TYPE")==null?"":rsMain1.getString("USER_TYPE");

 ACC_NAME1=rsMain1.getString("ACC_NAME1")==null?"":rsMain1.getString("ACC_NAME1");
 ACC_NAME2=rsMain1.getString("ACC_NAME2")==null?"":rsMain1.getString("ACC_NAME2");
 ACC_NAME3=rsMain1.getString("ACC_NAME3")==null?"":rsMain1.getString("ACC_NAME3");
 ACC_NAME4=rsMain1.getString("ACC_NAME4")==null?"":rsMain1.getString("ACC_NAME4");
 ACC_NAME5=rsMain1.getString("ACC_NAME5")==null?"":rsMain1.getString("ACC_NAME5");
 ACC_NAME6=rsMain1.getString("ACC_NAME6")==null?"":rsMain1.getString("ACC_NAME6");
 ACC_NAME7=rsMain1.getString("ACC_NAME7")==null?"":rsMain1.getString("ACC_NAME7");
 ACC_NAME8=rsMain1.getString("ACC_NAME8")==null?"":rsMain1.getString("ACC_NAME8");
 ACC_NAME9=rsMain1.getString("ACC_NAME9")==null?"":rsMain1.getString("ACC_NAME9");
 ACC_NAME10=rsMain1.getString("ACC_NAME10")==null?"":rsMain1.getString("ACC_NAME10");
 
 BEN_NM1=rsMain1.getString("BEN_NM1")==null?"":rsMain1.getString("BEN_NM1");
 BEN_NM2=rsMain1.getString("BEN_NM2")==null?"":rsMain1.getString("BEN_NM2");
 BEN_NM3=rsMain1.getString("BEN_NM3")==null?"":rsMain1.getString("BEN_NM3");
 BEN_NM4=rsMain1.getString("BEN_NM4")==null?"":rsMain1.getString("BEN_NM4");
 BEN_NM5=rsMain1.getString("BEN_NM5")==null?"":rsMain1.getString("BEN_NM5");
 BEN_NM6=rsMain1.getString("BEN_NM6")==null?"":rsMain1.getString("BEN_NM6");
 BEN_NM7=rsMain1.getString("BEN_NM7")==null?"":rsMain1.getString("BEN_NM7");
 BEN_NM8=rsMain1.getString("BEN_NM8")==null?"":rsMain1.getString("BEN_NM8");
 BEN_NM9=rsMain1.getString("BEN_NM9")==null?"":rsMain1.getString("BEN_NM9");
 BEN_NM10=rsMain1.getString("BEN_NM10")==null?"":rsMain1.getString("BEN_NM10");

UDT="U";
}
rsMain1.close();



%>
<br>
<input type="hidden" name="STATE_CD" id="STATE_CD" value="<%= STATE_CD %>">

<input type="hidden" name="USER_TYPE" id="USER_TYPE" value="<%= USER_TYPE %>">
<input type="hidden" name="COUNTFOIL_UP" id="COUNTFOIL_UP" value="<%= COUNTFOIL_UP %>">

<input type="hidden" name="OFF_CD" id="OFF_CD" value="<%= OFF_CD %>">

 <input type="hidden" name="todo" value="upload"/><input name="INS" type="hidden" id="INS" value=""  />
 
    <%
 try {                              //try 1
 
      if (MultipartFormDataRequest.isMultipartFormData(request))
      {                                            
	  
	  
         MultipartFormDataRequest mrequest = new MultipartFormDataRequest(request);
         String todo = null;
         if (mrequest != null) todo = mrequest.getParameter("todo");
	     if ( (todo != null) && (todo.equalsIgnoreCase("upload")) )
	     {                                                     //if3
                Hashtable files = mrequest.getFiles();
							
                if ( (files != null) && (!files.isEmpty()))
                {     												//if 4
                    UploadFile file = (UploadFile) files.get("uploadfile");
					
					 upBean.store(mrequest, "uploadfile");
						String maxID="1111";
						
					
				
					if(UDT.equals("I")){
		
	ResultSet rsMax= db.execSQL("SELECT SAFAL.SEQ_SUSPENSE_HO.NEXTVAL FROM DUAL");
		   while (rsMax.next()) {  //6
           SUSMID=rsMax.getString(1);
           }  rsMax.close();
		   
					}else{
					SUSMID=(String) mrequest.getParameter("SUSMID")==null?SUSMID:(String) mrequest.getParameter("SUSMID").trim();

					}
						
						Date dNow = new Date();
						SimpleDateFormat ft = new SimpleDateFormat("yyMMddhhmmssMs");
						String rnddt = ft.format(dNow);
						
						
							String ext="";
						try{
						ext=getExtension(file.getFileName());
						}catch(Exception e){}
						String frenNm="P"+SUSMID+rnddt+"."+ext;
						
						
						File f = new File(globalpath+file.getFileName()+"");
						
						boolean success =f.renameTo(new File(globalpath+frenNm+""));
						
	COUNTFOIL_UP=(String) mrequest.getParameter("COUNTFOIL_UP")==null?"":(String) mrequest.getParameter("COUNTFOIL_UP").trim();	
											
						frenNm=ext.equals("")?COUNTFOIL_UP:frenNm;
				
						
		StringBuffer qryUpdate = new StringBuffer();
		IFMS_YN=(String) mrequest.getParameter("IFMS_YN")==null?"":(String) mrequest.getParameter("IFMS_YN").trim();
		OFF_CD=(String) mrequest.getParameter("OFF_CD")==null?"":(String) mrequest.getParameter("OFF_CD").trim();
ACC_FROM=(String) mrequest.getParameter("ACC_FROM")==null?"":(String) mrequest.getParameter("ACC_FROM").trim();
ACC_TO=(String) mrequest.getParameter("ACC_TO")==null?"":(String) mrequest.getParameter("ACC_TO").trim();
IFSC_CODE=(String) mrequest.getParameter("IFSC_CODE")==null?"":(String) mrequest.getParameter("IFSC_CODE").trim();
PAYMENT_MODE=(String) mrequest.getParameter("PAYMENT_MODE")==null?"":(String) mrequest.getParameter("PAYMENT_MODE").trim();
TOT_AMT=(String) mrequest.getParameter("TOT_AMT")==null?"":(String) mrequest.getParameter("TOT_AMT").trim();
TRANS_DATE=(String) mrequest.getParameter("TRANS_DATE")==null?"":(String) mrequest.getParameter("TRANS_DATE").trim();
UTRN_NO=(String) mrequest.getParameter("UTRN_NO")==null?"":(String) mrequest.getParameter("UTRN_NO").trim();
DOC_UP1=(String) mrequest.getParameter("DOC_UP1")==null?"":(String) mrequest.getParameter("DOC_UP1").trim();
DOC_UP2=(String) mrequest.getParameter("DOC_UP2")==null?"":(String) mrequest.getParameter("DOC_UP2").trim();
REMARK=(String) mrequest.getParameter("REMARK")==null?"":(String) mrequest.getParameter("REMARK").trim();
UPDT_TIMESTAMP=(String) mrequest.getParameter("UPDT_TIMESTAMP")==null?"":(String) mrequest.getParameter("UPDT_TIMESTAMP").trim();
ACT_YN=(String) mrequest.getParameter("ACT_YN")==null?"":(String) mrequest.getParameter("ACT_YN").trim();
SUB_MODE=(String) mrequest.getParameter("SUB_MODE")==null?"":(String) mrequest.getParameter("SUB_MODE").trim();
IFMS_CODE1=(String) mrequest.getParameter("IFMS_CODE1")==null?"":(String) mrequest.getParameter("IFMS_CODE1").trim();
NARRATION1=(String) mrequest.getParameter("NARRATION1")==null?"":(String) mrequest.getParameter("NARRATION1").trim();
ACC_HEAD1=(String) mrequest.getParameter("ACC_HEAD1")==null?"":(String) mrequest.getParameter("ACC_HEAD1").trim();
AMT1=(String) mrequest.getParameter("AMT1")==null?"":(String) mrequest.getParameter("AMT1").trim();

BEN_CD1=(String) mrequest.getParameter("BEN_CD1")==null?"":(String) mrequest.getParameter("BEN_CD1").trim();
IFMS_CODE2=(String) mrequest.getParameter("IFMS_CODE2")==null?"":(String) mrequest.getParameter("IFMS_CODE2").trim();
NARRATION2=(String) mrequest.getParameter("NARRATION2")==null?"":(String) mrequest.getParameter("NARRATION2").trim();
ACC_HEAD2=(String) mrequest.getParameter("ACC_HEAD2")==null?"":(String) mrequest.getParameter("ACC_HEAD2").trim();
AMT2=(String) mrequest.getParameter("AMT2")==null?"":(String) mrequest.getParameter("AMT2").trim();
BEN_CD2=(String) mrequest.getParameter("BEN_CD2")==null?"":(String) mrequest.getParameter("BEN_CD2").trim();
IFMS_CODE3=(String) mrequest.getParameter("IFMS_CODE3")==null?"":(String) mrequest.getParameter("IFMS_CODE3").trim();
NARRATION3=(String) mrequest.getParameter("NARRATION3")==null?"":(String) mrequest.getParameter("NARRATION3").trim();
ACC_HEAD3=(String) mrequest.getParameter("ACC_HEAD3")==null?"":(String) mrequest.getParameter("ACC_HEAD3").trim();
AMT3=(String) mrequest.getParameter("AMT3")==null?"":(String) mrequest.getParameter("AMT3").trim();
BEN_CD3=(String) mrequest.getParameter("BEN_CD3")==null?"":(String) mrequest.getParameter("BEN_CD3").trim();
IFMS_CODE4=(String) mrequest.getParameter("IFMS_CODE4")==null?"":(String) mrequest.getParameter("IFMS_CODE4").trim();
NARRATION4=(String) mrequest.getParameter("NARRATION4")==null?"":(String) mrequest.getParameter("NARRATION4").trim();
ACC_HEAD4=(String) mrequest.getParameter("ACC_HEAD4")==null?"":(String) mrequest.getParameter("ACC_HEAD4").trim();
AMT4=(String) mrequest.getParameter("AMT4")==null?"":(String) mrequest.getParameter("AMT4").trim();
BEN_CD4=(String) mrequest.getParameter("BEN_CD4")==null?"":(String) mrequest.getParameter("BEN_CD4").trim();
IFMS_CODE5=(String) mrequest.getParameter("IFMS_CODE5")==null?"":(String) mrequest.getParameter("IFMS_CODE5").trim();
NARRATION5=(String) mrequest.getParameter("NARRATION5")==null?"":(String) mrequest.getParameter("NARRATION5").trim();
ACC_HEAD5=(String) mrequest.getParameter("ACC_HEAD5")==null?"":(String) mrequest.getParameter("ACC_HEAD5").trim();
AMT5=(String) mrequest.getParameter("AMT5")==null?"":(String) mrequest.getParameter("AMT5").trim();
BEN_CD5=(String) mrequest.getParameter("BEN_CD5")==null?"":(String) mrequest.getParameter("BEN_CD5").trim();
IFMS_CODE6=(String) mrequest.getParameter("IFMS_CODE6")==null?"":(String) mrequest.getParameter("IFMS_CODE6").trim();
NARRATION6=(String) mrequest.getParameter("NARRATION6")==null?"":(String) mrequest.getParameter("NARRATION6").trim();
ACC_HEAD6=(String) mrequest.getParameter("ACC_HEAD6")==null?"":(String) mrequest.getParameter("ACC_HEAD6").trim();
AMT6=(String) mrequest.getParameter("AMT6")==null?"":(String) mrequest.getParameter("AMT6").trim();
BEN_CD6=(String) mrequest.getParameter("BEN_CD6")==null?"":(String) mrequest.getParameter("BEN_CD6").trim();
IFMS_CODE7=(String) mrequest.getParameter("IFMS_CODE7")==null?"":(String) mrequest.getParameter("IFMS_CODE7").trim();
NARRATION7=(String) mrequest.getParameter("NARRATION7")==null?"":(String) mrequest.getParameter("NARRATION7").trim();
ACC_HEAD7=(String) mrequest.getParameter("ACC_HEAD7")==null?"":(String) mrequest.getParameter("ACC_HEAD7").trim();
AMT7=(String) mrequest.getParameter("AMT7")==null?"":(String) mrequest.getParameter("AMT7").trim();
BEN_CD7=(String) mrequest.getParameter("BEN_CD7")==null?"":(String) mrequest.getParameter("BEN_CD7").trim();
IFMS_CODE8=(String) mrequest.getParameter("IFMS_CODE8")==null?"":(String) mrequest.getParameter("IFMS_CODE8").trim();
NARRATION8=(String) mrequest.getParameter("NARRATION8")==null?"":(String) mrequest.getParameter("NARRATION8").trim();
ACC_HEAD8=(String) mrequest.getParameter("ACC_HEAD8")==null?"":(String) mrequest.getParameter("ACC_HEAD8").trim();
AMT8=(String) mrequest.getParameter("AMT8")==null?"":(String) mrequest.getParameter("AMT8").trim();
BEN_CD8=(String) mrequest.getParameter("BEN_CD8")==null?"":(String) mrequest.getParameter("BEN_CD8").trim();
IFMS_CODE9=(String) mrequest.getParameter("IFMS_CODE9")==null?"":(String) mrequest.getParameter("IFMS_CODE9").trim();
NARRATION9=(String) mrequest.getParameter("NARRATION9")==null?"":(String) mrequest.getParameter("NARRATION9").trim();
ACC_HEAD9=(String) mrequest.getParameter("ACC_HEAD9")==null?"":(String) mrequest.getParameter("ACC_HEAD9").trim();
AMT9=(String) mrequest.getParameter("AMT9")==null?"":(String) mrequest.getParameter("AMT9").trim();
BEN_CD9=(String) mrequest.getParameter("BEN_CD9")==null?"":(String) mrequest.getParameter("BEN_CD9").trim();
IFMS_CODE10=(String) mrequest.getParameter("IFMS_CODE10")==null?"":(String) mrequest.getParameter("IFMS_CODE10").trim();
NARRATION10=(String) mrequest.getParameter("NARRATION10")==null?"":(String) mrequest.getParameter("NARRATION10").trim();
ACC_HEAD10=(String) mrequest.getParameter("ACC_HEAD10")==null?"":(String) mrequest.getParameter("ACC_HEAD10").trim();
AMT10=(String) mrequest.getParameter("AMT10")==null?"":(String) mrequest.getParameter("AMT10").trim();
BEN_CD10=(String) mrequest.getParameter("BEN_CD10")==null?"":(String) mrequest.getParameter("BEN_CD10").trim();
USER_TYPE=(String) mrequest.getParameter("USER_TYPE")==null?"":(String) mrequest.getParameter("USER_TYPE").trim();
TO_OFF_CD=(String) mrequest.getParameter("TO_OFF_CD")==null?"":(String) mrequest.getParameter("TO_OFF_CD").trim();


out.print("UDT="+UDT);
	if(UDT.equals("I")){
	
qryUpdate.append("INSERT INTO SAFAL.SUSPENSE_HO_MAST  ");		      
qryUpdate.append("( TO_OFF_CD,USER_TYPE,");
qryUpdate.append("SUB_MODE,");
qryUpdate.append("ACT_YN,");
qryUpdate.append("UPDT_TIMESTAMP,");
qryUpdate.append("COUNTFOIL_UP,");
qryUpdate.append("OFF_CD,");
qryUpdate.append("ACC_FROM,");
qryUpdate.append("ACC_TO,");
qryUpdate.append("IFSC_CODE,");
qryUpdate.append("PAYMENT_MODE,");
qryUpdate.append("TOT_AMT,");
qryUpdate.append("TRANS_DATE,");
qryUpdate.append("UTRN_NO,");
qryUpdate.append("DOC_UP1,");
qryUpdate.append("DOC_UP2,");
qryUpdate.append("REMARK,");
qryUpdate.append("IFMS_CODE1,");
qryUpdate.append("NARRATION1,");
qryUpdate.append("ACC_HEAD1,");
qryUpdate.append("AMT1,");
qryUpdate.append("BEN_CD1,");
qryUpdate.append("IFMS_CODE2,");
qryUpdate.append("NARRATION2,");
qryUpdate.append("ACC_HEAD2,");
qryUpdate.append("AMT2,");
qryUpdate.append("BEN_CD2,");
qryUpdate.append("IFMS_CODE3,");
qryUpdate.append("NARRATION3,");
qryUpdate.append("ACC_HEAD3,");
qryUpdate.append("AMT3,");
qryUpdate.append("BEN_CD3,");
qryUpdate.append("IFMS_CODE4,");
qryUpdate.append("NARRATION4,");
qryUpdate.append("ACC_HEAD4,");
qryUpdate.append("AMT4,");
qryUpdate.append("BEN_CD4,");
qryUpdate.append("IFMS_CODE5,");
qryUpdate.append("NARRATION5,");
qryUpdate.append("ACC_HEAD5,");
qryUpdate.append("AMT5,");
qryUpdate.append("BEN_CD5,");
qryUpdate.append("IFMS_CODE6,");
qryUpdate.append("NARRATION6,");
qryUpdate.append("ACC_HEAD6,");
qryUpdate.append("AMT6,");
qryUpdate.append("BEN_CD6,");
qryUpdate.append("IFMS_CODE7,");
qryUpdate.append("NARRATION7,");
qryUpdate.append("ACC_HEAD7,");
qryUpdate.append("AMT7,");
qryUpdate.append("BEN_CD7,");
qryUpdate.append("IFMS_CODE8,");
qryUpdate.append("NARRATION8,");
qryUpdate.append("ACC_HEAD8,");
qryUpdate.append("AMT8,");
qryUpdate.append("BEN_CD8,");
qryUpdate.append("IFMS_CODE9,");
qryUpdate.append("NARRATION9,");
qryUpdate.append("ACC_HEAD9,");
qryUpdate.append("AMT9,");
qryUpdate.append("BEN_CD9,");
qryUpdate.append("IFMS_CODE10,");
qryUpdate.append("NARRATION10,");
qryUpdate.append("ACC_HEAD10,");
qryUpdate.append("AMT10,");
qryUpdate.append("BEN_CD10,SUSMID");
qryUpdate.append("  ) VALUES (?, ?,'D','Y',SYSDATE, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,? ) ");

}else{

//values.add(SUB_MODE); pstm.add ("L");
//values.add(ACT_YN); pstm.add ("L");
//values.add(UPDT_TIMESTAMP); pstm.add ("L");
qryUpdate.append(" UPDATE SAFAL.SUSPENSE_HO_MAST SET TO_OFF_CD=?,USER_TYPE=?,");
qryUpdate.append("SUB_MODE='D',");
qryUpdate.append("ACT_YN='Y',");


qryUpdate.append("UPDT_TIMESTAMP=SYSDATE,");

qryUpdate.append("COUNTFOIL_UP=?,");
qryUpdate.append("OFF_CD=?,");
qryUpdate.append("ACC_FROM=?,");
qryUpdate.append("ACC_TO=?,");
qryUpdate.append("IFSC_CODE=?,");
qryUpdate.append("PAYMENT_MODE=?,");
qryUpdate.append("TOT_AMT=?,");
qryUpdate.append("TRANS_DATE=?,");
qryUpdate.append("UTRN_NO=?,");
qryUpdate.append("DOC_UP1=?,");
qryUpdate.append("DOC_UP2=?,");
qryUpdate.append("REMARK=?,");
qryUpdate.append("IFMS_CODE1=?,");
qryUpdate.append("NARRATION1=?,");
qryUpdate.append("ACC_HEAD1=?,");
qryUpdate.append("AMT1=?,");
qryUpdate.append("BEN_CD1=?,");
qryUpdate.append("IFMS_CODE2=?,");
qryUpdate.append("NARRATION2=?,");
qryUpdate.append("ACC_HEAD2=?,");
qryUpdate.append("AMT2=?,");
qryUpdate.append("BEN_CD2=?,");
qryUpdate.append("IFMS_CODE3=?,");
qryUpdate.append("NARRATION3=?,");
qryUpdate.append("ACC_HEAD3=?,");
qryUpdate.append("AMT3=?,");
qryUpdate.append("BEN_CD3=?,");
qryUpdate.append("IFMS_CODE4=?,");
qryUpdate.append("NARRATION4=?,");
qryUpdate.append("ACC_HEAD4=?,");
qryUpdate.append("AMT4=?,");
qryUpdate.append("BEN_CD4=?,");
qryUpdate.append("IFMS_CODE5=?,");
qryUpdate.append("NARRATION5=?,");
qryUpdate.append("ACC_HEAD5=?,");
qryUpdate.append("AMT5=?,");
qryUpdate.append("BEN_CD5=?,");
qryUpdate.append("IFMS_CODE6=?,");
qryUpdate.append("NARRATION6=?,");
qryUpdate.append("ACC_HEAD6=?,");
qryUpdate.append("AMT6=?,");
qryUpdate.append("BEN_CD6=?,");
qryUpdate.append("IFMS_CODE7=?,");
qryUpdate.append("NARRATION7=?,");
qryUpdate.append("ACC_HEAD7=?,");
qryUpdate.append("AMT7=?,");
qryUpdate.append("BEN_CD7=?,");
qryUpdate.append("IFMS_CODE8=?,");
qryUpdate.append("NARRATION8=?,");
qryUpdate.append("ACC_HEAD8=?,");
qryUpdate.append("AMT8=?,");
qryUpdate.append("BEN_CD8=?,");
qryUpdate.append("IFMS_CODE9=?,");
qryUpdate.append("NARRATION9=?,");
qryUpdate.append("ACC_HEAD9=?,");
qryUpdate.append("AMT9=?,");
qryUpdate.append("BEN_CD9=?,");
qryUpdate.append("IFMS_CODE10=?,");
qryUpdate.append("NARRATION10=?,");
qryUpdate.append("ACC_HEAD10=?,");
qryUpdate.append("AMT10=?,");
qryUpdate.append("BEN_CD10=? WHERE SUSMID=?");


}

//TO_OFF_CD  67
values.add(TO_OFF_CD); pstm.add ("L");
values.add(USER_TYPE); pstm.add ("L");
//values.add(SUB_MODE); pstm.add ("L");
//values.add(ACT_YN); pstm.add ("L");
//values.add(UPDT_TIMESTAMP); pstm.add ("L");
values.add(frenNm); pstm.add ("L");
values.add(OFF_CD); pstm.add ("L");
values.add(ACC_FROM); pstm.add ("L");
values.add(ACC_TO); pstm.add ("L");
values.add(IFSC_CODE); pstm.add ("L");
values.add(PAYMENT_MODE); pstm.add ("L");
values.add(TOT_AMT); pstm.add ("L");
values.add(TRANS_DATE); pstm.add ("L");
values.add(UTRN_NO); pstm.add ("L");
values.add(DOC_UP1); pstm.add ("L");
values.add(DOC_UP2); pstm.add ("L");
values.add(REMARK); pstm.add ("L");


values.add(IFMS_CODE1); pstm.add ("L");
values.add(NARRATION1); pstm.add ("L");
values.add(ACC_HEAD1); pstm.add ("L");
values.add(AMT1); pstm.add ("L");
values.add(BEN_CD1); pstm.add ("L");
values.add(IFMS_CODE2); pstm.add ("L");
values.add(NARRATION2); pstm.add ("L");
values.add(ACC_HEAD2); pstm.add ("L");
values.add(AMT2); pstm.add ("L");
values.add(BEN_CD2); pstm.add ("L");
values.add(IFMS_CODE3); pstm.add ("L");
values.add(NARRATION3); pstm.add ("L");
values.add(ACC_HEAD3); pstm.add ("L");
values.add(AMT3); pstm.add ("L");
values.add(BEN_CD3); pstm.add ("L");
values.add(IFMS_CODE4); pstm.add ("L");
values.add(NARRATION4); pstm.add ("L");
values.add(ACC_HEAD4); pstm.add ("L");
values.add(AMT4); pstm.add ("L");
values.add(BEN_CD4); pstm.add ("L");
values.add(IFMS_CODE5); pstm.add ("L");
values.add(NARRATION5); pstm.add ("L");
values.add(ACC_HEAD5); pstm.add ("L");
values.add(AMT5); pstm.add ("L");
values.add(BEN_CD5); pstm.add ("L");
values.add(IFMS_CODE6); pstm.add ("L");
values.add(NARRATION6); pstm.add ("L");
values.add(ACC_HEAD6); pstm.add ("L");
values.add(AMT6); pstm.add ("L");
values.add(BEN_CD6); pstm.add ("L");
values.add(IFMS_CODE7); pstm.add ("L");
values.add(NARRATION7); pstm.add ("L");
values.add(ACC_HEAD7); pstm.add ("L");
values.add(AMT7); pstm.add ("L");
values.add(BEN_CD7); pstm.add ("L");
values.add(IFMS_CODE8); pstm.add ("L");
values.add(NARRATION8); pstm.add ("L");
values.add(ACC_HEAD8); pstm.add ("L");
values.add(AMT8); pstm.add ("L");
values.add(BEN_CD8); pstm.add ("L");
values.add(IFMS_CODE9); pstm.add ("L");
values.add(NARRATION9); pstm.add ("L");
values.add(ACC_HEAD9); pstm.add ("L");
values.add(AMT9); pstm.add ("L");
values.add(BEN_CD9); pstm.add ("L");
values.add(IFMS_CODE10); pstm.add ("L");
values.add(NARRATION10); pstm.add ("L");
values.add(ACC_HEAD10); pstm.add ("L");
values.add(AMT10); pstm.add ("L");
values.add(BEN_CD10); pstm.add ("L");
values.add(SUSMID); pstm.add ("L");


					
try{

out.print(qryUpdate.toString());
db.setSqlValue(qryUpdate.toString());
db.setValues(values,pstm);
db.executeUpdate() ;
values.clear();

}catch(Exception e){

out.print(e.toString());
}
	db.close();
session.setAttribute("SIFMS_YN",IFMS_YN);
response.sendRedirect("SUSPENSE_ENTRY.jsp?SUSMID="+SUSMID);
	
//try {
//out.print(qryUpdate.toString());
				
//}catch(Exception e) {}
		
					
					

						}    //if 4
						}    //if 3
					
		
		
		}//end ins		
		
		
		}catch (Exception m) {     // try
err=m.toString();
		err=err.substring(33,err.length());
		
		}		

 %>
 <table width="100%"  align="center" >
    <tr>
      <th  colspan="4"><div align="center">
        <SPAN class="style2">Form For Providing Details Of Remittance / Refunds Send to Central Office  </SPAN> </div></th>
    </tr>

    <tr>
      <td  colspan="2">Transcation ID:
     <input type="text" name="SUSMID" id="SUSMID" value="<%= SUSMID %>" readonly=""></td>
      <td colspan="2">Office Name :<%= OFF_NAME %></td>
    </tr>
  
    <tr>
      <th  colspan="2"><div align="center">State / Divisional Office Remitter Account </div></th>
      <th colspan="2"><div align="center">Remitted To Central 
        
      Office Account </div></th>
    </tr>
    
    <tr>
      <th > IFSC code : </th>
      <td ><input name="IFSC_CODE" type="text" id="IFSC_CODE" readonly="true" value="<%= IFSC_CODE %>"/>
      <input name="btnBank2" type="button" class="buttongrey" id="btnBank2" onClick="ShowNewPage2();"  value="Select  Bank IFS Code" /></td>
      <th > IFSC code :</th>
      <td >
	  
	  
	  <input name="IFSC_CODE_TO" type="text" id="IFSC_CODE_TO" readonly="true" value="SBIN0000515"/></td>
    </tr>
    <tr>
      <th> Remitter's A/C No. :</th>
      <td><div class="tooltip">
          <input name="ACC_FROM" type="text" id="ACC_FROM" size="20" maxlength="20" value="<%= ACC_FROM %>"/>
          <span class="tooltiptext"> Enter Correct Remitter Account No.</span></div></td>
      <th>Remitted to A/C No.:</th>
      <td><div class="tooltip">
          <input name="ACC_TO" type="text" id="ACC_TO" size="20" maxlength="20" onBlur="myFunction();" value="<%= ACC_TO %>" />
          <span class="tooltiptext"> Enter Correct Remitter Account No.</span> </div></td>
    </tr>

    <tr>
      <th>&nbsp;</th>
      <td>&nbsp;</td>
      <th>Refund Pertaining to Dte. of : </th>
      <td><select name="TO_OFF_CD" id="TO_OFF_CD"  class="buttongrey">
        <option value="">--SELECT--</option>
        <%
ResultSet rso = db.execSQL("SELECT OFF_CD,OFF_NAME FROM MAS.OFF_MAST WHERE OFF_TYPE_CD=30  AND ECOM_ACT_YN ='Y' ");
   	

	   while(rso.next()){ 
	   %>
        <option value="<%= rso.getString(1) %>"  <%if(TO_OFF_CD.equals(rso.getString(1))){out.print("selected=\"selected\"");}%>  ><%= rso.getString(2) %></option>
        <% } 
	  rso.close();
	   %>
      </select></td>
    </tr>
  </table>
  <table border="1" cellspacing="3" cellpadding="3" align="center" width="100%" >
    
    <tr>
      <td colspan="6" bgcolor="#FFFFCC"  > <div align="center">Payment Related Details</div></td>
    </tr>
    <tr>
      <th  ><div align="left">Date of remittance: </div></th>
      <td  >
	   <div class="tooltip">   <input name="TRANS_DATE" type="text" id="TRANS_DATE"  onClick="javascript:NewCssCal('TRANS_DATE','ddMMMyyyy')" readonly="true" value="<%= TRANS_DATE %>" />  <span class="tooltiptext">
Click Here To Select Date on which Amount is remitted</span></div>	 </td>
      <th  >Mode of Refund: </th>
      <td  ><select name="PAYMENT_MODE" id="PAYMENT_MODE"  class="buttongrey">
        <option value="">SELECT</option>
        <option value="NEFT" <%if(PAYMENT_MODE.equals("NEFT")){out.print("selected=\"selected\"");}%> >NFFT</option>
        <option value="RTGS"  <%if(PAYMENT_MODE.equals("RTGS")){out.print("selected=\"selected\"");}%> >RTGS</option>
        <option value="CASH" <%if(PAYMENT_MODE.equals("CASH")){out.print("selected=\"selected\"");}%> >CASH</option>
        <option value="CHEQ"  <%if(PAYMENT_MODE.equals("CHEQ")){out.print("selected=\"selected\"");}%> >CHEQUE</option>
		   <option value="DD"  <%if(PAYMENT_MODE.equals("DD")){out.print("selected=\"selected\"");}%> >DD</option>
      
      </select></td>
      <th  >Whether Entered in IFMS  : </th>
      <td  ><select name="IFMS_YN" id="IFMS_YN"  class="buttongrey" onChange="FUN_IFMS_YN();">
        <option value="">SELECT</option>
        <option value="YES" <%if(IFMS_YN.equals("YES")){out.print("selected=\"selected\"");}%> >YES</option>
        <option value="NO"  <%if(IFMS_YN.equals("NO")){out.print("selected=\"selected\"");}%> >NO</option>
      
      </select></td>
    </tr>
    
    <tr>
      <th ><div align="left">UTRN No : </div></th>
      <td >
	  
	   <div class="tooltip"> <input name="UTRN_NO" type="text" id="UTRN_NO" size="30" maxlength="30" value="<%= UTRN_NO %>"/><span class="tooltiptext">
Enter UTRN No.</span></div>	  </td>
      <th >Upload Counterfoil of Remittance :</th>
      <td colspan="3" rowspan="2" > 
	  <p class="s">
       <div class="tooltip">   <input name="uploadfile" type="file" class="buttongrey" id="uploadfile" /><span class="tooltiptext">
click here to Upload Countfoil</span></div>  </p>
          <% if(UDT.equals("U")){ %>
          <input name="BUTTON" type="button" class="buttonOrange" id="BUTTON" onClick="ViewDoc('<%= COUNTFOIL_UP %>');" value="View Doc" />
         
         
          <%}%>
     (Max Size 100 kb - jpg, jpeg, pdf)
               </td>
    </tr>
    <tr>
      <th colspan="3" ><span class="info" >Amount In Words : <span id="word"></span></span>&nbsp;	  </th>
    </tr>
    

  </table>
  
  
  
   <% if(!err.equals("")){ %>
		   
		<CENTER> <DIV  class="error"  style="width:80%;height:20px"><%= err %></DIV>

  <% } %>
  <table  align="center" width="100%" cellpadding="3" cellspacing="3" >
    
       <tr>
      <th colspan="6"  ><span  class="info" style="float:left"> Total Amount : <span id="tot_amt"></span></span> <div align="center" class="style1 style2"> REMITTANCE / REFUND DETAILS</div></th>
    </tr>
    <tr>
      <th  ><div align="center">SR.No</div></th>
      <th  ><div align="center">A/c Head </div></th>
      <th  ><div align="center">Amount</div></th>
      <th ><div align="center">Institution / Departmental  / Trading Units </div></th>
      <th  ><div align="center">IFMS Document No</div></th>
      <th ><div align="center">Narration</div></th>
    </tr>
    <tr>
      <td ><div align="center">1</div></td>
      <td ><span id="DACC_HEAD1"></span>
        <div align="center" >
		
		
		<input name="ACC_HEAD1" type="hidden" id="ACC_HEAD1" readonly="true" value="<%= ACC_HEAD1 %>"/>
		<input name="ACC_NAME1" type="text" id="ACC_NAME1" size="30"  readonly="true" value="<%= ACC_NAME1 %>"/>
		 <input name="btnBank2" type="button" class="buttongrey" id="btnBank2" onClick="ShowNewPage3('ACC_HEAD1','ACC_NAME1');"  value="Select" />

        </div></td>
      <td><div align="center">
        <input name="AMT1" type="text" id="AMT1" size="12" value="<%= AMT1 %>" maxlength="18" onKeyUp="word.innerHTML=convertNumberToWords(this.value);addTotAmt();" onFocus="word.innerHTML=convertNumberToWords(this.value);addTotAmt();"/>
        </div></td>
      <td><div align="center">
  
	
		     
		<input name="Text" type="text" id="Text1"  style="width: 250px; font-size:1.0em;"  placeholder="Search here by Institution Name" onFocus="showProductList1();"/>
    <input name="BEN_CD1" type="hidden" id="BEN_CD1"   value="">
		
      </div></td>
      <td><div align="center">
        <input type="text"name="IFMS_CODE1" id="IFMS_CODE1" value="<%= IFMS_CODE1 %>" size="20"/>
        </div></td>
      <td><div align="center">
        
		  <textarea name="NARRATION1" cols="30" rows="2" id="NARRATION1"><%= NARRATION1 %></textarea>
		  
      </div></td>
    </tr>
    <tr>
      <td ><div align="center">2</div></td>
      <td >
        <div align="center">
         		<input name="ACC_HEAD2" type="hidden" id="ACC_HEAD2" readonly="true" value="<%= ACC_HEAD2 %>"/>
		<input name="ACC_NAME2" type="text" id="ACC_NAME2" size="30"  readonly="true" value="<%= ACC_NAME2 %>"/>
		 <input name="btnBank2" type="button" class="buttongrey" id="btnBank2" onClick="ShowNewPage3('ACC_HEAD2','ACC_NAME2');"  value="Select" />

      </div></td>
      <td><div align="center">
        <input name="AMT2" type="text" id="AMT2" value="<%= AMT2 %>" size="12" maxlength="18"  onkeyup="word.innerHTML=convertNumberToWords(this.value);addTotAmt();" onFocus="word.innerHTML=convertNumberToWords(this.value);addTotAmt();"/>        
      </div></td>
      <td><div align="center">
    		<input name="Text" type="text" id="Text2"  style="width: 250px; font-size:1.0em;"  placeholder="Search here by Institution Name" onFocus="showProductList2();"/>
    <input name="BEN_CD2" type="hidden" id="BEN_CD2"   value="">
		
      </div></td>
      <td><div align="center">
        <input type="text"name="IFMS_CODE2" id="IFMS_CODE2" value="<%= IFMS_CODE2 %>" size="20"/>
        </div></td>
      <td><div align="center">
        <textarea name="NARRATION2" cols="30" rows="2" id="NARRATION2"><%= NARRATION2 %></textarea>
      </div></td>
    </tr>
    <tr>
      <td ><div align="center">3</div></td>
      <td >
         <div align="center">
                   		<input name="ACC_HEAD3" type="hidden" id="ACC_HEAD3" readonly="true" value="<%= ACC_HEAD3 %>"/>
		<input name="ACC_NAME3" type="text" id="ACC_NAME3" size="30"  readonly="true" value="<%= ACC_NAME3 %>"/>
		 <input name="btnBank2" type="button" class="buttongrey" id="btnBank2" onClick="ShowNewPage3('ACC_HEAD3','ACC_NAME3');"  value="Select" />
      </div></td>
      <td><div align="center">
        <input name="AMT3" type="text" id="AMT3" value="<%= AMT3 %>" size="12" maxlength="18"  onkeyup="word.innerHTML=convertNumberToWords(this.value);addTotAmt();" onFocus="word.innerHTML=convertNumberToWords(this.value);addTotAmt();"/>        
      </div></td>
      <td><div align="center">
   <input name="Text" type="text" id="Text3"  style="width: 250px; font-size:1.0em;"  placeholder="Search here by Institution Name" onFocus="showProductList3();"/>
    <input name="BEN_CD3" type="hidden" id="BEN_CD3"   value="">
		
		
        </div></td>
      <td><div align="center">
        <input type="text"name="IFMS_CODE3" id="IFMS_CODE3" value="<%= IFMS_CODE3 %>" size="20" />
        </div></td>
      <td><div align="center">
        <textarea name="NARRATION3" cols="30" rows="2" id="NARRATION3"><%= NARRATION3 %></textarea>
      </div></td>
    </tr>
    <tr>
      <td ><div align="center">4</div></td>
      <td >
        <div align="center">
          
		 <input name="ACC_HEAD4" type="hidden" id="ACC_HEAD4" readonly="true" value="<%= ACC_HEAD4 %>"/>
		<input name="ACC_NAME4" type="text" id="ACC_NAME4" value="<%= ACC_NAME4 %>" size="30" readonly="true"/>
		 <input name="btnBank2" type="button" class="buttongrey" id="btnBank2" onClick="ShowNewPage3('ACC_HEAD4','ACC_NAME4');"  value="Select" />
		  
		  
      </div></td>
      <td><div align="center">
          <input type="text" name="AMT4" id="AMT4" size="12" value="<%= AMT4 %>" maxlength="18"  onkeyup="word.innerHTML=convertNumberToWords(this.value);addTotAmt();" onFocus="word.innerHTML=convertNumberToWords(this.value);addTotAmt();"/>        
      </div></td>
      <td><div align="center">
       
	   <input name="Text" type="text" id="Text4"  style="width: 250px; font-size:1.0em;"  placeholder="Search here by Institution Name" onFocus="showProductList4();"/>
    <input name="BEN_CD4" type="hidden" id="BEN_CD4"   value="">
		

        </div></td>
      <td><div align="center">
        <input type="text"name="IFMS_CODE4" id="IFMS_CODE4" value="<%= IFMS_CODE4 %>" size="20"/>
        </div></td>
      <td><div align="center">
        <textarea name="NARRATION4" cols="30" rows="2" id="NARRATION4"><%= NARRATION4 %></textarea>
      </div></td>
    </tr>
    <tr>
      <td ><div align="center">5</div></td>
      <td >
        <div align="center">
          		 <input name="ACC_HEAD5" type="hidden" id="ACC_HEAD5" readonly="true" value="<%= ACC_HEAD5 %>"/>
		<input name="ACC_NAME5" type="text" id="ACC_NAME5" value="<%= ACC_NAME5 %>" size="30" readonly="true"/>
		 <input name="btnBank2" type="button" class="buttongrey" id="btnBank2" onClick="ShowNewPage3('ACC_HEAD5','ACC_NAME5');"  value="Select" />

      </div></td>
      <td><div align="center">
          <input type="text"name="AMT5" id="AMT5" size="12" value="<%= AMT5 %>" maxlength="18"  onkeyup="word.innerHTML=convertNumberToWords(this.value);addTotAmt();" onFocus="word.innerHTML=convertNumberToWords(this.value);addTotAmt();"/>        
      </div></td>
      <td><div align="center">
     
		       
	   <input name="Text" type="text" id="Text5"  style="width: 250px; font-size:1.0em;"  placeholder="Search here by Institution Name" onFocus="showProductList5();"/>
    <input name="BEN_CD5" type="hidden" id="BEN_CD5"   value="">
		

		
        </div></td>
      <td><div align="center">
        <input type="text"name="IFMS_CODE5" id="IFMS_CODE5" value="<%= IFMS_CODE5 %>" size="20"/>
      </div></td>
      <td><div align="center">
        <textarea name="NARRATION5" cols="30" rows="2" id="NARRATION5"><%= NARRATION5 %></textarea>
      </div></td>
    </tr>
    <tr>
      <td ><div align="center">6</div></td>
      <td >
        <div align="center">
       <input name="ACC_HEAD6" type="hidden" id="ACC_HEAD6" readonly="true" value="<%= ACC_HEAD6 %>"/>
		<input name="ACC_NAME6" type="text" id="ACC_NAME6" value="<%= ACC_NAME6 %>" size="30" readonly="true"/>
		 <input name="btnBank2" type="button" class="buttongrey" id="btnBank2" onClick="ShowNewPage3('ACC_HEAD6','ACC_NAME6');"  value="Select" />

      </div></td>
      <td><div align="center">
          <input type="text" name="AMT6" id="AMT6" size="12" maxlength="18" value="<%= AMT6 %>"  onkeyup="word.innerHTML=convertNumberToWords(this.value);addTotAmt();" onFocus="word.innerHTML=convertNumberToWords(this.value);addTotAmt();"/>        
      </div></td>
      <td><div align="center">

		     
		       
	   <input name="Text" type="text" id="Text6"  style="width: 250px; font-size:1.0em;"  placeholder="Search here by Institution Name" onFocus="showProductList6();"/>
    <input name="BEN_CD6" type="hidden" id="BEN_CD6"   value="">
		

		


        </div></td>
      <td><div align="center">
        <input type="text"name="IFMS_CODE6" id="IFMS_CODE6" value="<%= IFMS_CODE6 %>" size="20"/>
        </div></td>
      <td><div align="center">
        <textarea name="NARRATION6" cols="30" rows="2" id="NARRATION6"><%= NARRATION6 %></textarea>
      </div></td>
    </tr>
    <tr>
      <td ><div align="center">7</div></td>
      <td >
        <div align="center">
		
  <input name="ACC_HEAD7" type="hidden" id="ACC_HEAD7" readonly="true" value="<%= ACC_HEAD7 %>"/>
		<input name="ACC_NAME7" type="text" id="ACC_NAME7" value="<%= ACC_NAME7 %>" size="30" readonly="true"/>
		 <input name="btnBank2" type="button" class="buttongrey" id="btnBank2" onClick="ShowNewPage3('ACC_HEAD7','ACC_NAME7');"  value="Select" />
		 
      </div></td>
      <td><div align="center">
          <input type="text" name="AMT7" id="AMT7" size="12" value="<%= AMT7 %>" maxlength="18"  onkeyup="word.innerHTML=convertNumberToWords(this.value);addTotAmt();" onFocus="word.innerHTML=convertNumberToWords(this.value);addTotAmt();"/>        
      </div></td>
      <td><div align="center">
 
				     
		       
	   <input name="Text" type="text" id="Text7"  style="width: 250px; font-size:1.0em;"  placeholder="Search here by Institution Name" onFocus="showProductList7();"/>
    <input name="BEN_CD7" type="hidden" id="BEN_CD7"   value="">
		



        </div></td>
      <td><div align="center">
        <input type="text"name="IFMS_CODE7" id="IFMS_CODE7" value="<%= IFMS_CODE7 %>" size="20"/>
        </div></td>
      <td><div align="center">
        <textarea name="NARRATION7" cols="30" rows="2" id="NARRATION7"><%= NARRATION7 %></textarea>
      </div></td>
    </tr>
    <tr>
      <td ><div align="center">8</div></td>
      <td >
        <div align="center">
          <input name="ACC_HEAD8" type="hidden" id="ACC_HEAD8" readonly="true" value="<%= ACC_HEAD8 %>"/>
		<input name="ACC_NAME8" type="text" id="ACC_NAME8" value="<%= ACC_NAME8 %>" size="30" readonly="true"/>
		 <input name="btnBank2" type="button" class="buttongrey" id="btnBank2" onClick="ShowNewPage3('ACC_HEAD8','ACC_NAME8');"  value="Select" />
      </div></td>
      <td><div align="center">
          <input type="text"name="AMT8" id="AMT8" value="<%= AMT8 %>" size="12" maxlength="18"  onkeyup="word.innerHTML=convertNumberToWords(this.value);addTotAmt();" onFocus="word.innerHTML=convertNumberToWords(this.value);addTotAmt();"/>        
      </div></td>
      <td><div align="center">
		       
	   <input name="Text" type="text" id="Text8"  style="width: 250px; font-size:1.0em;"  placeholder="Search here by Institution Name" onFocus="showProductList8();"/>
    <input name="BEN_CD8" type="hidden" id="BEN_CD8"   value="">
		

        </div></td>
      <td><div align="center">
        <input type="text"name="IFMS_CODE8" id="IFMS_CODE8" value="<%= IFMS_CODE8 %>" size="20"/>
        </div></td>
      <td><div align="center">
        <textarea name="NARRATION8" cols="30" rows="2" id="NARRATION8"><%= NARRATION8 %></textarea>
      </div></td>
    </tr>
    <tr>
      <td ><div align="center">9</div></td>
      <td >
        <div align="center">
         <input name="ACC_HEAD9" type="hidden" id="ACC_HEAD9" readonly="true" value="<%= ACC_HEAD9 %>"/>
		<input name="ACC_NAME9" type="text" id="ACC_NAME9" value="<%= ACC_NAME9 %>" size="30" readonly="true"/>
		 <input name="btnBank2" type="button" class="buttongrey" id="btnBank2" onClick="ShowNewPage3('ACC_HEAD9','ACC_NAME9');"  value="Select" />
      </div></td>
      <td><div align="center">
          <input type="text"name="AMT9" id="AMT9" size="12" maxlength="18" value="<%= AMT9 %>"		   onkeyup="word.innerHTML=convertNumberToWords(this.value);addTotAmt();" onFocus="word.innerHTML=convertNumberToWords(this.value);addTotAmt();"/>        
      </div></td>
      <td><div align="center">
		       
	   <input name="Text" type="text" id="Text9"  style="width: 250px; font-size:1.0em;"  placeholder="Search here by Institution Name" onFocus="showProductList9();"/>
    <input name="BEN_CD9" type="hidden" id="BEN_CD9"   value="">
		


		
        </div></td>
      <td><div align="center">
        <input type="text"name="IFMS_CODE9" id="IFMS_CODE9" value="<%= IFMS_CODE9 %>" size="20"/>
        </div></td>
      <td><div align="center">
        <textarea name="NARRATION9" cols="30" rows="2" id="NARRATION9"><%= NARRATION9 %></textarea>
      </div></td>
    </tr>
    <tr>
      <td ><div align="center">10</div></td>
      <td ><div align="center">
                 <input name="ACC_HEAD10" type="hidden" id="ACC_HEAD10" readonly="true" value="<%= ACC_HEAD10 %>"/>
		<input name="ACC_NAME10" type="text" id="ACC_NAME10" value="<%= ACC_NAME10 %>" size="30" readonly="true"/>
		 <input name="btnBank2" type="button" class="buttongrey" id="btnBank2" onClick="ShowNewPage3('ACC_HEAD10','ACC_NAME10');"  value="Select" />
      </div></td>
      <td><div align="center">
          <input type="text"name="AMT10" id="AMT10" size="12" maxlength="18" value="<%= AMT10 %>" onKeyUp="word.innerHTML=convertNumberToWords(this.value);addTotAmt();" onFocus="word.innerHTML=convertNumberToWords(this.value);addTotAmt();"/>
      </div></td>
      <td><div align="center">
     		       
	   <input name="Text" type="text" id="Text10"  style="width: 250px; font-size:1.0em;"  placeholder="Search here by Institution Name" onFocus="showProductList10();"/>
    <input name="BEN_CD10" type="hidden" id="BEN_CD10"   value="">
		

      </div></td>
      <td><div align="center">
          <input name="IFMS_CODE10" type="text" id="IFMS_CODE10" value="<%= IFMS_CODE10 %>" size="20" /> 
          </div></td>
      <td><div align="center">
          <textarea name="NARRATION10" cols="30" rows="2" id="NARRATION10"><%= NARRATION10 %></textarea>
      </div></td>
    </tr>
    <tr>
      <td colspan="6" align="center" > <div align="center">
        <input name="BtnSave" type="button" class="buttongrey" id="BtnSave" onClick="submitform();" value="Save">
        
           <A href="REMITTANCE_VIEW.jsp" class="buttongrey">BACK</A></div></td>
    </tr>
  </table>

  
      
   

    
  </div>
</form>
</body>

<script language="javascript">
 var modalWin = new CreateModalPopUpObject();
 modalWin.SetLoadingImagePath("images/loading.gif");
 modalWin.SetCloseButtonImagePath("images/remove.gif");
 //Uncomment below line to make look buttons as link
 //modalWin.SetButtonStyle("background:none;border:none;textDecoration:underline;cursor:pointer");

   function ViewDoc(COUNTFOIL_UP){
var callbackFunctionArray = new Array(refreshpage);
 modalWin.ShowURL("sendredCountFoil.jsp?COUNTFOIL_UP="+COUNTFOIL_UP,800,1000,'Remittance',callbackFunctionArray,null);
 }//end of bank
 

 
function refreshpage() {
   form.submit(); 
}


 
 function ShowNewPage2(){

var urlpar='RBIBANKLOV2.jsp';
 var callbackFunctionArray = new Array(EnrollNow, EnrollLater);
 modalWin.ShowURL(urlpar,600,1000,'Find Bank Details',null,callbackFunctionArray);
 
 }//END OF FUNCTION
 
 function getBankLOV2(IFSC){
 form.IFSC_CODE.value=IFSC;
}
 
 
  function ShowNewPage3(HEAD,HNAME){

var urlpar='ACCHEAD_LOV2.jsp?HEAD='+HEAD+'&HNAME='+HNAME;
 var callbackFunctionArray = new Array(EnrollNow, EnrollLater);
 modalWin.ShowURL(urlpar,780,1200,'Find Account Head',null,callbackFunctionArray);
 
 }//END OF FUNCTION
 
 function getAccLOV2(VNAME,VHEAD,ACC_HEAD,ACC_NAME){
 
 if(VHEAD=="ACC_HEAD1"){
 form.ACC_HEAD1.value=ACC_HEAD;
 form.ACC_NAME1.value=ACC_NAME;
 }else if(VHEAD=="ACC_HEAD2"){
  form.ACC_HEAD2.value=ACC_HEAD;
 form.ACC_NAME2.value=ACC_NAME;
  }else if(VHEAD=="ACC_HEAD3"){
  form.ACC_HEAD3.value=ACC_HEAD;
 form.ACC_NAME3.value=ACC_NAME;
  }else if(VHEAD=="ACC_HEAD4"){
  form.ACC_HEAD4.value=ACC_HEAD;
 form.ACC_NAME4.value=ACC_NAME;
  }else if(VHEAD=="ACC_HEAD5"){
  form.ACC_HEAD5.value=ACC_HEAD;
 form.ACC_NAME5.value=ACC_NAME;
  }else if(VHEAD=="ACC_HEAD6"){
  form.ACC_HEAD6.value=ACC_HEAD;
 form.ACC_NAME6.value=ACC_NAME;
  }else if(VHEAD=="ACC_HEAD7"){
  form.ACC_HEAD7.value=ACC_HEAD;
 form.ACC_NAME7.value=ACC_NAME;
  }else if(VHEAD=="ACC_HEAD8"){
  form.ACC_HEAD8.value=ACC_HEAD;
 form.ACC_NAME8.value=ACC_NAME;
  }else if(VHEAD=="ACC_HEAD9"){
  form.ACC_HEAD9.value=ACC_HEAD;
 form.ACC_NAME9.value=ACC_NAME;
  }else if(VHEAD=="ACC_HEAD10"){
  form.ACC_HEAD10.value=ACC_HEAD;
 form.ACC_NAME10.value=ACC_NAME;
 
 }
 
}
 
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

</html>
