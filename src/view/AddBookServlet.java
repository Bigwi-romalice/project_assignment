package view;

import java.io.IOException;
import java.sql.Date;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Book;
import model.Book_status;
import model.Shelf;
import util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import controller.BookDAO;

/**
 * Servlet implementation class AddBookServlet
 */
@WebServlet("/BookServlet")
public class AddBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        // Retrieve form data
        String title = request.getParameter("title");
        int edition = Integer.parseInt(request.getParameter("edition"));
        String pubName = request.getParameter("pub_name");
        Date pubYear = Date.valueOf(request.getParameter("pub_year")); // Converts to SQL Date format
        String isbnCode = request.getParameter("isbn_code");
        Book_status bookStatus = Book_status.valueOf(request.getParameter("bookStatus").toUpperCase());
        UUID shelfId = UUID.fromString(request.getParameter("shelf_id")); // Assuming shelf_id is entered as a UUID

        // Create a new Book object
        Book book = new Book();
        book.setTitle(title);
        book.setEdition(edition);
        book.setPub_name(pubName);
        book.setPub_year(pubYear);
        book.setIsbn_code(isbnCode);
        book.setBookStatus(bookStatus);

        // Save the book to the database using BookDAO
        BookDAO bookDAO = new BookDAO();
        try (Session session = HibernateUtil.getSession().openSession()) {
            Transaction transaction = session.beginTransaction();

            // Retrieve the Shelf object based on shelf_id
            Shelf shelf = session.find(Shelf.class, shelfId);
            if (shelf != null) {
                book.setShelf(shelf);
                bookDAO.saveBook(book);
                transaction.commit();
            } else {
                // Handle case where shelf is not found (optional)
                // You might want to redirect to an error page or show a message
                transaction.rollback();
                request.setAttribute("error", "Shelf not found!");
                request.getRequestDispatcher("errorPage.jsp").forward(request, response);
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exception (optional)
            response.sendRedirect("errorPage.jsp"); // Redirect to an error page
            return;
        }

        // Redirect to confirmation or book list page
        response.sendRedirect("loadBooks");  // Redirect to a book list or confirmation page
    }
}
