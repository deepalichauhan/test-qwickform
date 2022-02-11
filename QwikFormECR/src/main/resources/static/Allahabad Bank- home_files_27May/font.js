var min=12;
var max=14;
function increaseFontSize() {
   var p = document.getElementsByTagName('p');
   for(i=0;i<p.length;i++) {
      if(p[i].style.fontSize) {
         var s = parseInt(p[i].style.fontSize.replace("px",""));
      } else {
         var s = 12;
      }
      if(s!=max) {
         s += 1;
      }
      p[i].style.fontSize = s+"px"
   }
   
      var a = document.getElementsByTagName('a');
   for(i=0;i<a.length;i++) {
      if(a[i].style.fontSize) {
         var s = parseInt(a[i].style.fontSize.replace("px",""));
      } else {
         var s = 12;
      }
      if(s!=max) {
         s += 1;
      }
      a[i].style.fontSize = s+"px"
   }
   
   
   var span = document.getElementsByTagName('span');
   for(i=0;i<span.length;i++) {
      if(span[i].style.fontSize) {
         var s = parseInt(span[i].style.fontSize.replace("px",""));
      } else {
         var s = 12;
      }
      if(s!=max) {
         s += 1;
      }
      span[i].style.fontSize = s+"px"
   }
   
   
    var li = document.getElementsByTagName('li');
   for(i=0;i<li.length;i++) {
      if(li[i].style.fontSize) {
         var s = parseInt(li[i].style.fontSize.replace("px",""));
      } else {
         var s = 12;
      }
      if(s!=max) {
         s += 1;
      }
      li[i].style.fontSize = s+"px"
   }
   
   
   
    var strong = document.getElementsByTagName('strong');
   for(i=0;i<strong.length;i++) {
      if(strong[i].style.fontSize) {
         var s = parseInt(strong[i].style.fontSize.replace("px",""));
      } else {
         var s = 12;
      }
      if(s!=max) {
         s += 1;
      }
      strong[i].style.fontSize = s+"px"
   }
  
  var td = document.getElementsByTagName('td');
   for(i=0;i<td.length;i++) {
      if(td[i].style.fontSize) {
         var s = parseInt(td[i].style.fontSize.replace("px",""));
      } else {
         var s = 12;
      }
      if(s!=max) {
         s += 1;
      }
      td[i].style.fontSize = s+"px"
   }
  
  var table = document.getElementsByTagName('table');
   for(i=0;i<table.length;i++) {
      if(table[i].style.fontSize) {
         var s = parseInt(table[i].style.fontSize.replace("px",""));
      } else {
         var s = 12;
      }
      if(s!=max) {
         s += 1;
      }
      table[i].style.fontSize = s+"px"
   }
   
  
  var div = document.getElementsByTagName('div');
   for(i=0;i<div.length;i++) {
      if(div[i].style.fontSize) {
         var s = parseInt(div[i].style.fontSize.replace("px",""));
      } else {
         var s = 12;
      }
      if(s!=max) {
         s += 1;
      }
      div[i].style.fontSize = s+"px"
   }
   
   
  
   
}
/* ---------------- decreaseFontSize--------------------- */
function decreaseFontSize() {
   var p = document.getElementsByTagName('p');
   for(i=0;i<p.length;i++) {
      if(p[i].style.fontSize) {
         var s = parseInt(p[i].style.fontSize.replace("px",""));
      } else {
         var s = 12;
      }
      if(s!=min) {
         s -= 1;
      }
      p[i].style.fontSize = s+"px"
   } 
   
   var a = document.getElementsByTagName('a');
   for(i=0;i<a.length;i++) {
      if(a[i].style.fontSize) {
         var s = parseInt(a[i].style.fontSize.replace("px",""));
      } else {
         var s = 12;
      }
      if(s!=min) {
         s -= 1;
      }
      a[i].style.fontSize = s+"px"
   } 
   
   var span = document.getElementsByTagName('span');
   for(i=0;i<span.length;i++) {
      if(span[i].style.fontSize) {
         var s = parseInt(span[i].style.fontSize.replace("px",""));
      } else {
         var s = 12;
      }
      if(s!=min) {
         s -= 1;
      }
      span[i].style.fontSize = s+"px"
   } 
   
    var li = document.getElementsByTagName('li');
   for(i=0;i<li.length;i++) {
      if(li[i].style.fontSize) {
         var s = parseInt(li[i].style.fontSize.replace("px",""));
      } else {
         var s = 12;
      }
      if(s!=min) {
         s -= 1;
      }
      li[i].style.fontSize = s+"px"
   } 
   
    var strong = document.getElementsByTagName('strong');
   for(i=0;i<strong.length;i++) {
      if(strong[i].style.fontSize) {
         var s = parseInt(strong[i].style.fontSize.replace("px",""));
      } else {
         var s = 12;
      }
      if(s!=min) {
         s -= 1;
      }
      strong[i].style.fontSize = s+"px"
   } 
    var td = document.getElementsByTagName('td');
   for(i=0;i<td.length;i++) {
      if(td[i].style.fontSize) {
         var s = parseInt(td[i].style.fontSize.replace("px",""));
      } else {
         var s = 12;
      }
      if(s!=min) {
         s -= 1;
      }
      td[i].style.fontSize = s+"px"
   } 
   
    var table = document.getElementsByTagName('table');
   for(i=0;i<table.length;i++) {
      if(table[i].style.fontSize) {
         var s = parseInt(table[i].style.fontSize.replace("px",""));
      } else {
         var s = 12;
      }
      if(s!=min) {
         s -= 1;
      }
      table[i].style.fontSize = s+"px"
   } 
 
    var div = document.getElementsByTagName('div');
   for(i=0;i<div.length;i++) {
      if(div[i].style.fontSize) {
         var s = parseInt(div[i].style.fontSize.replace("px",""));
      } else {
         var s = 12;
      }
      if(s!=min) {
         s -= 1;
      }
      div[i].style.fontSize = s+"px"
   } 
 
   
}

/*-------------------------------*/


