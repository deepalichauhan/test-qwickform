function showhidelistboxoptionsofCBGKSRegularOnlineFeeForm(form_value)
        {
                var val=form_value;
                //alert("Inside of showhidelistboxoptionsofCBGKSRegularOnlineFeeForm 1");           
                if((val.indexOf("10597*I and II")!='-1'||val.indexOf("10597*III and IV")!='-1'||val.indexOf("10597*V and VI")!='-1'||val.indexOf("10597*VII and VIII")!='-1'))
                {
                //      alert("Inside of showhidelistboxoptionsofCBGKSRegularOnlineFeeForm 2");
                        var CourseVal=document.getElementById("10599").selectedIndex;
                        if(CourseVal==0){
                                alert("Kindly select Course first");
                                document.getElementById("10597").selectedIndex=0;
                                document.getElementById("10599").focus();
                                return false;
                        }else {
                        if((CourseVal=="1") && (val=="10597*I and II" || val=="10597*III and IV" || val=="10597*V and VI"))
                         {
                                document.getElementById("10596").selectedIndex=0;
                                $('#7994 option').eq(1).hide();
                                $('#7994 option').eq(2).hide();
                                $('#7994 option').eq(3).show();
                                $('#7994 option').eq(4).hide();
                        }else if((CourseVal=="1") && (val=="10597*VII and VIII"))
                         {
                                document.getElementById("10596").selectedIndex=0;
                                $('#7994 option').eq(1).hide();
                                $('#7994 option').eq(2).show();
                                $('#7994 option').eq(3).hide();
                                $('#7994 option').eq(4).hide();

                        }else if((CourseVal=="3") && (val=="10597*I and II" || val=="10597*III and IV"))
                         {
                                document.getElementById("10596").selectedIndex=0;
                                $('#7994 option').eq(1).hide();
                                $('#7994 option').eq(2).hide();
                                $('#7994 option').eq(3).hide();
                                $('#7994 option').eq(4).show();

                        }else if((CourseVal=="4") && (val=="10597*I and II" || val=="10597*III and IV" || val=="10597*V and VI"))
                         {
                                document.getElementById("10596").selectedIndex=0;
                                $('#7994 option').eq(1).show();
                                $('#7994 option').eq(2).hide();
                                $('#7994 option').eq(3).hide();
                                $('#7994 option').eq(4).hide();

                        }
                }
        }

}

