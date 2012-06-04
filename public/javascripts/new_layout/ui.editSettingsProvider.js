jQuery(function() {
	jQuery( "#tabs-provider" ).tabs();
	
	if(window.location.hash){
   var hash = window.location.hash.substring(1); 
   if(hash == "profile"){
    jQuery( "#tabs-provider" ).tabs("enable", 1);
   }
	}	
	jQuery("html").scrollTop(10);
	
});
