jQuery(function() {
	jQuery( "#tabs" ).tabs();
	
	if(window.location.hash){
   var hash = window.location.hash.substring(1); 
   if(hash == "my-profile"){
    jQuery( "#tabs" ).tabs("enable", 1);
   }
	}	
	jQuery("html").scrollTop(0);
	
});
