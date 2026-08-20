
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


public class DBCon 
{
  
  private String cnt="java:comp/env/jdbc/PMEGPDSNEW";
  private Connection dbCon;
  private String sqlValue;
  private List values;
  private List ptype;
  
  public DBCon(){
   super();
  }

  public void setSqlValue(String sqlValue)
  {
    this.sqlValue=sqlValue;
  }

   public void setValues(List values,List ptype)
  {
  this.values=values;
  this.ptype=ptype;
  }


   public boolean connect() throws NamingException,SQLException
  {
 Context ctx=new InitialContext();
    DataSource ds=(DataSource) ctx.lookup(cnt);
   dbCon=ds.getConnection();
 
  return true;
  
  }


  public void close()throws SQLException 
 {
  dbCon.close();
 }
  
  public ResultSet execSQL(String sql) throws SQLException
 {
 Statement s=dbCon.createStatement();
 ResultSet r=s.executeQuery(sql);
 return(r==null)?null:r;
 }


private void setValues(PreparedStatement pstmt,List values,List ptype) throws SQLException
 {

  for (int i=0;i<values.size();i++)
    {

  String str=  (String)values.get(i);
  String pstr=(String) ptype.get(i);
  String v;

  v=(String)values.get(i);
  pstmt.setString(i+1,v);
    }//end for

 }//end method


 public ResultSet executeSQL(String sql,List values) throws SQLException{
   
		 PreparedStatement pstmt=dbCon.prepareStatement(sql);
	
		// 	for (int i=0;i<values.size();i++){
		// 	String str=  (String)values.get(i);
		// 	pstmt.setString(i+1,str);
		// 	 }//end for
			 
		// 	ResultSet r=pstmt.executeQuery();
		// 	return(r==null)?null:r;
    for (int i = 0; i < values.size(); i++) {
        Object value = values.get(i);
        // Handle different parameter types safely
        if (value == null) {
            pstmt.setNull(i + 1, Types.VARCHAR);
        } else if (value instanceof String) {
            pstmt.setString(i + 1, (String) value);
        } else if (value instanceof Integer) {
            pstmt.setInt(i + 1, (Integer) value);
        } else if (value instanceof Long) {
            pstmt.setLong(i + 1, (Long) value);
        } else if (value instanceof Date) {
            pstmt.setDate(i + 1, new java.sql.Date(((Date) value).getTime()));
        } else if (value instanceof Timestamp) {
            pstmt.setTimestamp(i + 1, (Timestamp) value);
        } else {
            // Fallback to string representation
            pstmt.setString(i + 1, value.toString());
        }
    }
    
    return pstmt.executeQuery();
}



//update query
public int executeUpdate() throws SQLException
 {
int noOfRows =0;
ResultSet rs=null;
PreparedStatement pstmt=null;
Statement stmt=null;
try
   {

if (values !=null && values.size()>0)
       {
pstmt=dbCon.prepareStatement(sqlValue);
setValues(pstmt,values,ptype);
noOfRows = pstmt.executeUpdate();
        }else
             {
			stmt=dbCon.createStatement();
			noOfRows=stmt.executeUpdate(sqlValue);
             }
	 }
       finally {
          if (rs!=null){
             try{ rs.close();}catch(SQLException e){}
                       }
          if (stmt!=null){
                  try{stmt.close();}catch(SQLException e){}
                         }
          if (pstmt!=null){
          try{pstmt.close();}catch(SQLException e){}
                          }      
                }
return noOfRows;
}

}

