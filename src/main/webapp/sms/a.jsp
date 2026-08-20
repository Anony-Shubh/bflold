
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.io.*"%>
<%@ page import="in.gov.mgov.SMSServices"%>
<%@ page import="java.net.*"%>


<%
/*
      String unknown = "unknown";
        String ipAddress = request.getHeader("X-Forwarded-For");
        if (ipAddress == null || ipAddress.length() == 0
                || unknown.equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getHeader("Proxy-Client-IP");
        }
		
        if (ipAddress == null || ipAddress.length() == 0
                || unknown.equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getHeader("WL-Proxy-Client-IP");
			
        }
        if (ipAddress == null || ipAddress.length() == 0
                || unknown.equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getHeader("HTTP_CLIENT_IP");
			
			
        }
        if (ipAddress == null || ipAddress.length() == 0
                || unknown.equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getHeader("HTTP_X_FORWARDED_FOR");
			
        }
		
        if (ipAddress == null || ipAddress.length() == 0
                || unknown.equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getRemoteAddr();
			
			
        }
    /*
	InetAddress localHost = InetAddress.getLocalHost();
NetworkInterface ni = NetworkInterface.getByInetAddress(localHost);
byte[] hardwareAddress = ni.getHardwareAddress();	

String[] hexadecimal = new String[hardwareAddress.length];
for (int i = 0; i < hardwareAddress.length; i++) {
    hexadecimal[i] = String.format("%02X", hardwareAddress[i]);
}
String macAddress = String.join("-", hexadecimal);
   
   out.print (macAddress);
  */
  
  /*
  try {
            // InetAddress address = InetAddress.getLocalHost();
            InetAddress address = InetAddress.getByName(ipAddress);
out.print (ipAddress);
            
            NetworkInterface ni = NetworkInterface.getByInetAddress(address);
            if (ni != null) {
                byte[] mac = ni.getHardwareAddress();
                if (mac != null) {
                   
                    for (int i = 0; i < mac.length; i++) {
                        System.out.format("%02X%s", mac[i], (i < mac.length - 1) ? "-" : "");
                    }
                } else {
                    out.println("Address doesn't exist or is not accessible.");
                }
            } else {
                out.println("Network Interface for the specified address is not found.");
            }
        } catch (UnknownHostException | SocketException e) {
            e.printStackTrace();
        }
  */

 //00-0C-29-64-26-E2
 /*
 String cmd = "ls -al";
Runtime run = Runtime.getRuntime();
Process pr = run.exec(cmd);
pr.waitFor();
BufferedReader buf = new BufferedReader(new InputStreamReader(pr.getInputStream()));
String line = "";
while ((line=buf.readLine())!=null) {
out.println(line);
}
*/

Enumeration paramNames = request.getParameterNames();
               while(paramNames.hasMoreElements()) {
                  String paramName = (String)paramNames.nextElement();
                  out.print("<tr><td>" + paramName + "</td>\n");
                  String paramValue = request.getHeader(paramName);
                  out.print("<td> " + paramValue + "</td></tr>\n");
				  
				out.print ("<br> IP: " + request.getRemoteAddr());
				
				out.print ("<br> URI " +request.getRequestURI());
				
				out.print ("<br> req session id: " +request.getRequestedSessionId());
				
				out.print ("<br> req getMethod()  " +request.getMethod()  );
				
				out.print ("<br> req status  " +response.getStatus()  );
				
				
				
				
               }
%>
<form id="form1" name="form1" method="post" action="">
Session ID: <%=session.getId()%>
<BR>
        Session creation time: <%=new Date(session.getCreationTime())%>
        <BR>
        Last accessed time: <%=new Date(session.getLastAccessedTime())%>
        <BR>
  abc
    <input type="text" name="textfield" />
<input name="aaaa" type="submit" value="aaaaa" />
</form>