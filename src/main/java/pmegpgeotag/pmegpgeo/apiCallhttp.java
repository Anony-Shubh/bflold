package pmegpgeotag.pmegpgeo;

import okhttp3.Headers;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
 import okhttp3.RequestBody;
 import okhttp3.MediaType;
import java.io.IOException;
import java.util.concurrent.TimeUnit;


public class apiCallhttp {
	 private final OkHttpClient httpClient = new OkHttpClient();



	
	 public String sendGETSync(String pappid,String pfromdt,String ptodt) throws IOException {
         
		  OkHttpClient client1 = new OkHttpClient().newBuilder()
				 .readTimeout(100000000, TimeUnit.MILLISECONDS)
		  .build();
		MediaType mediaType = MediaType.parse("application/json");
		//RequestBody body = RequestBody.create(mediaType, " {\r\n      \"applicantId\":\"DIGJ17186145-6212763\"\r\n      }");
		//RequestBody body = RequestBody.create(mediaType, " {\r\n      \"fromDate\":\"2021-06-05\",\r\n      \"toDate\":\"2021-06-08\"\r\n     }");
		
		RequestBody body = RequestBody.create(mediaType, "{\r\n     \"fromDate\":\""+pfromdt+"\",\r\n   \"toDate\":\""+ptodt+"\" \r\n }");
		
		Request request = new Request.Builder()
		  .url("http://geotag.kvic.gov.in//GetInspectionData/api/kvic/getDataForApproval")
		  .method("POST", body)
		
		  .addHeader("Content-Type", "application/json")
		  .build();
		//Response response = client.newCall(request).execute();

		        try (Response response = client1.newCall(request).execute()) {

		            if (!response.isSuccessful()) throw new IOException("Unexpected code " + response);

		            // Get response headers
		            Headers responseHeaders = response.headers();
		            for (int i = 0; i < responseHeaders.size(); i++) {
		              //  System.out.println(responseHeaders.name(i) + ": " + responseHeaders.value(i));
		            }

		            // Get response body
		            return (response.body().string());
		        }
	 }        


}
