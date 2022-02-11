////++++++++++++-------RECUP COLLEGE FEE FORM VALIDATION WORK START------------++++++++++/////

function showHideListBoxOptionsofRAJKIYARECUPCollegeFeeForm(form_value) {
	//alert("showHideListBoxOptionsofRAJKIYARECUPCollegeFeeForm -1");
	var formVal=form_value;
	if ((formVal.indexOf("12272*Yes")!='-1'||formVal.indexOf("12272*No")!='-1')) {
		var ParentsAnnualIncomeVal = document.getElementById("12271").selectedIndex;
		var CategoryVal = document.getElementById("12258").selectedIndex;
		//alert("showHideListBoxOptionsofRAJKIYARECUPCollegeFeeForm -2 >> "+ ParentsAnnualIncomeVal +", CategoryVal - "+CategoryVal+"");
		if (ParentsAnnualIncomeVal == 0) {
			//alert("showHideListBoxOptionsofRAJKIYARECUPCollegeFeeForm -3 >> "+ParentsAnnualIncomeVal);
			document.getElementById("12271").selectedIndex = 0;
			document.getElementById("12272").focus();
			return false;
		} else {
			//alert("showHideListBoxOptionsofRAJKIYARECUPCollegeFeeForm -4 >> "+ParentsAnnualIncomeVal +", CategoryVal - "+CategoryVal+"");
			if ((formVal == "12272*Yes") && (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2") && (CategoryVal == "1" || CategoryVal == "2")) {
				//alert("showHideListBoxOptionsofRAJKIYARECUPCollegeFeeForm -5 >>"+ParentsAnnualIncomeVal +", CategoryVal - "+CategoryVal+"");
				document.getElementById("12268").selectedIndex = 0;
				$('#12268 option').eq(1).hide();
				$('#12268 option').eq(2).hide();
				$('#12268 option').eq(3).hide();
				$('#12268 option').eq(4).show();

			}
			if ((formVal == "12272*Yes") && (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2") && (CategoryVal == "3" || CategoryVal == "4")) {
				//alert("showHideListBoxOptionsofRAJKIYARECUPCollegeFeeForm -6 >>"+ParentsAnnualIncomeVal +", CategoryVal - "+CategoryVal+"");
				document.getElementById("12268").selectedIndex = 0;
				$('#12268 option').eq(1).show();
				$('#12268 option').eq(2).hide();
				$('#12268 option').eq(3).hide();
				$('#12268 option').eq(4).hide();

			}
			if ((formVal == "12272*No") && (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2") && (CategoryVal == "1" || CategoryVal == "2")) {
				//alert("showHideListBoxOptionsofRAJKIYARECUPCollegeFeeForm -7 >>"+ParentsAnnualIncomeVal +", CategoryVal - "+CategoryVal+"");
				document.getElementById("12268").selectedIndex = 0;
				$('#12268 option').eq(1).hide();
				$('#12268 option').eq(2).show();
				$('#12268 option').eq(3).hide();
				$('#12268 option').eq(4).hide();

			} else if ((formVal == "12272*No") && (ParentsAnnualIncomeVal == "1") && (CategoryVal == "3" || CategoryVal == "4")) {
				//alert("showHideListBoxOptionsofRAJKIYARECUPCollegeFeeForm -8 >>"+ParentsAnnualIncomeVal +", CategoryVal - "+CategoryVal+"");
				document.getElementById("12268").selectedIndex = 0;
				$('#12268 option').eq(1).hide();
				$('#12268 option').eq(2).hide();
				$('#12268 option').eq(3).show();
				$('#12268 option').eq(4).hide();

			} else if ((formVal == "12272*No") && (ParentsAnnualIncomeVal == "2") && (CategoryVal == "3" || CategoryVal == "4")) {
				//alert("showHideListBoxOptionsofRAJKIYARECUPCollegeFeeForm -9 >>"+ParentsAnnualIncomeVal +", CategoryVal - "+CategoryVal+"");
				document.getElementById("12268").selectedIndex = 0;
				$('#12268 option').eq(1).hide();
				$('#12268 option').eq(2).hide();
				$('#12268 option').eq(3).hide();
				$('#12268 option').eq(4).show();

			}
		}
	}
}

////++++++++++++-------RECUP COLLEGE FEE FORM VALIDATION WORK END------------++++++++++/////
