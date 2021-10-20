function select(){
	var input = document.getElementById("input");
    var selectBox = document.getElementById("select-box");
    var type = document.getElementById("delimiter");
    var state = document.getElementById("state");
    var selected = selectBox.options[selectBox.selectedIndex].text
    if(selected == "상태"){
        input.style.display = "none";
        state.style.display = "inline-block";
        type.style.display = "none";
    }
    else if(selected == "구분"){
        input.style.display = "none";
        type.style.display = "inline-block";
        state.style.display = "none";
    }
    else{
	 	input.style.display = "inline-block";
	 	state.style.display = "none";
	 	type.style.display = "none";
	}
}
