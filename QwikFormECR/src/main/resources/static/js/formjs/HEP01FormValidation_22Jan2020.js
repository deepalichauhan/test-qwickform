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

////++++++++++++-------HEP01 Self Financed Student Hostel Online Fee Form START------------++++++++++/////

function showHideListBoxOptionsof567HEP01(form_value)
{
        //alert("insideshowHideListBoxOptionsofRNCollegeIntermediate -1 "+form_value);
        //alert("insideshowHideListBoxOptionsofRNCollegeIntermediate -1 "+form_value.indexOf("8951*1st-Spot Counselling"));
        var formVal=form_value;	
        if((formVal.indexOf("8951*1st-Spot Counselling")!='-1' || formVal.indexOf("8951*1st Counselling")!='-1' || formVal.indexOf("8951*2nd")!='-1'||
        		formVal.indexOf("8951*2nd-K Group-Counselling")!='-1' || formVal.indexOf("8951*2nd-K Group-Spot Counselling")!=-1) ||  
        		formVal.indexOf("8951*3rd")!='-1'){
		
		var yearVal=$("#8951").val();
		
		if(yearVal=="8951*1st-Spot Counselling" || yearVal=="8951*1st Counselling" || yearVal=="8951*2nd-K Group-Counselling" || 
				yearVal=="8951*2nd-K Group-Spot Counselling"){
				//alert("iddd sss>> "+yearVal);
				document.getElementById("8942").selectedIndex=0;
				$('#8942 option').eq(1).hide(); 			$('#8942 option').eq(2).show();						
		}else if(yearVal=="8951*2nd" || yearVal=="8951*3rd"){
				//alert("iddd sss>> "+yearVal);
				document.getElementById("8942").selectedIndex=0;
				$('#8942 option').eq(1).show();			$('#8942 option').eq(2).hide();					
		}
	}
}

////++++++++++++-------HEP01 Self Financed Student Hostel Online Fee Form END------------++++++++++/////

////++++++++++++-------HEP01 Regular Student Hostel Online Fee Form START------------++++++++++/////

function showHideListBoxOptionsof565HEP01(form_value)
{
        //alert("insideshowHideListBoxOptionsofRNCollegeIntermediate -1 "+form_value);
        //alert("insideshowHideListBoxOptionsofRNCollegeIntermediate -1 "+form_value.indexOf("8904*1st-Spot Counselling"));
        var formVal=form_value;	
        if((formVal.indexOf("8904*1st-Spot Counselling")!='-1' || formVal.indexOf("8904*1st Counselling")!='-1' || formVal.indexOf("8904*2nd")!='-1'||
        		formVal.indexOf("8904*2nd-K Group-Counselling")!='-1' || formVal.indexOf("8904*2nd-K Group-Spot Counselling")!=-1) ||  
        		formVal.indexOf("8904*3rd")!='-1'){
		
		var yearVal=$("#8904").val();
		
		if(yearVal=="8904*1st-Spot Counselling" || yearVal=="8904*1st Counselling" || yearVal=="8904*2nd-K Group-Counselling" || 
				yearVal=="8904*2nd-K Group-Spot Counselling"){
				//alert("iddd sss>> "+yearVal);
				document.getElementById("8908").selectedIndex=0;
				$('#8908 option').eq(1).hide(); 			$('#8908 option').eq(2).show();						
		}else if(yearVal=="8904*2nd" || yearVal=="8904*3rd"){
				//alert("iddd sss>> "+yearVal);
				document.getElementById("8908").selectedIndex=0;
				$('#8908 option').eq(1).show();			$('#8908 option').eq(2).hide();					
		}
	}
}

////++++++++++++-------HEP01 Regular Student Hostel Online Fee Form END------------++++++++++/////

////++++++++++++-------HEP01 Miscellaneous Online Fee Form START------------++++++++++/////

function showHideListBoxOptionsof562HEP01(form_value)
{
        //alert("insideshowHideListBoxOptionsofRNCollegeIntermediate -1 "+form_value);
        //alert("insideshowHideListBoxOptionsofRNCollegeIntermediate -1 "+form_value.indexOf("8844*1st(Spot Counselling)"));
        var formVal=form_value;	
        if((formVal.indexOf("8844*1st(Spot Counselling)")!='-1' || formVal.indexOf("8844*1st(Counselling)")!='-1' || formVal.indexOf("8844*2nd")!='-1'||
        		formVal.indexOf("8844*2nd Year K-Group(Counselling)")!='-1' || formVal.indexOf("8844*2nd Year K-Group(Spot Counselling)")!=-1) ||  
        		formVal.indexOf("8844*3rd")!='-1'){
		
		var yearVal=$("#8844").val();
		
		if(yearVal=="8844*1st(Spot Counselling)" || yearVal=="8844*1st(Counselling)" || yearVal=="8844*2nd Year K-Group(Counselling)" || 
				yearVal=="8844*2nd Year K-Group(Spot Counselling)"){
				//alert("iddd sss>> "+yearVal);
				document.getElementById("8853").selectedIndex=0;
				$('#8853 option').eq(1).hide(); 			$('#8853 option').eq(2).show();						
		}else if(yearVal=="8844*2nd" || yearVal=="8844*3rd"){
				//alert("iddd sss>> "+yearVal);
				document.getElementById("8853").selectedIndex=0;
				$('#8853 option').eq(1).show();			$('#8853 option').eq(2).hide();					
		}
	}
}

////++++++++++++-------HEP01 Miscellaneous Online Fee Form END------------++++++++++/////
