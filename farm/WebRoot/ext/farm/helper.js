function getRemoteData(url,callBack){
	return request({},"post",url,callBack);
}

function fromCode2Caption(code, arrayList) {
	var items = $(arrayList);
	for(var index = 0;index<items.length;index++){     	
    	if(items[index].code==code){
			return items[index].caption;			
    	}
	}
	return "";
}

function request(object,method,methodURL,successFunction){	
	$.ajax({
        cache: true,
        type: method,
        datatype:"json",
        url:methodURL,
        data:object,
        error: function(XMLHttpRequest, textStatus, errorThrown) {
        	 alert(XMLHttpRequest.status+"\r\n"+XMLHttpRequest.readyState+"\r\n"+textStatus);
        },
        success: successFunction
    });			
 } 

function jsonRequest(object,method,methodURL,successFunction){	
	$.ajax({
        cache: true,
        type: method,
        datatype:"json",
        contentType: "application/json",
        url:methodURL,
        data:JSON.stringify(object),
        error: function(XMLHttpRequest, textStatus, errorThrown) {
        	 alert(XMLHttpRequest.status+"\r\n"+XMLHttpRequest.readyState+"\r\n"+textStatus);
        },
        success: successFunction
    });			
 }

function freshUserInfo(result){
	var usernameMenu= window.parent.document.getElementById("menu").contentWindow.document.getElementById("usernameMenu");
	var experienceMenu= window.parent.document.getElementById("menu").contentWindow.document.getElementById("experienceMenu");
	var moneyMenu= window.parent.document.getElementById("menu").contentWindow.document.getElementById("moneyMenu");
	var integralMenu= window.parent.document.getElementById("menu").contentWindow.document.getElementById("integralMenu");
	var headMenu= window.parent.document.getElementById("menu").contentWindow.document.getElementById("headMenu");
	usernameMenu.innerHTML=result.username;
	experienceMenu.innerHTML=result.experience;
	moneyMenu.innerHTML=result.money;
	integralMenu.innerHTML=result.integral;
	headMenu.src = "images/headImages/"+result.head;
}