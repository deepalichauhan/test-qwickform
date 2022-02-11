/**
 * s675 = 0; s678 = 0; s676 = 0; s679 = 0; s667 = 0; s669 = 0; s671 = 0;
 * 
 * ss759 762 765 767 769 770 771
 */

function showHideAmountOptionForVocationalForm(form_value){
	alert("uploadNOCFileWhenSponsoredIsYes -1 "+form_value);
    	alert("uploadNOCFileWhenSponsoredIsYes -1 "+form_value.indexOf("8*Male"));
}

// Start NHSSN form Online Fee Form for New Student 02 July 2019
function showHideAmountOptionsofHNSSNOnlineFeeForm(form_value)
{
       	//alert("showHideAmountOptionsofHNSSNOnlineFeeForm -1 "+form_value);
    	//alert("showHideAmountOptionsofHNSSNOnlineFeeForm -1 "+form_value.indexOf("2382*General"));
        var formVal=form_value;

        if(formVal.indexOf("2382*General")!='-1' ||formVal.indexOf("2382*OBC")!='-1' ||formVal.indexOf("2382*SEBC")!='-1' 
		||formVal.indexOf("2382*SC")!='-1' ||formVal.indexOf("2382*ST")!='-1')
	{
		var GenderVal=$("#2373").val();
		var streamVal=$("#2385").val();

                if((formVal=="2382*General" ||formVal=="2382*OBC") && GenderVal=="2373*Male" && streamVal=="2385*Arts" )
                {
			//alert("Gen-OBC-Male-Arts-4780")
                        document.getElementById("2371").selectedIndex=0;
                        $('#2371 option').eq(1).show();		                     $('#2371 option').eq(2).hide();
			$('#2371 option').eq(3).hide();		                     $('#2371 option').eq(4).hide();

                }if((formVal=="2382*General" ||formVal=="2382*OBC") && GenderVal=="2373*Male" && streamVal=="2385*Commerce" )
                {
			//alert("Gen-OBC-Male-Commerce-4780")
                        document.getElementById("2371").selectedIndex=0;
                        $('#2371 option').eq(1).show();		                     $('#2371 option').eq(2).hide();
			$('#2371 option').eq(3).hide();		                     $('#2371 option').eq(4).hide();

                }if((formVal=="2382*General" ||formVal=="2382*OBC") && GenderVal=="2373*Male" && streamVal=="2385*Science" )
                {
			//alert("Gen-OBC-Male-Science-5423")
                        document.getElementById("2371").selectedIndex=0;
                        $('#2371 option').eq(1).hide();		                     $('#2371 option').eq(2).hide();
			$('#2371 option').eq(3).show();		                     $('#2371 option').eq(4).hide();
                }if((formVal=="2382*SC" ||formVal=="2382*ST") && GenderVal=="2373*Male" && (streamVal=="2385*Arts" || streamVal=="2385*Commerce"))
                {
			//alert("SC-ST-Male-Arts-Commerce-4684")
                        document.getElementById("2371").selectedIndex=0;
                        $('#2371 option').eq(1).hide();		                     $('#2371 option').eq(2).show();
			$('#2371 option').eq(3).hide();		                     $('#2371 option').eq(4).hide();
                }if((formVal=="2382*SC" ||formVal=="2382*ST") && GenderVal=="2373*Male" && streamVal=="2385*Science")
                {
			//alert("SC-ST-Male-Science-5315")
                        document.getElementById("2371").selectedIndex=0;
                        $('#2371 option').eq(1).hide();		                     $('#2371 option').eq(2).hide();
			$('#2371 option').eq(3).hide();		                     $('#2371 option').eq(4).show();
                }if((formVal=="2382*General" ||formVal=="2382*OBC" ||formVal=="2382*SC" ||formVal=="2382*ST") 
			&& GenderVal=="2373*Female" && (streamVal=="2385*Arts" ||streamVal=="2385*Commerce"))
                {
			//alert("Gen-OBC-SC-ST-Female-Arts-Commerce-4684")
                        document.getElementById("2371").selectedIndex=0;
                        $('#2371 option').eq(1).hide();		                     $('#2371 option').eq(2).show();
			$('#2371 option').eq(3).hide();		                     $('#2371 option').eq(4).hide();
                }if((formVal=="2382*General" ||formVal=="2382*OBC" ||formVal=="2382*SC" ||formVal=="2382*ST") 
			&& GenderVal=="2373*Female" && streamVal=="2385*Science")
                {
			//alert("Gen-OBC-SC-ST-Female-Science-5315")
                        document.getElementById("2371").selectedIndex=0;
                        $('#2371 option').eq(1).hide();		                     $('#2371 option').eq(2).hide();
			$('#2371 option').eq(3).hide();		                     $('#2371 option').eq(4).show();
                }
           }
}

// End NHSSN form Online Fee Form for New Student 

// Start PDPMJ form Mess Fee Advance for New Student 01 July 2019
function showHideAmountOptionsofPDPMJMessFeeAdvForm(form_value)
{
        //alert("Inside RECUPIncomeMoreThan2Lakh");
        var val=form_value;
        if(val.indexOf("2413*B.Tech")!='-1' ||val.indexOf("2413*B.Des")!='-1' ||val.indexOf("2413*M.Tech")!='-1' 
		||val.indexOf("2413*M.Des")!='-1' ||val.indexOf("2413*PHD")!='-1')
         {
                if(val=="2413*B.Tech" ||val=="2413*B.Des" )
                {
                        document.getElementById("2405").selectedIndex=0;
                        $('#2405 option').eq(1).show();
                        $('#2405 option').eq(2).hide();

                }
                else if(val=="2413*M.Tech" ||val=="2413*M.Des" ||val=="2413*PHD" )
                {
                        $('#2405 option').eq(1).hide();
                        $('#2405 option').eq(2).show();
                }
           }
}

// End PDPMJ form Mess Fee Advance for New Student 
