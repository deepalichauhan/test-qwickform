package com.sabpaisa.qforms.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.sabpaisa.qforms.beans.AdmitCardBean;
import com.sabpaisa.qforms.beans.CollegeBean;
import com.sabpaisa.qforms.beans.SampleFormBean;
import com.sabpaisa.qforms.beans.SampleTransBean;
import com.sabpaisa.qforms.services.AdmitCardService;
import com.sabpaisa.qforms.services.FeedbackDetailsService;
import com.sabpaisa.qforms.services.SampleFormService;
import com.sabpaisa.qforms.services.SampleTransService;
import com.sabpaisa.qforms.test.ImageUpload;

@CrossOrigin
@Controller
@RequestMapping
public class AdmitcardActionController {

	@Autowired
	FeedbackDetailsService feedbackDetailsService;
	@Autowired
	AdmitCardService admitCardService;
	@Autowired
	SampleFormService sampleFormService;
	@Autowired
	SampleTransService sampleTransService;

	private static final Logger log = LogManager.getLogger("AdmitcardActionController.class");

	String folder = "/usr/local/tomcat8-feedesk/webapps/QForms/AdmitCard";
	private AdmitCardBean admitBean = new AdmitCardBean();

	private CollegeBean clgBean = new CollegeBean();
	private SampleTransBean beanTransData = new SampleTransBean();

	private SampleFormBean form = new SampleFormBean();

	private List<AdmitCardBean> admitCardlist = new ArrayList<AdmitCardBean>();
	private AdmitCardBean bean = new AdmitCardBean();
	String fileFileName;
	FileInputStream inputStream;
	private File fileUpload;
	private String fileUploadFileName;
	private String contentType;

	@RequestMapping(value = "/fetchAdmitCardLists", method = { RequestMethod.GET, RequestMethod.POST })
	public String fetchAdmitCardsList(ModelMap model, HttpServletRequest request) {
		HttpSession ses = request.getSession();
		List<AdmitCardBean> admitCardlist = new ArrayList<AdmitCardBean>();

		try {
			admitCardlist = admitCardService.getAdmitCardList();
		} catch (Exception e) {
			log.error("admit card list not found ");
			e.printStackTrace();
		}
		model.put("admitCardlist", admitCardlist);
		log.info("Return SIze :::::" + admitCardlist.size());
		return "FL-AdmitCard";
	}

	@RequestMapping(value = "/saveBulkStudentData", method = { RequestMethod.GET, RequestMethod.POST })
	public String admitCardsBulk(Model model, HttpServletRequest request) {
		String type = request.getParameter("addType");

		if ("Bulk".equals(type)) {
			log.info("Add Type = Bulk");
			return "uploadBulkStudentsLIst";
		} else {
			System.out.println("Add Type = Single");
			return "addSingleStudent";
		}
	}

	@RequestMapping(value = "/SaveSingleStudentDetails", method = { RequestMethod.GET, RequestMethod.POST })
	public String saveSingleStudentAD(HttpServletRequest request, @ModelAttribute AdmitCardBean admitBean) {
		String valid ="";
		
		try {
			valid=admitCardService.saveSingleStudentlist(admitBean);
			if (valid.equalsIgnoreCase("true")) {
				request.setAttribute("msgData", "Data is saved successfully.");
			} else {
				request.setAttribute("msgData", "Data is not stored properly, Please reinsert your data and save.");
			}
		} catch (Exception e) {
			log.error("admit card details is not stored");
			e.printStackTrace();
		}
		return "Success";
	}

	@RequestMapping(value = "/SaveBulkStudentRecords", method = { RequestMethod.GET, RequestMethod.POST })
	public String SaveBulkStudentsAD(ModelMap model, HttpServletRequest request, @RequestParam MultipartFile fileUpload)
			throws IOException {

		HttpSession ses = request.getSession();
		String fileUploadFileName = "";
		String clientLogoPath = "";

		if (null != fileUpload) {
			clientLogoPath = getImagePath(fileUpload, "AdmitCard", "FormCreation", "DocumentFile");
			log.info("Client uploaded file path is ::::: " + clientLogoPath.toString());

			Timestamp timestamp = new Timestamp(System.currentTimeMillis());
			timestamp.toString();
			log.info("timestamp:::" + timestamp.getTime() + ">>>" + timestamp);
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
			LocalDate localDate = LocalDate.now();
			System.out.println(dtf.format(localDate));

			fileUploadFileName = fileUpload.getOriginalFilename();

			log.info("fileUploadFileName :::::::::::: " + fileUploadFileName.toString());

			if (fileUploadFileName.endsWith(".xlsx") || fileUploadFileName.endsWith(".csv")
					|| fileUploadFileName.endsWith(".xls")) {

				File dstFile = new File(clientLogoPath);
				// log.info("upload final path is ::" + dstFile);

				try {	
					try {
						String uploadFlag = admitCardService.generateTempTable(dstFile, "", "", "", "", ses);
						// log.info("upload flag is ::" + uploadFlag);

						if (uploadFlag == "tableCreationError") {
							request.setAttribute("msg", "Some Headers Missing ,not able upload Record");
							return "Failure";
						}
						if (uploadFlag == "excelError") {
							request.setAttribute("msg", "One or more cell headers missing values.");
							return "Failure";
						}
						if (uploadFlag == "fail") {
							request.setAttribute("msg", "Please Check Fees Configuration if not properly mapped");
							return "Failure";
						}
						if (uploadFlag == "dbError") {
							request.setAttribute("msg", "Data is not correct in file, please try again.");
							return "Failure";
						}
						request.setAttribute("msg", "Student Record Uploaded Successfully");
						return "Success";
					} catch (NullPointerException e) {
						e.printStackTrace();
						log.error("Not able to upload file issue \n may be issue in configuration");
						request.setAttribute("msg", "Not able to upload file issue \n may be issue in configuration");
						return "Failure";
					}
				} catch (Exception e2) {
					try {
						e2.printStackTrace();
						log.error("Error in file uploading, please try again.");
						request.setAttribute("msg", "Error in file uploading, please try again.");
						return "Failure";
					} catch (Exception e3) {
						e3.printStackTrace();
						log.error("Error in file uploading, please try again.");
						request.setAttribute("msg", "Error in file uploading, please try again.");
						return "Failure";
					}
				}
			}
		}
		String msg = "Please Select Proper File Format";
		log.error("Please Select Proper File Format");
		request.setAttribute("msg", msg);
		return "Failure";
	}

	private String getImagePath(MultipartFile companyLogoPath, String colCode, String formName, String payerName) {
		String logoPath = "";
		String reqLogoPath = "";
		if (companyLogoPath != null && !companyLogoPath.isEmpty()) {
			logoPath = ImageUpload.uploadFileHandler(companyLogoPath, colCode, formName, payerName);
			log.info("Main logopath is of uploaded file :  :  :  :  :  " + logoPath);
			String[] arr = logoPath.split("webapps");
			reqLogoPath = arr[1];
		}
		log.info("Sub reqLogoPath is of uploaded file :  :  :  :  :  " + reqLogoPath);
		return logoPath;
	}

	@RequestMapping(value = "/EditAdmitCardsDetailsById", method = { RequestMethod.GET, RequestMethod.POST })
	public String editAdmitCardsDetails(ModelMap model, HttpServletRequest request, @ModelAttribute AdmitCardBean admitBean) {
		AdmitCardBean editAdmitBean = new AdmitCardBean();
		try {
			editAdmitBean = admitCardService.editAdmitCardDetailsID(request.getParameter("id"));
		} catch (Exception e) {
			log.error("Admit card details is not updated.");
			e.printStackTrace();
		}
		log.info("Return SIze :::::" + admitCardlist.size());
		model.put("editAdmitBean", editAdmitBean);
		return "updateSingleStudent";
	}
	
	@RequestMapping(value = "/UpdateSingleStudentDetails", method = { RequestMethod.GET, RequestMethod.POST })
	public String updateSingleStudentDetails(HttpServletRequest request, @ModelAttribute AdmitCardBean admitBean) {
		log.info("admitbean "+admitBean.toString());
		String valid = "";
		
		try {
			valid = admitCardService.updateSingleStudentlist(admitBean);
			if (valid.equalsIgnoreCase("true")) {
				request.setAttribute("msgData", "Data is updated successfully.");
			} else {
				request.setAttribute("msgData", "Data is not updated properly, Please reinsert or update your data and save.");
			}
		} catch (Exception e) {
			log.error("Data is not updated properly, Please reinsert or update your data and save.");
			e.printStackTrace();
		}
		return "Success";
	}
	
	
	@RequestMapping(value = "/FetchAdmitCard", method = { RequestMethod.GET, RequestMethod.POST })
	public String fetchAdmitCardDetails(Model model, HttpServletRequest request) {
		log.info("FetchAdmitCard ============> FetchAdmitCard");
		request.setAttribute("msg", "Information for the Students appearing in the Written Test for admission to P.G. "
				+ "Course of Studies 2019-2021 under Arts Faculty, please verify with the relevant information in your admit card");
		return "FetchAdmitCard";
	}
	
	
	@RequestMapping(value = "/getAdmitCard", method = { RequestMethod.GET, RequestMethod.POST })
	public String fetchAdmitcard(ModelMap model, HttpServletRequest request, HttpSession ses) {
		log.info("start of getAdmitcard()");
		
		String Clientcode = null;
		String id = request.getParameter("txnId");
		CollegeBean clgBean = new CollegeBean();
		AdmitCardBean admitBean = new AdmitCardBean();
		SampleTransBean beanTransData = new SampleTransBean();
		SampleFormBean form = new SampleFormBean();
		String applicationFormNumber = request.getParameter("applicationNo");
		log.info("Txn id :::::::::: "+id);
		log.info("applicationFormNumber id :::::::::: "+applicationFormNumber);
		
		if (null != id) {
			try {
				admitBean = admitCardService.getAdmitCard(id);
			} catch (Exception e) {
				
				e.printStackTrace();
			}
			//log.info("admit card bean is :::::::: "+admitBean.toString());
			
			if (null == admitBean) {
				request.setAttribute("msg", id + " Transaction Id not Found, Please try later");
				return "FetchAdmitCard";
			}

			beanTransData = sampleTransService.getTransactionsBySabPaisaTxnId(admitBean.getReg_number());
			if (null == beanTransData) {
				request.setAttribute("msg", id + " Transaction Id not Found, Please try later");
				log.info("Transaction Id not Found, Please try later " + id);
				return "FetchAdmitCard";

			}
			try {
				clgBean = admitCardService.getCollegedetails(beanTransData.getCid());
				request.setAttribute("clientCode", clgBean.getCollegeCode());
				form = sampleFormService.getFormData(beanTransData.getTransForm().getFormId());
				//log.info("sample form bean  :::::::: "+form.toString());
				Clientcode = clgBean.getCollegeCode();
			} catch (Exception e) {
				e.printStackTrace();
			}
			ses.setAttribute("formDataForAdmitCard", form);
			model.put("admitBean", admitBean);
			log.info("End of getAdmitcard(), for " + id);
			return "ProvisionalAdmitCard";
		} else if (null != applicationFormNumber) {

			form = admitCardService.getAdmitCardByApplicationNo(applicationFormNumber);
			//log.info("sample form bean  :::::::: "+form.toString());
			
			if (null == form) {
				request.setAttribute("msg", id + " Application Form No not Found, Please try later");
				return "FetchAdmitCard";
			}
			//log.info("form id :::::::: "+form.toString());
			
			beanTransData = sampleTransService.getTransactionDetailsBasedOnTransactionId(form.getFormTransId());
			
			if (null == beanTransData) {
				request.setAttribute("msg", id + " Transaction Id not Found, Please try later");
				log.info("Transaction Id not Found, Please try later " + id);
				return "FetchAdmitCard";
			}

			try {
				admitBean = admitCardService.getAdmitCard(beanTransData.getSpTransId());
				clgBean = admitCardService.getCollegedetails(beanTransData.getCid());
			} catch (Exception e) {
				e.printStackTrace();
			}
			request.setAttribute("clientCode", clgBean.getCollegeCode());
			// request.setAttribute("clientCode", form.getFormInstId());
			ses.setAttribute("formDataForAdmitCard", form);
			model.put("admitBean", admitBean);
			log.info("End of getAdmitcard()");
			return "ProvisionalAdmitCard";
		}

		log.info("End of getAdmitcard()");
		return "FetchAdmitCard";

	}

	/*
	 * Enabled aggressive exception aggregation
	 */

	@RequestMapping(value = "/getNocCertificate", method = { RequestMethod.GET, RequestMethod.POST })
	public String getNocCertificate(Model model, HttpServletRequest request, HttpSession ses) {
		log.info("start of getNocCertificate()");
		String Clientcode = null;
		admitBean=new AdmitCardBean();
		String id = request.getParameter("txnId");
		
		if(null==request.getParameter("txnId")) {
			return "generateNoc";
		}else {
			admitBean = admitCardService.getAdmitCard(id);
			if (null == admitBean) {
				request.setAttribute("msg", id + " Transaction Id not Found");
				return "generateNoc";
			}
			model.addAttribute("admitBean", admitBean);
			log.info("End of getNocCertificate()");
			return "generateNocCertificate";
		}
	}

	

	public AdmitCardBean getAdmitBean() {
		return this.admitBean;
	}

	public void setAdmitBean(AdmitCardBean admitBean) {
		this.admitBean = admitBean;
	}

	public SampleTransBean getBeanTransData() {
		return this.beanTransData;
	}

	public void setBeanTransData(SampleTransBean beanTransData) {
		this.beanTransData = beanTransData;
	}

	public SampleFormBean getForm() {
		return this.form;
	}

	public void setForm(SampleFormBean form) {
		this.form = form;
	}

	public String getFileFileName() {
		return this.fileFileName;
	}

	public void setFileFileName(String fileFileName) {
		this.fileFileName = fileFileName;
	}

	public File getFileUpload() {
		return this.fileUpload;
	}

	public void setFileUpload(File fileUpload) {
		this.fileUpload = fileUpload;
	}

	public String getFileUploadFileName() {
		return this.fileUploadFileName;
	}

	public void setFileUploadFileName(String fileUploadFileName) {
		this.fileUploadFileName = fileUploadFileName;
	}

	public CollegeBean getClgBean() {
		return this.clgBean;
	}

	public void setClgBean(CollegeBean clgBean) {
		this.clgBean = clgBean;
	}

	public List<AdmitCardBean> getAdmitCardlist() {
		return this.admitCardlist;
	}

	public AdmitCardBean getBean() {
		return this.bean;
	}

	public void setBean(AdmitCardBean bean) {
		this.bean = bean;
	}

	public void setAdmitCardlist(List<AdmitCardBean> admitCardlist) {
		this.admitCardlist = admitCardlist;
	}
}
