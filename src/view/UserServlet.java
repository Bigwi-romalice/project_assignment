package view;

import java.io.IOException;
import java.util.Calendar;
import java.util.Date;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.LocationDAO;
import controller.MembershipDao;
import controller.MembershipTypeDao;
import controller.UserDao;
import model.Gender;
import model.Location;
import model.Location_type;
import model.Membership;
import model.Membership_type;
import model.Role;
import model.Users;
import util.PasswordUtils;

@WebServlet("/register")
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String personId = request.getParameter("personId");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String pnumber = request.getParameter("phoneNumber");
        UUID userId = UUID.randomUUID();
        String userName = request.getParameter("userName");
        String password = request.getParameter("password");  // Make sure to hash this password before saving
        String provinceName = request.getParameter("province");
        String districtName = request.getParameter("district");
        String sectorName = request.getParameter("sector");
        String cellName = request.getParameter("cell");
        String villageName = request.getParameter("village");
        String membershipTypeId = request.getParameter("membershipTypeId");
        String hashedPassword = PasswordUtils.hashPassword(password);
        Gender gender;
        Role role;

        // Parse gender and role with validation
        try {
            gender = Gender.valueOf(request.getParameter("gender").toUpperCase());
            role = Role.valueOf(request.getParameter("role").toUpperCase());
        } catch (IllegalArgumentException e) {
            response.sendRedirect("error.jsp"); // Handle invalid enums
            return;
        }

        LocationDAO locationDAO = new LocationDAO();
        UserDao userDAO = new UserDao();

        // Create or retrieve locations
        Location province = locationDAO.getOrCreateLocation(provinceName, Location_type.PROVINCE, null);
        Location district = locationDAO.getOrCreateLocation(districtName, Location_type.DISTRICT, province);
        Location sector = locationDAO.getOrCreateLocation(sectorName, Location_type.SECTOR, district);
        Location cell = locationDAO.getOrCreateLocation(cellName, Location_type.CELL, sector);
        Location village = locationDAO.getOrCreateLocation(villageName, Location_type.VILLAGE, cell);

        // Create user and associate with location
        Users user = new Users(personId, firstName, lastName, gender, pnumber, userId, userName, hashedPassword, role, village);
        userDAO.registerUser(user); // Register user

        // Only create membership if the user is a student
        if (role == Role.STUDENT || role == Role.TEACHER) {
            MembershipTypeDao membershipTypeDao = new MembershipTypeDao();
            UUID membershipId = UUID.fromString(membershipTypeId);
            Membership_type membershipType = membershipTypeDao.getMembershipTypeById(membershipId); // Fetch membership type

            Membership membership = new Membership();
            membership.setReader(user); // Associate the membership with the user
            membership.setMembershipType(membershipType); // Set the membership type based on user selection
            membership.setReg_date(new Date(System.currentTimeMillis())); // Set current date
            membership.setExpiry_time(calculateExpiryDate()); // Calculate expiry date for membership
            membership.setM_code(generateMembershipCode()); // Generate a unique code

            MembershipDao membershipDAO = new MembershipDao();
            membershipDAO.saveMembership(membership);
        }

        // Redirect to login page after registration
        response.sendRedirect("login.jsp");
    }

    private Date calculateExpiryDate() {
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.YEAR, 1); // Set expiry for one year
        return calendar.getTime();
    }

    private String generateMembershipCode() {
        return UUID.randomUUID().toString(); // Unique membership code
    }
}
