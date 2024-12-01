package view;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.roomDao;
import model.Room;

/**
 * Servlet implementation class AddRoomServlet
 */
@WebServlet("/RoomServlet")
public class AddRoomServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {

	        String roomCode = request.getParameter("roomCode");

	        Room room = new Room();
	        room.setRoomCode(roomCode);

	        roomDao roomDAO = new roomDao();
	        roomDAO.addRoom(room);

	        response.sendRedirect("addBook.jsp"); // Redirect to addBook.jsp after adding room
	    }
       
}
