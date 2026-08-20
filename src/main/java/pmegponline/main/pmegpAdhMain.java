package pmegponline.main;

import in.cdac.authforward.AuthRequestForwarder;
import in.gov.uidai.authentication.uid_auth_request_data_v_2_5.Gender;
import in.gov.uidai.authentication.uid_auth_request_data_v_2_5.MatchingStrategy;
import in.gov.uidai.authentication.uid_auth_request_data_v_2_5.Pi;
import in.gov.uidai.authentication.uid_auth_request_data_v_2_5.Pv;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.xml.stream.XMLStreamException;

import in.cdac.auth.helper.AuthCredentials;
import in.gov.uidai.authentication.otp_v_2_5.*;
import in.gov.uidai.authentication.uid_auth_bfd_response_v_2_5.AuthRes;
import in.gov.uidai.kyc.common.types_v_2_1.GenderType;
import pmegp.util.*;
import pmegponline.main.ReadXmlDomParser.*;

public class pmegpAdhMain {

	public static void main(String[] args) throws IOException {
		



String path = new File(".").getCanonicalPath();

///System.out.print(path);
		
		pmegpAadharValidationModel pam=new pmegpAadharValidationModel("879903800447","RANI VISHWAKARMA","female","","1991-01-01");
		
		System.out.print(pam.getAadharName());
		
		if (pam.errlist().size()>0) {
			System.out.print(pam.errlist());	
			
		}else {
			System.out.print("Successfully Verified........");
          System.out.print(pam.getVret());		
		} 			
			
		
		
	}

}

