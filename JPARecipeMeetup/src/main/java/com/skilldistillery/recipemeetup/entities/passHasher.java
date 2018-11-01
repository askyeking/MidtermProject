package com.skilldistillery.recipemeetup.entities;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.xml.bind.DatatypeConverter;

public class passHasher {

	public static void main(String[] args) {
		
		MessageDigest md = null;
		try {
			md = MessageDigest.getInstance("MD5");
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		String password = "Prince23";
		
		md.update(password.getBytes());
		byte[] digest = md.digest();

		String hashedPass = DatatypeConverter.printHexBinary(digest).toLowerCase();
		
		System.out.println(hashedPass);
	}

}
