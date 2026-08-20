import java.io.FileInputStream;
import java.security.MessageDigest; 
public class SHACheckSumExample
{
public static void main(String[] args)throws Exception
{
MessageDigest md = MessageDigest.getInstance("SHA-512"); 
FileInputStream fis = new
FileInputStream("d:\\loging.log"); 

byte[] dataBytes = new
byte[1024]; int nread = 0;
while ((nread =
fis.read(dataBytes)) != -1) {
md.update(dataBytes, 0, nread); 
};
byte[] mdbytes = md.digest();

StringBuffer sb = new StringBuffer();
for (int i = 0; i < mdbytes.length; i++)
{
sb.append(Integer.toString((mdbytes[i] & 0xff) + 0x100, 16).substring(1));
}
System.out.println("Hex format : " + sb.toString());

StringBuffer hexString = new StringBuffer();
for (int i=0;i<mdbytes.length;i++)
hexString.append(Integer.toHexString(0xFF & mdbytes[i]));
System.out.println(hexString.toString()); 
}

 }
