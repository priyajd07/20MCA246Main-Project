package com.example.onlineexam;

import java.util.Date;

public class ChatMessage {

	private String username;
	private String message;
	private Date date;
	private boolean incomingMessage;
	
	public ChatMessage() {
		super();
	}
	public ChatMessage(String message) {
		super();
		this.message = message;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public boolean isIncomingMessage() {
		return incomingMessage;
	}
	public void setIncomingMessage(boolean incomingMessage) {
		this.incomingMessage = incomingMessage;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public boolean isSystemMessage(){
		return getUsername()==null;
	}
}
