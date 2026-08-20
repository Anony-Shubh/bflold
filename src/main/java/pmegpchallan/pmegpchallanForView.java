package pmegpchallan;
import okhttp3.Headers;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import pmegpchallan.challanSHACheckHash;
import pmegpchallan.challanjsonMain;
import okhttp3.RequestBody;
 import okhttp3.MediaType;
import java.io.IOException;
import java.util.concurrent.TimeUnit;

public class pmegpchallanForView {
	
	
	public String pmegpchallanID(String var1) {
	String hash="";
	if (var1.equals("")||var1==null) {
		return "var1 not null";
	}else {
	try {
	RequestBody body=null ;
	  challanSHACheckHash sh=new challanSHACheckHash();
	  challanIDModel ci= new challanIDModel();
	  ci.setVar1(var1);
	  hash = sh.sha512(ci.getHash());       
	  System.out.print(hash);
	  System.out.print("\n");
	  
		  OkHttpClient client1 = new OkHttpClient().newBuilder().build();
		MediaType mediaType = MediaType.parse("application/x-www-form-urlencoded");
		String comp="form=2&key="+ci.getVkey()+"&command=verify_payment&var1="+var1+"&hash="+hash;
		 body = RequestBody.create(mediaType,comp );	
		System.out.print(body.toString());
		Request request = new Request.Builder()
		  .url("https://info.payu.in/merchant/postservice")
		  .method("POST", body)
		  .addHeader("Content-Type", "application/x-www-form-urlencoded")
		  .build();
		Response response = client1.newCall(request).execute();
		            if (!response.isSuccessful()) throw new IOException("Unexpected code " + response);
		            challanjsonMain cjm= new challanjsonMain();              
		            cjm.paymentstatusverify(response.body().string());
		            client1.connectionPool().evictAll();
		            response.close();
		             body=null;
		             cjm=null;	
		             ci=null;
		             return "Successfully Executed";
	}catch (Exception e) {
	
		 return "Something Went Wrong"+e.toString();
		
	}            
	}// end of if              
	 }// end of method       
}//
