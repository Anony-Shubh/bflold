<%@ include file="appIncludeHeaderPage.jsp" %>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.1.1.slim.min.js" integrity="sha384-A7FZj7v+d/sdmMqp/nOQwliLvUsJfDHW+k9Omg/a/EheAdgtzNs3hpfag6Ed950n" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js" integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script>
<script>
    $(document).ready(function(){
        $("#myModal").modal('show');
    });
</script>
<p></p>
<p></p>
<p></p>
<p></p>


<center>
<div align="center">
 <div align="center"> <H1>WELCOME</H1></div><BR/>
    <div align="center">  <img src="../images/pmegpetrackN.png" alt="comp" /></div>
      <BR/>
</p>
 
  <table border="10">
  <tr>
    <th><span style="font-weight: bold"> ID </span></th>
    <th><span style="font-weight: bold"><%=  vAppid %></span></th>
  </tr>
  <tr>
    <th><span style="font-weight: bold">Name</span></th>
    <th><span style="font-weight: bold"><%=  vAppName %></span></th>
  </tr>
  <tr>
    <th><span style="font-weight: bold">Type:</span></th>
    <th><span style="font-weight: bold"><%=  vBenfType %></span></th>
  </tr>
</table>


</div>
  <div class="container"> 
   <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
		 <h4 class="modal-title"><span style="color:#006633;font-family:Verdana, Arial, Helvetica, sans-serif;font-weight:900 "><p><strong>Important Notice</p></strong></span> </h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
         
        </div>
        <div class="modal-body"><p><strong><h2><span style="color:#990000;font-family:Verdana, Arial, Helvetica, sans-serif;font-weight:900 ">
		Please Verify Aadhaar No, Name, Date Of Birth , Gender and mobile No Details are as per Aadhaar Card....... ! <br/>
		
		</span></p></strong></h2>
 </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
