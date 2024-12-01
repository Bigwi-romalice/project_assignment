package model;

import javax.persistence.Column;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.MappedSuperclass;

@MappedSuperclass
public class Person {
	
	@Column(name="person_id")
	private String PersonId ;

	@Column(name="first_name")
	private String firstName;

	@Column(name="last_name")
	private String lastName;
	
	@Enumerated(EnumType.STRING)
	@Column(name="gender")
	private Gender gender;

	@Column(name="phone_number")
	private String Pnumber;

	
	
	public Person() {
	}

	public Person(String personId, String firstName, String lastName, Gender gender, String pnumber) {
		PersonId = personId;
		this.firstName = firstName;
		this.lastName = lastName;
		this.gender = gender;
		Pnumber = pnumber;
	}

	public String getPersonId() {
		return PersonId;
	}

	public void setPersonId(String personId) {
		PersonId = personId;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public Gender getGender() {
		return gender;
	}

	public void setGender(Gender gender) {
		this.gender = gender;
	}

	public String getPnumber() {
		return Pnumber;
	}

	public void setPnumber(String pnumber) {
		Pnumber = pnumber;
	}

}

