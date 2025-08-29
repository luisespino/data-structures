// MIT License
// Copyright (c) 2020 Luis Espino

function successors(n){
	if (n == 1) return [2, 4, 5];
	if (n == 2) return [1, 3, 4, 5, 6];
	if (n == 3) return [2, 5, 6];
	if (n == 4) return [1, 2, 5, 7, 8];
	if (n == 5) return [1, 2, 3, 4, 6, 7 ,8, 9];
	if (n == 6) return [2, 3, 5, 8 ,9];
	if (n == 7) return [4, 5, 8];
	if (n == 8) return [4, 5, 6 ,7, 9];
	if (n == 9) return [5, 6 , 8];
}

function breadth(start, end){
	document.getElementById("log").innerHTML+="<br>".concat("<h3>Breadth First Search</h3>");
	var list = [start];
	while (list.length > 0){
		var current = list.shift();
		document.getElementById("log").innerHTML+="<br>".concat(current);
		if (current == end) {
			document.getElementById("log").innerHTML+="<br>".concat("GOAL FOUND");
			return;
		}
		var temp = successors(current);
		document.getElementById("log").innerHTML+="<br>".concat(temp);
		list = list.concat(temp);
		document.getElementById("log").innerHTML+="<br>".concat(list);
	}
	document.getElementById("log").innerHTML+="<br>".concat("GOAL NOT FOUND");	
}

function depth(start, end){
	document.getElementById("log").innerHTML+="<br><br>".concat("<h3>Depth First Search (reverse)</h3>");
	var list = [start];
	while (list.length > 0){
		var current = list.shift();
		document.getElementById("log").innerHTML+="<br>".concat(current);
		if (current == end) {
			document.getElementById("log").innerHTML+="<br>".concat("GOAL FOUND");
			return;
		}
		var temp = successors(current);
		temp.reverse();
		document.getElementById("log").innerHTML+="<br>".concat(temp);
		list = temp.concat(list);
		document.getElementById("log").innerHTML+="<br>".concat(list);
	}
	document.getElementById("log").innerHTML+="<br>".concat("GOAL NOT FOUND");	
}

breadth(1,9);
depth(1,9);