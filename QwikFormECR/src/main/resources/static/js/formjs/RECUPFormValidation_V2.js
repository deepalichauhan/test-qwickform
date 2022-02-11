////++++++++++++-------RECUP COLLEGE FEE FORM VALIDATION WORK START------------++++++++++/////

function showHideListBoxOptionsofRAJKIYARECUPCollegeFeeForm(form_value) {
	alert("showHideListBoxOptionsofRAJKIYARECUPCollegeFeeForm -1");
	var formVal=form_value;
	if ((formVal.indexOf("12272*Yes")!= '-1'||formVal.indexOf("12272*No")!='-1')) {
		var CategoryVal = document.getElementById("12258").selectedIndex;
		var ParentsAnnualIncomeVal = document.getElementById("12271").selectedIndex;
		alert("showHideListBoxOptionsofRAJKIYARECUPCollegeFeeForm -2 >> "+ CategoryVal +", ParentsAnnualIncomeVal - "+ParentsAnnualIncomeVal+"");
		if (CategoryVal == 0) {
			alert("showHideListBoxOptionsofRAJKIYARECUPCollegeFeeForm -3 >> "+CategoryVal);
			document.getElementById("12258").selectedIndex = 0;
			document.getElementById("12272").focus();
			return false;
		} else {
			alert("showHideListBoxOptionsofRAJKIYARECUPCollegeFeeForm -4 >> "+ CategoryVal +", ParentsAnnualIncomeVal - "+ParentsAnnualIncomeVal+"");
			if ((CategoryVal == "1" || CategoryVal == "2") && (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2") && (formVal == "12272*Yes")) {
				alert("showHideListBoxOptionsofRAJKIYARECUPCollegeFeeForm -5 >> "+ CategoryVal +", ParentsAnnualIncomeVal - "+ParentsAnnualIncomeVal+"");
				document.getElementById("12268").selectedIndex = 0;
				$('#12268 option').eq(1).hide();
				$('#12268 option').eq(2).hide();
				$('#12268 option').eq(3).hide();
				$('#12268 option').eq(4).show();

			}
			if ((CategoryVal == "3" || CategoryVal == "4") && (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2") && (formVal == "12272*Yes")) {
				alert("showHideListBoxOptionsofRAJKIYARECUPCollegeFeeForm -6 >> "+ CategoryVal +", ParentsAnnualIncomeVal - "+ParentsAnnualIncomeVal+"");
				document.getElementById("12268").selectedIndex = 0;
				$('#12268 option').eq(1).show();
				$('#12268 option').eq(2).hide();
				$('#12268 option').eq(3).hide();
				$('#12268 option').eq(4).hide();

			}
			if ((CategoryVal == "1" || CategoryVal == "2") && (ParentsAnnualIncomeVal == "1" || ParentsAnnualIncomeVal == "2") && (formVal == "12272*No")) {
				alert("showHideListBoxOptionsofRAJKIYARECUPCollegeFeeForm -7 >> "+ CategoryVal +", ParentsAnnualIncomeVal - "+ParentsAnnualIncomeVal+"");
				document.getElementById("12268").selectedIndex = 0;
				$('#12268 option').eq(1).hide();
				$('#12268 option').eq(2).show();
				$('#12268 option').eq(3).hide();
				$('#12268 option').eq(4).hide();

			} else if ((CategoryVal == "3" || CategoryVal == "4") && (ParentsAnnualIncomeVal == "1") && (formVal == "12272*No")) {
				alert("showHideListBoxOptionsofRAJKIYARECUPCollegeFeeForm -8 >> "+ CategoryVal +", ParentsAnnualIncomeVal - "+ParentsAnnualIncomeVal+"");
				document.getElementById("12268").selectedIndex = 0;
				$('#12268 option').eq(1).hide();
				$('#12268 option').eq(2).hide();
				$('#12268 option').eq(3).show();
				$('#12268 option').eq(4).hide();

			} else if ((CategoryVal == "3" || CategoryVal == "4") && (ParentsAnnualIncomeVal == "2") && (formVal == "12272*No")) {
				alert("showHideListBoxOptionsofRAJKIYARECUPCollegeFeeForm -9 >> "+ CategoryVal +", ParentsAnnualIncomeVal - "+ParentsAnnualIncomeVal+"");
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
