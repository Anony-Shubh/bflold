<!DOCTYPE html>
<HTML>
<HEAD>
<META CHARSET="ISO-8859-1">
<TITLE>Bank Form For Physical Verification</TITLE>
<STYLE>
#customers {
  font-family: Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 70%;
}

#customers td, #customers th {
  border: 1px solid #ddd;
  padding: 8px;
}

#customers tr:nth-child(even){background-color: #f2f2f2;}

#customers tr:hover {background-color: #ddd;}

#customers th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: #04AA6D;
  color: white;
}
input[type=text] {
  width: 100%;
  padding: 8px 14px;
  margin: 8px 0;
  box-sizing: border-box;
}
.buttongreen {
  background-color: #4CAF50;
  border: none;
  color: white;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
}
</STYLE>
</HEAD>
<BODY>
<H1 align="center">Bank Form for Physical Verification</H1>
<form>

<table id="customers" align="center">
<tr>
  <td><DIV align="center">(1)</DIV></td>
  <td colspan="2">Bank Name</td>
  <td colspan="2">&nbsp;</td>
</tr>
<tr>
  <td><DIV align="center">(2)</DIV></td>
  <td colspan="2">Bank Address</td>
  <td colspan="2">&nbsp;</td>
</tr>
<tr>
  <td><DIV align="center">(3)</DIV></td>
  <td colspan="2">Branch Name</td>
  <td colspan="2">&nbsp;</td>
</tr>
<tr>
  <td><DIV align="center">(4)</DIV></td>
  <td colspan="2">IFSC Code</td>
  <td colspan="2">&nbsp;</td>
</tr>
<tr>
  <td><DIV align="center">(5)</DIV></td>
  <td colspan="2">Bank Phone No.*</td>
  <td colspan="2"><INPUT type="text"  name="bankName" value=""></td>
</tr>
<tr>
  <td><DIV align="center">(6)</DIV></td>
  <td colspan="2">Beneficiary Name</td>
  <td colspan="2">&nbsp;</td>
</tr>
<tr>
  <td><DIV align="center">(7)</DIV></td>
  <td colspan="2">Application ID</td>
  <td colspan="2">&nbsp;</td>
</tr>
<tr>
  <td><DIV align="center">(8)</DIV></td>
  <td colspan="2">Beneficiary Contact No.*</td>
  <td colspan="2">&nbsp;</td>
</tr>
<tr>
  <td width="34"><DIV align="center"></DIV></td>
  <td width="135">&nbsp;</td>
  <td width="186"><DIV align="center">Term Loan(CE) (in Rs.) </DIV></td>
  <td width="185"><DIV align="center">Cash Credit(WC) (in Rs.)</DIV></td>
  <td width="187"><DIV align="center">Total (in Rs)</DIV></td>
</tr>
<tr>
  <td><DIV align="center">(9)</DIV></td>
  <td>Total Loan Sanctioned (A) </td>
  <td><INPUT type="text"  name="bankName2" value=""></td>
  <td><INPUT type="text"  name="bankName23" value=""></td>
  <td><INPUT type="text"  name="bankName25" value=""></td>
</tr>
<tr>
  <td><DIV align="center">(10)</DIV></td>
  <td>Loan Released (B) </td>
  <td><INPUT type="text"  name="bankName22" value=""></td>
  <td><INPUT type="text"  name="bankName24" value=""></td>
  <td><INPUT type="text"  name="bankName26" value=""></td>
</tr>
<tr>
  <td><DIV align="center">(11)</DIV></td>
  <td>Balance Loan to be Released to Beneficiary (A-B) </td>
  <td><INPUT type="text"  name="bankName27" value=""></td>
  <td><INPUT type="text"  name="bankName28" value=""></td>
  <td><INPUT type="text"  name="bankName29" value=""></td>
</tr>
<tr>
  <td><DIV align="center">(12)</DIV></td>
  <td colspan="2"><P>Whether Cash Credit limit utilized by 100% of sanctioned amount <BR>
    and lot less than 75% during lock-in period of 3 years</P>
    <P>(Mention %age utilization in case of No.)</P></td>
  <td colspan="2"><INPUT type="radio" name="yes4" >Yes</input>
    <INPUT type="radio" name="no4"> No</input></td>
</tr>
<tr>
  <td><DIV align="center">(13)</DIV></td>
  <td colspan="2"> in case of No</td>
  <td colspan="2"><INPUT type="text"  name="bankName42" value=""></td>
</tr>
<tr>
  <td><DIV align="center">(14)</DIV></td>
  <td colspan="2">Rate of Interest*</td>
  <td colspan="2">&nbsp;</td>
</tr>
<tr>
  <td><DIV align="center">(15)</DIV></td>
  <td colspan="2">Margin Money amount Received</td>
  <td colspan="2">&nbsp;</td>
</tr>
<tr>
  <td><DIV align="center">(16)</DIV></td>

  <td colspan="2">TDR/Subsidy Reserve Fund Amount*</td>
  <td colspan="2">&nbsp;</td>
</tr>
<tr>
  <td><DIV align="center">(17)</DIV></td>
  <td colspan="2">TDR/Subsidy Reserve Fund Number*</td>
  <td colspan="2">&nbsp;</td>
</tr>
<tr>
  <td><DIV align="center">(18)</DIV></td>
  <td colspan="2">TDR/Subsidy Reserve Fund Date*</td>
  <td colspan="2">&nbsp;</td>
</tr>
<tr>
  <td><DIV align="center">(19)</DIV></td>
  <td colspan="2">CGTMSE Coverage*</td>
  <td colspan="2"><INPUT type="radio" name="yes4">
    Yes
    </input>
    <INPUT type="radio" name="no4">
    No
  </input></td>
</tr>
<tr>
  <td><DIV align="center">(20)</DIV></td>
  <td colspan="2">Whether Interest Charged on Correspondind amount of Margin Money*</td>
  <td colspan="2"><INPUT type="radio" name="yes4">
    Yes
    </input>
    <INPUT type="radio" name="no4">
    No
  </input></td>
</tr>
<tr>
  <td><DIV align="center">(21)</DIV></td>
  <td colspan="2">Collateral Security obtained*</td>
  <td colspan="2"><INPUT type="radio" name="yes4">
Yes
  </input>
  <INPUT type="radio" name="no4">
No
</input></td>
</tr>
<tr>
  <td><DIV align="center">(22)</DIV></td>
  <td colspan="2">If Yes, Value of Collateral Security</td>
  <td colspan="2"><INPUT type="text"  name="bankName4252" value=""></td>
</tr>
<tr>
  <td><DIV align="center">(23)</DIV></td>
  <td colspan="2">Whether Repayment of Loan is Regular</td>
  <td colspan="2"><INPUT type="radio" name="yes4">
    Yes
    </input>
    <INPUT type="radio" name="no4">
    No
  </input></td>
</tr>
<tr>
  <td><DIV align="center">(24)</DIV></td>
  <td colspan="2">Whether unit comes under NPA?<BR></td>
  <td colspan="2"><INPUT type="radio" name="yes4">
    Yes
    </input>
      <INPUT type="radio" name="no4">
    No
    </input></td>
</tr>
<tr>
  <td><DIV align="center">(25)</DIV></td>
  <td colspan="2">
If Yes, NPA w.e.f.</td>
  <td colspan="2"><INPUT type="text"  name="bankName2102" value=""></td>
</tr>

<tr>
  <td rowspan="3"><DIV align="center">(26)</DIV></td>
  <td colspan="2" rowspan="3">Unit Status*</td>
  <td colspan="2"><INPUT type="radio"  name="phoneNo" value="">
Working</td>
  </tr>
<tr>
  <td colspan="2"><INPUT type="radio"  name="phoneNo2" value="">
Not Working/defunct</td>
  </tr>
<tr>
  <td colspan="2"><INPUT type="radio"  name="phoneNo3" value="">
Non-Traceable

</td>
  </tr>
<tr>
  <td rowspan="2"><DIV align="center">(27)</DIV></td>
  <td colspan="2" rowspan="2">Annual Turnover of the Unit</td>
  <td><DIV align="center">Production (in Rs.) </DIV></td>
  <td><DIV align="center">Sales (in Rs.) </DIV></td>
</tr>
<tr>
  <td><INPUT type="text"  name="bankName210" value=""></td>
  <td><INPUT type="text"  name="bankName211" value=""></td>
</tr>
<tr>
  <td><DIV align="center">(28)</DIV></td>
  <td colspan="2">Any other Remark on the Functioning of the Unit</td>
  <td colspan="2"><textarea type="text"  name="prod22" rows="4" cols="50" value=""></textarea></td>
</tr>
<tr>
  <td colspan="5"><div align="center"><input type="button" value="Submit" class="buttongreen"></div></td>
  </tr>
</table>

</form>
</BODY>
</HTML>