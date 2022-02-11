////++++++++++++-------RN COLLEGE INTERMEDITE VALIDATION WORK END------------++++++++++/////

function showHideListBoxOptionsofRNCollegeIntermediate(form_value)
{
        //alert("insideshowHideListBoxOptionsofRNCollegeIntermediate -1 "+form_value);
        //alert("insideshowHideListBoxOptionsofRNCollegeIntermediate -1 "+form_value.indexOf("585*General"));
        var formVal=form_value;	
	if((formVal.indexOf("585*General")!='-1'||formVal.indexOf("585*SC")!='-1'||formVal.indexOf("585*ST")!='-1'||formVal.indexOf("585*BC-I")!='-1'||formVal.indexOf("585*BC-II")!='-1'))
	{
	var GenderVal=$("#578").val();
	var SubjectVal=$("#573").val();
	//alert("in if -2 >> "+GenderVal +", SubjectVal - "+SubjectVal+"");
	if(GenderVal==""){	
			alert("insideshowHideListBoxOptionsofRNCollegeIntermediate -3 >> "+GenderVal);
			document.getElementById("578").selectedIndex=0;
			document.getElementById("585").focus();
			return false;
	}else {
			//alert("insideshowHideListBoxOptionsofRNCollegeIntermediate -4 >> "+GenderVal +", formVal > "+formVal+", SubjectVal - "+SubjectVal+"");
			if((GenderVal=="578*Male") && (SubjectVal=="573*Maths(Sci)") && (formVal=="585*General" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("581").selectedIndex=0;
				$('#581 option').eq(1).show(); 			$('#581 option').eq(2).hide();			$('#581 option').eq(3).hide();
				$('#581 option').eq(4).hide();			$('#581 option').eq(5).hide();			$('#581 option').eq(6).hide();
				$('#581 option').eq(7).hide();			$('#581 option').eq(8).hide();			$('#581 option').eq(9).hide();
				$('#581 option').eq(10).hide();			$('#581 option').eq(11).hide();			$('#581 option').eq(12).hide();
				$('#581 option').eq(13).hide();			$('#581 option').eq(14).hide();			$('#581 option').eq(15).hide();
				
			
			}if((GenderVal=="578*Male") && (SubjectVal=="573*Biology(Sci)") && (formVal=="585*General" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("581").selectedIndex=0;
				$('#581 option').eq(1).hide();			$('#581 option').eq(2).show();			$('#581 option').eq(3).hide();
				$('#581 option').eq(4).hide();			$('#581 option').eq(5).hide();			$('#581 option').eq(6).hide();
				$('#581 option').eq(7).hide();			$('#581 option').eq(8).hide();			$('#581 option').eq(9).hide();
				$('#581 option').eq(10).hide();			$('#581 option').eq(11).hide();			$('#581 option').eq(12).hide();
				$('#581 option').eq(13).hide();			$('#581 option').eq(14).hide();			$('#581 option').eq(15).hide();
				
			}if((GenderVal=="578*Male") && (SubjectVal=="573*Arts") && (formVal=="585*General" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("581").selectedIndex=0;
				$('#581 option').eq(1).hide();			$('#581 option').eq(2).hide();			$('#581 option').eq(3).show();
				$('#581 option').eq(4).hide();			$('#581 option').eq(5).hide();			$('#581 option').eq(6).hide();
				$('#581 option').eq(7).hide();			$('#581 option').eq(8).hide();			$('#581 option').eq(9).hide();
				$('#581 option').eq(10).hide();			$('#581 option').eq(11).hide();			$('#581 option').eq(12).hide();
				$('#581 option').eq(13).hide();			$('#581 option').eq(14).hide();			$('#581 option').eq(15).hide();
				
			}if((GenderVal=="578*Female") && (SubjectVal=="573*Maths(Sci)") && (formVal=="585*General" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("581").selectedIndex=0;
				$('#581 option').eq(1).hide();			$('#581 option').eq(2).hide();			$('#581 option').eq(3).hide();
				$('#581 option').eq(4).show();			$('#581 option').eq(5).hide();			$('#581 option').eq(6).hide();
				$('#581 option').eq(7).hide();			$('#581 option').eq(8).hide();			$('#581 option').eq(9).hide();
				$('#581 option').eq(10).hide();			$('#581 option').eq(11).hide();			$('#581 option').eq(12).hide();
				$('#581 option').eq(13).hide();			$('#581 option').eq(14).hide();			$('#581 option').eq(15).hide();
				
			}if((GenderVal=="578*Female") && (SubjectVal=="573*Biology(Sci)") &&(formVal=="585*General" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("581").selectedIndex=0;
				$('#581 option').eq(1).hide();			$('#581 option').eq(2).hide();			$('#581 option').eq(3).hide();
				$('#581 option').eq(4).hide();			$('#581 option').eq(5).show();			$('#581 option').eq(6).hide();
				$('#581 option').eq(7).hide();			$('#581 option').eq(8).hide();			$('#581 option').eq(9).hide();
				$('#581 option').eq(10).hide();			$('#581 option').eq(11).hide();			$('#581 option').eq(12).hide();
				$('#581 option').eq(13).hide();			$('#581 option').eq(14).hide();			$('#581 option').eq(15).hide();
				
			}if((GenderVal=="578*Female") && (SubjectVal=="573*Arts") && (formVal=="585*General" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("581").selectedIndex=0;
				$('#581 option').eq(1).hide();			$('#581 option').eq(2).hide();			$('#581 option').eq(3).hide();
				$('#581 option').eq(4).hide();			$('#581 option').eq(5).hide();			$('#581 option').eq(6).show();
				$('#581 option').eq(7).hide();			$('#581 option').eq(8).hide();			$('#581 option').eq(9).hide();
				$('#581 option').eq(10).hide();			$('#581 option').eq(11).hide();			$('#581 option').eq(12).hide();
				$('#581 option').eq(13).hide();			$('#581 option').eq(14).hide();			$('#581 option').eq(15).hide();
				
			}else if((GenderVal=="578*Male") && (SubjectVal=="573*Maths(Sci)") && (formVal=="585*SC" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("581").selectedIndex=0;
				$('#581 option').eq(1).hide();			$('#581 option').eq(2).hide();			$('#581 option').eq(3).hide();
				$('#581 option').eq(4).hide();			$('#581 option').eq(5).hide();			$('#581 option').eq(6).hide();
				$('#581 option').eq(7).show();			$('#581 option').eq(8).hide();			$('#581 option').eq(9).hide();
				$('#581 option').eq(10).hide();			$('#581 option').eq(11).hide();			$('#581 option').eq(12).hide();
				$('#581 option').eq(13).hide();			$('#581 option').eq(14).hide();			$('#581 option').eq(15).hide();
				
			}else if((GenderVal=="578*Male") && (SubjectVal=="573*Biology(Sci)") && (formVal=="585*SC" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("581").selectedIndex=0;
				$('#581 option').eq(1).hide();			$('#581 option').eq(2).hide();			$('#581 option').eq(3).hide();
				$('#581 option').eq(4).hide();			$('#581 option').eq(5).hide();			$('#581 option').eq(6).hide();
				$('#581 option').eq(7).hide();			$('#581 option').eq(8).hide();			$('#581 option').eq(9).hide();
				$('#581 option').eq(10).hide();			$('#581 option').eq(11).hide();			$('#581 option').eq(12).hide();
				$('#581 option').eq(13).hide();			$('#581 option').eq(14).show();			$('#581 option').eq(15).hide();
				
			}else if((GenderVal=="578*Male") && (SubjectVal=="573*Arts") && (formVal=="585*SC" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("581").selectedIndex=0;
				$('#581 option').eq(1).hide();			$('#581 option').eq(2).hide();			$('#581 option').eq(3).hide();
				$('#581 option').eq(4).hide();			$('#581 option').eq(5).hide();			$('#581 option').eq(6).hide();
				$('#581 option').eq(7).hide();			$('#581 option').eq(8).hide();			$('#581 option').eq(9).hide();
				$('#581 option').eq(10).hide();			$('#581 option').eq(11).hide();			$('#581 option').eq(12).hide();
				$('#581 option').eq(13).hide();			$('#581 option').eq(14).hide();			$('#581 option').eq(15).show();
				
			}else if((GenderVal=="578*Female") && (SubjectVal=="573*Maths(Sci)") && (formVal=="585*SC" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("581").selectedIndex=0;
				$('#581 option').eq(1).hide();			$('#581 option').eq(2).hide();			$('#581 option').eq(3).hide();
				$('#581 option').eq(4).hide();			$('#581 option').eq(5).hide();			$('#581 option').eq(6).hide();
				$('#581 option').eq(7).hide();			$('#581 option').eq(8).hide();			$('#581 option').eq(9).hide();
				$('#581 option').eq(10).hide();			$('#581 option').eq(11).hide();			$('#581 option').eq(12).hide();
				$('#581 option').eq(13).show();			$('#581 option').eq(14).hide();			$('#581 option').eq(15).hide();
				
			}else if((GenderVal=="578*Female") && (SubjectVal=="573*Biology(Sci)") &&(formVal=="585*SC" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("581").selectedIndex=0;
				$('#581 option').eq(1).hide();			$('#581 option').eq(2).hide();			$('#581 option').eq(3).hide();
				$('#581 option').eq(4).hide();			$('#581 option').eq(5).hide();			$('#581 option').eq(6).hide();
				$('#581 option').eq(7).hide();			$('#581 option').eq(8).hide();			$('#581 option').eq(9).hide();
				$('#581 option').eq(10).hide();			$('#581 option').eq(11).hide();			$('#581 option').eq(12).hide();
				$('#581 option').eq(13).hide();			$('#581 option').eq(14).show();			$('#581 option').eq(15).hide();
				
			}else if((GenderVal=="578*Female") && (SubjectVal=="573*Arts") && (formVal=="585*SC" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("581").selectedIndex=0;
				$('#581 option').eq(1).hide();			$('#581 option').eq(2).hide();			$('#581 option').eq(3).hide();
				$('#581 option').eq(4).hide();			$('#581 option').eq(5).hide();			$('#581 option').eq(6).hide();
				$('#581 option').eq(7).hide();			$('#581 option').eq(8).hide();			$('#581 option').eq(9).hide();
				$('#581 option').eq(10).hide();			$('#581 option').eq(11).hide();			$('#581 option').eq(12).hide();
				$('#581 option').eq(13).hide();			$('#581 option').eq(14).hide();			$('#581 option').eq(15).show();
				
			}else if((GenderVal=="578*Male") && (SubjectVal=="573*Maths(Sci)") && (formVal=="585*ST" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("581").selectedIndex=0;
				$('#581 option').eq(1).hide();			$('#581 option').eq(2).hide();			$('#581 option').eq(3).hide();
				$('#581 option').eq(4).hide();			$('#581 option').eq(5).hide();			$('#581 option').eq(6).hide();
				$('#581 option').eq(7).hide();			$('#581 option').eq(8).hide();			$('#581 option').eq(9).hide();
				$('#581 option').eq(10).hide();			$('#581 option').eq(11).hide();			$('#581 option').eq(12).hide();
				$('#581 option').eq(13).show();			$('#581 option').eq(14).hide();			$('#581 option').eq(15).hide();
				
			}else if((GenderVal=="578*Male") && (SubjectVal=="573*Biology(Sci)") && (formVal=="585*ST" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("581").selectedIndex=0;
				$('#581 option').eq(1).hide();			$('#581 option').eq(2).hide();			$('#581 option').eq(3).hide();
				$('#581 option').eq(4).hide();			$('#581 option').eq(5).hide();			$('#581 option').eq(6).hide();
				$('#581 option').eq(7).hide();			$('#581 option').eq(8).hide();			$('#581 option').eq(9).hide();
				$('#581 option').eq(10).hide();			$('#581 option').eq(11).hide();			$('#581 option').eq(12).hide();
				$('#581 option').eq(13).hide();			$('#581 option').eq(14).show();			$('#581 option').eq(15).hide();
				
			}else if((GenderVal=="578*Male") && (SubjectVal=="573*Arts") && (formVal=="585*ST" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("581").selectedIndex=0;
				$('#581 option').eq(1).hide();			$('#581 option').eq(2).hide();			$('#581 option').eq(3).hide();
				$('#581 option').eq(4).hide();			$('#581 option').eq(5).hide();			$('#581 option').eq(6).hide();
				$('#581 option').eq(7).hide();			$('#581 option').eq(8).hide();			$('#581 option').eq(9).hide();
				$('#581 option').eq(10).hide();			$('#581 option').eq(11).hide();			$('#581 option').eq(12).hide();
				$('#581 option').eq(13).hide();			$('#581 option').eq(14).hide();			$('#581 option').eq(15).show();
				
			}else if((GenderVal=="578*Female") && (SubjectVal=="573*Maths(Sci)") && (formVal=="585*ST" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("581").selectedIndex=0;
				$('#581 option').eq(1).hide();			$('#581 option').eq(2).hide();			$('#581 option').eq(3).hide();
				$('#581 option').eq(4).hide();			$('#581 option').eq(5).hide();			$('#581 option').eq(6).hide();
				$('#581 option').eq(7).hide();			$('#581 option').eq(8).hide();			$('#581 option').eq(9).hide();
				$('#581 option').eq(10).hide();			$('#581 option').eq(11).hide();			$('#581 option').eq(12).hide();
				$('#581 option').eq(13).show();			$('#581 option').eq(14).hide();			$('#581 option').eq(15).hide();
				
			}else if((GenderVal=="578*Female") && (SubjectVal=="573*Biology(Sci)") && (formVal=="585*ST" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("581").selectedIndex=0;
				$('#581 option').eq(1).hide();			$('#581 option').eq(2).hide();			$('#581 option').eq(3).hide();
				$('#581 option').eq(4).hide();			$('#581 option').eq(5).hide();			$('#581 option').eq(6).hide();
				$('#581 option').eq(7).hide();			$('#581 option').eq(8).hide();			$('#581 option').eq(9).hide();
				$('#581 option').eq(10).hide();			$('#581 option').eq(11).hide();			$('#581 option').eq(12).hide();
				$('#581 option').eq(13).hide();			$('#581 option').eq(14).show();			$('#581 option').eq(15).hide();
				
			}else if((GenderVal=="578*Female") && (SubjectVal=="573*Arts") && (formVal=="585*ST" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("581").selectedIndex=0;
				$('#581 option').eq(1).hide();			$('#581 option').eq(2).hide();			$('#581 option').eq(3).hide();
				$('#581 option').eq(4).hide();			$('#581 option').eq(5).hide();			$('#581 option').eq(6).hide();
				$('#581 option').eq(7).hide();			$('#581 option').eq(8).hide();			$('#581 option').eq(9).hide();
				$('#581 option').eq(10).hide();			$('#581 option').eq(11).hide();			$('#581 option').eq(12).hide();
				$('#581 option').eq(13).hide();			$('#581 option').eq(14).hide();			$('#581 option').eq(15).show();
				
			}else if((GenderVal=="578*Male") && (SubjectVal=="573*Maths(Sci)") && (formVal=="585*BC-I" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("581").selectedIndex=0;
				$('#581 option').eq(1).hide();			$('#581 option').eq(2).hide();			$('#581 option').eq(3).hide();
				$('#581 option').eq(4).hide();			$('#581 option').eq(5).hide();			$('#581 option').eq(6).hide();
				$('#581 option').eq(7).hide();			$('#581 option').eq(8).hide();			$('#581 option').eq(9).hide();
				$('#581 option').eq(10).show();			$('#581 option').eq(11).hide();			$('#581 option').eq(12).hide();
				$('#581 option').eq(13).hide();			$('#581 option').eq(14).hide();			$('#581 option').eq(15).hide();
				
			}else if((GenderVal=="578*Male") && (SubjectVal=="573*Biology(Sci)") && (formVal=="585*BC-I" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("581").selectedIndex=0;
				$('#581 option').eq(1).hide();			$('#581 option').eq(2).hide();			$('#581 option').eq(3).hide();
				$('#581 option').eq(4).hide();			$('#581 option').eq(5).hide();			$('#581 option').eq(6).hide();
				$('#581 option').eq(7).hide();			$('#581 option').eq(8).hide();			$('#581 option').eq(9).hide();
				$('#581 option').eq(10).hide();			$('#581 option').eq(11).show();			$('#581 option').eq(12).hide();
				$('#581 option').eq(13).hide();			$('#581 option').eq(14).hide();			$('#581 option').eq(15).hide();
				
			}else if((GenderVal=="578*Male") && (SubjectVal=="573*Arts") && (formVal=="585*BC-I" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("581").selectedIndex=0;
				$('#581 option').eq(1).hide();			$('#581 option').eq(2).hide();			$('#581 option').eq(3).hide();
				$('#581 option').eq(4).hide();			$('#581 option').eq(5).hide();			$('#581 option').eq(6).hide();
				$('#581 option').eq(7).hide();			$('#581 option').eq(8).hide();			$('#581 option').eq(9).hide();
				$('#581 option').eq(10).hide();			$('#581 option').eq(11).hide();			$('#581 option').eq(12).show();
				$('#581 option').eq(13).hide();			$('#581 option').eq(14).hide();			$('#581 option').eq(15).hide();
				
			}else if((GenderVal=="578*Female") && (SubjectVal=="573*Maths(Sci)") && (formVal=="585*BC-I" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("581").selectedIndex=0;
				$('#581 option').eq(1).hide();			$('#581 option').eq(2).hide();			$('#581 option').eq(3).hide();
				$('#581 option').eq(4).hide();			$('#581 option').eq(5).hide();			$('#581 option').eq(6).hide();
				$('#581 option').eq(7).show();			$('#581 option').eq(8).hide();			$('#581 option').eq(9).hide();
				$('#581 option').eq(10).hide();			$('#581 option').eq(11).hide();			$('#581 option').eq(12).hide();
				$('#581 option').eq(13).hide();			$('#581 option').eq(14).hide();			$('#581 option').eq(15).hide();
				
			}else if((GenderVal=="578*Female") && (SubjectVal=="573*Biology(Sci)") && (formVal=="585*BC-I" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("581").selectedIndex=0;
				$('#581 option').eq(1).hide();			$('#581 option').eq(2).hide();			$('#581 option').eq(3).hide();
				$('#581 option').eq(4).hide();			$('#581 option').eq(5).hide();			$('#581 option').eq(6).hide();
				$('#581 option').eq(7).hide();			$('#581 option').eq(8).show();			$('#581 option').eq(9).hide();
				$('#581 option').eq(10).hide();			$('#581 option').eq(11).hide();			$('#581 option').eq(12).hide();
				$('#581 option').eq(13).hide();			$('#581 option').eq(14).hide();			$('#581 option').eq(15).hide();
				
			}else if((GenderVal=="578*Female") && (SubjectVal=="573*Arts") && (formVal=="585*BC-I" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("581").selectedIndex=0;
				$('#581 option').eq(1).hide();			$('#581 option').eq(2).hide();			$('#581 option').eq(3).hide();
				$('#581 option').eq(4).hide();			$('#581 option').eq(5).hide();			$('#581 option').eq(6).hide();
				$('#581 option').eq(7).hide();			$('#581 option').eq(8).hide();			$('#581 option').eq(9).show();
				$('#581 option').eq(10).hide();			$('#581 option').eq(11).hide();			$('#581 option').eq(12).hide();
				$('#581 option').eq(13).hide();			$('#581 option').eq(14).hide();			$('#581 option').eq(15).hide();
				
			}else if((GenderVal=="578*Male") && (SubjectVal=="573*Maths(Sci)") && (formVal=="585*BC-II" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("581").selectedIndex=0;
				$('#581 option').eq(1).show();			$('#581 option').eq(2).hide();			$('#581 option').eq(3).hide();
				$('#581 option').eq(4).hide();			$('#581 option').eq(5).hide();			$('#581 option').eq(6).hide();
				$('#581 option').eq(7).hide();			$('#581 option').eq(8).hide();			$('#581 option').eq(9).hide();
				$('#581 option').eq(10).hide();			$('#581 option').eq(11).hide();			$('#581 option').eq(12).hide();
				$('#581 option').eq(13).hide();			$('#581 option').eq(14).hide();			$('#581 option').eq(15).hide();
				
			}else if((GenderVal=="578*Male") && (SubjectVal=="573*Biology(Sci)") && (formVal=="585*BC-II" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("581").selectedIndex=0;
				$('#581 option').eq(1).hide();			$('#581 option').eq(2).show();			$('#581 option').eq(3).hide();
				$('#581 option').eq(4).hide();			$('#581 option').eq(5).hide();			$('#581 option').eq(6).hide();
				$('#581 option').eq(7).hide();			$('#581 option').eq(8).hide();			$('#581 option').eq(9).hide();
				$('#581 option').eq(10).hide();			$('#581 option').eq(11).hide();			$('#581 option').eq(12).hide();
				$('#581 option').eq(13).hide();			$('#581 option').eq(14).hide();			$('#581 option').eq(15).hide();
				
			}else if((GenderVal=="578*Male") && (SubjectVal=="573*Arts") && (formVal=="585*BC-II" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("581").selectedIndex=0;
				$('#581 option').eq(1).hide();			$('#581 option').eq(2).hide();			$('#581 option').eq(3).show();
				$('#581 option').eq(4).hide();			$('#581 option').eq(5).hide();			$('#581 option').eq(6).hide();
				$('#581 option').eq(7).hide();			$('#581 option').eq(8).hide();			$('#581 option').eq(9).hide();
				$('#581 option').eq(10).hide();			$('#581 option').eq(11).hide();			$('#581 option').eq(12).hide();
				$('#581 option').eq(13).hide();			$('#581 option').eq(14).hide();			$('#581 option').eq(15).hide();
				
			}else if((GenderVal=="578*Female") && (SubjectVal=="573*Maths(Sci)") && (formVal=="585*BC-II" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("581").selectedIndex=0;
				$('#581 option').eq(1).hide();			$('#581 option').eq(2).hide();			$('#581 option').eq(3).hide();
				$('#581 option').eq(4).show();			$('#581 option').eq(5).hide();			$('#581 option').eq(6).hide();
				$('#581 option').eq(7).hide();			$('#581 option').eq(8).hide();			$('#581 option').eq(9).hide();
				$('#581 option').eq(10).hide();			$('#581 option').eq(11).hide();			$('#581 option').eq(12).hide();
				$('#581 option').eq(13).hide();			$('#581 option').eq(14).hide();			$('#581 option').eq(15).hide();
				
			}else if((GenderVal=="578*Female") && (SubjectVal=="573*Biology(Sci)") && (formVal=="585*BC-II" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("581").selectedIndex=0;
				$('#581 option').eq(1).hide();			$('#581 option').eq(2).hide();			$('#581 option').eq(3).hide();
				$('#581 option').eq(4).hide();			$('#581 option').eq(5).show();			$('#581 option').eq(6).hide();
				$('#581 option').eq(7).hide();			$('#581 option').eq(8).hide();			$('#581 option').eq(9).hide();
				$('#581 option').eq(10).hide();			$('#581 option').eq(11).hide();			$('#581 option').eq(12).hide();
				$('#581 option').eq(13).hide();			$('#581 option').eq(14).hide();			$('#581 option').eq(15).hide();
				
			}else if((GenderVal=="578*Male") && (SubjectVal=="573*Arts") && (formVal=="585*BC-II" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("581").selectedIndex=0;
				$('#581 option').eq(1).hide();			$('#581 option').eq(2).hide();			$('#581 option').eq(3).hide();
				$('#581 option').eq(4).hide();			$('#581 option').eq(5).hide();			$('#581 option').eq(6).show();
				$('#581 option').eq(7).hide();			$('#581 option').eq(8).hide();			$('#581 option').eq(9).hide();
				$('#581 option').eq(10).hide();			$('#581 option').eq(11).hide();			$('#581 option').eq(12).hide();
				$('#581 option').eq(13).hide();			$('#581 option').eq(14).hide();			$('#581 option').eq(15).hide();
				
			}  
		}
	}
}

////++++++++++++-------RN COLLEGE INTERMEDITE VALIDATION WORK END------------++++++++++/////

////++++++++++++-------RN COLLEGE TDC Online Fee Form Start------------++++++++++/////

function showHideListBoxOptionsofRNCollegeTDCOnline(form_value)
{
        //alert("insideshowHideListBoxOptionsofRNCollegeIntermediate -1");
        //alert("insideshowHideListBoxOptionsofRNCollegeIntermediate -1 "+form_value.indexOf("596*General"));
        var formVal=form_value;	
	if((formVal.indexOf("596*General")!='-1'||formVal.indexOf("596*SC")!='-1'||formVal.indexOf("596*ST")!='-1'||formVal.indexOf("596*BC-I")!='-1'||formVal.indexOf("596*BC-II")!='-1'))
	{
	var GenderVal=$("#595").val();
	var SubjectVal=$("#593").val();
	//alert("in if -2 >> "+GenderVal +", SubjectVal - "+SubjectVal+"");
	if(GenderVal==""){	
			alert("insideshowHideListBoxOptionsofRNCollegeIntermediate -3 >> "+GenderVal);
			document.getElementById("595").selectedIndex=0;
			document.getElementById("596").focus();
			return false;
	}else {
			//alert("insideshowHideListBoxOptionsofRNCollegeIntermediate -4 >> "+GenderVal +", formVal > "+formVal+", SubjectVal - "+SubjectVal+"");
			if((GenderVal=="595*Male") && (SubjectVal=="593*Physics" ||SubjectVal=="593*Maths" ||SubjectVal=="593*Chemistry(Math)") && (formVal=="596*General" ||formVal=="596*BC-II" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("598").selectedIndex=0;
				$('#598 option').eq(1).hide();			$('#598 option').eq(2).hide();			$('#598 option').eq(3).hide();
				$('#598 option').eq(4).hide();			$('#598 option').eq(5).hide();			$('#598 option').eq(6).hide();
				$('#598 option').eq(7).hide();			$('#598 option').eq(8).show();			$('#598 option').eq(9).hide();
				
			}if((GenderVal=="595*Male") && (SubjectVal=="593*Physics" ||SubjectVal=="593*Maths" ||SubjectVal=="593*Chemistry(Math)") && (formVal=="596*BC-I" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("598").selectedIndex=0;
				$('#598 option').eq(1).hide();			$('#598 option').eq(2).hide();			$('#598 option').eq(3).hide();
				$('#598 option').eq(4).show();			$('#598 option').eq(5).hide();			$('#598 option').eq(6).hide();
				$('#598 option').eq(7).hide();			$('#598 option').eq(8).hide();			$('#598 option').eq(9).hide();
				
			}if((GenderVal=="595*Male") && (SubjectVal=="593*Physics" ||SubjectVal=="593*Maths" ||SubjectVal=="593*Chemistry(Math)") && (formVal=="596*SC" ||formVal=="596*ST" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("598").selectedIndex=0;
				$('#598 option').eq(1).show();			$('#598 option').eq(2).hide();			$('#598 option').eq(3).hide();
				$('#598 option').eq(4).hide();			$('#598 option').eq(5).hide();			$('#598 option').eq(6).hide();
				$('#598 option').eq(7).hide();			$('#598 option').eq(8).hide();			$('#598 option').eq(9).hide();
				
			}if((GenderVal=="595*Female") && (SubjectVal=="593*Physics" ||SubjectVal=="593*Maths" ||SubjectVal=="593*Chemistry(Math)") && (formVal=="596*General" ||formVal=="596*SC" ||formVal=="596*ST" ||formVal=="596*BC-I" ||formVal=="596*BC-II" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("598").selectedIndex=0;
				$('#598 option').eq(1).show();			$('#598 option').eq(2).hide();			$('#598 option').eq(3).hide();
				$('#598 option').eq(4).hide();			$('#598 option').eq(5).hide();			$('#598 option').eq(6).hide();
				$('#598 option').eq(7).hide();			$('#598 option').eq(8).hide();			$('#598 option').eq(9).hide();
				
			}else if((GenderVal=="595*Male") && (SubjectVal=="593*Zoology" ||SubjectVal=="593*Botany" ||SubjectVal=="593*Chemistry(Bio)") && (formVal=="596*General" ||formVal=="596*BC-II" ))
			{
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("598").selectedIndex=0;
				$('#598 option').eq(1).hide();			$('#598 option').eq(2).hide();			$('#598 option').eq(3).hide();
				$('#598 option').eq(4).hide();			$('#598 option').eq(5).hide();			$('#598 option').eq(6).hide();
				$('#598 option').eq(7).hide();			$('#598 option').eq(8).hide();			$('#598 option').eq(9).show();
				
			}else if((GenderVal=="595*Male") && (SubjectVal=="593*Zoology" ||SubjectVal=="593*Botany" ||SubjectVal=="593*Chemistry(Bio)") && (formVal=="596*BC-I" ))
			{
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("598").selectedIndex=0;
				$('#598 option').eq(1).hide();			$('#598 option').eq(2).hide();			$('#598 option').eq(3).hide();
				$('#598 option').eq(4).hide();			$('#598 option').eq(5).show();			$('#598 option').eq(6).hide();
				$('#598 option').eq(7).hide();			$('#598 option').eq(8).hide();			$('#598 option').eq(9).hide();
				
			}else if((GenderVal=="595*Male") && (SubjectVal=="593*Zoology" ||SubjectVal=="593*Botany" ||SubjectVal=="593*Chemistry(Bio)") && (formVal=="596*SC" ||formVal=="596*ST" ))
			{
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("598").selectedIndex=0;
				$('#598 option').eq(1).show();			$('#598 option').eq(2).hide();			$('#598 option').eq(3).hide();
				$('#598 option').eq(4).hide();			$('#598 option').eq(5).hide();			$('#598 option').eq(6).hide();
				$('#598 option').eq(7).hide();			$('#598 option').eq(8).hide();			$('#598 option').eq(9).hide();
				
			}else if((GenderVal=="595*Female") && (SubjectVal=="593*Zoology" ||SubjectVal=="593*Botany" ||SubjectVal=="593*Chemistry(Bio)") && (formVal=="596*General" ||formVal=="596*SC" ||formVal=="596*ST" ||formVal=="596*BC-I" ||formVal=="596*BC-II" ))
			{
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("598").selectedIndex=0;
				$('#598 option').eq(1).show();			$('#598 option').eq(2).hide();			$('#598 option').eq(3).hide();
				$('#598 option').eq(4).hide();			$('#598 option').eq(5).hide();			$('#598 option').eq(6).hide();
				$('#598 option').eq(7).hide();			$('#598 option').eq(8).hide();			$('#598 option').eq(9).hide();
				
			}else if((GenderVal=="595*Male") && (SubjectVal=="593*History" ||SubjectVal=="593*Political Science" ||SubjectVal=="593*Economics" ||SubjectVal=="593*Philosphy" ||SubjectVal=="593*Hindi" ||SubjectVal=="593*English" ||SubjectVal=="593*URDU" ||SubjectVal=="593*Sanskrit") && (formVal=="596*General" ||formVal=="596*BC-II" ))
			{
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("598").selectedIndex=0;
				$('#598 option').eq(1).hide();			$('#598 option').eq(2).hide();			$('#598 option').eq(3).hide();
				$('#598 option').eq(4).hide();			$('#598 option').eq(5).hide();			$('#598 option').eq(6).show();
				$('#598 option').eq(7).hide();			$('#598 option').eq(8).hide();			$('#598 option').eq(9).hide();
				
			}else if((GenderVal=="595*Male") && (SubjectVal=="593*History" ||SubjectVal=="593*Political Science" ||SubjectVal=="593*Economics" ||SubjectVal=="593*Philosphy" ||SubjectVal=="593*Hindi" ||SubjectVal=="593*English" ||SubjectVal=="593*URDU" ||SubjectVal=="593*Sanskrit") && (formVal=="596*BC-I" ))
			{
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("598").selectedIndex=0;
				$('#598 option').eq(1).hide();			$('#598 option').eq(2).show();			$('#598 option').eq(3).hide();
				$('#598 option').eq(4).hide();			$('#598 option').eq(5).hide();			$('#598 option').eq(6).hide();
				$('#598 option').eq(7).hide();			$('#598 option').eq(8).hide();			$('#598 option').eq(9).hide();
				
			}else if((GenderVal=="595*Male") && (SubjectVal=="593*History" ||SubjectVal=="593*Political Science" ||SubjectVal=="593*Economics" ||SubjectVal=="593*Philosphy" ||SubjectVal=="593*Hindi" ||SubjectVal=="593*English" ||SubjectVal=="593*URDU" ||SubjectVal=="593*Sanskrit") && (formVal=="596*SC" ||formVal=="596*ST" ))
			{
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("598").selectedIndex=0;
				$('#598 option').eq(1).show();			$('#598 option').eq(2).hide();			$('#598 option').eq(3).hide();
				$('#598 option').eq(4).hide();			$('#598 option').eq(5).hide();			$('#598 option').eq(6).hide();
				$('#598 option').eq(7).hide();			$('#598 option').eq(8).hide();			$('#598 option').eq(9).hide();
				
			}else if((GenderVal=="595*Female") && (SubjectVal=="593*History" ||SubjectVal=="593*Political Science" ||SubjectVal=="593*Economics" ||SubjectVal=="593*Philosphy" ||SubjectVal=="593*Hindi" ||SubjectVal=="593*English" ||SubjectVal=="593*URDU" ||SubjectVal=="593*Sanskrit") && (formVal=="596*General" ||formVal=="596*SC" ||formVal=="596*ST" ||formVal=="596*BC-I" ||formVal=="596*BC-II" ))
			{
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("598").selectedIndex=0;
				$('#598 option').eq(1).show();			$('#598 option').eq(2).hide();			$('#598 option').eq(3).hide();
				$('#598 option').eq(4).hide();			$('#598 option').eq(5).hide();			$('#598 option').eq(6).hide();
				$('#598 option').eq(7).hide();			$('#598 option').eq(8).hide();			$('#598 option').eq(9).hide();
				
			}else if((GenderVal=="595*Male") && (SubjectVal=="593*Psychology" ) && (formVal=="596*General" ||formVal=="596*BC-II" ))
			{
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("598").selectedIndex=0;
				$('#598 option').eq(1).hide();			$('#598 option').eq(2).hide();			$('#598 option').eq(3).hide();
				$('#598 option').eq(4).hide();			$('#598 option').eq(5).hide();			$('#598 option').eq(6).hide();
				$('#598 option').eq(7).show();			$('#598 option').eq(8).hide();			$('#598 option').eq(9).hide();
				
			}else if((GenderVal=="595*Male") && (SubjectVal=="593*Psychology" ) && (formVal=="596*BC-I" ))
			{
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("598").selectedIndex=0;
				$('#598 option').eq(1).hide();			$('#598 option').eq(2).hide();			$('#598 option').eq(3).show();
				$('#598 option').eq(4).hide();			$('#598 option').eq(5).hide();			$('#598 option').eq(6).hide();
				$('#598 option').eq(7).hide();			$('#598 option').eq(8).hide();			$('#598 option').eq(9).hide();
				
			}else if((GenderVal=="595*Male") && (SubjectVal=="593*Psychology" ) && (formVal=="596*SC" ||formVal=="596*ST" ))
			{
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("598").selectedIndex=0;
				$('#598 option').eq(1).show();			$('#598 option').eq(2).hide();			$('#598 option').eq(3).hide();
				$('#598 option').eq(4).hide();			$('#598 option').eq(5).hide();			$('#598 option').eq(6).hide();
				$('#598 option').eq(7).hide();			$('#598 option').eq(8).hide();			$('#598 option').eq(9).hide();
				
			}else if((GenderVal=="595*Female") && (SubjectVal=="593*Psychology" ) && (formVal=="596*General" ||formVal=="596*SC" ||formVal=="596*ST" ||formVal=="596*BC-I" ||formVal=="596*BC-II" ))
			{
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("598").selectedIndex=0;
				$('#598 option').eq(1).show();			$('#598 option').eq(2).hide();			$('#598 option').eq(3).hide();
				$('#598 option').eq(4).hide();			$('#598 option').eq(5).hide();			$('#598 option').eq(6).hide();
				$('#598 option').eq(7).hide();			$('#598 option').eq(8).hide();			$('#598 option').eq(9).hide();
				
			}
		}
	}
}
////++++++++++++-------RN COLLEGE TDC Online Fee Form END------------++++++++++/////

////++++++++++++-------RN COLLEGE Self Financed Online Fee Form Start------------++++++++++/////

function showHideListBoxOptionsofRNCollegeSelfFinancedOnline(form_value)
{
        //alert("insideshowHideListBoxOptionsofRNCollegeIntermediate -1");
        var formVal=form_value;	
	if((formVal.indexOf("623*General")!='-1'||formVal.indexOf("623*SC")!='-1'||formVal.indexOf("623*ST")!='-1'||formVal.indexOf("623*BC-I")!='-1'||formVal.indexOf("623*BC-II")!='-1'))
	{
	var GenderVal=$("#620").val();
	var SubjectVal=$("#625").val();
	//alert("in if -2 >> "+GenderVal +", SubjectVal - "+SubjectVal+"");
	if(GenderVal==""){	
			//alert("insideshowHideListBoxOptionsofRNCollegeIntermediate -3 >> "+GenderVal);
			document.getElementById("620").selectedIndex=0;
			document.getElementById("623").focus();
			return false;
	}else {
			//alert("insideshowHideListBoxOptionsofRNCollegeIntermediate -4 >> "+GenderVal +", formVal > "+formVal+", SubjectVal - "+SubjectVal+"");
			if((GenderVal=="620*Male" ||GenderVal=="620*Female" ) && (SubjectVal=="625*Commerce" ||SubjectVal=="625*Sociology" ) && (formVal=="623*General" ||formVal=="59534*BC-II" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("621").selectedIndex=0;
				$('#621 option').eq(1).hide();			$('#621 option').eq(2).show();			$('#621 option').eq(3).hide();
				$('#621 option').eq(4).hide();
				
			}if((GenderVal=="620*Male" ||GenderVal=="620*Female" ) && (SubjectVal=="625*Commerce" ||SubjectVal=="625*Sociology" ) && (formVal=="623*BC-I" ||formVal=="623*SC" ||formVal=="623*ST" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("621").selectedIndex=0;
				$('#621 option').eq(1).show();			$('#621 option').eq(2).hide();			$('#621 option').eq(3).hide();
				$('#621 option').eq(4).hide();
			}else if((GenderVal=="620*Male" ||GenderVal=="620*Female" ) && (SubjectVal=="625*Geography" ||SubjectVal=="625*Music" ||SubjectVal=="625*Home Science" ) && (formVal=="623*General" ||formVal=="59534*BC-II" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("621").selectedIndex=0;
				$('#621 option').eq(1).hide();			$('#621 option').eq(2).hide();			$('#621 option').eq(3).hide();
				$('#621 option').eq(4).show();
			}else if((GenderVal=="620*Male" ||GenderVal=="620*Female" ) && (SubjectVal=="625*Geography" ||SubjectVal=="625*Music" ||SubjectVal=="625*Home Science" ) && (formVal=="623*BC-I" ||formVal=="623*SC" ||formVal=="623*ST" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("621").selectedIndex=0;
				$('#621 option').eq(1).hide();			$('#621 option').eq(2).hide();			$('#621 option').eq(3).show();
				$('#621 option').eq(4).hide();
			}
		}
	}
}
////++++++++++++-------RN COLLEGE Self Financed Online Fee Form END------------++++++++++/////

////++++++++++++-------RN COLLEGE Vocational Online Fee Form Start------------++++++++++/////

function showHideListBoxOptionsofRNCollegeVocationalOnline(form_value)
{
       // alert("insideshowHideListBoxOptionsofRNCollegeVocationalOnline -1");
        var val=form_value;
        //if((val.indexOf("636*BCA ")!='-1'||val.indexOf("636*BBA ")!='-1'||val.indexOf("636*B.Sc(Biotech) ")!='-1'||val.indexOf("636*PGDYS ")!='-1') && (val.indexOf("633*I ")!='-1' ||val.indexOf("633*II ")!='-1' ||val.indexOf("633*III ")!='-1'))

        if((val.indexOf("633*I")!='-1' ||val.indexOf("633*II")!='-1' ||val.indexOf("633*III")!='-1') )
        {
                var CourseVal=document.getElementById("636").selectedIndex;
               // alert("636 value  >>>> "+CourseVal);
               // alert("insideshowHideListBoxOptionsofRNCollegeVocationalOnline==2");
                if(CourseVal==0){
                        alert("Kindly Select First Course Field");	
                        document.getElementById("633").selectedIndex=0;
                        document.getElementById("636").focus();
                        return false;
                }else {
                         if((CourseVal=="1") && (val=="633*I" ))
                         {
                               // alert("iddd sss>> "+CourseVal);
                                document.getElementById("639").selectedIndex=0;
                                $('#639 option').eq(1).show();
                                $('#639 option').eq(2).hide();
                                $('#639 option').eq(3).hide();
                                $('#639 option').eq(4).hide();
                                $('#639 option').eq(5).hide();

                         }if((CourseVal=="1") && (val=="633*II" ||val=="633*III" ))
                         {
                               // alert("iddd sss>> "+CourseVal);
                                document.getElementById("639").selectedIndex=0;
                                $('#639 option').eq(1).hide();
                                $('#639 option').eq(2).show();
                                $('#639 option').eq(3).hide();
                                $('#639 option').eq(4).hide();
                                $('#639 option').eq(5).hide();

                         }else if((CourseVal=="2" ) && (val=="633*I" ||val=="633*II" ||val=="633*III" ))
                         {
                               // alert("iddd sss>> "+CourseVal);
                                document.getElementById("639").selectedIndex=0;
                                $('#639 option').eq(1).show();
                                $('#639 option').eq(2).hide();
                                $('#639 option').eq(3).hide();
                                $('#639 option').eq(4).hide();
                                $('#639 option').eq(5).hide();

                         }else if((CourseVal=="3") && (val=="633*I" ))
                         {
                               // alert("iddd sss>> "+CourseVal);
                                document.getElementById("639").selectedIndex=0;
                                $('#639 option').eq(1).hide();
                                $('#639 option').eq(2).hide();
                                $('#639 option').eq(3).show();
                                $('#639 option').eq(4).hide();
                                $('#639 option').eq(5).hide();

                         }else if((CourseVal=="3") && (val=="633*II" ||val=="633*III" ))
                         {
                               // alert("iddd sss>> "+CourseVal);
                                document.getElementById("639").selectedIndex=0;
                                $('#639 option').eq(1).hide();
                                $('#639 option').eq(2).hide();
                                $('#639 option').eq(3).hide();
                                $('#639 option').eq(4).show();
                                $('#639 option').eq(5).hide();

                         }else if((CourseVal=="4") && (val=="633*I" ||val=="633*II" ||val=="633*III" ))
                         {
                               // alert("iddd sss>> "+CourseVal);
                                document.getElementById("639").selectedIndex=0;
                                $('#639 option').eq(1).hide();
                                $('#639 option').eq(2).hide();
                                $('#639 option').eq(3).hide();
                                $('#639 option').eq(4).hide();
                                $('#639 option').eq(5).show();

                         }
                }
        }
}

////++++++++++++-------RN COLLEGE Vocational Online Fee Form END------------++++++++++/////

////++++++++++++-------RN COLLEGE Vocational PG Fee Form Start------------++++++++++/////

function showHideListBoxOptionsofRNCollegePGOnline(form_value)
{
        //alert("insideshowHideListBoxOptionsofRNCollegePGOnline -1");
        var formVal=form_value;	
	if((formVal.indexOf("604*Gen")!='-1'||formVal.indexOf("604*SC")!='-1'||formVal.indexOf("604*ST")!='-1'||formVal.indexOf("604*BC-I")!='-1'||formVal.indexOf("604*BC-II")!='-1'))
	{
	var GenderVal=$("#612").val();
	var SubjectVal=$("#606").val();
	var SemesterVal=$("#605").val();
	//alert("in if -2 >> "+GenderVal +", SubjectVal - "+SubjectVal+", SemesterVal - "+SemesterVal+"");
	if(SubjectVal==0){	
			//alert("insideshowHideListBoxOptionsofRNCollegePGOnline -3 >> "+GenderVal);
			document.getElementById("612").selectedIndex=0;
			document.getElementById("606").selectedIndex=0;
			document.getElementById("604").focus();
			return false;
	}else {
			//alert("insideshowHideListBoxOptionsofRNCollegePGOnline -4 >> "+GenderVal +", formVal > "+formVal+", SubjectVal - "+SubjectVal+", SemesterVal - "+SemesterVal+"");
			if((GenderVal=="612*Male" ) && (SubjectVal=="606*Physics" ||SubjectVal=="606*Chemistry"  ||SubjectVal=="606*Zoology" ||SubjectVal=="606*Botany" ) && (SemesterVal=="605*I" ) && (formVal=="604*Gen" ||formVal=="604*BC-I" ||formVal=="604*BC-II" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("611").selectedIndex=0;
				$('#611 option').eq(1).hide();			$('#611 option').eq(2).hide();			$('#611 option').eq(3).hide();
				$('#611 option').eq(4).hide();			$('#611 option').eq(5).hide();			$('#611 option').eq(6).hide();
				$('#611 option').eq(7).hide();			$('#611 option').eq(8).show();
				
			}if((GenderVal=="612*Male" ) && (SubjectVal=="606*Physics" ||SubjectVal=="606*Chemistry"  ||SubjectVal=="606*Zoology"  ||SubjectVal=="606*Botany"  )  && (SemesterVal=="605*III" ) && (formVal=="604*Gen" ||formVal=="604*BC-I" ||formVal=="604*BC-II" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("611").selectedIndex=0;
				$('#611 option').eq(1).hide();			$('#611 option').eq(2).hide();			$('#611 option').eq(3).hide();
				$('#611 option').eq(4).hide();			$('#611 option').eq(5).hide();			$('#611 option').eq(6).hide();
				$('#611 option').eq(7).show();			$('#611 option').eq(8).hide();
				
			}else if((GenderVal=="612*Female" ) && (SubjectVal=="606*Physics" ||SubjectVal=="606*Chemistry"  ||SubjectVal=="606*Zoology"  ||SubjectVal=="606*Botany"  )  && (SemesterVal=="605*I" ||SemesterVal=="605*III"  ) && (formVal=="604*Gen" ||formVal=="604*BC-I" ||formVal=="604*BC-II" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("611").selectedIndex=0;
				$('#611 option').eq(1).show();			$('#611 option').eq(2).hide();			$('#611 option').eq(3).hide();
				$('#611 option').eq(4).hide();			$('#611 option').eq(5).hide();			$('#611 option').eq(6).hide();
				$('#611 option').eq(7).hide();			$('#611 option').eq(8).hide();
				
			}else if((GenderVal=="612*Male" ||GenderVal=="612*Female"  ) && (SubjectVal=="606*Physics" ||SubjectVal=="606*Chemistry"  ||SubjectVal=="606*Zoology"  ||SubjectVal=="606*Botany"  )  && (SemesterVal=="605*I" ||SemesterVal=="605*III"  ) && (formVal=="604*SC" ||formVal=="604*ST" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("611").selectedIndex=0;
				$('#611 option').eq(1).show();			$('#611 option').eq(2).hide();			$('#611 option').eq(3).hide();
				$('#611 option').eq(4).hide();			$('#611 option').eq(5).hide();			$('#611 option').eq(6).hide();
				$('#611 option').eq(7).hide();			$('#611 option').eq(8).hide();
				
			}else if((GenderVal=="612*Male" ) && (SubjectVal=="606*Maths"  )  && (SemesterVal=="605*I" ) && (formVal=="604*Gen" ||formVal=="604*BC-I" ||formVal=="604*BC-II" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("611").selectedIndex=0;
				$('#611 option').eq(1).hide();			$('#611 option').eq(2).hide();			$('#611 option').eq(3).hide();
				$('#611 option').eq(4).hide();			$('#611 option').eq(5).hide();			$('#611 option').eq(6).show();
				$('#611 option').eq(7).hide();			$('#611 option').eq(8).hide();
				
			}else if((GenderVal=="612*Male" ) && (SubjectVal=="606*Maths"  )  && (SemesterVal=="605*III" ) && (formVal=="604*Gen" ||formVal=="604*BC-I" ||formVal=="604*BC-II" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("611").selectedIndex=0;
				$('#611 option').eq(1).hide();			$('#611 option').eq(2).hide();			$('#611 option').eq(3).hide();
				$('#611 option').eq(4).show();			$('#611 option').eq(5).hide();			$('#611 option').eq(6).hide();
				$('#611 option').eq(7).hide();			$('#611 option').eq(8).hide();
				
			}else if((GenderVal=="612*Female" ) && (SubjectVal=="606*Maths"  )  && (SemesterVal=="605*I" ||SemesterVal=="605*III"  ) && (formVal=="604*Gen" ||formVal=="604*BC-I" ||formVal=="604*BC-II" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("611").selectedIndex=0;
				$('#611 option').eq(1).show();			$('#611 option').eq(2).hide();			$('#611 option').eq(3).hide();
				$('#611 option').eq(4).hide();			$('#611 option').eq(5).hide();			$('#611 option').eq(6).hide();
				$('#611 option').eq(7).hide();			$('#611 option').eq(8).hide();
				
			}else if((GenderVal=="612*Male" ||GenderVal=="612*Female"  ) && (SubjectVal=="606*Maths"  )  && (SemesterVal=="605*I" ||SemesterVal=="605*III"  ) && (formVal=="604*SC" ||formVal=="604*ST" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("611").selectedIndex=0;
				$('#611 option').eq(1).show();			$('#611 option').eq(2).hide();			$('#611 option').eq(3).hide();
				$('#611 option').eq(4).hide();			$('#611 option').eq(5).hide();			$('#611 option').eq(6).hide();
				$('#611 option').eq(7).hide();			$('#611 option').eq(8).hide();
				
			}else if((GenderVal=="612*Male" ) && (SubjectVal=="606*History" ||SubjectVal=="606*Political Science" ||SubjectVal=="606*Economics" ||SubjectVal=="606*Philosophy" ||SubjectVal=="606*HindI" ||SubjectVal=="606*English" ||SubjectVal=="606*URDU" )  && (SemesterVal=="605*I" ) && (formVal=="604*Gen" ||formVal=="604*BC-I" ||formVal=="604*BC-II" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("611").selectedIndex=0;
				$('#611 option').eq(1).hide();			$('#611 option').eq(2).hide();			$('#611 option').eq(3).show();
				$('#611 option').eq(4).hide();			$('#611 option').eq(5).hide();			$('#611 option').eq(6).hide();
				$('#611 option').eq(7).hide();			$('#611 option').eq(8).hide();
				
			}else if((GenderVal=="612*Male" ) && (SubjectVal=="606*History" ||SubjectVal=="606*Political Science" ||SubjectVal=="606*Economics" ||SubjectVal=="606*Philosophy" ||SubjectVal=="606*HindI" ||SubjectVal=="606*English" ||SubjectVal=="606*URDU" )  && (SemesterVal=="605*III" ) && (formVal=="604*Gen" ||formVal=="604*BC-I" ||formVal=="604*BC-II" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("611").selectedIndex=0;
				$('#611 option').eq(1).hide();			$('#611 option').eq(2).show();			$('#611 option').eq(3).hide();
				$('#611 option').eq(4).hide();			$('#611 option').eq(5).hide();			$('#611 option').eq(6).hide();
				$('#611 option').eq(7).hide();			$('#611 option').eq(8).hide();
				
			}else if((GenderVal=="612*Female" ) && (SubjectVal=="606*History" ||SubjectVal=="606*Political Science" ||SubjectVal=="606*Economics" ||SubjectVal=="606*Philosophy" ||SubjectVal=="606*HindI" ||SubjectVal=="606*English" ||SubjectVal=="606*URDU" )  && (SemesterVal=="605*I" ||SemesterVal=="605*III" ) && (formVal=="604*Gen" ||formVal=="604*BC-I" ||formVal=="604*BC-II" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("611").selectedIndex=0;
				$('#611 option').eq(1).show();			$('#611 option').eq(2).hide();			$('#611 option').eq(3).hide();
				$('#611 option').eq(4).hide();			$('#611 option').eq(5).hide();			$('#611 option').eq(6).hide();
				$('#611 option').eq(7).hide();			$('#611 option').eq(8).hide();
				
			}else if((GenderVal=="612*Male" ||GenderVal=="612*Female" ) && (SubjectVal=="606*History" ||SubjectVal=="606*Political Science" ||SubjectVal=="606*Economics" ||SubjectVal=="606*Philosophy" ||SubjectVal=="606*HindI" ||SubjectVal=="606*English" ||SubjectVal=="606*URDU" )  && (SemesterVal=="605*I" ||SemesterVal=="605*III" ) && (formVal=="604*SC" ||formVal=="604*ST" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("611").selectedIndex=0;
				$('#611 option').eq(1).show();			$('#611 option').eq(2).hide();			$('#611 option').eq(3).hide();
				$('#611 option').eq(4).hide();			$('#611 option').eq(5).hide();			$('#611 option').eq(6).hide();
				$('#611 option').eq(7).hide();			$('#611 option').eq(8).hide();
				
			}else if((GenderVal=="612*Male" ) && (SubjectVal=="606*Psychology" )  && (SemesterVal=="605*I" ) && (formVal=="604*Gen" ||formVal=="604*BC-I" ||formVal=="604*BC-II" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("611").selectedIndex=0;
				$('#611 option').eq(1).hide();			$('#611 option').eq(2).hide();			$('#611 option').eq(3).hide();
				$('#611 option').eq(4).hide();			$('#611 option').eq(5).show();			$('#611 option').eq(6).hide();
				$('#611 option').eq(7).hide();			$('#611 option').eq(8).hide();
				
			}else if((GenderVal=="612*Male" ) && (SubjectVal=="606*Psychology" )  && (SemesterVal=="605*III" ) && (formVal=="604*Gen" ||formVal=="604*BC-I" ||formVal=="604*BC-II" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("611").selectedIndex=0;
				$('#611 option').eq(1).hide();			$('#611 option').eq(2).hide();			$('#611 option').eq(3).show();
				$('#611 option').eq(4).hide();			$('#611 option').eq(5).hide();			$('#611 option').eq(6).hide();
				$('#611 option').eq(7).hide();			$('#611 option').eq(8).hide();
				
			}else if((GenderVal=="612*Female" ) && (SubjectVal=="606*Psychology" )  && (SemesterVal=="605*I" ||SemesterVal=="605*III" ) && (formVal=="604*Gen" ||formVal=="604*BC-I" ||formVal=="604*BC-II" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("611").selectedIndex=0;
				$('#611 option').eq(1).show();			$('#611 option').eq(2).hide();			$('#611 option').eq(3).hide();
				$('#611 option').eq(4).hide();			$('#611 option').eq(5).hide();			$('#611 option').eq(6).hide();
				$('#611 option').eq(7).hide();			$('#611 option').eq(8).hide();
				
			}else if((GenderVal=="612*Male" ||GenderVal=="612*Female" ) && (SubjectVal=="606*Psychology" )  && (SemesterVal=="605*I" ||SemesterVal=="605*III" ) && (formVal=="604*SC" ||formVal=="604*ST" ))
       			 {
				//alert("iddd sss>> "+SubjectVal);
				document.getElementById("611").selectedIndex=0;
				$('#611 option').eq(1).show();			$('#611 option').eq(2).hide();			$('#611 option').eq(3).hide();
				$('#611 option').eq(4).hide();			$('#611 option').eq(5).hide();			$('#611 option').eq(6).hide();
				$('#611 option').eq(7).hide();			$('#611 option').eq(8).hide();
				
			}
		}
	}
}
////++++++++++++-------RN COLLEGE PG Online Fee Form END------------++++++++++/////
