 var xmlhttpObject = null;
 
//Get XMLHTTP Object
function getXMLHTTPObject() {
        var xmlhttpObject = null;
        try {
                // For Old Microsoft Browsers
                xmlhttpObject = new ActiveXObject("Msxml2.XMLHTTP");
        } catch (e) {
                try {
                        // For Microsoft IE 6.0+
                        xmlhttpObject = new ActiveXObject("Microsoft.XMLHTTP");
                } catch (e1) {
                        // No Browser accepts the XMLHTTP Object then false
                        xmlhttpObject = false;
                }
        }
        if (!xmlhttpObject && typeof XMLHttpRequest != 'undefined') {
                // For Mozilla, Opera Browsers
                xmlhttpObject = new XMLHttpRequest();
        }
        // Mandatory Statement returning the ajax object created
        return xmlhttpObject;
}

// Change the value of the outputText field


function handleServerResponse(disDiv) {
        if (xmlhttpObject.readyState == 4) {
                if (xmlhttpObject.status == 200) {
                        document.getElementById("test").innerHTML = xmlhttpObject.responseText;
                } else {
                        alert("Error during AJAX call. Please try again");
                }
        }
}

// Implement business logic
function doAjaxCall(URL,txtboxName,disDiv) {
	
	
        xmlhttpObject = getXMLHTTPObject();
        if (xmlhttpObject != null) {
			
		//var param=	txtboxName;
              //  var URLN = URL+ "?APP_ID="+ document.getElementById("APP_ID").value+"&MOB_NO1="+ document.getElementById("MOB_NO1").value;
                xmlhttpObject.open("GET", URL+txtboxName, true);
                xmlhttpObject.send(null);
                xmlhttpObject.onreadystatechange = handleServerResponse(disDiv);
        }
}


/*
function  urlParam(txtboxName) {
   var dataArray = [];
   //Getting the data from all elements in the form
   for (var i = 0; i < 2; i++) {
     var encodedData = encodeURIComponent(document.getElementById("+txtboxName+").name);
     encodedData += "=";
     encodedData += encodeURIComponent(document.getElementById("+txtboxName+").value);
     dataArray.push(ProM);
   }
   return dataArray.join("&#038;");
 }
 */