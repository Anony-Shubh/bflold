<%@ page session="true" import="java.sql.*,java.util.*,pkgPmegpNew.DBCon"  %>
<head>
	<title>SAMADHAN ONLINE EDP TRAINIG</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
	<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="css/style.css">
	<link rel="stylesheet" type="text/css" href="css/responsive.css">
</head>

<%

String username = request.getParameter("u_name")==null?"":(String) request.getParameter("u_name");
String password = request.getParameter("p_word")==null?"":(String) request.getParameter("p_word");

String OFF_CD="";
String OFF_NAME = "";

if (!username.equals("")&&!password.equals("")){
   DBCon db= new DBCon();
db.connect();
	
	StringBuffer qrysb= new StringBuffer();

qrysb.append("select off_name,off_cd, u_name,p_word from mas_off_mast where u_name=?  AND p_word=? and off_cd=9246   " ); 


List values=new ArrayList();
  
  values.add(username);
  values.add(password);
  

ResultSet rsMain = db.executeSQL(qrysb.toString(),values);

	

    if (rsMain.next()) 
	{
		OFF_CD=rsMain.getString("OFF_CD")==null?"":rsMain.getString("OFF_CD");
		OFF_NAME=rsMain.getString("OFF_NAME")==null?"":rsMain.getString("OFF_NAME");

       session.setAttribute("slogin", "Y");

		session.setAttribute("SOFF_CD", OFF_CD);
		session.setAttribute("SOFF_NAME", OFF_NAME);
		
    } 
	rsMain.close();
	db.close();
	}//end of if
	

 if (!OFF_CD.equals("")){
 session.setAttribute("slogin", "Y");
response.sendRedirect("online_EDP.jsp"); 
	
	
	
	}else{			   
				   session.invalidate();
                    request.setAttribute("errorMessage", "Invalid username or password");
                    RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
                    rd.forward(request, response); 
			}	
%>


