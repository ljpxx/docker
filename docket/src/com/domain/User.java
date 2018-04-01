package com.domain;

public class User {
	private String id;
	private String password;
	private String name;
	private String type;
	
	public User(){
		
	}

	public User(String id,String name,String password,String type){
		this.id=id;
		this.name=name;
		this.password=password;
		this.type=type;
	}
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	
}
