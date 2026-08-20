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
  
public class printApplication {  
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
        
  
            pst = conn.prepareStatement("select * from APP_DETAIL where APP_ID=? and MOB_NO1=?"); 
             
            pst.setString(1, appId);  
            pst.setString(2,mobNo1 );  
  
            rs = pst.executeQuery();  
            status = rs.next();  
  
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
}  