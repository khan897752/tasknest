package com.tasknest.model;

public class AccountUser {
	private int id;
    private String fullname;
    private String email;
    private String username;
    private String password;
    private String role;
    private String created_at;
    
    public AccountUser() {}

    public AccountUser(String fullname, String email, String username, String password, String role) {
        this.fullname = fullname;
        this.email = email;
        this.username = username;
        this.password = password;
        this.role = role;
    }

    
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getFullname() {
		return fullname;
	}
	public void setFullname(String fullname) {
		this.fullname = fullname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getUsername() {
		return username;
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
	public String getCreated_at() {
		return created_at;
	}
	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}
    


}
