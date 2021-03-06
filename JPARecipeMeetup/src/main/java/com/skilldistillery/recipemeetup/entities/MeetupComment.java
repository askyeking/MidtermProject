package com.skilldistillery.recipemeetup.entities;

import java.util.ArrayList;
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
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

//This entity informs JPA that the class represents a table from the database (Instances will hold values from the table rows, and can populate the DB).
@Entity
@Table(name = "meetup_comment")
public class MeetupComment {
	
	// The fields below correlate with fields in the address table in the database
	// Id is a primary key and autogenerated by the database, hence annotated with Id and GeneratedValue
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	
	@Column(name="text_content")
	private String textContent;
	
	@Column(name="post_date")
	@Temporal(TemporalType.TIMESTAMP)
	private Date postDate;
	
	private boolean active;

	/* A join table annotation is used for  mapping  many-to-many association. 
	 * The join table is a simple merge table that has a ManyToOne connection to both tables, allowing for a ManyToMany relationship to be mapped through this table.
	 * joinColumn corresponds to the foreign key column in the DB to this class
	 * inverseJoinColumns corresponds to the  foreign key column in the DB to the other class
	 */
	@ManyToMany
	@JoinTable(name="meetup_comment_like",
	joinColumns=@JoinColumn(name="meetup_comment_id"),
	inverseJoinColumns=@JoinColumn(name="user_id"))
	private List<User> userMeetupCommentLikers;
	
	@ManyToOne
	@JoinColumn(name="user_id")
	private User meetupCommentOwner;
	
	@ManyToOne
	@JoinColumn(name="meetup_id")
	private Meetup meetupCommentedOn;
	
	
	
	//Below this point you will find simple add and remove methods for other fields; getters and setters; and toString;
	// More info about these methods inside Address Entity around line 44.
	
	public void addUserMeetupCommentLiker(User commentLiker) {
        if(userMeetupCommentLikers== null) {
            userMeetupCommentLikers = new ArrayList<>();
        }
        
        if(!userMeetupCommentLikers.contains(commentLiker)) {
            userMeetupCommentLikers.add(commentLiker);
            commentLiker.addMeetupCommentLike(this);
        }
        
    }
    
    public void removeUserMeetupCommentLiker(User commentLiker) {
        if(userMeetupCommentLikers != null && userMeetupCommentLikers.contains(commentLiker)) {
        userMeetupCommentLikers.remove(commentLiker);
        commentLiker.removeMeetupCommentLike(this);
        }
    }
	
	public MeetupComment() {
		super();
	}

	public MeetupComment(int id,  String textContent, Date postDate, boolean active) {
		super();
		this.id = id;
		this.textContent = textContent;
		this.postDate = postDate;
		this.active = active;
	}

	public int getId() {
		return id;
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
		return "MeetupComment [id=" + id + ", userID=" +  ", meetupID=" +", textContent="
				+ textContent + ", postDate=" + postDate + ", active=" + active + "]";
	}

	public List<User> getUserMeetupCommentLikers() {
		return userMeetupCommentLikers;
	}

	public void setUserMeetupCommentLikers(List<User> userMeetupCommentLikers) {
		this.userMeetupCommentLikers = userMeetupCommentLikers;
	}

	public User getMeetupCommentOwner() {
		return meetupCommentOwner;
	}

	public void setMeetupCommentOwner(User meetupCommentOwner) {
		this.meetupCommentOwner = meetupCommentOwner;
	}

	public Meetup getMeetupCommentedOn() {
		return meetupCommentedOn;
	}

	public void setMeetupCommentedOn(Meetup meetupCommentedOn) {
		this.meetupCommentedOn = meetupCommentedOn;
	}
}
