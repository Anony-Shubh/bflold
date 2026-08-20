package pmegpchallan;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

@WebServlet("/test")
public class testservlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	private final String vkey="BHUZlo";
	private final String var1="021315651|011315651|021347606|031347606|011347606";
	private final String vsalt="MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCdZKRkWFJA/C8CtiveKRI8VIn+3G/mWLWawVzwQH7290C8digYXOZJmqNwHqnE2d+mmQq8qMfN1xcP1K+p/rUTimzrGem3QKrLNxfvd20wssSvNrmtk+AdJLNBzMYKf6OOO3tTZZydrNybgJdEvxwGSXWjjNW/CMeNyW1D1sCOed6VaVUi4YIqL9cy0lXqhT2+BRAJ/lDcDynR9rcuDA0Xl0C34QbbkKJMwWzbKMfRlcCtrvDO4ZSZ5zx606/s0W/TplvwW7MSf1wwMEYURWIGucfnYPIc4r3io+mpHRd55XZM4KsGXS/OIoawC+14pav1ZWlKUB8VB5MwAffoH/+VAgMBAAECggEAZyJLlnVJcMvPAjfdBvZivKWoxxgrOwVl+sI55DRe/fWGtfe2zkARpqlt70oodJVPuBsQrg7q3jbTJcx4TyxX+zX5qRSR0ULOp9qyFHhtVDvQJf/2K4d6k5442CUWoEqDIfBYH4210pwy8rKQbLvN4VDBhSoD5eoa2Q3kS0+tXa322xlEMQ6AMxz3/Fd9u/xz9rHUQ0B1/aD4EhnBjmdhcCFRACIbIeHt7QLOgjLteOIbAsmZpplA+tWwJt5KnjPlv1XuezkrjXpk/pYhOOxJV77XEjITjLXkq8GECDbQA0zRrcZ3mmIJOARuldrQAwX5AF8LcUoZ2NEljtMccpcgAQKBgQDJXYybGaz70o9U1d+N1AieTTVK8qZd/Htw4PrpOg7NabvkN3t8yZLAPdyyH27RigIz9U4mWIwBvEyL5l3uZloxw2dBRasj3NsOvcdNBL6Fwvzy0P7+iMPYzUx9tLGcnC5rMHxi7DT9msPdr4t94Hsw7uqSccRvjEP/wx1coilAtQKBgQDIGNzr9BwyBEgfBFfrc/5vchzFia0RaAY9Z+lf1fyU/94Gdcp6ySOPLeM65OwJ24NoQYHQR3xAuBSFG26X9eDmY9M+C72udF3NTEl/pcPj3vewXCVyQCFFaEkFRJHeelkQfAJjwd9+uxwLqLIwdzliME2/23gpaZrDTmpDG7BvYQKBgQCXE7r0ezUP0pB7I+OQM28r5d2AF8G+bjnnHMTjyw1kDFpOBVp+63VRCpjUg0TPrW2tsfQqTPDuNGpx5CrBPMWa5HJJxI18YK1xx+0J2e9fyEWjoC5QpifaN12WSsWfLIafIUeRqIqxYzZk0tojXRLQSdBwgy7QSjqSX79dysSMqQKBgQCpS+f3NwV4CAlhPNKKYwyeDEVtmMu2U3YcFEPvEuTuyAF5I8YZ1v5gEOoVlURkHrbyyaHkr+bf9x9dc1VB+wW6yDEdaN+mr8wBfA8fkgfIT4jvTTddkAbWa6KEc3ybaJbcjJ+U+Z534iWbc7K3sNf7THUr46uqFjCcGEdt2gqQYQKBgFVpmgw8cy4FwKqkb2naSjJpvHHl77TnqEuHE+n1owcH9tqkJUonTIZpo8A6DcPdAYVTnBMq+ky6MtCJy8ebzx7NzQbl1DuXvPiXoombUMfhvkkIqTdBdzV5N/rhy79pQRLBIvNDgkvhRXmwJiDx6KCIcW5U0hbZyoCE4cOEcjia";
	private  String hash="";

	protected void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
	
		RequestBody body=null ;

		  challanSHACheckHash sh=new challanSHACheckHash();
		  
		  try {
			hash = sh.sha512(vkey+"|verify_payment|"+var1+"|"+vsalt);
			
			
			 OkHttpClient client1 = new OkHttpClient().newBuilder().build();
				
				MediaType mediaType = MediaType.parse("application/x-www-form-urlencoded");
				String comp="form=2&key="+vkey+"&command=verify_payment&var1="+var1+"&hash="+hash;
				 body = RequestBody.create(mediaType,comp );	
				System.out.print(body.toString());
				Request request1 = new Request.Builder()
				  .url("https://info.payu.in/merchant/postservice")
				  .method("POST", body)
				  .addHeader("Content-Type", "application/x-www-form-urlencoded")
				  .build();
				Response response1 = client1.newCall(request1).execute();
			
				  if (!response1.isSuccessful()) {
		            challanjsonMain cjm= new challanjsonMain();  
		            cjm.paymentstatusverify(response1.body().string());
		            //client1.connectionPool().evictAll();
		           // response1.close();
		                        
		             
		         }        	
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
	}// end of this
	
	}// end of Mainservlet main class
	

