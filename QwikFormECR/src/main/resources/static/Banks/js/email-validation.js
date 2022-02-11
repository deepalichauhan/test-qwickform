function ValidateEmail(inputText)
{
	var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
	if(inputText.value.match(mailformat))
	{
		document.requestform.emailid.focus();
		//.emailid.focus();
		return true;
	}
	else
	{
		alert("You have entered an invalid email address!");
		document.requestform.emailid.focus();
		//.emailid.focus();
		return false;
	}
}

function Requestmessage(inputnm)
{
  var phoneno = /^\d{10}$/;
  if(inputnm.value.match(phoneno))
  {
      return true;
  }
  else
  {
     alert("Not a valid Phone Number");
     return false;
  }
  }
