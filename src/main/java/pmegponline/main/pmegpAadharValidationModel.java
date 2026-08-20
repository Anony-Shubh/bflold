package pmegponline.main;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.xml.stream.XMLStreamException;

import in.cdac.auth.helper.AuthCredentials;
import in.cdac.authforward.AuthRequestForwarder;
import in.gov.uidai.authentication.uid_auth_request_data_v_2_5.Gender;
import in.gov.uidai.authentication.uid_auth_request_data_v_2_5.Pi;
import pmegp.util.VerhoeffAlgorithm;

public class pmegpAadharValidationModel {
	
	String aadharNo;
	String aadharName;
	String gender;
	String txn_gen;
	String dob;
	String mobno;
	
	public String getDob() {
		return dob;
	}
	public String getMobno() {
		return mobno;
	}
	public void setDob(String dob) {
		this.dob = dob;
	}
	public void setMobno(String mobno) {
		this.mobno = mobno;
	}

	public  String vret="";
	public  String vcode="";
	 public String vtxn="";
	public  String vinfo="";
	 public String vts="";
	 public String verr="";
	 
	public String  reslt="";
	
	public String getReslt() {
		return reslt;
	}
	public void setTxn_gen(String txn_gen) {
		this.txn_gen = txn_gen;
	}
	public void setVret(String vret) {
		this.vret = vret;
	}
	public void setVcode(String vcode) {
		this.vcode = vcode;
	}
	public void setVtxn(String vtxn) {
		this.vtxn = vtxn;
	}
	public void setVinfo(String vinfo) {
		this.vinfo = vinfo;
	}
	public void setVts(String vts) {
		this.vts = vts;
	}
	public void setVerr(String verr) {
		this.verr = verr;
	}
	public void setReslt(String reslt) {
		this.reslt = reslt;
	}
	public String getTxn_gen() {
		return txn_gen;
	}
	public String getVret() {
		return vret;
	}
	public String getVcode() {
		return vcode;
	}
	public String getVtxn() {
		return vtxn;
	}
	public String getVinfo() {
		return vinfo;
	}
	public String getVts() {
		return vts;
	}
	public String getVerr() {
		return verr;
	}

	
	public String getAadharNo() {
		return aadharNo;
	}
	/**
	 * @return the aadharName
	 */
	public String getAadharName() {
		return aadharName;
	}
	/**
	 * @return the gender
	 */
	public String getGender() {
		return gender;
	}
	/**
	 * @param aadharNo the aadharNo to set
	 */
	public void setAadharNo(String aadharNo) {
		this.aadharNo = aadharNo;
	}
	/**
	 * @param aadharName the aadharName to set
	 */
	public void setAadharName(String aadharName) {
		this.aadharName = aadharName;
	}
	/**
	 * @param gender the gender to set
	 */
	public void setGender(String gender) {
		this.gender = gender;
	}
	
	public pmegpAadharValidationModel(String aadharNo1, String aadharName1, String gender1,String Mobno1,String dob1) {
		super();
		this.aadharNo = aadharNo1;
		this.aadharName = aadharName1;
		this.gender = gender1;
		this.mobno=Mobno1;
		this.dob=dob1;
	}
	
	
	
	
	
	
	public ArrayList<String> errlist () {
		ArrayList<String> verrlist = new ArrayList<String>();
		VerhoeffAlgorithm vaf=new VerhoeffAlgorithm();
		
		if (vaf.validateAadharNumber(aadharNo)==false) {
			verrlist.add("Invalid Aadhar No !");	
		}
		
		if (vaf.validateAadharName(aadharName)==false) {
			verrlist.add("Invalid Aadhar Name !");	
		}
		
		if (gender.equals("")) {
			verrlist.add("Invalid Gender !");
		}
		
		if (vaf.validateMobNo(mobno)  ==false) {
			if( mobno.length()>0) {
			verrlist.add("Invalid Mobile No !");
			}
		}
		
		if (vaf.validateDOB(dob)==false) {
			if (dob.length()>0) {
			verrlist.add("Invalid Date of Birth");
			}
		}
		
		
		
		
		if (verrlist.size()==0) {
			
			AuthRequestForwarder aud=new AuthRequestForwarder();
			AuthCredentials ac =new AuthCredentials();
			int max =900;
			int min=800;
			int random_int = (int)Math.floor(Math.random()*(max-min+1)+min);
			SimpleDateFormat sdf = new SimpleDateFormat("ddMMyyyyHHmmssSSS");
			String date = sdf.format(new Date()); 
			txn_gen="KVPM"+date+""+random_int;
			ac.setUid(aadharNo);
			ac.setAc("TCS1002010");
			ac.setTxn(txn_gen);
			//ac.setSubAuaCode("SKVIC16038");
			ac.setSubAuaCode("PKVIC16038");
			ac.setTerminalId("");
			String path=null;
			try {
				 path = new File(".").getCanonicalPath();
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			ac.setEncryptionCertificate(path+"\\uidaicert\\uidai_auth_prod-30-12-2019.cer");
			ac.setVersion("2.5");
			//ac.setLicenseKey("8B6BA11F1C0AD881E72C8FE681821C5C61C4AB89DHWFCHEIPL");
			ac.setLicenseKey("8b08bac56d5a317eaf18a89a3f55032a9a65eff7");
			//ac.setEnvironment("PreSecondary");
			ac.setEnvironment("ProdSecondary");
			
			Pi pi= new Pi();
			pi.setName(aadharName);
			gender=gender.toUpperCase();
			gender=gender.trim();
			if (mobno.length()>0) {
			pi.setPhone(mobno);
			}
			if (dob.length()>0) {
			pi.setDob(dob);
			}
			
			switch (gender) {
			case "WOMEN":
				pi.setGender(Gender.F);
				
				 break;
			case "FEMALE":
				pi.setGender(Gender.F);
				
				 break;
			case "MALE":
				pi.setGender(Gender.M);
				break;
			case "TRANSGENDER":
				pi.setGender(Gender.T);
				break;
			default:	
				pi.setGender(Gender.T);
				break;
			}
			
			pi.setAge(18);
			reslt=aud.demoAuthUsingPi2_5(ac, pi);
			try {
				
				ReadXmlDomParser xmlparser= new ReadXmlDomParser();
				
				xmlparser.parser(reslt);
				
				
				
				vret=xmlparser.getret();
				vcode=xmlparser.getcode();
				vtxn=xmlparser.gettxn();
				vinfo=xmlparser.getinfo();
				vts=xmlparser.getts();
				verr=xmlparser.geterr();
				
				
				vret=vret.toUpperCase();
				
				if (vret.equals("N")) {
				verrlist.add("Data Mismatch: Re-enter AadharNumber/Name/Gender/dob/Mobile No Exactly As per Aadhar Card...!("+xmlparser.geterr()+")");	
				}
				
				
			} catch (FileNotFoundException | XMLStreamException e) {
				verrlist.add("UIDAI Server failed to Verify Try Later!");
				System.out.print(e.toString()+reslt);
				
			}
			
			
			
		}
		
		return verrlist;
		
	
	
	}

}
