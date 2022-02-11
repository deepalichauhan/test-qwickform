function showHideListBoxOptionsofTNBCollegeAdmissionOnlineFeeForm(form_value) {
//	alert("showHideListBoxOptionsofTNBCollegeAdmissionOnlineFeeForm -1");
	var val = form_value;
	if ((val.indexOf("10801*More than 1 Lakhs") != '-1' || val.indexOf("10801*Less Than 1 Lakhs") != '-1')) {
  //             alert("showHideListBoxOptionsofTNBCollegeAdmissionOnlineFeeForm -20 >> ");
		
		var CourseVal = document.getElementById("10810").selectedIndex;
		var CategoryVal = document.getElementById("10791").selectedIndex;
	//	alert("showHideListBoxOptionsofTNBCollegeAdmissionOnlineFeeForm -2 >> " + CourseVal + ", CategoryVal - " + CategoryVal + "");
		if (CourseVal == 0) {
				alert("Please select any one course >> "+ CourseVal);
				document.getElementById("10810").selectedIndex = 0;
				document.getElementById("10791").focus();
				return false;
		}else {
	//		alert("showHideListBoxOptionsofTNBCollegeAdmissionOnlineFeeForm -3 >> CourseVal - "+ CourseVal + ", CategoryVal - " + CategoryVal + ":");
			
			if((CourseVal == "1") && (CategoryVal == "1" || CategoryVal == "2" || CategoryVal == "5") && (val == "10801*More than 1 Lakhs" || val == "10801*Less Than 1 Lakhs")){
	//			alert("showHideListBoxOptionsofTNBCollegeAdmissionOnlineFeeForm -4 >> "+ CourseVal+" ::: "+val);
				//document.getElementById("10785").selectedIndex = 0;
                                document.getElementById("10785").value=972;
				
			}
			if((CourseVal == "2") && (CategoryVal == "1" || CategoryVal == "2" || CategoryVal == "5") && (val == "10801*More than 1 Lakhs" || val == "10801*Less Than 1 Lakhs")){
	//			alert("showHideListBoxOptionsofTNBCollegeAdmissionOnlineFeeForm -5 >> "+ CourseVal+" ::: "+val);
				//document.getElementById("10785").selectedIndex = 0;
                                document.getElementById("10785").value=960;
				
			}
			if((CourseVal == "3") && (CategoryVal == "1" || CategoryVal == "2" || CategoryVal == "5") && (val == "10801*More than 1 Lakhs" || val == "10801*Less Than 1 Lakhs")){
	//			alert("showHideListBoxOptionsofTNBCollegeAdmissionOnlineFeeForm -6 >> "+ CourseVal+" ::: "+val);
				//document.getElementById("10785").selectedIndex = 0;
                                document.getElementById("10785").value=897;
				
			}
			else if((CourseVal == "1" || CourseVal == "2") && (CategoryVal == "3" || CategoryVal == "4") && (val == "10801*More than 1 Lakhs" || val == "10801*Less Than 1 Lakhs")){
	//			alert("showHideListBoxOptionsofTNBCollegeAdmissionOnlineFeeForm -7 >> "+ CourseVal+" ::: "+val);
				//document.getElementById("10785").selectedIndex = 0;
                                document.getElementById("10785").value=828;
				
			}
			else if((CourseVal == "3") && (CategoryVal == "3" || CategoryVal == "4") && (val == "10801*More than 1 Lakhs" || val == "10801*Less Than 1 Lakhs")){
	//			alert("showHideListBoxOptionsofTNBCollegeAdmissionOnlineFeeForm -8 >> "+ CourseVal+" ::: "+val);
				//document.getElementById("10785").selectedIndex = 0;
                                document.getElementById("10785").value=777;
				
			}
			else if((CourseVal == "1") && (CategoryVal == "6") && (val == "10801*More than 1 Lakhs")){
	//			alert("showHideListBoxOptionsofTNBCollegeAdmissionOnlineFeeForm -9 >> "+ CourseVal+" ::: "+val);
				//document.getElementById("10785").selectedIndex = 0;
				document.getElementById("10785").value=972;
			}
			else if((CourseVal == "2") && (CategoryVal == "6") && (val == "10801*More than 1 Lakhs")){
	//			alert("showHideListBoxOptionsofTNBCollegeAdmissionOnlineFeeForm -10 >> "+ CourseVal+" ::: "+val);
				//document.getElementById("10785").selectedIndex = 0;
				document.getElementById("10785").value=960;
			}
			else if((CourseVal == "3") && (CategoryVal == "6") && (val == "10801*More than 1 Lakhs")){
	//			alert("showHideListBoxOptionsofTNBCollegeAdmissionOnlineFeeForm -11 >> "+ CourseVal+" ::: "+val);
				//document.getElementById("10785").selectedIndex = 0;
				document.getElementById("10785").value=897;
			}
			else if((CourseVal == "1" || CourseVal == "2") && (CategoryVal == "6") && (val == "10801*Less Than 1 Lakhs")){
	//			alert("showHideListBoxOptionsofTNBCollegeAdmissionOnlineFeeForm -12 >> "+ CourseVal+" ::: "+val);
				//document.getElementById("10785").selectedIndex = 0;
				document.getElementById("10785").value=828;
			}
			else if((CourseVal == "3") && (CategoryVal == "6") && (val == "10801*Less Than 1 Lakhs")){
	//			alert("showHideListBoxOptionsofTNBCollegeAdmissionOnlineFeeForm -13 >> "+ CourseVal+" ::: "+val);
				//document.getElementById("10785").selectedIndex = 0;
				document.getElementById("10785").value=777;
			}
		}	
	}
}
