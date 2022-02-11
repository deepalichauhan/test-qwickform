/**
 * s675 = 0; s678 = 0; s676 = 0; s679 = 0; s667 = 0; s669 = 0; s671 = 0;
 * 
 * ss759 762 765 767 769 770 771
 */

function showHideAmountOptionForVocationalForm(form_value){
	alert("uploadNOCFileWhenSponsoredIsYes -1 "+form_value);
    	alert("uploadNOCFileWhenSponsoredIsYes -1 "+form_value.indexOf("8*Male"));
}

//Start LNM01 form Foreign National Candidate Online Fee Form for New Student 08 July 2019

function showHideAmountOptionsofLNMO1MCAMBAMHRMForFNCODevelopmentFee(form_value){
	//alert("showHideAmountOptionsofLNMO1MCAMBAMHRMForFNCODevelopmentFee -1 "+form_value);
    	//alert("showHideAmountOptionsofLNMO1MCAMBAMHRMForFNCODevelopmentFee -1 "+form_value.indexOf("2774*I"));
        var formVal=form_value;

        if(formVal.indexOf("2774*I")!='-1' ||formVal.indexOf("2774*II")!='-1' ||formVal.indexOf("2774*III")!='-1'){
		var courVal=$("#2770").val();
		
		if(( formVal=="2774*I" ||formVal=="2774*II" ||formVal=="2774*III") && courVal=="2770*MCA"){
			//alert("I-II-III-MCA-10000");
                        document.getElementById("2778").selectedIndex=0;
                        $('#2778 option').eq(1).show();		                     $('#2778 option').eq(2).hide();
		}if(( formVal=="2774*I" ||formVal=="2774*II") && (courVal=="2770*MBA" ||courVal=="2770*MBA-Exe" ||courVal=="2770*MBA(IB)" || courVal=="2770*MHRM")){
			//alert("I-II-MBA-Exe-IB-MHRM-10000");
                        document.getElementById("2778").selectedIndex=0;
                        $('#2778 option').eq(1).show();		                     $('#2778 option').eq(2).hide();
		}if(formVal=="2774*III" && (courVal=="2770*MBA" ||courVal=="2770*MBA-Exe" ||courVal=="2770*MBA(IB)" || courVal=="2770*MHRM")){
			//alert("III-MBA-Exe-IB-MHRM-Not Applicable");
                        document.getElementById("2778").selectedIndex=0;
                        $('#2778 option').eq(1).hide();		                     $('#2778 option').eq(2).show();
		}
	}
}

function showHideAmountOptionsofLNMO1MCAMBAMHRMForFNCOFormPayableFee(form_value)
{
       	//alert("showHideAmountOptionsofLNMO1MCAMBAMHRMForFNCOFormPayableFee -1 "+form_value);
    	//alert("showHideAmountOptionsofLNMO1MCAMBAMHRMForFNCOFormPayableFee -1 "+form_value.indexOf("2775*1st"));
        var formVal=form_value;

        if(formVal.indexOf("2775*1st")!='-1' ||formVal.indexOf("2775*2nd")!='-1' ||formVal.indexOf("2775*3rd")!='-1')
	{
		var courVal=$("#2770").val();
				
		if((courVal=="2770*MCA" || courVal=="2770*MBA") && formVal=="2775*1st" )
                {
			//alert("MCA-MBA-1st-92000");
                        document.getElementById("2779").selectedIndex=0;
                        $('#2779 option').eq(1).hide();		                     $('#2779 option').eq(2).hide();
			$('#2779 option').eq(3).hide();		                     $('#2779 option').eq(4).show();
                       
                }if((courVal=="2770*MCA" || courVal=="2770*MBA") && (formVal=="2775*2nd" || formVal=="2775*3rd") )
                {
			//alert("MCA-MBA-2nd-3rd-54000");
                        document.getElementById("2779").selectedIndex=0;
                        $('#2779 option').eq(1).hide();		                     $('#2779 option').eq(2).show();
			$('#2779 option').eq(3).hide();		                     $('#2779 option').eq(4).hide();
                       
                }if(courVal=="2770*MHRM" && formVal=="2775*1st" )
                {
			//alert("MHRM-1st-90000");
                        document.getElementById("2779").selectedIndex=0;
                        $('#2779 option').eq(1).hide();		                     $('#2779 option').eq(2).hide();
			$('#2779 option').eq(3).show();		                     $('#2779 option').eq(4).hide();
                        
                }if(courVal=="2770*MHRM" && (formVal=="2775*2nd" || formVal=="2775*3rd") )
                {
			//alert("MHRM-2nd-3rd-30000");
                        document.getElementById("2779").selectedIndex=0;
                        $('#2779 option').eq(1).show();		                     $('#2779 option').eq(2).hide();
			$('#2779 option').eq(3).hide();		                     $('#2779 option').eq(4).hide();
                       
                }	
	}
}

// End LNM01 form Foreign National Candidate Online Fee Form for New Student 08 July 2019

// Start LNM01 form MCA MBA MBA-Exe MBA-IB MHRM Online Fee Form for New Student 06 July 2019

function showHideAmountOptionsofLNMO1MCAMBAMHRMForDevelopmentFee(form_value){
	//alert("showHideAmountOptionsofLNMO1BBABCAOnlineFeeForm -1 "+form_value);
    	//alert("showHideAmountOptionsofLNMO1BBABCAOnlineFeeForm -1 "+form_value.indexOf("2733*I"));
        var formVal=form_value;

        if(formVal.indexOf("2733*I")!='-1' ||formVal.indexOf("2733*II")!='-1' ||formVal.indexOf("2733*III")!='-1'){
		var courVal=$("#2731").val();
		
		if(( formVal=="2733*I" ||formVal=="2733*II" ||formVal=="2733*III") && courVal=="2731*MCA"){
			//alert("I-II-III-MCA-10000");
                        document.getElementById("2734").selectedIndex=0;
                        $('#2734 option').eq(1).show();		                     $('#2734 option').eq(2).hide();
		}if(( formVal=="2733*I" ||formVal=="2733*II") && (courVal=="2731*MBA" ||courVal=="2731*MBA-Exe" ||courVal=="2731*MBA-IB" || courVal=="2731*MHRM")){
			//alert("I-II-MBA-Exe-IB-MHRM-10000");
                        document.getElementById("2734").selectedIndex=0;
                        $('#2734 option').eq(1).show();		                     $('#2734 option').eq(2).hide();
		}if(formVal=="2733*III" && (courVal=="2731*MBA" ||courVal=="2731*MBA-Exe" ||courVal=="2731*MBA-IB" || courVal=="2731*MHRM")){
			//alert("III-MBA-Exe-IB-MHRM-Not Applicable");
                        document.getElementById("2734").selectedIndex=0;
                        $('#2734 option').eq(1).hide();		                     $('#2734 option').eq(2).show();
		}
	}
}

function showHideAmountOptionsofLNMO1MCAMBAMHRMPayableFee(form_value)
{
       	//alert("showHideAmountOptionsofLNMO1BBABCAOnlineFeeForm -1 "+form_value);
    	//alert("showHideAmountOptionsofLNMO1BBABCAOnlineFeeForm -1 "+form_value.indexOf("2701*General"));
        var formVal=form_value;

        if(formVal.indexOf("2732*General")!='-1' ||formVal.indexOf("2732*OBC")!='-1' ||formVal.indexOf("2732*SC")!='-1' ||formVal.indexOf("2732*ST")!='-1')
	{
		var courVal=$("#2731").val();
		var instVal=$("#2725").val();
		
		if((formVal=="2732*General" ||formVal=="2732*OBC") && (courVal=="2731*MCA" || courVal=="2731*MBA" ||courVal=="2731*MBA-IB") && instVal=="2725*1st" )
                {
			//alert("General-OBC-MCA-MBA-IB-1st-90000");
                        document.getElementById("2722").selectedIndex=0;
                        $('#2722 option').eq(1).hide();		                     $('#2722 option').eq(2).hide();
			$('#2722 option').eq(3).hide();		                     $('#2722 option').eq(4).hide();
                        $('#2722 option').eq(5).hide();		                     $('#2722 option').eq(6).hide();
			$('#2722 option').eq(7).hide();		                     $('#2722 option').eq(8).show();
			$('#2722 option').eq(9).hide();
                }if((formVal=="2732*SC" ||formVal=="2732*ST") && (courVal=="2731*MCA" || courVal=="2731*MBA" ||courVal=="2731*MBA-IB") && instVal=="2725*1st" )
                {
			//alert("SC-ST-MCA-MBA-IB-1st-45000");
                        document.getElementById("2722").selectedIndex=0;
                        $('#2722 option').eq(1).hide();		                     $('#2722 option').eq(2).hide();
			$('#2722 option').eq(3).hide();		                     $('#2722 option').eq(4).hide();
                        $('#2722 option').eq(5).show();		                     $('#2722 option').eq(6).hide();
			$('#2722 option').eq(7).hide();		                     $('#2722 option').eq(8).hide();
			$('#2722 option').eq(9).hide();
                }if((formVal=="2732*General" ||formVal=="2732*OBC") && (courVal=="2731*MCA" || courVal=="2731*MBA" ||courVal=="2731*MBA-IB" ||courVal=="2731*MBA-Exe") && (instVal=="2725*2nd" ||instVal=="2725*3rd") )
                {
			//alert("General-OBC-MCA-MBA-Exe-IB-2nd-3rd-35000");
                        document.getElementById("2722").selectedIndex=0;
                        $('#2722 option').eq(1).hide();		                     $('#2722 option').eq(2).hide();
			$('#2722 option').eq(3).hide();		                     $('#2722 option').eq(4).show();
                        $('#2722 option').eq(5).hide();		                     $('#2722 option').eq(6).hide();
			$('#2722 option').eq(7).hide();		                     $('#2722 option').eq(8).hide();
			$('#2722 option').eq(9).hide();
                }if((formVal=="2732*SC" ||formVal=="2732*ST") && (courVal=="2731*MCA" || courVal=="2731*MBA" ||courVal=="2731*MBA-IB" ||courVal=="2731*MBA-Exe") && (instVal=="2725*2nd" ||instVal=="2725*3rd") )
                {
			//alert("SC-ST-MCA-MBA-Exe-IB-2nd-3rd-17500");
                        document.getElementById("2722").selectedIndex=0;
                        $('#2722 option').eq(1).hide();		                     $('#2722 option').eq(2).show();
			$('#2722 option').eq(3).hide();		                     $('#2722 option').eq(4).hide();
                        $('#2722 option').eq(5).hide();		                     $('#2722 option').eq(6).hide();
			$('#2722 option').eq(7).hide();		                     $('#2722 option').eq(8).hide();
			$('#2722 option').eq(9).hide();
                }if((formVal=="2732*General" ||formVal=="2732*OBC") && courVal=="2731*MBA-Exe" && instVal=="2725*1st" )
                {
			//alert("General-OBC-MBA-Exe-1st-100000");
                        document.getElementById("2722").selectedIndex=0;
                        $('#2722 option').eq(1).hide();		                     $('#2722 option').eq(2).hide();
			$('#2722 option').eq(3).hide();		                     $('#2722 option').eq(4).hide();
                        $('#2722 option').eq(5).hide();		                     $('#2722 option').eq(6).hide();
			$('#2722 option').eq(7).hide();		                     $('#2722 option').eq(8).hide();
			$('#2722 option').eq(9).show();
                }if((formVal=="2732*SC" ||formVal=="2732*ST") && courVal=="2731*MBA-Exe" && instVal=="2725*1st" )
                {
			//alert("SC-ST-MBA-Exe-1st-50000");
                        document.getElementById("2722").selectedIndex=0;
                        $('#2722 option').eq(1).hide();		                     $('#2722 option').eq(2).hide();
			$('#2722 option').eq(3).hide();		                     $('#2722 option').eq(4).hide();
                        $('#2722 option').eq(5).hide();		                     $('#2722 option').eq(6).show();
			$('#2722 option').eq(7).hide();		                     $('#2722 option').eq(8).hide();
			$('#2722 option').eq(9).hide();
                }if((formVal=="2732*General" ||formVal=="2732*OBC") && courVal=="2731*MHRM" && instVal=="2725*1st" )
                {
			//alert("General-OBC-MHRM-1st-70000");
                        document.getElementById("2722").selectedIndex=0;
                        $('#2722 option').eq(1).hide();		                     $('#2722 option').eq(2).hide();
			$('#2722 option').eq(3).hide();		                     $('#2722 option').eq(4).hide();
                        $('#2722 option').eq(5).hide();		                     $('#2722 option').eq(6).hide();
			$('#2722 option').eq(7).show();		                     $('#2722 option').eq(8).hide();
			$('#2722 option').eq(9).hide();
                }if((formVal=="2732*SC" ||formVal=="2732*ST") && courVal=="2731*MHRM" && instVal=="2725*1st" )
                {
			//alert("SC-ST-MHRM-1st-35000");
                        document.getElementById("2722").selectedIndex=0;
                        $('#2722 option').eq(1).hide();		                     $('#2722 option').eq(2).hide();
			$('#2722 option').eq(3).hide();		                     $('#2722 option').eq(4).show();
                        $('#2722 option').eq(5).hide();		                     $('#2722 option').eq(6).hide();
			$('#2722 option').eq(7).hide();		                     $('#2722 option').eq(8).hide();
			$('#2722 option').eq(9).hide();
                }if((formVal=="2732*General" ||formVal=="2732*OBC") && courVal=="2731*MHRM" && (instVal=="2725*2nd" ||instVal=="2725*3rd"))
                {
			//alert("General-OBC-MHRM-2nd-3rd-21000");
                        document.getElementById("2722").selectedIndex=0;
                        $('#2722 option').eq(1).hide();		                     $('#2722 option').eq(2).hide();
			$('#2722 option').eq(3).show();		                     $('#2722 option').eq(4).hide();
                        $('#2722 option').eq(5).hide();		                     $('#2722 option').eq(6).hide();
			$('#2722 option').eq(7).hide();		                     $('#2722 option').eq(8).hide();
			$('#2722 option').eq(9).hide();
                }if((formVal=="2732*SC" ||formVal=="2732*ST") && courVal=="2731*MHRM" && (instVal=="2725*2nd" ||instVal=="2725*3rd"))
                {
			//alert("SC-ST-MHRM-2nd-3rd-10500");
                        document.getElementById("2722").selectedIndex=0;
                        $('#2722 option').eq(1).show();		                     $('#2722 option').eq(2).hide();
			$('#2722 option').eq(3).hide();		                     $('#2722 option').eq(4).hide();
                        $('#2722 option').eq(5).hide();		                     $('#2722 option').eq(6).hide();
			$('#2722 option').eq(7).hide();		                     $('#2722 option').eq(8).hide();
			$('#2722 option').eq(9).hide();
                }		
	}
}

// End LNM01 form MCA MBA MBA-Exe MBA-IB MHRM Online Fee Form for New Student 06 July 2019

// Start LNM01 form BBA BCA Online Fee Form for New Student 04 July 2019
function showHideAmountOptionsofLNMO1BBABCAOnlineFeeForm(form_value)
{
       	//alert("showHideAmountOptionsofLNMO1BBABCAOnlineFeeForm -1 "+form_value);
    	//alert("showHideAmountOptionsofLNMO1BBABCAOnlineFeeForm -1 "+form_value.indexOf("2701*Gen"));
        var formVal=form_value;

        if(formVal.indexOf("2701*Gen")!='-1' ||formVal.indexOf("2701*OBC")!='-1' ||formVal.indexOf("2701*SC")!='-1' ||formVal.indexOf("2701*ST")!='-1')
	{
		var courVal=$("#2703").val();
		var instVal=$("#2711").val();

                if((formVal=="2701*Gen" ||formVal=="2701*OBC") && courVal=="2703*BBA" && instVal=="2711*1st" )
                {
			//alert("Gen-OBC-BBA-1st-40000")
                        document.getElementById("2708").selectedIndex=0;
                        $('#2708 option').eq(1).hide();		                     $('#2708 option').eq(2).hide();
			$('#2708 option').eq(3).hide();		                     $('#2708 option').eq(4).hide();
                        $('#2708 option').eq(5).hide();		                     $('#2708 option').eq(6).hide();
			$('#2708 option').eq(7).show();		                     $('#2708 option').eq(8).hide();

                }if((formVal=="2701*SC" ||formVal=="2701*ST") && courVal=="2703*BBA" && instVal=="2711*1st" )
                {
			//alert("SC-ST-BBA-1st-20000")
                        document.getElementById("2708").selectedIndex=0;
                        $('#2708 option').eq(1).hide();		                     $('#2708 option').eq(2).hide();
			$('#2708 option').eq(3).hide();		                     $('#2708 option').eq(4).hide();
                        $('#2708 option').eq(5).show();		                     $('#2708 option').eq(6).hide();
			$('#2708 option').eq(7).hide();		                     $('#2708 option').eq(8).hide();

                }if((formVal=="2701*Gen" ||formVal=="2701*OBC") && courVal=="2703*BCA" && instVal=="2711*1st" )
                {
			//alert("Gen-OBC-BCA-1st-42000")
                        document.getElementById("2708").selectedIndex=0;
                        $('#2708 option').eq(1).hide();		                     $('#2708 option').eq(2).hide();
			$('#2708 option').eq(3).hide();		                     $('#2708 option').eq(4).hide();
                        $('#2708 option').eq(5).hide();		                     $('#2708 option').eq(6).hide();
			$('#2708 option').eq(7).hide();		                     $('#2708 option').eq(8).show();

                }if((formVal=="2701*SC" ||formVal=="2701*ST") && courVal=="2703*BCA" && instVal=="2711*1st" )
                {
			//alert("SC-ST-BCA-1st-21000")
                        document.getElementById("2708").selectedIndex=0;
                        $('#2708 option').eq(1).hide();		                     $('#2708 option').eq(2).hide();
			$('#2708 option').eq(3).hide();		                     $('#2708 option').eq(4).hide();
                        $('#2708 option').eq(5).hide();		                     $('#2708 option').eq(6).show();
			$('#2708 option').eq(7).hide();		                     $('#2708 option').eq(8).hide();

                }if((formVal=="2701*Gen" ||formVal=="2701*OBC") && courVal=="2703*BBA" && (instVal=="2711*2nd" || instVal=="2711*3rd") )
                {
			//alert("Gen-OBC-BBA-2nd-3rd-10600")
                        document.getElementById("2708").selectedIndex=0;
                        $('#2708 option').eq(1).hide();		                     $('#2708 option').eq(2).hide();
			$('#2708 option').eq(3).show();		                     $('#2708 option').eq(4).hide();
                        $('#2708 option').eq(5).hide();		                     $('#2708 option').eq(6).hide();
			$('#2708 option').eq(7).hide();		                     $('#2708 option').eq(8).hide();

                }if((formVal=="2701*SC" ||formVal=="2701*ST") && courVal=="2703*BBA" && (instVal=="2711*2nd" || instVal=="2711*3rd") )
                {
			//alert("SC-ST-BBA-2nd-3rd-5300")
                        document.getElementById("2708").selectedIndex=0;
                        $('#2708 option').eq(1).show();		                     $('#2708 option').eq(2).hide();
			$('#2708 option').eq(3).hide();		                     $('#2708 option').eq(4).hide();
                        $('#2708 option').eq(5).hide();		                     $('#2708 option').eq(6).hide();
			$('#2708 option').eq(7).hide();		                     $('#2708 option').eq(8).hide();

                }if((formVal=="2701*Gen" ||formVal=="2701*OBC") && courVal=="2703*BCA" && (instVal=="2711*2nd" || instVal=="2711*3rd") )
                {
			//alert("Gen-OBC-BCA-2nd-3rd-11100")
                        document.getElementById("2708").selectedIndex=0;
                        $('#2708 option').eq(1).hide();		                     $('#2708 option').eq(2).hide();
			$('#2708 option').eq(3).hide();		                     $('#2708 option').eq(4).show();
                        $('#2708 option').eq(5).hide();		                     $('#2708 option').eq(6).hide();
			$('#2708 option').eq(7).hide();		                     $('#2708 option').eq(8).hide();

                }if((formVal=="2701*SC" ||formVal=="2701*ST") && courVal=="2703*BCA" && (instVal=="2711*2nd" || instVal=="2711*3rd") )
                {
			//alert("SC-ST-BCA-2nd-3rd-5550")
                        document.getElementById("2708").selectedIndex=0;
                        $('#2708 option').eq(1).hide();		                     $('#2708 option').eq(2).show();
			$('#2708 option').eq(3).hide();		                     $('#2708 option').eq(4).hide();
                        $('#2708 option').eq(5).hide();		                     $('#2708 option').eq(6).hide();
			$('#2708 option').eq(7).hide();		                     $('#2708 option').eq(8).hide();

                }
           }
}

// Start LNM01 form BBA BCA Online Fee Form for New Student

