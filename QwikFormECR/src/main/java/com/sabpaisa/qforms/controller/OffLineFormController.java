package com.sabpaisa.qforms.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.parsers.ParserConfigurationException;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.xml.sax.SAXException;

import com.sabpaisa.qforms.beans.BeanFieldLookup;
import com.sabpaisa.qforms.beans.BeanFormDetails;
import com.sabpaisa.qforms.beans.BeanPayerType;
import com.sabpaisa.qforms.beans.LoginBean;
import com.sabpaisa.qforms.config.AppPropertiesConfig;
import com.sabpaisa.qforms.services.DaoFeeService;
import com.sabpaisa.qforms.services.DaoFieldLookupService;
import com.sabpaisa.qforms.services.OffLineFormService;
import com.sabpaisa.qforms.services.SampleFormService;

@CrossOrigin
@Controller
@RequestMapping
public class OffLineFormController {

	@Autowired
	private DaoFeeService daoFeeService;

	@Autowired
	private SampleFormService sampleFormService;

	@Autowired
	private OffLineFormService offLineFormService;

	@Autowired
	DaoFieldLookupService daoFieldLookupService;

	private static final Logger log = LogManager.getLogger("OffLineFormController.class");
	LoginBean loginBean = new LoginBean();
	BeanFieldLookup beanFieldLookup = new BeanFieldLookup();
	BeanPayerType beanPayerType = new BeanPayerType();
	BeanFormDetails beanFormDetail = new BeanFormDetails();
	AppPropertiesConfig locationProperties = new AppPropertiesConfig();
	Properties properties = locationProperties.getPropValues();
	String uploadPath = properties.getProperty("uploadFilePath");
	String qFormsIP = properties.getProperty("qFormsIP");

	// use for Burdhwan University
	String cidForMaxFilledSeat1 = properties.getProperty("cidForMaxFilledSeat1");
	String cidForMaxFilledSeat2 = properties.getProperty("cidForMaxFilledSeat2");
	String cidForMaxFilledSeat3 = properties.getProperty("cidForMaxFilledSeat3");

	private ArrayList<String> recordsHeaders = new ArrayList<String>();

	private String fileUploadFileName;
	private File fileUpload;
	String folder = "D:\\";
	private static final long serialVersionUID = 1L;
	
	// excel file upload page open
	@RequestMapping(value = "/offLineFormUpload")
	public ModelAndView offLineFormUpload(HttpServletRequest request, HttpServletResponse response, HttpSession ses) {

		loginBean = (LoginBean) ses.getAttribute("loginUserBean");
		ModelAndView mav = new ModelAndView("OffLineFormUpload");
		ses.setAttribute("flag_session", "S");

		return mav;
	}

	// <<Praveen offLineFormUploadForReInsert Development>> use for uploading new
	// excel file of the form
	@RequestMapping(value = "/offLineFormUploadForReInsert")
	public ModelAndView offLineFormUploadForReInsert(HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) {

		loginBean = (LoginBean) ses.getAttribute("loginUserBean");
		ModelAndView mav = new ModelAndView("OffLineFormUploadForReInsert");
		ses.setAttribute("flag_session", "S");

		return mav;
	}

	@RequestMapping(value = "/addBulkDataFromFile")
	public String addBulkRecord(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession ses,
			@RequestParam MultipartFile fileUpload, RedirectAttributes redirectAttributes)
			throws IOException, ParserConfigurationException, InvalidFormatException, SAXException {

		log.info("Start of addBulkDataFromFile() method");
		if (null != ses.getAttribute("columnListOfFirstRow")) {
			ses.removeAttribute("columnListOfFirstRow");

		}
		if (null != ses.getAttribute("fieldLookupList")) {
			ses.removeAttribute("fieldLookupList");

		}
		fileUploadFileName = new String();
		Boolean isCSV = false;
		BeanFieldLookup fieldLookup = new BeanFieldLookup();
		if (null != fileUpload) {
			byte[] bytes = fileUpload.getBytes();
			Path path = Paths.get("" + fileUpload.getOriginalFilename());
			log.info("fileUploadFileName path :::::::::::: " + path.toString());

			Files.write(path, bytes);

			fileUploadFileName = fileUpload.getOriginalFilename();

			log.info("fileUploadFileName :::::::::::: " + fileUploadFileName.toString());

			if (fileUploadFileName.endsWith(".xlsx") || fileUploadFileName.endsWith(".csv") || fileUploadFileName.endsWith(".xls")) {

				try {
					Integer totalFileSize = null;
					String ext = null;
					String dbpath = null;
					String OS = System.getProperty("os.name").toLowerCase();
					if (OS.indexOf("win") >= 0) {// if windows
						uploadPath = folder;
					}
					try {
						totalFileSize = new File(uploadPath).listFiles().length;
						totalFileSize = totalFileSize + 1;
						log.info("File Name is +++++++++++ " + fileUploadFileName.toString());
						if (fileUploadFileName.endsWith(".csv")) {
							isCSV = true;
						}
						ext = FilenameUtils.getExtension(fileUploadFileName);
						log.info("File Extenssion is +++++++++++ " + ext.toString());
						fileUploadFileName = StringUtils.removeEnd(fileUploadFileName, "." + ext);
						dbpath = uploadPath + "/" + fileUploadFileName + "_" + totalFileSize.toString() + "." + ext;
						log.info("File saved at Path == {" + dbpath + "}");
					} catch (Exception e) {
						dbpath = uploadPath + "/" + fileUploadFileName;
						e.printStackTrace();
					}
					File dstFile = new File(dbpath);
					log.info("dstFile is ::::::::::: " + dstFile);
					new File(uploadPath).mkdirs();
					Path source = Paths.get(fileUpload.getOriginalFilename());
					Path destination = Paths.get(dstFile.getPath());
					log.info("source for file : " + source + ", : destination for file : " + destination);
					Files.copy(source, destination, StandardCopyOption.REPLACE_EXISTING);
					log.info("File Name is ::" + fileUploadFileName);
					if (isCSV) {
						log.info("Got CSV File");
						try {
							String csvFileAddress = dbpath;
							ext = FilenameUtils.getExtension(csvFileAddress);
							String xlsxFileAddress = StringUtils.removeEnd(csvFileAddress, "." + ext);
							xlsxFileAddress = xlsxFileAddress + "_" + totalFileSize.toString() + ".xlsx";
							log.info("New File NaME IS " + xlsxFileAddress);
							XSSFWorkbook workBook = new XSSFWorkbook();
							XSSFSheet sheet = workBook.createSheet("sheet1");
							String currentLine = null;
							int RowNum = 0;
							BufferedReader br = new BufferedReader(new FileReader(csvFileAddress));
							while ((currentLine = br.readLine()) != null) {
								String str[] = currentLine.split(",");

								XSSFRow currentRow = sheet.createRow(RowNum);
								for (int i = 0; i < str.length; i++) {
									currentRow.createCell(i).setCellValue(str[i]);
								}
								RowNum++;
							}
							FileOutputStream fileOutputStream = new FileOutputStream(xlsxFileAddress);
							workBook.write(fileOutputStream);
							fileOutputStream.close();
							File dstFile1 = new File(xlsxFileAddress);
							log.info("System File Path=" + dstFile1.getCanonicalPath());
							dstFile = dstFile1;
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
					try {
						log.info("upload final path is ::" + dstFile);
						ArrayList<String> columnListOfFirstRow = new ArrayList<String>();
						List<Integer> fieldLookupList = new ArrayList<Integer>();
						columnListOfFirstRow = offLineFormService.generateColumnList(dstFile, ses);
						
						for (int i = 0; i < columnListOfFirstRow.size(); i++) {
							log.info(i + " value of columnListOf FirstRow is :::::::: "
									+ columnListOfFirstRow.get(i).toString());
							fieldLookup.setLookup_name(columnListOfFirstRow.get(i));
							fieldLookup.setLookup_type("Input");
							if (!fieldLookup.getLookup_name().equals("EMAIL_ID")
									&& !fieldLookup.getLookup_name().equals("EmailId")
									&& !fieldLookup.getLookup_name().equals("Email_Id")
									&& !fieldLookup.getLookup_name().equals("email")
									&& !fieldLookup.getLookup_name().equals("Email")
									&& !fieldLookup.getLookup_name().equals("emaild")
									&& !fieldLookup.getLookup_name().equals("PUBLICATION_EMAIL")) {
								log.info("it is in if block :::");
								fieldLookup.setLookup_subtype("Text");
							} else {
								log.info("it is in else block :::");
								fieldLookup.setLookup_subtype("Email");
							}
							fieldLookup.setIsVisible(Integer.valueOf(1));
							beanFieldLookup = daoFieldLookupService.saveField(fieldLookup);
							fieldLookupList.add(beanFieldLookup.getLookup_id());
							ses.setAttribute("msg",
									(Object) "Field Saved Successfully the form builder will now reload...");
							ses.setAttribute("link", "window.location='formCustomField'");
						}
						log.info("fieldLookupList with number of lookupId :: " + fieldLookupList.toString());
						log.info("fieldLookupList with number of lookupId :: " + fieldLookupList.size());
						ses.setAttribute("fieldLookupList", fieldLookupList);
						
						ses.setAttribute("columnListOfFirstRow", columnListOfFirstRow);
						ses.setAttribute("dbpath", dbpath);
						log.info("columnListOfFirstRow flag is ::" + columnListOfFirstRow.toString());
						if (columnListOfFirstRow.isEmpty()) {
							request.setAttribute("msg", "Some Headers Missing ,not able upload Record");
							return "OffLineFormUpload";
						} else {
							return "OffLineFormPreview";
						}
					} catch (NullPointerException e) {
						e.printStackTrace();
						request.setAttribute("msg", "Not able to upload file issue \n may be issue in configuration");
						return "OffLineFormUpload";
					}
				} catch (Exception e) {
					e.printStackTrace();
					request.setAttribute("msg", "Error in file uploading, please try again.");
					return "OffLineFormUpload";
				}
			} else {
				String msg = "Please Select Proper File Format";
				request.setAttribute("msg", msg);
				return "OffLineFormUpload";
			}
		} else {
			String columnList = (String) ses.getAttribute("columnListOfFirstRow");
			String fieldLookup1 = (String) ses.getAttribute("fieldLookupList");
			if (null != columnList && null != fieldLookup1) {
				log.info("columnList :: " + columnList);
				log.info("columnList :: " + fieldLookup1);
			}
			ses.setAttribute("fieldLookupList", fieldLookup1);
			ses.setAttribute("columnListOfFirstRow", columnList);
			return "OffLineFormPreview";
		}
	}

	@RequestMapping(value = "/uploadBulkDataForReInsert")
	public String uploadBulkDataForReInsert(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses, @RequestParam MultipartFile fileUpload, RedirectAttributes redirectAttributes)
			throws IOException, ParserConfigurationException, InvalidFormatException, SAXException {

		log.info("Start of uploadBulkDataForReInsert() method");
		Boolean isCSV = false;
		Map<Integer, ArrayList<Object>> inParam = new HashMap<Integer, ArrayList<Object>>();
		if (null != fileUpload) {
			byte[] bytes = fileUpload.getBytes();
			Path path = Paths.get("" + fileUpload.getOriginalFilename());
			// log.info("fileUploadFileName path :::::::::::: " + path.toString());
			Files.write(path, bytes);
			fileUploadFileName = fileUpload.getOriginalFilename();
			// log.info("fileUploadFileName :::::::::::: " + fileUploadFileName.toString());
			if (fileUploadFileName.endsWith(".xlsx") || fileUploadFileName.endsWith(".csv")) {
				try {
					Integer totalFileSize = null;
					String ext = null;
					String dbpath = null;

					String OS = System.getProperty("os.name").toLowerCase();
					if (OS.indexOf("win") >= 0) {// if windows
						uploadPath = folder;
					}
					try {
						totalFileSize = new File(uploadPath).listFiles().length;
						totalFileSize = totalFileSize + 1;
						// log.info("File Name is +++++++++++ " + fileUploadFileName.toString());
						if (fileUploadFileName.endsWith(".csv")) {
							isCSV = true;
						}
						ext = FilenameUtils.getExtension(fileUploadFileName);
						log.info("File Extenssion is +++++++++++ " + ext.toString());
						fileUploadFileName = StringUtils.removeEnd(fileUploadFileName, "." + ext);
						dbpath = uploadPath + "/" + fileUploadFileName + "_" + totalFileSize.toString() + "." + ext;
						// log.info("File saved at Path == {" + dbpath + "}");
					} catch (Exception e) {
						dbpath = uploadPath + "/" + fileUploadFileName;
						e.printStackTrace();
					}
					File dstFile = new File(dbpath);
					// log.info("dstFile is ::::::::::: " + dstFile);
					new File(uploadPath).mkdirs();
					Path source = Paths.get(fileUpload.getOriginalFilename());
					Path destination = Paths.get(dstFile.getPath());
					// log.info("source for file : " + source + ", : destination for file : " +
					// destination);
					Files.copy(source, destination, StandardCopyOption.REPLACE_EXISTING);
					// log.info("File Name is ::" + fileUploadFileName);
					if (isCSV) {
						log.info("Got CSV File");
						try {
							String csvFileAddress = dbpath;
							ext = FilenameUtils.getExtension(csvFileAddress);
							String xlsxFileAddress = StringUtils.removeEnd(csvFileAddress, "." + ext);
							xlsxFileAddress = xlsxFileAddress + "_" + totalFileSize.toString() + ".xlsx";
							// log.info("New File NaME IS " + xlsxFileAddress);
							XSSFWorkbook workBook = new XSSFWorkbook();
							XSSFSheet sheet = workBook.createSheet("sheet1");
							String currentLine = null;
							int RowNum = 0;
							BufferedReader br = new BufferedReader(new FileReader(csvFileAddress));
							while ((currentLine = br.readLine()) != null) {
								String str[] = currentLine.split(",");
								XSSFRow currentRow = sheet.createRow(RowNum);
								for (int i = 0; i < str.length; i++) {
									currentRow.createCell(i).setCellValue(str[i]);
								}
								RowNum++;
							}
							FileOutputStream fileOutputStream = new FileOutputStream(xlsxFileAddress);
							workBook.write(fileOutputStream);
							fileOutputStream.close();
							// log.info("Done");
							File dstFile1 = new File(xlsxFileAddress);
							// log.info("System File Path=" + dstFile1.getCanonicalPath());
							dstFile = dstFile1;
							// FileUtils.copyFile(fileUpload, dstFile1);
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
					try {
						// log.info("upload final path is ::" + dstFile);
						FileInputStream fileInputStream = new FileInputStream(dstFile);
						ArrayList<String> columnListOfFirstRow = new ArrayList<String>();
						columnListOfFirstRow = offLineFormService.generateColumnList(dstFile, ses);
						// log.info("columnListOfFirstRow :::: "+columnListOfFirstRow.toString());
						inParam = this.importExcelFileToDataBase(ses, loginBean, fileInputStream, columnListOfFirstRow);
						// log.info("insertable value is :::::::: "+inParam.toString());
						ses.setAttribute("msg",
								(Object) "Field Saved Successfully the form builder will now reload...");
						ses.setAttribute("columnListOfFirstRow", columnListOfFirstRow);
						ses.setAttribute("insertParam", inParam);
						// log.info("columnListOfFirstRow flag is ::" +
						// columnListOfFirstRow.toString());
						if (columnListOfFirstRow.isEmpty()) {
							request.setAttribute("msg", "Some Headers Missing ,not able upload Record");
							return "OffLineFormUploadForReInsert";
						} else {
							return "Success";
						}
					} catch (NullPointerException e) {
						e.printStackTrace();
						request.setAttribute("msg", "Not able to upload file issue \n may be issue in configuration");
						return "OffLineFormUploadForReInsert";
					}
				} catch (Exception e) {
					e.printStackTrace();
					request.setAttribute("msg", "Error in file uploading, please try again.");
					return "OffLineFormUploadForReInsert";
				}
			} else {
				// log.info("file Format not Match");
				String msg = "Please Select Proper File Format";
				request.setAttribute("msg", msg);
				return "OffLineFormUploadForReInsert";
			}
		} else {
			String msg = "Please Select Proper File Format";
			request.setAttribute("msg", msg);
			return "OffLineFormUploadForReInsert";
		}
	}

	public Map<Integer, ArrayList<Object>> importExcelFileToDataBase(HttpSession ses, LoginBean loginBean,
			FileInputStream fileInputStream, ArrayList<String> columnListOfFirstRow) throws IOException {

		log.info("Start importExcelFileToDataBase() method");
		Map<Integer, ArrayList<Object>> inParam = new HashMap<Integer, ArrayList<Object>>();
		XSSFWorkbook xssfWorkbook = new XSSFWorkbook(fileInputStream);
		XSSFSheet hssfSheet = xssfWorkbook.getSheetAt(0);
		Integer exceColSize = columnListOfFirstRow.size();
		ArrayList<String> emailArrayList = new ArrayList<String>();
		try {
			Iterator<Row> rows = hssfSheet.rowIterator();
			String stringVal, blankVal, errorlVal, booleanval, defaultVal;
			String clientId = loginBean.getCollgBean().getCollegeId().toString();
			String UserId = loginBean.getCollgBean().getCollegeId().toString();
			Long numVal;
			XSSFCell cell = null;
			String coulumnForClientTable = "";
			int j = 1;
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
						// log.info("After removing Special char, cell value is {"+
						// tempCellVAlue.trim().replaceAll("[^\\p{Alpha}\\d@.'_\\s-]", "") + "}");
						tempArrayList.add(tempCellVAlue.trim().replaceAll("[^\\p{Alpha}\\d@.'_\\s-]", ""));
					} catch (NullPointerException NE) {
						log.info("Cell number yahi wala dikkat diya at number:" + i + " - " + NE);
						tempArrayList.add("");
					}
					i++;
				}
				// log.info("Insert Value list size ::" + tempArrayList.size());
				// log.info("Insert Value list size ::" + tempArrayList.toString());
				// log.info("Column list size ::" + exceColSize);
				if (!exceColSize.equals(tempArrayList.size())) {
					log.info("Column Size is not matched, So return excelError status");
				}
				// log.info("finally temArrayList in outer loop ::::
				// "+tempArrayList.toString());
				inParam.put(j, tempArrayList);
				j++;
			}
			// log.info("finally inParam is in outer loop :::: "+inParam.toString());
		} finally {
			// session.close();
		}
		return inParam;
	}

	@RequestMapping(value = "/saveFormDataAsNewTarget", method = { RequestMethod.GET, RequestMethod.POST })
	public String saveFormDataAsNewTarget(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses) {

		ArrayList<String> columnListOfFirstRow = new ArrayList<String>();
		columnListOfFirstRow = (ArrayList<String>) ses.getAttribute("columnListOfFirstRow");
		log.info("columnListOfFirstRow :::: " + columnListOfFirstRow.toString());
		String status = null;
		String clientCode = "";
		String tempTableNameForFileUpload = "";
		String tempTableName = "";
		BeanPayerType payerTypeBean = new BeanPayerType();
		ArrayList<Object> cellVal = new ArrayList<Object>();
		Map<Integer, ArrayList<Object>> inParam = new HashMap<Integer, ArrayList<Object>>();
		inParam = (Map<Integer, ArrayList<Object>>) ses.getAttribute("insertParam");
		log.info("insertable value in database :::: " + inParam.toString());
		Integer formId = Integer.parseInt(request.getParameter("formId"));
		log.info("New formId is ::: " + formId);
		BeanFormDetails bfd = new BeanFormDetails();
		bfd = sampleFormService.getFormDetails(formId);
		clientCode = bfd.getFormOwnerName();

		if (null != bfd.getPayer_type()) {
			payerTypeBean = daoFieldLookupService.getPayerLookupsById(bfd.getPayer_type());
		}

		String payerType = "";
		if (null != payerTypeBean.getPayer_type()) {
			payerType = payerTypeBean.getPayer_type();
			payerType = payerType.replaceAll("\\s", "_");
			payerType = payerType.replaceAll("'", "apos");
			payerType = payerType.replaceAll("/", "fslsh");
			payerType = payerType.replaceAll("\\\\", "bslsh");
			payerType = payerType.replaceAll("\\*", "astrk");
			payerType = payerType.replaceAll("\\(", "obkt");
			payerType = payerType.replaceAll("\\)", "cbkt");
			payerType = payerType.replaceAll("\\-", "hphn");
			payerType = payerType.replaceAll("\\:", "cln");
			payerType = payerType.replaceAll("\\.", "dot");
		}

		tempTableNameForFileUpload = "zz_" + clientCode + "_" + payerType + "_" + formId;
		// tempTableName = "zz_client_user_data_" + formId;

		log.info("formName is ::: " + bfd.getFormName());
		for (Map.Entry<Integer, ArrayList<Object>> temp : inParam.entrySet()) {
			cellVal = temp.getValue();
			String insertParam = new String();
			Iterator<Object> iterator = cellVal.iterator();
			while (iterator.hasNext()) {
				String ss = (String) iterator.next();
				insertParam = insertParam + "," + "'" + ss + "'";
				// log.info("insertParam in loop :::: "+insertParam);
			}
			status = offLineFormService.saveDataInToTempTable(columnListOfFirstRow, insertParam,
					tempTableNameForFileUpload, bfd.getFormName(), bfd.getFormOwnerName());
		}
		log.info("status is ::::: " + status);
		if (null != status && status.equalsIgnoreCase("success")) {
			return "Success";
		} else {

			return "errorPage";
		}
	}

	// http://localhost:8081/QForms/payerFormForLP?formid=46&bid=3&cid=125&PayeeProfile=MAYURBAREILLY
	@RequestMapping(value = "/linksForFormPay", method = { RequestMethod.GET, RequestMethod.POST })
	public String linksForFormPay(ModelMap model, HttpSession ses, HttpServletRequest request) {

//		 = request.getSession();
		Integer formid = Integer.parseInt(request.getParameter("reqFormId"));
		log.info("formid :::::::::::::: " + formid.toString());
		BeanFormDetails formDetails = new BeanFormDetails();
		BeanPayerType payerDetails = new BeanPayerType();
		String bid = "", cid = "", payerProfile = "";
		String clientUrl = "";
		String validateFieldName = null;
		formDetails = sampleFormService.getFormDetails(formid);
		log.info("FormDetals is :::::::::: " + formDetails.toString() + "and client code is ::::::::: "+ formDetails.getFormOwnerName());
		Integer payerId = formDetails.getPayer_type();
		log.info("PayerId by given form details is :::::::::::: " + payerId.toString());
		validateFieldName = formDetails.getValidateFieldOfExcel();
		log.info("validateFieldName by given form details is :::::::::::: " + validateFieldName.toString());
		payerDetails = offLineFormService.getPayerDetails(payerId);
		log.info("current payerid is as per database table of payers :::::::: " + payerDetails.getPayer_id().toString());
		bid = payerDetails.getBid();
		cid = payerDetails.getCid();
		payerProfile = payerDetails.getPayer_type();
		if (validateFieldName.isEmpty()) {
			clientUrl = qFormsIP + "StartUrl?bid=" + bid + "&cid=" + cid;
		} else {
			// log.info("Client id for BU form property file :::: "+cidForMaxFilledSeat1);
			clientUrl = qFormsIP + "validateFieldFormById?formid=" + formid + "&bid=" + bid + "&cid=" + cid
					+ "&PayeeProfile=" + payerProfile;
			// log.info("Now FormURL for user is :::::::::: " + clientUrl);
		}
		request.setAttribute("clientUrl", clientUrl);
		return "LinksForFormPay";
	}

	public DaoFeeService getDaoFeeService() {
		return daoFeeService;
	}

	public void setDaoFeeService(DaoFeeService daoFeeService) {
		this.daoFeeService = daoFeeService;
	}

	public LoginBean getLoginBean() {
		return loginBean;
	}

	public void setLoginBean(LoginBean loginBean) {
		this.loginBean = loginBean;
	}

	public BeanPayerType getBeanPayerType() {
		return beanPayerType;
	}

	public void setBeanPayerType(BeanPayerType beanPayerType) {
		this.beanPayerType = beanPayerType;
	}

	public BeanFormDetails getBeanFormDetail() {
		return beanFormDetail;
	}

	public void setBeanFormDetail(BeanFormDetails beanFormDetail) {
		this.beanFormDetail = beanFormDetail;
	}

	public ArrayList<String> getRecordsHeaders() {
		return recordsHeaders;
	}

	public void setRecordsHeaders(ArrayList<String> recordsHeaders) {
		this.recordsHeaders = recordsHeaders;
	}

	public String getUploadPath() {
		return uploadPath;
	}

	public void setUploadPath(String uploadPath) {
		this.uploadPath = uploadPath;
	}

	public String getFileUploadFileName() {
		return fileUploadFileName;
	}

	public void setFileUploadFileName(String fileUploadFileName) {
		this.fileUploadFileName = fileUploadFileName;
	}

	public File getFileUpload() {
		return fileUpload;
	}

	public void setFileUpload(File fileUpload) {
		this.fileUpload = fileUpload;
	}

	public String getFolder() {
		return folder;
	}

	public void setFolder(String folder) {
		this.folder = folder;
	}

}
