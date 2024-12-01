package model;

import java.util.Date;
import java.util.UUID;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;





@Entity
@Table(name="book")
public class Book {

	@Id
	@GeneratedValue
    private UUID bookId;
	private int edition;
	private String title;
	private String pub_name ;
	
	@Column(name="publication_year")
	private Date pub_year;
	
	@Column(name="ISBN_code")
	private String isbn_code ;
	
	@Enumerated(EnumType.STRING)
	@Column(name="book_status")
	private Book_status bookStatus;
	
	@ManyToOne
	@JoinColumn(name = "shelf_id")
	private Shelf shelf;


	public Book() {
	}


	public Book(UUID bookId, int edition, String title, String pub_name, Date pub_year, String isbn_code,
			Book_status bookStatus, Shelf shelf) {
		this.bookId = bookId;
		this.edition = edition;
		this.title = title;
		this.pub_name = pub_name;
		this.pub_year = pub_year;
		this.isbn_code = isbn_code;
		this.bookStatus = bookStatus;
		this.shelf = shelf;
	}


	public UUID getBookId() {
		return bookId;
	}


	public void setBookId(UUID bookId) {
		this.bookId = bookId;
	}


	public int getEdition() {
		return edition;
	}


	public void setEdition(int edition) {
		this.edition = edition;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public String getPub_name() {
		return pub_name;
	}


	public void setPub_name(String pub_name) {
		this.pub_name = pub_name;
	}


	public Date getPub_year() {
		return pub_year;
	}


	public void setPub_year(Date pub_year) {
		this.pub_year = pub_year;
	}


	public String getIsbn_code() {
		return isbn_code;
	}


	public void setIsbn_code(String isbn_code) {
		this.isbn_code = isbn_code;
	}


	public Book_status getBookStatus() {
		return bookStatus;
	}


	public void setBookStatus(Book_status bookStatus) {
		this.bookStatus = bookStatus;
	}


	public Shelf getShelf() {
		return shelf;
	}


	public void setShelf(Shelf shelf) {
		this.shelf = shelf;
	}	
 
}
