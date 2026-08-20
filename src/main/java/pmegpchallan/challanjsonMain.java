package pmegpchallan;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.JsonNodeType;

import pmegpchallan.challanDatamodel;
import pmegpchallan.challanSHACheckHash;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;

public class challanjsonMain {
	private static int rowid=0;
	private static List<challanDatamodel> list= new ArrayList<challanDatamodel>();
	
	static String DB_DRIVER = "oracle.jdbc.driver.OracleDriver";
    static String DB_CONNECTION = "jdbc:oracle:thin:@192.168.50.86:1521:IASDB";//43.240.67.54
    static String DB_USER = "PMEGPNEW"; 
    static String DB_PASSWORD = "PMEGP123";
  
  public void paymentstatusverify(String inputJson) throws Exception,IOException, SQLException {
	  Connection connection = null;
	  PreparedStatement PSDEL=null;
	  PreparedStatement stmt=null;
	  
	  
	  //challanjsonMain api=new challanjsonMain();	 			
	 
      
		Class.forName(DB_DRIVER);
      connection = DriverManager.getConnection(DB_CONNECTION, DB_USER, DB_PASSWORD);
     
    	  
 String SQL_DELETE="Delete from INDBANKPAY_RESPONSE_TEMP";
          
          
          PSDEL = connection.prepareStatement(SQL_DELETE);
          
          int row1 = PSDEL.executeUpdate();
          
          PSDEL.close();
          
      
      int[] result = null;
      
      String SQL = "INSERT INTO INDBANKPAY_RESPONSE_TEMP (TRANSACTIONID,COL_DESC,COL_VAL,ROWNUMB) VALUES(?,?,?,?)"; 
      ObjectMapper objectMapper=null;
      JsonNode rootNode=null;
      
      objectMapper = new ObjectMapper();
      rootNode = objectMapper.readTree(inputJson);
      traverse(rootNode, 1);
   	  
           stmt = connection.prepareStatement(SQL);
          connection.setAutoCommit(false);
          
          String vtransactionId="";
          Object COL_DESC="";
          Object COL_VAL="";
          Object ROWNUMB="";
	      
	      for (challanDatamodel s : list) //Iterates as long as there are elements in the list. An object s is created of type Employee class.
	      {
	    	  
	    	  if ((String) s.gettransactionId()!="") { 
	    	  vtransactionId= (String) s.gettransactionId();
 	          }
	    	  
	    	 if((String) s.getColdesc()==("transactionId")) {
	    		 
	    		  s.setColval(vtransactionId);     // for column transactionid only 
	    	 }
	    	 
	    	 
	     // System.out.println((String) s.getColdesc()+"--"+(String) vtransactionId+"--"+ s.getColval());
	      stmt.setString(1, (String) vtransactionId); // Value for the first parameter, namely 'firstName'
          stmt.setString(2, (String) s.getColdesc() ); // Value for the second parameter, namely 'lastName'
          stmt.setObject(3, s.getColval()); 
          stmt.setInt(4,  s.getRowid()); // Value for the third parameter, namely 'id'
          stmt.addBatch(); // Add to Batch
	      
	     
        
          result = stmt.executeBatch(); // execute the Batch and commit
          connection.commit();
          
	      }
    
	      list.clear();
  }   
  
  private static void traverse(JsonNode node, int level) {
      if (node.getNodeType() == JsonNodeType.ARRAY) {
          traverseArray(node, level);
      } else if (node.getNodeType() == JsonNodeType.OBJECT) {
          traverseObject(node, level);
      } else {
         throw new RuntimeException("Not yet implemented");
      }
  }

  private static void traverseObject(JsonNode node, int level) {
      node.fieldNames().forEachRemaining((String fieldName) -> {
          JsonNode childNode = node.get(fieldName);
          printNode(childNode, fieldName, level);
          //for nested object or arrays
          if (traversable(childNode)) {
              traverse(childNode, level + 1);
          }
      });
  }

  private static void traverseArray(JsonNode node, int level) {
      for (JsonNode jsonArrayNode : node) {
          printNode(jsonArrayNode, "arrayElement", level);
          if (traversable(jsonArrayNode)) {
              traverse(jsonArrayNode, level + 1);
          }
      }
  }

  private static boolean traversable(JsonNode node) {
      return node.getNodeType() == JsonNodeType.OBJECT ||
              node.getNodeType() == JsonNodeType.ARRAY;
  }

  private static void printNode(JsonNode node, String keyName, int level) {
	  Object value = null;
	 String transactionId="";
	  	 int i=0;
	  	 
      if (traversable(node)) {
    	  if (keyName!="transaction_details") {
    		  rowid=rowid+1;
        	  list.add( new challanDatamodel(keyName, "transactionId",value,rowid));
          }
          
      } else {
        
          if (node.isTextual()) {
              value = node.textValue();
          } else if (node.isNumber()) {
              value = node.numberValue();
          }//todo add more types
        //  System.out.printf("%" + (level * 4 - 3) + "s|-- %s=%s type=%s%n",                  "", keyName, value, node.getNodeType());
      
      
      
    	
      Object mihpayid="";
      Object request_id="";
      Object bank_ref_num="";
      Object amt="";
      Object transaction_amount="";
      Object txnid="";
      Object additional_charges="";
      Object productinfo="";
      Object firstname="";
      Object bankcode="";
      Object udf1="";
      Object udf3="";
      Object udf4="";
      Object udf5="";
      Object field2="";
      Object field9="";
      Object error_code="";
      Object addedon="";
      Object payment_source="";
      Object card_type="";
      Object error_Message="";
      Object net_amount_debit="";
      Object disc="";
      Object mode="";
      Object PG_TYPE="";
      Object card_no="";
      Object name_on_card="";
      Object udf2="";
      Object field5="";
      Object field7="";
      Object status="";
      Object unmappedstatus="";
      Object Merchant_UTR="";
      Object Settled_At="";
    
   
      if (keyName.equals("mihpayid")) {
    	  rowid=rowid+1;
    	  list.add( new challanDatamodel(transactionId, "mihpayid",value,rowid));
    	 
      }
      if (keyName.equals("request_id")) {
    	  rowid=rowid+1;
    	  list.add( new challanDatamodel(transactionId, "request_id",value,rowid));
    	 
      }
      if (keyName.equals("bank_ref_num")) {
    	  rowid=rowid+1;
    	  list.add( new challanDatamodel(transactionId, "bank_ref_num",value,rowid));
    	 
      }
      if (keyName.equals("amt")) {
    	  rowid=rowid+1;
    	  list.add( new challanDatamodel(transactionId, "amt",value,rowid));
    	 
      }
      if (keyName.equals("transaction_amount")) {
    	  rowid=rowid+1;
    	  list.add( new challanDatamodel(transactionId, "transaction_amount",value,rowid));
    	 
      }
      
      
      if (keyName.equals("txnid")) {
    	  rowid=rowid+1;
    	  list.add( new challanDatamodel(transactionId, "txnid",value,rowid));
    	 
      }
      if (keyName.equals("additional_charges")) {
    	  rowid=rowid+1;
    	  list.add( new challanDatamodel(transactionId, "additional_charges",value,rowid));
    	 
      }
      if (keyName.equals("productinfo")) {
    	  rowid=rowid+1;
    	  list.add( new challanDatamodel(transactionId, "productinfo",value,rowid));
    	 
      }
      if (keyName.equals("firstname")) {
    	  rowid=rowid+1;
    	  list.add( new challanDatamodel(transactionId, "firstname",value,rowid));
    	 
      }
      if (keyName.equals("bankcode")) {
    	  rowid=rowid+1;
    	  list.add( new challanDatamodel(transactionId, "bankcode",value,rowid));
    	 
      }
      
      if (keyName.equals("udf1")) {
    	  rowid=rowid+1;
    	  list.add( new challanDatamodel(transactionId, "udf1",value,rowid));
    	 
      }
      
      if (keyName.equals("udf3")) {
    	  rowid=rowid+1;
    	  list.add( new challanDatamodel(transactionId, "udf3",value,rowid));
    	 
      }
      
      if (keyName.equals("udf4")) {
    	  rowid=rowid+1;
    	  list.add( new challanDatamodel(transactionId, "udf4",value,rowid));
    	 
      }
      
      
      
      if (keyName.equals("udf5")) {
    	  rowid=rowid+1;
    	  list.add( new challanDatamodel(transactionId, "udf5",value,rowid));
    	 
      }if (keyName.equals("field2")) {
    	  rowid=rowid+1;
    	  list.add( new challanDatamodel(transactionId, "field2",value,rowid));
    	 
      }
      if (keyName.equals("field9")) {
    	  rowid=rowid+1;
    	  list.add( new challanDatamodel(transactionId, "field9",value,rowid));
    	 
      }
      
      if (keyName.equals("error_code")) {
    	  rowid=rowid+1;
    	  list.add( new challanDatamodel(transactionId, "error_code",value,rowid));
    	 
      }
      if (keyName.equals("addedon")) {
    	  rowid=rowid+1;
    	  list.add( new challanDatamodel(transactionId, "addedon",value,rowid));
    	 
      }
      if (keyName.equals("payment_source")) {
    	  rowid=rowid+1;
    	  list.add( new challanDatamodel(transactionId, "payment_source",value,rowid));
    	 
      }
      if (keyName.equals("card_type")) {
    	  rowid=rowid+1;
    	  list.add( new challanDatamodel(transactionId, "card_type",value,rowid));
    	 
      }
      if (keyName.equals("error_Message")) {
    	  rowid=rowid+1;
    	  list.add( new challanDatamodel(transactionId, "error_Message",value,rowid));
    	 
      }
      
   
      if (keyName.equals("net_amount_debit")) {
    	  rowid=rowid+1;
    	  list.add( new challanDatamodel(transactionId, "net_amount_debit",value,rowid));
    	 
      }
      if (keyName.equals("disc")) {
    	  rowid=rowid+1;
    	  list.add( new challanDatamodel(transactionId, "disc",value,rowid));
    	 
      }
      if (keyName.equals("mode")) {
    	  rowid=rowid+1;
    	  list.add( new challanDatamodel(transactionId, "mode",value,rowid));
    	 
      }
      if (keyName.equals("PG_TYPE")) {
    	  rowid=rowid+1;
    	  list.add( new challanDatamodel(transactionId, "PG_TYPE",value,rowid));
    	 
      }
      if (keyName.equals("card_no")) {
    	  rowid=rowid+1;
    	  list.add( new challanDatamodel(transactionId, "card_no",value,rowid));
    	 
      }
      if (keyName.equals("name_on_card")) {
    	  rowid=rowid+1;
    	  list.add( new challanDatamodel(transactionId, "name_on_card",value,rowid));
    	 
      }
      
      if (keyName.equals("udf2")) {
    	  rowid=rowid+1;
    	  list.add( new challanDatamodel(transactionId, "udf2",value,rowid));
    	 
      }
      if (keyName.equals("field5")) {
    	  rowid=rowid+1;
    	  list.add( new challanDatamodel(transactionId, "field5",value,rowid));
    	 
      }
      if (keyName.equals("field7")) {
    	  rowid=rowid+1;
    	  list.add( new challanDatamodel(transactionId, "field7",value,rowid));
    	 
      }
      
      if (keyName.equals("status")) {
    	  rowid=rowid+1;
    	  list.add( new challanDatamodel(transactionId, "status",value,rowid));
    	 
      }
      
      if (keyName.equals("unmappedstatus")) {
    	  rowid=rowid+1;
    	  list.add( new challanDatamodel(transactionId, "unmappedstatus",value,rowid));
    	 
      }
      
      if (keyName.equals("Merchant_UTR")) {
    	  rowid=rowid+1;
    	  list.add( new challanDatamodel(transactionId, "Merchant_UTR",value,rowid));
    	 
      }
      
      if (keyName.equals("Settled_At")) {
    	  rowid=rowid+1;
    	  list.add( new challanDatamodel(transactionId, "Settled_At",value,rowid));
    	 
      }
      
      
      
      }// traverse node else
     // list.clear();
  }
 
}
