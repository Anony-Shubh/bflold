<%@ page session="true"  import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.SQLException"%>

<!DOCTYPE html>
<html>
  <head>
 
    <title>Reverse Geocoding</title>
    <script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
   <script>
   
  
function initMap() {
  const map = new google.maps.Map(document.getElementById("map"), {
    zoom: 8,
    center: { lat: 20.5937, lng: 78.9629 },
  });
  const geocoder = new google.maps.Geocoder();
  const infowindow = new google.maps.InfoWindow();
  //document.getElementById("submit").addEventListener("click", () => {
    geocodeLatLng(geocoder, map, infowindow);
 // });
}
   
   
   
	function geocodeLatLng(geocoder, map, infowindow) {
  const input = document.getElementById("latlng").value;
  const latlngStr = input.split(",", 2);
  const latlng = {
    lat: parseFloat(latlngStr[0]),
    lng: parseFloat(latlngStr[1]),
  };
  geocoder.geocode({ location: latlng }, (results, status) => {
    if (status === "OK") {
      if (results[0]) {
        map.setZoom(11);
        const marker = new google.maps.Marker({
          position: latlng,
          map: map,
        });
        infowindow.setContent(results[0].formatted_address);
        infowindow.open(map, marker);
      } else {
        window.alert("No results found");
      }
    } else {
      window.alert("Geocoder failed due to: " + status);
    }
  });
}

</script>
<style>
/* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
#map {
  height: 100%;
}

/* Optional: Makes the sample page fill the window. */
html,
body {
  height: 100%;
  margin: 0;
  padding: 0;
}

#floating-panel {
  position: absolute;
  top: 10px;
  left: 25%;
  z-index: 5;
  background-color: #fff;
  padding: 5px;
  border: 1px solid #999;
  text-align: center;
  font-family: "Roboto", "sans-serif";
  line-height: 30px;
  padding-left: 10px;
}

#floating-panel {
  position: absolute;
  top: 5px;
  left: 50%;
  margin-left: -180px;
  width: 350px;
  z-index: 5;
  background-color: #fff;
  padding: 5px;
  border: 1px solid #999;
}

#latlng {
  width: 225px;
}
</style>
  </head>
  <body onLoad="initMap();" > 
  
  <%
    String APP_ID=request.getParameter("APP_ID")==null?"":(String)request.getParameter("APP_ID");
	  String PMEGPGEOTAGID=request.getParameter("PMEGPGEOTAGID")==null?"":(String)request.getParameter("PMEGPGEOTAGID");
	  String LATITUDE="";
	  String LONGITUDE="";	  
	   String UNIT_NAME = "";
ResultSet  rs;
  DBCon db= new DBCon();
db.connect();
 
    StringBuffer qrysb= new StringBuffer();
	

qrysb.append("   SELECT GT.LATITUDE,GT.LONGITUDE,GT.UNIT_NAME "      );
qrysb.append(" FROM GEOTAG_TRANS GT WHERE APP_ID=? AND PMEGPGEOTAGID=?"      );


  List values=new ArrayList();
  
values.add(APP_ID);
values.add(PMEGPGEOTAGID);
  
   rs = db.executeSQL(qrysb.toString(),values);
   values.clear();
   while (rs.next()){
	
	
	LATITUDE=rs.getString("LATITUDE")==null?"":rs.getString("LATITUDE");	
	LONGITUDE=rs.getString("LONGITUDE")==null?"":rs.getString("LONGITUDE");
	UNIT_NAME=rs.getString("UNIT_NAME")==null?"":rs.getString("UNIT_NAME");
	}
  %>
   <!-- <div id="floating-panel">-->
      <input id="latlng" type="hidden" value="<%=LATITUDE%>,<%=LONGITUDE%>" />
	  
    <!-- <input id="submit" type="button" value="Reverse Geocode" />-->
   <!-- </div>-->
     <div id="map"></div>

    <!-- Async script executes immediately and must be after any DOM elements used in callback. -->
	 <script  src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBWhnwFabPgBJU0kD3rfKfDC89rRx7LF7A&callback=initMap&libraries=&v=weekly" async></script>
    
	 
  </body>
</html>