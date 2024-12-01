package view;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.MembershipDao;
import model.Membership;
import model.Status;
import model.Users;

/**
 * Servlet implementation class checkmembership
 */
@WebServlet("/checkMembershipStatus")
public class CheckMembershipStatusServlet extends HttpServlet {
		private static final long serialVersionUID = 1L;

	    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        // Retrieve the current logged-in user from the session
	        Users user = (Users) request.getSession().getAttribute("user");

	        if (user == null) {
	            // If no user is logged in, redirect to login page with an error message
	            response.sendRedirect("login.jsp?error=You need to log in first.");
	            return;
	        }

	        // Fetch the membership status of the user
	        MembershipDao membershipDAO = new MembershipDao();
	        Membership membership = membershipDAO.getMembershipByUser(user);

	        if (membership != null && membership.getMembershipStatus() == Status.APPROVED) {
	            // If the membership is approved, redirect to the borrow book page
	            response.sendRedirect("borrowBook");
	        } else {
	            // If the membership is not approved, show an error message
	            response.sendRedirect("student.jsp?error=Your membership is not approved yet.");
	        }
	    }

}
