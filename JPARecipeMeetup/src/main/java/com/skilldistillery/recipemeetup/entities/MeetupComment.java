package com.skilldistillery.recipemeetup.entities;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "meetup_comment")
public class MeetupComment {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	
	@Column(name="user_id")
	private int userID;
		
	@Column(name="meetup_id")
	private int meetupID;
	
	@Column(name="text_content")
	private String textContent;
	
	@Column(name="post_date")
	@Temporal(TemporalType.TIMESTAMP)
	private Date postDate;
	
	private boolean active;

	@ManyToMany(cascade = {CascadeType.PERSIST, CascadeType.REMOVE})
	@JoinTable(name="meetup_comment_like",
	joinColumns=@JoinColumn(name="meetup_comment_id"),
	inverseJoinColumns=@JoinColumn(name="user_id"))
	private List<User> userMeetupCommentLikes;
	
	public MeetupComment() {
		super();
	}

	public MeetupComment(int id, int userID, int meetupID, String textContent, Date postDate, boolean active) {
		super();
		this.id = id;
		this.userID = userID;
		this.meetupID = meetupID;
		this.textContent = textContent;
		this.postDate = postDate;
		this.active = active;
	}
	
	

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public int getMeetupID() {
		return meetupID;
	}

	public void setMeetupID(int meetupID) {
		this.meetupID = meetupID;
	}

	public String getTextContent() {
		return textContent;
	}

	public void setTextContent(String textContent) {
		this.textContent = textContent;
	}

	public Date getPostDate() {
		return postDate;
	}

	public void setPostDate(Date postDate) {
		this.postDate = postDate;
	}

	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
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
		MeetupComment other = (MeetupComment) obj;
		if (id != other.id)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "MeetupComment [id=" + id + ", userID=" + userID + ", meetupID=" + meetupID + ", textContent="
				+ textContent + ", postDate=" + postDate + ", active=" + active + "]";
	}

	public List<User> getUserMeetupCommentLikes() {
		return userMeetupCommentLikes;
	}

	public void setUserMeetupCommentLikes(List<User> userMeetupCommentLikes) {
		this.userMeetupCommentLikes = userMeetupCommentLikes;
	}
}
