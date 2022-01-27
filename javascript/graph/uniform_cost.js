// MIT License
// Copyright (c) 2021 Luis Espino

function sucesores(n){
    if (n[0]=='A')
        return [['B', n[1]+5,inc()], ['C', n[1]+6,inc()]]
    if (n[0]=='B')
        return [['A', n[1]+5,inc()], ['C', n[1]+6,inc()], ['D', n[1]+3,inc()], ['E', n[1]+5,inc()]]
    if (n[0]=='C')
        return [['A', n[1]+6,inc()], ['B', n[1]+6,inc()], ['E', n[1]+2,inc()]]
    if (n[0]=='D')
        return [['B', n[1]+3,inc()], ['E', n[1]+3,inc()], ['F', n[1]+4,inc()]]
    if (n[0]=='E')
        return [['B', n[1]+5,inc()], ['C', n[1]+2,inc()], ['D', n[1]+3,inc()], ['F', n[1]+1,inc()]]
    if (n[0]=='F')
        return [['D', n[1]+4,inc()], ['E', n[1]+1,inc()]]
}

function costo(start, end){
	var dot = '{'
	var list = [[start,0,inc()]];
	dot+=list[0][2]+' [label="'+list[0][0]+'"];'
	while (list.length > 0){
		var current = list.shift();
		if (current[0] == end) {			
			dot += '}'
			return dot
		}
		var temp = sucesores(current);
		//temp.reverse();
		temp.forEach(val => dot+=val[2]+' [label="'+val[0]+'"];'+current[2]+'--'+val[2]+' [label="'+val[1]+'"] ;')
		list = temp.concat(list);
		list = list.sort( function(a,b) { return a[1] - b[1] });
	}
	dot += '}'
	return dot
}

var id = 1
function inc() {
	return id++
}
