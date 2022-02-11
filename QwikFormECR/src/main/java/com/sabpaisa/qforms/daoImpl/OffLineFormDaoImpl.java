package com.sabpaisa.qforms.daoImpl;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.hibernate.Criteria;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.sabpaisa.qforms.beans.BeanFieldLookup;
import com.sabpaisa.qforms.beans.BeanFormDetails;
import com.sabpaisa.qforms.beans.BeanPayerType;
import com.sabpaisa.qforms.beans.LoginBean;
import com.sabpaisa.qforms.dao.OffLineFormDao;
import com.sabpaisa.qforms.util.DBConnection;

@Repository
public class OffLineFormDaoImpl implements OffLineFormDao {

	@Autowired
	SessionFactory factory;

	@Autowired
	DataSource dataSource;

	@Autowired
	JdbcTemplate jdbcTemplate;

	private static final Logger log = LogManager.getLogger("OffLineFormDaoImpl.class");
	private LoginBean loginBean = new LoginBean();
	
	@Override
	public ArrayList<String> generateColumnList(File fileUpload, HttpSession ses) throws Exception {

		log.info("Start of generateColumnList() method in daoimpl page");
		ArrayList<String> columnList = new ArrayList<String>();
		File excelFile = fileUpload;
		String flag = (String) ses.getAttribute("flag_session");
		loginBean = (LoginBean) ses.getAttribute("loginUserBean");
		// log.info("loginbean is ===== = " + loginBean.toString());
		log.debug("flag_session = " + ses.getAttribute("flag_session"));
		// log.info("excelFile = " + excelFile.toString() + "::::::::::: flag_session");
		FileInputStream fileInputStream = new FileInputStream(excelFile);
		// log.info("fileInputStream = " + fileInputStream.toString());
		ses.setAttribute("fileInputStream", fileInputStream);
		XSSFWorkbook xssfWorkbook = new XSSFWorkbook(fileInputStream);
		// log.info("xssfWorkbook = " + xssfWorkbook.toString());
		XSSFSheet hssfSheet = xssfWorkbook.getSheetAt(0);
		// log.info("hssfSheet = " + hssfSheet.toString());
		Session session = factory.openSession();
		try {
			Iterator<Row> rows = hssfSheet.rowIterator();
			XSSFCell cell;
			while (rows.hasNext()) {
				// log.info("Open while loop with rows");
				XSSFRow row = (XSSFRow) rows.next();
				Iterator<Cell> cells = row.cellIterator();
				while (cells.hasNext()) {
					// log.info("Open while loop with cells");
					cell = (XSSFCell) cells.next();
					if (row.getRowNum() == 0) {
						columnList.add(cell.getStringCellValue());
						// log.info("now column list is ::::::::: " + columnList.toString());
						continue;
					}
				}
			}
			// log.info("size of columnlist is.. " + columnList.size());
			ses.setAttribute("sesColumnList", columnList);
			return columnList;
		} catch (Exception e) {
			e.printStackTrace();
			return columnList;
		}
	}

	@Override
	public String generateTempTable(ArrayList<String> columnListOfFirstRow, String tempTableName, HttpSession ses,
			String formName, String cCode) throws Exception {

		log.info("Open generateTempTable() method and columnList is :::::: " + columnListOfFirstRow.size());
		String dbPath = (String) ses.getAttribute("dbpath");
		// log.info("Now dbPath is in method :::::: "+dbPath.toString());
		String uploadFlag = null;
		File uploadFile = new File(dbPath);
		FileInputStream fileInputStream = new FileInputStream(uploadFile);
		try {
			ses.setAttribute("fieldValidationFlag", "Y");
			
			//log.info("Now start uploading excel file into client table as firstTimeTemplateCreationFlag value is {"
			//+ "Y" + "} and uploadFlag is {" + uploadFlag + "}");
			 
			uploadFlag = importExcelFileToDataBase(ses, fileInputStream, columnListOfFirstRow, tempTableName, formName,cCode);
			return uploadFlag;
		} catch (Exception e) {
			e.printStackTrace();
			return "fail";
		}
	}

	// updated flow of Add student FD0.4
	//@SuppressWarnings("null")
	public String importExcelFileToDataBase(HttpSession ses, FileInputStream fileInputStream,
			ArrayList<String> columnListOfFirstRow, String tempTableName, String formName, String cCode) throws IOException {

		log.info("Start importExcelFileToDataBase() method and formName is :::::: " + formName.toString());
		Session session = factory.openSession();
		XSSFWorkbook xssfWorkbook = new XSSFWorkbook(fileInputStream);
		XSSFSheet hssfSheet = xssfWorkbook.getSheetAt(0);
		Integer exceColSize = columnListOfFirstRow.size();
		Date currentDate = null;
		// ArrayList<String> emailArrayList = new ArrayList<String>();
		String uniqueKey = new String();
		try {
			ses.setAttribute("tableName", tempTableName);
			Iterator<Row> rows = hssfSheet.rowIterator();
			uniqueKey = "";
			String coulumnForClientTable = "";
			while (rows.hasNext()) {
				XSSFRow row = (XSSFRow) rows.next();
				if (row.getRowNum() == 0) {
					continue;
				}
				int i = 0;
				// log.info("Empty Value of Cell is = " + hssfSheet.getRow(1).getCell(3));
				Iterator<Cell> cells = row.cellIterator();
				ArrayList<Object> tempArrayList = new ArrayList<Object>();
				while (i < exceColSize) {
					Cell c = row.getCell(i);
					// log.info("fir chala mera loop");
					try {
						String tempCellVAlue = c.getStringCellValue();
						// log.info("Cell value is ={" + tempCellVAlue + "}");
						tempArrayList.add(tempCellVAlue.trim().replaceAll("[^\\p{Alpha}\\d@.'_\\s-]", ""));
					} catch (NullPointerException NE) {
						log.debug("Cell number yahi wala dikkat diya at number:" + i + " - " + NE);
						tempArrayList.add("");
					}
					i++;
				}
				if (!exceColSize.equals(tempArrayList.size())) {
					log.info("Column Size is not matched, So return excelError status");
					return "excelError";
				}
				String insertParam = new String();
				Iterator<Object> iterator = tempArrayList.iterator();
				while (iterator.hasNext()) {
					String ss = (String) iterator.next();
					insertParam = insertParam + "," + "'" + ss + "'";
					// log.info("insertParam in loop :::: "+insertParam);
				}
				// log.info("finally insertParam in outer loop :::: "+insertParam);
				Transaction tx = session.beginTransaction();
				try {

					DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					Date dateobj = new Date();
					log.info(df.format(dateobj));

					insertParam = insertParam.substring(1, insertParam.length());
					coulumnForClientTable = String.join(",", columnListOfFirstRow);
					// log.info("inserting values into {" + tempTableName + "} >>>> for coulmn is
					// >>>> {"+coulumnForClientTable+"}, and coulumnValues are >>>>
					// {"+insertParam+"}");
					String getAutoUniqueKey = getAlphaNumericString(13,cCode);
					String form_Name = "form_Name";
					String sql = "INSERT INTO " + tempTableName + " (fileUploadDate" + "," + "unique_Key" + ","
							+ coulumnForClientTable + "," + form_Name + ") VALUES(" + "'" + df.format(dateobj) + "'"
							+ "," + "'" + getAutoUniqueKey + "'" + "," + insertParam + "," + "'" + formName + "'" + ")";
					// log.info("sql ::" + sql);
					SQLQuery sqlQuery = session.createSQLQuery(sql);
					sqlQuery.executeUpdate();
					tx.commit();
				} catch (RuntimeException se) {
					log.error("Exception occoured while inserting data into {" + tempTableName + "} table >> ", se);
					return "dbError";
				}
				// log.info("insert string ::" + insertParam);
			}
			log.info("End importExcelFileToDataBase() method");
			return "success";
		} finally {
			session.close();
		}
	}

	private String getAlphaNumericString(int n, String cCode) {

		char[] symbolsString1 = new char[] {};
		StringBuilder tmp = new StringBuilder();
		char ch = 'a';
		while (ch <= 'g') {
			tmp.append(ch);
			char ch1 = 'a';
			while (ch1 <= 'd') {
				tmp.append(ch1);
				symbolsString1 = tmp.toString().toCharArray();
				ch1 = (char) (ch1 + '\u0001');
			}
			ch = (char) (ch + '\u0001');
		}

		double captNumber = 5.0 + Math.random() * 5.0;
		String genCapt = String.valueOf(captNumber).substring(2, 4);
		String ranGenString = symbolsString1.toString().substring(3, 7);
		String genAlphaNum = String.valueOf(ranGenString) + genCapt;

		// chose a Character random from this String
		String AlphaNumericString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ" + "0123456789" + "abcdefghijklmnopqrstuvxyz";

		// create StringBuffer size of AlphaNumericString
		StringBuilder sb = new StringBuilder(n);
		sb.append(cCode);
		for (int i = 0; i < n; i++) {

			// generate a random number between
			// 0 to AlphaNumericString variable length
			int index = (int) (AlphaNumericString.length() * Math.random());

			// add Character one by one in end of sb
			sb.append(AlphaNumericString.charAt(index));
		}
		sb.append(genAlphaNum);
		log.info("generated UniqueKey is : " + sb.toString());

		return sb.toString();
	}

	@Override
	public BeanPayerType getPayerDetails(Integer id) {
		log.debug("Start getPayerDetails() method and searching in data_form_details " + id);
		Session session = factory.openSession();
		BeanPayerType payerDetails = new BeanPayerType();
		try {
			Criteria cr = session.createCriteria(BeanPayerType.class);
			cr.add((Criterion) Restrictions.eq((String) "id", (Object) id));
			BeanPayerType beanPayerDetails = payerDetails = (BeanPayerType) cr.list().get(0);
			// log.info("returning form name is "+beanFormDetails.getPayer_type());
			log.info("End getFormDetails() method");
			return beanPayerDetails;
		} catch (Exception e) {
			e.printStackTrace();
			BeanPayerType beanPayerDetails = payerDetails;
			return beanPayerDetails;
		} finally {
			session.close();
		}
	}

	@Override
	public String saveDataInToTempTable(ArrayList<String> columnListOfFirstRow, String insertParam,
			String tempTableNameForFileUpload, String formName, String cCode) {
		log.info("Start saveDataInToTempTable() method and searching in data_form_details ");
		Session session = factory.openSession();
		String key = null;
		String coulumnForClientTable = "";
		Transaction tx = session.beginTransaction();
		try {
			insertParam = insertParam.substring(1, insertParam.length());
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date dateobj = new Date();
			log.info(df.format(dateobj));
			coulumnForClientTable = String.join(",", columnListOfFirstRow);
			/*
			 * log.info("inserting values into { zz_client_user_data_"+ formId +
			 * "} >>>> for coulmn is >>>> {"+coulumnForClientTable
			 * +"}, and coulumnValues are >>>> {"+insertParam+"}");
			 */
			String getAutoUniqueKey = getAlphaNumericString(13, cCode);
			String form_Name = "form_Name";
			String sql = "INSERT INTO " + tempTableNameForFileUpload + " (fileUploadDate" + "," + "unique_Key" + ","
					+ coulumnForClientTable + "," + form_Name + ") VALUES(" + "'" + df.format(dateobj) + "'"
					+ "," + "'" + getAutoUniqueKey + "'" + "," + insertParam + "," + "'" + formName + "'" + ")";
			// log.info("sql ::" + sql);
			SQLQuery sqlQuery = session.createSQLQuery(sql);
			sqlQuery.executeUpdate();
			tx.commit();
			return "success";
		} catch (RuntimeException se) {
			log.error("Exception occoured while inserting data into {" + tempTableNameForFileUpload + "} table >> ",
					se);
			return "dbError";
		}
	}

	@Override
	public ArrayList<String> fetchListOfFieldsAsFieldName(String fieldName) {
		Session session = factory.openSession();
		ArrayList<String> fieldLookupList = new ArrayList<String>();
		String fQuery = "";
		try {
			fQuery = "select lookup_name from lookup_inventory_fields where lookup_name like '%"+fieldName+"%'";
			log.info("Selected Query is : "+fQuery);
			SQLQuery query1 = session.createSQLQuery(fQuery);
			fieldLookupList = (ArrayList<String>) query1.list();
			fieldLookupList.add(fieldName);
		}catch(Exception e) {
			log.error(e.getMessage());
		}finally {
			session.close();
		}
		log.info("fieldLookupList : "+fieldLookupList.toString());
		return fieldLookupList;
	}

	@Override
	public ArrayList<String> fetchListOfValidationAsFieldName(String fieldName) {
		Session session = factory.openSession();
		ArrayList<String> fieldLookupList = new ArrayList<String>();
		String fQuery = "";
		try {
			
			fQuery = "select lookup_type from lookup_inventory_fields where lookup_name like '%"+fieldName+"%'";
			
			log.info("Selected Query is : "+fQuery);
			SQLQuery query1 = session.createSQLQuery(fQuery);
			fieldLookupList = (ArrayList<String>) query1.list();
			log.info("list size is 1 : "+fieldLookupList.size());
		}catch(Exception e) {
			log.error(e.getMessage());
		}finally {
			session.close();
		}
		log.info("fieldLookupList : "+fieldLookupList.toString());
		return fieldLookupList;
	}

	@Override
	public Map<String, ArrayList<String>> fetchListOfFieldsAsColumnList(ArrayList<String> columnListOfFirstRow) {
		// TODO Auto-generated method stub
		return null;
	}
}
