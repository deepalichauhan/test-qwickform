package com.sabpaisa.qforms.util;

import java.util.Properties;

import org.apache.log4j.Logger;

import com.sabpaisa.qforms.config.AppPropertiesConfig;


public class FormLinkUtilities {

	static String source="ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789=_";
	static String target="WS7XEDQ9A8ZC6RFVT1KO0LP5GBY4HNU3J2MI-=";
	
	static Logger log = Logger.getLogger(FormLinkUtilities.class);	
	AppPropertiesConfig quickCollectProperties = new AppPropertiesConfig();
	Properties cProps = quickCollectProperties.getPropValues();

	public static String obfuscate(String s) {
	    char[] result= new char[10];
	    for (int i=0;i<s.length();i++) {
	        char c=s.charAt(i);
	        int index=source.indexOf(c);
	        result[i]=target.charAt(index);
	    }

	    return new String(result);
	}

	public static String deobfuscate(String s) {
	    char[] result= new char[10];
	    for (int i=0;i<s.length();i++) {
	        char c=s.charAt(i);
	        int index=target.indexOf(c);
	        result[i]=source.charAt(index);
	    }

	    return new String(result);
	}
	
	@SuppressWarnings("null")
	public String getPropertiesValue(String value){
	log.info("Fetching cProps value ");
	log.info("cProps value is ");

	String propValue = cProps.getProperty(value);

	if(propValue!=null || !propValue.isEmpty())
	{
		return propValue;
	}
	else{
		log.info("Property not found ");
	}
		return propValue;
	}

	public AppPropertiesConfig getQuickCollectProperties() {
		return quickCollectProperties;
	}

	public void setQuickCollectProperties(AppPropertiesConfig quickCollectProperties) {
		this.quickCollectProperties = quickCollectProperties;
	}

}
