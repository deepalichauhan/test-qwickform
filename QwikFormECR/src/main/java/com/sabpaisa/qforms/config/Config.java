package com.sabpaisa.qforms.config;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;

@Component
//@Order(Ordered.HIGHEST_PRECEDENCE)
@Configuration
public class Config implements Filter {

	private final Logger log = LoggerFactory.getLogger(Config.class);

	public Config() {
		log.info("Config init");
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
			throws IOException, ServletException {
		
		
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;
		String sessionid = request.getSession().getId();
		
		response.setHeader("Access-Control-Allow-Origin", request.getHeader("Origin"));
		response.setHeader("Access-Control-Allow-Credentials", "true");
		response.setHeader("Access-Control-Allow-Methods", "POST, PUT, GET, OPTIONS, DELETE");
//		response.setHeader("Access-Control-Allow-Methods", "POST");
		response.setHeader("Access-Control-Max-Age", "3600");
		response.setHeader("Access-Control-Allow-Headers", 
				"Origin, Content-Type, Accept, X-Requested-With, remember-me");
		response.setHeader("Strict-Transport-Security", "max-age=31536000 ; includeSubDomains");
		response.setHeader("X-Content-Type-Options", "nosniff");
		response.setHeader("X-Frame-Options", "DENY");
		response.setHeader("X-XSS-Protection", "1; mode=block");
		
		response.addHeader("Pragma", "no-cache");
		response.addHeader("Cache-Control", "no-cache, no-store, must-revalidate, private");
		response.addHeader("Expires", "0");
		//response.setHeader("SET-COOKIE", "JSESSIONID=" + sessionid + "; secure");
		
		String contextPath = request.getContextPath();
		
		/*response.setHeader("SET-COOKIE", "JSESSIONID=" + sessionid+
		 ";Path="+contextPath+";Secure;HttpOnly");*/
		 
//   	    response.setHeader("Content-Type","text/plain");    
   	    if (request.getParameter("JSESSIONID") != null) {
   	        Cookie userCookie = new Cookie("JSESSIONID", request.getParameter("JSESSIONID"));
   	        userCookie.setHttpOnly(true);
   			//clientCookie.setComment(purpose);
   	        userCookie.setSecure(true);
   	        response.addCookie(userCookie);
   	    } else {
   	        String sessionId = sessionid;
   	        Cookie userCookie = new Cookie("JSESSIONID", sessionId);
   	        userCookie.setHttpOnly(true);
   			//clientCookie.setComment(purpose);
   	        userCookie.setSecure(true);
   	        response.addCookie(userCookie);
   	    }
		
		chain.doFilter(req, res);
	}

	@Override
	public void init(FilterConfig filterConfig) {
	}

	@Override
	public void destroy() {
	}

}
