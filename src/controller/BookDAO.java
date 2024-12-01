package controller;

import java.util.List;
import java.util.UUID;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import model.Book;
import model.Book_status;
import model.Borrower;
import util.HibernateUtil;

public class BookDAO {

	public void saveBook(Book book) {
	    Transaction transaction = null;
	    try (Session session = HibernateUtil.getSession().openSession()) {
	        transaction = session.beginTransaction();
	        session.save(book);
            session.flush();  // Optional: forces Hibernate to synchronize immediately
	        transaction.commit();
	    } catch (Exception e) {
	        if (transaction != null) transaction.rollback();
	        e.printStackTrace();
	    }
	}


	public List<Book> getAllBooks() {
	        List<Book> books = null;
	        try (Session session = HibernateUtil.getSession().openSession()) {
	            books = session.createQuery("from Book", Book.class).list();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return books;
	}
	public Book getBookById(UUID bookId) {
        try (Session session = HibernateUtil.getSession().openSession()) {
            return session.get(Book.class, bookId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

	public boolean updateBookStatusToBorrowed(UUID bookId) {
	    Transaction transaction = null;
	    try (Session session = HibernateUtil.getSession().openSession()) {
	        transaction = session.beginTransaction();

	        // Retrieve the book by ID
	        Book book = session.get(Book.class, bookId);

	        // Check if the book exists and has available stock
	        if (book != null && book.getShelf().getAvailable_stock() > 0) {
	            // Decrease the available stock
	            int newAvailableStock = book.getShelf().getAvailable_stock() - 1;
	            book.getShelf().setAvailable_stock(newAvailableStock);

	            // Increase the borrowed number
	            int newBorrowedNumber = book.getShelf().getB_number() + 1;
	            book.getShelf().setB_number(newBorrowedNumber);

	            // Set the book's status to BORROWED only if the stock reaches zero
	                book.setBookStatus(Book_status.BORROWED);
	            

	            // Save the updated book and shelf
	            session.update(book);
	            session.update(book.getShelf());

	            transaction.commit();
	            return true; // Successfully borrowed
	        } else {
	            return false; // No stock available, cannot borrow
	        }
	    } catch (Exception e) {
	        if (transaction != null) {
	            transaction.rollback();
	        }
	        e.printStackTrace();
	        return false; // Error occurred
	    }
	}

	public List<Book> getAvailableBooks() { 
	    List<Book> availableBooks;
	    try (Session session = HibernateUtil.getSession().openSession()) {
	        // Modified HQL query to include bookStatus check
	        String hql = "FROM Book b WHERE b.shelf.available_stock > 0 AND b.bookStatus = :status";
	        Query<Book> query = session.createQuery(hql, Book.class);
	        query.setParameter("status", Book_status.AVAILABLE);  // Set the parameter for bookStatus
	        
	        availableBooks = query.list();

	        // Console output for verification
	        if (availableBooks != null && !availableBooks.isEmpty()) {
	            System.out.println("Available books retrieved:");
	        } else {
	            System.out.println("No available books found.");
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	        availableBooks = null;
	    }
	    return availableBooks;
	}

	 public boolean isBookBorrowed(UUID bookId) {
	        try (Session session = HibernateUtil.getSession().openSession()) {
	            // Query to check if there are any borrowers for this book
	            String hql = "FROM Borrower b WHERE b.book.bookId = :bookId";
	            Query<Borrower> query = session.createQuery(hql, Borrower.class);
	            query.setParameter("bookId", bookId);
	            List<Borrower> borrowers = query.list();
	            return !borrowers.isEmpty();  // If there are any borrowers, return true
	        } catch (Exception e) {
	            e.printStackTrace();
	            return false;
	        }
	    }

	    // Method to delete a book
	    public boolean deleteBook(UUID bookId) {
	        try (Session session = HibernateUtil.getSession().openSession()) {
	            Transaction transaction = session.beginTransaction();

	            // Fetch the Book entity
	            Book book = session.get(Book.class, bookId);

	            if (book != null) {
	                // Check if the book is borrowed
	                if (isBookBorrowed(bookId)) {
	                    // Book is borrowed, cannot delete
	                    transaction.rollback();
	                    return false;
	                }

	                // Proceed to delete the book if not borrowed
	                session.delete(book);
	                transaction.commit();
	                return true;
	            }

	            // Book not found
	            transaction.rollback();
	            return false;
	        } catch (Exception e) {
	            e.printStackTrace();
	            return false;
	        }
	    }


		 public void update(Book book) {
		        Transaction transaction = null;
		        try (Session session = HibernateUtil.getSession().openSession()) {
		            // Start a transaction
		            transaction = session.beginTransaction();

		            // Update the book in the database
		            session.update(book);

		            // Commit the transaction
		            transaction.commit();
		        } catch (Exception e) {
		            if (transaction != null) {
		                transaction.rollback(); // Roll back on error
		            }
		            e.printStackTrace(); // Log the error for debugging
		        }
		    }
}
