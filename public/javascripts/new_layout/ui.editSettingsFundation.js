jQuery(function() {
	jQuery( "#tabs-fundation" ).tabs();
	
	if(window.location.hash){
   var hash = window.location.hash.substring(1); 
   if(hash == "profile"){
    jQuery( "#tabs-fundation" ).tabs("enable", 1);
   }
	}	
	jQuery("html").scrollTop(0);
	
});
