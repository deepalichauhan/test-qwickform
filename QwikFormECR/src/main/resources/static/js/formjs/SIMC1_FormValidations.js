function showHideListBoxOptionsofSIMC1OnlineFeeFormfor1styear(form_value)
{
        //alert("Inside showHideListBoxOptionsofSIMC1OnlineFeeFormfor1styear");
        var val=form_value;
        if((val.indexOf("10611*BSC COMPUTER APPLICATION")!='-1'|| val.indexOf("10611*BCOM COMPUTER APPLICATION")!='-1'|| val.indexOf("10611*BA COMPUTER APPLICATION")!='-1'|| val.indexOf("10611*BA HINDI")!='-1'|| val.indexOf("10611*BA ENGLISH")!='-1'|| val.indexOf("10611*BA SANSKRIT")!=-1|| val.indexOf("10611*BA HISTORY")!=-1|| val.indexOf("10611*BA GEOGRAPHY")!=-1|| val.indexOf("10611*BA POLITICAL SCIENCE")!=-1|| val.indexOf("10611*BA SOCIOLOGY")!=-1|| val.indexOf("10611*BA NAGPURI")!=-1|| val.indexOf("10611*BA KHARIA")!=-1|| val.indexOf("10611*BA KURUKH")!=-1|| val.indexOf("10611*BA ECONOMICS")!=-1|| val.indexOf("10611*BA PHILOSOPHY")!=-1|| val.indexOf("10611*BA ANTHROPOLOGY")!=-1|| val.indexOf("10611*BA PSYCHOLOGY")!=-1|| val.indexOf("10611*BA Gen")!=-1|| val.indexOf("10611*BSC ZOOLOGY")!=-1|| val.indexOf("10611*BSC BOTANY")!=-1|| val.indexOf("10611*BSC CHEMISTRY")!=-1|| val.indexOf("10611*BSC MATHEMATICS")!=-1|| val.indexOf("10611*BSC PHYSICS")!=-1|| val.indexOf("10611*BSC GEOLOGY")!=-1|| val.indexOf("10611*BCOM ACCOUNT")!=-1|| val.indexOf("10611*BCOM Gen")!=-1))
{
        if(val=="10611*BA HINDI" ||val=="10611*BA ENGLISH" ||val=="10611*BA SANSKRIT" ||val=="10611*BA HISTORY" ||val=="10611*BA POLITICAL SCIENCE" ||val=="10611*BA SOCIOLOGY" ||val=="10611*BA NAGPURI" ||val=="10611*BA KHARIA" ||val=="10611*BA KURUKH" ||val=="10611*BA ECONOMICS" ||val=="10611*BA PHILOSOPHY" ||val=="10611*BA Gen" ||val=="10611*BCOM ACCOUNT" ||val=="10611*Bcom Gen" )
{
                                document.getElementById("10622").selectedIndex=0;
                                $('#10622 option').eq(1).show();
				$('#10622 option').eq(2).hide();
				$('#10622 option').eq(3).hide();                        
        }else if(val=="10611*BA GEOGRAPHY" ||val=="10611*BA ANTHROPOLOGY" ||val=="10611*BA PSYCHOLOGY" ||val=="10611*BSC ZOOLOGY" ||val=="10611*BSC BOTANY" ||val=="10611*BSC CHEMISTRY" ||val=="10611*BSC MATHEMATICS" ||val=="10611*BSC PHYSICS" ||val=="10611*BSC GEOLOGY" )
{
                                document.getElementById("10622").selectedIndex=0;
                                $('#10622 option').eq(1).hide();
				$('#10622 option').eq(2).show();
				$('#10622 option').eq(3).hide();                        
        }else if(val=="10611*BSC COMPUTER APPLICATION" ||val=="10611*BCOM COMPUTER APPLICATION" ||val=="10611*BA COMPUTER APPLICATION" )
{
                                document.getElementById("10622").selectedIndex=0;
                                $('#10622 option').eq(1).hide();
				$('#10622 option').eq(2).hide();
				$('#10622 option').eq(3).show();                                
                }
        }
}

