package in.gov.uidai.auth.sampleapp;

import in.gov.uidai.auth.sampleapp.NewUidMain;


	
		 class test {
			    public static void main (String[] args) {
			                   NewUidMain sm = new NewUidMain();
			                        String uid="531000598382";
			                             String name="Sidhartha panda";
			                            String gend="Male";
			                          String yr="1974";


			                    sm.validateuidaidata (uid,name,gend,yr);
			                    System.out.println("output"+sm.getSucessYN());
			                      
			                          
			                           }
			                           
			                           } 


