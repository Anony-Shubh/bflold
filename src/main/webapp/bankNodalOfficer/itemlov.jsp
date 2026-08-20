 
<%@ page session="true" import="java.sql.*,java.util.*,java.text.*,java.util.Date,java.text.SimpleDateFormat,pkgPmegpNew.DBCon"  %>

<%
   String query = (String)request.getParameter("q");
DBCon db= new DBCon();
db.connect();

StringBuffer qrysb = new StringBuffer();
		 qrysb.append("  SELECT MD.DISTRICT_NAME|| ' '|| MS.STATE_NM||' ('||MD.DISTRICT_NAME ||')' as dist_dis ");
		 qrysb.append("  FROM M_DISTRICT MD,M_STATE MS WHERE MD.STATE_CD=MS.STATE_CD  ");
		 qrysb.append("  AND MD.DISTRICT_STATUS = 'A' ");
		
         ResultSet rs = db.execSQL(qrysb.toString());	

		   
		   	 
	
			  
			
	List li = new ArrayList();
 
       while(rs.next())
       {
           li.add(rs.getString(1));
		  
       }
 
       String[] str = new String[li.size()];
       Iterator it = li.iterator();
 
       int i = 0;
       while(it.hasNext())
       {
           String p = (String)it.next();
           str[i] = p;
           i++;
       }
 
    //jQuery related start
    
 
       int cnt=1;
       for(int j=0;j<str.length;j++)
       {
           if(str[j].toUpperCase().startsWith(query.toUpperCase()))
           {
              out.print(str[j]+"\n");
              if(cnt>=5)// 5=How many results have to show while we are typing(auto suggestions)
              break;
              cnt++;
            }
       }	   
 
		
		 %>

