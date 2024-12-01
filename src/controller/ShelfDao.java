package controller;

import org.hibernate.Session;
import org.hibernate.Transaction;

import model.Book;
import model.Shelf;
import util.HibernateUtil;
import java.util.List;
import java.util.UUID;

public class ShelfDao {

	 public void addShelf(Shelf shelf) {
	        try (Session session = HibernateUtil.getSession().openSession()) {
	            Transaction transaction = session.beginTransaction();
	            session.merge(shelf);
	            transaction.commit();
	        }
	    }

	 public List<Shelf> getAllShelves() {
		    try (Session session = HibernateUtil.getSession().openSession()) {
		        // Use INNER JOIN to fetch shelves with associated room data
		        return session.createQuery("from Shelf", Shelf.class).list();
		    }catch(Exception e) {
		    	System.out.println(e.getMessage());
		    }
			return null;
		}

	// Method to update a Shelf record
	    public void updateShelf(Shelf shelf) {
	        Transaction transaction = null;
	        try (Session session = HibernateUtil.getSession().openSession()) {
	            transaction = session.beginTransaction();
	            session.update(shelf);
	            transaction.commit();
	        } catch (Exception e) {
	            if (transaction != null) {
	                transaction.rollback();
	            }
	            e.printStackTrace();
	        }
	    }
	    
	    public void updateShelfStock(UUID bookId) {
	        Transaction transaction = null;
	        try (Session session = HibernateUtil.getSession().openSession()) {
	            transaction = session.beginTransaction();

	            // Retrieve the Book by ID
	            Book book = session.get(Book.class, bookId);

	            // Ensure the book exists
	            if (book != null) {
	                Shelf shelf = book.getShelf();
	                
	                // Increase the available stock in the shelf by 1
	                shelf.setAvailable_stock(shelf.getAvailable_stock() + 1);

	                // Save the updated shelf data
	                session.update(shelf);
	                transaction.commit();
	            }
	        } catch (Exception e) {
	            if (transaction != null) transaction.rollback();
	            e.printStackTrace();
	        }
	    }

}
