package xls;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class trialservletfunct
 */

@WebServlet("/trialservletfunct")
public class trialservletfunct extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final int BUFSIZE = 4096;
	private String filePath;  
	private ServletOutputStream outStream;
    /**
     * @see HttpServlet#HttpServlet()
     */
	public void init( ){
	      // Get the file location where it would be stored.
	      filePath = getServletContext().getInitParameter("file_upload"); 
	     
	      /**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */}
	public trialservletfunct() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		ServletContext context = getServletContext();
		String filenameas=request.getParameter("param1");
		String filpathstring=filePath+filenameas;
		File file = new File(filePath+filenameas);
       int length = 0;
       	//outStream = response.getOutputStream();
      // PrintWriter out=response.getWriter();
       String mimeType = context.getMimeType(filpathstring);
       System.out.println("Value of mimeType" + mimeType);
       if(mimeType == null)
       {
    	   outStream = response.getOutputStream();

          	FileInputStream fl=new FileInputStream(file);
          	int i;
   			while((i=fl.read())!= -1)
   					outStream.write(i);;
   			outStream.close();
   			fl.close(); 
       }
       else
    	   {//showimg(request,response,outStream,filenameas); 
    	   response.setContentType("application/XLS");
    		//File fl=new File(filePath+filname);
    		FileInputStream inStream = new FileInputStream(file);
    		response.setContentLength((int) file.length());
    		String headerKey = "Content-Disposition";
    		String headerValue = String.format("inline; filename=\"%s\"", file.getName());
    		response.setHeader(headerKey, headerValue);
    		outStream = response.getOutputStream();
    		byte[] buffer = new byte[4096];
    		int bytesRead = -1;
    		while ((bytesRead = inStream.read(buffer)) != -1) 
    		{
    		outStream.write(buffer, 0, bytesRead);
    		}
    		inStream.close();
    		outStream.close();
    	   }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
}
