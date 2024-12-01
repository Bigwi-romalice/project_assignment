package controller;

import org.hibernate.Session;
import org.hibernate.Transaction;
import model.Room;
import util.HibernateUtil;
import java.util.List;

public class roomDao {

	    public void addRoom(Room room) {
	        try (Session session = HibernateUtil.getSession().openSession()) {
	            Transaction transaction = session.beginTransaction();
	            session.merge(room);
	            transaction.commit();
	        }
	    }

	    public List<Room> getAllRooms() {
	        try (Session session = HibernateUtil.getSession().openSession()) {
	            return session.createQuery("from Room", Room.class).list();
	        }
	    }
	}


