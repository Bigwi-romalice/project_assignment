package view;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.BorrowerDao;
import model.Borrower;

/**
 * Servlet implementation class ReturnBook
 */
@WebServlet("/returnBook")
public class ReturnBook extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReturnBook() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the borrower ID from the request
        String borrowerIdStr = request.getParameter("id");

        if (borrowerIdStr != null) {
            try {
            	  // Parse the borrower ID as a UUID
                UUID borrowerId = UUID.fromString(borrowerIdStr);

                // Use the BorrowerDao to retrieve the borrower by UUID
                BorrowerDao borrowerDao = new BorrowerDao();
                Borrower borrower = borrowerDao.getBorrowerById(borrowerId);

                if (borrower != null) {
                    // Assuming the book ID and user ID are part of the borrower object.
                    UUID userId = borrower.getReader().getUserId();  // Get the user ID
//                    UUID bookId = borrower.getBook().getBookId();  // Get the book ID
                    
                    // Use the DAO method to return the book
//                    BookDAO bookDao = new BookDAO();
                    boolean success = borrowerDao.returnBorrowedBook(borrowerId);  // Call returnBorrowedBook DAO method
                    
                    if (success) {
                        // Redirect back to the list of borrowers after successfully returning the book
                    	System.out.println("it worked");
                        response.sendRedirect("DisplayAllBorrowers");
                    } else {
                        // If the return failed, show an error page or message
                        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unable to return the book.");
                    }
                } else {
                    // If borrower not found, show error page or message
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Borrower not found.");
                }
            } catch (NumberFormatException e) {
                // Handle invalid ID format
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid borrower ID.");
            }
        } else {
            // Handle case where no ID is provided
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing borrower ID.");
        }
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
