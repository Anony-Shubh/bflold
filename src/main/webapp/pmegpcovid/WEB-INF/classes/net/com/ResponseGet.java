package net.com;

//java.nio.charset.StandardCharsets;
import java.util.Base64;
import javax.crypto.*;
import java.security.*;
import com.toml.dp.util.AES128Bit;
import java.util.*;
import java.util.List;
import java.util.*;
import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.Statement;
           
  public class ResponseGet {
  
     private static final String DB_DRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String DB_CONNECTION = "jdbc:oracle:thin:@43.240.67.54:1521:IASDB";
	private static final String DB_USER = "SAFAL";
	private static final String DB_PASSWORD = "SAFAL";
 Connection conn =null; 
   Statement statement=null;
  
      public static void main (String[] args) {
String encData="mOzykGgg5g9SgFKNL2idWjXbyM7H65NNxnmZHLmgWNp+RHJTYSzJBcIuYEG4YZ2V9aFcTigDCTkc569j1484rib0BA1DoNQdrJyjflRrzUXOW+YYvptCHEts7XwO1Y7SDEIAr7Puhii7Ur20drB9IZc/dTdCyxFi3v3oZhDzJGFKCLeXz/EyyWAX49paqu9Emme+mzP7KGTTGaS7jIcjxI6a+1MtPyERseIg/mzFb1vQyhFZRGDL/u9RhrLK4gQsQ13j6C6v42L286jtmoiCd/RpBTuK3qOX3cxlnLyLs8vHme3q2Tu++PZRo3r4dIZ6Xa2BmPajpHKxespZkLfHnHMwhngeR/5v5+iAZwleWt9MSAo3B3ZFUflKsNfjwCJI";
String merchIdVal="1000003";    
    
    
     ResponseGet sm = new ResponseGet();    
	  System.out.print(sm.ShowPath (encData,merchIdVal));

}



    public  String  ShowPath (String pencData,String pmerchIdVal){
          
          
     	String mrechn="";      
try {
String encData=pencData;
String merchIdVal=pmerchIdVal;

AES128Bit enc =new AES128Bit();
String csv=enc.decrypt(encData,"fBc5628ybRQf88f/aqDUOQ==");

		String[] strArray = new String[] {
"MerchantOrderNo",
"SBIePayReferenceID",
"Status",
"Amount",
"Currency",
"Paymode",
"OtherDetails",
"Reason",
"BankCode",
"BankReferenceNumber",
"TransactionDate",
"Country",
"CIN",
"MarchantId",
"OthBankCharges"
};
	
     String[] elements = csv.split("\\s*[|]\\s*");
   List<String> fixedLenghtList = Arrays.asList(elements);
  ArrayList<String> listOfString = new ArrayList<String>(fixedLenghtList);
  
    String rqystr=" INSERT INTO SBIEPAY_RESPONSE ( RTIMESTAMP,MERCHANT_ORDER_NO,SBIE_PAYREF_ID,STATUS,AMOUNT,CURRENCY,PAYMODE,OTHER_DETAILS,REASON,BANKCODE,BANK_REFERENCE_NUMBER,TRANSACTION_DATE,COUNTRY,CIN,MERCHANTID,OTHBANKCHARGES) VALUES (sysdate ";
  String qryval="";

   		for (int i = 0; i < strArray.length; i++) {		
 	
         qryval=qryval+",'"+listOfString.get(i)+"'";
         mrechn=listOfString.get(0);
		 }	
       	
  rqystr=rqystr+qryval+")";
		  //System.out.print(rqystr);	
        


        try{
            Connection conn = DriverManager.getConnection(DB_CONNECTION,DB_USER,DB_PASSWORD); 
            Statement st = conn.createStatement(); 
            st.executeUpdate(rqystr); 
           
            conn.close(); 
            }catch (Exception e){System.out.print(e.toString());
            }
        
}catch (Exception e){System.out.print("thre is problem in SBI Data");}




          
          return mrechn;
          
          
                 }    // ShowPath end
 
 }// end main