package view;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.roomDao;
import model.Room;

/**
 * Servlet implementation class LoadRoomServlet
 */
@WebServlet("/loadRooms")
public class LoadRoomServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	    protected void doGet(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {
	        roomDao roomDAO = new roomDao();
	        List<Room> rooms = roomDAO.getAllRooms();

	        // Set rooms as a request attribute
	        request.setAttribute("rooms", rooms);

	        // Forward to the JSP page where the dropdown will be populated
	        request.getRequestDispatcher("addShelf.jsp").forward(request, response);
	    }

}
