

/***********************************
*   http://javascripts.vbarsan.com/
*   This notice may not be removed 
***********************************/

//-- Begin Scroller's Parameters and messages -->
//scroller's width
var swidth=650;

//scroller's height
var sheight=54;

//scroller's speed 
var sspeed=2;
var restart=sspeed;
var rspeed=sspeed;

//scroller's pause 
var spause=2000;

//scroller's background
var sbcolor="";

//messages: change to your own; use as many as you'd like; set up Hyperlinks to URLs as you normally do: <a target=... href="... URL ...">..message..</a>.
var singletext=new Array();
singletext[0] = '<strong><nobr align="center" style="color:#0573C2;"><!--FinMin has accepted the voluntary retirement of Smt. Archana Bhargava, Chairperson & Managing Director of United Bank of India w.e.f. 20/02/2014.  **-->***Get yourself registered for Mobile Banking facility through the Internet Banking   ***Customers are requested to report any Phishing Email/SMS/Suspicious Activity/Cyber Frauds etc involving Allahabad Bank  to phishing.incidents@allahabadbank.in      ***Instant Money Transfer Facility is available 24x7 through IMPS on Internet Banking  & Mobile Banking. <strong>';

//singletext[...]='...';
//-- end Parameters and message -->

//-- begin: Scroller's Algorithm -->
var ii=0;var gekso=0;if(navigator.product&&navigator.product=="Gecko"){var agt = navigator.userAgent.toLowerCase();var rvStart = agt.indexOf('rv:');var rvEnd = agt.indexOf(')', rvStart);var check15 = agt.substring(rvStart+3, rvEnd);if(parseFloat(check15)<1.8) gekso=1;}var operbr=0; operbr=navigator.userAgent.toLowerCase().indexOf('opera');
function goup(){if(sspeed!=rspeed*16){sspeed=sspeed*2;restart=sspeed;}}
function godown(){if(sspeed>rspeed){sspeed=sspeed/2;restart=sspeed;}}
function start(){
if(document.getElementById){ns6div=document.getElementById('iens6div');if(operbr!=-1)operdiv=document.getElementById('operaslider');ns6div.style.left=swidth+"px";ns6div.innerHTML=singletext[0];sizeup=ns6div.offsetWidth;if(operbr!=-1&&sizeup==swidth){operdiv.innerHTML=singletext[0];sizeup=operdiv.offsetWidth;}ns6scroll();}
else 
if(document.layers){ns4layer=document.ns4div.document.ns4div1;ns4layer.left=swidth;ns4layer.document.write(singletext[0]);ns4layer.document.close();sizeup=ns4layer.document.width;ns4scroll();}
else 
if(document.all){iediv=iens6div;iediv.style.pixelLeft=swidth+"px";iediv.innerHTML=singletext[0];sizeup=iediv.offsetWidth;iescroll();}}
function iescroll(){if(iediv.style.pixelLeft>0&&iediv.style.pixelLeft<=sspeed){iediv.style.pixelLeft=0;setTimeout("iescroll()",spause);}else 
if(iediv.style.pixelLeft>=sizeup*-1){iediv.style.pixelLeft-=sspeed+"px";setTimeout("iescroll()",100);}else{if(ii==singletext.length-1)ii=0;else ii++;iediv.style.pixelLeft=swidth+"px";iediv.innerHTML=singletext[ii];sizeup=iediv.offsetWidth;iescroll();}}
function ns4scroll(){if(ns4layer.left>0&&ns4layer.left<=sspeed){ns4layer.left=0;setTimeout("ns4scroll()",spause);}else 
if(ns4layer.left>=sizeup*-1){ns4layer.left-=sspeed;setTimeout("ns4scroll()",100);}else{if(ii==singletext.length-1)ii=0;else ii++;ns4layer.left=swidth;ns4layer.document.write(singletext[ii]);ns4layer.document.close();sizeup=ns4layer.document.width;ns4scroll();}}
function ns6scroll(){if(parseInt(ns6div.style.left)>0&&parseInt(ns6div.style.left)<=sspeed){ns6div.style.left=0;setTimeout("ns6scroll()",spause);}else if(parseInt(ns6div.style.left)>=sizeup*-1){ns6div.style.left=parseInt(ns6div.style.left)-sspeed+"px";setTimeout("ns6scroll()",50);}
else{if(ii==singletext.length-1)ii=0;else ii++;
ns6div.style.left=swidth+"px";ns6div.innerHTML=singletext[ii];sizeup=ns6div.offsetWidth;if(operbr!=-1&&sizeup==swidth){operdiv.innerHTML=singletext[ii];sizeup=operdiv.offsetWidth;}ns6scroll();}}
//-- end Algorithm -->