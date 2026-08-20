
package CovidPackage;

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
import java.sql.Connection;


public class DBCon 
{
  
  private String cnt="java:comp/env/jdbc/SVM";
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
 if ( ( dbCon !=null) && (!dbCon.isClosed()) ){
  dbCon.close();
}
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
		

			for (int i=0;i<values.size();i++){
			
			String str=  (String)values.get(i);
			
			pstmt.setString(i+1,str);
			 }//end for
			 

ResultSet r=pstmt.executeQuery();
return(r==null)?null:r;
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

