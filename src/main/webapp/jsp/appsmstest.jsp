<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="in.gov.mgov.SMSServices"%>



</head>

<body>
<form name="form1"  method="Post">
<% 
SMSServices sms1=new SMSServices();

//2740939a-a79d-42ba-984c-02fb4fa0e10d
//String username, String password , String message , String senderId, String mobileNumber,String secureKey
sms1.sendSingleSMS("KVICDIT", "Panda@1974","test", "KVICIT","7506134588","2740939a-a79d-42ba-984c-02fb4fa0e10d");
	// SendSMS.sendSingleSMS( MOBNO, sms_string);

%>
