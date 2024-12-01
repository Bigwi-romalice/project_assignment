package controller;


import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import model.Membership;

import model.Status;
import model.Users;
import util.HibernateUtil;

public class MembershipDao {

	public void saveMembership(Membership membership) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSession().openSession()) {
            transaction = session.beginTransaction();
            session.saveOrUpdate(membership); // Save the membership object to the database
            transaction.commit(); // Commit the transaction
        } catch (Exception e) {
            System.err.println("Error saving membership: " + e.getMessage());
            if (transaction != null) {
                transaction.rollback(); // Roll back the transaction in case of an error
            }
            e.printStackTrace(); // Print the stack trace for debugging
        }
    }

	public List<Membership> getPendingMemberships() {
	    List<Membership> pendingMemberships = new ArrayList<>();
	    Transaction transaction = null;
	    try (Session session = HibernateUtil.getSession().openSession()) {
	        transaction = session.beginTransaction();
	        pendingMemberships = session.createQuery("FROM Membership WHERE membershipStatus = :status", Membership.class)
	                                    .setParameter("status", Status.PENDING)
	                                    .getResultList();
	        transaction.commit();
	    } catch (Exception e) {
	        if (transaction != null) transaction.rollback();
	        e.printStackTrace();
	    }
	    return pendingMemberships;
	}


	 public void updateMembershipStatus(UUID membershipId, Status newStatus) {
	        Transaction transaction = null;
	        try (Session session = HibernateUtil.getSession().openSession()) {
	            transaction = session.beginTransaction();
	            Membership membership = session.get(Membership.class, membershipId);
	            if (membership != null) {
	                membership.setMembershipStatus(newStatus);
	                session.update(membership);
	                transaction.commit();
	            }
	        } catch (Exception e) {
	            if (transaction != null) transaction.rollback();
	            e.printStackTrace();
	        }
	    }

		    // Method to get membership by user
		    public Membership getMembershipByUser(Users user) {
		        Membership membership = null;

		        // Assuming you're using a database and Hibernate to fetch the data
		        Session session = HibernateUtil.getSession().openSession();
		        try {
		            session.beginTransaction();
		            
		            // Get the membership by user
		            membership = session.createQuery("FROM Membership WHERE reader = :user", Membership.class)
		                                 .setParameter("user", user)
		                                 .uniqueResult();
		            
		            session.getTransaction().commit();
		        } catch (Exception e) {
		            e.printStackTrace();
		        } finally {
		            session.close();
		        }

		        return membership;
		    }
		    public Membership getMembershipByUserId(UUID userId) {
		        Membership membership = null;
		        try (Session session = HibernateUtil.getSession().openSession()) {
		            String hql = "FROM Membership m WHERE m.reader.userId = :userId AND m.membershipStatus = :status";
		            Query<Membership> query = session.createQuery(hql, Membership.class);
		            query.setParameter("userId", userId);
		            query.setParameter("status", Status.APPROVED); // assuming we only want active memberships
		            membership = query.uniqueResult();
		        } catch (Exception e) {
		            e.printStackTrace();
		        }
		        return membership;
		    }


	
}
	
