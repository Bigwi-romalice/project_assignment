package view;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import controller.BorrowerDao;
import model.Borrower;

/**
 * Servlet implementation class DisplayAllBorrowers
 */
@WebServlet("/DisplayAllBorrowers")
public class DisplayAllBorrowers extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DisplayAllBorrowers() {
        super();
        // TODO Auto-generated constructor stub
    }

	
//	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		// TODO Auto-generated method stub
//		response.getWriter().append("Served at: ").append(request.getContextPath());
//	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	 BorrowerDao dao = new BorrowerDao();
	   try {
           List<Borrower> borrowers = dao.getBorrowersWithBorrowedBooks();
           System.out.println("Borrowers list size: " + borrowers.size()); 
           request.setAttribute("borrowers", borrowers);
           request.getRequestDispatcher("/LibrarianViewBorrowings.jsp").forward(request, response);
       } catch (Exception e) {
           e.printStackTrace(); // Log the error for debugging
           response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while retrieving the borrowers.");
       }
	}

}
