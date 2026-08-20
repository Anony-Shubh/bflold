package net.java.md5;

import org.apache.commons.codec.digest.DigestUtils;

public class JavaMD5Hash {

	public static void main(String[] args) {

			String password = request.getParameter("password");

			System.out.println( DigestUtils.md5Hex( password ) );

	}
}