<%@ page session="true"  import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
<title>Flat Pricing Tables</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
<link rel="stylesheet" href="style.css" type="text/css"/>
<link href='http://fonts.googleapis.com/css?family=ABeeZee' rel='stylesheet' type='text/css'>
<link href="bootstrap.css" rel="stylesheet" type="text/css"/>
<link href="bootstrap-responsive.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="css/01.css" type="text/css"/>
<script>
function postURL(url, multipart) {
var yr=document.form.PMEGPYEAR.value;
url=url+'?YR='+yr;
  var form = document.createElement("FORM");
  form.method = "POST";
  if(multipart) {
    form.enctype = "multipart/form-data";
  }
  form.style.display = "none";
  document.body.appendChild(form);
  form.action = url.replace(/\?(.*)/, function(_, urlArgs) {
    urlArgs.replace(/\+/g, " ").replace(/([^&=]+)=([^&=]*)/g, function(input, key, value) {
      input = document.createElement("INPUT");
      input.type = "hidden";
      input.name = decodeURIComponent(key);
      input.value = decodeURIComponent(value);
      form.appendChild(input);
    });
    return "";
  });
  form.submit();
}

function selyear() {
document.getElementById("form").submit();

}

</script>
<style>
body {
  background:white;
  font-family: 'Open Sans', sans-serif;
}
.center {
  position: absolute;
  display: inline-block;
  top: 50%; left: 50%;
  transform: translate(-50%, -50%);
}

/** Custom Select **/
.custom-select-wrapper {
  position: relative;
  display: inline-block;
  user-select: none;
}
  .custom-select-wrapper select {
    display: none;
  }
  .custom-select {
    position: relative;
    display: inline-block;
  }
    .custom-select-trigger {
      position: relative;
      display: block;
      width: 130px;
      padding: 0 84px 0 22px;
      font-size: 22px;
      font-weight: 300;
      color: #fff;
      line-height: 60px;
      background: #5c9cd8;
      border-radius: 4px;
      cursor: pointer;
    }
      .custom-select-trigger:after {
        position: absolute;
        display: block;
        content: '';
        width: 10px; height: 10px;
        top: 50%; right: 25px;
        margin-top: -3px;
        border-bottom: 1px solid #fff;
        border-right: 1px solid #fff;
        transform: rotate(45deg) translateY(-50%);
        transition: all .4s ease-in-out;
        transform-origin: 50% 0;
      }
      .custom-select.opened .custom-select-trigger:after {
        margin-top: 3px;
        transform: rotate(-135deg) translateY(-50%);
      }
  .custom-options {
    position: absolute;
    display: block;
    top: 100%; left: 0; right: 0;
    min-width: 100%;
    margin: 15px 0;
    border: 1px solid #b5b5b5;
    border-radius: 4px;
    box-sizing: border-box;
    box-shadow: 0 2px 1px rgba(0,0,0,.07);
    background: #fff;
    transition: all .4s ease-in-out;
    
    opacity: 0;
    visibility: hidden;
    pointer-events: none;
    transform: translateY(-15px);
  }
  .custom-select.opened .custom-options {
    opacity: 1;
    visibility: visible;
    pointer-events: all;
    transform: translateY(0);
  }
    .custom-options:before {
      position: absolute;
      display: block;
      content: '';
      bottom: 100%; right: 25px;
      width: 7px; height: 7px;
      margin-bottom: -4px;
      border-top: 1px solid #b5b5b5;
      border-left: 1px solid #b5b5b5;
      background: #fff;
      transform: rotate(45deg);
      transition: all .4s ease-in-out;
    }
    .option-hover:before {
      background: #f9f9f9;
    }
    .custom-option {
      position: relative;
      display: block;
      padding: 0 22px;
      border-bottom: 1px solid #b5b5b5;
      font-size: 18px;
      font-weight: 600;
      color: #b5b5b5;
      line-height: 47px;
      cursor: pointer;
      transition: all .4s ease-in-out;
    }
    .custom-option:first-of-type {
      border-radius: 4px 4px 0 0;
    }
    .custom-option:last-of-type {
      border-bottom: 0;
      border-radius: 0 0 4px 4px;
    }
    .custom-option:hover,
    .custom-option.selection {
      background: #f9f9f9;
    }
	
	h3 {
  color:#990000;
  background-color:#CCCCCC;
}
</style>
</head>

<body >
<form method="post" name="form" id="form">
<img src="image/04_01.png" width="100%" style="border-bottom: 1px solid #000000">
<div class="container-fluid">
<div class="row-fluid">

<br>
      <img src="image/01.png" >
        
</div>
 <p>
   <%
   
   String YR=request.getParameter("PMEGPYEAR")==null?"ALL":(String) request.getParameter("PMEGPYEAR");
String rFromdt="";
String rTodt="";

if (YR.equals("2016-17")) {
rFromdt ="1-APR-2016";
rTodt="31-MAR-2017";
}

if (YR.equals("2017-18")) {
rFromdt ="1-APR-2017";
rTodt="31-MAR-2018";}

if (YR.equals("2018-19")) {
rFromdt ="1-APR-2018";
rTodt="31-MAR-2019";
}
if (YR.equals("2019-20")) {
rFromdt ="1-APR-2019";
rTodt="31-MAR-2020";
}

if (YR.equals("2020-21")) {
rFromdt ="1-APR-2020";
rTodt="31-MAR-2021";
}

if (YR.equals("ALL")) {
rFromdt ="1-JUL-2016";
rTodt="31-MAR-2021";
}

if (YR.equals("2021-22")) {
rFromdt ="1-APR-2021";
rTodt="31-MAR-2022";
}

if (YR.equals("2022-23")) {
rFromdt ="1-APR-2022";
rTodt="31-MAR-2023";
}

if (YR.equals("2023-24")) {
rFromdt ="1-APR-2023";
rTodt="31-MAR-2024";
}
if (YR.equals("2024-25")) {
rFromdt ="1-APR-2024";
rTodt="31-MAR-2025";
}
   
   
DBCon db= new DBCon();
db.connect();	
String REC_NO = "";
String REC_MM = "";
String SANC_NO = "";
String SANC_MM = "";
String DISB_NO = "";
String DISB_MM = "";


 StringBuffer qrysb= new StringBuffer();
  
 qrysb.append("   SELECT /*+ parallel(auto) */ "      );
qrysb.append("     SUM( NVL( CASE"      );
qrysb.append("           WHEN TRUNC(sq.app_rec_date) BETWEEN '"+rFromdt+"' AND '"+rTodt+"' THEN"      );
qrysb.append("   1"      );
qrysb.append("               ELSE"      );
qrysb.append("   0"      );
qrysb.append("       END,0)) AS REC_NO,"      );
qrysb.append("       "      );
qrysb.append("     round(SUM( NVL( CASE"      );
qrysb.append("           WHEN TRUNC(sq.app_rec_date) BETWEEN '"+rFromdt+"' AND '"+rTodt+"' THEN"      );
qrysb.append("               rec_mm"      );
qrysb.append("               ELSE"      );
qrysb.append("   0"      );
qrysb.append("       END,0))/10000000,2) AS REC_MM,"      );
qrysb.append("        SUM( NVL( CASE"      );
qrysb.append("           WHEN TRUNC(sq.Loan_sanc_dt) BETWEEN '"+rFromdt+"' AND '"+rTodt+"' THEN"      );
qrysb.append("               sanc_no"      );
qrysb.append("               ELSE"      );
qrysb.append("   0"      );
qrysb.append("       END,0)) AS SANC_NO,"      );
qrysb.append("       "      );
qrysb.append("    round( SUM( NVL( CASE"      );
qrysb.append("           WHEN TRUNC(sq.Loan_sanc_dt) BETWEEN '"+rFromdt+"' AND '"+rTodt+"' THEN"      );
qrysb.append("               rec_mm"      );
qrysb.append("               ELSE"      );
qrysb.append("   0"      );
qrysb.append("       END,0)) /10000000,2)AS SANC_MM,"      );
qrysb.append("       SUM( NVL( CASE"      );
qrysb.append("           WHEN TRUNC(sq.mm_rel_dt) BETWEEN '"+rFromdt+"' AND '"+rTodt+"' THEN"      );
qrysb.append("               disb_no"      );
qrysb.append("               ELSE"      );
qrysb.append("   0"      );
qrysb.append("       END,0)) AS DISB_NO,"      );
qrysb.append("       "      );
qrysb.append("    round( SUM( NVL( CASE"      );
qrysb.append("           WHEN TRUNC(sq.mm_rel_dt) BETWEEN '"+rFromdt+"' AND '"+rTodt+"' THEN"      );
qrysb.append("               disb_mm"      );
qrysb.append("               ELSE"      );
qrysb.append("   0"      );
qrysb.append("       END,0))/10000000,2) AS DISB_MM"      );
qrysb.append("      "      );
qrysb.append("   FROM"      );
qrysb.append("       ("      );
qrysb.append("           SELECT /*+ parallel(auto) */"      );
qrysb.append("               ms.state_cd,"      );
qrysb.append("               ms.state_nm,"      );
qrysb.append("               ad.online_subdt as app_rec_date,"      );
qrysb.append("               bd.mm_rel_dt,"      );
qrysb.append("               ad.app_id,"      );
qrysb.append("               bd.loan_sanc_dt,"      );
qrysb.append("               rb.bank_name,"      );
qrysb.append("               md.district_name,"      );
qrysb.append("               md.district_cd,"      );
qrysb.append("               1 AS rec_no,"      );
qrysb.append("               pm.inv AS rec_mm,"      );
qrysb.append("               DECODE(bd.act_id, 11, 1, 0) AS sanc_no,"      );
qrysb.append("               DECODE(bd.act_id, 11, pm.inv) AS sanc_mm,"      );
qrysb.append("               DECODE(bd.pact_id, 34, 1, 0) AS disb_no,"      );
qrysb.append("               DECODE(bd.pact_id, 34, bd.mm_rel_amt) AS disb_mm"      );
qrysb.append("           FROM"      );
qrysb.append("               PMEGPNEW.app_detail       ad,"      );
qrysb.append("               PMEGPNEW.bank_dataentry   bd,"      );
qrysb.append("               PMEGPNEW.pmegp_mminv      pm,"      );
qrysb.append("               PMEGPNEW.m_state          ms,"      );
qrysb.append("               PMEGPNEW.m_district       md,"      );
qrysb.append("               PMEGPNEW.rbibanklist      rb,"      );
qrysb.append("               PMEGPNEW.mas_off_mast     mom"      );
qrysb.append("           WHERE"      );
qrysb.append("               ad.app_id = pm.app_id"      );
qrysb.append("               AND ad.off_cd = mom.off_cd"      );
qrysb.append("               AND ad.unit_dist_cd = md.district_cd"      );
qrysb.append("               AND md.state_cd = ms.state_cd"      );
qrysb.append("               AND ad.ifsc_code = rb.ifsc_code"      );
qrysb.append("               AND ad.app_id = bd.app_id (+)  "      );
qrysb.append("       ) sq"      );




ResultSet rsMain = db.execSQL(qrysb.toString());


while (rsMain.next()) {
REC_NO=rsMain.getString("REC_NO")==null?"":rsMain.getString("REC_NO");
REC_MM=rsMain.getString("REC_MM")==null?"":rsMain.getString("REC_MM");
SANC_NO=rsMain.getString("SANC_NO")==null?"":rsMain.getString("SANC_NO");
SANC_MM=rsMain.getString("SANC_MM")==null?"":rsMain.getString("SANC_MM");
DISB_NO=rsMain.getString("DISB_NO")==null?"":rsMain.getString("DISB_NO");
DISB_MM=rsMain.getString("DISB_MM")==null?"":rsMain.getString("DISB_MM");


}
rsMain.close();
db.close();
%>
  </p>
 <p>
 Select Year:
   <select name="PMEGPYEAR" id="PMEGPYEAR"  class="custom-select sources" placeholder="Source Type" onChange="selyear();">
     <option value="ALL" selected>ALL </option>
	  <option value="2024-25" <% if (YR.equals("2024-25")){ out.print("Selected");};%>>2024-25 (Current Year) </option>
	  <option value="2023-24" <% if (YR.equals("2023-24")){ out.print("Selected");};%>>2023-24  </option>
	  <option value="2022-23" <% if (YR.equals("2022-23")){ out.print("Selected");};%>>2022-23  </option>
	  <option value="2021-22" <% if (YR.equals("2021-22")){ out.print("Selected");};%>>2021-22  </option>
	  <option value="2020-21" <% if (YR.equals("2020-21")){ out.print("Selected");};%>>2020-21  </option>
     <option value="2019-20" <% if (YR.equals("2019-20")){ out.print("Selected");};%>>2019-20 </option>
     <option value="2018-19"  <%if (YR.equals("2018-19")){ out.print("Selected");};%> >2018-19</option>
     <option value="2017-18" <%if (YR.equals("2017-18")){ out.print("Selected");};%>>2017-18</option>
     <option value="2016-17" <%if (YR.equals("2016-17")){ out.print("Selected");};%>>2016-17 ( From 01-Jul-2016)</option>
   </select>
  
   <br>
  </p>
 <div class="row-fluid2">


            <div class="span3 tiny ">
                <div class="pricing-table-header-tiny">
                    <h2>APPLICATION RECIEVED </h2>
                </div>
                <div class="pricing-table-features">
                    <p><strong>No. of Application :</strong><h3><%= REC_NO %></h3></p>
                    <p><strong>Margin Money :</strong><h3><%= REC_MM %></h3>(in cr.)</p>
              </div>
                <div class="pricing-table-signup-tiny">
                 <input name="btnrec" type="button" class="btn-info" value="More" onClick="postURL('statewisedwdbmsme.jsp','');">
                </div>
            </div>
 
 
            <div class="span3 medium">
                <div class="pricing-table-header-medium">
                    <h2>SANCTIONED BY BANK </h2>
                </div><div class="pricing-table-features">
                    <p><strong>No. of Projects :</strong><b><h3><%= SANC_NO %></h3></b></p>
                    <p><strong>Margin Money :</strong><b><h3><%= SANC_MM %></h3></b></p>
<p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(in cr.)<b></p>					
                </div>
                <div class="pricing-table-signup-medium">
                    <input name="btnrec" type="button" class="btn-info" value="More" onClick="postURL('statewisedwdbmsme.jsp','');">
                </div>
            </div>

            <div class="span3 pro">
                <div class="pricing-table-header-pro">
                    <h2>MARGIN MONEY RELEASED </h2>
                </div><div class="pricing-table-features">
                    <p><strong>No. of Projects :</strong><b><h3><%= DISB_NO %></h3></b></p>
                  <p><strong>Disbursed :</strong><b><h3><%= DISB_MM %></h3></b></p>
<p><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(in cr.)<b></p>					
                </div>
                <div class="pricing-table-signup-pro">
                   <input name="btnrec" type="button" class="btn-info" value="More" onClick="postURL('statewisedwdbmsme.jsp','');">
                    </p>
                </div>
            </div>



  </div>
</div>

<div class="ab" style="padding: 0.5rem;background-color: #B57D96;text-align: center;color: #FFFFFF;border-top: 1px solid ;font-weight: 800;border:2px solid #000">
	<B>DESIGNED AND MAINTAINED BY DIRECTORATE OF INFORMATION TECHNOLOGY, KVIC, MUMBAI</B>
</div>
</form>
    </body>
</html>
