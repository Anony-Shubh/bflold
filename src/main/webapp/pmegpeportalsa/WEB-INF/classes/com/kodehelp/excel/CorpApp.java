package com.kodehelp.excel;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.*;
import java.util.Date;
import java.text.SimpleDateFormat;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
public class CorpApp {
public static void main(String[] args) throws Exception {
    try {
    	Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
        Connection con = null;        
        String connectionQuery="jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=E:\\myserver\\tomcat8\\webapps\\testkvic\\WEB-INF\\registration1.mdb;uid=; pwd=password here;";
        con = DriverManager.getConnection(connectionQuery); 
        System. out.println ("Database Connected.");
        con.setAutoCommit(false);  
		  Date dNow = new Date();
        SimpleDateFormat ft = new SimpleDateFormat ("ddMMyyyy"); 
        String DT=ft.format(dNow);
        FileInputStream input = new FileInputStream("C:\\Users\\test\\user\\SUCCESS_FAILED_NEW_MM_DISB_TRANSACTION_AS_ON_"+DT+".xls");
        POIFSFileSystem fs = new POIFSFileSystem(input);
        Workbook workbook;
        workbook = WorkbookFactory.create(fs);
        Sheet sheet = workbook.getSheetAt(0);
           Row row;       
            row = (Row) sheet.getRow(0);
            String SRNO1 = row.getCell(0).getStringCellValue(); 
           // System.out.println(SRNO1);
            String STATE1= row.getCell(1).getStringCellValue();   
           // System.out.println(STATE1);
            String APP_ID1=row.getCell(2).getStringCellValue();
            //System.out.println(APP_ID1);
            String APP_NAME1 = row.getCell(3).getStringCellValue();
           // System.out.println(APP_NAME1);
            String IFSC_CODE1 = row.getCell(4).getStringCellValue();
           // System.out.println(IFSC_CODE1);
            String TRANSAC1 =  row.getCell(5).getStringCellValue();
           // System.out.println(TRANSAC1);
            //String TOTAMSAN1 =   row.getCell(6).getStringCellValue();
           // System.out.println(TOTAMSAN1);
            String LOANSANDATE1= row.getCell(7).getStringCellValue(); 
            //System.out.println(LOANSANDATE1);
            String TOTAMDIS1=   row.getCell(8).getStringCellValue();
           //System.out.println(TOTAMDIS1);
            String LOANACCAPP1=  row.getCell(9).getStringCellValue();
            //System.out.println(LOANACCAPP1);
            String MMCLAIMFIELD1=  row.getCell(10).getStringCellValue();
            //System.out.println(MMCLAIMFIELD1);
            String MMCLAIMDATE1 =  row.getCell(11).getStringCellValue();   
            //System.out.println(MMCLAIMDATE1);
            String MMAUTHFIELD1=row.getCell(12).getStringCellValue();
           // System.out.println(MMAUTHFIELD1);
            String MMFINALAUTH1 =  row.getCell(13).getStringCellValue();
            //System.out.println(MMFINALAUTH1);
            String MMDISCORP1=  row.getCell(14).getStringCellValue();
            //System.out.println(MMDISCORP1);
            String MMDISCORPDATE1 = row.getCell(15).getStringCellValue(); 
            //System.out.println(MMDISCORPDATE1);
            String UTRNNO1= row.getCell(16).getStringCellValue();
            //System.out.println(UTRNNO1);
            String PAYMENTSTATUS1=row.getCell(17).getStringCellValue();
           // System.out.println(PAYMENTSTATUS1);
            String FAILEDREASON1 = row.getCell(18).getStringCellValue(); 
           // System.out.println(FAILEDREASON1);
           if ( (SRNO1.equals("S No.")) && (STATE1.equals("AGENCY_STATE"))&& (APP_ID1.equals("PMEGP_APPLICANTION_ID"))
            	&& (APP_NAME1.equals("APPLICANT_NAME"))
            	&& (IFSC_CODE1.equals("IFSC_CODE")) 
            	&& (TRANSAC1.equals("TRANSIENT_ACCNT_NO"))            	
            	//&& (TOTAMSAN1.equals("TOTAL_AMOUNT_SANCTIONED"))
            	&& (LOANSANDATE1.equals("LOAN_SANCTIONED_DATE") )
            	&& (TOTAMDIS1.equals("LOAN_AMOUNT_DISBURSED") )
            	&& (LOANACCAPP1.equals("LOAN_ACCOUNT_NUMBER") )
            	&& (MMCLAIMFIELD1.equals("MARGIN_MONEY_CLAIMED_AMOUNT") )
            	&& (MMCLAIMDATE1.equals("MM_CLAIM_DATE_BY_KVIC_LOCATION"))
            	&& (MMAUTHFIELD1.equals("AUTHORISED_KVIC_LOCATION") )
            	&& (MMFINALAUTH1.equals("AUTHORISED_DATE"))
            	&& (MMDISCORP1.equals("MM_AMOUNT_DISBURSED_CORP BANK"))
            	&& (MMDISCORPDATE1.equals("MM_DISBURSEMENT_DATE") )
            	&& (UTRNNO1.equals("TRANSACTION_REF_NUMBER") )
            	&& (PAYMENTSTATUS1.equals("TRANSACTION_STATUS") )
            	&& (FAILEDREASON1.equals("REASON")))	{
            
        	   Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
               Connection con1 = null;
               PreparedStatement pstm = null;
               String connectionQuery1="jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=E:\\myserver\\tomcat8\\webapps\\testkvic\\WEB-INF\\registration1.mdb;uid=; pwd=password here;";
               con1 = DriverManager.getConnection(connectionQuery1); 
               con1.setAutoCommit(false); 
        	   FileInputStream input1 = new FileInputStream("C:\\Users\\test\\user\\SUCCESS_FAILED_NEW_MM_DISB_TRANSACTION_AS_ON_"+DT+".xls");
               POIFSFileSystem fs1 = new POIFSFileSystem(input1);
               Workbook workbook1;
               workbook1 = WorkbookFactory.create(fs1);
               Sheet sheet1 = workbook1.getSheetAt(0);               
               for (int i = 1; i <= sheet1.getLastRowNum(); i++) {
               row = (Row) sheet1.getRow(i);	
               int ID =  (int) row.getCell(0).getNumericCellValue();
                     String AGN_STATE = row.getCell(1).getStringCellValue();           
                     String APP_ID=row.getCell(2).getStringCellValue();
                     String APP_NAME = row.getCell(3).getStringCellValue();
                     String IFSC_CODE = row.getCell(4).getStringCellValue();           
                     String TRANSAC =  row.getCell(5).getStringCellValue();
                     int TOTAMSAN =  (int) row.getCell(6).getNumericCellValue();
                     String LOANSANDATE= row.getCell(7).getStringCellValue();           
                     int TOTAMDIS=  (int) row.getCell(8).getNumericCellValue();
                     String LOANACCAPP=  row.getCell(9).getStringCellValue();
                     String MMCLAIMFIELD=  row.getCell(10).getStringCellValue();
                     String MMCLAIMDATE =  row.getCell(11).getStringCellValue(); 
                     String MMAUTHFIELD=row.getCell(12).getStringCellValue();
                     String MMFINALAUTH =  row.getCell(13).getStringCellValue();
                     int MMDISCORP=  (int) row.getCell(14).getNumericCellValue();
                     String MMDISCORPDATE = row.getCell(15).getStringCellValue(); 
                     String UTRNNO= row.getCell(16).getStringCellValue();
                     String PAYMENTSTATUS=row.getCell(17).getStringCellValue();
                     String FAILEDREASON = row.getCell(18).getStringCellValue();  
                     String sql = "INSERT INTO CORP_BANK (SRNO,STATE,APPID,NAME,IFSCCODE,"
                     		+ "TRANSAC,TOTAMSAN,LOANSANDATE,TOTAMDIS,LOANACCAPP,MMCLAIMFIELD,"
                     		+ "MMCLAIMDATE,MMAUTHFIELD,MMFINALAUTH,MMDISCORP,MMDISCORPDATE,"
                     		+ "UTRNNO,PAYMENTSTATUS,FAILEDREASON) "
                     		+ " VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                     pstm=con1.prepareStatement(sql);
                     pstm.setInt(1, ID);
                     pstm.setString(2, AGN_STATE);
                     pstm.setString(3, APP_ID);
                     pstm.setString(4,APP_NAME);   
                     pstm.setString(5,IFSC_CODE);   
                     pstm.setString(6, TRANSAC);
                     pstm.setInt(7, TOTAMSAN);
                     pstm.setString(8,LOANSANDATE);   
                     pstm.setInt(9,TOTAMDIS);
                     pstm.setString(10, LOANACCAPP);
                     pstm.setString(11, MMCLAIMFIELD);
                     pstm.setString(12, MMCLAIMDATE);
                     pstm.setString(13,MMAUTHFIELD); 
                     pstm.setString(14,MMFINALAUTH); 
                     pstm.setInt(15,MMDISCORP);
                     pstm.setString(16,MMDISCORPDATE);
                     pstm.setString(17, UTRNNO);
                     pstm.setString(18,PAYMENTSTATUS);
                     pstm.setString(19,FAILEDREASON);
                     pstm.executeUpdate();
                     System.out.println("Import rows " + i);      
                     }
                 con1.commit();
                 input1.close();
                 pstm.close(); 
                 con1.close(); 
        	   System.out.println("Successfully Imported");
				}				
           else{         
        System.out.println("Invalid Input File ");
               }
           input.close();
           con.close();
		   }
     catch (IOException e) {
    	 System.out.println(e);
}	    
}
}
