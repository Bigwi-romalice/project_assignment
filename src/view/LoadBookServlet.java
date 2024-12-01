package view;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.BookDAO;
import model.Book;
import model.Role;
import model.Users;

/**
 * Servlet implementation class LoadBookServlet
 */
@WebServlet("/loadBooks")
public class LoadBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BookDAO bookDao = new BookDAO();
        try {
            // Get all books from the database
            List<Book> books = bookDao.getAllBooks();
            request.setAttribute("books", books);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading books");
        }

        // Get session object and check for logged-in user
        HttpSession session = request.getSession(false);
        Users user = (Users) session.getAttribute("user");

        if (user == null) {
            // Redirect to login if no user found
            response.sendRedirect("login.jsp");
        } else {
            // Check user role and forward to appropriate JSP page
            Role role = user.getRole();


            if (Role.LIBRARIAN.equals(role)) {
                // Forward to bookList.jsp if the user is a librarian
                RequestDispatcher dispatcher = request.getRequestDispatcher("bookList.jsp");
                dispatcher.forward(request, response);
            } else {
                // Forward to ViewBooks.jsp for other roles (like users)
                RequestDispatcher dispatcher = request.getRequestDispatcher("ViewBooks.jsp");
                dispatcher.forward(request, response);
            }
        }
    }
}
