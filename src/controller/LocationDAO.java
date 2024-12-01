package controller;

import model.Location;
import model.Location_type;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import util.HibernateUtil;

import java.util.List;
import java.util.UUID;

public class LocationDAO {

    private SessionFactory sessionFactory;

    public LocationDAO() {
        this.sessionFactory = HibernateUtil.getSession();
    }

    // Method to check if a location exists, or create it if not
    public Location getOrCreateLocation(String name, Location_type type, Location parent) {
        Session session = null;
        Transaction transaction = null;
        try {
            session = sessionFactory.openSession();

            // Query to check if the location already exists
            Query<Location> query = session.createQuery(
                "FROM Location WHERE locationName = :name AND locationType = :type AND parent = :parent", Location.class);
            query.setParameter("name", name);
            query.setParameter("type", type);
            query.setParameter("parent", parent);

            Location location = query.uniqueResult();

            // If the location exists, return it
            if (location != null) {
                return location;
            }

            // If it does not exist, create and save a new location
            transaction = session.beginTransaction();
            String locationCode = generateLocationCode(name, type, parent); // Generate the code
            location = new Location(locationCode, name, type, parent);
            session.save(location);
            transaction.commit();

            return location;

        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
        return null;
    }

    // Helper method to generate a unique location code based on hierarchy
    private String generateLocationCode(String name, Location_type type, Location parent) {
        String parentCode = (parent != null && parent.getLocationCode() != null) ? parent.getLocationCode() : "";
        return parentCode + "-" + type.name().substring(0, 3) + "-" + name.replaceAll("\\s", "").toUpperCase();
    }



	// Method to fetch all top-level locations (provinces)
    public List<Location> getTopLevelLocations() {
        try (Session session = sessionFactory.openSession()) {
            Query<Location> query = session.createQuery("FROM Location WHERE parentId IS NULL", Location.class);
            return query.getResultList();
        }
    }

    // Method to fetch child locations of a given parent location (e.g., districts in a province)
    public List<Location> getChildLocations(UUID parentId) {
        try (Session session = sessionFactory.openSession()) {
            Query<Location> query = session.createQuery("FROM Location WHERE parentId = :parentId", Location.class);
            query.setParameter("parentId", parentId);
            return query.getResultList();
        }
    }

    // Method to retrieve a specific location by ID
    public Location getLocationById(UUID locationId) {
        try (Session session = sessionFactory.openSession()) {
            return session.get(Location.class, locationId);
        }
    }
}
