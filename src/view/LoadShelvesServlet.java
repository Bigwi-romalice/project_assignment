package view;

import java.util.List;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.ShelfDao;
import model.Shelf;

/**
 * Servlet implementation class LoadShelvesServlet
 */
@WebServlet("/loadShelves")
public class LoadShelvesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	 protected void doGet(HttpServletRequest request, HttpServletResponse response){
	        
	       try { ShelfDao shelfDAO = new ShelfDao();
	        List<Shelf> shelves = shelfDAO.getAllShelves();
	        
	        // Set shelves attribute explicitly as List<Shelf>
	        request.setAttribute("shelves", shelves);
	        request.getRequestDispatcher("addBook.jsp").forward(request, response);
	    }catch(Exception e){
	    	System.out.println(e.getMessage());
	    }
	       }
}
