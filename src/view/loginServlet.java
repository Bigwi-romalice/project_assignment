package view;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.UserDao;
import model.Users;
import util.PasswordUtils;

/**
 * Servlet implementation class loginServlet
 */
@WebServlet("/login")
public class loginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        String username = request.getParameter("username");
	        String password = request.getParameter("password");

	        UserDao userDao = new UserDao();
	        Users user = userDao.getUserByUsername(username);

	        if (user != null && PasswordUtils.hashPassword(password).equals(user.getPassword())) {
	            HttpSession session = request.getSession();
	            session.setAttribute("user", user);  // Store user data in session
	            
	            // Redirect based on role
	            switch (user.getRole()) {
	                case LIBRARIAN:
	                	request.getRequestDispatcher("librarianPage.jsp").forward(request, response);
//	                    response.sendRedirect("librarianPage.jsp");
	                    break;
	                case STUDENT:
	                case TEACHER:	
	                	request.getRequestDispatcher("student.jsp").forward(request, response);
//	                    response.sendRedirect("student.jsp");
	                    break;
	                case MANAGER:
	                case HOD:
	                case DEAN:
	                	request.getRequestDispatcher("management.jsp").forward(request, response);
//	                    response.sendRedirect("management.jsp");
	                    break;
	                default:
	                	request.getRequestDispatcher("error.jsp").forward(request, response);
//	                    response.sendRedirect("error.jsp");
	                    break;
	            }
	        } else {
	        	request.getRequestDispatcher("login.jsp?error=invalid").forward(request, response);
	        	
//	            response.sendRedirect("login.jsp?error=invalid");
	        }
	    }
	    
	    
	}


