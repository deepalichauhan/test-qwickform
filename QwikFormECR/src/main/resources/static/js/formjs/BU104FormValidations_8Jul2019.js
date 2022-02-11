/**
 * s675 = 0; s678 = 0; s676 = 0; s679 = 0; s667 = 0; s669 = 0; s671 = 0;
 * 
 * ss759 762 765 767 769 770 771
 */


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