/**
 * s675 = 0; s678 = 0; s676 = 0; s679 = 0; s667 = 0; s669 = 0; s671 = 0;
 * 
 * ss759 762 765 767 769 770 771
 */

function showHideAmountOptionForVocationalForm(form_value) {
	alert("uploadNOCFileWhenSponsoredIsYes -1 " + form_value);
	alert("uploadNOCFileWhenSponsoredIsYes -1 " + form_value.indexOf("8*Male"));
}

// //++++++++++++-------RECUP COLLEGE MESS FEE VALIDATION WORK Start 17 July
// 2019------------++++++++++/////

function showHideListBoxOptionsofRECUPCollegeMessFee(form_value) {
	alert("showHideListBoxOptionsofRECUPCollegeMessFee -1");
	var val = form_value;
	if ((val.indexOf("2940*Male ") != '-1' || val.indexOf("2940*Female ") != '-1')) {
		var YearVal = document.getElementById("2935").selectedIndex;
		var EntryVal = document.getElementById("2937").selectedIndex;
		alert("showHideListBoxOptionsofRECUPCollegeMessFee -2 >> " + YearVal
				+ ", EntryVal - " + EntryVal + "");
		if (YearVal == 0) {
			alert("showHideListBoxOptionsofRECUPCollegeMessFee -3 >> "
					+ YearVal);
			document.getElementById("2935").selectedIndex = 0;
			document.getElementById("2940").focus();
			return false;
		} else {
			alert("showHideListBoxOptionsofRECUPCollegeMessFee -4 >> "
					+ YearVal + ", EntryVal - " + EntryVal + "");
			if ((YearVal == "1") && (EntryVal == "1" || EntryVal == "2")
					&& (val == "2940*Male ")) {
				alert("showHideListBoxOptionsofRECUPCollegeMessFee -5 >> "
						+ EntryVal);
				document.getElementById("2948").selectedIndex = 0;
				$('#2948 option[value="' + "2948*Girls Hostel-REC " + '"]')
						.hide();
				$('#2948 option[value="' + "2948*Boys Hostel-1- REC " + '"]')
						.show();
				$('#2948 option[value="' + "2948*Boys Hostel-2- REC " + '"]')
						.hide();

			}
			if ((YearVal == "3") && (EntryVal == "1" || EntryVal == "2")
					&& (val == "2940*Male ")) {
				alert("showHideListBoxOptionsofRECUPCollegeMessFee -6 >> "
						+ EntryVal);
				document.getElementById("2948").selectedIndex = 0;
				$('#2948 option[value="' + "2948*Girls Hostel-REC " + '"]')
						.hide();
				$('#2948 option[value="' + "2948*Boys Hostel-1- REC " + '"]')
						.hide();
				$('#2948 option[value="' + "2948*Boys Hostel-2- REC " + '"]')
						.show();

			}
			if ((YearVal == "2") && (EntryVal == "1") && (val == "2940*Male ")) {
				alert("showHideListBoxOptionsofRECUPCollegeMessFee -7 >> "
						+ EntryVal);
				document.getElementById("2948").selectedIndex = 0;
				$('#2948 option[value="' + "2948*Girls Hostel-REC " + '"]')
						.hide();
				$('#2948 option[value="' + "2948*Boys Hostel-1- REC " + '"]')
						.show();
				$('#2948 option[value="' + "2948*Boys Hostel-2- REC " + '"]')
						.hide();

			} else if ((YearVal == "2") && (EntryVal == "2")
					&& (val == "2940*Male ")) {
				alert("showHideListBoxOptionsofRECUPCollegeMessFee -11 >> "
						+ EntryVal);
				document.getElementById("2948").selectedIndex = 0;
				$('#2948 option[value="' + "2948*Girls Hostel-REC " + '"]')
						.hide();
				$('#2948 option[value="' + "2948*Boys Hostel-1- REC " + '"]')
						.hide();
				$('#2948 option[value="' + "2948*Boys Hostel-2- REC " + '"]')
						.show();

			} else if ((YearVal == "4") && (EntryVal == "2")
					&& (val == "2940*Male ")) {
				alert("showHideListBoxOptionsofRECUPCollegeMessFee -22 >> "
						+ EntryVal);
				document.getElementById("2948").selectedIndex = 0;
				$('#2948 option[value="' + "2948*Girls Hostel-REC " + '"]')
						.hide();
				$('#2948 option[value="' + "2948*Boys Hostel-1- REC " + '"]')
						.show();
				$('#2948 option[value="' + "2948*Boys Hostel-2- REC " + '"]')
						.hide();

			} else if ((YearVal == "4") && (EntryVal == "1")
					&& (val == "2940*Male ")) {
				alert("showHideListBoxOptionsofRECUPCollegeMessFee -24 >> "
						+ EntryVal);
				document.getElementById("2948").selectedIndex = 0;
				$('#2948 option[value="' + "2948*Girls Hostel-REC " + '"]')
						.hide();
				$('#2948 option[value="' + "2948*Boys Hostel-1- REC " + '"]')
						.hide();
				$('#2948 option[value="' + "2948*Boys Hostel-2- REC " + '"]')
						.show();

			} else if ((YearVal == "1" || YearVal == "2" || YearVal == "3" || YearVal == "4")
					&& (EntryVal == "1" || EntryVal == "2")
					&& (val == "2940*Female ")) {
				alert("showHideListBoxOptionsofRECUPCollegeMessFee -24 >> "
						+ EntryVal);
				document.getElementById("2948").selectedIndex = 0;
				$('#2948 option[value="' + "2948*Girls Hostel-REC " + '"]')
						.show();
				$('#2948 option[value="' + "2948*Boys Hostel-1- REC " + '"]')
						.hide();
				$('#2948 option[value="' + "2948*Boys Hostel-2- REC " + '"]')
						.hide();
			}
		}
	}
}

// //++++++++++++-------RECUP COLLEGE MESS FEE VALIDATION WORK END 17 July
// 2019------------++++++++++/////

// //++++++++++++-------RECUP COLLEGE FEE FORM VALIDATION WORK Start 17
// July------------++++++++++/////

function showHideListBoxOptionsofRECUPCollegeFeeForm(form_value) {
	// alert("insideshowHideListBoxOptionsofRNCollegeMessFee -1");
	var val = form_value;
	if ((val.indexOf("2963*General") != '-1' || val.indexOf("2963*OBC") != '-1'
			|| val.indexOf("2963*SC") != '-1' || val.indexOf("2963*ST") != '-1')) {
		var ParentsAnnualIncomeVal = document.getElementById("2970").selectedIndex;
		var YearVal = document.getElementById("2954").selectedIndex;
		var ThroughUPSEEVal = document.getElementById("2960").selectedIndex;
		var HostelVal = document.getElementById("2955").selectedIndex;
		var FeeWaiverStudentVal = document.getElementById("2971").selectedIndex;
		// alert("showHideListBoxOptionsofRNCollegeMessFee -2 >>
		// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+", ThroughUPSEEVal -
		// "+ThroughUPSEEVal+", HostelVal - "+HostelVal+", FeeWaiverStudentVal -
		// "+FeeWaiverStudentVal+"");
		if (YearVal == 0) {
			// alert("showHideListBoxOptionsofRNCollegeMessFee -3 >>
			// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
			// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal - "+HostelVal+",
			// FeeWaiverStudentVal - "+FeeWaiverStudentVal+"");
			document.getElementById("2954").selectedIndex = 0;
			document.getElementById("2963").focus();
			return false;
		} else {
			// alert("showHideListBoxOptionsofRNCollegeMessFee -4 >>
			// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
			// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal - "+HostelVal+",
			// FeeWaiverStudentVal - "+FeeWaiverStudentVal+"");
			if ((YearVal == "1")
					&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
					&& (ThroughUPSEEVal == "2")
					&& (HostelVal == "1" || HostelVal == "2")
					&& (FeeWaiverStudentVal == "2")
					&& (val == "2963*General" || val == "2963*OBC")) {
				// alert("showHideListBoxOptionsofRNCollegeMessFee -5 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).hide();
				$('#2968 option').eq(2).hide();
				$('#2968 option').eq(3).hide();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).hide();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).hide();
				$('#2968 option').eq(9).hide();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).hide();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).hide();
				$('#2968 option').eq(15).hide();
				$('#2968 option').eq(16).hide();
				$('#2968 option').eq(17).hide();
				$('#2968 option').eq(18).hide();
				$('#2968 option').eq(19).hide();
				$('#2968 option').eq(20).show();

			}
			if ((YearVal == "1") && (ParentsAnnualIncomeVal == "1")
					&& (ThroughUPSEEVal == "2")
					&& (HostelVal == "1" || HostelVal == "2")
					&& (FeeWaiverStudentVal == "2")
					&& (val == "2963*SC" || val == "2963*ST")) {
				// alert("showHideListBoxOptionsofRNCollegeMessFee -6 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).hide();
				$('#2968 option').eq(2).hide();
				$('#2968 option').eq(3).hide();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).hide();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).hide();
				$('#2968 option').eq(9).hide();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).hide();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).hide();
				$('#2968 option').eq(15).hide();
				$('#2968 option').eq(16).hide();
				$('#2968 option').eq(17).hide();
				$('#2968 option').eq(18).hide();
				$('#2968 option').eq(19).hide();
				$('#2968 option').eq(20).show();

			}
			if ((YearVal == "1") && (ParentsAnnualIncomeVal == "2")
					&& (ThroughUPSEEVal == "2")
					&& (HostelVal == "1" || HostelVal == "2")
					&& (FeeWaiverStudentVal == "2")
					&& (val == "2963*SC" || val == "2963*ST")) {
				// alert("showHideListBoxOptionsofRNCollegeMessFee -7 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).hide();
				$('#2968 option').eq(2).hide();
				$('#2968 option').eq(3).hide();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).hide();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).show();
				$('#2968 option').eq(8).hide();
				$('#2968 option').eq(9).hide();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).hide();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).hide();
				$('#2968 option').eq(15).hide();
				$('#2968 option').eq(16).hide();
				$('#2968 option').eq(17).hide();
				$('#2968 option').eq(18).hide();
				$('#2968 option').eq(19).hide();
				$('#2968 option').eq(20).hide();

			} else if ((YearVal == "2") && (ParentsAnnualIncomeVal == "2")
					&& (ThroughUPSEEVal == "2")
					&& (HostelVal == "1" || HostelVal == "2")
					&& (FeeWaiverStudentVal == "2")
					&& (val == "2963*General" || val == "2963*OBC")) {
				// alert("showHideListBoxOptionsofRNCollegeMessFee -8 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).hide();
				$('#2968 option').eq(2).hide();
				$('#2968 option').eq(3).hide();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).hide();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).hide();
				$('#2968 option').eq(9).hide();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).hide();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).hide();
				$('#2968 option').eq(15).hide();
				$('#2968 option').eq(16).hide();
				$('#2968 option').eq(17).hide();
				$('#2968 option').eq(18).hide();
				$('#2968 option').eq(19).hide();
				$('#2968 option').eq(20).show();

			} else if ((YearVal == "2") && (ParentsAnnualIncomeVal == "1")
					&& (ThroughUPSEEVal == "2")
					&& (HostelVal == "1" || HostelVal == "2")
					&& (FeeWaiverStudentVal == "2")
					&& (val == "2963*SC" || val == "2963*ST")) {
				// alert("showHideListBoxOptionsofRNCollegeMessFee -9 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).hide();
				$('#2968 option').eq(2).hide();
				$('#2968 option').eq(3).hide();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).hide();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).hide();
				$('#2968 option').eq(9).hide();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).hide();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).hide();
				$('#2968 option').eq(15).hide();
				$('#2968 option').eq(16).hide();
				$('#2968 option').eq(17).hide();
				$('#2968 option').eq(18).hide();
				$('#2968 option').eq(19).hide();
				$('#2968 option').eq(20).show();

			} else if ((YearVal == "2") && (ParentsAnnualIncomeVal == "2")
					&& (ThroughUPSEEVal == "2")
					&& (HostelVal == "1" || HostelVal == "2")
					&& (FeeWaiverStudentVal == "2")
					&& (val == "2963*SC" || val == "2963*ST")) {
				// alert("showHideListBoxOptionsofRNCollegeMessFee -10 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).hide();
				$('#2968 option').eq(2).hide();
				$('#2968 option').eq(3).hide();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).hide();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).show();
				$('#2968 option').eq(9).hide();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).hide();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).hide();
				$('#2968 option').eq(15).hide();
				$('#2968 option').eq(16).hide();
				$('#2968 option').eq(17).hide();
				$('#2968 option').eq(18).hide();
				$('#2968 option').eq(19).hide();
				$('#2968 option').eq(20).hide();

			} else if ((YearVal == "3")
					&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
					&& (ThroughUPSEEVal == "2") && (HostelVal == "1")
					&& (FeeWaiverStudentVal == "2")
					&& (val == "2963*General" || val == "2963*OBC")) {
				// alert("showHideListBoxOptionsofRNCollegeMessFee -11 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).hide();
				$('#2968 option').eq(2).hide();
				$('#2968 option').eq(3).hide();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).hide();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).hide();
				$('#2968 option').eq(9).hide();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).hide();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).hide();
				$('#2968 option').eq(15).hide();
				$('#2968 option').eq(16).show();
				$('#2968 option').eq(17).hide();
				$('#2968 option').eq(18).hide();
				$('#2968 option').eq(19).hide();
				$('#2968 option').eq(20).hide();

			} else if ((YearVal == "3")
					&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
					&& (ThroughUPSEEVal == "2") && (HostelVal == "1")
					&& (FeeWaiverStudentVal == "2")
					&& (val == "2963*General" || val == "2963*OBC")) {
				// alert("showHideListBoxOptionsofRNCollegeMessFee -12 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).hide();
				$('#2968 option').eq(2).hide();
				$('#2968 option').eq(3).hide();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).hide();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).hide();
				$('#2968 option').eq(9).hide();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).hide();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).hide();
				$('#2968 option').eq(15).hide();
				$('#2968 option').eq(16).show();
				$('#2968 option').eq(17).hide();
				$('#2968 option').eq(18).hide();
				$('#2968 option').eq(19).hide();
				$('#2968 option').eq(20).hide();

			} else if ((YearVal == "3")
					&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
					&& (ThroughUPSEEVal == "2") && (HostelVal == "2")
					&& (FeeWaiverStudentVal == "2")
					&& (val == "2963*General" || val == "2963*OBC")) {// //++++++++++++-------RECUP
																		// COLLEGE
																		// FEE
																		// FORM
																		// VALIDATION
																		// WORK
																		// Start
																		// 17
																		// July------------++++++++++/////

				function showHideListBoxOptionsofRECUPCollegeFeeForm(form_value) {
					// alert("insideshowHideListBoxOptionsofRNCollegeMessFee
					// -1");
					var val = form_value;
					if ((val.indexOf("2963*General") != '-1'
							|| val.indexOf("2963*OBC") != '-1'
							|| val.indexOf("2963*SC") != '-1' || val
							.indexOf("2963*ST") != '-1')) {
						var ParentsAnnualIncomeVal = document
								.getElementById("2970").selectedIndex;
						var YearVal = document.getElementById("2954").selectedIndex;
						var ThroughUPSEEVal = document.getElementById("2960").selectedIndex;
						var HostelVal = document.getElementById("2955").selectedIndex;
						var FeeWaiverStudentVal = document
								.getElementById("2971").selectedIndex;
						// alert("showHideListBoxOptionsofRNCollegeMessFee -2 >>
						// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
						// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
						// "+HostelVal+", FeeWaiverStudentVal -
						// "+FeeWaiverStudentVal+"");
						if (YearVal == 0) {
							// alert("showHideListBoxOptionsofRNCollegeMessFee
							// -3 >> "+ParentsAnnualIncomeVal +", YearVal -
							// "+YearVal+", ThroughUPSEEVal -
							// "+ThroughUPSEEVal+", HostelVal - "+HostelVal+",
							// FeeWaiverStudentVal - "+FeeWaiverStudentVal+"");
							document.getElementById("2954").selectedIndex = 0;
							document.getElementById("2963").focus();
							return false;
						} else {
							// alert("showHideListBoxOptionsofRNCollegeMessFee
							// -4 >> "+ParentsAnnualIncomeVal +", YearVal -
							// "+YearVal+", ThroughUPSEEVal -
							// "+ThroughUPSEEVal+", HostelVal - "+HostelVal+",
							// FeeWaiverStudentVal - "+FeeWaiverStudentVal+"");
							if ((YearVal == "1")
									&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
									&& (ThroughUPSEEVal == "2")
									&& (HostelVal == "1" || HostelVal == "2")
									&& (FeeWaiverStudentVal == "2")
									&& (val == "2963*General" || val == "2963*OBC")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -5 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).hide();
								$('#2968 option').eq(2).hide();
								$('#2968 option').eq(3).hide();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).hide();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).hide();
								$('#2968 option').eq(9).hide();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).hide();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).hide();
								$('#2968 option').eq(15).hide();
								$('#2968 option').eq(16).hide();
								$('#2968 option').eq(17).hide();
								$('#2968 option').eq(18).hide();
								$('#2968 option').eq(19).hide();
								$('#2968 option').eq(20).show();

							}
							if ((YearVal == "1")
									&& (ParentsAnnualIncomeVal == "1")
									&& (ThroughUPSEEVal == "2")
									&& (HostelVal == "1" || HostelVal == "2")
									&& (FeeWaiverStudentVal == "2")
									&& (val == "2963*SC" || val == "2963*ST")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -6 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).hide();
								$('#2968 option').eq(2).hide();
								$('#2968 option').eq(3).hide();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).hide();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).hide();
								$('#2968 option').eq(9).hide();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).hide();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).hide();
								$('#2968 option').eq(15).hide();
								$('#2968 option').eq(16).hide();
								$('#2968 option').eq(17).hide();
								$('#2968 option').eq(18).hide();
								$('#2968 option').eq(19).hide();
								$('#2968 option').eq(20).show();

							}
							if ((YearVal == "1")
									&& (ParentsAnnualIncomeVal == "2")
									&& (ThroughUPSEEVal == "2")
									&& (HostelVal == "1" || HostelVal == "2")
									&& (FeeWaiverStudentVal == "2")
									&& (val == "2963*SC" || val == "2963*ST")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -7 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).hide();
								$('#2968 option').eq(2).hide();
								$('#2968 option').eq(3).hide();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).hide();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).show();
								$('#2968 option').eq(8).hide();
								$('#2968 option').eq(9).hide();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).hide();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).hide();
								$('#2968 option').eq(15).hide();
								$('#2968 option').eq(16).hide();
								$('#2968 option').eq(17).hide();
								$('#2968 option').eq(18).hide();
								$('#2968 option').eq(19).hide();
								$('#2968 option').eq(20).hide();

							} else if ((YearVal == "2")
									&& (ParentsAnnualIncomeVal == "2")
									&& (ThroughUPSEEVal == "2")
									&& (HostelVal == "1" || HostelVal == "2")
									&& (FeeWaiverStudentVal == "2")
									&& (val == "2963*General" || val == "2963*OBC")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -8 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).hide();
								$('#2968 option').eq(2).hide();
								$('#2968 option').eq(3).hide();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).hide();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).hide();
								$('#2968 option').eq(9).hide();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).hide();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).hide();
								$('#2968 option').eq(15).hide();
								$('#2968 option').eq(16).hide();
								$('#2968 option').eq(17).hide();
								$('#2968 option').eq(18).hide();
								$('#2968 option').eq(19).hide();
								$('#2968 option').eq(20).show();

							} else if ((YearVal == "2")
									&& (ParentsAnnualIncomeVal == "1")
									&& (ThroughUPSEEVal == "2")
									&& (HostelVal == "1" || HostelVal == "2")
									&& (FeeWaiverStudentVal == "2")
									&& (val == "2963*SC" || val == "2963*ST")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -9 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).hide();
								$('#2968 option').eq(2).hide();
								$('#2968 option').eq(3).hide();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).hide();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).hide();
								$('#2968 option').eq(9).hide();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).hide();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).hide();
								$('#2968 option').eq(15).hide();
								$('#2968 option').eq(16).hide();
								$('#2968 option').eq(17).hide();
								$('#2968 option').eq(18).hide();
								$('#2968 option').eq(19).hide();
								$('#2968 option').eq(20).show();

							} else if ((YearVal == "2")
									&& (ParentsAnnualIncomeVal == "2")
									&& (ThroughUPSEEVal == "2")
									&& (HostelVal == "1" || HostelVal == "2")
									&& (FeeWaiverStudentVal == "2")
									&& (val == "2963*SC" || val == "2963*ST")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -10 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).hide();
								$('#2968 option').eq(2).hide();
								$('#2968 option').eq(3).hide();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).hide();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).show();
								$('#2968 option').eq(9).hide();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).hide();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).hide();
								$('#2968 option').eq(15).hide();
								$('#2968 option').eq(16).hide();
								$('#2968 option').eq(17).hide();
								$('#2968 option').eq(18).hide();
								$('#2968 option').eq(19).hide();
								$('#2968 option').eq(20).hide();

							} else if ((YearVal == "3")
									&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
									&& (ThroughUPSEEVal == "2")
									&& (HostelVal == "1")
									&& (FeeWaiverStudentVal == "2")
									&& (val == "2963*General" || val == "2963*OBC")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -11 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).hide();
								$('#2968 option').eq(2).hide();
								$('#2968 option').eq(3).hide();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).hide();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).hide();
								$('#2968 option').eq(9).hide();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).hide();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).hide();
								$('#2968 option').eq(15).hide();
								$('#2968 option').eq(16).show();
								$('#2968 option').eq(17).hide();
								$('#2968 option').eq(18).hide();
								$('#2968 option').eq(19).hide();
								$('#2968 option').eq(20).hide();

							} else if ((YearVal == "3")
									&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
									&& (ThroughUPSEEVal == "2")
									&& (HostelVal == "1")
									&& (FeeWaiverStudentVal == "2")
									&& (val == "2963*General" || val == "2963*OBC")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -12 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).hide();
								$('#2968 option').eq(2).hide();
								$('#2968 option').eq(3).hide();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).hide();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).hide();
								$('#2968 option').eq(9).hide();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).hide();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).hide();
								$('#2968 option').eq(15).hide();
								$('#2968 option').eq(16).show();
								$('#2968 option').eq(17).hide();
								$('#2968 option').eq(18).hide();
								$('#2968 option').eq(19).hide();
								$('#2968 option').eq(20).hide();

							} else if ((YearVal == "3")
									&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
									&& (ThroughUPSEEVal == "2")
									&& (HostelVal == "2")
									&& (FeeWaiverStudentVal == "2")
									&& (val == "2963*General" || val == "2963*OBC")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -13 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).hide();
								$('#2968 option').eq(2).hide();
								$('#2968 option').eq(3).hide();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).hide();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).hide();
								$('#2968 option').eq(9).hide();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).hide();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).hide();
								$('#2968 option').eq(15).hide();
								$('#2968 option').eq(16).hide();
								$('#2968 option').eq(17).hide();
								$('#2968 option').eq(18).show();
								$('#2968 option').eq(19).hide();
								$('#2968 option').eq(20).hide();

							} else if ((YearVal == "3")
									&& (ParentsAnnualIncomeVal == "1")
									&& (ThroughUPSEEVal == "2")
									&& (HostelVal == "1")
									&& (FeeWaiverStudentVal == "2")
									&& (val == "2963*SC" || val == "2963*ST")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -14 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).hide();
								$('#2968 option').eq(2).hide();
								$('#2968 option').eq(3).hide();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).hide();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).hide();
								$('#2968 option').eq(9).hide();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).hide();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).hide();
								$('#2968 option').eq(15).hide();
								$('#2968 option').eq(16).show();
								$('#2968 option').eq(17).hide();
								$('#2968 option').eq(18).hide();
								$('#2968 option').eq(19).hide();
								$('#2968 option').eq(20).hide();

							} else if ((YearVal == "3")
									&& (ParentsAnnualIncomeVal == "1")
									&& (ThroughUPSEEVal == "2")
									&& (HostelVal == "2")
									&& (FeeWaiverStudentVal == "2")
									&& (val == "2963*SC" || val == "2963*ST")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -15 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).hide();
								$('#2968 option').eq(2).hide();
								$('#2968 option').eq(3).hide();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).hide();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).hide();
								$('#2968 option').eq(9).hide();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).hide();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).hide();
								$('#2968 option').eq(15).hide();
								$('#2968 option').eq(16).hide();
								$('#2968 option').eq(17).hide();
								$('#2968 option').eq(18).show();
								$('#2968 option').eq(19).hide();
								$('#2968 option').eq(20).hide();

							} else if ((YearVal == "3")
									&& (ParentsAnnualIncomeVal == "2")
									&& (ThroughUPSEEVal == "2")
									&& (HostelVal == "1")
									&& (FeeWaiverStudentVal == "2")
									&& (val == "2963*SC" || val == "2963*ST")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -16 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).hide();
								$('#2968 option').eq(2).hide();
								$('#2968 option').eq(3).show();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).hide();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).hide();
								$('#2968 option').eq(9).hide();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).hide();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).hide();
								$('#2968 option').eq(15).hide();
								$('#2968 option').eq(16).hide();
								$('#2968 option').eq(17).hide();
								$('#2968 option').eq(18).hide();
								$('#2968 option').eq(19).hide();
								$('#2968 option').eq(20).hide();

							} else if ((YearVal == "3")
									&& (ParentsAnnualIncomeVal == "2")
									&& (ThroughUPSEEVal == "2")
									&& (HostelVal == "2")
									&& (FeeWaiverStudentVal == "2")
									&& (val == "2963*SC" || val == "2963*ST")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -17 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).hide();
								$('#2968 option').eq(2).hide();
								$('#2968 option').eq(3).hide();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).show();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).hide();
								$('#2968 option').eq(9).hide();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).hide();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).hide();
								$('#2968 option').eq(15).hide();
								$('#2968 option').eq(16).hide();
								$('#2968 option').eq(17).hide();
								$('#2968 option').eq(18).hide();
								$('#2968 option').eq(19).hide();
								$('#2968 option').eq(20).hide();

							} else if ((YearVal == "4")
									&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
									&& (ThroughUPSEEVal == "2")
									&& (HostelVal == "1")
									&& (FeeWaiverStudentVal == "2")
									&& (val == "2963*General" || val == "2963*OBC")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -18 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).hide();
								$('#2968 option').eq(2).hide();
								$('#2968 option').eq(3).hide();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).hide();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).hide();
								$('#2968 option').eq(9).hide();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).hide();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).hide();
								$('#2968 option').eq(15).hide();
								$('#2968 option').eq(16).show();
								$('#2968 option').eq(17).hide();
								$('#2968 option').eq(18).hide();
								$('#2968 option').eq(19).hide();
								$('#2968 option').eq(20).hide();

							} else if ((YearVal == "4")
									&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
									&& (ThroughUPSEEVal == "2")
									&& (HostelVal == "2")
									&& (FeeWaiverStudentVal == "2")
									&& (val == "2963*General" || val == "2963*OBC")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -19 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).hide();
								$('#2968 option').eq(2).hide();
								$('#2968 option').eq(3).hide();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).hide();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).hide();
								$('#2968 option').eq(9).hide();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).hide();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).hide();
								$('#2968 option').eq(15).hide();
								$('#2968 option').eq(16).hide();
								$('#2968 option').eq(17).hide();
								$('#2968 option').eq(18).show();
								$('#2968 option').eq(19).hide();
								$('#2968 option').eq(20).hide();

							} else if ((YearVal == "4")
									&& (ParentsAnnualIncomeVal == "1")
									&& (ThroughUPSEEVal == "2")
									&& (HostelVal == "1")
									&& (FeeWaiverStudentVal == "2")
									&& (val == "2963*SC" || val == "2963*ST")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -20 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).hide();
								$('#2968 option').eq(2).hide();
								$('#2968 option').eq(3).hide();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).hide();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).hide();
								$('#2968 option').eq(9).hide();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).hide();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).hide();
								$('#2968 option').eq(15).hide();
								$('#2968 option').eq(16).show();
								$('#2968 option').eq(17).hide();
								$('#2968 option').eq(18).hide();
								$('#2968 option').eq(19).hide();
								$('#2968 option').eq(20).hide();

							} else if ((YearVal == "4")
									&& (ParentsAnnualIncomeVal == "1")
									&& (ThroughUPSEEVal == "2")
									&& (HostelVal == "2")
									&& (FeeWaiverStudentVal == "2")
									&& (val == "2963*SC" || val == "2963*ST")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -21 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).hide();
								$('#2968 option').eq(2).hide();
								$('#2968 option').eq(3).hide();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).hide();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).hide();
								$('#2968 option').eq(9).hide();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).hide();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).hide();
								$('#2968 option').eq(15).hide();
								$('#2968 option').eq(16).hide();
								$('#2968 option').eq(17).hide();
								$('#2968 option').eq(18).show();
								$('#2968 option').eq(19).hide();
								$('#2968 option').eq(20).hide();

							} else if ((YearVal == "4")
									&& (ParentsAnnualIncomeVal == "2")
									&& (ThroughUPSEEVal == "2")
									&& (HostelVal == "1")
									&& (FeeWaiverStudentVal == "2")
									&& (val == "2963*SC" || val == "2963*ST")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -22 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).hide();
								$('#2968 option').eq(2).hide();
								$('#2968 option').eq(3).show();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).hide();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).hide();
								$('#2968 option').eq(9).hide();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).hide();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).hide();
								$('#2968 option').eq(15).hide();
								$('#2968 option').eq(16).hide();
								$('#2968 option').eq(17).hide();
								$('#2968 option').eq(18).hide();
								$('#2968 option').eq(19).hide();
								$('#2968 option').eq(20).hide();

							} else if ((YearVal == "4")
									&& (ParentsAnnualIncomeVal == "2")
									&& (ThroughUPSEEVal == "2")
									&& (HostelVal == "2")
									&& (FeeWaiverStudentVal == "2")
									&& (val == "2963*SC" || val == "2963*ST")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -23 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).hide();
								$('#2968 option').eq(2).hide();
								$('#2968 option').eq(3).hide();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).show();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).hide();
								$('#2968 option').eq(9).hide();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).hide();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).hide();
								$('#2968 option').eq(15).hide();
								$('#2968 option').eq(16).hide();
								$('#2968 option').eq(17).hide();
								$('#2968 option').eq(18).hide();
								$('#2968 option').eq(19).hide();
								$('#2968 option').eq(20).hide();

							} else if ((YearVal == "5")
									&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
									&& (ThroughUPSEEVal == "2")
									&& (HostelVal == "1")
									&& (FeeWaiverStudentVal == "2")
									&& (val == "2963*General" || val == "2963*OBC")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -24 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).hide();
								$('#2968 option').eq(2).hide();
								$('#2968 option').eq(3).hide();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).hide();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).hide();
								$('#2968 option').eq(9).hide();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).hide();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).hide();
								$('#2968 option').eq(15).hide();
								$('#2968 option').eq(16).hide();
								$('#2968 option').eq(17).show();
								$('#2968 option').eq(18).hide();
								$('#2968 option').eq(19).hide();
								$('#2968 option').eq(20).hide();

							} else if ((YearVal == "5")
									&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
									&& (ThroughUPSEEVal == "2")
									&& (HostelVal == "2")
									&& (FeeWaiverStudentVal == "2")
									&& (val == "2963*General" || val == "2963*OBC")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -25 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).hide();
								$('#2968 option').eq(2).hide();
								$('#2968 option').eq(3).hide();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).hide();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).hide();
								$('#2968 option').eq(9).hide();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).hide();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).hide();
								$('#2968 option').eq(15).hide();
								$('#2968 option').eq(16).hide();
								$('#2968 option').eq(17).hide();
								$('#2968 option').eq(18).hide();
								$('#2968 option').eq(19).show();
								$('#2968 option').eq(20).hide();

							} else if ((YearVal == "5")
									&& (ParentsAnnualIncomeVal == "1")
									&& (ThroughUPSEEVal == "2")
									&& (HostelVal == "1")
									&& (FeeWaiverStudentVal == "2")
									&& (val == "2963*SC" || val == "2963*ST")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -26 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).hide();
								$('#2968 option').eq(2).hide();
								$('#2968 option').eq(3).hide();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).hide();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).hide();
								$('#2968 option').eq(9).hide();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).hide();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).hide();
								$('#2968 option').eq(15).hide();
								$('#2968 option').eq(16).hide();
								$('#2968 option').eq(17).show();
								$('#2968 option').eq(18).hide();
								$('#2968 option').eq(19).hide();
								$('#2968 option').eq(20).hide();

							} else if ((YearVal == "5")
									&& (ParentsAnnualIncomeVal == "1")
									&& (ThroughUPSEEVal == "2")
									&& (HostelVal == "2")
									&& (FeeWaiverStudentVal == "2")
									&& (val == "2963*SC" || val == "2963*ST")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -27 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).hide();
								$('#2968 option').eq(2).hide();
								$('#2968 option').eq(3).hide();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).hide();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).hide();
								$('#2968 option').eq(9).hide();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).hide();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).hide();
								$('#2968 option').eq(15).hide();
								$('#2968 option').eq(16).hide();
								$('#2968 option').eq(17).hide();
								$('#2968 option').eq(18).hide();
								$('#2968 option').eq(19).show();
								$('#2968 option').eq(20).hide();

							} else if ((YearVal == "5")
									&& (ParentsAnnualIncomeVal == "2")
									&& (ThroughUPSEEVal == "2")
									&& (HostelVal == "1")
									&& (FeeWaiverStudentVal == "2")
									&& (val == "2963*SC" || val == "2963*ST")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -28 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).hide();
								$('#2968 option').eq(2).hide();
								$('#2968 option').eq(3).hide();
								$('#2968 option').eq(4).show();
								$('#2968 option').eq(5).hide();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).hide();
								$('#2968 option').eq(9).hide();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).hide();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).hide();
								$('#2968 option').eq(15).hide();
								$('#2968 option').eq(16).hide();
								$('#2968 option').eq(17).hide();
								$('#2968 option').eq(18).hide();
								$('#2968 option').eq(19).hide();
								$('#2968 option').eq(20).hide();

							} else if ((YearVal == "5")
									&& (ParentsAnnualIncomeVal == "2")
									&& (ThroughUPSEEVal == "2")
									&& (HostelVal == "2")
									&& (FeeWaiverStudentVal == "2")
									&& (val == "2963*SC" || val == "2963*ST")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -29 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).hide();
								$('#2968 option').eq(2).hide();
								$('#2968 option').eq(3).hide();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).hide();
								$('#2968 option').eq(6).show();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).hide();
								$('#2968 option').eq(9).hide();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).hide();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).hide();
								$('#2968 option').eq(15).hide();
								$('#2968 option').eq(16).hide();
								$('#2968 option').eq(17).hide();
								$('#2968 option').eq(18).hide();
								$('#2968 option').eq(19).hide();
								$('#2968 option').eq(20).hide();

							} else if ((YearVal == "1" || YearVal == "2")
									&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
									&& (ThroughUPSEEVal == "2")
									&& (HostelVal == "1" || HostelVal == "2")
									&& (FeeWaiverStudentVal == "1")
									&& (val == "2963*General"
											|| val == "2963*OBC"
											|| val == "2963*SC" || val == "2963*ST")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -30 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).hide();
								$('#2968 option').eq(2).hide();
								$('#2968 option').eq(3).hide();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).hide();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).hide();
								$('#2968 option').eq(9).hide();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).hide();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).show();
								$('#2968 option').eq(14).hide();
								$('#2968 option').eq(15).hide();
								$('#2968 option').eq(16).hide();
								$('#2968 option').eq(17).hide();
								$('#2968 option').eq(18).hide();
								$('#2968 option').eq(19).hide();
								$('#2968 option').eq(20).hide();

							} else if ((YearVal == "3")
									&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
									&& (ThroughUPSEEVal == "2")
									&& (HostelVal == "1")
									&& (FeeWaiverStudentVal == "1")
									&& (val == "2963*General"
											|| val == "2963*OBC"
											|| val == "2963*SC" || val == "2963*ST")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -31 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).hide();
								$('#2968 option').eq(2).hide();
								$('#2968 option').eq(3).hide();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).hide();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).hide();
								$('#2968 option').eq(9).show();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).hide();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).hide();
								$('#2968 option').eq(15).hide();
								$('#2968 option').eq(16).hide();
								$('#2968 option').eq(17).hide();
								$('#2968 option').eq(18).hide();
								$('#2968 option').eq(19).hide();
								$('#2968 option').eq(20).hide();

							} else if ((YearVal == "3")
									&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
									&& (ThroughUPSEEVal == "2")
									&& (HostelVal == "2")
									&& (FeeWaiverStudentVal == "1")
									&& (val == "2963*General"
											|| val == "2963*OBC"
											|| val == "2963*SC" || val == "2963*ST")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -32 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).hide();
								$('#2968 option').eq(2).hide();
								$('#2968 option').eq(3).hide();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).hide();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).hide();
								$('#2968 option').eq(9).hide();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).show();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).hide();
								$('#2968 option').eq(15).hide();
								$('#2968 option').eq(16).hide();
								$('#2968 option').eq(17).hide();
								$('#2968 option').eq(18).hide();
								$('#2968 option').eq(19).hide();
								$('#2968 option').eq(20).hide();

							} else if ((YearVal == "4")
									&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
									&& (ThroughUPSEEVal == "2")
									&& (HostelVal == "1")
									&& (FeeWaiverStudentVal == "1")
									&& (val == "2963*General"
											|| val == "2963*OBC"
											|| val == "2963*SC" || val == "2963*ST")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -33 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).hide();
								$('#2968 option').eq(2).hide();
								$('#2968 option').eq(3).hide();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).hide();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).hide();
								$('#2968 option').eq(9).show();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).hide();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).hide();
								$('#2968 option').eq(15).hide();
								$('#2968 option').eq(16).hide();
								$('#2968 option').eq(17).hide();
								$('#2968 option').eq(18).hide();
								$('#2968 option').eq(19).hide();
								$('#2968 option').eq(20).hide();

							} else if ((YearVal == "4")
									&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
									&& (ThroughUPSEEVal == "2")
									&& (HostelVal == "2")
									&& (FeeWaiverStudentVal == "1")
									&& (val == "2963*General"
											|| val == "2963*OBC"
											|| val == "2963*SC" || val == "2963*ST")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -34 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).hide();
								$('#2968 option').eq(2).hide();
								$('#2968 option').eq(3).hide();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).hide();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).hide();
								$('#2968 option').eq(9).hide();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).show();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).hide();
								$('#2968 option').eq(15).hide();
								$('#2968 option').eq(16).hide();
								$('#2968 option').eq(17).hide();
								$('#2968 option').eq(18).hide();
								$('#2968 option').eq(19).hide();
								$('#2968 option').eq(20).hide();

							} else if ((YearVal == "5")
									&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
									&& (ThroughUPSEEVal == "2")
									&& (HostelVal == "1")
									&& (FeeWaiverStudentVal == "1")
									&& (val == "2963*General"
											|| val == "2963*OBC"
											|| val == "2963*SC" || val == "2963*ST")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -35 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).hide();
								$('#2968 option').eq(2).hide();
								$('#2968 option').eq(3).hide();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).hide();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).hide();
								$('#2968 option').eq(9).hide();
								$('#2968 option').eq(10).show();
								$('#2968 option').eq(11).hide();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).hide();
								$('#2968 option').eq(15).hide();
								$('#2968 option').eq(16).hide();
								$('#2968 option').eq(17).hide();
								$('#2968 option').eq(18).hide();
								$('#2968 option').eq(19).hide();
								$('#2968 option').eq(20).hide();

							} else if ((YearVal == "5")
									&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
									&& (ThroughUPSEEVal == "2")
									&& (HostelVal == "2")
									&& (FeeWaiverStudentVal == "1")
									&& (val == "2963*General"
											|| val == "2963*OBC"
											|| val == "2963*SC" || val == "2963*ST")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -36 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).hide();
								$('#2968 option').eq(2).hide();
								$('#2968 option').eq(3).hide();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).hide();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).hide();
								$('#2968 option').eq(9).hide();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).hide();
								$('#2968 option').eq(12).show();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).hide();
								$('#2968 option').eq(15).hide();
								$('#2968 option').eq(16).hide();
								$('#2968 option').eq(17).hide();
								$('#2968 option').eq(18).hide();
								$('#2968 option').eq(19).hide();
								$('#2968 option').eq(20).hide();

							} else if ((YearVal == "1")
									&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
									&& (ThroughUPSEEVal == "1")
									&& (HostelVal == "1" || HostelVal == "2")
									&& (FeeWaiverStudentVal == "2")
									&& (val == "2963*General" || val == "2963*OBC")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -37 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).hide();
								$('#2968 option').eq(2).hide();
								$('#2968 option').eq(3).hide();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).hide();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).hide();
								$('#2968 option').eq(9).hide();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).hide();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).show();
								$('#2968 option').eq(15).hide();
								$('#2968 option').eq(16).hide();
								$('#2968 option').eq(17).hide();
								$('#2968 option').eq(18).hide();
								$('#2968 option').eq(19).hide();
								$('#2968 option').eq(20).hide();

							} else if ((YearVal == "1")
									&& (ParentsAnnualIncomeVal == "1")
									&& (ThroughUPSEEVal == "1")
									&& (HostelVal == "1" || HostelVal == "2")
									&& (FeeWaiverStudentVal == "2")
									&& (val == "2963*SC" || val == "2963*ST")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -38 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).hide();
								$('#2968 option').eq(2).hide();
								$('#2968 option').eq(3).hide();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).hide();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).hide();
								$('#2968 option').eq(9).hide();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).hide();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).hide();
								$('#2968 option').eq(15).show();
								$('#2968 option').eq(16).hide();
								$('#2968 option').eq(17).hide();
								$('#2968 option').eq(18).hide();
								$('#2968 option').eq(19).hide();
								$('#2968 option').eq(20).hide();

							} else if ((YearVal == "1")
									&& (ParentsAnnualIncomeVal == "2")
									&& (ThroughUPSEEVal == "1")
									&& (HostelVal == "1" || HostelVal == "2")
									&& (FeeWaiverStudentVal == "2")
									&& (val == "2963*SC" || val == "2963*ST")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -39 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).show();
								$('#2968 option').eq(2).hide();
								$('#2968 option').eq(3).hide();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).hide();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).hide();
								$('#2968 option').eq(9).hide();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).hide();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).hide();
								$('#2968 option').eq(15).hide();
								$('#2968 option').eq(16).hide();
								$('#2968 option').eq(17).hide();
								$('#2968 option').eq(18).hide();
								$('#2968 option').eq(19).hide();
								$('#2968 option').eq(20).hide();

							} else if ((YearVal == "2")
									&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
									&& (ThroughUPSEEVal == "1")
									&& (HostelVal == "1" || HostelVal == "2")
									&& (FeeWaiverStudentVal == "2")
									&& (val == "2963*General" || val == "2963*OBC")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -40 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).hide();
								$('#2968 option').eq(2).hide();
								$('#2968 option').eq(3).hide();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).hide();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).hide();
								$('#2968 option').eq(9).hide();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).hide();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).show();
								$('#2968 option').eq(15).hide();
								$('#2968 option').eq(16).hide();
								$('#2968 option').eq(17).hide();
								$('#2968 option').eq(18).hide();
								$('#2968 option').eq(19).hide();
								$('#2968 option').eq(20).hide();

							} else if ((YearVal == "2")
									&& (ParentsAnnualIncomeVal == "1")
									&& (ThroughUPSEEVal == "1")
									&& (HostelVal == "1" || HostelVal == "2")
									&& (FeeWaiverStudentVal == "2")
									&& (val == "2963*SC" || val == "2963*ST")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -41 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).hide();
								$('#2968 option').eq(2).hide();
								$('#2968 option').eq(3).hide();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).hide();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).hide();
								$('#2968 option').eq(9).hide();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).hide();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).hide();
								$('#2968 option').eq(15).show();
								$('#2968 option').eq(16).hide();
								$('#2968 option').eq(17).hide();
								$('#2968 option').eq(18).hide();
								$('#2968 option').eq(19).hide();
								$('#2968 option').eq(20).hide();

							} else if ((YearVal == "2")
									&& (ParentsAnnualIncomeVal == "2")
									&& (ThroughUPSEEVal == "1")
									&& (HostelVal == "1" || HostelVal == "2")
									&& (FeeWaiverStudentVal == "2")
									&& (val == "2963*SC" || val == "2963*ST")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -42 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).show();
								$('#2968 option').eq(2).hide();
								$('#2968 option').eq(3).hide();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).hide();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).hide();
								$('#2968 option').eq(9).hide();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).hide();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).hide();
								$('#2968 option').eq(15).hide();
								$('#2968 option').eq(16).hide();
								$('#2968 option').eq(17).hide();
								$('#2968 option').eq(18).hide();
								$('#2968 option').eq(19).hide();
								$('#2968 option').eq(20).hide();

							} else if ((YearVal == "1")
									&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
									&& (ThroughUPSEEVal == "1")
									&& (HostelVal == "1" || HostelVal == "2")
									&& (FeeWaiverStudentVal == "1")
									&& (val == "2963*General" || val == "2963*OBC")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -43 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).hide();
								$('#2968 option').eq(2).show();
								$('#2968 option').eq(3).hide();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).hide();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).hide();
								$('#2968 option').eq(9).hide();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).hide();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).hide();
								$('#2968 option').eq(15).hide();
								$('#2968 option').eq(16).hide();
								$('#2968 option').eq(17).hide();
								$('#2968 option').eq(18).hide();
								$('#2968 option').eq(19).hide();
								$('#2968 option').eq(20).hide();

							} else if ((YearVal == "1")
									&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
									&& (ThroughUPSEEVal == "1")
									&& (HostelVal == "1" || HostelVal == "2")
									&& (FeeWaiverStudentVal == "1")
									&& (val == "2963*SC" || val == "2963*ST")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -44 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).hide();
								$('#2968 option').eq(2).hide();
								$('#2968 option').eq(3).hide();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).hide();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).show();
								$('#2968 option').eq(9).hide();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).hide();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).hide();
								$('#2968 option').eq(15).hide();
								$('#2968 option').eq(16).hide();
								$('#2968 option').eq(17).hide();
								$('#2968 option').eq(18).hide();
								$('#2968 option').eq(19).hide();
								$('#2968 option').eq(20).hide();

							} else if ((YearVal == "2")
									&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
									&& (ThroughUPSEEVal == "1")
									&& (HostelVal == "1" || HostelVal == "2")
									&& (FeeWaiverStudentVal == "1")
									&& (val == "2963*General" || val == "2963*OBC")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -45 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).hide();
								$('#2968 option').eq(2).show();
								$('#2968 option').eq(3).hide();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).hide();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).hide();
								$('#2968 option').eq(9).hide();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).hide();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).hide();
								$('#2968 option').eq(15).hide();
								$('#2968 option').eq(16).hide();
								$('#2968 option').eq(17).hide();
								$('#2968 option').eq(18).hide();
								$('#2968 option').eq(19).hide();
								$('#2968 option').eq(20).hide();

							} else if ((YearVal == "2")
									&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
									&& (ThroughUPSEEVal == "1")
									&& (HostelVal == "1" || HostelVal == "2")
									&& (FeeWaiverStudentVal == "1")
									&& (val == "2963*SC" || val == "2963*ST")) {
								// alert("showHideListBoxOptionsofRNCollegeMessFee
								// -46 >> "+ParentsAnnualIncomeVal +", YearVal -
								// "+YearVal+", ThroughUPSEEVal -
								// "+ThroughUPSEEVal+", HostelVal -
								// "+HostelVal+", FeeWaiverStudentVal -
								// "+FeeWaiverStudentVal+"");
								document.getElementById("2968").selectedIndex = 0;
								$('#2968 option').eq(1).hide();
								$('#2968 option').eq(2).hide();
								$('#2968 option').eq(3).hide();
								$('#2968 option').eq(4).hide();
								$('#2968 option').eq(5).hide();
								$('#2968 option').eq(6).hide();
								$('#2968 option').eq(7).hide();
								$('#2968 option').eq(8).show();
								$('#2968 option').eq(9).hide();
								$('#2968 option').eq(10).hide();
								$('#2968 option').eq(11).hide();
								$('#2968 option').eq(12).hide();
								$('#2968 option').eq(13).hide();
								$('#2968 option').eq(14).hide();
								$('#2968 option').eq(15).hide();
								$('#2968 option').eq(16).hide();
								$('#2968 option').eq(17).hide();
								$('#2968 option').eq(18).hide();
								$('#2968 option').eq(19).hide();
								$('#2968 option').eq(20).hide();
							}
						}
					}
				}

				// //++++++++++++-------RECUP COLLEGE FEE FORM VALIDATION WORK
				// END 17 July------------++++++++++/////

				// //++++++++++++-------RECUP COLLEGE MESS FEE VALIDATION WORK
				// Start 17 July 2019------------++++++++++/////

				function showHideListBoxOptionsofRECUPCollegeMessFee(form_value) {
					// alert("showHideListBoxOptionsofRECUPCollegeMessFee -1");
					var val = form_value;
					if ((val.indexOf("2935*I") != '-1'
							|| val.indexOf("2935*II") != '-1' || val
							.indexOf("2935*III") != '-1')
							|| val.indexOf("2935*IV") != '-1') {
						var GenderVal = document.getElementById("2940").selectedIndex;
						var EntryVal = document.getElementById("2937").selectedIndex;
						// alert("showHideListBoxOptionsofRECUPCollegeMessFee -2
						// >> "+GenderVal +", EntryVal - "+EntryVal+"");
						if (val == 0) {
							// alert("showHideListBoxOptionsofRECUPCollegeMessFee
							// -3 >> "+GenderVal);
							document.getElementById("2935").selectedIndex = 0;
							document.getElementById("2935").focus();
							return false;
						} else {
							// alert("showHideListBoxOptionsofRECUPCollegeMessFee
							// -4 >> "+GenderVal +", EntryVal - "+EntryVal+"");
							if ((val == "2935*I")
									&& (EntryVal == "1" || EntryVal == "2")
									&& (GenderVal == "1")) {
								a// lert("showHideListBoxOptionsofRECUPCollegeMessFee
									// -5 >>"+GenderVal +", EntryVal -
									// "+EntryVal+"");
								document.getElementById("2948").selectedIndex = 0;
								$('#2948 option').eq(1).hide();
								$('#2948 option').eq(2).show();
								$('#2948 option').eq(3).hide();

							}
							if ((val == "2935*III")
									&& (EntryVal == "1" || EntryVal == "2")
									&& (GenderVal == "1")) {
								// alert("showHideListBoxOptionsofRECUPCollegeMessFee
								// -6 >>"+GenderVal +", EntryVal -
								// "+EntryVal+"");
								document.getElementById("2948").selectedIndex = 0;
								$('#2948 option').eq(1).hide();
								$('#2948 option').eq(2).hide();
								$('#2948 option').eq(3).show();

							}
							if ((val == "2935*II") && (EntryVal == "1")
									&& (GenderVal == "1")) {
								// alert("showHideListBoxOptionsofRECUPCollegeMessFee
								// -7 >>"+GenderVal +", EntryVal -
								// "+EntryVal+"");
								document.getElementById("2948").selectedIndex = 0;
								$('#2948 option').eq(1).hide();
								$('#2948 option').eq(2).show();
								$('#2948 option').eq(3).hide();

							} else if ((val == "2935*II") && (EntryVal == "2")
									&& (GenderVal == "1")) {
								// alert("showHideListBoxOptionsofRECUPCollegeMessFee
								// -8 >>"+GenderVal +", EntryVal -
								// "+EntryVal+"");
								document.getElementById("2948").selectedIndex = 0;
								$('#2948 option').eq(1).hide();
								$('#2948 option').eq(2).hide();
								$('#2948 option').eq(3).show();

							} else if ((val == "2935*IV") && (EntryVal == "2")
									&& (GenderVal == "1")) {
								// alert("showHideListBoxOptionsofRECUPCollegeMessFee
								// -9 >>"+GenderVal +", EntryVal -
								// "+EntryVal+"");
								document.getElementById("2948").selectedIndex = 0;
								$('#2948 option').eq(1).hide();
								$('#2948 option').eq(2).show();
								$('#2948 option').eq(3).hide();

							} else if ((val == "2935*IV") && (EntryVal == "1")
									&& (GenderVal == "1")) {
								// alert("showHideListBoxOptionsofRECUPCollegeMessFee
								// -10 >>"+GenderVal +", EntryVal -
								// "+EntryVal+"");
								document.getElementById("2948").selectedIndex = 0;
								$('#2948 option').eq(1).hide();
								$('#2948 option').eq(2).hide();
								$('#2948 option').eq(3).show();

							} else if ((val == "2935*I" || val == "2935*II"
									|| val == "2935*III" || val == "2935*IV")
									&& (EntryVal == "1" || EntryVal == "2")
									&& (GenderVal == "2")) {
								// alert("showHideListBoxOptionsofRECUPCollegeMessFee
								// -11 >>"+GenderVal +", EntryVal -
								// "+EntryVal+"");
								document.getElementById("2948").selectedIndex = 0;
								$('#2948 option').eq(1).show();
								$('#2948 option').eq(2).hide();
								$('#2948 option').eq(3).hide();
							}
						}
					}
				}

				// //++++++++++++-------RECUP COLLEGE MESS FEE VALIDATION WORK
				// END 17 July 2019------------++++++++++/////
				// alert("showHideListBoxOptionsofRNCollegeMessFee -13 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).hide();
				$('#2968 option').eq(2).hide();
				$('#2968 option').eq(3).hide();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).hide();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).hide();
				$('#2968 option').eq(9).hide();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).hide();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).hide();
				$('#2968 option').eq(15).hide();
				$('#2968 option').eq(16).hide();
				$('#2968 option').eq(17).hide();
				$('#2968 option').eq(18).show();
				$('#2968 option').eq(19).hide();
				$('#2968 option').eq(20).hide();

			} else if ((YearVal == "3") && (ParentsAnnualIncomeVal == "1")
					&& (ThroughUPSEEVal == "2") && (HostelVal == "1")
					&& (FeeWaiverStudentVal == "2")
					&& (val == "2963*SC" || val == "2963*ST")) {
				// alert("showHideListBoxOptionsofRNCollegeMessFee -14 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).hide();
				$('#2968 option').eq(2).hide();
				$('#2968 option').eq(3).hide();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).hide();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).hide();
				$('#2968 option').eq(9).hide();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).hide();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).hide();
				$('#2968 option').eq(15).hide();
				$('#2968 option').eq(16).show();
				$('#2968 option').eq(17).hide();
				$('#2968 option').eq(18).hide();
				$('#2968 option').eq(19).hide();
				$('#2968 option').eq(20).hide();

			} else if ((YearVal == "3") && (ParentsAnnualIncomeVal == "1")
					&& (ThroughUPSEEVal == "2") && (HostelVal == "2")
					&& (FeeWaiverStudentVal == "2")
					&& (val == "2963*SC" || val == "2963*ST")) {
				// alert("showHideListBoxOptionsofRNCollegeMessFee -15 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).hide();
				$('#2968 option').eq(2).hide();
				$('#2968 option').eq(3).hide();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).hide();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).hide();
				$('#2968 option').eq(9).hide();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).hide();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).hide();
				$('#2968 option').eq(15).hide();
				$('#2968 option').eq(16).hide();
				$('#2968 option').eq(17).hide();
				$('#2968 option').eq(18).show();
				$('#2968 option').eq(19).hide();
				$('#2968 option').eq(20).hide();

			} else if ((YearVal == "3") && (ParentsAnnualIncomeVal == "2")
					&& (ThroughUPSEEVal == "2") && (HostelVal == "1")
					&& (FeeWaiverStudentVal == "2")
					&& (val == "2963*SC" || val == "2963*ST")) {
				// alert("showHideListBoxOptionsofRNCollegeMessFee -16 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).hide();
				$('#2968 option').eq(2).hide();
				$('#2968 option').eq(3).show();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).hide();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).hide();
				$('#2968 option').eq(9).hide();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).hide();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).hide();
				$('#2968 option').eq(15).hide();
				$('#2968 option').eq(16).hide();
				$('#2968 option').eq(17).hide();
				$('#2968 option').eq(18).hide();
				$('#2968 option').eq(19).hide();
				$('#2968 option').eq(20).hide();

			} else if ((YearVal == "3") && (ParentsAnnualIncomeVal == "2")
					&& (ThroughUPSEEVal == "2") && (HostelVal == "2")
					&& (FeeWaiverStudentVal == "2")
					&& (val == "2963*SC" || val == "2963*ST")) {
				// alert("showHideListBoxOptionsofRNCollegeMessFee -17 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).hide();
				$('#2968 option').eq(2).hide();
				$('#2968 option').eq(3).hide();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).show();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).hide();
				$('#2968 option').eq(9).hide();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).hide();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).hide();
				$('#2968 option').eq(15).hide();
				$('#2968 option').eq(16).hide();
				$('#2968 option').eq(17).hide();
				$('#2968 option').eq(18).hide();
				$('#2968 option').eq(19).hide();
				$('#2968 option').eq(20).hide();

			} else if ((YearVal == "4")
					&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
					&& (ThroughUPSEEVal == "2") && (HostelVal == "1")
					&& (FeeWaiverStudentVal == "2")
					&& (val == "2963*General" || val == "2963*OBC")) {
				// alert("showHideListBoxOptionsofRNCollegeMessFee -18 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).hide();
				$('#2968 option').eq(2).hide();
				$('#2968 option').eq(3).hide();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).hide();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).hide();
				$('#2968 option').eq(9).hide();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).hide();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).hide();
				$('#2968 option').eq(15).hide();
				$('#2968 option').eq(16).show();
				$('#2968 option').eq(17).hide();
				$('#2968 option').eq(18).hide();
				$('#2968 option').eq(19).hide();
				$('#2968 option').eq(20).hide();

			} else if ((YearVal == "4")
					&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
					&& (ThroughUPSEEVal == "2") && (HostelVal == "2")
					&& (FeeWaiverStudentVal == "2")
					&& (val == "2963*General" || val == "2963*OBC")) {
				// alert("showHideListBoxOptionsofRNCollegeMessFee -19 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).hide();
				$('#2968 option').eq(2).hide();
				$('#2968 option').eq(3).hide();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).hide();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).hide();
				$('#2968 option').eq(9).hide();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).hide();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).hide();
				$('#2968 option').eq(15).hide();
				$('#2968 option').eq(16).hide();
				$('#2968 option').eq(17).hide();
				$('#2968 option').eq(18).show();
				$('#2968 option').eq(19).hide();
				$('#2968 option').eq(20).hide();

			} else if ((YearVal == "4") && (ParentsAnnualIncomeVal == "1")
					&& (ThroughUPSEEVal == "2") && (HostelVal == "1")
					&& (FeeWaiverStudentVal == "2")
					&& (val == "2963*SC" || val == "2963*ST")) {
				// alert("showHideListBoxOptionsofRNCollegeMessFee -20 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).hide();
				$('#2968 option').eq(2).hide();
				$('#2968 option').eq(3).hide();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).hide();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).hide();
				$('#2968 option').eq(9).hide();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).hide();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).hide();
				$('#2968 option').eq(15).hide();
				$('#2968 option').eq(16).show();
				$('#2968 option').eq(17).hide();
				$('#2968 option').eq(18).hide();
				$('#2968 option').eq(19).hide();
				$('#2968 option').eq(20).hide();

			} else if ((YearVal == "4") && (ParentsAnnualIncomeVal == "1")
					&& (ThroughUPSEEVal == "2") && (HostelVal == "2")
					&& (FeeWaiverStudentVal == "2")
					&& (val == "2963*SC" || val == "2963*ST")) {
				// alert("showHideListBoxOptionsofRNCollegeMessFee -21 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).hide();
				$('#2968 option').eq(2).hide();
				$('#2968 option').eq(3).hide();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).hide();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).hide();
				$('#2968 option').eq(9).hide();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).hide();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).hide();
				$('#2968 option').eq(15).hide();
				$('#2968 option').eq(16).hide();
				$('#2968 option').eq(17).hide();
				$('#2968 option').eq(18).show();
				$('#2968 option').eq(19).hide();
				$('#2968 option').eq(20).hide();

			} else if ((YearVal == "4") && (ParentsAnnualIncomeVal == "2")
					&& (ThroughUPSEEVal == "2") && (HostelVal == "1")
					&& (FeeWaiverStudentVal == "2")
					&& (val == "2963*SC" || val == "2963*ST")) {
				// alert("showHideListBoxOptionsofRNCollegeMessFee -22 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).hide();
				$('#2968 option').eq(2).hide();
				$('#2968 option').eq(3).show();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).hide();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).hide();
				$('#2968 option').eq(9).hide();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).hide();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).hide();
				$('#2968 option').eq(15).hide();
				$('#2968 option').eq(16).hide();
				$('#2968 option').eq(17).hide();
				$('#2968 option').eq(18).hide();
				$('#2968 option').eq(19).hide();
				$('#2968 option').eq(20).hide();

			} else if ((YearVal == "4") && (ParentsAnnualIncomeVal == "2")
					&& (ThroughUPSEEVal == "2") && (HostelVal == "2")
					&& (FeeWaiverStudentVal == "2")
					&& (val == "2963*SC" || val == "2963*ST")) {
				// alert("showHideListBoxOptionsofRNCollegeMessFee -23 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).hide();
				$('#2968 option').eq(2).hide();
				$('#2968 option').eq(3).hide();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).show();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).hide();
				$('#2968 option').eq(9).hide();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).hide();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).hide();
				$('#2968 option').eq(15).hide();
				$('#2968 option').eq(16).hide();
				$('#2968 option').eq(17).hide();
				$('#2968 option').eq(18).hide();
				$('#2968 option').eq(19).hide();
				$('#2968 option').eq(20).hide();

			} else if ((YearVal == "5")
					&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
					&& (ThroughUPSEEVal == "2") && (HostelVal == "1")
					&& (FeeWaiverStudentVal == "2")
					&& (val == "2963*General" || val == "2963*OBC")) {
				// alert("showHideListBoxOptionsofRNCollegeMessFee -24 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).hide();
				$('#2968 option').eq(2).hide();
				$('#2968 option').eq(3).hide();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).hide();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).hide();
				$('#2968 option').eq(9).hide();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).hide();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).hide();
				$('#2968 option').eq(15).hide();
				$('#2968 option').eq(16).hide();
				$('#2968 option').eq(17).show();
				$('#2968 option').eq(18).hide();
				$('#2968 option').eq(19).hide();
				$('#2968 option').eq(20).hide();

			} else if ((YearVal == "5")
					&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
					&& (ThroughUPSEEVal == "2") && (HostelVal == "2")
					&& (FeeWaiverStudentVal == "2")
					&& (val == "2963*General" || val == "2963*OBC")) {
				// alert("showHideListBoxOptionsofRNCollegeMessFee -25 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).hide();
				$('#2968 option').eq(2).hide();
				$('#2968 option').eq(3).hide();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).hide();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).hide();
				$('#2968 option').eq(9).hide();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).hide();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).hide();
				$('#2968 option').eq(15).hide();
				$('#2968 option').eq(16).hide();
				$('#2968 option').eq(17).hide();
				$('#2968 option').eq(18).hide();
				$('#2968 option').eq(19).show();
				$('#2968 option').eq(20).hide();

			} else if ((YearVal == "5") && (ParentsAnnualIncomeVal == "1")
					&& (ThroughUPSEEVal == "2") && (HostelVal == "1")
					&& (FeeWaiverStudentVal == "2")
					&& (val == "2963*SC" || val == "2963*ST")) {
				// alert("showHideListBoxOptionsofRNCollegeMessFee -26 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).hide();
				$('#2968 option').eq(2).hide();
				$('#2968 option').eq(3).hide();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).hide();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).hide();
				$('#2968 option').eq(9).hide();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).hide();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).hide();
				$('#2968 option').eq(15).hide();
				$('#2968 option').eq(16).hide();
				$('#2968 option').eq(17).show();
				$('#2968 option').eq(18).hide();
				$('#2968 option').eq(19).hide();
				$('#2968 option').eq(20).hide();

			} else if ((YearVal == "5") && (ParentsAnnualIncomeVal == "1")
					&& (ThroughUPSEEVal == "2") && (HostelVal == "2")
					&& (FeeWaiverStudentVal == "2")
					&& (val == "2963*SC" || val == "2963*ST")) {
				// alert("showHideListBoxOptionsofRNCollegeMessFee -27 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).hide();
				$('#2968 option').eq(2).hide();
				$('#2968 option').eq(3).hide();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).hide();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).hide();
				$('#2968 option').eq(9).hide();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).hide();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).hide();
				$('#2968 option').eq(15).hide();
				$('#2968 option').eq(16).hide();
				$('#2968 option').eq(17).hide();
				$('#2968 option').eq(18).hide();
				$('#2968 option').eq(19).show();
				$('#2968 option').eq(20).hide();

			} else if ((YearVal == "5") && (ParentsAnnualIncomeVal == "2")
					&& (ThroughUPSEEVal == "2") && (HostelVal == "1")
					&& (FeeWaiverStudentVal == "2")
					&& (val == "2963*SC" || val == "2963*ST")) {
				// alert("showHideListBoxOptionsofRNCollegeMessFee -28 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).hide();
				$('#2968 option').eq(2).hide();
				$('#2968 option').eq(3).hide();
				$('#2968 option').eq(4).show();
				$('#2968 option').eq(5).hide();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).hide();
				$('#2968 option').eq(9).hide();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).hide();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).hide();
				$('#2968 option').eq(15).hide();
				$('#2968 option').eq(16).hide();
				$('#2968 option').eq(17).hide();
				$('#2968 option').eq(18).hide();
				$('#2968 option').eq(19).hide();
				$('#2968 option').eq(20).hide();

			} else if ((YearVal == "5") && (ParentsAnnualIncomeVal == "2")
					&& (ThroughUPSEEVal == "2") && (HostelVal == "2")
					&& (FeeWaiverStudentVal == "2")
					&& (val == "2963*SC" || val == "2963*ST")) {
				// alert("showHideListBoxOptionsofRNCollegeMessFee -29 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).hide();
				$('#2968 option').eq(2).hide();
				$('#2968 option').eq(3).hide();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).hide();
				$('#2968 option').eq(6).show();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).hide();
				$('#2968 option').eq(9).hide();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).hide();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).hide();
				$('#2968 option').eq(15).hide();
				$('#2968 option').eq(16).hide();
				$('#2968 option').eq(17).hide();
				$('#2968 option').eq(18).hide();
				$('#2968 option').eq(19).hide();
				$('#2968 option').eq(20).hide();

			} else if ((YearVal == "1" || YearVal == "2")
					&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
					&& (ThroughUPSEEVal == "2")
					&& (HostelVal == "1" || HostelVal == "2")
					&& (FeeWaiverStudentVal == "1")
					&& (val == "2963*General" || val == "2963*OBC"
							|| val == "2963*SC" || val == "2963*ST")) {
				// alert("showHideListBoxOptionsofRNCollegeMessFee -30 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).hide();
				$('#2968 option').eq(2).hide();
				$('#2968 option').eq(3).hide();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).hide();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).hide();
				$('#2968 option').eq(9).hide();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).hide();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).show();
				$('#2968 option').eq(14).hide();
				$('#2968 option').eq(15).hide();
				$('#2968 option').eq(16).hide();
				$('#2968 option').eq(17).hide();
				$('#2968 option').eq(18).hide();
				$('#2968 option').eq(19).hide();
				$('#2968 option').eq(20).hide();

			} else if ((YearVal == "3")
					&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
					&& (ThroughUPSEEVal == "2")
					&& (HostelVal == "1")
					&& (FeeWaiverStudentVal == "1")
					&& (val == "2963*General" || val == "2963*OBC"
							|| val == "2963*SC" || val == "2963*ST")) {
				// alert("showHideListBoxOptionsofRNCollegeMessFee -31 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).hide();
				$('#2968 option').eq(2).hide();
				$('#2968 option').eq(3).hide();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).hide();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).hide();
				$('#2968 option').eq(9).show();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).hide();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).hide();
				$('#2968 option').eq(15).hide();
				$('#2968 option').eq(16).hide();
				$('#2968 option').eq(17).hide();
				$('#2968 option').eq(18).hide();
				$('#2968 option').eq(19).hide();
				$('#2968 option').eq(20).hide();

			} else if ((YearVal == "3")
					&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
					&& (ThroughUPSEEVal == "2")
					&& (HostelVal == "2")
					&& (FeeWaiverStudentVal == "1")
					&& (val == "2963*General" || val == "2963*OBC"
							|| val == "2963*SC" || val == "2963*ST")) {
				// alert("showHideListBoxOptionsofRNCollegeMessFee -32 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).hide();
				$('#2968 option').eq(2).hide();
				$('#2968 option').eq(3).hide();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).hide();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).hide();
				$('#2968 option').eq(9).hide();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).show();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).hide();
				$('#2968 option').eq(15).hide();
				$('#2968 option').eq(16).hide();
				$('#2968 option').eq(17).hide();
				$('#2968 option').eq(18).hide();
				$('#2968 option').eq(19).hide();
				$('#2968 option').eq(20).hide();

			} else if ((YearVal == "4")
					&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
					&& (ThroughUPSEEVal == "2")
					&& (HostelVal == "1")
					&& (FeeWaiverStudentVal == "1")
					&& (val == "2963*General" || val == "2963*OBC"
							|| val == "2963*SC" || val == "2963*ST")) {
				// alert("showHideListBoxOptionsofRNCollegeMessFee -33 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).hide();
				$('#2968 option').eq(2).hide();
				$('#2968 option').eq(3).hide();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).hide();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).hide();
				$('#2968 option').eq(9).show();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).hide();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).hide();
				$('#2968 option').eq(15).hide();
				$('#2968 option').eq(16).hide();
				$('#2968 option').eq(17).hide();
				$('#2968 option').eq(18).hide();
				$('#2968 option').eq(19).hide();
				$('#2968 option').eq(20).hide();

			} else if ((YearVal == "4")
					&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
					&& (ThroughUPSEEVal == "2")
					&& (HostelVal == "2")
					&& (FeeWaiverStudentVal == "1")
					&& (val == "2963*General" || val == "2963*OBC"
							|| val == "2963*SC" || val == "2963*ST")) {
				// alert("showHideListBoxOptionsofRNCollegeMessFee -34 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).hide();
				$('#2968 option').eq(2).hide();
				$('#2968 option').eq(3).hide();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).hide();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).hide();
				$('#2968 option').eq(9).hide();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).show();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).hide();
				$('#2968 option').eq(15).hide();
				$('#2968 option').eq(16).hide();
				$('#2968 option').eq(17).hide();
				$('#2968 option').eq(18).hide();
				$('#2968 option').eq(19).hide();
				$('#2968 option').eq(20).hide();

			} else if ((YearVal == "5")
					&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
					&& (ThroughUPSEEVal == "2")
					&& (HostelVal == "1")
					&& (FeeWaiverStudentVal == "1")
					&& (val == "2963*General" || val == "2963*OBC"
							|| val == "2963*SC" || val == "2963*ST")) {
				// alert("showHideListBoxOptionsofRNCollegeMessFee -35 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).hide();
				$('#2968 option').eq(2).hide();
				$('#2968 option').eq(3).hide();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).hide();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).hide();
				$('#2968 option').eq(9).hide();
				$('#2968 option').eq(10).show();
				$('#2968 option').eq(11).hide();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).hide();
				$('#2968 option').eq(15).hide();
				$('#2968 option').eq(16).hide();
				$('#2968 option').eq(17).hide();
				$('#2968 option').eq(18).hide();
				$('#2968 option').eq(19).hide();
				$('#2968 option').eq(20).hide();

			} else if ((YearVal == "5")
					&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
					&& (ThroughUPSEEVal == "2")
					&& (HostelVal == "2")
					&& (FeeWaiverStudentVal == "1")
					&& (val == "2963*General" || val == "2963*OBC"
							|| val == "2963*SC" || val == "2963*ST")) {
				// alert("showHideListBoxOptionsofRNCollegeMessFee -36 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).hide();
				$('#2968 option').eq(2).hide();
				$('#2968 option').eq(3).hide();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).hide();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).hide();
				$('#2968 option').eq(9).hide();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).hide();
				$('#2968 option').eq(12).show();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).hide();
				$('#2968 option').eq(15).hide();
				$('#2968 option').eq(16).hide();
				$('#2968 option').eq(17).hide();
				$('#2968 option').eq(18).hide();
				$('#2968 option').eq(19).hide();
				$('#2968 option').eq(20).hide();

			} else if ((YearVal == "1")
					&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
					&& (ThroughUPSEEVal == "1")
					&& (HostelVal == "1" || HostelVal == "2")
					&& (FeeWaiverStudentVal == "2")
					&& (val == "2963*General" || val == "2963*OBC")) {
				// alert("showHideListBoxOptionsofRNCollegeMessFee -37 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).hide();
				$('#2968 option').eq(2).hide();
				$('#2968 option').eq(3).hide();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).hide();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).hide();
				$('#2968 option').eq(9).hide();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).hide();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).show();
				$('#2968 option').eq(15).hide();
				$('#2968 option').eq(16).hide();
				$('#2968 option').eq(17).hide();
				$('#2968 option').eq(18).hide();
				$('#2968 option').eq(19).hide();
				$('#2968 option').eq(20).hide();

			} else if ((YearVal == "1") && (ParentsAnnualIncomeVal == "1")
					&& (ThroughUPSEEVal == "1")
					&& (HostelVal == "1" || HostelVal == "2")
					&& (FeeWaiverStudentVal == "2")
					&& (val == "2963*SC" || val == "2963*ST")) {
				// alert("showHideListBoxOptionsofRNCollegeMessFee -38 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).hide();
				$('#2968 option').eq(2).hide();
				$('#2968 option').eq(3).hide();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).hide();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).hide();
				$('#2968 option').eq(9).hide();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).hide();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).hide();
				$('#2968 option').eq(15).show();
				$('#2968 option').eq(16).hide();
				$('#2968 option').eq(17).hide();
				$('#2968 option').eq(18).hide();
				$('#2968 option').eq(19).hide();
				$('#2968 option').eq(20).hide();

			} else if ((YearVal == "1") && (ParentsAnnualIncomeVal == "2")
					&& (ThroughUPSEEVal == "1")
					&& (HostelVal == "1" || HostelVal == "2")
					&& (FeeWaiverStudentVal == "2")
					&& (val == "2963*SC" || val == "2963*ST")) {
				// alert("showHideListBoxOptionsofRNCollegeMessFee -39 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).show();
				$('#2968 option').eq(2).hide();
				$('#2968 option').eq(3).hide();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).hide();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).hide();
				$('#2968 option').eq(9).hide();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).hide();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).hide();
				$('#2968 option').eq(15).hide();
				$('#2968 option').eq(16).hide();
				$('#2968 option').eq(17).hide();
				$('#2968 option').eq(18).hide();
				$('#2968 option').eq(19).hide();
				$('#2968 option').eq(20).hide();

			} else if ((YearVal == "2")
					&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
					&& (ThroughUPSEEVal == "1")
					&& (HostelVal == "1" || HostelVal == "2")
					&& (FeeWaiverStudentVal == "2")
					&& (val == "2963*General" || val == "2963*OBC")) {
				// alert("showHideListBoxOptionsofRNCollegeMessFee -40 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).hide();
				$('#2968 option').eq(2).hide();
				$('#2968 option').eq(3).hide();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).hide();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).hide();
				$('#2968 option').eq(9).hide();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).hide();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).show();
				$('#2968 option').eq(15).hide();
				$('#2968 option').eq(16).hide();
				$('#2968 option').eq(17).hide();
				$('#2968 option').eq(18).hide();
				$('#2968 option').eq(19).hide();
				$('#2968 option').eq(20).hide();

			} else if ((YearVal == "2") && (ParentsAnnualIncomeVal == "1")
					&& (ThroughUPSEEVal == "1")
					&& (HostelVal == "1" || HostelVal == "2")
					&& (FeeWaiverStudentVal == "2")
					&& (val == "2963*SC" || val == "2963*ST")) {
				// alert("showHideListBoxOptionsofRNCollegeMessFee -41 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).hide();
				$('#2968 option').eq(2).hide();
				$('#2968 option').eq(3).hide();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).hide();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).hide();
				$('#2968 option').eq(9).hide();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).hide();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).hide();
				$('#2968 option').eq(15).show();
				$('#2968 option').eq(16).hide();
				$('#2968 option').eq(17).hide();
				$('#2968 option').eq(18).hide();
				$('#2968 option').eq(19).hide();
				$('#2968 option').eq(20).hide();

			} else if ((YearVal == "2") && (ParentsAnnualIncomeVal == "2")
					&& (ThroughUPSEEVal == "1")
					&& (HostelVal == "1" || HostelVal == "2")
					&& (FeeWaiverStudentVal == "2")
					&& (val == "2963*SC" || val == "2963*ST")) {
				// alert("showHideListBoxOptionsofRNCollegeMessFee -42 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).show();
				$('#2968 option').eq(2).hide();
				$('#2968 option').eq(3).hide();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).hide();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).hide();
				$('#2968 option').eq(9).hide();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).hide();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).hide();
				$('#2968 option').eq(15).hide();
				$('#2968 option').eq(16).hide();
				$('#2968 option').eq(17).hide();
				$('#2968 option').eq(18).hide();
				$('#2968 option').eq(19).hide();
				$('#2968 option').eq(20).hide();

			} else if ((YearVal == "1")
					&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
					&& (ThroughUPSEEVal == "1")
					&& (HostelVal == "1" || HostelVal == "2")
					&& (FeeWaiverStudentVal == "1")
					&& (val == "2963*General" || val == "2963*OBC")) {
				// alert("showHideListBoxOptionsofRNCollegeMessFee -43 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).hide();
				$('#2968 option').eq(2).show();
				$('#2968 option').eq(3).hide();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).hide();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).hide();
				$('#2968 option').eq(9).hide();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).hide();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).hide();
				$('#2968 option').eq(15).hide();
				$('#2968 option').eq(16).hide();
				$('#2968 option').eq(17).hide();
				$('#2968 option').eq(18).hide();
				$('#2968 option').eq(19).hide();
				$('#2968 option').eq(20).hide();

			} else if ((YearVal == "1")
					&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
					&& (ThroughUPSEEVal == "1")
					&& (HostelVal == "1" || HostelVal == "2")
					&& (FeeWaiverStudentVal == "1")
					&& (val == "2963*SC" || val == "2963*ST")) {
				// alert("showHideListBoxOptionsofRNCollegeMessFee -44 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).hide();
				$('#2968 option').eq(2).hide();
				$('#2968 option').eq(3).hide();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).hide();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).show();
				$('#2968 option').eq(9).hide();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).hide();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).hide();
				$('#2968 option').eq(15).hide();
				$('#2968 option').eq(16).hide();
				$('#2968 option').eq(17).hide();
				$('#2968 option').eq(18).hide();
				$('#2968 option').eq(19).hide();
				$('#2968 option').eq(20).hide();

			} else if ((YearVal == "2")
					&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
					&& (ThroughUPSEEVal == "1")
					&& (HostelVal == "1" || HostelVal == "2")
					&& (FeeWaiverStudentVal == "1")
					&& (val == "2963*General" || val == "2963*OBC")) {
				// alert("showHideListBoxOptionsofRNCollegeMessFee -45 >>
				// "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+",
				// ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal -
				// "+HostelVal+", FeeWaiverStudentVal -
				// "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).hide();
				$('#2968 option').eq(2).show();
				$('#2968 option').eq(3).hide();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).hide();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).hide();
				$('#2968 option').eq(9).hide();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).hide();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).hide();
				$('#2968 option').eq(15).hide();
				$('#2968 option').eq(16).hide();
				$('#2968 option').eq(17).hide();
				$('#2968 option').eq(18).hide();
				$('#2968 option').eq(19).hide();
				$('#2968 option').eq(20).hide();

			} else if ((YearVal == "2")
					&& (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2")
					&& (ThroughUPSEEVal == "1")
					&& (HostelVal == "1" || HostelVal == "2")
					&& (FeeWaiverStudentVal == "1")
					&& (val == "2963*SC" || val == "2963*ST")) {
				//alert("showHideListBoxOptionsofRNCollegeMessFee -46 >> "+ParentsAnnualIncomeVal +", YearVal - "+YearVal+", ThroughUPSEEVal - "+ThroughUPSEEVal+", HostelVal - "+HostelVal+", FeeWaiverStudentVal - "+FeeWaiverStudentVal+"");
				document.getElementById("2968").selectedIndex = 0;
				$('#2968 option').eq(1).hide();
				$('#2968 option').eq(2).hide();
				$('#2968 option').eq(3).hide();
				$('#2968 option').eq(4).hide();
				$('#2968 option').eq(5).hide();
				$('#2968 option').eq(6).hide();
				$('#2968 option').eq(7).hide();
				$('#2968 option').eq(8).show();
				$('#2968 option').eq(9).hide();
				$('#2968 option').eq(10).hide();
				$('#2968 option').eq(11).hide();
				$('#2968 option').eq(12).hide();
				$('#2968 option').eq(13).hide();
				$('#2968 option').eq(14).hide();
				$('#2968 option').eq(15).hide();
				$('#2968 option').eq(16).hide();
				$('#2968 option').eq(17).hide();
				$('#2968 option').eq(18).hide();
				$('#2968 option').eq(19).hide();
				$('#2968 option').eq(20).hide();
			}
		}
	}
}

////++++++++++++-------RECUP COLLEGE FEE FORM VALIDATION WORK END 17 July------------++++++++++/////

////++++++++++++-------RECUP COLLEGE MESS FEE VALIDATION WORK Start 17 July 2019------------++++++++++/////

function showHideListBoxOptionsofRECUPCollegeMessFee(form_value) {
	//alert("showHideListBoxOptionsofRECUPCollegeMessFee -1");
	var val = form_value;
	if ((val.indexOf("2935*I") != '-1' || val.indexOf("2935*II") != '-1' || val
			.indexOf("2935*III") != '-1')
			|| val.indexOf("2935*IV") != '-1') {
		var GenderVal = document.getElementById("2940").selectedIndex;
		var EntryVal = document.getElementById("2937").selectedIndex;
		//alert("showHideListBoxOptionsofRECUPCollegeMessFee -2 >> "+GenderVal +", EntryVal - "+EntryVal+"");
		if (val == 0) {
			//alert("showHideListBoxOptionsofRECUPCollegeMessFee -3 >> "+GenderVal);
			document.getElementById("2935").selectedIndex = 0;
			document.getElementById("2935").focus();
			return false;
		} else {
			//alert("showHideListBoxOptionsofRECUPCollegeMessFee -4 >> "+GenderVal +", EntryVal - "+EntryVal+"");
			if ((val == "2935*I") && (EntryVal == "1" || EntryVal == "2")
					&& (GenderVal == "1")) {
				a//lert("showHideListBoxOptionsofRECUPCollegeMessFee -5 >>"+GenderVal +", EntryVal - "+EntryVal+"");
				document.getElementById("2948").selectedIndex = 0;
				$('#2948 option').eq(1).hide();
				$('#2948 option').eq(2).show();
				$('#2948 option').eq(3).hide();

			}
			if ((val == "2935*III") && (EntryVal == "1" || EntryVal == "2")
					&& (GenderVal == "1")) {
				//alert("showHideListBoxOptionsofRECUPCollegeMessFee -6 >>"+GenderVal +", EntryVal - "+EntryVal+"");
				document.getElementById("2948").selectedIndex = 0;
				$('#2948 option').eq(1).hide();
				$('#2948 option').eq(2).hide();
				$('#2948 option').eq(3).show();

			}
			if ((val == "2935*II") && (EntryVal == "1") && (GenderVal == "1")) {
				//alert("showHideListBoxOptionsofRECUPCollegeMessFee -7 >>"+GenderVal +", EntryVal - "+EntryVal+"");
				document.getElementById("2948").selectedIndex = 0;
				$('#2948 option').eq(1).hide();
				$('#2948 option').eq(2).show();
				$('#2948 option').eq(3).hide();

			} else if ((val == "2935*II") && (EntryVal == "2")
					&& (GenderVal == "1")) {
				//alert("showHideListBoxOptionsofRECUPCollegeMessFee -8 >>"+GenderVal +", EntryVal - "+EntryVal+"");
				document.getElementById("2948").selectedIndex = 0;
				$('#2948 option').eq(1).hide();
				$('#2948 option').eq(2).hide();
				$('#2948 option').eq(3).show();

			} else if ((val == "2935*IV") && (EntryVal == "2")
					&& (GenderVal == "1")) {
				//alert("showHideListBoxOptionsofRECUPCollegeMessFee -9 >>"+GenderVal +", EntryVal - "+EntryVal+"");
				document.getElementById("2948").selectedIndex = 0;
				$('#2948 option').eq(1).hide();
				$('#2948 option').eq(2).show();
				$('#2948 option').eq(3).hide();

			} else if ((val == "2935*IV") && (EntryVal == "1")
					&& (GenderVal == "1")) {
				//alert("showHideListBoxOptionsofRECUPCollegeMessFee -10 >>"+GenderVal +", EntryVal - "+EntryVal+"");
				document.getElementById("2948").selectedIndex = 0;
				$('#2948 option').eq(1).hide();
				$('#2948 option').eq(2).hide();
				$('#2948 option').eq(3).show();

			} else if ((val == "2935*I" || val == "2935*II"
					|| val == "2935*III" || val == "2935*IV")
					&& (EntryVal == "1" || EntryVal == "2")
					&& (GenderVal == "2")) {
				//alert("showHideListBoxOptionsofRECUPCollegeMessFee -11 >>"+GenderVal +", EntryVal - "+EntryVal+"");
				document.getElementById("2948").selectedIndex = 0;
				$('#2948 option').eq(1).show();
				$('#2948 option').eq(2).hide();
				$('#2948 option').eq(3).hide();
			}
		}
	}
}

////++++++++++++-------RECUP COLLEGE MESS FEE VALIDATION WORK END 17 July 2019------------++++++++++/////

