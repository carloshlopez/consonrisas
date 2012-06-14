jQuery(function() {
	jQuery( "#tabs-provider" ).tabs();
	
	if(window.location.hash){
   var hash = window.location.hash.substring(1); 
   if(hash == "profile"){
    jQuery( "#tabs-provider" ).tabs("enable", 1);
   }
	}	
	jQuery("html").scrollTop(10);
	
  jQuery("#show_submit").click(function(e){
    e.preventDefault();
    
      var form = jQuery(this).closest("form");
      var action = form.attr("action");
      var serialized_form = form.serialize();
      action = action.substr(0,action.indexOf('?'));
        jQuery.post(action+".json", serialized_form, function(data){
           if (data.resp == 'ok'){
            jQuery("#alert-msg p").html("Espectáculo creado");
            jQuery("#alert-msg").slideDown().delay(2500).slideUp();
           }
           else if(data.resp == 'error'){
            jQuery("#alert-msg p").html("Error actualizando los datos intenta más tarde");
            jQuery("#alert-msg").slideDown().delay(2500).slideUp();
           }
        });      
    
  });		
  
  jQuery(".show_delete").click(function(e){
    e.preventDefault();
    var idProvider = jQuery(this).attr("provider_id");
    var idShow = jQuery(this).attr("show_id");    
    jQuery.post("/providers/"+idProvider+"/shows/"+idShow+".json", {"_method": "delete"}, function(data){
       if (data.resp == 'ok'){
        jQuery("#alert-msg p").html("Espectáculo eliminado");
        jQuery("#alert-msg").slideDown().delay(2500).slideUp();
        jQuery("#show-"+idShow).fadeOut("slow", function(){
          jQuery("#show-"+idShow).remove();
        });
        
       }
       else if(data.resp == 'error'){
        jQuery("#alert-msg p").html("Error actualizando los datos intenta más tarde");
        jQuery("#alert-msg").slideDown().delay(2500).slideUp();
       }        
    });
	});  
	
});
