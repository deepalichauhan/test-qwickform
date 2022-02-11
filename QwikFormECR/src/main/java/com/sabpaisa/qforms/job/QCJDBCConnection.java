package com.sabpaisa.qforms.job;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class QCJDBCConnection
{
  static String port = "3306";
  static String dbName = "sabpaisa";
  static String location = "localhost";
  
  static String DB_URL = "jdbc:mysql://" + location + ":" + port + "/" + dbName;
  static String userName = "root";
  static String pass = "root";
  
  public QCJDBCConnection() {}
  
  public static Connection getConnection() throws ClassNotFoundException, SQLException
  {
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = null;
    try {
      con = DriverManager.getConnection(DB_URL, userName, pass);
    }
    catch (Exception e) {
      e.printStackTrace();
    }
    return con;
  }
}
