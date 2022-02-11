////++++++++++++-------HEP01 Tuition Online Fee Form START------------++++++++++/////

function showHideListBoxOptionsofHEP01(form_value)
{
        //alert("insideshowHideListBoxOptionsofRNCollegeIntermediate -1 "+form_value);
        //alert("insideshowHideListBoxOptionsofRNCollegeIntermediate -1 "+form_value.indexOf("8751*1st-Spot Counselling"));
        var formVal=form_value;	
	if((formVal.indexOf("8751*1st-Spot Counselling")!='-1'|| formVal.indexOf("8751*2nd")!='-1'|| formVal.indexOf("8751*2nd K Group- Spot Counselling")!='-1'||
			formVal.indexOf("8751*3rd")!='-1'|| formVal.indexOf("8751*1st-Counselling")!='-1'|| formVal.indexOf("8751*2nd Year K Group- Counselling")!=-1)){
		
		var yearVal=$("#8751").val();
		
		if(yearVal=="8751*1st-Spot Counselling" || yearVal=="8751*2nd" || yearVal=="8751*2nd K Group- Spot Counselling" || yearVal=="8751*3rd"){
				//alert("iddd sss>> "+yearVal);
				document.getElementById("8748").selectedIndex=0;
				$('#8748 option').eq(1).hide(); 			$('#8748 option').eq(2).show();						
		}else if(yearVal=="8751*1st-Counselling" || yearVal=="8751*2nd Year K Group- Counselling"){
				//alert("iddd sss>> "+yearVal);
				document.getElementById("8748").selectedIndex=0;
				$('#8748 option').eq(1).show();			$('#8748 option').eq(2).hide();					
		}
	}
}

////++++++++++++-------HEP01 Tuition Online Fee Form END------------++++++++++/////
