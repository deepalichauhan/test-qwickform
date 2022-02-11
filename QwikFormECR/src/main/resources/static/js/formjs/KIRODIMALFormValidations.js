////++++++++++++-------KIRODIMAL GOVERNMENT POLYTECHNIC COLLEGE RAIGARH VALIDATION WORK START------------++++++++++/////

function showHideListBoxOptionsofKIRODIMALFormForFullTimeStudents(form_value)
{
        //alert("insideshowHideListBoxOptionsofKIRODIMALFormForFullTimeStudents -1 "+form_value);
        //alert("insidesshowHideListBoxOptionsofKIRODIMALFormForFullTimeStudents -1 "+form_value.indexOf("11568*Unreserved-Not Applicable"));
        var formVal=form_value;	
	if((formVal.indexOf("11568*Unreserved-Not Applicable")!='-1'||formVal.indexOf("11568*OBC-Less than 1 Lakh")!='-1'||formVal.indexOf("11568*OBC- More than 1 Lakh")!='-1'||formVal.indexOf("11568*SC-ST-Less than 2.5 Lakh")!='-1'||formVal.indexOf("11568*SC-ST-More than 2.5 Lakh")!='-1'))
	{
	var YearVal=$("#11571").val();
	var GenderVal=$("#11558").val();
	var CategoryVal=$("#11562").val();
	alert("in if -2 >> "+YearVal +",GenderVal - "+GenderVal +", CategoryVal - "+CategoryVal+"");
	if(GenderVal==""){	
			alert("insideshowHideListBoxOptionsofKIRODIMALFormForFullTimeStudents -3 >> "+YearVal +", GenderVal - "+GenderVal+", CategoryVal - "+CategoryVal+"");
			document.getElementById("11571").selectedIndex=0;
			document.getElementById("11558").selectedIndex=0;
			document.getElementById("11568").focus();
			return false;
	}else {
			alert("insideshowHideListBoxOptionsofKIRODIMALFormForFullTimeStudents -4 >> "+YearVal +", GenderVal - "+GenderVal+", CategoryVal - "+CategoryVal+"");
			if((YearVal=="11571*1st") && (GenderVal=="11558*Male") && (CategoryVal=="11562*Unreserved") && (formVal=="11568*Unreserved-Not Applicable" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("11570").selectedIndex=0;
				$('#11570 option').eq(1).hide(); 
                                $('#11570 option').eq(2).hide();
				$('#11570 option').eq(3).hide();
				$('#11570 option').eq(4).show();				
			
			}if((YearVal=="11571*2nd"||YearVal=="11571*3rd") && (GenderVal=="11558*Male") && (CategoryVal=="11562*Unreserved") && (formVal=="11568*Unreserved-Not Applicable" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("11570").selectedIndex=0;
				$('#11570 option').eq(1).hide(); 
                                $('#11570 option').eq(2).hide();
				$('#11570 option').eq(3).show();
				$('#11570 option').eq(4).hide();
				
			}if((YearVal=="11571*1st") && (GenderVal=="11558*Male") && (CategoryVal=="11562*OBC") && (formVal=="11568*OBC-Less than 1 Lakh" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("11570").selectedIndex=0;
				$('#11570 option').eq(1).hide(); 
                                $('#11570 option').eq(2).show();
				$('#11570 option').eq(3).hide();
				$('#11570 option').eq(4).hide();
				
			}if((YearVal=="11571*1st") && (GenderVal=="11558*Male") && (CategoryVal=="11562*OBC") && (formVal=="11568*OBC- More than 1 Lakh" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("11570").selectedIndex=0;
				$('#11570 option').eq(1).hide(); 
                                $('#11570 option').eq(2).hide();
				$('#11570 option').eq(3).hide();
				$('#11570 option').eq(4).show();
				
			}if((YearVal=="11571*2nd"||YearVal=="11571*3rd") && (GenderVal=="11558*Male") && (CategoryVal=="11562*OBC") && (formVal=="11568*OBC-Less than 1 Lakh" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("11570").selectedIndex=0;
				$('#11570 option').eq(1).show(); 
                                $('#11570 option').eq(2).hide();
				$('#11570 option').eq(3).hide();
				$('#11570 option').eq(4).hide();
				
			}if((YearVal=="11571*2nd"||YearVal=="11571*3rd") && (GenderVal=="11558*Male") && (CategoryVal=="11562*OBC") && (formVal=="11568*OBC- More than 1 Lakh" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("11570").selectedIndex=0;
				$('#11570 option').eq(1).hide(); 
                                $('#11570 option').eq(2).hide();
				$('#11570 option').eq(3).show();
				$('#11570 option').eq(4).hide();
				
			}else if((YearVal=="11571*1st") && (GenderVal=="11558*Male") && (CategoryVal=="11562*SC"||CategoryVal=="11562*ST") && (formVal=="11568*SC-ST-Less than 2.5 Lakh" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("11570").selectedIndex=0;
				$('#11570 option').eq(1).hide(); 
                                $('#11570 option').eq(2).show();
				$('#11570 option').eq(3).hide();
				$('#11570 option').eq(4).hide();
				
			}else if((YearVal=="11571*1st") && (GenderVal=="11558*Male") && (CategoryVal=="11562*SC"||CategoryVal=="11562*ST") && (formVal=="11568*SC-ST-More than 2.5 Lakh" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("11570").selectedIndex=0;
				$('#11570 option').eq(1).hide(); 
                                $('#11570 option').eq(2).hide();
				$('#11570 option').eq(3).hide();
				$('#11570 option').eq(4).show();
				
			}else if((YearVal=="11571*2nd"||YearVal=="11571*3rd") && (GenderVal=="11558*Male") && (CategoryVal=="11562*SC"||CategoryVal=="11572*ST") && (formVal=="11568*SC-ST-Less than 2.5 Lakh" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("11570").selectedIndex=0;
				$('#11570 option').eq(1).show(); 
                                $('#11570 option').eq(2).hide();
				$('#11570 option').eq(3).hide();
				$('#11570 option').eq(4).hide();
				
			}else if((YearVal=="11571*2nd"||YearVal=="11571*3rd") && (GenderVal=="11558*Male") && (CategoryVal=="11562*SC"||CategoryVal=="11572*ST") && (formVal=="11568*SC-ST-More than 2.5 Lakh" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("11570").selectedIndex=0;
				$('#11570 option').eq(1).hide(); 
                                $('#11570 option').eq(2).hide();
				$('#11570 option').eq(3).show();
				$('#11570 option').eq(4).hide();
				
			}else if((YearVal=="11571*1st") && (GenderVal=="11558*Female") && (CategoryVal=="11562*Unreserved"||"11562*OBC"||"11562*SC"||CategoryVal=="11562*ST") && (formVal=="11568*Unreserved-Not Applicable"||"11568*OBC-Less than 1 Lakh"||"11568*OBC- More than 1 Lakh"||"11568*SC-ST-Less than 2.5 Lakh"||"11568*SC-ST-More than 2.5 Lakh" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("11570").selectedIndex=0;
				$('#11570 option').eq(1).hide(); 
                                $('#11570 option').eq(2).show();
				$('#11570 option').eq(3).hide();
				$('#11570 option').eq(4).hide();
				
			}else if((YearVal=="11571*2nd"||YearVal=="11571*3rd") && (GenderVal=="11558*Female") && (CategoryVal=="11562*Unreserved"||"11562*OBC"||"11562*SC"||CategoryVal=="11562*ST") && (formVal=="11568*Unreserved-Not Applicable"||"11568*OBC-Less than 1 Lakh"||"11568*OBC- More than 1 Lakh"||"11568*SC-ST-Less than 2.5 Lakh"||"11568*SC-ST-More than 2.5 Lakh" ))

       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("11570").selectedIndex=0;
				$('#11570 option').eq(1).show(); 
                                $('#11570 option').eq(2).hide();
				$('#11570 option').eq(3).hide();
				$('#11570 option').eq(4).hide();
				
			}
		}
	}
}

////++++++++++++-------KIRODIMAL GOVERNMENT POLYTECHNIC COLLEGE RAIGARH VALIDATION WORK END------------++++++++++/////
