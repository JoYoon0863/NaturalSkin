function idFind(value){
	if(value == "1"){
		document.getElementById('email').style.display = "";
		document.getElementById('phone').style.display = "none";
	}
	else if(value == "2"){
		document.getElementById('email').style.display = "none"; 
		document.getElementById('phone').style.display = "";
	}
}