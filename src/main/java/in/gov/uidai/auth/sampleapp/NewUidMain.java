



	/*******************************************************************************
	 * DISCLAIMER: The sample code or utility or tool described herein
	 *    is provided on an "as is" basis, without warranty of any kind.
	 *    UIDAI does not warrant or guarantee the individual success
	 *    developers may have in implementing the sample code on their
	 *    environment. 
	 *    
	 *    UIDAI does not warrant, guarantee or make any representations
	 *    of any kind with respect to the sample code and does not make
	 *    any representations or warranties regarding the use, results
	 *    of use, accuracy, timeliness or completeness of any data or
	 *    information relating to the sample code. UIDAI disclaims all
	 *    warranties, express or implied, and in particular, disclaims
	 *    all warranties of merchantability, fitness for a particular
	 *    purpose, and warranties related to the code, or any service
	 *    or software related thereto. 
	 *    
	 *    UIDAI is not responsible for and shall not be liable directly
	 *    or indirectly for any direct, indirect damages or costs of any
	 *    type arising out of use or any action taken by you or others
	 *    related to the sample code.
	 *    
	 *    THIS IS NOT A SUPPORTED SOFTWARE.
	 ******************************************************************************/
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

	import java.awt.Font;
	import java.awt.Image;
	import java.awt.Rectangle;
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
/*
	import javax.swing.ImageIcon;
	import javax.swing.InputVerifier;
	import javax.swing.JComponent;
	import javax.swing.JFileChooser;
	import javax.swing.JFormattedTextField;
	import javax.swing.JLabel;
	import javax.swing.JOptionPane;
	import javax.swing.JPasswordField;
	import javax.swing.UIManager;
	import javax.swing.filechooser.FileFilter;
	import javax.swing.filechooser.FileNameExtensionFilter;
*/
	import org.apache.commons.io.FileUtils;
	import org.apache.commons.lang.StringUtils;

	
public class NewUidMain   {
		String AuthServerURL="https://asa.epramaan.gov.in/ASA/1.6/aua/auth";
		String TerminalID="public";
		String Aua="";
		String ServiceAgency="";
		String Asalicencekey="";
		String SignatureFile="E:\\tomcat5\\webapps\\uidaitest\\uidaicertificate\\kviconlinegovinpubkey.cer";	
		String password="ABC@123";
		char[] PasswordSignature=password.toCharArray();	
         String SignatureAlias="";
         String ASALicense="";
       String  DSIGPublicKey="E:\\tomcat5\\webapps\\uidaitest\\uidaicertificate\\kviconlinegovinpubkey.cer";
       String PublicKeyFile="E:\\tomcat5\\webapps\\uidaitest\\uidaicertificate\\uidai_auth_encrypt_preprod.cer";
       Boolean UseSSK=true;
       Boolean usesPi=true; 
       Boolean usesPa=false; 
       Boolean usesPfa=false; 
       Boolean usesPin=false; 
       Boolean usesOtp=false; 
       Boolean usesBio=false;
       Boolean usesBioFMR=false;
       Boolean usesBioFIR=false;
       Boolean usesBioIIR=false;
       String UDC="";
       String FDC="";
       String IDC="";
       String LocationValue="";
       String Locationtype="P";
       String PIP="";
      String  PidType="X";
       String BFDURL="";
   public static  String uid = "";
	public static String name = "";
	public static	String gender="";
	public static	String vday="";
	public static	String vmonth="";
	public static	String vyear="";
   
   public static String vsuc="";

   
       
       
		private static Map<String, Font> languageToFontMap = new HashMap<String, Font>();
		public static Map<String, byte[]> skeyMap = new HashMap<String, byte[]>();

		static {
			languageToFontMap.put("English", Font.decode("tahoma-plain-10"));
			languageToFontMap.put("Hindi", Font.decode("mangal-plain-10"));
			languageToFontMap.put("Kannada", Font.decode("tunga-plain-10"));
			languageToFontMap.put("Malayalam", Font.decode("kartika-plain-10"));
		}

		private static Map<String, String> languageToCodeMap = new HashMap<String, String>();
		static {
			languageToCodeMap.put("English", "23");
			languageToCodeMap.put("Hindi", "06");
			languageToCodeMap.put("Kannada", "07");
			languageToCodeMap.put("Malayalam", "11");
		}
		

	
		private static Map<String, String> tokenLabelToTokenTypeMap = new HashMap<String, String>();
		static {
			tokenLabelToTokenTypeMap.put("Mobile", "001");
		}

		private List<DeviceCollectedAuthData.BiometricData> bioCaptures = new ArrayList<DeviceCollectedAuthData.BiometricData>();
	    private Map<FingerPosition, CaptureDetails> bfdCaptures = new HashMap<FingerPosition, CaptureDetails>();

		private AuthClient authClient;
		private BfdClient bfdClient;
		private OtpClient otpClient;
		private AuthResponseValidator authResponseValidator;

		private AuthAUADataCreator auaDataCreator = null;
		private BfdAUADataCreator auaDataCreatorForBfd = null;
      
    
      
		/**
		 * Name of the class that provides biometric integration API implementation.
		 */
		private String biometricAPIImplementationClass = "in.gov.uidai.auth.sampleapp.DigitalPersonaImpl";

		
		
		/* public static void main (String[] args) {
             validateuidaidata ("531000598382","Sidhartha panda", "Male", "1974");

                             }
    */                       
                  
           public  void  validateuidaidata (String vuid,String vname,String vgender,String vyear){
                  uid=vuid;
                  name=vname;
                  gender=vgender;
                  this.vyear=vyear;
                  
                  NewUidMain sm = new NewUidMain();
                  sm.loadPreferences();
                  sm.initializeAuthClient();
                  sm.authenticateRequest(sm.constructAuthRequest(), false);
                  
                 String tr=sm.getSucessYN();           
                  
                 System.out.println("in main\n"+tr);
                    }
                                                     
		 
		/** Creates new form Test */
		
  public NewUidMain() {
		super();
				}
	
		private void initializeAuthClient() {
			try {
				
				authClient = new AuthClient(new URL(AuthServerURL).toURI());
				
				DigitalSigner ds = new DigitalSigner(SignatureFile, PasswordSignature,
								SignatureAlias);
				
				
				authClient.setDigitalSignator(ds);
				//bfdClient.setDigitalSignator(ds);
		
				authClient.setAsaLicenseKey(Asalicencekey);
				
				authResponseValidator = new AuthResponseValidator(new SignatureVerifier(DSIGPublicKey));
				
				auaDataCreator = new AuthAUADataCreator(new Encrypter(PublicKeyFile),UseSSK);
								
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		
	     		private void loadPreferences() {
			FileInputStream is = null;
			try {
				File preferencesFile = new File("authclient.properties");
				if (preferencesFile.exists()) {
					is = new FileInputStream(preferencesFile);
					Properties p = new Properties();
					p.load(is);

					if (p.get("authServerUrl") != null) {
						//jTextFieldAuthServerURL.setText(p.get("authServerUrl").toString());
						AuthServerURL=p.get("authServerUrl").toString();
					}

			
					if (p.get("auaCode") != null) {
						//jTextFieldAua.setText(p.get("auaCode").toString());
						Aua=p.get("auaCode").toString();
					}
					if (p.get("signKeyStore") != null) {
						//jTextFieldSignatureFile.setText(p.get("signKeyStore").toString());
						SignatureFile=p.get("signKeyStore").toString();
					}

					if (p.get("sa") != null) {
						//jTextFieldServiceAgency.setText(p.get("sa").toString());
						ServiceAgency=p.get("sa").toString();
					}

					if (p.get("licenseKey") != null) {
						//jTextFieldLicenseKey.setText(p.get("licenseKey").toString());
						Asalicencekey=p.get("licenseKey").toString();
					}

					if (p.get("asaLicenseKey") != null) {
						//jTextFieldASALicense.setText(p.get("asaLicenseKey").toString());
						ASALicense=p.get("asaLicenseKey").toString();
					}

					if (p.get("terminalId") != null) {
						//jTextFieldTerminalID.setText(p.get("terminalId").toString());
						TerminalID=p.get("terminalId").toString();
					}

					if (p.get("publicKeyFile") != null) {
						//jTextFieldPublicKeyFile.setText(p.get("publicKeyFile").toString());
						PublicKeyFile=p.get("publicKeyFile").toString();
					}

					if (p.get("publicKeyFileDSIG") != null && !StringUtils.isEmpty(p.get("publicKeyFileDSIG").toString())) {
						//jTextFieldDSIGPublicKey.setText(p.get("publicKeyFileDSIG").toString());
						DSIGPublicKey=p.get("publicKeyFileDSIG").toString();
					}
					//else {
					//	jTextFieldDSIGPublicKey.setText(p.get("publicKeyFile").toString());
				//	}

					if (p.get("usesPi") != null) {
						//jCheckBoxPi.setSelected(Boolean.valueOf(p.get("usesPi").toString()));
					
						usesPi=Boolean.valueOf(p.get("usesPi").toString());
					}

					if (p.get("usesPa") != null) {
						//jCheckBoxPa.setSelected(Boolean.valueOf(p.get("usesPa").toString()));
						usesPa=Boolean.valueOf(p.get("usesPa").toString());
					}

					if (p.get("usesPfa") != null) {
						//jCheckBoxPfa.setSelected(Boolean.valueOf(p.get("usesPfa").toString()));
						usesPfa=Boolean.valueOf(p.get("usesPfa").toString());
					}

					if (p.get("usesPin") != null) {
						//jCheckBoxPin.setSelected(Boolean.valueOf(p.get("usesPin").toString()));
						usesPin=Boolean.valueOf(p.get("usesPin").toString());
					}

					if (p.get("usesOtp") != null) {
						//jCheckBoxOtp.setSelected(Boolean.valueOf(p.get("usesOtp").toString()));
						usesOtp=Boolean.valueOf(p.get("usesOtp").toString());
					}

					if (p.get("usesBio") != null) {
					//	jCheckBoxBio.setSelected(Boolean.valueOf(p.get("usesBio").toString()));
						usesBio=Boolean.valueOf(p.get("usesBio").toString());
					}

					if (p.get("usesBioFMR") != null) {
						//jCheckBoxFMR.setSelected(Boolean.valueOf(p.get("usesBioFMR").toString()));
						usesBioFMR=Boolean.valueOf(p.get("usesBioFMR").toString());
					}

					if (p.get("usesBioFIR") != null) {
						//jCheckBoxFIR.setSelected(Boolean.valueOf(p.get("usesBioFIR").toString()));
						usesBioFIR=Boolean.valueOf(p.get("usesBioFIR").toString());
					}

					if (p.get("usesBioIIR") != null) {
						//jCheckBoxIIR.setSelected(Boolean.valueOf(p.get("usesBioIIR").toString()));
						usesBioIIR=Boolean.valueOf(p.get("usesBioIIR").toString());
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
						UseSSK=Boolean.valueOf(p.get("useSSK").toString());
					}
					
					if (p.get("pidType") != null) {
						PidType=p.get("pidType").toString();
					}
					
					
					if (p.get("bfdServerUrl") != null) {
						BFDURL=p.get("bfdServerUrl").toString();
					}
					
				}

			} catch (IOException ex) {
				Logger.getLogger(NewUidMain.class.getName()).log(Level.SEVERE, null, ex);
			} finally {
				try {
					if (is != null) {
						is.close();
					}
				} catch (IOException ex) {
					Logger.getLogger(NewUidMain.class.getName()).log(Level.SEVERE, null, ex);
				}
			}
		}
      
      
      
      
      		public DeviceCollectedAuthData constructAuthRequest() {
			DeviceCollectedAuthData request = new DeviceCollectedAuthData();

			
					//jFormattedTextFieldAADHAAR1.getText();
			request.setUid(uid);
			request.setLanguage(null);
			//}

				
					//jTextFieldName.getText().trim();
			if ((name != null) && (name.length() > 0)) {
				request.setName(name);
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
			request.setGender(gender);
			
			// Assemble DOB
			String day =vday; 
					//jTextFieldDobDay.getText().trim();
			String month =vmonth; 
					//jTextFieldDobMonth.getText().trim();
			String year =vyear;
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
			String DobType="";
			//}
			//if (!"Select".equalsIgnoreCase(jComboBoxDOBType.getSelectedItem().toString())) {
				//request.setDobType(jComboBoxDOBType.getSelectedItem().toString());
			request.setDobType(DobType);
			//}

			//if (StringUtils.isNotBlank(this.jTextFieldAge.getText())) {
				//request.setAge(jTextFieldAge.getText());
			request.setAge(null);
			//}
		//	request.setNameMatchValue((Integer) jSpinnerNameMatchValue.getValue());
			request.setNameMatchValue((Integer) 100);
			
			//request.setLocalNameMatchValue((Integer) jSpinnerNameMatchValueLocal.getValue());
			request.setLocalNameMatchValue((Integer) 100);

			if (this.bioCaptures.size() > 0) {
				request.setBiometrics(this.bioCaptures);
			}
			
			String faddress=""; 
			//request.setFullAddress(this.jTextAreaFullAddressValue.getText());
			request.setFullAddress(faddress);
			
			String localaddress="";
			//request.setLocalFullAddress(this.jTextAreaFullAddressValueLocal.getText());
			request.setLocalFullAddress(localaddress="");
			
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
			//m.setFdc(this.jTextFieldFDC.getText());
			m.setFdc(FDC);
			//m.setIdc(this.jTextFieldIDC.getText());
			m.setIdc(IDC);
			//m.setPip(this.jTextFieldPIP.getText());
			m.setPip(PIP);
			//m.setLot(LocationType.valueOf(this.jComboBoxLocationType.getSelectedItem().toString()));
			m.setLot(LocationType.P);
			//m.setLov(this.jTextFieldLocationValue.getText());
			m.setLov(LocationValue);
		
			//m.setUdc(this.jTextFieldUDC.getText());
			m.setUdc(UDC);
			return m;
		}

		private void authenticateRequest(DeviceCollectedAuthData authData, boolean useProto) {
			try {

				//this.repaint();

				try {
					new URL(AuthServerURL).openConnection().connect();
				} catch (Exception e) {
				//	JOptionPane.showMessageDialog(this, "Server not reachable.\nVerify the URL in Edit -> Preferences",
				//			"UID Authentication Demo Client", JOptionPane.ERROR_MESSAGE);
					System.out.println("Server not reachable.");
					return;
				}

		
				Uses usesElement = createUsesElement();

				AuthDataFromDeviceToAUA auaData = null;
				if (useProto) {
					//auaData = auaDataCreator.prepareAUAData(authData.getUid(), this.jTextFieldTerminalID.getText(), authData.getDeviceMetaData(),
					//		(Object) PidCreator.createProtoPid(authData), DataType.P);
				} else {
					auaData = auaDataCreator.prepareAUAData(authData.getUid(), TerminalID,  authData.getDeviceMetaData(),
							(Object) PidCreator.createXmlPid(authData), DataType.X);
				}

				Tkn token = null;
				String vtoken="";
				if (StringUtils.isNotBlank(vtoken)) {
					token = new Tkn();
					token.setValue(vtoken);
					token.setType(vtoken);
				}
				
				
				AuthRequestCreator authRequestCreator = new AuthRequestCreator();
				Auth auth = authRequestCreator.createAuthRequest(Aua,ServiceAgency,
						Asalicencekey, usesElement, token, auaData, authData.getDeviceMetaData());

				AuthResponseDetails data = authClient.authenticate(auth);
				AuthRes authResult = data.getAuthRes();

				if (authResult != null) {
					displayAuthResults(authResult, useProto);
				}

				fillAuthResponseValidationText(auth, auaData.getHashedDemoBytes(), authResult, data.getXml());
				//	System.out.println("XML"data.getXml());
			} catch (Exception e) {
			//	JOptionPane.showMessageDialog(this, "Error: " + e.getMessage(), "UID Authentication Demo Client", JOptionPane.ERROR_MESSAGE);
				System.out.println("Error"+ e.getMessage());
				e.printStackTrace();
			}

		}

		private Uses createUsesElement() {
			
			Uses uses = new Uses();
		
			uses.setPi(UsesFlag.Y);
			uses.setPa(UsesFlag.N);
			uses.setPin(UsesFlag.N);
			uses.setOtp(UsesFlag.N);
			uses.setBio(UsesFlag.N);
			uses.setPfa(UsesFlag.N);
			
			String biometricTypes = "";
			
			

			return uses;
		}

		
		public void displayAuthResults(AuthRes authResult, boolean useProto) {
		//	javax.swing.JLabel status = (useProto ? this.jLabelAuthStatusTextProto : this.jLabelAuthStatusTextXML);
		//	javax.swing.JLabel statusLabel = (useProto ?  this.jLabelAuthStatusProto : this.jLabelAuthStatus);

		//	statusLabel.setText(useProto ? "Proto " : "XML");
			
			if (authResult.getRet().equals(AuthResult.Y)) {
		
				System.out.println("\nSUCCESS");
            vsuc="S";
		     			} else {
		     vsuc="F";
                      System.out.println("failed");
        //  String  verrcode=e.getMessage();
					}
		}
      
            
      public String getSucessYN(){
      return (vsuc);
      }
				
		private void fillAuthResponseValidationText(Auth auth, byte[] hashedDemoXML, AuthRes authResult, String responseXML) {
			ValidationResult result = this.authResponseValidator.validateAuthResponse(auth, hashedDemoXML, authResult, responseXML);
				
			System.out.println("Authentication result"+result.toString());
         
			if (!result.isDigitalSignatureVerified()) {
						System.out.println("Signature Verification Failed");
			}
		}

		
}

