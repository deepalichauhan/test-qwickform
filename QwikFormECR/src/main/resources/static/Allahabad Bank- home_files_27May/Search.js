

function stripCharsInBag(s, bag) {
    for (var i = 0; i < document.getElementById("zoom_query").value.length; i++) {
        if (bag.indexOf(document.getElementById("zoom_query").value.charAt(i)) != -1) {
            alert("You have entered special characters");
            return false;
        }
        else return true;
    }
}
function check(txtvalue) {
    var iChars = "!@#$%^&*()+=-[]\\\';,./{}|\":<>?";
    if (txtvalue == "Search here") {
        alert("Please enter value for search");
    }
    else if (txtvalue == "") {
        alert("Please enter value for search");
    }
    else if (stripCharsInBag(txtvalue, iChars) == false) {
        //alert("You have entered special characters");
    }
    else 
    {
        window.location = "searchPg.aspx?zoom_query=" + txtvalue;
    }

}