package view;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.BookDAO;
import model.Book;
import model.Book_status;

/**
 * Servlet implementation class UpdateBookServlet
 */
@WebServlet("/updateBookServlet")
public class UpdateBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookId = request.getParameter("bookId"); // Get the ID of the book to update

        if (bookId != null && !bookId.isEmpty()) {
            try {
                // Parse UUID
                UUID id = UUID.fromString(bookId);

                // Retrieve the updated fields from the form
                String editionStr = request.getParameter("edition_" + bookId);
                String title = request.getParameter("title_" + bookId);
                String pubName = request.getParameter("pubName_" + bookId);
                String pubYearStr = request.getParameter("pubYear_" + bookId);
                String isbn = request.getParameter("isbn_" + bookId);

                // Validate required fields
                if (title == null || title.isEmpty() || pubName == null || pubName.isEmpty()) {
                    throw new IllegalArgumentException("Title and Publisher Name are required fields.");
                }

                // Convert data types
                int edition = editionStr != null && !editionStr.isEmpty() ? Integer.parseInt(editionStr) : 0;
                Date pubYear = null;
                if (pubYearStr != null && !pubYearStr.isEmpty()) {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    pubYear = sdf.parse(pubYearStr);
                }
           

                // Fetch the book from the database
                BookDAO bookDAO = new BookDAO();
                Book book = bookDAO.getBookById(id);

                if (book != null) {
                    // Update the book properties
                    book.setEdition(edition);
                    book.setTitle(title);
                    book.setPub_name(pubName);
                    book.setPub_year(pubYear);
                    book.setIsbn_code(isbn);

                    // Save the updated book
                    bookDAO.update(book);
                } else {
                    throw new IllegalArgumentException("Book with ID " + bookId + " not found.");
                }
            } catch (IllegalArgumentException e) {
                // Handle specific issues (e.g., invalid input)
                e.printStackTrace();
                request.setAttribute("error", e.getMessage());
            } catch (Exception e) {
                // General error handling
                e.printStackTrace();
                request.setAttribute("error", "An error occurred while updating the book.");
            }
        } else {
            request.setAttribute("error", "Book ID is required.");
        }

        // Redirect back to the book list
        response.sendRedirect("loadBooks");
    }
}
