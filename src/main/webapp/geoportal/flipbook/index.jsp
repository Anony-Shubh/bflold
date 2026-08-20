

<%@ page session="true"  import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="globalp.*"%>
<%
String benef_id="";
String benef_name="";
String gndr="";
String social="";
String u_name="";
String u_addr="";
String u_est_dt="";
String u_loc="";
String u_spon="";
String ind_type="";
String u_lat="";
String u_long="";
String prod_desc="";
String proj_cost="";
String bank_name="";
String branch_name="";
String ifsc_code="";
String ann_prod_qty="";
String ann_prod_rs="";
String presn_sale_qty="";
String presn_sale_rs="";
String ctry_expt="";
String mgn_rls="";
String ver_status="";
String ver_dt="";
String img="";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width">
    <title>Document</title>
    <script type="text/javascript" src="js/jquery.min.1.7.js"></script>
    <script type="text/javascript" src="js/turn.min.js"></script>
    <script type="text/javascript" src="js/modernizr.2.5.3.min.js"></script>
    <style>
        body{
            overflow: hidden;
            background: rgb(250, 189, 97);
        }
        #container{
            width: 100%;
            height: 100%;
           
            
        }
        #flipbook{
            width: 100%;
            height: 100%;
            margin: auto;
            margin-top: 37px;
        }
        #flipbook .page{
    
            background-color: white;
            background-repeat: no-repeat;
            background-size: 100% 100%;
            
    
        }
        #flipbook .depth{
        background-image:url(img/pages-depth.png);
        position:absolute;
        top:7px;
        width:16px;
        height:590px;
        }
        #flipbook iframe{
            margin: 0 auto;
            padding: 25px 5px 10px 15px;
        }
        #flipbook .page-wrapper{
            -webkit-perspective: 2000px;
            -moz-perspective: 2000px;
            -o-perspective:2000px;
            perspective: 2000px;
        }
        #flipbook .hard{
            background: darkgray;
            color: #ffffff;
            -webkit-box-shadow: inset 0 0 5px #666666;
            -moz-box-shadow: inset 0 0 5px #666666;
            -o-box-shadow: inset 0 0 5px #666666;
            box-shadow: inset 0 0 5px #666666;
            font-weight: bold;
        }
        #flipbook .hard img{
            width: 100%;
            height: 100%;
        }
        
        #flipbook .even{
        background-image:-webkit-linear-gradient(left, #FFF 95%, #ddd 100%);
        background-image:-moz-linear-gradient(left, #FFF 95%, #ddd 100%);
        background-image:-o-linear-gradient(left, #FFF 95%, #ddd 100%);
        background-image:-ms-linear-gradient(left, #FFF 95%, #ddd 100%);
    
        }
        #flipbook .odd img{
            width: 97%;
            height: 97%;
            margin-top: 7px;
            margin-left: 9px;
        }
        
        #flipbook .odd{
            background-image:-webkit-linear-gradient(right, #FFF 95%, #ddd 100%);
            background-image:-moz-linear-gradient(right, #FFF 95%, #ddd 100%);
            background-image:-o-linear-gradient(right, #FFF 95%, #ddd 100%);
            background-image:-ms-linear-gradient(right, #FFF 95%, #ddd 100%);
        }
        table {
            font-family: arial, sans-serif;
            border-collapse: collapse;
            width: 100%;
            margin: 5px;
        }
        
        tr,td, th {
            border: 1px solid #dddddd;
            text-align: center;
            padding: 6px;
            font-size: 8px;
        
            
        }
        th{
            font-weight: bolder;
        }
        p{
            background-color: rgb(187, 119, 18);
            color: white;
            text-align: center;
            margin: 5px;
            font-size: 13px;
            display:ruby-base;
        }
        .row{
            background-color:#ddd;
            text-transform: uppercase;
            font-weight: bolder;
            
        }
    </style>
   
</head>
<body>
    <div id="container">
        <div id="flipbook">
                <div class="hard"><img src="img/1234.jpg" width="100%" height="100%"></div>
                <div class="hard"><img src="img/12345.jpg"> <div class="depth"></div></div>
                <div></div>
               
                <%
				//String  APP_ID =request.getParameter("APP_ID")==null?"":(String)request.getParameter("APP_ID");
				//String  PMEGPGEOTAGID =request.getParameter("PMEGPGEOTAGID")==null?"":(String)request.getParameter("PMEGPGEOTAGID");
String ID="";
				DBCon db= new DBCon();
				db.connect();
              StringBuffer qrysb= new StringBuffer();
	

qrysb.append("   SELECT GT.UNIT_NAME,substr(AD.App_id,instr(AD.App_id,'-')+1,length(AD.app_id))  AS ID, "      );
qrysb.append("     GT.UNIT_ADDRESS,AD.APP_NAME,AD.GENDER,  AD.BENF_CATAGORY_CD,GT.LATITUDE,  GT.LONGITUDE, "      );
qrysb.append("     GT.PMEGPGEOTAGID,"      );
qrysb.append("     TO_CHAR(GT.UNIT_ESTABLISHMENT_DATE,'DD-MON-RRRR') AS UNIT_ESTABLISHMENT_DATE,"      );
qrysb.append("     AD.UNIT_LOC,AD.APP_ID,"      );
qrysb.append("     AD.IND_TYPE,GT.DOC_NAME,"      );
qrysb.append("     AD.PROD_DESC,"      );
qrysb.append("     NVL(BD.MACHINARY_COST,0)+NVL(BD.WORKING_CAPITAL,0)AS TOT_PRJ_COST,"      );
qrysb.append("     RBL.BANK_NAME,"      );
qrysb.append("     RBL.IFSC_CODE,"      );
qrysb.append("     RBL.BRANCHNAME,"      );
qrysb.append("     GT.ANNUAL_PRODUCTION_QUANTITY,"      );
qrysb.append("     GT.PRESENT_PRODUCTION_VALUE,"      );
qrysb.append("     GT.ANNUAL_PRODUCTION_VALUE,"      );
qrysb.append("     GT.PRESENT_PRODUCTION_QUANTITY,"      );
qrysb.append("     GT.COUNTRY_OF_EXPORT,"      );
qrysb.append("     BD.MM_REL_AMT,"      );
qrysb.append("     GT.VERIFICATION_STATUS,"      );
qrysb.append("      TO_CHAR(GT.VERIFICATION_DATETIME,'DD-MON-RRRR') AS VERIFICATION_DATETIME, GT.PRESENT_SALES_QUANTITY,  GT.PRESENT_SALES_VALUE  "      );
qrysb.append("   FROM APP_DETAIL AD,"      );
qrysb.append("     BANK_DATAENTRY BD,"      );
qrysb.append("     MAS_OFF_MAST MOM,"      );
qrysb.append("     M_DISTRICT MD,"      );
qrysb.append("     M_STATE MS,"      );
qrysb.append("     ACTIVITY_MAST AM,"      );
qrysb.append("     GEOTAG_TRANS GT,"      );
qrysb.append("     RBIBANKLIST RBL,"      );
qrysb.append("     IND_GRP_MAST IGM,"      );
qrysb.append("     GEOTAG_REMARKS GR"      );
qrysb.append("   WHERE AD.APP_ID      = BD.APP_ID"      );
qrysb.append("   AND AD.OFF_CD        = MOM.OFF_CD"      );
qrysb.append("   AND AD.UNIT_DIST_CD  = MD.DISTRICT_CD"      );
qrysb.append("   AND MS.STATE_CD      = MD.STATE_CD"      );
qrysb.append("   AND AM.ACTIVITY_CD   = AD.ACTIVITY_CD"      );
qrysb.append("   AND AD.IFSC_CODE     = RBL.IFSC_CODE"      );
qrysb.append("   AND GT.REMTRID       = GR.REMTRID(+)"      );
qrysb.append("   AND AD.APP_ID        = GT.APP_ID"      );
qrysb.append("   AND AM.IND_GRP_CD    = IGM.IND_GRP_CD"      );
qrysb.append("   AND (BD.PACT_ID      = 34 AND GT.DOC_NAME IS NOT NULL) "      );
//qrysb.append("   AND AD.APP_ID        = ?  "      );
//qrysb.append("   AND GT.PMEGPGEOTAGID = ? )"      );




List values=new ArrayList();


  
   ResultSet rs = db.execSQL(qrysb.toString());
 
     
				   
				   
				   
				   
                    while(rs.next()){ 
					
                        benef_id=rs.getString("APP_ID")==null?"":rs.getString("APP_ID");
                        benef_name=rs.getString("APP_NAME")==null?"":rs.getString("APP_NAME");
                        gndr=rs.getString("GENDER")==null?"":rs.getString("GENDER");
                        social=rs.getString("BENF_CATAGORY_CD")==null?"":rs.getString("BENF_CATAGORY_CD");
                        u_name=rs.getString("UNIT_NAME")==null?"":rs.getString("UNIT_NAME");
                        u_addr=rs.getString("UNIT_ADDRESS")==null?"":rs.getString("UNIT_ADDRESS");
                        u_est_dt=rs.getString("UNIT_ESTABLISHMENT_DATE")==null?"":rs.getString("UNIT_ESTABLISHMENT_DATE");
                        u_loc=rs.getString("UNIT_LOC")==null?"":rs.getString("UNIT_LOC");
                       // u_spon=rs.getString("u_spon")==null?"":rs.getString("u_spon");
                        ind_type=rs.getString("IND_TYPE")==null?"":rs.getString("IND_TYPE");
                        u_lat=rs.getString("LATITUDE")==null?"":rs.getString("LATITUDE");
                        u_long=rs.getString("LONGITUDE")==null?"":rs.getString("LONGITUDE");
                        prod_desc=rs.getString("PROD_DESC")==null?"":rs.getString("PROD_DESC");
                        proj_cost=rs.getString("TOT_PRJ_COST")==null?"":rs.getString("TOT_PRJ_COST");
                        bank_name=rs.getString("BANK_NAME")==null?"":rs.getString("BANK_NAME");
                        branch_name=rs.getString("BRANCHNAME")==null?"":rs.getString("BRANCHNAME");
                        ifsc_code=rs.getString("IFSC_CODE")==null?"":rs.getString("IFSC_CODE");
                        ann_prod_qty=rs.getString("ANNUAL_PRODUCTION_QUANTITY")==null?"":rs.getString("ANNUAL_PRODUCTION_QUANTITY");
                        ann_prod_rs=rs.getString("ANNUAL_PRODUCTION_VALUE")==null?"":rs.getString("ANNUAL_PRODUCTION_VALUE");
                        presn_sale_qty=rs.getString("PRESENT_SALES_QUANTITY")==null?"":rs.getString("PRESENT_SALES_VALUE");
                        presn_sale_rs=rs.getString("PRESENT_SALES_VALUE")==null?"":rs.getString("PRESENT_SALES_VALUE");
                        ctry_expt=rs.getString("COUNTRY_OF_EXPORT")==null?"":rs.getString("COUNTRY_OF_EXPORT");
                        mgn_rls=rs.getString("MM_REL_AMT")==null?"":rs.getString("MM_REL_AMT");
                        ver_status=rs.getString("VERIFICATION_STATUS")==null?"":rs.getString("VERIFICATION_STATUS");
                        ver_dt=rs.getString("VERIFICATION_DATETIME")==null?"":rs.getString("VERIFICATION_DATETIME");		
						img=rs.getString("DOC_NAME")==null?"":rs.getString("DOC_NAME");
						ID=rs.getString("ID")==null?"":rs.getString("ID");
						
						
						
																																										
                        
                %>
                <div class="even">
                    <p>UNIT DETAILS</p>
                    <table>
                        <tr class="row">
                            <th colspan="2">Unit Name:</th>
                            <td colspan="4"><%=u_name%></td>
                        </tr>
                        <tr>
                            <th colspan="2">Unit Address:</th>
                            <td colspan="4"><%=u_addr%></td>
                        </tr>
                            <th>Unit Establishment Date:</th>
                            <th>Unit location:</th>
                            <th>Unit Sponsored</th>
                            <th>Industry type</th>
                            <th>Geo Tag</th>
                        </tr>
                        <tr>
                            <td><%=u_est_dt%></td> 
                            <td><%=u_loc%></td>
                            <td><%=u_spon%></td>
                            <td><%=ind_type%></td>
                            <td><%=u_lat%>,<%=u_long%></td>
                            </tr>
                        <tr>
                            <th colspan="2">Product Discription</th>
                            <td colspan="4"><%=prod_desc%></td>
                        </tr>
                        <tr>
                            <th colspan="2">Total Project Cost:</th>
                            <td colspan="4"><%=proj_cost%></td>
                        </tr>
                    </table>
                    <p>BENEFICIARY DETAILS</p>
                    <table>
                        <tr class="row">
                            <th>Beneficiary ID:</th>
                            <td colspan="2"><%=benef_id%></td>
                        </tr>
                        <tr>
                            <th>Beneficiary Name:</th>
                            <th>Gender:</th>
                            <th>Social:</th>
                        </tr>
                        <tr>
                            
                            <td> <%=benef_name%></td>
                            <td><%=gndr%></td>
                            <td><%=social%></td>
                        </tr>
                    </table>
                    
                    <P>BANK DETAILS</P>
                    <table>
                        <tr>
                            <th>Financing bank:</th>
                            <th>Bank branch:</th>
                            <th>IFSC CODE:</th>  
                        </tr>
                        <tr>
                            <td><%=bank_name%></td>
                            <td><%=branch_name%></td>
                            <td><%=ifsc_code%></td>
                        </tr>
                    </table>
                    <P>OTHER DETAILS</P>
                    <table>
                        <tr>
                            <th></th>
                            <th>Quantity</th>
                            <th>Value(in Rupees)</th>    
                        </tr>
                        <tr>
                            <td>Annual production</td>
                            <td><%=ann_prod_qty%></td>
                            <td><%=ann_prod_rs%></td>
                        </tr>
                        <tr>
                            <td>Present Production</td>
                            <td><%=presn_sale_qty%></td>
                            <td><%=presn_sale_rs%></td>
                        </tr>
                    </table>
                    <table>
                        <tr>
                            <th colspan="2">Country of Export:</th>
                            <td colspan="4"><%=ctry_expt%></td>
                        </tr>
                        <tr>
                            <th colspan="2"> Margin money release:</th>
                            <td colspan="4"><%=mgn_rls%></td>
                        </tr>
                        <tr>
                            <th>Verification Status:</th>
                            <td><%=ver_status%></td>
                            <th>Verification Date:</th>
                            <td><%=ver_dt%></td>
                        </tr>
                    </table>
                </div>
                    <div class="odd">
					<img src="../../../pmegpeportalappdoc/GEOTAGUPLOAD/<%=ID%>/<%=img%>">
                       <!-- <img src="<%=img%>">-->
                    </div>
					
                <%
                }
				rs.close();
				db.close();
                %>

                <div></div>
                    <div class="hard"><img src="img/123456.jpg" width="100%" height="100%"><div class="depth"></div></div>
                    <div class="hard"><img src="img/12333.jpg"></div>                    
        </div>
    </div>
    <script>
        $("#flipbook").turn({
            width: 822,
            height: 525,
            autocenter: true,
            next:true
        });
        $(window).bind('keydown', function(e){
    
    if (e.target && e.target.tagName.toLowerCase()!='input')
        if (e.keyCode==37)
            $('#flipbook').turn('previous');
        else if (e.keyCode==39)
            $('#flipbook').turn('next');
        });
    </script>
</body>
</html>