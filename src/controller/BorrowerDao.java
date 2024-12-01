package controller;

import model.Borrower;
import model.Users;
import util.HibernateUtil;
import model.Membership;
import model.Membership_type;
import model.Shelf;
import model.Book;
import model.Book_status;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

public class BorrowerDao {

	
	  // Method to save a new Borrower record
    public void saveBorrower(Borrower borrower) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSession().openSession()) {
            transaction = session.beginTransaction();
            session.save(borrower);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }

    
   

    public Borrower getBorrowerById(UUID borrowerId) {
        Borrower borrower = null;
        try (Session session = HibernateUtil.getSession().openSession()) {
            // Query to fetch Borrower by UUID
            String hql = "FROM Borrower WHERE id = :borrowerId";
            Query<Borrower> query = session.createQuery(hql, Borrower.class);
            query.setParameter("borrowerId", borrowerId);

            // Retrieve the single result (or null if not found)
            borrower = query.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return borrower;
    }


	public List<Borrower> getAllBorrowers() {
	    List<Borrower> borrowers = new ArrayList<>();
	    try (Session session = HibernateUtil.getSession().openSession()) {
	        borrowers = session.createQuery("From Borrower", Borrower.class).list();
	        System.out.println("Number of borrowers retrieved: " + borrowers.size()); // Check the size
	    } catch (Exception e) {
	        e.printStackTrace();  // Log any exceptions
	    }
	    return borrowers;
	}
	
	public List<Borrower> getBorrowersWithBorrowedBooks() {
	    List<Borrower> borrowers = new ArrayList<>();
	    try (Session session = HibernateUtil.getSession().openSession()) {
	        // Corrected HQL query to use the exact field name in the Book class
	    	String hql = "SELECT br FROM Borrower br JOIN br.book b WHERE b.bookStatus = :status AND br.return_date IS NULL";
	        Query<Borrower> query = session.createQuery(hql, Borrower.class);
	        query.setParameter("status", Book_status.BORROWED); // Set the status to 'BORROWED'

	        borrowers = query.list();

	        // Output the number of borrowers with borrowed books
	        System.out.println("Number of borrowers with borrowed books: " + borrowers.size());

	    } catch (Exception e) {
	        e.printStackTrace();  // Log any exceptions
	    }
	    return borrowers;
	}

	public boolean returnBorrowedBook(UUID borrowerId) {
	    try (Session session = HibernateUtil.getSession().openSession()) {
	        Transaction transaction = session.beginTransaction();

	        // Fetch the Borrower record for the given borrowerId
	        Borrower borrower = session.get(Borrower.class, borrowerId);

	        if (borrower != null) {
	            // Step 1: Update the return date of the borrower
	            borrower.setReturn_date(new Date()); // Set the current date as return date

	            // Step 2: Get the book and shelf associated with this borrower
	            Book book = borrower.getBook();
	            Shelf shelf = book.getShelf(); // Assuming there's a Shelf object related to the Book

	            // Step 3: Increase the available stock in the shelf table
	            int currentStock = shelf.getAvailable_stock();
	            shelf.setAvailable_stock(currentStock + 1);  // Increase stock by 1

	            // Step 4: Change the book status to "available"
	            book.setBookStatus(Book_status.AVAILABLE);

	            // Step 5: Calculate and set late fees if applicable
	            double fine = 0.0;
	            if (borrower.getDueDate() != null && new Date().after(borrower.getDueDate())) {
	                long diff = new Date().getTime() - borrower.getDueDate().getTime();
	                int overdueDays = (int) (diff / (1000 * 60 * 60 * 24));  // Convert milliseconds to days

	                // Retrieve the user and membership information
	                Users user = borrower.getReader();
	                if (user != null) {
	                    Membership membership = session.createQuery(
	                        "FROM Membership m WHERE m.reader = :user", Membership.class)
	                        .setParameter("user", user)
	                        .uniqueResult();

	                    if (membership != null) {
	                        Membership_type membershipType = membership.getMembershipType();
	                        if (membershipType != null) {
	                            fine = membershipType.getPrice();
	                        }
	                    }
	                }
	                // Calculate the total late fees based on overdue days and the fine rate
	                int totalFees = (int) (overdueDays * fine);
	                int fineInt = (int) fine;

	                // Update borrower with calculated fees
	                borrower.setFine(fineInt);
	                borrower.setLate_fees(totalFees);
	            }

	            // Step 6: Persist all updates in the database
	            session.update(shelf);   // Update the shelf with new stock
	            session.update(book);    // Update the book status
	            session.update(borrower); // Update borrower with return date and calculated fees

	            // Commit the transaction
	            transaction.commit();
	            return true;
	        } else {
	            // No matching borrower found, rollback and return false
	            transaction.rollback();
	            return false;
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}

	
}
