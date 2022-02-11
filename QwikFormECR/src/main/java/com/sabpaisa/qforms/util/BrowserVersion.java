package com.sabpaisa.qforms.util;

import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class BrowserVersion {
	// private static WebDriver browserDriver;
	static Logger log = LogManager.getLogger(BrowserVersion.class.getName());

	public static String getBrowserAndVersion(HttpServletRequest request) {
		String browserDetails = request.getHeader("User-Agent");
		String userAgent = browserDetails;
		String user = userAgent.toLowerCase();

		String os = "";
		String browser = "";

		log.info("User Agent for the request is 1 ===>" + browserDetails);
		// log.info("User Agent for the request is 2 ===>" + userAgent);
		// log.info("User Agent for the request is 3 ===>" + user);
		// =================OS=======================
		if (userAgent.toLowerCase().indexOf("windows") >= 0) {
			os = "Windows";
		} else if (userAgent.toLowerCase().indexOf("mac") >= 0) {
			os = "Mac";
		} else if (userAgent.toLowerCase().indexOf("x11") >= 0) {
			os = "Linux";
		} else if (userAgent.toLowerCase().indexOf("android") >= 0) {
			os = "Android";
		} else if (userAgent.toLowerCase().indexOf("iphone") >= 0) {
			os = "IPhone";
		} else {
			os = "UnKnown, More-Info: " + userAgent;
		}
		// log.info("OS name of this User Agent for the request is 4 ===>" + os);

		// ===============Browser===========================
		if (user.contains("msie")) {
			String substring = userAgent.substring(userAgent.indexOf("MSIE")).split(";")[0];
			browser = substring.split(" ")[0].replace("MSIE", "IE") + "-" + substring.split(" ")[1];
			log.info("Browser Name MSIE ==========>" + browser);
		} else if (user.contains("safari") && user.contains("version")) {
			browser = (userAgent.substring(userAgent.indexOf("Safari")).split(" ")[0]).split("/")[0] + "-"
					+ (userAgent.substring(userAgent.indexOf("Version")).split(" ")[0]).split("/")[1];
			log.info("Browser Name SAFARI ==========>" + browser);
		} else if (user.contains("opr") || user.contains("opera")) {
			if (user.contains("opera")) {
				browser = (userAgent.substring(userAgent.indexOf("Opera")).split(" ")[0]).split("/")[0] + "-"
						+ (userAgent.substring(userAgent.indexOf("Version")).split(" ")[0]).split("/")[1];
				
			}else if (user.contains("opr")) {
				browser = ((userAgent.substring(userAgent.indexOf("OPR")).split(" ")[0]).replace("/", "-"))
						.replace("OPR", "Opera");
			}
			log.info("Browser Name OPERA ==========>" + browser);
		} else if (user.contains("chrome")) {
			browser = (userAgent.substring(userAgent.indexOf("Chrome")).split(" ")[0]).replace("/", "-");
			log.info("Browser Name CHROME ==========>" + browser);
		} else if ((user.indexOf("mozilla/7.0") > -1) || (user.indexOf("netscape6") != -1)
				|| (user.indexOf("mozilla/4.7") != -1) || (user.indexOf("mozilla/4.78") != -1)
				|| (user.indexOf("mozilla/4.08") != -1) || (user.indexOf("mozilla/3") != -1)) {
			// browser=(userAgent.substring(userAgent.indexOf("MSIE")).split("
			// ")[0]).replace("/", "-");
			browser = "Netscape-?";
			log.info("Browser Name NETSCAPE ==========>" + browser);
		} else if (user.contains("firefox")) {
			browser = (userAgent.substring(userAgent.indexOf("Firefox")).split(" ")[0]).replace("/", "-");
			log.info("Browser Name FIREFOX ==========>" + browser);
		} else if (user.contains("rv")) {
			browser = "IE-" + user.substring(user.indexOf("rv") + 3, user.indexOf(")"));
			log.info("Browser Name RV IE ==========>" + browser);
		} else {
			browser = "UnKnown, More-Info: " + userAgent;
		}
		// log.info("Operating System 5 ======>" + os);
		log.info("Browser Name 6 ==========>" + browser);
		return browser;
	}

	public String getOperatingSystem(HttpServletRequest request) {

		String userAgent = request.getHeader("User-Agent");
		String os = "";
		String versionOS = "";
		Integer indexNumber = 0;
		// log.info("User Agent for the request is 1 ===>" + userAgent);

		// =================OS=======================
		if (userAgent.toLowerCase().indexOf("windows") >= 0) {
			os = "Windows";
			if (userAgent.toLowerCase().indexOf("64") >= 0 && (userAgent.toLowerCase().indexOf("NT 6.0") >= 0
					|| userAgent.toLowerCase().indexOf("NT 6.1") >= 0 || userAgent.toLowerCase().indexOf("NT 6.2") >= 0
					|| userAgent.toLowerCase().indexOf("NT 6.3") >= 0 || userAgent.toLowerCase().indexOf("NT 5.1") >= 0
					|| userAgent.toLowerCase().indexOf("NT 5.2") >= 0
					|| userAgent.toLowerCase().indexOf("NT 10.0") >= 0)) {

				versionOS = "win XP/7/8/10 with 64-bit";
			} else {
				versionOS = "win XP/7/8/10 with 32-bit";
			}
		} else if (userAgent.toLowerCase().indexOf("mac") >= 0) {
			os = "Mac";
			if (userAgent.toLowerCase().indexOf("64") >= 0 && (userAgent.toLowerCase().indexOf("Mac OS X 10.14") >= 0
					|| userAgent.toLowerCase().indexOf("Mac OS X 10_14") >= 0
					|| userAgent.toLowerCase().indexOf("Mac OS X 10_13") >= 0)) {

				versionOS = "Mac OS X 10.14/Mac OS X 10.13 with 64-bit";
			} else {
				versionOS = "Mac OS X 10.14/Mac OS X 10.13 with 32-bit";
			}
		} else if (userAgent.toLowerCase().indexOf("x11") >= 0) {
			os = "Linux";
			if (userAgent.toLowerCase().indexOf("64") >= 0) {

				versionOS = "64-bit";
			} else {
				versionOS = "32-bit";
			}
		} else if (userAgent.toLowerCase().indexOf("android") >= 0) {
			os = "Android";
			if (userAgent.toLowerCase().indexOf("64") >= 0) {

				versionOS = "64-bit";
			} else {
				versionOS = "32-bit";
			}
		} else if (userAgent.toLowerCase().indexOf("iphone") >= 0) {
			os = "IPhone";
			if (userAgent.toLowerCase().indexOf("64") >= 0) {

				versionOS = "64-bit";
			} else {
				versionOS = "32-bit";
			}
		} else {
			os = "UnKnown, More-Info: " + userAgent;
		}

		return os + "_" + versionOS;
	}

	public String getBrowserDetails12(HttpServletRequest request) {
		String userAgent = request.getHeader("User-Agent");
		String user = userAgent.toLowerCase();

		String browser = "";

		// log.info("User Agent for the request is 1 ===>" + userAgent);
		// log.info("User Agent for the request is 2 ===>" + user);
		// =================OS=======================

		// ===============Browser===========================
		if (user.contains("msie")) {
			String substring = userAgent.substring(userAgent.indexOf("MSIE")).split(";")[0];
			browser = substring.split(" ")[0].replace("MSIE", "IE") + "-" + substring.split(" ")[1];
		} else if (user.contains("safari") && user.contains("version")) {
			browser = (userAgent.substring(userAgent.indexOf("Safari")).split(" ")[0]).split("/")[0] + "-"
					+ (userAgent.substring(userAgent.indexOf("Version")).split(" ")[0]).split("/")[1];
		} else if (user.contains("opr") || user.contains("opera")) {
			if (user.contains("opera"))
				browser = (userAgent.substring(userAgent.indexOf("Opera")).split(" ")[0]).split("/")[0] + "-"
						+ (userAgent.substring(userAgent.indexOf("Version")).split(" ")[0]).split("/")[1];
			else if (user.contains("opr"))
				browser = ((userAgent.substring(userAgent.indexOf("OPR")).split(" ")[0]).replace("/", "-"))
						.replace("OPR", "Opera");
		} else if (user.contains("chrome")) {
			browser = (userAgent.substring(userAgent.indexOf("Chrome")).split(" ")[0]).replace("/", "-");
		} else if ((user.indexOf("mozilla/7.0") > -1) || (user.indexOf("netscape6") != -1)
				|| (user.indexOf("mozilla/4.7") != -1) || (user.indexOf("mozilla/4.78") != -1)
				|| (user.indexOf("mozilla/4.08") != -1) || (user.indexOf("mozilla/3") != -1)) {

			browser = "Netscape-?";

		} else if (user.contains("firefox")) {
			browser = (userAgent.substring(userAgent.indexOf("Firefox")).split(" ")[0]).replace("/", "-");
		} else if (user.contains("rv")) {
			browser = "IE-" + user.substring(user.indexOf("rv") + 3, user.indexOf(")"));
		} else {
			browser = "UnKnown, More-Info: " + userAgent;
		}

		log.info("Browser Name 3 ==========>" + browser);
		return browser;
	}
}
