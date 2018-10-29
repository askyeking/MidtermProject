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

@Entity
@Table(name = "meetup_comment")
public class MeetupComment {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	
	@Column(name="text_content")
	private String textContent;
	
	@Column(name="post_date")
	@Temporal(TemporalType.TIMESTAMP)
	private Date postDate;
	
	private boolean active;

	@ManyToMany
	@JoinTable(name="meetup_comment_like",
	joinColumns=@JoinColumn(name="meetup_comment_id"),
	inverseJoinColumns=@JoinColumn(name="user_id"))
	private List<User> userMeetupCommentLikers;
	
	//(cascade = {CascadeType.PERSIST, CascadeType.REMOVE})
	@ManyToOne
	@JoinColumn(name="user_id")
	private User meetupCommentOwner;
	
	//(cascade = {CascadeType.PERSIST, CascadeType.REMOVE})
	@ManyToOne
	@JoinColumn(name="meetup_id")
	private Meetup meetupCommentedOn;
	
	
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
