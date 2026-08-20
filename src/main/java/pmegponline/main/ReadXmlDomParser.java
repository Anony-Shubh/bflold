package pmegponline.main;
// Java Code to implement StAX parser
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.Iterator;
import javax.xml.namespace.QName;
import javax.xml.stream.XMLEventReader;
import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.XMLStreamException;
import javax.xml.stream.events.*;

public class ReadXmlDomParser
{
	static String vret="";
	static String vcode="";
	static String vtxn="";
	static String vinfo="";
	static String vts="";
	static String verr="";
	
	@SuppressWarnings("unlikely-arg-type")
	public static void parser(String file) throws FileNotFoundException,XMLStreamException
	{
		XMLInputFactory factory = XMLInputFactory.newInstance();
		XMLEventReader eventReader =factory.createXMLEventReader(new ByteArrayInputStream(file.getBytes()));
		
         String valnm="";
		
		while (eventReader.hasNext())
		{
			
			XMLEvent event = eventReader.nextEvent();

			
			if (event.isStartElement())
			{
				StartElement element = (StartElement)event;

				
				Iterator<Attribute> iterator = element.getAttributes();
				while (iterator.hasNext())
				{
					Attribute attribute = iterator.next();
					QName name = attribute.getName();
					String value = attribute.getValue();
					
					valnm = name.toString().trim();
					//System.out.println(name+" = " + value);
					if (valnm.equals("ret")) {
						vret=value;
						//System.out.println(name+" = " + value);
					}
					
					if (valnm.equals("code")) {
						vcode=value;
						//System.out.println(name+" = " + value);
						}
					
					if (valnm.equals("err")) {
						verr=value;
						//System.out.println(name+" = " + value);
						}
					
					if (valnm.equals("txn")) {
						vtxn=value;
						//System.out.println(name+" = " + value);
						}
					
					if (valnm.equals("info")) {
						vinfo=value;
						//System.out.println(name+" = " + value);
						}
					
					if (valnm.equals("ts")) {
						vts=value;
						
						//System.out.println(name+" = " + value);
						}
					
					
				}
			}	
			}

	}
	
	
	
	public String geterr() {
		return verr;
		
	}
	
	public String getts() {
		return vts;
		
	}
	
	public String getinfo() {
		return vinfo;
		
	}
	
	public String gettxn() {
		return vtxn;
		
	}
	
	public String getcode() {
		return vcode;
		
	}
	
	public String getret() {
		return vret;
		
	}
	
	
	
	
	
}
