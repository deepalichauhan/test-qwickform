package com.sabpaisa.qforms.daoImpl;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import javax.validation.Validation;
import javax.validation.Validator;
import javax.validation.ValidatorFactory;

import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.sabpaisa.qforms.beans.AdmitCardBean;
import com.sabpaisa.qforms.beans.CollegeBean;
import com.sabpaisa.qforms.beans.SampleFormBean;
import com.sabpaisa.qforms.dao.AdmitCardDAO;
import com.sabpaisa.qforms.util.DBConnection;

@Repository
public class AdmitCardDAOImpl implements AdmitCardDAO {

	@Autowired
	SessionFactory factory;

	@Autowired
	DataSource dataSource;

	@Autowired
	JdbcTemplate jdbcTemplate;

	private static final Logger log = LogManager.getLogger("AdmitCardDAOImpl.class");

	Connection conn = null;
	Connection con = null;
	Statement stmt = null;
	DBConnection connection = new DBConnection();

	@Override
	public AdmitCardBean getAdmitCard(String id) {
		log.info("Start of getAdminCard() method.");
		Session session = factory.openSession();
		AdmitCardBean bean = new AdmitCardBean();
		try {
			bean = (AdmitCardBean) session.createCriteria(AdmitCardBean.class)
					.add(Restrictions.eq("reg_number", id))
					.list().get(0);
			//log.info("Admit card bean for given id ::: "+id+" , ::::::: is =====> "+bean.toString());
		} catch (IndexOutOfBoundsException ex) {
			return bean = null;
		} catch (java.lang.NullPointerException ex) {
			return bean = null;
		} finally {
			session.close();
		}
		log.info("End of getAdminCard() method.");
		return bean;
	}

	@Override
	public SampleFormBean getAdmitCardByApplicationNo(String applicationFormNumber) {
		log.info("Start of getAdmitCardByApplicationNo() method.");
		Session session = factory.openSession();
		SampleFormBean formBean = new SampleFormBean();

		try {
			formBean = (SampleFormBean) session.createCriteria(SampleFormBean.class)
					.add(Restrictions.eq("formNumber", applicationFormNumber)).list().get(0);
		} catch (IndexOutOfBoundsException ex) {
			return formBean = null;
		} catch (java.lang.NullPointerException ex) {
			return formBean = null;
		} finally {
			session.close();
		}
		log.info("End of getAdmitCardByApplicationNo() method.");
		return formBean;
	}

	@Override
	public String saveSingleStudentlist(AdmitCardBean admitBean) {
		log.info("Start of saveSingleStudentlist() method.");
		Session session = factory.openSession();
		String valid = "true";
		try {
			Transaction tx = session.beginTransaction();
			session.save(admitBean);

			ValidatorFactory factory1 = Validation.buildDefaultValidatorFactory();
			Validator validator = (Validator) factory1.getValidator();
			validator.validate(admitBean);

			tx.commit();
		} catch (java.lang.NullPointerException ex) {

		} catch (javax.validation.ConstraintViolationException e) {
			e.printStackTrace();
			valid = "false";
		} finally {
			session.close();
		}
		log.info("End of saveSingleStudentlist() method.");
		return valid;
	}

	@Override
	public String updateSingleStudentlist(AdmitCardBean admitBean) {
		log.info("Start of updateSingleStudentlist() method.");
		Session session = factory.openSession();
		String valid = "true";
		try {
			Transaction tx = session.beginTransaction();
			session.update(admitBean);

			ValidatorFactory factory1 = Validation.buildDefaultValidatorFactory();
			Validator validator = (Validator) factory1.getValidator();
			validator.validate(admitBean);

			tx.commit();
		} catch (java.lang.NullPointerException ex) {

		} catch (javax.validation.ConstraintViolationException e) {
			e.printStackTrace();
			valid = "false";
		} finally {
			session.close();
		}
		log.info("End of updateSingleStudentlist() method.");
		return valid;
	}
	
	@Override
	public String generateTempTable(File fileUpload, String sendLink, String serviceId, String productId,
			String sheetName, HttpSession ses) throws IOException {
		log.info("Start of generateTempTable() method.");
		File excelFile = fileUpload;
		String uploadFlag = null;
		String tableName = "admitcard";
		FileInputStream fileInputStream = new FileInputStream(excelFile);
		DBConnection connection = new DBConnection();
		Connection con = null;
		
		XSSFWorkbook xssfWorkbook = new XSSFWorkbook(fileInputStream);

		XSSFSheet hssfSheet = xssfWorkbook.getSheetAt(0);
		Session session = factory.openSession();

		try {
			Iterator<Row> rows = hssfSheet.rowIterator();
			XSSFCell cell;
			ArrayList<String> columnList = new ArrayList<String>();

			while (rows.hasNext()) {
				XSSFRow row = (XSSFRow) rows.next();
				Iterator<Cell> cells = row.cellIterator();

				while (cells.hasNext()) {

					cell = (XSSFCell) cells.next();

					if (row.getRowNum() == 0) {

						// to get header name of each column of excel file to
						// create column name in table

						columnList.add(cell.getStringCellValue());

						continue;

					}

				}

			}
			log.info("size of columnlist is.. " + columnList.size());
			Integer excelColumnSize = columnList.size();
			List<String> useList = new ArrayList<String>();

			ses.setAttribute("sesColumnList", columnList);

			String dynSQL = new String();

			Iterator<String> iterator = columnList.iterator();

			while (iterator.hasNext()) {
				String string2 = (String) iterator.next();

				string2 = string2.replaceAll("\\s", "_");
				string2 = string2.replaceAll("'", "apos");
				string2 = string2.replaceAll("/", "fslsh");
				string2 = string2.replaceAll("\\\\", "bslsh");
				string2 = string2.replaceAll("\\*", "astrk");
				string2 = string2.replaceAll("\\(", "obkt");
				string2 = string2.replaceAll("\\)", "cbkt");
				/*string2 = string2.replaceAll("\\-", "hphn");
				string2 = string2.replaceAll("\\:", "cln");
				string2 = string2.replaceAll("\\.", "dot");*/
				string2 = StringUtils.removeEnd(string2, "_");
				log.info("generate column names ::" + string2);
				
				dynSQL = dynSQL + "," + string2 + " varchar(255)";

			}

			String[] splitsqlString = dynSQL.split(",");
			for (int i = 0; i < splitsqlString.length; i++) {
				String string2 = splitsqlString[i];
				useList.add(string2);

			}
			Integer sheetNo = 1;
			dynSQL = dynSQL.substring(1, dynSQL.length());

			log.info("dynSQL is.." + dynSQL);
			
			Boolean CreateDBflag = false;
			con = connection.getConnectionAdmitCard();
			
			try {
				DatabaseMetaData meta = con.getMetaData();
				ResultSet res = meta.getTables(null, null, tableName, null);
				//log.info("No of Column is ==" + res.getRow());
				if (!res.next()) {
					CreateDBflag = Boolean.valueOf(true);
					log.info("Table Not Exists");
				} else {
					log.info("Table Exist");
					CreateDBflag = Boolean.valueOf(false);
					/*sheetNo = getSheetCounter(tempTableName);
					sheetNo = sheetNo + 1;*/
					//log.debug("After increment Sheet No = " + sheetNo);
				}
			} catch (Exception localException) {

			}
			
			/*DatabaseMetaData meta = con.getMetaData();
			ResultSet res = meta.getTables(null, null, tableName, null);
			log.info("No of Column is ==" + res.getRow());
			if (!res.next()) {

				// CreateDBflag = true;
				log.info("Table Not Exists");
			} else {
				CreateDBflag = false;

			}*/
			//log.info("create db flag is :::::::::::::: "+CreateDBflag.toString());
			if (CreateDBflag == true) {

				try {
					session.createSQLQuery("CREATE TABLE " + tableName
							+ " (id int(5) NOT NULL PRIMARY KEY AUTO_INCREMENT,PRODUCT_TYPE varchar(10),SERVICE_TYPE varchar(10),"
							+ dynSQL
							+ ", SECRET_KEY varchar(50) UNIQUE,STATUS varchar(20),CREATED_DATE DATETIME,PAYMENT_TRANSACTION_DATE DATETIME,PAYMENT_TRANSACTION_ID varchar(55),PAID_AMOUNT DOUBLE,BASE_AMOUNT DOUBLE,CLIENT_ID varchar(50),SEND_LINK varchar(2),SHEET_NO varchar(50),UPLOADED_BY_USER varchar(5))")
							.executeUpdate();

					log.info("Table created");

				} catch (RuntimeException e) {
					return "tableCreationError";
				}

			}

			// importExcelFileToDatabase2(excelFile, useList);
			try {
				// ses.setAttribute("fieldValidationFlag",
				// firstTimeTemplateCreationFlag);
				uploadFlag = importExcelFileToDataBase(excelFile, useList, excelColumnSize, sendLink, serviceId,
						productId, tableName, sheetName);
				log.info("End of generateTempTable() method.");
				return uploadFlag;

			} catch (Exception e) {
				e.printStackTrace();
				return "fail";
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			return "fail";
		}
	}

	private String importExcelFileToDataBase(File fileUpload, List<String> useList, Integer exceColSize,
			String sendLink, String serviceId, String productId, String tableName2, String sheetName)
			throws IOException {
		log.info("Start of importExcelFileToDataBase() method.");
		Session session = factory.openSession();
		Connection conn = null;
		Statement stmt = null;
		DBConnection connection = new DBConnection();
		FileInputStream fileInputStream = new FileInputStream(fileUpload);
		XSSFWorkbook xssfWorkbook = new XSSFWorkbook(fileInputStream);
		XSSFSheet hssfSheet = xssfWorkbook.getSheetAt(0);

		try {

			Iterator<Row> rows = hssfSheet.rowIterator();
//			String stringVal;
//			String blankVal;
//			String errorlVal;
//			String booleanval;
//			String defaultVal;
//
//			Long numVal;
//			XSSFCell cell = null;

			while (rows.hasNext()) {

				XSSFRow row = (XSSFRow) rows.next();

				if (row.getRowNum() == 0) {
					continue;
				}

				int i = 0;
				log.info("Empty Value of Cell is = " + hssfSheet.getRow(1).getCell(3));
				Iterator<Cell> cells = row.cellIterator();
				ArrayList<Object> tempArrayList = new ArrayList<Object>();
				while (i < exceColSize) {

					Cell c = row.getCell(i);
					//log.info("fir chala mera loop");
					try {
						// System.out.println("Cell value is =" +
						// c.getStringCellValue());
						// c.setCellType(Cell.CELL_TYPE_STRING);
						
						String tempCellVAlue = c.getStringCellValue();
						log.info("Cell value is ={" + tempCellVAlue + "}");
//						tempArrayList.add(tempCellVAlue.trim().replaceAll("[^\\p{Alpha}\\d@.'_\\s-]", ""));
						tempArrayList.add(tempCellVAlue.trim());
						
						//tempArrayList.add(c.getStringCellValue().trim());
					} catch (NullPointerException NE) {
						log.info("Cell number yahi wala dikkat diya at number:" + i + " - " + NE);
						tempArrayList.add("");
					}
					i++;
				}

				log.info("Insert Value list size ::" + tempArrayList.size());
				log.info("Column list size ::" + exceColSize);
				if (!exceColSize.equals(tempArrayList.size())) {
					log.info("Column Size is not matched, So return excelError status");
					return "excelError";
				}
				String insertParam = new String();

				Iterator<Object> iterator = tempArrayList.iterator();

				while (iterator.hasNext()) {
					String ss = (String) iterator.next();

					insertParam = insertParam + "," + "'" + ss + "'";
				}
				String key = null;
				
				try {

					insertParam = insertParam.substring(1, insertParam.length());
					conn = connection.getConnectionAdmitCard();
					log.info("Connected database successfully...");
					log.info("Inserting records into the table...");
					stmt = conn.createStatement();

					Date date = new Date();
					log.info("inserting values ::" + insertParam);

					/*String sql = "INSERT INTO `admitcard`(`id`,`reg_number`,`name`,`applied_course`,`roll_number`,`doe`,`toe`,`center`,`father_name`,`category`,`dob`,`gender`)VALUES"
							+ "(" + insertParam +",'NA','NA'"+")";*/
					String sql = "INSERT INTO `admitcard`(`id`,`reg_number`,`name`,`applied_course`,`roll_number`,`doe`,`toe`,`center`,`father_name`,`category`,`dob`,`gender`)VALUES"
							+ "(null,"+ insertParam +")";
					log.info("sql ::" + sql);

					int counter = stmt.executeUpdate(sql);
				} catch (SQLException se) {
					log.info("Handle errors for JDBC 1");
					se.printStackTrace();
				} catch (Exception e) {
					log.info("Handle errors for JDBC 2");
					return "dbError";
				} finally {
					log.info("finally block used to close resources 1");
					try {
						if (stmt != null) {
							log.info("finally block used to close resources 2");
							stmt.close();
							}
						//con.close();

					} catch (SQLException se) {
						log.info("Handle errors for JDBC 3");
					} // do nothing
					try {
						if (conn != null) {
							log.info("finally block used to close resources 3");
							conn.close();
							}
					} catch (SQLException se) {
						log.info("Handle errors for JDBC 4");
						se.printStackTrace();
					} // end finally try

					// return "success";
				}
				log.info("End of importExcelFileToDataBase() method.");
			}

			return "success";
		}

		catch (Exception e) {

			e.printStackTrace();
			return "fail";
		} finally {
			session.close();
		}

		// return null;

	}

	@Override
	// @SuppressWarnings("unchecked")
	public List<AdmitCardBean> getAdmitCardList() {
		log.info("Start of getAdmitCardList() method");
		Session session = factory.openSession();
		List<AdmitCardBean> list = new ArrayList<AdmitCardBean>();
		try {
			list = session.createCriteria(AdmitCardBean.class).list();
			log.info("End of getAdmitCardList() method");
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			log.info("End of getAdmitCardList() method");
			return null;
		} finally {
			session.close();
		}
	}

	@Override
	@SuppressWarnings("unchecked")
	public AdmitCardBean editAdmitCardDetailsID(String parameter) {
		log.info("Start of editAdmitCardDetailsID() method.");
		Session session = factory.openSession();
		AdmitCardBean list = new AdmitCardBean();
		try {
			list = (AdmitCardBean) session.createCriteria(AdmitCardBean.class)
					.add(Restrictions.eq("id", Integer.parseInt(parameter))).list().get(0);
			//log.info("Admit card list is as per given id ::::: "+list.toString());
			log.info("End of editAdmitCardDetailsID() method.");
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			session.close();
		}
	}

	@Override
	public CollegeBean getCollegedetails(String id) {
		log.info("Start of getCollegedetails() method.");
		Session session = factory.openSession();
		CollegeBean bean = new CollegeBean();

		try {
			bean = (CollegeBean) session.createCriteria(CollegeBean.class)
					.add(Restrictions.eq("collegeId", Integer.parseInt(id))).list().get(0);
		} catch (IndexOutOfBoundsException ex) {
			return bean = null;
		} catch (java.lang.NullPointerException ex) {

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		log.info("End of getCollegedetails() method.");
		return bean;

	}
}
