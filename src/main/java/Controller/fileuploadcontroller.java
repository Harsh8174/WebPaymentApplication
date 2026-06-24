package Controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.IOUtils;

import DAO.Dao;
import Model.User;
/**
 * Servlet implementation class fileuploadcontroller
 */
@WebServlet("/upload")
public class fileuploadcontroller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		DiskFileItemFactory factory=new DiskFileItemFactory();
		System.out.println("factory created");
		ServletFileUpload sfu=new ServletFileUpload(factory);
		System.out.println("sfu obejct created");
		try {
			List<FileItem> list=sfu.parseRequest(request);
			FileItem item=(FileItem)list.get(0);
			String file_path_name=item.getName();
			File f=new File(file_path_name);
			String file_name=System.currentTimeMillis() + "_" + f.getName();
			System.out.println(file_name);
		     
			String upload_path=request.getServletContext().getRealPath("/images");
			File f1=new File(upload_path+File.separator+file_name);
			try {
				System.out.println("end");
				item.write(f1);
				
				HttpSession session=request.getSession();
				System.out.println(session.getId());
			    User u=(User)session.getAttribute("User"); 	
				Dao.setuploadimagename(u, file_name,true);
			    session.setAttribute("profileimage", true);
				session.setAttribute("image_name", file_name);
				request.getRequestDispatcher("dashboard.jsp").forward(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (FileUploadException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
