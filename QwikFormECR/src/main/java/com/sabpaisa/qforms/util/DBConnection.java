package com.sabpaisa.qforms.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.sabpaisa.qforms.config.AppPropertiesConfig;

public class DBConnection
{
  public DBConnection() {}
  
  private static Logger log = LogManager.getLogger(DBConnection.class.getName());
  AppPropertiesConfig appProperties = new AppPropertiesConfig();
  Properties cProps = appProperties.getPropValues();
  String username = cProps.getProperty("spring.datasource.username");
  String password = cProps.getProperty("spring.datasource.password");
  String DB_URL = cProps.getProperty("spring.datasource.url");
  String DRIVER=cProps.getProperty("spring.datasource.driver");
  public Connection getConnectionApp() {
    Connection con = null;
    log.info("username == " + username+" ::::: password ::::::: "+password);
    log.info("DB_URL == " + DB_URL);
    log.info("DRIVER == " + DRIVER);
    try {
      Class.forName(DRIVER);
    }
    catch (ClassNotFoundException e) {
      e.printStackTrace();
    }
    try
    {
      con = java.sql.DriverManager.getConnection(DB_URL, username, password);
    } catch (Exception ex) {
      ex.printStackTrace();
    }
    log.info("Connection is ::::::::: "+con.toString());
    return con;
  }
  
  public Connection getConnectionAdmitCard()
  {
    Connection con = null;
    log.info("DB_URL == " + DB_URL);
    try {
    	Class.forName(DRIVER);
    }
    catch (ClassNotFoundException e) {
      e.printStackTrace();
    }
    try
    {
      con = DriverManager.getConnection(DB_URL, username, password);
    } catch (Exception ex) {
      ex.printStackTrace();
    }
    return con;
  }
}
