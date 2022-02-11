/**
 * s675 = 0; s678 = 0; s676 = 0; s679 = 0; s667 = 0; s669 = 0; s671 = 0;
 * 
 * ss759 762 765 767 769 770 771
 */

function showHideAmountOptionForVocationalForm(form_value){
	alert("uploadNOCFileWhenSponsoredIsYes -1 "+form_value);
    alert("uploadNOCFileWhenSponsoredIsYes -1 "+form_value.indexOf("8*Male"));
}

//Start BU104 form Foreign National Candidate Online Fee Form for New Student 08 July 2019

function showHideAmountOptionsofBU104LLMOnlineFeeForm(form_value){
	alert("showHideAmountOptionsofBU104LLMOnlineFeeForm -1 "+form_value);
    	alert("showHideAmountOptionsofBU104LLMOnlineFeeForm -1 "+form_value.indexOf("2774*I"));
        var formVal=form_value;

        if(formVal.indexOf("1137*BU Campus")!='-1' ||formVal.indexOf("1137*BU2 Campus")!='-1'){
			if(formVal=="1137*BU Campus"){
				alert("I-II-III-MCA-10000");
	                        document.getElementById("1136").selectedIndex=0;
	                        $('#1136 option').eq(1).show();		                     $('#1136 option').eq(2).hide();
			}if(formVal=="1137*BU2 Campus"){
				alert("I-II-MBA-Exe-IB-MHRM-10000");
				document.getElementById("1136").selectedIndex=0;
                $('#1136 option').eq(1).hide();		                     $('#1136 option').eq(2).show();
			}
	}
}
//Start BU104 form Foreign National Candidate Online Fee Form for New Student 08 July 2019

//Start BU104 form Foreign National Candidate Online Fee Form for New Student 08 July 2019

function showHideAmountOptionsofBU104LLMOnlineFeeForm(form_value){
	alert("showHideAmountOptionsofBU104LLMOnlineFeeForm -1 "+form_value);
    	alert("showHideAmountOptionsofBU104LLMOnlineFeeForm -1 "+form_value.indexOf("3029*BU Campus"));
        var formVal=form_value;

        if(formVal.indexOf("3029*BU Campus")!='-1' ||formVal.indexOf("3029*Hoohgly Mohsin College")!='-1'){
			if(formVal=="3029*BU Campus"){
				alert("I-II-III-MCA-10000[[[[[[[[[[[[");
	                        document.getElementById("3033").selectedIndex=0;
	                        document.getElementById("3026").value='Arvind';
	                        $('#3033 option').eq(1).show();		                     
	                        $('#3033 option').eq(2).hide();
			}
			if(formVal=="3029*Hoohgly Mohsin College"){
				alert("I-II-MBA-Exe-IB-MHRM-10000");
				document.getElementById("3033").selectedIndex=0;
                $('#3033 option').eq(1).hide();		                     
                $('#3033 option').eq(2).show();
			}
	}
}
//Start BU104 form Foreign National Candidate Online Fee Form for New Student 08 July 2019

//Start BU105
function uploadNOCFileWhenSponsoredIsYes(form_value){
	//alert("uploadNOCFileWhenSponsoredIsYes -1 "+form_value);
    //alert("uploadNOCFileWhenSponsoredIsYes -1 "+form_value.indexOf("1762*Yes"));
	var formVal=form_value;	
	if(formVal.indexOf("1762*Yes")!='-1' || formVal.indexOf("1762*No")!='-1'){
		//alert("Sponsored field Value is Selected 1"+formVal);
		if(formVal=="1762*Yes"){
			//alert("In if block Gate field Value is Selected 1"+elements[i].value);
			alert("You select Sponsored is Yes, So Please upload your NOC Mentioning Experience Certificate");
			sponsoredValue=formVal;
		}else if(formVal=="1762*No"){
			alert("NOC Mentioning Experience Certificate is Not Mendetory");
			sponsoredValue=formVal;
			//alert("gateValue variable result is 1 "+sponsoredValue);
		}
	}else{
		alert("Please select any one option in Sponsored.");
		return false;
	}
}
//END BU105

//Start BU105 form M Tech Process 25 June 2019
function uploadNOCFileWhenSponsoredIsYes1(form_value){
	//alert("uploadNOCFileWhenSponsoredIsYes -1 "+form_value);
    //alert("uploadNOCFileWhenSponsoredIsYes -1 "+form_value.indexOf("1762*Yes"));
	var formVal=form_value;	
	if(formVal.indexOf("1762*Yes")!='-1' || formVal.indexOf("1762*No")!='-1'){
		//alert("Sponsored field Value is Selected 1"+formVal);
		if(formVal=="1762*Yes"){
			//alert("In if block Gate field Value is Selected 1"+elements[i].value);
			alert("You select Sponsored is Yes, So Please upload your NOC Mentioning Experience Certificate");
			sponsoredValue=formVal;
		}else if(formVal=="1762*No"){
			alert("NOC Mentioning Experience Certificate is Not Mendetory");
			sponsoredValue=formVal;
			//alert("gateValue variable result is 1 "+sponsoredValue);
		}
	}else{
		alert("Please select any one option in Sponsored.");
		return false;
	}
}
//END BU105 form M Tech Process

//Start BU105 form M Phill Process 4 July 2019
function showHideSubjectOptionsofMPhillPhdOnlineForm(form_value){
	//alert("showHideSubjectOptionsofMPhillPhdOnlineForm -1 "+form_value);
	//alert("showHideSubjectOptionsofMPhillPhdOnlineForm -1 "+form_value.indexOf("2475*Ph D"));
	var formVal=form_value;	
	if(formVal.indexOf("2475*Ph D")!='-1' || formVal.indexOf("2475*M Phil")!='-1' || formVal.indexOf("2475*Both")!='-1'){
		//alert("Sponsored field Value is Selected 1"+formVal);
		if(formVal=="2475*Ph D"){
		    //alert("2475*Ph D"+formVal);
		    document.getElementById("2504").selectedIndex=0;
                    $('#2504 option').eq(1).show(); 		$('#2504 option').eq(2).show();		$('#2504 option').eq(3).show();
		    $('#2504 option').eq(4).show();             $('#2504 option').eq(5).show();		$('#2504 option').eq(6).show();
     		    $('#2504 option').eq(7).show();		$('#2504 option').eq(8).show();		$('#2504 option').eq(9).hide();
                    $('#2504 option').eq(10).show();		$('#2504 option').eq(11).show();	$('#2504 option').eq(12).show();
                    $('#2504 option').eq(13).show();		$('#2504 option').eq(14).show();	$('#2504 option').eq(15).show();
		    $('#2504 option').eq(16).hide();		$('#2504 option').eq(17).hide();
		}if(formVal=="2475*M Phil"){
		    //alert("2475*M Phil"+formVal);
		    document.getElementById("2504").selectedIndex=0;
                    $('#2504 option').eq(1).show(); 		$('#2504 option').eq(2).show();		$('#2504 option').eq(3).show();
		    $('#2504 option').eq(4).show();             $('#2504 option').eq(5).show();		$('#2504 option').eq(6).show();
     		    $('#2504 option').eq(7).show();		$('#2504 option').eq(8).hide();		$('#2504 option').eq(9).show();
                    $('#2504 option').eq(10).hide();		$('#2504 option').eq(11).hide();	$('#2504 option').eq(12).hide();
                    $('#2504 option').eq(13).hide();		$('#2504 option').eq(14).hide();	$('#2504 option').eq(15).hide();
		    $('#2504 option').eq(16).show();		$('#2504 option').eq(17).show();
		}if(formVal=="2475*Both"){
		    //alert("2475*Both"+formVal);
		    document.getElementById("2504").selectedIndex=0;
                    $('#2504 option').eq(1).show(); 		$('#2504 option').eq(2).show();		$('#2504 option').eq(3).show();
		    $('#2504 option').eq(4).show();             $('#2504 option').eq(5).show();		$('#2504 option').eq(6).show();
     		    $('#2504 option').eq(7).show();		$('#2504 option').eq(8).hide();		$('#2504 option').eq(9).hide();
                    $('#2504 option').eq(10).hide();		$('#2504 option').eq(11).hide();	$('#2504 option').eq(12).hide();
                    $('#2504 option').eq(13).hide();		$('#2504 option').eq(14).hide();	$('#2504 option').eq(15).hide();
		    $('#2504 option').eq(16).hide();		$('#2504 option').eq(17).hide();
		}
	}
}
//END BU105 form M Tech Process


////++++++++++++-------GOC01 WORK Start------------++++++++++/////

function showHideListBoxOptionsofGOC01ForCourse(form_value)
{
	alert("inside showHideListBoxOptionsofGOC01ForCourse "+form_value);
	var formVal=form_value;
}

////++++++++++++-------GOC01 WORK End------------++++++++++/////