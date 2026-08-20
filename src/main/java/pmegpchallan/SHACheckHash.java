

package pmegpchallan;

import org.apache.commons.codec.binary.*;
import java.io.FileInputStream;
import java.security.MessageDigest; 
public class SHACheckHash
{



public String sha512 (String apara)throws Exception{

 MessageDigest mda = MessageDigest.getInstance("SHA-512");
byte [] digesta = mda.digest(apara.getBytes());


StringBuffer sb = new StringBuffer();

for (int i = 0; i < digesta.length; i++)
{
sb.append(Integer.toString((digesta[i] & 0xff) + 0x100, 
16).substring(1));
}

      return sb.toString();
        
} // sha512

 }// class


