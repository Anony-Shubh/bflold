/*
 * @author:         Carlo Fontanos
 * @author_url:     carlofontanos.com
 *
 * A simple code snippet for parsing JSON data from a URL
 */
package api;
               
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.Statement;

public class JsonParser {

  public static  String vfrmdt = "";
public static  String vtodt = "";

           private static final String DB_DRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String DB_CONNECTION = "jdbc:oracle:thin:@192.168.50.86:1521:IASDB";
	private static final String DB_USER = "pmegpnew";
	private static final String DB_PASSWORD = "pmegp123";
   
          //43.240.67.54

    public JsonParser() {
		super();
		  }
        
   public  void  Showedp (String FROMDT,String TODT){
                  vfrmdt=FROMDT;
                   vtodt=TODT;
                                                     
                   
    JsonParser sm =new JsonParser();
           sm.edpdata(vfrmdt,vtodt);

                
                                    }
 
	              
    public void edpdata(String FROMDT,String TODT) {

     
      String qryString="";

       Connection connection =null; 
               Statement statement=null;
            
            try {
             Class.forName(DB_DRIVER);
             connection = DriverManager.getConnection(DB_CONNECTION,DB_USER,DB_PASSWORD);
             statement = connection.createStatement();
            
             connection.setAutoCommit(false) ;      
            
            }catch (Exception e) {System.out.print(e.toString());} 
            
               try {                          
              statement.execute("DELETE FROM ONLINE_EDP_DATA_TEMP");
                                     
              }catch (Exception e) {
             System.out.println(e.toString());
             
            }

     


        JSONParser parser = new JSONParser();

        try {        
            URL oracle = new URL("https://udyami.org.in/api/registrationdetails/2019-04-01/2019-12-31"); // URL to Parse
            URLConnection yc = oracle.openConnection();
            BufferedReader in = new BufferedReader(new InputStreamReader(yc.getInputStream()));
           
            String inputLine;
            while ((inputLine = in.readLine()) != null) {              
                JSONArray a = (JSONArray) parser.parse(inputLine);
             // application_id	name	email	mobile	pan_number	aadhar_number	type	registration_date	training_completion_date	certificate_no	download_certificate
 
                // Loop through each item
                for (Object o : a) {
                    JSONObject tutorials = (JSONObject) o;

                    
                      String application_id = (String) tutorials.get("application_id");
                      String name = (String) tutorials.get("name");
                      String email = (String) tutorials.get("email");
                      String mobile = (String) tutorials.get("mobile");
                      String pan_number = (String) tutorials.get("pan_number");
                      String aadhar_number = (String) tutorials.get("aadhar_number");
                      String type = (String) tutorials.get("type");
                      String registration_date = (String) tutorials.get("registration_date");
                      String training_completion_date = (String) tutorials.get("training_completion_date");
                      String certificate_no = (String) tutorials.get("certificate_no");
                      String download_certificate = (String) tutorials.get("download_certificate");
                      

                     String repdownload_certificate=(download_certificate.replace("\'>", ">")).replace("='","=");
                    

                        try {                          
                        statement.execute("INSERT INTO ONLINE_EDP_DATA_TEMP (APPLICATION_ID,NAME,EMAIL,MOBILE,PAN_NUMBER,AADHAR_NUMBER,TYPE,REGISTRATION_DATE,TRAINING_COMPLETION_DATE,CERTIFICATE_NO,DOWNLOAD_CERTIFICATE,LAST_UPDT_DT,PMEGP_DB_UPDATE) values('"+application_id+"','"+name+"','"+email+"','"+mobile+"','"+pan_number+"','"+aadhar_number+"','"+type+"','"+registration_date+"','"+training_completion_date+"','"+certificate_no+"','"+repdownload_certificate+"',SYSDATE,'')");
                               
                      }catch (Exception e) {
                       System.out.println(e);
 System.out.println(repdownload_certificate);

                        }   
                                  
                                  
                   System.out.println("\n");
                }
            }
            in.close();
            
               try {
            statement.close();
            connection.close();
            }catch (Exception e) {
				 System.out.print(e.toString());
				 }
 
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (ParseException e) {
            e.printStackTrace();
        }  
    }  
}