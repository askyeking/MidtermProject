package com.skilldistillery.recipemeetup.entities;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.CreationTimestamp;

@Entity
public class Meetup {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String title;

	@Column(name = "address_id")
	private int addressID;

	@Column(name = "date_created")
	@Temporal(TemporalType.TIMESTAMP)
	@CreationTimestamp
	private Date createDate;
	
	@Column(name="img_url")
	private String imgURL;
	
	private String description;
	
	@Column(name="author_id")
	private int authorID;
	
	@Column(name="maximum_attendance")
	private int maxAttendance;
	
	private boolean active;
	
	@Column(name="start_time")
	@Temporal(TemporalType.TIMESTAMP)
	private Date startTime;
	
	@Column(name="end_time")
	@Temporal(TemporalType.TIMESTAMP)
	private Date endTime;

	public Meetup() {
		super();
	}

	public Meetup(int id, String title, int addressID, Date createDate, String imgURL, String description, int authorID, int maxAttendance,
			boolean active, Date startTime, Date endTime) {
		super();
		this.id = id;
		this.title = title;
		this.addressID = addressID;
		this.createDate = createDate;
		this.imgURL = imgURL;
		this.description = description;
		this.authorID = authorID;
		this.maxAttendance = maxAttendance;
		this.active = active;
		this.startTime = startTime;
		this.endTime = endTime;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getTitle() {
		return title;
	}

	public void setName(String name) {
		this.title = title;
	}

	public int getAddressID() {
		return addressID;
	}

	public void setAddressID(int addressID) {
		this.addressID = addressID;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getImgURL() {
		return imgURL;
	}

	public void setImgURL(String imgURL) {
		this.imgURL = imgURL;
	}

	public int getAuthorID() {
		return authorID;
	}

	public void setAuthorID(int authorID) {
		this.authorID = authorID;
	}

	public int getMaxAttendance() {
		return maxAttendance;
	}

	public void setMaxAttendance(int maxAttendance) {
		this.maxAttendance = maxAttendance;
	}

	public Boolean getActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}

	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Meetup other = (Meetup) obj;
		if (id != other.id)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Meetup [id=" + id + ", title=" + title + ", addressID=" + addressID + ", createDate=" + createDate
				+ ", imgURL=" + imgURL + ", description=" + description + ", authorID=" + authorID + ", maxAttendance=" + maxAttendance + ", active="
				+ active + ", startTime=" + startTime + ", endTime=" + endTime + "]";
	}
}
