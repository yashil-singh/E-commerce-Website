package model;

import java.io.File;

import javax.servlet.http.Part;

import resources.MyConstants;

public class User {
	String firstname, lastname, username, password, role, imageUrlFromPart;

	public User() {}
	
	public User(String firstname, String lastname, String username, Part part) {
		this.firstname = firstname;
		this.lastname = lastname;
		this.username = username;
		this.imageUrlFromPart = getImageUrl(part);
	}
	
	public User(String firstname, String lastname, String username, 
			String password, String role, Part part){
		this.firstname = firstname;
		this.lastname = lastname;
		this.username = username;
		this.password = password;
		this.role = role;
		this.imageUrlFromPart = getImageUrl(part);
	}
	
	public String getFirstName() {
		return firstname;
	}
	public void setFirstName(String firstname) {
		this.firstname = firstname;
	}
	public String getLastName() {
		return lastname;
	}
	public void setLastName(String lastname) {
		this.lastname = lastname;
	}
	public String getUsername() {
		return username	;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;		
	}
	private String getImageUrl(Part part) {
		String savePath = MyConstants.IMGSAVEPATH;
		File fileSaveDir = new File(savePath);
		String imageUrlFromPart = null;
		if (!fileSaveDir.exists()) {
			fileSaveDir.mkdir();
		}
		String contentDisp = part.getHeader("content-disposition");
		String[] items = contentDisp.split(";");
		for (String s : items) {
			if (s.trim().startsWith("filename")) {
				imageUrlFromPart = s.substring(s.indexOf("=") + 2, s.length() - 1);
			}
		}
		if(imageUrlFromPart == null || imageUrlFromPart.isEmpty()) {
			imageUrlFromPart= "download.png";
		}
		return imageUrlFromPart;
	}
	
	public String getImageUrlFromPart() {
		return imageUrlFromPart;
	}
	
	public void setImageUrlFromPart(Part part) {
		this.imageUrlFromPart = getImageUrl(part);
	}
}
