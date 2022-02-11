package com.sabpaisa.qforms.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
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
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.xml.sax.SAXException;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sabpaisa.qforms.beans.BeanFieldLookup;
import com.sabpaisa.qforms.beans.BeanFormDetails;
import com.sabpaisa.qforms.beans.BeanPayerType;
import com.sabpaisa.qforms.beans.CollegeBean;
import com.sabpaisa.qforms.beans.FetchTransactionDetails;
import com.sabpaisa.qforms.beans.SampleFormBean;
import com.sabpaisa.qforms.beans.SampleFormView;
import com.sabpaisa.qforms.config.AppPropertiesConfig;
import com.sabpaisa.qforms.services.CollegeService;
import com.sabpaisa.qforms.services.DaoFieldLookupService;
import com.sabpaisa.qforms.services.LoginDAOService;
import com.sabpaisa.qforms.services.OffLineFormService;
import com.sabpaisa.qforms.services.SampleTransService;

@Controller
@RequestMapping
@CrossOrigin
public class TempToDeleteController {

	@Autowired
	DaoFieldLookupService daoFieldLookupService;

	@Autowired
	CollegeService collegeService;

	@Autowired
	OffLineFormService offLineFormService;

	@Autowired
	LoginDAOService loginDAOService;

	@Autowired
	SampleTransService sampleTransService;

	@Autowired
	SessionFactory factory;

	private static Logger log = LogManager.getLogger(TempToDeleteController.class.getName());

	private AppPropertiesConfig locationProperties = new AppPropertiesConfig();
	private Properties properties = locationProperties.getPropValues();
	private String uploadPath = properties.getProperty("uploadFilePath");
	private String folder = "D:\\";
	private BeanFieldLookup beanFieldLookup = new BeanFieldLookup();
	private static final ObjectMapper mapper = new ObjectMapper();

	/* Use for fetching transaction data by txn id */

	/* Use for fetching transaction data by txn id */

	@RequestMapping(value = "/offLineFormUploadNew")
	public ModelAndView offLineFormUpload(HttpServletRequest request, HttpServletResponse response, HttpSession ses) {

		// loginBean = (LoginBean) OffLineFormUpload ses.getAttribute("");
		ModelAndView mav = new ModelAndView("OffLineFormUploadForInventory");
		ses.setAttribute("flag_session", "S");

		return mav;
	}

	@RequestMapping(value = "/addFieldForSuggessionProcess")
	public String addFieldForSuggessionProcess(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession ses, @RequestParam MultipartFile fileUpload, RedirectAttributes redirectAttributes)
			throws IOException, ParserConfigurationException, InvalidFormatException, SAXException {

		log.info("Start of addFieldForSuggessionProcess() method");
		if (null != ses.getAttribute("columnListOfFirstRow")) {
			ses.removeAttribute("columnListOfFirstRow");

		}
		if (null != ses.getAttribute("fieldLookupList")) {
			ses.removeAttribute("fieldLookupList");

		}
		String fileUploadFileName = new String();
		Boolean isCSV = false;
		BeanFieldLookup fieldLookup = new BeanFieldLookup();
		ArrayList<String> columnListOfFirstRow = new ArrayList<String>();
		ArrayList<String> fieldLookupList = new ArrayList<String>();
		Map<String, ArrayList<String>> mappedFieldList = new HashMap<String, ArrayList<String>>();
		Map<String, ArrayList<String>> mappedValidationList = new HashMap<String, ArrayList<String>>();
		if (null != fileUpload) {
			byte[] bytes = fileUpload.getBytes();
			Path path = Paths.get("" + fileUpload.getOriginalFilename());
			log.debug("fileUploadFileName path :::::::::::: " + path.toString());

			Files.write(path, bytes);

			fileUploadFileName = fileUpload.getOriginalFilename();

			log.debug("fileUploadFileName :::::::::::: " + fileUploadFileName.toString());

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
						log.debug("File Name is +++++++++++ " + fileUploadFileName.toString());
						if (fileUploadFileName.endsWith(".csv")) {
							isCSV = true;
						}
						ext = FilenameUtils.getExtension(fileUploadFileName);
						log.debug("File Extenssion is +++++++++++ " + ext.toString());
						fileUploadFileName = StringUtils.removeEnd(fileUploadFileName, "." + ext);
						dbpath = uploadPath + "/" + fileUploadFileName + "_" + totalFileSize.toString() + "." + ext;
						log.debug("File saved at Path == {" + dbpath + "}");
					} catch (Exception e) {
						dbpath = uploadPath + "/" + fileUploadFileName;
						e.printStackTrace();
					}
					File dstFile = new File(dbpath);
					log.debug("dstFile is ::::::::::: " + dstFile);
					new File(uploadPath).mkdirs();
					Path source = Paths.get(fileUpload.getOriginalFilename());
					Path destination = Paths.get(dstFile.getPath());
					log.debug("source for file : " + source + ", : destination for file : " + destination);
					Files.copy(source, destination, StandardCopyOption.REPLACE_EXISTING);
					log.debug("File Name is ::" + fileUploadFileName);
					if (isCSV) {
						log.info("Got CSV File");
						try {
							String csvFileAddress = dbpath;
							ext = FilenameUtils.getExtension(csvFileAddress);
							String xlsxFileAddress = StringUtils.removeEnd(csvFileAddress, "." + ext);
							xlsxFileAddress = xlsxFileAddress + "_" + totalFileSize.toString() + ".xlsx";
							log.debug("New File NaME IS " + xlsxFileAddress);
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
							log.debug("System File Path=" + dstFile1.getCanonicalPath());
							dstFile = dstFile1;
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
					try {
						log.debug("upload final path is ::" + dstFile);

						columnListOfFirstRow = offLineFormService.generateColumnList(dstFile, ses);

						mappedFieldList = offLineFormService.fetchListOfFieldsAsColumnList(columnListOfFirstRow);

						mappedValidationList = offLineFormService
								.fetchListOfValidationAsColumnList(columnListOfFirstRow);

//						for (int i = 0; i < columnListOfFirstRow.size(); i++) {
//							log.info(i + " value of columnListOf FirstRow is :::::::: "	+ columnListOfFirstRow.get(i).toString());
//							String fieldName=columnListOfFirstRow.get(i).toString();
//							
//							fieldLookupList=offLineFormService.fetchListOfFieldsAsFieldName(fieldName);
//							
//							fieldLookup.setLookup_name(columnListOfFirstRow.get(i));
//							fieldLookup.setLookup_type("Input");
//							if (!fieldLookup.getLookup_name().equals("EMAIL_ID")
//									&& !fieldLookup.getLookup_name().equals("EmailId")
//									&& !fieldLookup.getLookup_name().equals("Email_Id")
//									&& !fieldLookup.getLookup_name().equals("email")
//									&& !fieldLookup.getLookup_name().equals("Email")
//									&& !fieldLookup.getLookup_name().equals("emaild")
//									&& !fieldLookup.getLookup_name().equals("PUBLICATION_EMAIL")) {
//								log.debug("it is in if block :::");
//								fieldLookup.setLookup_subtype("Text");
//							} else {
//								log.debug("it is in else block :::");
//								fieldLookup.setLookup_subtype("Email");
//							}
//							fieldLookup.setIsVisible(Integer.valueOf(1));
//							beanFieldLookup = daoFieldLookupService.saveField(fieldLookup);
//							fieldLookupList.add(beanFieldLookup.getLookup_id());
//							ses.setAttribute("msg",
//									(Object) "Field Saved Successfully the form builder will now reload...");
//							ses.setAttribute("link", "window.location='formCustomField'");
//						}
//						log.debug("fieldLookupList with number of lookupId :: " + fieldLookupList.toString());
//						log.debug("fieldLookupList with number of lookupId :: " + fieldLookupList.size());

						model.addAttribute("mappedFieldList", mappedFieldList);
						model.addAttribute("mappedValidationList", mappedValidationList);
						model.addAttribute("columnListOfFirstRow", columnListOfFirstRow);

						// ses.setAttribute("mappedList", mappedList);

						// ses.setAttribute("columnListOfFirstRow", columnListOfFirstRow);
						ses.setAttribute("dbpath", dbpath);

						if (columnListOfFirstRow.isEmpty()) {
							request.setAttribute("msg", "Some Headers Missing ,not able upload Record");
							return "OffLineFormUpload";
						} else {
							log.info("columnListOfFirstRow flag is :: 1234 :  " + columnListOfFirstRow.toString());
							return "OffLineFormPreviewForFieldSuggession";
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
				log.debug("columnList :: " + columnList);
				log.debug("columnList :: " + fieldLookup1);
			}
			ses.setAttribute("fieldLookupList", fieldLookup1);
			ses.setAttribute("columnListOfFirstRow", columnList);
			return "OffLineFormPreview";
		}
	}

	public void fetchMap() {
		String name = "KKKKK";
		List a = new ArrayList();
		a.add("LL");
		a.add("GG");
		a.add("HH");
		a.add("JJ");
		a.add("KK");
		System.out.println(a.toString());
		name = "name=" + a.toString();
		System.out.println(name);
	}

	/*
	 * private ArrayList<SampleFormView> processFormViewForLP(Map<Integer, String>
	 * formDataMap, HttpSession ses, Integer formId) throws Exception {
	 * ArrayList<SampleFormView> formViewList = new ArrayList<SampleFormView>();
	 * Double amount = 0.0; log.info("processing form"); ArrayList<Integer> keySet =
	 * new ArrayList<Integer>(formDataMap.keySet()); SampleFormBean formBean = new
	 * SampleFormBean();
	 * 
	 * if (null != formId) { log.info("Now samplle form id is ::::::::::: " +
	 * formId); formBean = sampleFormService.getFormData(formId); }
	 * 
	 * int i = 0; log.info("key set is :: " + keySet.toString()); while (i <
	 * keySet.size()) { String[] formFieldValue =
	 * formDataMap.get(keySet.get(i)).split("=");
	 * 
	 * String fieldKey = keySet.get(i).toString(); String fieldValue =
	 * formFieldValue[0].toString(); log.debug("fieldKey in loop is ::: " +
	 * fieldKey); log.debug("formFieldValue[0].toString() in loop is ::: " +
	 * fieldValue + "," + "formFieldValue[1].toString()" +
	 * formFieldValue[1].toString());
	 * 
	 * if (formFieldValue.length != 2) {
	 * log.info("Form Field Value corrupt or Unreadable"); } else { SampleFormView
	 * formViewData = new SampleFormView(); String[] valueAndOrder =
	 * formFieldValue[1].split("\\$"); log.debug(("value is " + formFieldValue[1] +
	 * "and next array is " + valueAndOrder[0]));
	 * 
	 * String reGenerateValue = valueAndOrder[0].toString();
	 * 
	 * // if(null!=formBean) { //
	 * if(reGenerateValue.equalsIgnoreCase("File Upload1")) { // String
	 * filePath=formBean.getFile_Path1(); //
	 * reGenerateValue=getGeneratedStringValue(filePath); // } //
	 * if(reGenerateValue.equalsIgnoreCase("File Upload2")) { // String
	 * filePath=formBean.getFile_Path2(); //
	 * reGenerateValue=getGeneratedStringValue(filePath); // } //
	 * if(reGenerateValue.equalsIgnoreCase("File Upload3")) { // String
	 * filePath=formBean.getFile_Path3(); //
	 * reGenerateValue=getGeneratedStringValue(filePath); // } //
	 * if(reGenerateValue.equalsIgnoreCase("File Upload4")) { // String
	 * filePath=formBean.getFile_Path4(); //
	 * reGenerateValue=getGeneratedStringValue(filePath); // } //
	 * if(reGenerateValue.equalsIgnoreCase("File Upload5")) { // String
	 * filePath=formBean.getFile_Path5(); //
	 * reGenerateValue=getGeneratedStringValue(filePath); // } //
	 * if(reGenerateValue.equalsIgnoreCase("File Upload6")) { // String
	 * filePath=formBean.getFile_Path6(); //
	 * reGenerateValue=getGeneratedStringValue(filePath); // } //
	 * if(reGenerateValue.equalsIgnoreCase("File Upload7")) { // String
	 * filePath=formBean.getFile_Path7(); //
	 * reGenerateValue=getGeneratedStringValue(filePath); // } //
	 * if(reGenerateValue.equalsIgnoreCase("File Upload8")) { // String
	 * filePath=formBean.getFile_Path8(); //
	 * reGenerateValue=getGeneratedStringValue(filePath); // } //
	 * if(reGenerateValue.equalsIgnoreCase("File Upload9")) { // String
	 * filePath=formBean.getFile_Path9(); //
	 * reGenerateValue=getGeneratedStringValue(filePath); // } //
	 * if(reGenerateValue.equalsIgnoreCase("File Upload10")) { // String
	 * filePath=formBean.getFile_Path10(); //
	 * reGenerateValue=getGeneratedStringValue(filePath); // } // }
	 * 
	 * // for File Upload process 15 June 2019 by Praveen // End code if
	 * (fieldValue.equalsIgnoreCase("AMOUNT") ||
	 * fieldValue.equalsIgnoreCase("Total Amount") || fieldValue == "Total Amount"
	 * || fieldValue == "AMOUNT" ||
	 * fieldValue.equalsIgnoreCase("Total_Payable_Amount") ||
	 * fieldValue.equalsIgnoreCase("TOTAL_PAYABLE_AMOUNT")) {
	 * if(fieldValue=="Total Amount" || fieldValue=="AMOUNT"){
	 * log.debug("It is in for Final Amount is for payment"); amount =
	 * Double.parseDouble(reGenerateValue); }
	 * log.debug("Final Amount is for payment :::: " + amount.toString());
	 * formViewData.setLabel(formFieldValue[0]);
	 * formViewData.setValue(reGenerateValue); try {
	 * formViewData.setOrder(Integer.valueOf(Integer.parseInt(valueAndOrder[1].trim(
	 * )))); } catch (ArrayIndexOutOfBoundsException e) {
	 * formViewData.setOrder(Integer.valueOf(i)); }
	 * 
	 * formViewList.add(formViewData); } ++i; }
	 * 
	 * log.debug("Final Amount is for payment :::: " + amount.toString());
	 * ses.setAttribute("amountField", amount); Collections.sort(formViewList);
	 * return formViewList; }
	 * 
	 * ------------------------------------------------------ private
	 * ArrayList<SampleFormView> processFormForView(Map<Integer, String>
	 * formDataMap, HttpSession ses, SampleFormBean localFormBean,int flag) throws
	 * Exception { ArrayList<SampleFormView> formViewList = new
	 * ArrayList<SampleFormView>(); Double amount = 0.0;
	 * log.info("processing form"); ArrayList<Integer> keySet = new
	 * ArrayList<Integer>(formDataMap.keySet());
	 * 
	 * if (null != localFormBean) { log.info("flag log is ::::::::::: " + flag); }
	 * 
	 * int i = 0; log.info("key set is :: " + keySet.toString()); while (i <
	 * keySet.size()) { String[] formFieldValue =
	 * formDataMap.get(keySet.get(i)).split("=");
	 * 
	 * String fieldKey = keySet.get(i).toString(); String fieldValue =
	 * formFieldValue[0].toString(); log.info("fieldKey in loop is ::: " +
	 * fieldKey); log.info("formFieldValue[0].toString() in loop is ::: " +
	 * fieldValue + "," + "formFieldValue[1].toString()" +
	 * formFieldValue[1].toString()); if (formFieldValue.length != 2) {
	 * log.info("Form Field Value corrupt or Unreadable"); } else { SampleFormView
	 * formViewData = new SampleFormView(); String[] valueAndOrder =
	 * formFieldValue[1].split("\\$"); log.info(("value is " + formFieldValue[1] +
	 * "and next array is " + valueAndOrder[0]));
	 * 
	 * String reGenerateValue = valueAndOrder[0].toString(); //
	 * if(null!=localFormBean && (flag==2)) { //
	 * if(reGenerateValue.equalsIgnoreCase("File Upload1") &&
	 * null!=localFormBean.getFile_Path1()) { // String
	 * filePath=localFormBean.getFile_Path1(); //
	 * reGenerateValue=getGeneratedStringValue(filePath); // } //
	 * if(reGenerateValue.equalsIgnoreCase("File Upload2") &&
	 * null!=localFormBean.getFile_Path2()) { // String
	 * filePath=localFormBean.getFile_Path2(); //
	 * reGenerateValue=getGeneratedStringValue(filePath); // } //
	 * if(reGenerateValue.equalsIgnoreCase("File Upload3") &&
	 * null!=localFormBean.getFile_Path3()) { // String
	 * filePath=localFormBean.getFile_Path3(); //
	 * reGenerateValue=getGeneratedStringValue(filePath); // } //
	 * if(reGenerateValue.equalsIgnoreCase("File Upload4") &&
	 * null!=localFormBean.getFile_Path4()) { // String
	 * filePath=localFormBean.getFile_Path4(); //
	 * reGenerateValue=getGeneratedStringValue(filePath); // } //
	 * if(reGenerateValue.equalsIgnoreCase("File Upload5") &&
	 * null!=localFormBean.getFile_Path5()) { // String
	 * filePath=localFormBean.getFile_Path5(); //
	 * reGenerateValue=getGeneratedStringValue(filePath); // } //
	 * if(reGenerateValue.equalsIgnoreCase("File Upload6") &&
	 * null!=localFormBean.getFile_Path6()) { // String
	 * filePath=localFormBean.getFile_Path6(); //
	 * reGenerateValue=getGeneratedStringValue(filePath); // } //
	 * if(reGenerateValue.equalsIgnoreCase("File Upload7") &&
	 * null!=localFormBean.getFile_Path7()) { // String
	 * filePath=localFormBean.getFile_Path7(); //
	 * reGenerateValue=getGeneratedStringValue(filePath); // } //
	 * if(reGenerateValue.equalsIgnoreCase("File Upload8") &&
	 * null!=localFormBean.getFile_Path8()) { // String
	 * filePath=localFormBean.getFile_Path8(); //
	 * reGenerateValue=getGeneratedStringValue(filePath); // } //
	 * if(reGenerateValue.equalsIgnoreCase("File Upload9") &&
	 * null!=localFormBean.getFile_Path9()) { // String
	 * filePath=localFormBean.getFile_Path9(); //
	 * reGenerateValue=getGeneratedStringValue(filePath); // } //
	 * if(reGenerateValue.equalsIgnoreCase("File Upload10") &&
	 * null!=localFormBean.getFile_Path10()) { // String
	 * filePath=localFormBean.getFile_Path10(); //
	 * reGenerateValue=getGeneratedStringValue(filePath); // } // } if
	 * (fieldValue.equalsIgnoreCase("AMOUNT") ||
	 * fieldValue.equalsIgnoreCase("Total Amount") || fieldValue == "Total Amount"
	 * || fieldValue == "AMOUNT" ||
	 * fieldValue.equalsIgnoreCase("Total_Payable_Amount") ||
	 * fieldValue.equalsIgnoreCase("TOTAL_PAYABLE_AMOUNT")) {
	 * //log.info("It is in for Final Amount is for payment reGenerateValue :::: "
	 * +reGenerateValue); amount = Double.parseDouble(reGenerateValue); }
	 * log.info("finally reGenerateValue is :::: "+reGenerateValue);
	 * log.debug("Final Amount is for payment :::: " + amount.toString());
	 * formViewData.setLabel(formFieldValue[0]);
	 * formViewData.setValue(reGenerateValue); try {
	 * formViewData.setOrder(Integer.valueOf(Integer.parseInt(valueAndOrder[1].trim(
	 * )))); } catch (ArrayIndexOutOfBoundsException e) {
	 * formViewData.setOrder(Integer.valueOf(i)); }
	 * 
	 * formViewList.add(formViewData); } ++i; }
	 * 
	 * log.info("Final Amount is for payment :::: " + amount.toString());
	 * ses.setAttribute("amountField", amount); // ses.setAttribute("downloadList",
	 * downloadList); Collections.sort(formViewList); return formViewList; }
	 * 
	 * public String getGeneratedStringValue(String filePath) { String
	 * reGenerateValue="";
	 * reGenerateValue=filePath.substring(filePath.lastIndexOf("\\")+1,filePath.
	 * length()); int i=reGenerateValue.lastIndexOf("_"); int
	 * j=reGenerateValue.lastIndexOf("."); String fname=reGenerateValue.substring(0,
	 * i); String ext=reGenerateValue.substring(j+1, reGenerateValue.length());
	 * reGenerateValue=fname+"."+ext;
	 * log.info("FFFFFFFFFFFFFFFFFF1 valueName :: "+reGenerateValue); return
	 * reGenerateValue; }
	 * -------------------------------------------------------------
	 * 
	 * 
	 * private ArrayList<SampleFormView> processFormView(Map<Integer, String>
	 * formDataMap, HttpSession ses, Integer formId) throws Exception {
	 * ArrayList<SampleFormView> formViewList = new ArrayList<SampleFormView>();
	 * Double amount = 0.0; log.info("processing form"); ArrayList<Integer> keySet =
	 * new ArrayList<Integer>(formDataMap.keySet()); SampleFormBean formBean =
	 * (SampleFormBean) ses.getAttribute("form");
	 * 
	 * if (null != formId) { log.info("Now samplle form id is ::::::::::: " +
	 * formId); formBean=sampleFormService.getFormData(formId); }
	 * 
	 * int i = 0; log.info("key set is :: " + keySet.toString()); while (i <
	 * keySet.size()) { String[] formFieldValue =
	 * formDataMap.get(keySet.get(i)).split("=");
	 * 
	 * String fieldKey = keySet.get(i).toString(); String fieldValue =
	 * formFieldValue[0].toString(); log.info("fieldKey in loop is ::: " +
	 * fieldKey); log.info("formFieldValue[0].toString() in loop is ::: " +
	 * fieldValue + "," + "formFieldValue[1].toString()" +
	 * formFieldValue[1].toString()); if (formFieldValue.length != 2) {
	 * log.info("Form Field Value corrupt or Unreadable"); } else { SampleFormView
	 * formViewData = new SampleFormView(); String[] valueAndOrder =
	 * formFieldValue[1].split("\\$"); log.info(("value is " + formFieldValue[1] +
	 * "and next array is " + valueAndOrder[0]));
	 * 
	 * String reGenerateValue = valueAndOrder[0].toString(); // if(null!=formBean) {
	 * // if(reGenerateValue.equalsIgnoreCase("File Upload1") &&
	 * null!=formBean.getFile_Path1()) { //
	 * //reGenerateValue=formBean.getFile_Path1().substring(formBean.getFile_Path1()
	 * .lastIndexOf("/")+1); // reGenerateValue=formBean.getFile_Path1(); // } //
	 * if(reGenerateValue.equalsIgnoreCase("File Upload2") &&
	 * null!=formBean.getFile_Path2()) { //
	 * reGenerateValue=formBean.getFile_Path2(); // } //
	 * if(reGenerateValue.equalsIgnoreCase("File Upload3") &&
	 * null!=formBean.getFile_Path3()) { //
	 * reGenerateValue=formBean.getFile_Path3(); // } //
	 * if(reGenerateValue.equalsIgnoreCase("File Upload4") &&
	 * null!=formBean.getFile_Path4()) { //
	 * reGenerateValue=formBean.getFile_Path4(); // } //
	 * if(reGenerateValue.equalsIgnoreCase("File Upload5") &&
	 * null!=formBean.getFile_Path5()) { //
	 * reGenerateValue=formBean.getFile_Path5(); // } //
	 * if(reGenerateValue.equalsIgnoreCase("File Upload6") &&
	 * null!=formBean.getFile_Path6()) { //
	 * reGenerateValue=formBean.getFile_Path6(); // } //
	 * if(reGenerateValue.equalsIgnoreCase("File Upload7") &&
	 * null!=formBean.getFile_Path7()) { //
	 * reGenerateValue=formBean.getFile_Path7(); // } //
	 * if(reGenerateValue.equalsIgnoreCase("File Upload8") &&
	 * null!=formBean.getFile_Path8()) { //
	 * reGenerateValue=formBean.getFile_Path8(); // } //
	 * if(reGenerateValue.equalsIgnoreCase("File Upload9") &&
	 * null!=formBean.getFile_Path9()) { //
	 * reGenerateValue=formBean.getFile_Path9(); // } //
	 * if(reGenerateValue.equalsIgnoreCase("File Upload10") &&
	 * null!=formBean.getFile_Path10()) { //
	 * reGenerateValue=formBean.getFile_Path10(); // } // } if
	 * (fieldValue.equalsIgnoreCase("AMOUNT") ||
	 * fieldValue.equalsIgnoreCase("Total Amount") || fieldValue == "Total Amount"
	 * || fieldValue == "AMOUNT" ||
	 * fieldValue.equalsIgnoreCase("Total_Payable_Amount") ||
	 * fieldValue.equalsIgnoreCase("TOTAL_PAYABLE_AMOUNT")) {
	 * log.info("It is in for Final Amount is for payment reGenerateValue :::: "
	 * +reGenerateValue); amount = Double.parseDouble(reGenerateValue); }
	 * 
	 * log.debug("Final Amount is for payment :::: " + amount.toString());
	 * formViewData.setLabel(formFieldValue[0]);
	 * formViewData.setValue(reGenerateValue); try {
	 * formViewData.setOrder(Integer.valueOf(Integer.parseInt(valueAndOrder[1].trim(
	 * )))); } catch (ArrayIndexOutOfBoundsException e) {
	 * formViewData.setOrder(Integer.valueOf(i)); }
	 * 
	 * formViewList.add(formViewData); } ++i; }
	 * 
	 * log.info("Final Amount is for payment :::: " + amount.toString());
	 * ses.setAttribute("amountField", amount); // ses.setAttribute("downloadList",
	 * downloadList); Collections.sort(formViewList); return formViewList; }
	 */
	
	
	// Old process
		/*
		 * @RequestMapping(value = "/challanTxnStatusFromChallanSystem", method = {
		 * RequestMethod.POST, RequestMethod.GET }) public @ResponseBody String
		 * challanTxnStatusFromChallanSystem(@RequestParam String challanNumber,
		 * 
		 * @RequestParam String spTxnId, @RequestParam String clientTxnId, @RequestParam
		 * String transStatus,
		 * 
		 * @RequestParam String transDate, @RequestParam String
		 * totalAmount, @RequestParam String transPayMode) throws ParseException {
		 * log.info("received request "); SampleTransBean transBean = new
		 * SampleTransBean(); Integer formId = null; String resCode=""; Session session
		 * = factory.openSession(); log.
		 * info("open challanTxnStatusFromChallanSystem() method with all parameters sent by Challan system"
		 * ); try { if (spTxnId == null || clientTxnId == null || transStatus == null ||
		 * transDate == null || totalAmount == null || spTxnId.isEmpty() ||
		 * clientTxnId.isEmpty() || transStatus.isEmpty() || transDate.isEmpty() ||
		 * totalAmount.isEmpty()) {
		 * 
		 * log.
		 * info("Data have null or empty value please provide some data as per requirement"
		 * );
		 * 
		 * return HttpStatus.NOT_ACCEPTABLE.toString();
		 * 
		 * } else { log.info("clientTxnID is {" + clientTxnId + "}, spTxnId is {" +
		 * spTxnId + "}, challanNumber is {" + challanNumber +
		 * "}, challan Payment Date is {" + transDate + "}, challanStatus is {" +
		 * transStatus + "}, total paid amount is {" + totalAmount + "}");
		 * 
		 * if(transStatus.equalsIgnoreCase(ApplicationStatus.success.toString())) {
		 * resCode="0000"; }else
		 * if(transStatus.equalsIgnoreCase(ApplicationStatus.failure.toString())) {
		 * resCode="0300"; }else
		 * if(transStatus.equalsIgnoreCase(ApplicationStatus.cancelled.toString())) {
		 * resCode="0400"; }else { resCode="0100"; }
		 * 
		 * DateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss"); Date
		 * dateOfTransaction = sdf.parse(transDate);
		 * 
		 * try { transBean = sampleTransService.getTransactions(clientTxnId);
		 * 
		 * // transBean =
		 * sampleTransService.fetchTransactionDetail(clientTxnId,spTxnId,challanNumber,
		 * transDate, // transStatus,totalAmount,resCode,transPayMode);
		 * 
		 * } catch (Exception e1) { e1.printStackTrace(); }
		 * 
		 * if (null != transBean) {
		 * log.info("sampleTransBean is found and comming id : " + transBean.getId() +
		 * " and qf id is : " + transBean.getTransId()); formId = transBean.getFormId();
		 * 
		 * if ((null!=transBean.getSpTransId() || !transBean.getSpTransId().isEmpty())
		 * && (transBean.getSpTransId().equals(spTxnId) || transBean.getSpTransId() ==
		 * spTxnId)) {
		 * 
		 * transBean.setSpTransId(spTxnId);
		 * transBean.setTransAmount(Double.parseDouble(totalAmount));
		 * transBean.setTransDate(dateOfTransaction);
		 * transBean.setChallanNo(challanNumber); transBean.setTransStatus(transStatus);
		 * transBean.setSpRespCode(resCode);
		 * 
		 * if (!transPayMode.isEmpty() || !transPayMode.equals(null) || null !=
		 * transPayMode) { transBean.setTransPaymode(transPayMode); } else {
		 * transBean.setTransPaymode("Challan"); }
		 * 
		 * try { transBean = sampleTransService.updateChalanTransaction(transBean); }
		 * catch (Exception e) { e.printStackTrace(); }
		 * 
		 * try { DateFormat df = new SimpleDateFormat("yyyy-MM-dd  HH:mm:ss"); String
		 * currentDate = df.format(new Date(System.currentTimeMillis())); String payMode
		 * = "Challan"; if (!transPayMode.isEmpty() || !transPayMode.equals(null) ||
		 * null != transPayMode) { payMode = transPayMode; } String challnNo =
		 * transBean.getChallanNo();
		 * 
		 * if (challnNo == null || "".equals(challnNo)) { challnNo = "N/A"; }
		 * 
		 * log.info("Going to udate update zz_client_user_data_" + formId +
		 * ", table for qcId {" + clientTxnId + "}"); Transaction tx =
		 * session.beginTransaction();
		 * 
		 * String tableName = "zz_client_user_data_" + formId;
		 * 
		 * session.createSQLQuery("update " + tableName + " set transStatus='" +
		 * transBean.getTransStatus() + "',transPaymode='" + payMode + "',transDate='" +
		 * currentDate + "',transAmount='" + transBean.getTransAmount() +
		 * "',challanNo='" + challnNo + "',spTransId='" + spTxnId + "',pgTransId='" +
		 * spTxnId + "' where  transId='" + clientTxnId + "'").executeUpdate();
		 * tx.commit(); return HttpStatus.OK.toString(); } catch (Exception e) { log.
		 * info("Exception Occoured while updating Record Not Updated into zz_client_user_data_"
		 * + formId + " while returning from SabPaisa");
		 * 
		 * e.printStackTrace(); return HttpStatus.BAD_REQUEST.toString(); } }else
		 * if(null==transBean.getSpTransId() || transBean.getSpTransId().isEmpty()){
		 * 
		 * transBean.setSpTransId(spTxnId);
		 * transBean.setTransAmount(Double.parseDouble(totalAmount));
		 * transBean.setTransDate(dateOfTransaction);
		 * transBean.setChallanNo(challanNumber); transBean.setTransStatus(transStatus);
		 * transBean.setSpRespCode(resCode);
		 * 
		 * if (!transPayMode.isEmpty() || !transPayMode.equals(null) || null !=
		 * transPayMode) { transBean.setTransPaymode(transPayMode); } else {
		 * transBean.setTransPaymode("Challan"); }
		 * 
		 * try { transBean = sampleTransService.updateChalanTransaction(transBean); }
		 * catch (Exception e) { e.printStackTrace(); }
		 * 
		 * try { DateFormat df = new SimpleDateFormat("yyyy-MM-dd  HH:mm:ss"); String
		 * currentDate = df.format(new Date(System.currentTimeMillis())); String payMode
		 * = "Challan"; if (!transPayMode.isEmpty() || !transPayMode.equals(null) ||
		 * null != transPayMode) { payMode = transPayMode; } String challnNo =
		 * transBean.getChallanNo();
		 * 
		 * if (challnNo == null || "".equals(challnNo) || challnNo.isEmpty()) { challnNo
		 * = "N/A"; }
		 * 
		 * log.info("Going to udate update zz_client_user_data_" + formId +
		 * ", table for qcId {" + clientTxnId + "}"); Transaction tx =
		 * session.beginTransaction();
		 * 
		 * String tableName = "zz_client_user_data_" + formId;
		 * 
		 * session.createSQLQuery("update " + tableName + " set transStatus='" +
		 * transBean.getTransStatus() + "',transPaymode='" + payMode + "',transDate='" +
		 * currentDate + "',transAmount='" + transBean.getTransAmount() +
		 * "',challanNo='" + challnNo + "',spTransId='" + spTxnId + "',pgTransId='" +
		 * spTxnId + "' where  transId='" + clientTxnId + "'").executeUpdate();
		 * tx.commit(); return HttpStatus.OK.toString(); } catch (Exception e) { log.
		 * info("Exception Occoured while updating Record Not Updated into zz_client_user_data_"
		 * + formId + " while returning from SabPaisa"); e.printStackTrace(); return
		 * HttpStatus.BAD_REQUEST.toString(); } }else {
		 * log.info("sampleTransBean is not find in DB for the given QFID : " +
		 * clientTxnId); return HttpStatus.NO_CONTENT.toString(); } } else {
		 * log.info("sampleTransBean is not find in DB for the given QFID : " +
		 * clientTxnId); return HttpStatus.NO_CONTENT.toString(); } } } catch
		 * (NumberFormatException e) { e.printStackTrace(); return
		 * HttpStatus.UNPROCESSABLE_ENTITY.toString(); } }
		 */
	public static void main(String[] args) {
		TempToDeleteController ttd = new TempToDeleteController();
		// ttd.addFieldForSuggessionProcess();
		ttd.fetchMap();
	}

}
