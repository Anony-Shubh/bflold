package in.gov.uidai.auth.sampleapp;



	

	import in.gov.uidai.auth.aua.helper.AuthRequestCreator;
	import in.gov.uidai.auth.aua.helper.AuthResponseValidator;
	import in.gov.uidai.auth.aua.helper.AuthResponseValidator.ValidationResult;
	import in.gov.uidai.auth.aua.helper.BfdRequestCreator;
	import in.gov.uidai.auth.aua.helper.DigitalSigner;
	import in.gov.uidai.auth.aua.helper.OtpRequestCreator;
	import in.gov.uidai.auth.aua.helper.SignatureVerifier;
	import in.gov.uidai.auth.aua.httpclient.AuthClient;
	import in.gov.uidai.auth.aua.httpclient.BfdClient;
	import in.gov.uidai.auth.aua.httpclient.OtpClient;
	import in.gov.uidai.auth.client.biometrics.BiometricIntegrationAPI;
	import in.gov.uidai.auth.client.biometrics.CaptureDetails;
	import in.gov.uidai.auth.client.biometrics.CaptureHandler;
	import in.gov.uidai.auth.device.helper.AuthAUADataCreator;
	import in.gov.uidai.auth.device.helper.BfdAUADataCreator;
	import in.gov.uidai.auth.device.helper.Encrypter;
	import in.gov.uidai.auth.device.helper.PidCreator;
	import in.gov.uidai.auth.device.helper.RbdCreator;
	import in.gov.uidai.auth.device.model.AuthDataFromDeviceToAUA;
	import in.gov.uidai.auth.device.model.AuthResponseDetails;
	import in.gov.uidai.auth.device.model.BFDDataFromDeviceToAUA;
	import in.gov.uidai.auth.device.model.BfdResponseDetails;
	import in.gov.uidai.auth.device.model.DeviceCollectedAuthData;
	import in.gov.uidai.auth.device.model.DeviceCollectedBfdData;
	import in.gov.uidai.auth.device.model.OtpDataFromDeviceToAUA;
	import in.gov.uidai.authentication.common.types._1.FingerPosition;
	import in.gov.uidai.authentication.common.types._1.LocationType;
	import in.gov.uidai.authentication.common.types._1.Meta;
	import in.gov.uidai.authentication.otp._1.Otp;
	import in.gov.uidai.authentication.otp._1.OtpRes;
	import in.gov.uidai.authentication.otp._1.OtpResult;
	import in.gov.uidai.authentication.uid_auth_request._1.Auth;
	import in.gov.uidai.authentication.uid_auth_request._1.DataType;
	import in.gov.uidai.authentication.uid_auth_request._1.Tkn;
	import in.gov.uidai.authentication.uid_auth_request._1.Uses;
	import in.gov.uidai.authentication.uid_auth_request._1.UsesFlag;
	import in.gov.uidai.authentication.uid_auth_request_data._1.BioMetricType;
	import in.gov.uidai.authentication.uid_auth_request_data._1.BiometricPosition;
	import in.gov.uidai.authentication.uid_auth_request_data._1.MatchingStrategy;
	import in.gov.uidai.authentication.uid_auth_response._1.AuthRes;
	import in.gov.uidai.authentication.uid_auth_response._1.AuthResult;
	import in.gov.uidai.authentication.uid_bfd_request._1.Bfd;
	import in.gov.uidai.authentication.uid_bfd_response._1.BfdRes;
	import in.gov.uidai.authentication.uid_bfd_response._1.Rank;
	import in.gov.uidai.authentication.uid_bfd_response._1.Ranks;

	import java.io.File;
	import java.io.FileInputStream;
	import java.io.FileOutputStream;
	import java.io.IOException;
	import java.net.URISyntaxException;
	import java.net.URL;
	import java.util.ArrayList;
	import java.util.HashMap;
	import java.util.List;
	import java.util.Map;
	import java.util.Properties;
	import java.util.logging.Level;
	import java.util.logging.Logger;

	import org.apache.commons.io.FileUtils;
	import org.apache.commons.lang.StringUtils;

	import com.sun.jersey.api.client.Client;
	import com.sun.jersey.api.client.ClientResponse;
	import com.sun.jersey.api.client.WebResource;


	public class KvicUid {
	     
	   private AuthClient authClient;
		private AuthResponseValidator authResponseValidator;

		private AuthAUADataCreator auaDataCreator = null;
	   
	      public static Map<String, byte[]> skeyMap = new HashMap<String, byte[]>();
	      
	   private static Map<String, String> tokenLabelToTokenTypeMap = new HashMap<String, String>();
		static {
			tokenLabelToTokenTypeMap.put("Mobile", "001");
		}
		 String  outresponse=null;
	   
		String FDC="";
		String IDC="";
		String PIP="";
		String LocationValue="";
	   String Locationtype="";
	   String PidType="";

		String UDC="";
		//String AuthServerURL="http://auth.uidai.gov.in/1.6/";
	   String AuthServerURL="";
	    // String BFDURL="http://developer.uidai.gov.in/otp/1.6/";
	   String OTPServerUrl= "";
			String TerminalID="";
			String AuaCode="";
	    // String AuaCode="public";

			String subauacode="";
			//String aualicenceKey="MBFWjkJHNF-fLidl8oOHtUwgL5p1ZjDbWrqsMEVEJLVEDpnlNj_CZTg";
	      String aualicenceKey="";
			String Asalicencekey="";
	      
			String SignatureFile="";
			String password="ABC@123";
			char[] PasswordSignature=password.toCharArray();
			//String SignatureAlias="public";
	      String SignatureAlias="";
			//String PublicKeyFile="E:\\tomcat5\\webapps\\uidaitest\\uidaicertificate\\uidai_auth_sign_preprod.cer";
	       String PublicKeyFile="";
	  
			String DSIGPublicKey= "";

	      
	      		Boolean useSSK=true;
	      String uid ="784718538996" ;
	      String name ="Renuka Shivaji Sonune";
	      String gender="Female";
	     String address="";
	     String fulladdress="";
	           Boolean useProto=false;
	           Boolean usesPi=true;
	                                  public static void main (String[] args) {
	                                                                 
	                                  KvicUid sm = new KvicUid();
	                                   sm.loadPreferences(); 
	                                   sm.initializeAuthClient();                              
	                                   sm.authenticateRequest(sm.constructAuthRequest(), false);                  			              
			                               }
	                     
	               
	  public void initializeAuthClient() {
			try {
				 			authClient = new AuthClient(new URL(AuthServerURL).toURI());
	                			
	                System.out.println(authClient);
							DigitalSigner ds = new DigitalSigner(SignatureFile, PasswordSignature,SignatureAlias);
	               //	DigitalSigner ds = new DigitalSigner( PasswordSignature);

	              			
				authClient.setDigitalSignator(ds);
							
				authClient.setAsaLicenseKey(Asalicencekey);
			
				authResponseValidator = new AuthResponseValidator(new SignatureVerifier(DSIGPublicKey));
				
				auaDataCreator = new AuthAUADataCreator(new Encrypter(PublicKeyFile), false);
				//auaDataCreatorForBfd = new BfdAUADataCreator(new Encrypter(PublicKeyFile), false);
							} catch (Exception e) {
				e.printStackTrace();
			}
		}
	   
		

	      
	      public void loadPreferences() {
	      		FileInputStream is = null;
			try {
				File preferencesFile = new File("authclient.properties");
	            if (preferencesFile.exists()) {
					is = new FileInputStream(preferencesFile.getAbsolutePath());
	             System.out.println(preferencesFile.getAbsolutePath());

					Properties p = new Properties();
					p.load(is);

					if (p.get("authServerUrl") != null) {
						AuthServerURL=p.get("authServerUrl").toString();
						System.out.println("properties value"+AuthServerURL);
					}

					if (p.get("auaCode") != null) {
						AuaCode=p.get("auaCode").toString();
					}
					if (p.get("signKeyStore") != null) {
						SignatureFile=p.get("signKeyStore").toString();
					}

					if (p.get("sa") != null) {
						subauacode=p.get("sa").toString();
					}

					if (p.get("licenseKey") != null) {
						aualicenceKey=p.get("licenseKey").toString();
					}

					if (p.get("asaLicenseKey") != null) {
						Asalicencekey=p.get("asaLicenseKey").toString();
					}

					if (p.get("terminalId") != null) {
						TerminalID=p.get("terminalId").toString();
					}

					if (p.get("publicKeyFile") != null) {
						PublicKeyFile=p.get("publicKeyFile").toString();
					}

					if (p.get("publicKeyFileDSIG") != null) {
						DSIGPublicKey=p.get("publicKeyFileDSIG").toString();
					}
					if (p.get("usesPi") != null) {
					//	usesElement=p.get("usesPi").toString();
	               //Uses=Boolean.valueOf(p.get("usesPi").toString());
	                 usesPi=Boolean.valueOf(p.get("usesPi").toString());

					}

				
					if (p.get("signatureAlias") != null) {
						SignatureAlias=p.get("signatureAlias").toString();
					}

					if (p.get("signaturePassword") != null) {
						password=p.get("signaturePassword").toString();
					}

					if (p.get("udc") != null) {
						UDC=p.get("udc").toString();
					}

					if (p.get("fdc") != null) {
						FDC=p.get("fdc").toString();
					}

					if (p.get("idc") != null) {
						IDC=p.get("idc").toString();
					}
					
					if (p.get("pincode") != null) {
						LocationValue=p.get("pincode").toString();
					}

					if (p.get("lot") != null) {
						Locationtype=p.get("lot").toString();
					}
					
					if (p.get("lov") != null) {
						LocationValue=p.get("lov").toString();
					}
					
					if (p.get("publicIP") != null) {
						PIP=p.get("publicIP").toString();
					}
					
					if (p.get("useSSK") != null) {
						useSSK=true;
					}
					
					if (p.get("pidType") != null) {
						PidType=p.get("pidType").toString();
						System.out.println("pidtype value"+PidType);
					}
					
					
				//	if (p.get("bfdServerUrl") != null) {
				//		jTextFieldBFDURL.setText(p.get("bfdServerUrl").toString());
				//	}
					
				}

			} catch (IOException ex) {
				Logger.getLogger(KvicUid.class.getName()).log(Level.SEVERE, null, ex);
			} finally {
				try {
					if (is != null) {
						is.close();
					}
				} catch (IOException ex) {
					Logger.getLogger(KvicUid.class.getName()).log(Level.SEVERE, null, ex);
				}
			}
		}
	   
	   
	   
	  /* private void storePreferences() {
			FileOutputStream of = null;
			FileInputStream is = null;
			try {
				//jDialogPreferences.setVisible(false);

				Properties p = new Properties();

				File preferencesFile = new File("authclient.properties");
				if (preferencesFile.exists()) {
					is = new FileInputStream(preferencesFile);
					p.load(is);
				}
				is.close();
				is = null;

				p.put("authServerUrl",AuthServerURL);
				p.put("otpServerUrl", OTPServerUrl);
				p.put("bfdServerUrl", BFDURL);
				
				p.put("auaCode", Aua);

				p.put("sa", ServiceAgency);
				p.put("licenseKey",LicenseKey);
				p.put("asaLicenseKey", ASALicense);
				p.put("terminalId", TerminalID);
				p.put("publicKeyFile",PublicKeyFile);
				p.put("publicKeyFileDSIG",DSIGPublicKey);

				p.put("usesPi", String.valueOf());
			//	p.put("usesPa", String.valueOf(jCheckBoxPa.isSelected()));
			//	p.put("usesPfa", String.valueOf(jCheckBoxPfa.isSelected()));
			//	p.put("usesPin", String.valueOf(jCheckBoxPin.isSelected()));
			//	p.put("usesOtp", String.valueOf(jCheckBoxOtp.isSelected()));
			//	p.put("usesBio", String.valueOf(jCheckBoxBio.isSelected()));
			//	p.put("usesBioFMR", String.valueOf(jCheckBoxFMR.isSelected()));
			//	p.put("usesBioFIR", String.valueOf(jCheckBoxFIR.isSelected()));
			//	p.put("usesBioIIR", String.valueOf(jCheckBoxIIR.isSelected()));

				boolean signatureAttributeChanged = false;
				if (StringUtils.isNotBlank(SignatureFile)
						&& !SignatureFile).equals(p.get("signKeyStore").toString())) {
					signatureAttributeChanged = true;
				}
				p.put("signKeyStore",SignatureFile);

				if (StringUtils.isNotBlank(SignatureAlias)
						&& !SignatureAlias.equals(p.get("signatureAlias").toString())) {
					signatureAttributeChanged = true;
				}
				p.put("signatureAlias", SignatureAlias);

				if (StringUtils.isNotBlank(PasswordSignature)
						&& !PasswordSignature.equals(p.get("signaturePassword"))) {
					signatureAttributeChanged = true;
				}
				p.put("signaturePassword", new String(PasswordSignature.getPassword()));

				p.put("udc",UDC.getText());
				p.put("fdc",FDC.getText());
				p.put("idc",IDC.getText());

				p.put("lot",LocationType);
				p.put("lov", LocationValue);
				p.put("useSSK",UseSSK);
				p.put("pidType", PidType);
				p.put("publicIP",PIP);
				
				p.put("pincode", LocationValue);

				File f = new File("authclient.properties");
				of = new FileOutputStream(f);
				p.store(of, "Auth client preferences");

				initializeAuthClient();

				if (signatureAttributeChanged) {
					JOptionPane.showMessageDialog(this,
							"Signature related attributes changed. \nPlease RESTART the auth client for it to take effect.",
							"UID Authentication Demo Client", JOptionPane.ERROR_MESSAGE);
				}

			} catch (IOException ex) {
			//	Logger.getLogger(SampleClientMainFrame.class.getName()).log(Level.SEVERE, null, ex);
			} finally {
				try {
					if (is != null) {
						is.close();
					}

					if (of != null) {
						of.close();
					}
				} catch (IOException ex) {
					Logger.getLogger(SampleMain.class.getName()).log(Level.SEVERE, null, ex);
				}
			}
		}*/
	   
	   
	   	private Uses createUsesElement() {
			
			Uses uses = new Uses();
			uses.setPi(UsesFlag.Y);
			
			uses.setPa(UsesFlag.N);
			uses.setPin(UsesFlag.N);
			uses.setOtp(UsesFlag.N);
			uses.setBio(UsesFlag.N);
			uses.setPfa(UsesFlag.N);
			
			String biometricTypes = "";
			/*
			if (jCheckBoxFMR.isSelected()) {
				biometricTypes += "FMR";
			}
			
			if (jCheckBoxFIR.isSelected()) {
				if (StringUtils.isNotBlank(biometricTypes)) {
					biometricTypes += ",";
				}
				biometricTypes += "FIR";
			}
			
			if (jCheckBoxIIR.isSelected()) {
				if (StringUtils.isNotBlank(biometricTypes)) {
					biometricTypes += ",";
				}
				biometricTypes += "IIR";
			}*/

			return uses;
		}

	   DeviceCollectedAuthData constructAuthRequest() {
			
	      DeviceCollectedAuthData request = new DeviceCollectedAuthData();
	      
			//String uid ="999999990019" ;
			request.setUid(uid);
	      System.out.println("uid"+uid);


			//String name ="Shivshankar Choudhury";
	     // request.setName(name);
			//System.out.println("name"+name);
	           	
			
		//	String uid = "12344444444";
			//jFormattedTextFieldAADHAAR1.getText();
	//request.setUid(uid);
	
	//if (!jLanguageCombo.getSelectedItem().toString().equalsIgnoreCase("select")) {
		//String language = languageToCodeMap.get(jLanguageCombo.getSelectedItem().toString());
		//request.setLanguage(language);			 
	//} else {
		request.setLanguage(null);
	//}


	//String name = name;
			//jTextFieldName.getText().trim();
	if ((name != null) && (name.length() > 0)) {
		request.setName(name);
		System.out.println("name"+name);
	}
	String lname =""; 
			//jTextFieldNameLocal.getText().trim();
	if ((lname != null) && (lname.length() > 0)) {
		request.setLname(lname);
	}

	String pinCode =""; 
			//jTextFieldPincode.getText().trim();
	if ((pinCode != null) && (pinCode.length() > 0)) {
		request.setPinCode(pinCode);
	}
	String careOf = "";
			//jTextFieldCareOf.getText().trim();
	if ((careOf != null) && (careOf.length() > 0)) {
		request.setCareOf(careOf);
	}
	String building = "";
			//jTextFieldBuilding.getText().trim();
	if ((building != null) && (building.length() > 0)) {
		request.setBuilding(building);
	}
	String street ="";
			//jTextFieldStreet.getText().trim();
	if ((street != null) && (street.length() > 0)) {
		request.setStreet(street);
	}
	String landmark ="";
			//jTextFieldLandmark.getText().trim();
	if ((landmark != null) && (landmark.length() > 0)) {
		request.setLandmark(landmark);
	}
	String locality ="";
			//jTextFieldLocality.getText().trim();
	if ((locality != null) && (locality.length() > 0)) {
		request.setLocality(locality);
	}
	String village =""; 
			//jTextFieldVtc.getText().trim(); // ******
	if ((village != null) && (village.length() > 0)) {
		request.setVillage(village);
	}

	String poName =""; 
			//jTextFieldPOName.getText().trim();
	if ((poName != null) && (poName.length() > 0)) {
		request.setPoName(poName);
	}

	String subdistrict =""; 
			//jTextFieldSubdist.getText().trim();
	if ((subdistrict != null) && (subdistrict.length() > 0)) {
		request.setSubdistrict(subdistrict);
	}

	String district ="";
			//jTextFieldDistrict.getText().trim();
	if ((district != null) && (district.length() > 0)) {
		request.setDistrict(district);
	}
	String state ="";
			//(String) jTextFieldState.getText().trim();
	if ((state != null) && (state.trim().length() > 0)) {
		request.setState(state);
	}
	String phoneNo ="";
			//jTextFieldPhone.getText().trim();
	if ((phoneNo != null) && (phoneNo.length() > 0)) {
		request.setPhoneNo(phoneNo);
	}
	String email =""; 
			//jTextFieldEmail.getText().trim();
	if ((email != null) && (email.length() > 0)) {
		request.setEmail(email);
	}
	String staticPin =""; 
			//(new String(jPasswordFieldPIN.getPassword())).trim();
	if ((staticPin != null) && (staticPin.length() > 0)) {
		request.setStaticPin(staticPin);
	}
	String dynamicPin ="";
			//(new String(jPasswordFieldOTP.getPassword())).trim();
	if ((dynamicPin != null) && (dynamicPin.length() > 0)) {
		request.setDynamicPin(dynamicPin);
	}
		
	// Assemble gender
	//request.setGender((String) jComboGender.getSelectedItem());
	request.setGender((String) "Male");
	
	// Assemble DOB
	String day =""; 
			//jTextFieldDobDay.getText().trim();
	String month =""; 
			//jTextFieldDobMonth.getText().trim();
	String year ="";
			//jTextFieldDobYear.getText().trim();
	String dob = null;
	if ((year != null) && (year.length() > 0) && (month != null) && (month.length() > 0) && (day != null) && (day.length() > 0)) {
		dob = year + "-" + month + "-" + day;
	} else if ((year != null) && (year.length() > 0) && (month != null) && (month.length() > 0)) {
		dob = year + "-" + month + "-" + "";
	} else if ((year != null) && (year.length() > 0) && (day != null) && (day.length() > 0)) {
		dob = year + "-" + "" + "-" + day;
	} else if ((month != null) && (month.length() > 0) && (day != null) && (day.length() > 0)) {
		dob = "" + "-" + month + "-" + day;
	} else if ((month != null) && (month.length() > 0)) {
		dob = "" + "-" + month + "-" + "";
	} else if ((day != null) && (day.length() > 0)) {
		dob = "" + "-" + "" + "-" + day;
	} else if ((year != null) && (year.length() > 0)) {
		dob = year;
	}

	request.setDob(dob);

	//if (!"Select".equalsIgnoreCase(jComboBoxDOBType.getSelectedItem().toString())) {
		//request.setDobType(jComboBoxDOBType.getSelectedItem().toString());
	request.setDobType("Select");
	//}

	//if (StringUtils.isNotBlank(this.jTextFieldAge.getText())) {
		//request.setAge(jTextFieldAge.getText());
	request.setAge("");
	//}
//	request.setNameMatchValue((Integer) jSpinnerNameMatchValue.getValue());
	request.setNameMatchValue((Integer) 100);
	
	//request.setLocalNameMatchValue((Integer) jSpinnerNameMatchValueLocal.getValue());
	request.setLocalNameMatchValue((Integer) 100);

	//if (this.bioCaptures.size() > 0) {
	//	request.setBiometrics(this.bioCaptures);
	//}

	//request.setFullAddress(this.jTextAreaFullAddressValue.getText());
	request.setFullAddress("");
	
	//request.setLocalFullAddress(this.jTextAreaFullAddressValueLocal.getText());
	request.setLocalFullAddress("");
	
	//request.setFullAddressMatchValue((Integer) jSpinnerPfaMatchValue.getValue());
	request.setFullAddressMatchValue((Integer)100);
	
	//request.setLocalFullAddressMatchValue((Integer) jSpinnerPfaMatchValueLocal.getValue());
	request.setLocalFullAddressMatchValue((Integer) 100);

	// Name match strategy
	//if (jRadioButtonNameMatchExact.isSelected()) {
		request.setNameMatchStrategy(MatchingStrategy.E);
	/*} else {
		if (jRadioButtonNameMatchPartial.isSelected()) {
			request.setNameMatchStrategy(MatchingStrategy.P);
		} else {
			request.setNameMatchStrategy(MatchingStrategy.F);
		}
	}*/

	// Pa match strategy
	//request.setAddressMatchStrategy(jRadioButtonAddressExactMatch.isSelected() ? MatchingStrategy.E : MatchingStrategy.P);
		request.setAddressMatchStrategy( MatchingStrategy.E );

	// Pfa match strategy
	//if (jRadioButtonPfaExactMatch.isSelected()) {
		request.setFullAddressMatchStrategy(MatchingStrategy.E);
	/*} else {
		if (jRadioButtonPfaPartialMatch.isSelected()) {
			request.setFullAddressMatchStrategy(MatchingStrategy.P);
		} else {
			request.setFullAddressMatchStrategy(MatchingStrategy.F);
		}
	}*/

	
	Meta m = createMeta();
	request.setDeviceMetaData(m);
	
	return request;
		}

	   
		    
	  
		private Meta createMeta() {
			Meta m = new Meta();
			m.setFdc(FDC);
			m.setIdc(IDC);
			m.setPip(PIP);
			m.setLot(LocationType.P);
			m.setLov(LocationValue);
			m.setUdc(UDC);
			return m;
		}

		public void  authenticateRequest(DeviceCollectedAuthData authData, boolean useProto) {
			
			try {
	        // System.out.println("Signature Verification");

	         try {
					new URL(AuthServerURL).openConnection().connect();
	           // System.out.println("server connected");
				} catch (Exception e) {
					//JOptionPane.showMessageDialog(this, "Server not reachable.\nVerify the URL in Edit -> Preferences",
					//		"UID Authentication Demo Client" );
	            System.out.println("server not reachable");
					return;
				}

				//new URL(AuthServerURL).openConnection().connect();

				Uses usesElement = createUsesElement();

				AuthDataFromDeviceToAUA auaData = null;
				
				if (useProto) {
	            	  System.out.println("if UsePROTO is true");
		
	      }else
				{	auaData = auaDataCreator.prepareAUAData(uid, TerminalID,  authData.getDeviceMetaData(),(Object) PidCreator.createXmlPid(authData), DataType.X);
	          			}
	         
	         
	         String Tokenfield=null;
	         String Tokentype=null;
				Tkn token = null;
	            
				token = new Tkn();
				token.setValue(Tokenfield);
			   token.setType(Tokentype);
				
	         
	       			
				AuthRequestCreator authRequestCreator = new AuthRequestCreator();
				Auth auth = authRequestCreator.createAuthRequest(AuaCode, subauacode,aualicenceKey, usesElement , token, auaData, authData.getDeviceMetaData());

				AuthResponseDetails data = authClient.authenticate(auth);
				AuthRes authResult = data.getAuthRes();

				if (authResult != null) {
	           // System.out.println("useProto"+useProto);
					displayAuthResults(authResult, useProto);
				}

				fillAuthResponseValidationText(auth, auaData.getHashedDemoBytes(), authResult, data.getXml());

			} catch (Exception e) {
				//showMessageDialog(this, "Error: " + e.getMessage(), "UID Authentication Demo Client");
				System.out.println("error:"+ e.getMessage());
	         e.printStackTrace();
			}

		}
		
			private void fillAuthResponseValidationText(Auth auth, byte[] hashedDemoXML, AuthRes authResult, String responseXML) {
			ValidationResult result = this.authResponseValidator.validateAuthResponse(auth, hashedDemoXML, authResult, responseXML);
			//this.jTextAreaResponseValidationResult.setText(this.jTextAreaResponseValidationResult.getText() + "\n" + result.toString());
						System.out.println("RESULT IS"+result.toString());
			if (!result.isDigitalSignatureVerified()) {
				//showMessageDialog(this, "Signature Verification Failed", "UID Authentication Demo Client",JOptionPane.ERROR_MESSAGE);
				System.out.println("Signature Verification Failed");
				}
			}

//		System.out.println("useProto"+useProto);

		private void displayAuthResults(AuthRes authResult,Boolean useProto) {
				if (authResult.getRet().equals(AuthResult.Y)) {
				outresponse="success authentication";		
	         System.out.println("success authentication");

	        		} else {
								outresponse="failed";
	               System.out.println("AUTHENTICATION FAILED  "+ authResult.getErr() );

				//status.setText((useProto ? "Proto " : "XML") + " Error code: " + authResult.getErr() + " (" + ErrorCodeDescriptions.getDescription(authResult.getErr()) + ")");
				//status.setVisible(true);
			}
			
			//String origValue = StringUtils.isNotBlank(this.jLabelAuthRefCodeValue.getText()) ? this.jLabelAuthRefCodeValue.getText() + ", " : "";
			//this.jLabelAuthRefCodeValue.setText(origValue + authResult.getCode());

			outresponse=outresponse+"Authresult hell"+authResult.getCode();
			//his.jLabelAuthRefCodeValue.setVisible(true);
			//this.jLabelAuthRefCode.setVisible(true);
		}

	      	
}
