package pkgPmegpNew;

import javax.sql.*;
import java.sql.*;
import javax.sql.ConnectionPoolDataSource;
import javax.sql.PooledConnection;
import javax.naming.*;
import java.io.*;
import java.util.*;
import java.text.SimpleDateFormat;
import java.text.*;
import java.util.Date;
//import oracle.sql.*;
import java.sql.Connection;
//import java.sql.Date;


public class DBCon {

    private String cnt = "java:comp/env/jdbc/PMEGPDSNEW";
    private Connection dbCon;
    private ResultSet rs;
    private PreparedStatement pstmt;
    private Statement stmt;


    private String sqlValue;
    private List values;
    private List ptype;

    public DBCon() {
        super();
    }

    public void setSqlValue(String sqlValue) {
        this.sqlValue = sqlValue;
    }

    public void setValues(List values, List ptype) {
        this.values = values;
        this.ptype = ptype;
    }


    public boolean connect() throws NamingException, SQLException {
        Context ctx = new InitialContext();
        DataSource ds = (DataSource) ctx.lookup(cnt);
        dbCon = ds.getConnection();

        return true;

    }


    public void close() throws SQLException {
    if (rs !=null) { 
   try{ rs.close();}catch(SQLException e){}
 }
 
  if (stmt !=null) { 
   try{ stmt.close();}catch(SQLException e){}
 }

 
   if (pstmt !=null) { 
   try{ pstmt.close();}catch(SQLException e){}
 }
 
  if (dbCon !=null) { 
   try{ dbCon.close();}catch(SQLException e){}
 }


 
        
    }

    public ResultSet execSQL(String sql) throws SQLException {
         stmt=null;      
        stmt = dbCon.createStatement();
        rs=null;
        rs = stmt.executeQuery(sql);
        return (rs == null) ? null : rs;
           }


    private void setValues(PreparedStatement pstmt, List values, List ptype) throws SQLException {

        for (int i = 0; i < values.size(); i++) {

            String str = (String) values.get(i);
            String pstr = (String) ptype.get(i);
            String v;

            v = (String) values.get(i);
            pstmt.setString(i + 1, v);
        } //end for

    } //end method


    public ResultSet executeSQL(String sql, List values) throws SQLException {
    
        pstmt=null;  
        rs =null;
           
        pstmt = dbCon.prepareStatement(sql);

        for (int i = 0; i < values.size(); i++) {
            String str = (String) values.get(i);
            pstmt.setString(i + 1, str);
        } //end for

        rs = pstmt.executeQuery();
        return (rs == null) ? null : rs;
    }



    //update query
    public int executeUpdate() throws SQLException {
        int noOfRows = 0;
        pstmt = null;
        stmt = null;
            if (values != null && values.size() > 0) {
           pstmt=  dbCon.prepareStatement(sqlValue);
              setValues(pstmt, values, ptype);
                noOfRows = pstmt.executeUpdate();
                pstmt.close();
            } else {
                stmt = dbCon.createStatement();
                noOfRows = stmt.executeUpdate(sqlValue);
                stmt.close();
            }
               return noOfRows;
    }
}