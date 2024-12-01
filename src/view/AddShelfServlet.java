package view;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import controller.ShelfDao;
import model.Room;
import model.Shelf;
import util.HibernateUtil;

/**
 * Servlet implementation class AddShelfServlet
 */
@WebServlet("/shelfServlet")
public class AddShelfServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddShelfServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String bookCategory = request.getParameter("bookCategory");
        int initialStock = Integer.parseInt(request.getParameter("initialStock"));
        UUID roomId = UUID.fromString(request.getParameter("room")); // Room ID from dropdown

        // Retrieve the Room object
        Room room;
        try (Session session = HibernateUtil.getSession().openSession()) {
            room = session.find(Room.class, roomId);
        }

        // Create and save the Shelf
        Shelf shelf = new Shelf();
        shelf.setBookCategory(bookCategory);
        shelf.setInitial_stock(initialStock);
        shelf.setAvailable_stock(initialStock);
        shelf.setRoom(room);

        ShelfDao shelfDAO = new ShelfDao();
        shelfDAO.addShelf(shelf);

        response.sendRedirect("addBook.jsp"); // Redirect to addBook.jsp after adding shelf
    }
	

}
