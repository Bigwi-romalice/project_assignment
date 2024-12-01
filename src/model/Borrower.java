package model;

import java.util.Date;
import java.util.UUID;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;



@Entity
@Table(name="borrower")
public class Borrower {

    @Id
    @GeneratedValue
    private UUID id;
	
	private Date dueDate;
	private int fine;
	private Date return_date;	
	
	@Column(name="late_charges")
	private int late_fees ;

	@Column(name="pickup_Date")
	private Date pickup_date;
	
    @ManyToOne
    @JoinColumn(name = "book_id")
    private Book book;
	
    @ManyToOne
    @JoinColumn(name = "reader_id")
    private Users reader;

	public Borrower() {
	}

	public Borrower(UUID id, Date dueDate, int fine, Date return_date, int late_fees, Date pickup_date, Book book,
			Users reader) {
		this.id = id;
		this.dueDate = dueDate;
		this.fine = fine;
		this.return_date = return_date;
		this.late_fees = late_fees;
		this.pickup_date = pickup_date;
		this.book = book;
		this.reader = reader;
	}



	public UUID getId() {
		return id;
	}

	public void setId(UUID id) {
		this.id = id;
	}

	public Date getDueDate() {
		return dueDate;
	}

	public void setDueDate(Date dueDate) {
		this.dueDate = dueDate;
	}

	public int getFine() {
		return fine;
	}

	public void setFine(int fine) {
		this.fine = fine;
	}

	public Date getReturn_date() {
		return return_date;
	}

	public void setReturn_date(Date return_date) {
		this.return_date = return_date;
	}

	public int getLate_fees() {
		return late_fees;
	}

	public void setLate_fees(int late_fees) {
		this.late_fees = late_fees;
	}

	public Date getPickup_date() {
		return pickup_date;
	}

	public void setPickup_date(Date pickup_date) {
		this.pickup_date = pickup_date;
	}

	public Book getBook() {
		return book;
	}

	public void setBook(Book book) {
		this.book = book;
	}

	public Users getReader() {
		return reader;
	}

	public void setReader(Users reader) {
		this.reader = reader;
	}
	
    
    
}
