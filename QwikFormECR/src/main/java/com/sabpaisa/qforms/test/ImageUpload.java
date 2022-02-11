package com.sabpaisa.qforms.test;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.sabpaisa.qforms.beans.BeanFormDetails;
import com.sabpaisa.qforms.beans.CollegeBean;

public class ImageUpload {

	static Logger log = LogManager.getLogger(ImageUpload.class.getName());

	public String showFormWithValidatedValue(HttpSession ses, CollegeBean colBean, String payerProfile, BeanFormDetails beanDataForm) {

		log.info("inside callValidationForm() Method ");
		String returnFlag="";
		
		Integer cid=colBean.getCollegeId();
		Integer bid=colBean.getBankDetailsOTM().getBankId();
		
		if (null != ses.getAttribute("formViewData")) {
			ses.removeAttribute("formViewData");
		}
		if (null != ses.getAttribute("sampleFormBean")) {
			ses.removeAttribute("sampleFormBean");
		}
		/*
		 * if (null != ses.getAttribute("form")) { ses.removeAttribute("form"); }
		 */
		if (null != ses.getAttribute("formDetails")) {
			ses.removeAttribute("formDetails");
		}
		if (null != ses.getAttribute("formInstanceId")) {
			ses.removeAttribute("formInstanceId");
		}
		if (null != ses.getAttribute("feeAmt")) {
			ses.removeAttribute("feeAmt");
		}
		if (null != ses.getAttribute("feeDetails")) {
			ses.removeAttribute("feeDetails");
		}
		if (null != ses.getAttribute("paidAmount")) {
			ses.removeAttribute("paidAmount");
		}

		if (null != colBean) {
			log.debug("colBean " + colBean.toString());
		}

		//beanDataForm = sampleFormService.getFormDetails(Integer.valueOf(Integer.parseInt(dataForm_FormId)));
		String fieldForValidate = null;
		fieldForValidate = beanDataForm.getValidateFieldOfExcel().toString();
		String formStatus = beanDataForm.getStatus();

		if ((fieldForValidate != null && !fieldForValidate.equals("")) && formStatus.equalsIgnoreCase("APPROVED")) {
			returnFlag = "PayerFormForLP";
			log.info("first visit for validation");
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
			log.debug(("genAlphaNu is::" + genAlphaNum));
			ses.setAttribute("genAlphaNum", genAlphaNum);
		} else {
			returnFlag = "errorPage";
		}
		ses.setAttribute("CollegeBean", colBean);
		ses.setAttribute("bid", bid);
		ses.setAttribute("cid", cid);
		ses.setAttribute("payerProfile", payerProfile);
		ses.setAttribute("beanDataForm", beanDataForm);
		return returnFlag;
	}

	public static String uploadFileHandler(MultipartFile file_image, String colCode, String formName, String payerName)

	{
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		timestamp.toString();
		log.info("timestamp:::" + timestamp.getTime() + ">>>" + timestamp);
		String file_image_folderName = "";
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
		LocalDate localDate = LocalDate.now();
		System.out.println(dtf.format(localDate));

		String imagePath = "";
		log.info("in method file name" + file_image.getOriginalFilename() + "name:::" + file_image.getName());
		if (!file_image.isEmpty()) {
			try {
				String fileName = file_image.getOriginalFilename();
				log.info("file name>>>" + fileName);
				String reqFileName = "";
				String reqFileExt = "";
				if (fileName.contains(".")) {
					log.info("in if");
					String[] arr = fileName.split("\\.");
					log.info("arrr" + arr);
					reqFileName = arr[0];

					reqFileName = reqFileName.replaceAll("\\s", "_");
					reqFileName = reqFileName.replaceAll("'", "apos");
					reqFileName = reqFileName.replaceAll("/", "fslsh");
					reqFileName = reqFileName.replaceAll("\\\\", "bslsh");
					reqFileName = reqFileName.replaceAll("\\*", "astrk");
					reqFileName = reqFileName.replaceAll("\\(", "obkt");
					reqFileName = reqFileName.replaceAll("\\)", "cbkt");
					reqFileName = reqFileName.replaceAll("\\-", "hphn");
					// reqFileName = reqFileName.replaceAll("hphn", "\\-");
					reqFileName = reqFileName.replaceAll("\\:", "cln");
					reqFileName = reqFileName.replaceAll("\\.", "dot");

					reqFileExt = arr[1];
					log.info(":::" + arr[0]);
				}
				log.info("reqFileName is for uploading :: " + reqFileName);
				File dir = null;
				byte[] bytes = file_image.getBytes();
				// Creating the directory to store file
				String rootPath = System.getProperty("catalina.home");

				if (reqFileExt.equalsIgnoreCase("pdf") || reqFileExt.equalsIgnoreCase("doc")
						|| reqFileExt.equalsIgnoreCase("docx") || reqFileExt.equalsIgnoreCase("xlsx")
						|| reqFileExt.equalsIgnoreCase("xls") || reqFileExt.equalsIgnoreCase("csv")
						|| reqFileExt.equalsIgnoreCase("txt")) {

					file_image_folderName = "QwikFormClientDocument";

				} else {
					file_image_folderName = "QwikFormClientImages";
				}

				/*
				 * if(file_image_folderName.equalsIgnoreCase("EventImage")){
				 * log.info("in iffff"); dir = new File(rootPath + File.separator +
				 * "/webapps/clientEvent/" + file_image_folderName); }else{ log.info("in else");
				 * if(file_image_folderName.contains("_")){
				 * log.info("in if"+file_image_folderName); dir = new File(rootPath +
				 * File.separator + "/webapps/clientDocs/" + file_image_folderName); }else{
				 */
				log.info("in else" + file_image_folderName);
				// String colCode, String formName, String payerName
				dir = new File(rootPath + File.separator + "/webapps/QwikFormsContent/" + file_image_folderName + "/"
						+ colCode + "/" + payerName + "/" + formName + "/" + localDate);
				/*
				 * } }
				 */
				if (!dir.exists())
					dir.mkdirs();
				// Create the file on server
				File serverFile = new File(dir.getAbsolutePath() + File.separator + reqFileName + "_"
						+ timestamp.getTime() + "." + reqFileExt);
				BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(serverFile));
				stream.write(bytes);
				stream.close();
				log.info("First Server File Location=" + serverFile.getAbsolutePath());
				imagePath = serverFile.getAbsolutePath();
			} catch (Exception e) {
				return "You failed to upload => " + e.getMessage();
			}
		}

		return imagePath;
	}

}
