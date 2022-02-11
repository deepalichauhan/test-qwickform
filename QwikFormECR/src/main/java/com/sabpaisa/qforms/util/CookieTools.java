package com.sabpaisa.qforms.util;

/*import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CookieTools {

	public int division;

	  public void writeCookie(String cookieName,String cookieContent) {

	    // Save to cookie
		  Cookie clientCookie = new Cookie(cookieName, cookieContent);
			// setting cookie to expiry in 30 mins
			clientCookie.setMaxAge(30 * 60);
			servletResponse.addCookie(clientCookie);
		  
	    Cookie div = new Cookie("cookieDivision", String.format("%d",division));
	    div.setMaxAge(60*60*24*365); // Make the cookie last a year
	    servletResponse.addCookie(div);
	  }

	  // For access to the raw servlet request / response, eg for cookies
	  protected HttpServletResponse servletResponse=ServletActionContext.getResponse();
	  @Override
	  public void setServletResponse(HttpServletResponse servletResponse) {
	    this.servletResponse = servletResponse;
	  }

	  protected HttpServletRequest servletRequest;
	  @Override
	  public void setServletRequest(HttpServletRequest servletRequest) {
	    this.servletRequest = servletRequest;
	  }
}
*/