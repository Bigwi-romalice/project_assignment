package view;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.BookDAO;

@WebServlet("/deleteBookServlet")
public class DeleteBookServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the book ID from the request
        String bookIdParam = request.getParameter("bookId");

        // Validate the input
        if (bookIdParam != null && !bookIdParam.isEmpty()) {
            try {
                // Convert the bookId from String to UUID
                UUID bookId = UUID.fromString(bookIdParam);

                // Instantiate BookDAO and attempt to delete the book
                BookDAO bookDAO = new BookDAO();
                boolean isDeleted = bookDAO.deleteBook(bookId);

                if (isDeleted) {
                    // Successfully deleted, forward back to the book list page with a success message
                    request.setAttribute("message", "Book deleted successfully.");
                } else {
                    // Failed to delete (book is borrowed or some error)
                    request.setAttribute("message", "Book could not be deleted. It might be currently borrowed.");
                }
            } catch (IllegalArgumentException e) {
                // Invalid UUID format
                request.setAttribute("message", "Invalid book ID.");
            }
        } else {
            request.setAttribute("message", "No book selected.");
        }

        response.sendRedirect("loadBooks");
    }
}
