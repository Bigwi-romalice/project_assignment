package controller;

import model.Location;
import model.Location_type;
import model.Users;
import util.HibernateUtil;


import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class UserDao {

	 public void registerUser(Users user) {
	        Transaction transaction = null;
	        Session session = null; // Declare session here
	        try {
	            session = HibernateUtil.getSession().openSession(); // Open a new session
	            transaction = session.beginTransaction();
	            session.save(user);
	            transaction.commit();
	        } catch (Exception e) {
	            if (transaction != null) {
	            	System.out.println(e.getMessage());
	                transaction.rollback(); // Roll back if there was an error
	            }
	            e.printStackTrace(); // Print the error for debugging
	        } finally {
	            if (session != null) {
	                session.close(); // Close the session in the finally block
	            }
	        }
	    }

	 public Users getUserByUsername(String username) {
		    Transaction transaction = null;
		    Users user = null;
		    try (Session session = HibernateUtil.getSession().openSession()) {
		        transaction = session.beginTransaction();

		        // Perform the query
		        user = session.createQuery("FROM Users u WHERE u.userName = :username", Users.class)
		                      .setParameter("username", username)
		                      .uniqueResult();

		        transaction.commit(); // Commit if no errors
		    } catch (Exception e) {
		        if (transaction != null) {
		        	System.out.println(e.getMessage());
		            transaction.rollback(); // Roll back in case of errors
		        }
		        e.printStackTrace();
		    }
		    return user;
		}

	 public Users getUserByPhoneNumber(String phoneNumber) {
	        try (Session session = HibernateUtil.getSession().openSession()) {
	        	String hql = "FROM Users u WHERE u.Pnumber = :phoneNumber";
	            Query<Users> query = session.createQuery(hql, Users.class);
	            query.setParameter("phoneNumber", phoneNumber);
	            return query.uniqueResult();
	        } catch (Exception e) {
	            e.printStackTrace();
	            System.out.println(e.getMessage());
	            return null;
	        }
	    }

	    public Location getProvinceByVillage(Location village) {
	        if (village == null) return null;

	        try (Session session = HibernateUtil.getSession().openSession()) {
	            // Traverse to the parent locations until we reach the province
	            Location current = village;
	            while (current.getParent() != null) {
	                current = current.getParent();
	            }
	            return current.getLocationType() == Location_type.PROVINCE ? current : null;
	        } catch (Exception e) {
	            e.printStackTrace();
	            return null;
	        }
	    }
 
}
