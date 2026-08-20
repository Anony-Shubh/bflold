    <%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Insert title here</title>
    </head>
    <body onLoad="do_totals2()">
    <script language="javascript">
    function submitForm(oForm) {
    dototals1();
    oForm.submit();
    // return true;
    }
    function do_totals1() {
    document.all.pleasewaitScreen.style.pixelTop = (document.body.scrollTop + 50);
    document.all.pleasewaitScreen.style.visibility = "visible";
    // window.setTimeout('do_totals2()');
    }
    function do_totals2() {
    document.all.pleasewaitScreen.style.visibility = "hidden";
    }
    function lengthy_calculation() {
    while(true) {
    }
    }
    </script>
    <DIV ID="pleasewaitScreen" STYLE="position: absolute; z-index: 5; top: 30%; left: 42%; visibility: hidden">
    <TABLE 
     ID="Table1">
    <TR>
    <TD   ALIGN="CENTER"
    VALIGN="MIDDLE"><img src="../img/loading.gif"></TD>
   <TD WIDTH="100%" HEIGHT="100%" BGCOLOR="silver" ALIGN="CENTER"
    VALIGN="MIDDLE"><FONT FACE="Arial" SIZE="4" COLOR="blue"><B>Calculating<br>
    Please Wait</B></FONT></TD> 
    </TR>
    </TABLE>
    </DIV>
   
    <form action="../pmegpdashboardmr.jsp" method="post"  onSubmit="do_totals1()">
    <p align="center"><input type="submit" name="btn_calc"
    value="Perform Calculation" ;></p>
    </form>
    <p>
    <center>
    </center>
    <p>
    </body>
    </html>