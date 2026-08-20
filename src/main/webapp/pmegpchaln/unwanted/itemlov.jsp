 
<%! 

public String sha512 (String apara)throws Exception{

 MessageDigest mda = MessageDigest.getInstance("SHA-512");
byte [] digesta = mda.digest(apara.getBytes());


StringBuffer sb = new StringBuffer();

for (int i = 0; i < digesta.length; i++)
{

sb.append(Integer.toString((digesta[i] & 0xff) + 0x100,16).substring(1));

}
   return sb.toString();
        
} // sha512

%>
<%@ page session="true" buffer="500kb" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon,org.apache.commons.codec.binary.*,java.io.FileInputStream,java.security.MessageDigest"  %>

<%
   String TXNID = request.getParameter("TXNID")==null?"":(String) request.getParameter("TXNID").trim();
   String APP_ID = request.getParameter("APP_ID")==null?"":(String) request.getParameter("APP_ID").trim();
   String MM_REL_AMT = request.getParameter("MM_REL_AMT")==null?"":(String) request.getParameter("MM_REL_AMT").trim();
   String APP_NAME = request.getParameter("APP_NAME")==null?"":(String) request.getParameter("APP_NAME").trim();
   String IFSC_CODE = request.getParameter("IFSC_CODE")==null?"":(String) request.getParameter("IFSC_CODE").trim();
   String BANKNAME = request.getParameter("BANKNAME")==null?"":(String) request.getParameter("BANKNAME").trim();
   String BRANCHNAME = request.getParameter("BRANCHNAME")==null?"":(String) request.getParameter("BRANCHNAME").trim();
 String PRODUCTINFO = request.getParameter("PRODUCTINFO")==null?"":(String) request.getParameter("PRODUCTINFO").trim();
 String MOBILE = request.getParameter("MOBILE")==null?"":(String) request.getParameter("MOBILE").trim();
 String EMAIL = request.getParameter("EMAIL")==null?"":(String) request.getParameter("EMAIL").trim();
 String UDF5=request.getParameter("UDF5")==null?"":(String) request.getParameter("UDF5").trim();
	  
  String hash=sha512("BHUZlo|"+TXNID+"|"+MM_REL_AMT+"|"+PRODUCTINFO+"|"+APP_NAME+"|"+EMAIL+"|"+APP_ID+"|"+BANKNAME+"|"+IFSC_CODE+"|"+BRANCHNAME+"|"+UDF5+"||||||MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCdZKRkWFJA/C8CtiveKRI8VIn+3G/mWLWawVzwQH7290C8digYXOZJmqNwHqnE2d+mmQq8qMfN1xcP1K+p/rUTimzrGem3QKrLNxfvd20wssSvNrmtk+AdJLNBzMYKf6OOO3tTZZydrNybgJdEvxwGSXWjjNW/CMeNyW1D1sCOed6VaVUi4YIqL9cy0lXqhT2+BRAJ/lDcDynR9rcuDA0Xl0C34QbbkKJMwWzbKMfRlcCtrvDO4ZSZ5zx606/s0W/TplvwW7MSf1wwMEYURWIGucfnYPIc4r3io+mpHRd55XZM4KsGXS/OIoawC+14pav1ZWlKUB8VB5MwAffoH/+VAgMBAAECggEAZyJLlnVJcMvPAjfdBvZivKWoxxgrOwVl+sI55DRe/fWGtfe2zkARpqlt70oodJVPuBsQrg7q3jbTJcx4TyxX+zX5qRSR0ULOp9qyFHhtVDvQJf/2K4d6k5442CUWoEqDIfBYH4210pwy8rKQbLvN4VDBhSoD5eoa2Q3kS0+tXa322xlEMQ6AMxz3/Fd9u/xz9rHUQ0B1/aD4EhnBjmdhcCFRACIbIeHt7QLOgjLteOIbAsmZpplA+tWwJt5KnjPlv1XuezkrjXpk/pYhOOxJV77XEjITjLXkq8GECDbQA0zRrcZ3mmIJOARuldrQAwX5AF8LcUoZ2NEljtMccpcgAQKBgQDJXYybGaz70o9U1d+N1AieTTVK8qZd/Htw4PrpOg7NabvkN3t8yZLAPdyyH27RigIz9U4mWIwBvEyL5l3uZloxw2dBRasj3NsOvcdNBL6Fwvzy0P7+iMPYzUx9tLGcnC5rMHxi7DT9msPdr4t94Hsw7uqSccRvjEP/wx1coilAtQKBgQDIGNzr9BwyBEgfBFfrc/5vchzFia0RaAY9Z+lf1fyU/94Gdcp6ySOPLeM65OwJ24NoQYHQR3xAuBSFG26X9eDmY9M+C72udF3NTEl/pcPj3vewXCVyQCFFaEkFRJHeelkQfAJjwd9+uxwLqLIwdzliME2/23gpaZrDTmpDG7BvYQKBgQCXE7r0ezUP0pB7I+OQM28r5d2AF8G+bjnnHMTjyw1kDFpOBVp+63VRCpjUg0TPrW2tsfQqTPDuNGpx5CrBPMWa5HJJxI18YK1xx+0J2e9fyEWjoC5QpifaN12WSsWfLIafIUeRqIqxYzZk0tojXRLQSdBwgy7QSjqSX79dysSMqQKBgQCpS+f3NwV4CAlhPNKKYwyeDEVtmMu2U3YcFEPvEuTuyAF5I8YZ1v5gEOoVlURkHrbyyaHkr+bf9x9dc1VB+wW6yDEdaN+mr8wBfA8fkgfIT4jvTTddkAbWa6KEc3ybaJbcjJ+U+Z534iWbc7K3sNf7THUr46uqFjCcGEdt2gqQYQKBgFVpmgw8cy4FwKqkb2naSjJpvHHl77TnqEuHE+n1owcH9tqkJUonTIZpo8A6DcPdAYVTnBMq+ky6MtCJy8ebzx7NzQbl1DuXvPiXoombUMfhvkkIqTdBdzV5N/rhy79pQRLBIvNDgkvhRXmwJiDx6KCIcW5U0hbZyoCE4cOEcjia");

  %>
 <input name="hash" id="hash" type="hidden" value="<%= hash %>" />
