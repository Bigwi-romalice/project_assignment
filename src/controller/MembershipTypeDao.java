package controller;

import model.Membership_type;
import util.HibernateUtil;

import java.util.List;
import java.util.UUID;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;



public class MembershipTypeDao {

	public boolean hasMembershipTypes() {
        try (Session session = HibernateUtil.getSession().openSession()) {
            Query<Long> query = session.createQuery("SELECT COUNT(m) FROM Membership_type m", Long.class);
            Long count = query.uniqueResult();
            return count > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public void saveDefaultMembershipTypes() {
        try (Session session = HibernateUtil.getSession().openSession()) {
            Transaction transaction = session.beginTransaction();
            
            // Create default membership types
            Membership_type gold = new Membership_type( 5, 50.0, "gold");
            Membership_type silver = new Membership_type(3, 30.0, "silver");
            Membership_type striver = new Membership_type( 2, 10.0, "striver");

            // Save them to the database
            session.save(gold);
            session.save(silver);
            session.save(striver);

            transaction.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public List<Membership_type> getAllMembershipTypes() {
        try (Session session = HibernateUtil.getSession().openSession()) {
            return session.createQuery("FROM Membership_type", Membership_type.class).list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public void addMembershipType(Membership_type membershipType) {
        try (Session session = HibernateUtil.getSession().openSession()) {
            session.beginTransaction();
            session.save(membershipType);
            session.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Membership_type getMembershipTypeById(UUID membershipTypeId) {
        Transaction transaction = null;
        Membership_type membershipType = null;

        try (Session session = HibernateUtil.getSession().openSession()) {
            transaction = session.beginTransaction();
            // Create a query to fetch the Membership_type by its ID
            Query<Membership_type> query = session.createQuery("FROM Membership_type WHERE membershipTypeId = :membershipId", Membership_type.class);
            query.setParameter("membershipId", membershipTypeId);
            membershipType = query.uniqueResult(); // Fetch the single result
            transaction.commit();
        } catch (Exception e) {
        	System.out.println(e.getMessage());
            if (transaction != null) transaction.rollback();
//            e.printStackTrace();
        }

        return membershipType; // Return the retrieved Membership_type
    }
}
