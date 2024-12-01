package util;

import java.util.Properties;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.cfg.Environment;
import model.Book;
import model.Borrower;
import model.Location;
import model.Membership;
import model.Membership_type;
import model.Room;
import model.Shelf;
import model.Users;

public class HibernateUtil {

	public static SessionFactory sessionFactory = null;

	public static SessionFactory getSession() {
		
		if(sessionFactory == null) {
			try {
				Configuration conf = new Configuration();
				
				Properties settings = new Properties();

                settings.put(Environment.DRIVER, "org.postgresql.Driver");
                settings.put(Environment.URL, "jdbc:postgresql://localhost:5432/auca_library_db");
                settings.put(Environment.USER, "postgres");
                settings.put(Environment.PASS, "123");
                settings.put(Environment.DIALECT, "org.hibernate.dialect.PostgreSQLDialect");
                settings.put(Environment.HBM2DDL_AUTO, "update");
                settings.put(Environment.SHOW_SQL, "true");

                conf.setProperties(settings);

                // Add annotated classes
                conf.addAnnotatedClass(Users.class);
                conf.addAnnotatedClass(Book.class);
                conf.addAnnotatedClass(Borrower.class);
                conf.addAnnotatedClass(Location.class);
                conf.addAnnotatedClass(Membership.class);
                conf.addAnnotatedClass(Membership_type.class);
                conf.addAnnotatedClass(Room.class);
                conf.addAnnotatedClass(Shelf.class);
				
                sessionFactory = conf.buildSessionFactory();
			}catch(Exception ex) {
				System.out.println("Error Message is : "+ex.getMessage());
			}

			return sessionFactory;
		}else {
			return sessionFactory;
		}
	}
}
