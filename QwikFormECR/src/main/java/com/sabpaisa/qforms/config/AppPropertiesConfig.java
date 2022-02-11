package com.sabpaisa.qforms.config;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import java.util.logging.Logger;
import org.springframework.stereotype.Component;

@Component("appPropertiesConfig")
public class AppPropertiesConfig {
	String result = "";
	InputStream inputStream;
	static Logger log = Logger.getLogger("AppPropertiesConfig");

	public AppPropertiesConfig() {
	}

	public Properties getPropValues() {
		Properties prop = new Properties();
		try {
			String propFileName = "application.properties";
			
			inputStream = getClass().getClassLoader().getResourceAsStream(propFileName);

			if (inputStream != null) {
				prop.load(inputStream);
			} else
				throw new FileNotFoundException("property file '" + propFileName + "' not found in the classpath");
		} catch (Exception e) {
			e.getMessage();
			log.info("Exception: " + e);
			try {
				inputStream.close();
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		}

		try {
			inputStream.close();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return prop;
	}
}
