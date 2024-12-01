package view;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.BookDAO;
import controller.BorrowerDao;
import model.Book;
import model.Borrower;
import model.Users;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@WebServlet("/borrowBook")
public class BorrowBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UUID bookId = UUID.fromString(request.getParameter("bookId"));
        Users currentUser = (Users) request.getSession().getAttribute("user");
        String returnDateParam = request.getParameter("returnDate");

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Date returnDate;
        try {
            returnDate = java.sql.Date.valueOf(returnDateParam); // Convert to SQL Date
        } catch (IllegalArgumentException e) {
            request.getSession().setAttribute("message", "Invalid return date format. Please try again.");
            response.sendRedirect("borrowBook");
            return;
        }

        BookDAO bookDAO = new BookDAO();
        boolean success = bookDAO.updateBookStatusToBorrowed(bookId);

        if (success) {
            Borrower borrower = new Borrower();
            borrower.setReader(currentUser);
            borrower.setBook(bookDAO.getBookById(bookId));
            borrower.setPickup_date(new Date()); // Current date as pickup date
            borrower.setDueDate(returnDate); // User-selected return date

            BorrowerDao borrowerDao = new BorrowerDao();
            borrowerDao.saveBorrower(borrower);

            request.getSession().setAttribute("message", "Book borrowed successfully!");
        } else {
            request.getSession().setAttribute("message", "Book is out of stock or unavailable.");
        }

        response.sendRedirect("borrowBook"); // Redirect to borrowBook.jsp with the message
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Existing code to fetch available books

        BookDAO bookDao = new BookDAO();
        
        // Fetch books the user has borrowed
//        List<Book> borrowedBooks = bookDao.getBooksBorrowedByUser(currentUser.getUserId()); 
//        request.setAttribute("borrowedBooks", borrowedBooks);

        List<Book> availableBooks = bookDao.getAvailableBooks();
        request.setAttribute("availableBooks", availableBooks);

        request.getRequestDispatcher("/borrowBook.jsp").forward(request, response);
    }

}
