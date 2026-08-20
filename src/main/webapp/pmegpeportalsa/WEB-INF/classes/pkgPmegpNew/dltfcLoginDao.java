package pkgPmegpNew;

import javax.sql.ConnectionPoolDataSource;
import javax.sql.PooledConnection;
import javax.naming.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.sql.DataSource;
import java.io.*;

public class dltfcLoginDao {

public static String OFF_CD = "";
 public static  String OFF_NAME = "";
 public static String CITY = "";
  public static String AGENCY_TYPE = "";


public String getOFF_CD(String OFF_CD){
this.OFF_CD=OFF_CD;
return OFF_CD;
}

 public static boolean validate(String appId, String mobNo1) {
  boolean status = false;
  Connection conn = null;
  PreparedStatement pst = null;
  ResultSet rs = null;

  

  try {

   Context initContext = new InitialContext();
   Context envContext = (Context) initContext.lookup("java:comp/env");
   DataSource ds = (DataSource) envContext.lookup("jdbc/PMEGPDSNEW");
   conn = ds.getConnection();


   pst = conn.prepareStatement("select * from MAS_OFF_MAST where U_NAME=? and P_WORD=? AND CONV_DLTFCYN = 'Y' ");


   pst.setString(1, appId);
   pst.setString(2, mobNo1);

   rs = pst.executeQuery();
   status = rs.next();

   while (rs.next()) {

    OFF_CD = rs.getString("OFF_CD");
    OFF_NAME = rs.getString("OFF_NAME");
    CITY = rs.getString("CITY");
    AGENCY_TYPE = rs.getString("AGENCY_TYPE");

    


   }

  } catch (Exception e) {
   e.printStackTrace();
  } finally {
   if (conn != null) {
    try {
     conn.close();
    } catch (SQLException e) {
     e.printStackTrace();
    }
   }
   if (pst != null) {
    try {
     pst.close();
    } catch (SQLException e) {
     e.printStackTrace();
    }
   }
   if (rs != null) {
    try {
     rs.close();
    } catch (SQLException e) {
     e.printStackTrace();
    }
   }
  }
  return status;
 }
}//end of class