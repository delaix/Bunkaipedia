
// This function will toggle the the block visibilty for an identified div. It will also toggle the
// text of the show/hide link which must also be identified.
function toggle_div_visibility(show_hide_div, switch_text_div, show_text, hide_text) {
  hide_text = (typeof show_text == "undefined") ? '[hide]' : hide_text;
  show_text = (typeof show_text == "undefined") ? '[show]' : show_text;
	var element = document.getElementById(show_hide_div);
	var text = document.getElementById(switch_text_div);
	if(element.style.display == "block") {
    element.style.display = "none";
		text.innerHTML = show_text;
  } else {
		element.style.display = "block";
		text.innerHTML = hide_text;
	}
} 
