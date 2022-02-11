package com.sabpaisa.qforms.util;

import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;

public class ConnectionClass {

	public static SessionFactory sessionFactoryfactory = buildSessionFactory();
	
	//public static SessionFactory sessionFactoryfactoryReportsDB = buildSessionFactoryReportsDB();


	

	public static SessionFactory buildSessionFactory() {

		if (sessionFactoryfactory == null) {
			Configuration configuration = new Configuration().configure("hibernate.cfg.xml");

			StandardServiceRegistryBuilder builder = new StandardServiceRegistryBuilder().applySettings(configuration
					.getProperties());
			SessionFactory factory = configuration.buildSessionFactory(builder.build());
			return factory;

		} else {
			return sessionFactoryfactory;
		}
		
		

	}
	/*
	public static SessionFactory buildSessionFactoryReportsDB() {

		
		if (sessionFactoryfactoryReportsDB == null) {
			Configuration configuration1 = new Configuration().configure("hibernate.reportsdbcfg.xml");
			
			StandardServiceRegistryBuilder builder = new StandardServiceRegistryBuilder().applySettings(configuration1
					.getProperties());
		
			SessionFactory factory1 = configuration1.buildSessionFactory(builder.build());
			return factory1;

		} else {
			return sessionFactoryfactoryReportsDB;
		}

	}	
	*/
	

	public static void shutDown() {

		getFactory().close();
		//getSessionFactoryfactoryReportsDB().close();
	}
	public static SessionFactory getFactory() {
		return sessionFactoryfactory;
	}
	public static void setSessionFactoryfactory(SessionFactory sessionFactoryfactory) {
		ConnectionClass.sessionFactoryfactory = sessionFactoryfactory;
	}
	/*
	public static SessionFactory getSessionFactoryfactoryReportsDB() {
		return sessionFactoryfactoryReportsDB;
	}
	public static void setSessionFactoryfactoryReportsDB(SessionFactory sessionFactoryfactoryReportsDB) {
		ConnectionClass.sessionFactoryfactoryReportsDB = sessionFactoryfactoryReportsDB;
	}
*/
}
