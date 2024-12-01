package view;

import java.io.IOException;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;

import controller.ShelfDao;
import model.Shelf;

/**
 * Servlet Filter implementation class populateShelvesFilter
 */
@WebFilter("/addBook.jsp")
public class populateShelvesFilter implements Filter {

	  public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
	            throws IOException, ServletException {
	        HttpServletRequest httpRequest = (HttpServletRequest) request;
	        
	        // Check if shelves attribute is already set
	        if (httpRequest.getAttribute("shelves") == null) {
	            ShelfDao shelfDAO = new ShelfDao();
	            List<Shelf> shelves = shelfDAO.getAllShelves();
	            httpRequest.setAttribute("shelves", shelves);
	        }
	        
	        // Continue to the requested resource
	        chain.doFilter(request, response);
	    }	
	
	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
