<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<!doctype html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>SMS SERVICE</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link href="css/style.css" rel="stylesheet">
    <link href="Media Query/media.css" rel="stylesheet">
    <link rel="stylesheet" href="css/font-awesome.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
</HEAD>

<BODY>
<FORM name="form1"  method="Post">
  <section class="main" id="main">
        <header class="top-banner mt-1 mb-1" style="width: 100%;" id="myDiv1">
            <div class="container-fluid">
                <img src="img/chairman_dashboard (7).jpeg" style="margin: 0; width: 100%;">
            </div>
        </header><input name="ins" type="hidden" id="ins" value="">
        <section class="ftco-section">
            <nav class="navbar navbar-expand-lg" id="ftco-navbar">
                <div class="container">
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav"
                        aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="fa fa-bars" style="color: #fff;"> MENU</span>
                    </button>
                    <div class="logout order-lg-last">

                        <a href="logout.jsp">Logout</a>

                    </div>
                    <div class="collapse navbar-collapse" id="ftco-nav">
                        <ul class="navbar-nav mr-auto" ID="ftco-ul">
                            <li class="nav-item"><a href="homepage.jsp" class="nav-link">Home</a></li>
                            <li class="nav-item"><a href="#" class="nav-link">Officer on Tour</a></li>
                            <li class="nav-item"><a href="#" class="nav-link">Officer on Leave</a></li>
							<li class="nav-item"><a href="#" class="nav-link">Change Password</a></li>
                            <li class="nav-item "><a href="SmsView.jsp" class="nav-link">SMS Service</a></li>
                        </ul>
                    </div>
                </div>
            </nav>
        </section>


<br><br><br><br>
<TABLE align="center">

  <TR > 
    <TH > <DIV align="center" class="GreenLebel">
      <H2>
        <INPUT name="ins" type="hidden" id="ins" value="">
     Detail has been successfully sent to TRAI</H2>
      <P><DIV align="center"><A href="SmsView.jsp" class="btn">
	BACK</A> </DIV></p>
    </DIV></TH>
    </TR>

   
      <TR > 
        
    <TH nowrap>
      <DIV align="center"><br><br>Designed and Developed by Directorate of Information Technology(DIT),KVIC,Mumbai    </DIV></TH>
      </TR>
</TABLE>
</FORM>
</BODY>
</HTML>

