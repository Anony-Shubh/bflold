<%@page language="java" import="java.sql.*"%>
<%@page import="java.util.*" %>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.simple.parser.ParseException"%>
<%@page import="pkgPmegpNew.DBCon"%>

<% 
int recCount=0;
    try
    {
	String IFSC_CODE_SER=request.getParameter("IFSC_CODE_SER")==null?"":(String) request.getParameter("IFSC_CODE_SER");
	DBCon db= new DBCon();
   db.connect();
   List values=new ArrayList();
     values.add (IFSC_CODE_SER); 
	 
	String stb=" SELECT IFSC_CODE as name,BANK_NAME ,BRANCHNAME,DISTRICT FROM RBIBANKLIST WHERE IFSC_CODE LIKE UPPER(?) ";
	

 ResultSet rs = db.executeSQL(stb,values);
	 JSONArray list = new JSONArray();
      
        while(rs.next())
        {
            JSONObject obj=new JSONObject();
            obj.put("name", rs.getObject(1)+"|");
            obj.put("BANK_NAME", rs.getObject(2)+"|");
            obj.put("BRANCHNAME", rs.getObject(3)+"|");
            obj.put("DISTRICT", rs.getObject(4)+"|");
 			recCount=recCount+1;
            list.add(obj);
        }
 if (recCount>0){
        out.print(list);
		}else{
		out.print("invalid IFS Code or No Record Found.");
		}
	rs.close();
	db.close();
    }catch(Exception ex)
    {
        out.println("<h1>"+ex+"</g1>");
    }
 
 
 

 %>
