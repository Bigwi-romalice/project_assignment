package model;

import java.util.Set;
import java.util.UUID;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;


@Entity
@Table(name="users")
public class Users extends Person {
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private UUID userId;
	
	@Column(name="user_name")
	private String userName;
	
	@Column(nullable = false)
	private String password;

	@Enumerated(EnumType.STRING)
    @Column(nullable = false)
	private Role role;
	
	@ManyToOne
	@JoinColumn(name = "village_id", nullable = false)
	private Location village;

    @OneToMany(mappedBy = "reader", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<Borrower> borrowings;
	 
    public Users() {
	}


	public Users(String personId, String firstName, String lastName, Gender gender, String pnumber, UUID userId,
			String userName, String password, Role role, Location village) {
		super(personId, firstName, lastName, gender, pnumber);
		this.userId = userId;
		this.userName = userName;
		this.password = password;
		this.role = role;
		this.village = village;
	}
	
	

	public UUID getUserId() {
		return userId;
	}

	public void setUserId(UUID userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public Location getVillage() {
		return village;
	}

	public void setVillage(Location village) {
		this.village = village;
	}

	public Set<Borrower> getBorrowings() {
		return borrowings;
	}

	public void setBorrowings(Set<Borrower> borrowings) {
		this.borrowings = borrowings;
	}

	
}
