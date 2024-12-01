package view;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Role;
import model.Users; // Assuming your User class is in the 'model' package

@WebFilter(urlPatterns = {"/addBook.jsp", "/BookList.jsp", "/addShelf.jsp", "/viewpending.jsp", "/addRoom.jsp",
        "/borrowBook.jsp", "/LibrarianPage.jsp", "/LibrarianViewBorrowings.jsp", "/management.jsp", "/viewBooks.jsp", "/student.jsp", "/borrowBook.jsp"})
public class pageFilter implements Filter {

    @Override
    public void destroy() {
        // No specific destruction logic required
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        HttpSession session = httpRequest.getSession(false);

        // Check if there is an active session and if the user is logged in
        if (session == null || session.getAttribute("user") == null) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/accessDenied");
            return;
        }

        // Retrieve the user object from the session
        Users user = (Users) session.getAttribute("user");
        Role role = user.getRole(); // Assuming the User class has a getRole() method
        System.out.println("Filter role: " + role);

        // Define allowed URLs for each role
        List<String> librarianAllowedUrls = Arrays.asList(
                "/addBook.jsp", "/BookList.jsp", "/addShelf.jsp", "/viewpending.jsp", "/addRoom.jsp",
                "/borrowBook.jsp", "/LibrarianPage.jsp", "/LibrarianViewBorrowings.jsp"
        );

        List<String> managerDeanHodAllowedUrls = Arrays.asList(
                "/management.jsp", "/viewBooks.jsp"
        );

        List<String> studentTeacherAllowedUrls = Arrays.asList(
                "/student.jsp", "/borrowBook.jsp"
        );

        // Get the requested URL
        String requestUrl = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());

        // Track the last visited page
        session.setAttribute("lastPage", requestUrl);

        // Check access permissions based on role
        if (role == Role.LIBRARIAN && librarianAllowedUrls.contains(requestUrl)) {
            chain.doFilter(request, response);
        } else if ((role == Role.MANAGER || role == Role.DEAN || role == Role.HOD) && managerDeanHodAllowedUrls.contains(requestUrl)) {
            chain.doFilter(request, response);
        } else if ((role == Role.STUDENT || role == Role.TEACHER) && studentTeacherAllowedUrls.contains(requestUrl)) {
            chain.doFilter(request, response);
        } else {
            // Redirect back to the last visited page or a default page
            String lastPage = (String) session.getAttribute("lastPage");
            if (lastPage != null && !lastPage.equals(requestUrl)) {
                httpResponse.sendRedirect(httpRequest.getContextPath() + lastPage);
            } else {
                // Fallback to a default page if no valid last page is available
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/Register.jsp");
            }
        }
    }


    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // No specific initialization logic required
    }
}
