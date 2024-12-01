package view;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.MembershipDao;
import model.Membership;
import model.Status;

/**
 * Servlet implementation class ViewPendingServlet
 */
@WebServlet("/viewPendingMemberships")
public class ViewPendingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MembershipDao membershipDao = new MembershipDao();

    // Handles displaying pending memberships
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Membership> pendingMemberships = membershipDao.getPendingMemberships();
        request.setAttribute("pendingMemberships", pendingMemberships);
        request.getRequestDispatcher("viewpending.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String membershipIdStr = request.getParameter("id");

        if (membershipIdStr != null && !membershipIdStr.isEmpty()) {
            UUID membershipId = UUID.fromString(membershipIdStr);
            if ("approve".equalsIgnoreCase(action)) {
                membershipDao.updateMembershipStatus(membershipId, Status.APPROVED);
            } else if ("decline".equalsIgnoreCase(action)) {
                membershipDao.updateMembershipStatus(membershipId, Status.REJECTED);
            }
        }
        response.sendRedirect("viewPendingMemberships"); // Reloads the page to reflect changes
    }
}
