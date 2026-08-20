<%@ page import="java.io.IOException" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.Files" %>
<%@ page import="java.nio.file.Path" %>
<%@ page import="java.nio.file.Paths" %>
<%@ page import="java.nio.file.StandardCopyOption.*" %>
<%@ page import="pkgPmegpNew.DBCon"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="globalp.*"%>


<html>
<head>
<title>datatransfer</title>
</head>
<body>
<form>
<%
String fileExistinNas="Y";
String DOC_NAME=request.getParameter("docname")==null?"-":(String) request.getParameter("docname");

if (!DOC_NAME.equals("")) {
StringBuffer qrysb = new StringBuffer();
kvicGlobalPath sm = new kvicGlobalPath();
//String a=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/pmegpappupload_temp/");
String destnationfolder=sm.getStorage("pmegpappuploadSecond/"+DOC_NAME+"");

ArrayList<String> ar = new ArrayList<String>();

String updir=sm.getStorage("KVIC_UPLOAD_TEMP/PMEGPEPORTAL/");

ar.add("pmegpeportal_deletedfile");
ar.add("pmegpappupload_temp");
ar.add("pmegpappupload_temp1");
ar.add("pmegpappupload_temp2");
ar.add("pmegpappupload_temp_106");
ar.add("pmegpappupload_temp101");
ar.add("pmegpappupload_temp102");
ar.add("pmegpappupload_temp103");
ar.add("pmegpappupload_temp104");
ar.add("pmegpappupload_temp105");
ar.add("pmegpappupload_temp106");
ar.add("pmegpappupload_temp107");
ar.add("pmegpappupload_temp108/");
ar.add("pmegpappupload_temp109");
ar.add("pmegpappupload_unwanted");
ar.add("pmegpappupload_temp110");
ar.add("pmegpappupload_temp111");
ar.add("pmegpappupload_temp112");
ar.add("tempedponline");
ar.add("pmegpappupload_temp113");
ar.add("pmegpappupload_temp114");
ar.add("pmegpappupload_temp115");
ar.add("pmegpappupload_temp116");
ar.add("pmegpappupload_temp117");
ar.add("pmegpappupload_temp118");
ar.add("pmegpappupload_temp119");
ar.add("pmegpappupload_temp121");
ar.add("pmegpappupload_temp122");
ar.add("pmegpappupload_temp123");
ar.add("pmegpappupload_temp124");
ar.add("pmegpappupload_temp125");
ar.add("pmegpappupload_temp126");
ar.add("pmegpappupload_temp127");
ar.add("pmegpappupload_temp128");
ar.add("pmegpappupload_temp130");
ar.add("pmegpappupload_temp131");
ar.add("pmegpappupload_temp132");

ar.add("pmegpappupload_temp133");
ar.add("pmegpappupload_temp134");
ar.add("pmegpappupload_temp135");
ar.add("pmegpappupload_temp136");
ar.add("pmegpappupload_temp137");
ar.add("pmegpappupload_temp138");
ar.add("pmegpappupload_temp139");
ar.add("pmegpappupload_temp140");
ar.add("pmegpappupload_temp141");
ar.add("pmegpappupload_temp142");

ar.add("pmegpappupload_temp143");
ar.add("pmegpappupload_temp144");
ar.add("pmegpappupload_temp145");
ar.add("pmegpappupload_temp146");
ar.add("pmegpappupload_temp147");
ar.add("pmegpappupload_temp148");
ar.add("pmegpappupload_temp149");
ar.add("pmegpappupload_temp150");
ar.add("pmegpappupload_temp151");
ar.add("pmegpappupload_temp152");
ar.add("pmegpappupload_temp153");
ar.add("pmegpappupload_temp154");
ar.add("pmegpappupload_temp155");
ar.add("pmegpappupload_temp156");
ar.add("pmegpappupload_temp157");
ar.add("pmegpappupload_temp158");
ar.add("pmegpappupload_temp159");
ar.add("pmegpappupload_temp160");
ar.add("pmegpappupload_temp161");
ar.add("pmegpappupload_temp162");
ar.add("pmegpappupload_temp163");
ar.add("pmegpappupload_temp164");
ar.add("pmegpappupload_temp165");
ar.add("pmegpappupload_temp166");
ar.add("pmegpappupload_temp167");
ar.add("pmegpappupload_temp168");
ar.add("pmegpappupload_temp169");
ar.add("pmegpappupload_temp170");
ar.add("pmegpappupload_temp171");
ar.add("pmegpappupload_temp172");
ar.add("pmegpappupload_temp173");
ar.add("pmegpappupload_temp174");
ar.add("pmegpappupload_temp175");
ar.add("pmegpappupload_temp176");
ar.add("pmegpappupload_temp177");
ar.add("pmegpappupload_temp178");
ar.add("pmegpappupload_temp179");
ar.add("pmegpappupload_temp180");
ar.add("pmegpappupload_temp181");
ar.add("pmegpappupload_temp182");
ar.add("pmegpappupload_temp183");
ar.add("pmegpappupload_temp184");
ar.add("pmegpappupload_temp185");
ar.add("pmegpappupload_temp186");
ar.add("pmegpappupload_temp187");
ar.add("pmegpappupload_temp188");
ar.add("pmegpappupload_temp189");
ar.add("pmegpappupload_temp190");
ar.add("pmegpappupload_temp191");
ar.add("pmegpappupload_temp192");
ar.add("pmegpappupload_temp193");
ar.add("pmegpappupload_temp194");
ar.add("pmegpappupload_temp195");
ar.add("pmegpappupload_temp196");
ar.add("pmegpappupload_temp197");
ar.add("pmegpappupload_temp198");
ar.add("pmegpappupload_temp199");
ar.add("pmegpappupload_temp200");
ar.add("pmegpappupload_temp201");
ar.add("pmegpappupload_temp202");
ar.add("pmegpappupload_temp203");
ar.add("pmegpappupload_temp204");
ar.add("pmegpappupload_temp205");
ar.add("pmegpappupload_temp206");
ar.add("pmegpappupload_temp207");
ar.add("pmegpappupload_temp208");
ar.add("pmegpappupload_temp209");
ar.add("pmegpappupload_temp210");
ar.add("pmegpappupload_temp211");
ar.add("pmegpappupload_temp212");
ar.add("pmegpappupload_temp213");
ar.add("pmegpappupload_temp214");
ar.add("pmegpappupload_temp215");
ar.add("pmegpappupload_temp216");
ar.add("pmegpappupload_temp217");
ar.add("pmegpappupload_temp218");
ar.add("pmegpappupload_temp219");
ar.add("pmegpappupload_temp220");
ar.add("pmegpappupload_temp221");
ar.add("pmegpappupload_temp222");
ar.add("pmegpappupload_temp223");
ar.add("pmegpappupload_temp224");
ar.add("pmegpappupload_temp225");
ar.add("pmegpappupload_temp226");
ar.add("pmegpappupload_temp227");
ar.add("pmegpappupload_temp228");
ar.add("pmegpappupload_temp229");
ar.add("pmegpappupload_temp230");
ar.add("pmegpappupload_temp231");
ar.add("pmegpappupload_temp232");
ar.add("pmegpappupload_temp233");
ar.add("pmegpappupload_temp234");
ar.add("pmegpappupload_temp235");
ar.add("pmegpappupload_temp236");
ar.add("pmegpappupload_temp237");
ar.add("pmegpappupload_temp238");
ar.add("pmegpappupload_temp239");
ar.add("pmegpappupload_temp240");
ar.add("pmegpappupload_temp241");
ar.add("pmegpappupload_temp242");
ar.add("pmegpappupload_temp243");
ar.add("pmegpappupload_temp244");
ar.add("pmegpappupload_temp245");
ar.add("pmegpappupload_temp246");
ar.add("pmegpappupload_temp247");
ar.add("pmegpappupload_temp248");
ar.add("pmegpappupload_temp249");
ar.add("pmegpappupload_temp250");
ar.add("pmegpappupload_temp251");
ar.add("pmegpappupload_temp252");
ar.add("pmegpappupload_temp253");
ar.add("pmegpappupload_temp254");
ar.add("pmegpappupload_temp255");
ar.add("pmegpappupload_temp256");
ar.add("pmegpappupload_temp257");
ar.add("pmegpappupload_temp258");
ar.add("pmegpappupload_temp259");
ar.add("pmegpappupload_temp260");
ar.add("pmegpappupload_temp261");
ar.add("pmegpappupload_temp262");
ar.add("pmegpappupload_temp263");
ar.add("pmegpappupload_temp264");
ar.add("pmegpappupload_temp265");
ar.add("pmegpappupload_temp266");
ar.add("pmegpappupload_temp267");
ar.add("pmegpappupload_temp268");
ar.add("pmegpappupload_temp269");
ar.add("pmegpappupload_temp270");
ar.add("pmegpappupload_temp271");
ar.add("pmegpappupload_temp272");
ar.add("pmegpappupload_temp273");
ar.add("pmegpappupload_temp274");
ar.add("pmegpappupload_temp275");
ar.add("pmegpappupload_temp276");
ar.add("pmegpappupload_temp277");
ar.add("pmegpappupload_temp278");
ar.add("pmegpappupload_temp279");
ar.add("pmegpappupload_temp280");
ar.add("pmegpappupload_temp281");
ar.add("pmegpappupload_temp282");
ar.add("pmegpappupload_temp283");
ar.add("pmegpappupload_temp284");
ar.add("pmegpappupload_temp285");
ar.add("pmegpappupload_temp286");
ar.add("pmegpappupload_temp287");
ar.add("pmegpappupload_temp288");
ar.add("pmegpappupload_temp289");
ar.add("pmegpappupload_temp290");
ar.add("pmegpappupload_temp291");
ar.add("pmegpappupload_temp292");
ar.add("pmegpappupload_temp293");
ar.add("pmegpappupload_temp294");
ar.add("pmegpappupload_temp295");
ar.add("pmegpappupload_temp296");
ar.add("pmegpappupload_temp297");
ar.add("pmegpappupload_temp298");
ar.add("pmegpappupload_temp299");
ar.add("pmegpappupload_temp300");
ar.add("pmegpappupload_temp301");
ar.add("pmegpappupload_temp302");
ar.add("pmegpappupload_temp303");
ar.add("pmegpappupload_temp304");
ar.add("pmegpappupload_temp305");
ar.add("pmegpappupload_temp306");
ar.add("pmegpappupload_temp307");
ar.add("pmegpappupload_temp308");
ar.add("pmegpappupload_temp309");
ar.add("pmegpappupload_temp310P");
ar.add("pmegpappupload_temp311");
ar.add("pmegpappupload_temp312");
ar.add("pmegpappupload_temp313");
ar.add("pmegpappupload_temp314");
ar.add("pmegpappupload_temp315");
ar.add("pmegpappupload_temp316");
ar.add("pmegpappupload_temp317");
ar.add("pmegpappupload_temp318");
ar.add("pmegpappupload_temp319");
ar.add("pmegpappupload_temp320");
ar.add("pmegpappupload_temp321");
ar.add("pmegpappupload_temp322");
ar.add("pmegpappupload_temp323");
ar.add("pmegpappupload_temp324");
ar.add("pmegpappupload_temp325");
ar.add("pmegpappupload_temp326");
ar.add("pmegpappupload_temp327");
ar.add("pmegpappupload_temp328");
ar.add("pmegpappupload_temp329");
ar.add("pmegpappupload_temp330");
ar.add("pmegpappupload_temp331");
ar.add("pmegpappupload_temp332");
ar.add("pmegpappupload_temp333");
ar.add("pmegpappupload_temp334");
ar.add("pmegpappupload_temp335");
ar.add("pmegpappupload_temp336");
ar.add("pmegpappupload_temp337");
ar.add("pmegpappupload_temp338");
ar.add("pmegpappupload_temp339");
ar.add("pmegpappupload_temp340");
ar.add("pmegpappupload_temp341");
ar.add("pmegpappupload_temp342");
ar.add("pmegpappupload_temp343");
ar.add("pmegpappupload_temp344");
ar.add("pmegpappupload_temp345");


int count=0;
		
File file= new File(destnationfolder);

if (file.exists()) {
count=10;
out.print ("Exit in destination folder..........");
}
if (count<1) {
String docpath="";
Path target = Paths.get(destnationfolder);
 while (ar.size() > count) {
	docpath=updir+""+ar.get(count)+"/"+DOC_NAME+"";
	file= new File(docpath);
		if (file.exists()) {
		Path source = Paths.get(docpath)	;		
   			Files.move(source, target);
			break;
		}
         count++;
      }
	  
} // end of count

}// end of docfind
	
response.sendRedirect("../../pmegpeportalappdoc/pmegpappuploadSecond/"+DOC_NAME);
%>

</body>
</form>
