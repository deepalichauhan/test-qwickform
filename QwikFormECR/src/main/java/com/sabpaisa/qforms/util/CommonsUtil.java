package com.sabpaisa.qforms.util;

import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ResponseBody;

public class CommonsUtil {
	


	public CommonsUtil() {}
	
	public String getAlphaNumericString(int n) {

		char[] symbolsString1 = new char[] {};
		StringBuilder tmp = new StringBuilder();
		char ch = 'a';
		while (ch <= 'g') {
			tmp.append(ch);
			char ch1 = 'a';
			while (ch1 <= 'd') {
				tmp.append(ch1);
				symbolsString1 = tmp.toString().toCharArray();
				ch1 = (char) (ch1 + '\u0001');
			}
			ch = (char) (ch + '\u0001');
		}
		double captNumber = 5.0 + Math.random() * 5.0;
		String genCapt = String.valueOf(captNumber).substring(2, 4);
		String ranGenString = symbolsString1.toString().substring(3, 7);
		String genAlphaNum = String.valueOf(ranGenString) + genCapt;
		String AlphaNumericString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ" + "0123456789" + "abcdefghijklmnopqrstuvxyz";
		StringBuilder sb = new StringBuilder(n);
		
		for (int i = 0; i < n; i++) {
			int index = (int) (AlphaNumericString.length() * Math.random());
			sb.append(AlphaNumericString.charAt(index));
		}
		sb.append(genAlphaNum);
		return sb.toString();
	}

	public static boolean checkBlank(String strValue) {
		return strValue == null || strValue.trim().isEmpty();
	}

	public static boolean checkBlank(Collection<? extends Object> collection) {
		return (collection == null || collection.isEmpty());
	}
	
	public static String convertNullToSingleSpace(String str) {
		if ((str != null) && (!"null".equalsIgnoreCase(str))
				&& (!"".equalsIgnoreCase(str.trim()))) {
			return str.trim();
		}
		return "Unavailable";
	}

	public static String convertNullToBlank(String str) {
		if ((str != null) && (!"null".equalsIgnoreCase(str))) {
			return str.trim();
		}
		return "";
	}
	
	public static String getLikeSearchQueryParam(String input) {
		return "%" + input + "%";
	}
	
	/*public static String getAuthenticationMessage(String key){
		String result;
		switch (key) {
			case CodeConstant.EMPTY_PASSWORD:
				result = "Password can't be blank!";
				break;
			case CodeConstant.EMPTY_USERNAME:
				result = "Username can't be blank!";
				break;
			case CodeConstant.USER_NOT_FOUND:
				result = "Invalid username and password!";
				break;
			case CodeConstant.INVAILED_USERNAME:
				result = "Invalid Username!";
				break;
			case CodeConstant.INVAILED_PASSWORD:
				result = "Invalid Password!";
				break;
			case CodeConstant.AUTH_ERROR:
				result = "Invalid username and password!";
				break;
			case CodeConstant.CONN_ERROR:
				result = "Invalid Username!";
				break;
			case CodeConstant.GEN_ERROR:
				result = "Invalid Password!";
				break;
			case CodeConstant.AUTH_SUCCESS:
				result = "Authentication Success!";
				break;
			default:
				result = "";
				break;
		}
		return result;
	}*/
	
	/*public static String getAuthenticationKey(Authentication authentication) {		
		if(authentication == null){
			return CodeConstant.USER_NOT_FOUND;
		}
		
		Collection<? extends GrantedAuthority> authorities = authentication
				.getAuthorities();
		for (GrantedAuthority grantedAuthority : authorities) {
			return grantedAuthority.getAuthority();			 
		}
		return "";
	}*/
	
	public static @ResponseBody Map<String,String> validate(BindingResult result){
		Map<String,String> map = new HashMap<String, String>();
		List<FieldError> fieldErrorList= result.getFieldErrors();
		for(FieldError fieldError: fieldErrorList ){                    
			map.put(fieldError.getField(), fieldError.getDefaultMessage());
        }
		return map;
	}

}
