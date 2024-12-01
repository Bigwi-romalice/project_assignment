package model;

import java.util.List;
import java.util.UUID;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="location")
public class Location {
	
	@Id
	@GeneratedValue
    private UUID locationId;

	@Column(name="location_code", nullable = false)
	private String locationCode;

	@Column(name="location_name", nullable = false)
	private String locationName;
	
	@Enumerated(EnumType.STRING)
	@Column(name="location_type", nullable = false)
	private Location_type locationType;

	@ManyToOne
    @JoinColumn(name = "parent_id")
    private Location parent;

    @OneToMany(mappedBy = "parent", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Location> subLocations;

    @OneToMany(mappedBy = "village", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Users> users;

    // Default constructor
	public Location() {}

    // Constructor for child locations with parent
    public Location(String locationCode, String locationName, Location_type locationType, Location parent) {
        this.locationCode = locationCode;
        this.locationName = locationName;
        this.locationType = locationType;
        this.parent = parent;
    }

	// Getters and Setters
	public UUID getLocationId() {
		return locationId;
	}

	public void setLocationId(UUID locationId) {
		this.locationId = locationId;
	}

	public String getLocationCode() {
		return locationCode;
	}

	public void setLocationCode(String locationCode) {
		this.locationCode = locationCode;
	}

	public String getLocationName() {
		return locationName;
	}

	public void setLocationName(String locationName) {
		this.locationName = locationName;
	}

	public Location_type getLocationType() {
		return locationType;
	}

	public void setLocationType(Location_type locationType) {
		this.locationType = locationType;
	}

	public Location getParent() {
		return parent;
	}

	public void setParent(Location parent) {
		this.parent = parent;
	}

	public List<Location> getSubLocations() {
		return subLocations;
	}

	public void setSubLocations(List<Location> subLocations) {
		this.subLocations = subLocations;
	}

	public List<Users> getUsers() {
		return users;
	}

	public void setUsers(List<Users> users) {
		this.users = users;
	}
}
