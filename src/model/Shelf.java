package model;

import java.util.List;
import java.util.UUID;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;


@Entity
@Table(name="shelf")
public class Shelf {

	@Id
	@GeneratedValue
	private UUID shelfId;
	private int available_stock;
	private int initial_stock;
	private String bookCategory;

	@Column(name="borrowed_number")
	private int b_number;

	@ManyToOne
	@JoinColumn(name = "roomid", referencedColumnName = "roomid", nullable = false)
	private Room room;

	
	@OneToMany(mappedBy = "shelf")
	private List<Book> books;

	
	public Shelf() {
	}


	public UUID getShelfId() {
		return shelfId;
	}


	public void setShelfId(UUID shelfId) {
		this.shelfId = shelfId;
	}


	public int getAvailable_stock() {
		return available_stock;
	}


	public void setAvailable_stock(int available_stock) {
		this.available_stock = available_stock;
	}


	public int getInitial_stock() {
		return initial_stock;
	}


	public void setInitial_stock(int initial_stock) {
		this.initial_stock = initial_stock;
	}


	public String getBookCategory() {
		return bookCategory;
	}


	public void setBookCategory(String bookCategory) {
		this.bookCategory = bookCategory;
	}


	public int getB_number() {
		return b_number;
	}


	public void setB_number(int b_number) {
		this.b_number = b_number;
	}


	public Room getRoom() {
		return room;
	}


	public void setRoom(Room room) {
		this.room = room;
	}


	public List<Book> getBooks() {
		return books;
	}


	public void setBooks(List<Book> books) {
		this.books = books;
	}
	

}


