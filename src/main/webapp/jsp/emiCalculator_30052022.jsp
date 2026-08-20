<HTML>

<HEAD>
    <META CHARSET="ISO-8859-1">
    <TITLE>EMI Calculator</TITLE>

    <LINK rel="stylesheet" href="../pmegphomenew/css/sweetalert2.min.css">
    <LINK rel="stylesheet" href="../pmegphomenew/css/bootstrap.min.css">
    <LINK href="../pmegphomenew/css/style.css" rel="stylesheet">
    <LINK href="../pmegphomenew/Media Query/media.css" rel="stylesheet">
	
<STYLE type="text/css">
<!--
.style1 {color: #FFFFFF}
-->
ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
  overflow: hidden;
  background-color: #8c4906;
}

li {
  float: left;
  border-right:1px solid #bbb;
}

li:last-child {
  border-right: none;
}

li a {
  display: block;
  color: white;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
}

li a:hover:not(.active) {
  background-color: #111;
}

.active {
  background-color: #6e3904;
}

</STYLE>	
</HEAD>

<BODY>


  
<%@ include file="newincludepage.jsp" %>

    <DIV class="container">
        <DIV class="calculator">
            <H3>EMI Calculator for PMEGP Loan </H3>
            <FORM name="loan-form" inte();>
                <DIV class="form1">
                    <DIV class="row">
                        <DIV class="col-md-2 col-12"></DIV>
                        <DIV class="col-md-4 col-12">
                            <DIV class='loanBlock'>
                                <SPAN class="loanAmount">Loan Amount : </SPAN><BR>
                            </DIV>
                        </DIV>

                        <DIV class="col-md-4 col-12">
                            <DIV class='loanBlock'>
                                <INPUT type=number id="amount" size="" PATTERN="/^-?\d+\.?\d*$/" value="" />
                                <CENTER>
                                    <H2>
                                        <DIV id="word"></DIV>
                                    </H2>
                                </CENTER>
                            </DIV>
                        </DIV>
                        <DIV class="col-md-2 col-12"></DIV>

                    </DIV>

                    <DIV class="row">
                        <DIV class="col-md-2 col-12"></DIV>
                        <DIV class="col-md-4 col-12">
                            <DIV class='loanBlock'>
                                <SPAN class="loanAmount">Annual Rate of Interest : </SPAN>
                            </DIV>
                        </DIV>

                        <DIV class="col-md-4 col-12">
                            <DIV class='loanBlock'>
                                <INPUT type="number" STEP="any" name="apr" id="apr" PATTERN="/^-?\d+\.?\d*$/"
                                    onclick="interest()" ; value=""><BR>
                            </DIV>
                        </DIV>

                        <DIV class="col-md-2 col-12"></DIV>
                    </DIV>
                    <DIV class="row">
                        <DIV class="col-md-2 col-12"></DIV>
                        <DIV class="col-md-4 col-12">
                            <DIV class='loanBlock'>
                                <SPAN class="loanAmount">Loan Tenure (In Years) : </SPAN>
                            </DIV>
                        </DIV>
                        <DIV class="col-md-4 col-12">
                            <DIV class='loanBlock'>
                                <SELECT id="tenure" VALUE="10">
                                    <OPTION value="1">1</OPTION>
                                    <OPTION value="2">2</OPTION>
                                    <OPTION value="3">3</OPTION>
                                    <OPTION value="4">4</OPTION>
                                    <OPTION value="5" selected>5</OPTION>
                                    <OPTION value="6">6</OPTION>
                                    <OPTION value="7">7</OPTION>
                                    <OPTION value="8">8</OPTION>
                                    <OPTION value="9">9</OPTION>
                                    <OPTION value="10">10</OPTION>
                                </SELECT>
                            </DIV>
                        </DIV>
                        <DIV class="col-md-2 col-12"></DIV>
                    </DIV>

                    <BUTTON type="button" id="calculation" onClick="callcalc()" class="btn-calc">Calculate</BUTTON>
                </DIV>

                <DIV class="form2">
                    <DIV class='right'>
                        <DIV><B>Loan EMI : <BR>Rs. </B>
                            <P id="EMICapt"> </P>
                        </DIV>
                    </DIV>
                    <DIV class='middle'>
                        <DIV><B> Total Interest Payable: <BR>Rs. </B>
                            <P id="EMICapts"></P>
                        </DIV>
                    </DIV>
                    <DIV class='left'>
                        <DIV><B> Total Payment:<BR> Rs. </B>
                            <DIV id="EMICaptss"> </DIV>
                        </DIV>
                    </DIV>
                </DIV>
                <HR>
                <DIV align="center" class="note">
                    <H4>Note</H4>
                    <P>1. Calculator is provided only as general self-help Planning Tools.</P>
                    <P>2. Calculated EMI Result is indicative only.</P>
                </DIV>
            </FORM>
        </DIV>
    </DIV>
    <!-------------------------------------------------Footer Section  start  ---------------------------------------------->
  <Footer>
    <DIV class="container-fluid">
      <DIV class="footer-content py-2">
        <P>DESIGNED AND MAINTAINED
          BY DIRECTORATE OF INFORMATION TECHNOLOGY, KVIC, MUMBAI <SPAN class="email">( pmegpeportal.kvic@gov.in )</SPAN>
        </P>
      </DIV>
    </DIV>
  </Footer>

  <!-------------------------------------------------Footer Section End  ---------------------------------------------->
    <SCRIPT src="../pmegphomenew/js/jquery.min.js"></SCRIPT>
    <SCRIPT src="../pmegphomenew/js/bootstrap.min.js"></SCRIPT>
    <SCRIPT language="javascript" src="../pmegphomenew/js/sweetalert2.js"></SCRIPT>
    <SCRIPT src='../pmegphomenew/js/calci.js'> </SCRIPT>
    <SCRIPT language="javascript">
        function callcalc() {
            var vamt = document.getElementById('amount').value;
            var vinte = document.getElementById('apr').value;
            if (Number(vamt) < 1) {
                Swal.fire("Please enter Loan Amount...");
                return false;
            } else if (Number(vamt) > 2500000) {
                Swal.fire("Maximum Loan Amount is 25 lakhs");
                return false;
            } else if (Number(vinte) > 20) {
                Swal.fire("Rate of Interest Should be less than 20%...");
                return false;
            } else if (Number(vinte) < 1) {
                Swal.fire("Please enter annual Rate of Interest...");
                return false;
            }
            else {
                calculator();
                return false;
            }
        }
    </SCRIPT>
</BODY>

</HTML>