package com.sabpaisa.qforms.util;

import java.util.Properties;

import javax.sql.DataSource;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.orm.hibernate5.HibernateTransactionManager;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.sabpaisa.qforms.config.AppPropertiesConfig;

@Configuration
@EnableTransactionManagement
@ComponentScan({ "com.sabpaisa.qforms" })
public class HibernateConfig {

	AppPropertiesConfig appProperties = new AppPropertiesConfig();
	Properties properties = appProperties.getPropValues();
	String url = properties.getProperty("spring.datasource.url");
	String driver = properties.getProperty("spring.datasource.driver");
	String userName = properties.getProperty("spring.datasource.username");
	String password = properties.getProperty("spring.datasource.password");
	String beanData = properties.getProperty("springBeanData");
	String show_sql = properties.getProperty("hibernate.show-sql");
	String hibernate_dialect = properties.getProperty("hibernate.dialect");
	String hibernate_event_merge_entity_copy_observer = properties
			.getProperty("hibernate.event.merge.entity_copy_observer");
	String hibernate_current_session_context_class = properties.getProperty("hibernate.current_session_context_class");

	@Bean
	public DataSource dataSource() {
		DriverManagerDataSource dataSource = new DriverManagerDataSource();
		dataSource.setDriverClassName(driver);
		dataSource.setUrl(url);
		dataSource.setUsername(userName);
		dataSource.setPassword(password);
		return dataSource;
	}

	private Properties hibernateProperties() {
		Properties properties = new Properties();
		properties.put("hibernate.dialect", hibernate_dialect);
		properties.put("hibernate.show_sql", show_sql);
		properties.put("hibernate.event.merge.entity_copy_observer", hibernate_event_merge_entity_copy_observer);
		properties.put("hibernate.current_session_context_class", hibernate_current_session_context_class);
//	        properties.put("hibernate.hbm2ddl.auto", "false");
		return properties;
	}

	@Bean
	public LocalSessionFactoryBean sessionFactory() {
		LocalSessionFactoryBean sessionFactory = new LocalSessionFactoryBean();
		sessionFactory.setDataSource(dataSource());
		sessionFactory.setPackagesToScan(new String[] { beanData });
		sessionFactory.setHibernateProperties(hibernateProperties());
		return sessionFactory;
	}

	@Bean
	@Autowired
	public HibernateTransactionManager transactionManager(SessionFactory sessionFactory) {
		HibernateTransactionManager htm = new HibernateTransactionManager();
		htm.setSessionFactory(sessionFactory);
		return htm;
	}
}