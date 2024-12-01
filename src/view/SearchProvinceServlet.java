package view;

import controller.UserDao;
import model.Location;
import model.Users;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/searchProvince")
public class SearchProvinceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDao userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDao();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String phoneNumber = req.getParameter("phoneNumber");

        if (phoneNumber == null || phoneNumber.isEmpty()) {
            req.setAttribute("errorMessage", "Phone number is required.");
            forwardToJsp(req, resp, "searchProvince.jsp");
            return;
        }

        try {
            // Fetch user by phone number
            Users user = userDAO.getUserByPhoneNumber(phoneNumber);

            if (user == null) {
                req.setAttribute("errorMessage", "No user found with the provided phone number.");
                forwardToJsp(req, resp, "searchProvince.jsp");
                return;
            }

            // Get the province of the user's village
            Location province = userDAO.getProvinceByVillage(user.getVillage());

            if (province == null) {
                req.setAttribute("errorMessage", "No province found for the user's village.");
            } else {
                req.setAttribute("provinceName", province.getLocationName());
            }

            forwardToJsp(req, resp, "provinceName.jsp");
        } catch (Exception e) {
            log("Error processing searchProvince request", e);
            req.setAttribute("errorMessage", "An internal error occurred. Please try again later.");
            forwardToJsp(req, resp, "provinceName.jsp");
        }
    }

    private void forwardToJsp(HttpServletRequest req, HttpServletResponse resp, String jspPath) throws ServletException, IOException {
        RequestDispatcher dispatcher = req.getRequestDispatcher(jspPath);
        dispatcher.forward(req, resp);
    }
}
