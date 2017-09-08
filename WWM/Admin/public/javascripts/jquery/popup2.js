// JavaScript Document
function toggle_p(div_id_p) {
	var el = document.getElementById(div_id_p);
	if ( el.style.display == 'none' ) {	el.style.display = 'block';}
	else {el.style.display = 'none';}
}
function blanket_size_p(popUpDivVar_p) {
	if (typeof window.innerWidth != 'undefined') {
		viewportheight = window.innerHeight;
	} else {
		viewportheight = document.documentElement.clientHeight;
	}
	if ((viewportheight > document.body.parentNode.scrollHeight) && (viewportheight > document.body.parentNode.clientHeight)) {
		blanket_height = viewportheight;
	} else {
		if (document.body.parentNode.clientHeight > document.body.parentNode.scrollHeight) {
			blanket_height = document.body.parentNode.clientHeight;
		} else {
			blanket_height = document.body.parentNode.scrollHeight;
		}
	}
	var blanket_p = document.getElementById('blanket2');
	blanket_p.style.height = blanket_height + 'px';
	var popUpDiv2 = document.getElementById(popUpDivVar_p);
	popUpDiv_height=180;//150 is half popup's height
	popUpDiv2.style.top = popUpDiv_height + 'px';
}
function window_pos_p(popUpDivVar_p) {
	if (typeof window.innerWidth != 'undefined') {
		viewportwidth = window.innerHeight;
	} else {
		viewportwidth = document.documentElement.clientHeight;
	}
	if ((viewportwidth > document.body.parentNode.scrollWidth) && (viewportwidth > document.body.parentNode.clientWidth)) {
		window_width = viewportwidth;
	} else {
		if (document.body.parentNode.clientWidth > document.body.parentNode.scrollWidth) {
			window_width = document.body.parentNode.clientWidth;
		} else {
			window_width = document.body.parentNode.scrollWidth;
		}
	}
	var popUpDiv2 = document.getElementById(popUpDivVar_p);
	window_width=window_width/2-350;//150 is half popup's width
	popUpDiv2.style.left = window_width + 'px';
}
function popup_1(windowname) {
	blanket_size_p(windowname);
	window_pos_p(windowname);
	toggle_p('blanket2');
	toggle_p(windowname);		
}

