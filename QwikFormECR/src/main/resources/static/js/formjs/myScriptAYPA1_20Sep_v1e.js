

function showhidelistboxoptionsofAYPA1MembershiCategories(form_value)
	{
	        var val=form_value;
		//alert("Inside of showhideAyurvedRegistrationOnlineForm 1");		
		if((val.indexOf("7988*1st September to 30 september")!='-1'||val.indexOf("7988*1st October to 15th November")!='-1'||val.indexOf("7988*After 15th November to Stot Registration")!='-1') )
		{ 
		//	alert("Inside of showhideAyurvedRegistrationOnlineForm 2");
			var MembershipVal=document.getElementById("7995").selectedIndex;
			if(MembershipVal==0){
				alert("Kindly select Membership first");	
				document.getElementById("7988").selectedIndex=0;
				document.getElementById("7995").focus();
				return false;
			}else {
			if((MembershipVal=="1") && (val=="7988*1st September to 30 september"))
       			 {
                		document.getElementById("7994").selectedIndex=0;
				$('#7994 option').eq(1).hide();
				$('#7994 option').eq(2).hide();
				$('#7994 option').eq(3).hide();
				$('#7994 option').eq(4).hide();
				$('#7994 option').eq(5).hide();
				$('#7994 option').eq(6).hide();
				$('#7994 option').eq(7).show();
				$('#7994 option').eq(8).hide();
				$('#7994 option').eq(9).hide();
				$('#7994 option').eq(10).hide();
				$('#7994 option').eq(11).hide();
				$('#7994 option').eq(12).hide();
			}else if((MembershipVal=="1") && (val=="7988*1st October to 15th November" ))
                         {
                		document.getElementById("7994").selectedIndex=0;
				$('#7994 option').eq(1).hide();
				$('#7994 option').eq(2).hide();
				$('#7994 option').eq(3).hide();
				$('#7994 option').eq(4).hide();
				$('#7994 option').eq(5).hide();
				$('#7994 option').eq(6).hide();
				$('#7994 option').eq(7).hide();
				$('#7994 option').eq(8).show();
				$('#7994 option').eq(9).hide();
				$('#7994 option').eq(10).hide();
				$('#7994 option').eq(11).hide();
				$('#7994 option').eq(12).hide();
			}else if((MembershipVal=="1" ) && (val=="7988*After 15th November to Stot Registration" ))
                         {
				document.getElementById("7994").selectedIndex=0;
				$('#7994 option').eq(1).hide();
				$('#7994 option').eq(2).hide();
				$('#7994 option').eq(3).hide();
				$('#7994 option').eq(4).hide();
				$('#7994 option').eq(5).hide();
				$('#7994 option').eq(6).hide();
				$('#7994 option').eq(7).hide();
				$('#7994 option').eq(8).hide();
				$('#7994 option').eq(9).hide();
				$('#7994 option').eq(10).show();
				$('#7994 option').eq(11).hide();
				$('#7994 option').eq(12).hide();
			}else if((MembershipVal=="4" ) && (val=="7988*1st September to 30 september" ))
                         {
				document.getElementById("7994").selectedIndex=0;
				$('#7994 option').eq(1).hide();
				$('#7994 option').eq(2).hide();
				$('#7994 option').eq(3).hide();
				$('#7994 option').eq(4).hide();
				$('#7994 option').eq(5).hide();
				$('#7994 option').eq(6).hide();
				$('#7994 option').eq(7).hide();
				$('#7994 option').eq(8).hide();
				$('#7994 option').eq(9).show();
				$('#7994 option').eq(10).hide();
				$('#7994 option').eq(11).hide();
				$('#7994 option').eq(12).hide();
			}else if((MembershipVal=="4" ) && (val=="7988*1st October to 15th November" ))
                         {
				document.getElementById("7994").selectedIndex=0;
				$('#7994 option').eq(1).hide();
				$('#7994 option').eq(2).hide();
				$('#7994 option').eq(3).hidemyScriptAYPA1_v1c.js();
				$('#7994 option').eq(4).hide();
				$('#7994 option').eq(5).hide();
				$('#7994 option').eq(6).hide();
				$('#7994 option').eq(7).hide();
				$('#7994 option').eq(8).hide();
				$('#7994 option').eq(9).hide();
				$('#7994 option').eq(10).hide();
				$('#7994 option').eq(11).show();
				$('#7994 option').eq(12).hide();
			}else if((MembershipVal=="4" ) && (val=="7988*After 15th November to Stot Registration" ))
                         {
				document.getElementById("7994").selectedIndex=0;
				$('#7994 option').eq(1).hide();
				$('#7994 option').eq(2).hide();
				$('#7994 option').eq(3).hide();
				$('#7994 option').eq(4).hide();
				$('#7994 option').eq(5).hide();
				$('#7994 option').eq(6).hide();
				$('#7994 option').eq(7).hide();
				$('#7994 option').eq(8).hide();
				$('#7994 option').eq(9).hide();
				$('#7994 option').eq(10).hide();
				$('#7994 option').eq(11).hide();
				$('#7994 option').eq(12).show();
			}else if((MembershipVal=="5") && (val=="7988*1st September to 30 september"))
                         {
				document.getElementById("7994").selectedIndex=0;
				$('#7994 option').eq(1).hide();
				$('#7994 option').eq(2).hide();
				$('#7994 option').eq(3).hide();
				$('#7994 option').eq(4).show();
				$('#7994 option').eq(5).hide();
				$('#7994 option').eq(6).hide();
				$('#7994 option').eq(7).hide();
				$('#7994 option').eq(8).hide();
				$('#7994 option').eq(9).hide();
				$('#7994 option').eq(10).hide();
				$('#7994 option').eq(11).hide();
				$('#7994 option').eq(12).hide();
			}else if((MembershipVal=="5" ) && (val=="7988*1st October to 15th November"))
                         {
                		document.getElementById("7994").selectedIndex=0;
				$('#7994 option').eq(1).hide();
				$('#7994 option').eq(2).hide();
				$('#7994 option').eq(3).hide();
				$('#7994 option').eq(4).hide();
				$('#7994 option').eq(5).hide();
				$('#7994 option').eq(6).show();
				$('#7994 option').eq(7).hide();
				$('#7994 option').eq(8).hide();
				$('#7994 option').eq(9).hide();
				$('#7994 option').eq(10).hide();
				$('#7994 option').eq(11).hide();
				$('#7994 option').eq(12).hide();
			}else if((MembershipVal=="5" ) && (val=="7988*After 15th November to Stot Registration"))
                         {
				document.getElementById("7994").selectedIndex=0;
				$('#7994 option').eq(1).hide();
				$('#7994 option').eq(2).hide();
				$('#7994 option').eq(3).hide();
				$('#7994 option').eq(4).hide();
				$('#7994 option').eq(5).hide();
				$('#7994 option').eq(6).hide();
				$('#7994 option').eq(7).show();
				$('#7994 option').eq(8).hide();
				$('#7994 option').eq(9).hide();
				$('#7994 option').eq(10).hide();
				$('#7994 option').eq(11).hide();
				$('#7994 option').eq(12).hide();
			}else if((MembershipVal=="6" ) && (val=="7988*1st September to 30 september"))
                         {
				document.getElementById("7994").selectedIndex=0;
				$('#7994 option').eq(1).show();
				$('#7994 option').eq(2).hide();
				$('#7994 option').eq(3).hide();
				$('#7994 option').eq(4).hide();
				$('#7994 option').eq(5).hide();
				$('#7994 option').eq(6).hide();
				$('#7994 option').eq(7).hide();
				$('#7994 option').eq(8).hide();
				$('#7994 option').eq(9).hide();
				$('#7994 option').eq(10).hide();
				$('#7994 option').eq(11).hide();
				$('#7994 option').eq(12).hide();
			}else if((MembershipVal=="6" ) && (val=="7988*1st October to 15th November"))
                         {
				document.getElementById("7994").selectedIndex=0;
				$('#7994 option').eq(1).hide();
				$('#7994 option').eq(2).show();
				$('#7994 option').eq(3).hide();
				$('#7994 option').eq(4).hide();
				$('#7994 option').eq(5).hide();
				$('#7994 option').eq(6).hide();
				$('#7994 option').eq(7).hide();
				$('#7994 option').eq(8).hide();
				$('#7994 option').eq(9).hide();
				$('#7994 option').eq(10).hide();
				$('#7994 option').eq(11).hide();
				$('#7994 option').eq(12).hide();
			}else if((MembershipVal=="6" ) && (val=="7988*After 15th November to Stot Registration"))
                         {
				document.getElementById("7994").selectedIndex=0;
				$('#7994 option').eq(1).hide();
				$('#7994 option').eq(2).hide();
				$('#7994 option').eq(3).show();
				$('#7994 option').eq(4).hide();
				$('#7994 option').eq(5).hide();
				$('#7994 option').eq(6).hide();
				$('#7994 option').eq(7).hide();
				$('#7994 option').eq(8).hide();
				$('#7994 option').eq(9).hide();
				$('#7994 option').eq(10).hide();
				$('#7994 option').eq(11).hide();
				$('#7994 option').eq(12).hide();
			
			}
		}
	}

}
