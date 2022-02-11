package com.sabpaisa.qforms.util;

import java.time.LocalDate;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Properties;
import java.util.Set;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.sabpaisa.qforms.beans.BeanFeeDetails;
import com.sabpaisa.qforms.beans.BeanFormDetails;
import com.sabpaisa.qforms.beans.BeanLateFee;
import com.sabpaisa.qforms.config.AppPropertiesConfig;
import com.sabpaisa.qforms.controller.FormBuilderController;

public class LateFeeCalculator {

	private static Logger log = LogManager.getLogger(FormBuilderController.class.getName());
	
	AppPropertiesConfig appProperties = new AppPropertiesConfig();
	Properties properties = appProperties.getPropValues();
	
	Integer Monthly_Periodic_sd = Integer.parseInt(properties.getProperty("Monthly-Periodic-sd"));
	Integer Monthly_Periodic_ed = Integer.parseInt(properties.getProperty("Monthly-Periodic-ed"));
	Integer Monthly_Periodic_flsd = Integer.parseInt(properties.getProperty("Monthly-Periodic-flsd"));
	Integer Monthly_Periodic_fled = Integer.parseInt(properties.getProperty("Monthly-Periodic-fled"));
	Integer Monthly_Periodic_fAmount=Integer.parseInt(properties.getProperty("Monthly-Periodic-fAmount"));
	Integer Monthly_Periodic_slsd = Integer.parseInt(properties.getProperty("Monthly-Periodic-slsd"));
	Integer Monthly_Periodic_sled = Integer.parseInt(properties.getProperty("Monthly-Periodic-sled"));
	Integer Monthly_Periodic_sAmount=Integer.parseInt(properties.getProperty("Monthly-Periodic-sAmount"));
	Integer Monthly_Periodic_tlsd = Integer.parseInt(properties.getProperty("Monthly-Periodic-tlsd"));
	Integer Monthly_Periodic_tled = Integer.parseInt(properties.getProperty("Monthly-Periodic-tled"));	
	Integer Monthly_Periodic_tAmount=Integer.parseInt(properties.getProperty("Monthly-Periodic-tAmount"));
	
	Integer Monthly_Periodic_Daily_sd = Integer.parseInt(properties.getProperty("Monthly-Periodic-Daily-sd"));
	Integer Monthly_Periodic_Daily_ed = Integer.parseInt(properties.getProperty("Monthly-Periodic-Daily-ed"));
	Integer Monthly_Periodic_Daily_flsd = Integer.parseInt(properties.getProperty("Monthly-Periodic-Daily-flsd"));
	Integer Monthly_Periodic_Daily_fled = Integer.parseInt(properties.getProperty("Monthly-Periodic-Daily-fled"));
	Integer Monthly_Periodic_Daily_slsd = Integer.parseInt(properties.getProperty("Monthly-Periodic-Daily-slsd"));
	Integer Monthly_Periodic_Daily_sled = Integer.parseInt(properties.getProperty("Monthly-Periodic-Daily-sled"));
	
	
	public BeanFeeDetails calculateLateFeeAsBeanFeeDetails(BeanFormDetails formdetails) {

		BeanFeeDetails feeDetailForFormBuilder = new BeanFeeDetails();
		Set<BeanLateFee> lateFeeSet = new HashSet<BeanLateFee>();

		LocalDate today1 = LocalDate.now();
		int currentYear = today1.getYear();
		int currentMonth = today1.getMonthValue();
		int currentDay = today1.getDayOfMonth();
		log.info("Current Date :" + today1 + ": year :" + currentYear + ": month :" + currentMonth + ": day :"
				+ currentDay);

		Date lateFeeStartDate = new Date();
		Date lateFeeEndDate = new Date();
		log.info("lateFeeStartDate {" + lateFeeStartDate + "}, lateFeeEndDate {" + lateFeeEndDate + "}");

		Integer numberOfDays = 0;
		Double baseamt = 0.0;

		feeDetailForFormBuilder = formdetails.getFormFee();
		baseamt = feeDetailForFormBuilder.getFeeBaseAmount();
		lateFeeSet = feeDetailForFormBuilder.getLatefeeset();
		log.info("Set of late fee configured with this form =======> " + lateFeeSet.toString());
		if (formdetails.getValidityflag() == 1) {
			Iterator<BeanLateFee> itrLateFee = lateFeeSet.iterator();
			while (itrLateFee.hasNext()) {
				BeanLateFee lateFee = itrLateFee.next();
				lateFeeStartDate = lateFee.getLatefeeStartdate();
				lateFeeEndDate = lateFee.getLatefeeEnddate();
				log.info("After getting info from DataLateFee table ----> lateFeeStartDate {" + lateFeeStartDate
						+ "}, lateFeeEndDate {" + lateFeeEndDate + "}");

				Date today = new Date();
				Date formendDate = formdetails.getFormEndDate();
				// Date lateDate = formdetails.getFormLateEndDate();

				if (null != lateFeeStartDate && null != lateFeeEndDate) {
					if ((lateFeeStartDate.equals(today) || lateFeeStartDate.before(today))
							&& (lateFeeEndDate.after(today) || lateFeeEndDate.equals(today))) {
						log.info("All dsates are matched properly");

						if (lateFee.getLatefeeType().equalsIgnoreCase(ApplicationStatus.Fixed.toString())) {
							log.info("All dsates are matched properly for Fixed");
							feeDetailForFormBuilder
									.setFeeBaseAmount(Double.valueOf(baseamt + lateFee.getLatefeeAmount()));
						}
						if (lateFee.getLatefeeType().equalsIgnoreCase(ApplicationStatus.Periodic.toString())) {
							log.info("All dsates are matched properly for Periodic");
							feeDetailForFormBuilder
									.setFeeBaseAmount(Double.valueOf(baseamt + lateFee.getLatefeeAmount()));
						}
						
						if (lateFee.getLatefeeType().equalsIgnoreCase(ApplicationStatus.Daily_Update.toString())) {
							numberOfDays = (int) (today.getTime() - lateFeeStartDate.getTime());
							float daysBetween = (numberOfDays / (1000 * 60 * 60 * 24)) + 1;
							log.info("number of days are : - > " + daysBetween);
							feeDetailForFormBuilder.setFeeBaseAmount(
									Double.valueOf(baseamt + (lateFee.getLatefeeAmount() * daysBetween)));
							log.info("late fee paid by user is : - > " + feeDetailForFormBuilder.getFeeBaseAmount());
						}
						if (lateFee.getLatefeeType().equalsIgnoreCase(ApplicationStatus.Monthly_Fixed.toString())) {

							Calendar calendar = Calendar.getInstance();
							calendar.setTime(formendDate);

							int year = calendar.get(Calendar.YEAR);
							int month = calendar.get(Calendar.MONTH);
							int day = calendar.get(Calendar.DAY_OF_MONTH);

							log.info("Current Date :" + formendDate + ": year :" + year + ": month :" + month + 1
									+ ": day :" + day);

							if ((currentDay >= Monthly_Periodic_sd && currentDay <= Monthly_Periodic_ed) && currentYear <= year) {
								feeDetailForFormBuilder.setFeeBaseAmount(Double.valueOf(0.0));
							} else {
								feeDetailForFormBuilder
										.setFeeBaseAmount(Double.valueOf(baseamt + lateFee.getLatefeeAmount()));
							}
							log.info("late fee paid by user is : - > " + feeDetailForFormBuilder.getFeeBaseAmount());
						}
						if (lateFee.getLatefeeType().equalsIgnoreCase(ApplicationStatus.Monthly_Daily.toString())) {

							Calendar calendar = Calendar.getInstance();
							calendar.setTime(formendDate);

							int year = calendar.get(Calendar.YEAR);
							int month = calendar.get(Calendar.MONTH);
							int day = calendar.get(Calendar.DAY_OF_MONTH);

							log.info("Current Date :" + formendDate + ": year :" + year + ": month :" + month + 1
									+ ": day :" + day);

							if ((currentDay >= Monthly_Periodic_sd && currentDay <= Monthly_Periodic_ed) && currentYear <= year) {
								feeDetailForFormBuilder.setFeeBaseAmount(Double.valueOf(0.0));
							} else {
								numberOfDays=1; 
								log.info("current day is : "+currentDay);
								for(int i=11;i<=currentDay;i++) {
									numberOfDays++;
								}
								log.info("number of days are (numberOfDays-1) : - > " + (numberOfDays-1));
								feeDetailForFormBuilder.setFeeBaseAmount(
										Double.valueOf(baseamt + (lateFee.getLatefeeAmount() * (numberOfDays-1))));
							}
							log.info("late fee paid by user is : - > " + feeDetailForFormBuilder.getFeeBaseAmount());
						}
						if (lateFee.getLatefeeType().equalsIgnoreCase(ApplicationStatus.Monthly_Periodic.toString())) {

							Calendar calendar = Calendar.getInstance();
							calendar.setTime(formendDate);

							int year = calendar.get(Calendar.YEAR);
							int month = calendar.get(Calendar.MONTH);
							int day = calendar.get(Calendar.DAY_OF_MONTH);

							log.info("Current Date :" + formendDate + ": year :" + year + ": month :" + month + 1
									+ ": day :" + day);

							if ((currentDay >= Monthly_Periodic_sd && currentDay <= Monthly_Periodic_ed) && currentYear <= year) {
								feeDetailForFormBuilder.setFeeBaseAmount(Double.valueOf(0.0));
								log.info("late fee paid by user is : - > " + feeDetailForFormBuilder.getFeeBaseAmount());
							} else if ((currentDay >= Monthly_Periodic_flsd && currentDay <= Monthly_Periodic_fled) && currentYear <= year) {
								
								feeDetailForFormBuilder
								.setFeeBaseAmount(Double.valueOf(baseamt + Monthly_Periodic_fAmount));
								log.info("late fee paid by user is : - > " + feeDetailForFormBuilder.getFeeBaseAmount());
							}else if ((currentDay >= Monthly_Periodic_slsd && currentDay <= Monthly_Periodic_sled) && currentYear <= year) {
								
								feeDetailForFormBuilder
								.setFeeBaseAmount(Double.valueOf(baseamt + Monthly_Periodic_sAmount));
								log.info("late fee paid by user is : - > " + feeDetailForFormBuilder.getFeeBaseAmount());
							}else if ((currentDay >= Monthly_Periodic_tlsd) && currentYear <= year) {
								
								feeDetailForFormBuilder
								.setFeeBaseAmount(Double.valueOf(baseamt + Monthly_Periodic_tAmount));
								log.info("late fee paid by user is : - > " + feeDetailForFormBuilder.getFeeBaseAmount());
							}
							log.info("late fee paid by user is : - > " + feeDetailForFormBuilder.getFeeBaseAmount());
						}
						// if
						// (lateFee.getLatefeeType().equalsIgnoreCase(ApplicationStatus.Monthly_Periodic_Daily.toString()))
						// {
						//
						// Calendar calendar = Calendar.getInstance();
						// calendar.setTime(formendDate);
						//
						// int year = calendar.get(Calendar.YEAR);
						// int month = calendar.get(Calendar.MONTH);
						// int day = calendar.get(Calendar.DAY_OF_MONTH);
						//
						// log.info("Current Date :" + formendDate + ": year :" + year + ": month :" +
						// month + 1
						// + ": day :" + day);
						//
						// if ((currentDay >= Monthly_Periodic_sd && currentDay <= Monthly_Periodic_ed)
						// && currentYear <= year) {
						// feeDetailForFormBuilder.setFeeBaseAmount(Double.valueOf(0.0));
						// } else if ((currentDay >= Monthly_Periodic_flsd && currentDay <=
						// Monthly_Periodic_fled) && currentYear <= year) {
						//
						// feeDetailForFormBuilder
						// .setFeeBaseAmount(Double.valueOf(baseamt + lateFee.getLatefeeAmount()));
						// }else if ((currentDay >= Monthly_Periodic_slsd && currentDay <=
						// Monthly_Periodic_sled) && currentYear <= year) {
						//
						// feeDetailForFormBuilder
						// .setFeeBaseAmount(Double.valueOf(baseamt + lateFee.getLatefeeAmount()));
						// }else if ((currentDay >= Monthly_Periodic_tlsd) && currentYear <= year) {
						//
						// feeDetailForFormBuilder
						// .setFeeBaseAmount(Double.valueOf(baseamt + lateFee.getLatefeeAmount()));
						// }
						// log.info("late fee paid by user is : - > " +
						// feeDetailForFormBuilder.getFeeBaseAmount());
						// }

						// if (lateFee.getLatefeeType().equalsIgnoreCase("Percentage")
						// && !lateFee.getLatefeeAmount().equals(0)) {
						// log.info("All dsates are matched properly for Percentage");
						// feeDetailForFormBuilder.setFeeBaseAmount(
						// Double.valueOf(baseamt + baseamt * (lateFee.getLatefeeAmount() / 100.0)));
						// }

					}
				} else {
					log.info("late fee amount is not configured at this date : " + today.toString());
				}
			}
		} else {
			log.info("formDetails is empty");
		}

		return feeDetailForFormBuilder;
	}
	
	public Double calculateLateFee(BeanFormDetails formdetails) {

		BeanFeeDetails feeDetailForFormBuilder = new BeanFeeDetails();
		Set<BeanLateFee> lateFeeSet = new HashSet<BeanLateFee>();

		LocalDate today1 = LocalDate.now();
		int currentYear = today1.getYear();
		int currentMonth = today1.getMonthValue();
		int currentDay = today1.getDayOfMonth();
		log.info("Current Date :" + today1 + ": year :" + currentYear + ": month :" + currentMonth + ": day :"
				+ currentDay);

		Date lateFeeStartDate = null;
		Date lateFeeEndDate = null;

		Integer numberOfDays = 0;
		Double baseamt = 0.0;

		feeDetailForFormBuilder = formdetails.getFormFee();
		baseamt = feeDetailForFormBuilder.getFeeBaseAmount();
		lateFeeSet = feeDetailForFormBuilder.getLatefeeset();

		if (null != formdetails.getId()) {
			log.info("It is in current Form Id formdetails.getId() : " + formdetails.getId());
			feeDetailForFormBuilder = formdetails.getFormFee();
			log.info("It is in current Form Id feeDetailForFormBuilder.getId() : " + feeDetailForFormBuilder.getId());
			baseamt = feeDetailForFormBuilder.getFeeBaseAmount();
			lateFeeSet = feeDetailForFormBuilder.getLatefeeset();
			log.info("Set of late fee configured with this form =======> " + lateFeeSet.toString());

			Iterator<BeanLateFee> itrLateFee = lateFeeSet.iterator();
			while (itrLateFee.hasNext()) {
				log.info("It is in current Form Id with while loop");
				BeanLateFee lateFee = itrLateFee.next();
				lateFeeStartDate = lateFee.getLatefeeStartdate();
				lateFeeEndDate = lateFee.getLatefeeEnddate();
				log.info("After getting info from DataLateFee table ----> lateFeeStartDate {" + lateFeeStartDate
						+ "}, lateFeeEndDate {" + lateFeeEndDate + "}");

				if (formdetails.getValidityflag() == 1) {
					Date today = new Date();
					Date formendDate = formdetails.getFormEndDate();
					// Date lateDate = formdetails.getFormLateEndDate();

					if (formendDate.before(today) && (lateFeeStartDate.equals(today) || lateFeeStartDate.before(today))
							&& (lateFeeEndDate.after(today) || lateFeeEndDate.equals(today))) {
						log.info("It is in current Form Id for checking the dates.");
						if (lateFee.getLatefeeType().equalsIgnoreCase(ApplicationStatus.Fixed.toString())) {
							log.info("Calculation for Fixed Type late fee");
							baseamt = Double.valueOf(baseamt + lateFee.getLatefeeAmount());
						}
						if (lateFee.getLatefeeType().equalsIgnoreCase(ApplicationStatus.Periodic.toString())) {
							log.info("All dsates are matched properly for Periodic");
							baseamt = Double.valueOf(baseamt + lateFee.getLatefeeAmount());
						}
						if (lateFee.getLatefeeType().equalsIgnoreCase(ApplicationStatus.Daily_Update.toString())
								&& !lateFee.getLatefeeAmount().equals(0)) {
							log.info("Calculation for Daily_Update Type late fee");
							numberOfDays = (int) (today.getTime() - lateFeeStartDate.getTime());
							float daysBetween = (numberOfDays / (1000 * 60 * 60 * 24)) + 1;
							log.info("number of days are : - > " + daysBetween);
							baseamt = Double.valueOf(baseamt + (lateFee.getLatefeeAmount() * daysBetween));
							log.info("late fee paid by user is : - > " + baseamt);
						}
						if (lateFee.getLatefeeType().equalsIgnoreCase(ApplicationStatus.Monthly_Fixed.toString())) {

							Calendar calendar = Calendar.getInstance();
							calendar.setTime(formendDate);

							int year = calendar.get(Calendar.YEAR);
							int month = calendar.get(Calendar.MONTH);
							int day = calendar.get(Calendar.DAY_OF_MONTH);

							log.info("Current Date :" + formendDate + ": year :" + year + ": month :" + month + 1
									+ ": day :" + day);

							if ((currentDay >= Monthly_Periodic_sd && currentDay <= Monthly_Periodic_sd) && currentYear <= year) {
								baseamt=0.0;
							} else {
								baseamt=Double.valueOf(baseamt + lateFee.getLatefeeAmount());
							}
							log.info("late fee paid by user is : - > " + baseamt);
						}
						if (lateFee.getLatefeeType().equalsIgnoreCase(ApplicationStatus.Monthly_Daily.toString())) {

							Calendar calendar = Calendar.getInstance();
							calendar.setTime(formendDate);

							int year = calendar.get(Calendar.YEAR);
							int month = calendar.get(Calendar.MONTH);
							int day = calendar.get(Calendar.DAY_OF_MONTH);

							log.info("Current Date :" + formendDate + ": year :" + year + ": month :" + month + 1
									+ ": day :" + day);

							if ((currentDay >= Monthly_Periodic_sd && currentDay <= Monthly_Periodic_sd) && currentYear <= year) {
								feeDetailForFormBuilder.setFeeBaseAmount(Double.valueOf(0.0));
							} else {
								numberOfDays=1; 
								log.info("current day is : "+currentDay);
								for(int i=11;i<=currentDay;i++) {
									numberOfDays++;
								}
								log.info("number of days are (numberOfDays-1) : - > " + (numberOfDays-1));
								baseamt=Double.valueOf(baseamt + (lateFee.getLatefeeAmount() * (numberOfDays-1)));
							}
							log.info("late fee paid by user is : - > " + baseamt);
						}
						if (lateFee.getLatefeeType().equalsIgnoreCase(ApplicationStatus.Monthly_Periodic.toString())) {

							Calendar calendar = Calendar.getInstance();
							calendar.setTime(formendDate);

							int year = calendar.get(Calendar.YEAR);
							int month = calendar.get(Calendar.MONTH);
							int day = calendar.get(Calendar.DAY_OF_MONTH);

							log.info("Current Date :" + formendDate + ": year :" + year + ": month :" + month + 1
									+ ": day :" + day);

							if ((currentDay >= Monthly_Periodic_sd && currentDay <= Monthly_Periodic_ed)
									&& currentYear <= year) {
								baseamt=0.0;
							} else if ((currentDay >= Monthly_Periodic_flsd && currentDay <= Monthly_Periodic_fled)
									&& currentYear <= year) {

								baseamt=Double.valueOf(baseamt + Monthly_Periodic_fAmount);
							} else if ((currentDay >= Monthly_Periodic_slsd && currentDay <= Monthly_Periodic_sled)
									&& currentYear <= year) {

								baseamt=Double.valueOf(baseamt + Monthly_Periodic_sAmount);
							} else if ((currentDay >= Monthly_Periodic_tlsd) && currentYear <= year) {

								baseamt=Double.valueOf(baseamt + Monthly_Periodic_tAmount);
							}
							log.info("late fee paid by user is : - > " + baseamt);
						}
						// if
						// (lateFee.getLatefeeType().equalsIgnoreCase(ApplicationStatus.Monthly_Periodic_Daily.toString()))
						// {
						//
						// Calendar calendar = Calendar.getInstance();
						// calendar.setTime(formendDate);
						//
						// int year = calendar.get(Calendar.YEAR);
						// int month = calendar.get(Calendar.MONTH);
						// int day = calendar.get(Calendar.DAY_OF_MONTH);
						//
						// log.info("Current Date :" + formendDate + ": year :" + year + ": month :" +
						// month + 1
						// + ": day :" + day);
						//
						// if ((currentDay >= Monthly_Periodic_sd && currentDay <= Monthly_Periodic_ed)
						// && currentYear <= year) {
						// baseamt=0.0;
						// } else if ((currentDay >= Monthly_Periodic_flsd && currentDay <=
						// Monthly_Periodic_fled) && currentYear <= year) {
						//
						// baseamt=Double.valueOf(baseamt + lateFee.getLatefeeAmount());
						// }else if ((currentDay >= Monthly_Periodic_slsd && currentDay <=
						// Monthly_Periodic_sled) && currentYear <= year) {
						//
						// baseamt=Double.valueOf(baseamt + lateFee.getLatefeeAmount());
						// }else if ((currentDay >= Monthly_Periodic_tlsd) && currentYear <= year) {
						//
						// baseamt=Double.valueOf(baseamt + lateFee.getLatefeeAmount());
						// }
						// log.info("late fee paid by user is : - > " +
						// baseamt;
						// }

						// if (lateFee.getLatefeeType().equalsIgnoreCase("Percentage")
						// && !lateFee.getLatefeeAmount().equals(0)) {
						// log.info("All dsates are matched properly for Percentage");
						// baseamt=
						// Double.valueOf(baseamt + baseamt * (lateFee.getLatefeeAmount() / 100.0));
						// }
					}
				}
			}
		} else {
			log.info("formDetails is empty");
		}

		return baseamt;
	}
	
}
