package view;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.MembershipTypeDao;
import model.Membership_type;

/**
 * Servlet implementation class MembershipTypeServlet
 */
@WebServlet("/initializeMemberships")
public class MembershipTypeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
	@Override
    public void init() throws ServletException {
        MembershipTypeDao membershipTypeDAO = new MembershipTypeDao();

        // Check if membership types exist in the database
        List<Membership_type> existingTypes = membershipTypeDAO.getAllMembershipTypes();
        if (existingTypes == null || existingTypes.isEmpty()) {
            // Add default membership types if the table is empty
            membershipTypeDAO.addMembershipType(new Membership_type( 5, 50, "GOLD"));
            membershipTypeDAO.addMembershipType(new Membership_type( 3, 30, "SILVER"));
            membershipTypeDAO.addMembershipType(new Membership_type(2, 10, "STRIVER"));
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        MembershipTypeDao membershipTypeDAO = new MembershipTypeDao();
        
        // Fetch all membership types to display in the dropdown
        List<Membership_type> membershipTypes = membershipTypeDAO.getAllMembershipTypes();
        
        // Set membership types as a request attribute for the JSP page
        request.setAttribute("membershipTypes", membershipTypes);
        
        // Forward to the register.jsp page
        request.getRequestDispatcher("Register.jsp").forward(request, response);
    }
	
}
