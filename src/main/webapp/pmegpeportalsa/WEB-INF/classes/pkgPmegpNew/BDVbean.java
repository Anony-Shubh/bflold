package pkgPmegpNew;
import java.io.*;

public class BDVbean {
  private String dt="";
  private String num="";
  
  public void setDt( String dt){
   this.dt=dt.trim();
  }

public void setNum( String num){
   this.num=num.trim();
  }

public String getVDate(){
String msg="";
dt=dt.toUpperCase();
try {
if (!(  ( dt.equals("") || dt.equals(null)  ) ) ){
int position1=dt.indexOf("-");
int position2=dt.lastIndexOf("-");
if (dt.length() !=11 && position1 !=2 && position2 !=6){
 msg="N";
}else{
 String vmon=dt.substring(position1+1,position2).toUpperCase();
if (!(  vmon.equals("JAN")|| vmon.equals("FEB")|| vmon.equals("MAR")|| vmon.equals("APR")|| vmon.equals("MAY")|| vmon.equals("JUN")|| vmon.equals("JUL")|| vmon.equals("AUG")|| vmon.equals("SEP")|| vmon.equals("OCT")|| vmon.equals("NOV")|| vmon.equals("DEC") )){
msg="N";
}
}
}//end of first if

}catch(Exception e){
msg="N";
}
return (msg);
}//end if getDt

public String getVNum(){
String msg1="";
num=(num.equals("")||num.equals(null))?"0": num.trim();
try{
int vown=Integer.parseInt(num);
}catch(Exception e){
msg1="N";
}
return(msg1);
}//end if num
}//end of class
