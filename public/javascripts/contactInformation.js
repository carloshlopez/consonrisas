jQuery(function() {
	
  jQuery(".contact_information_delete").click(function(e){
    e.preventDefault();
    var idProvider = jQuery(this).attr("member_id");
    var idInfo = jQuery(this).attr("info_id");    
    var memberType = jQuery(this).attr("member_type"); 
    var path = "/providers/";
    if (memberType == 1)
      path = "/fundations/"
    jQuery.post(path+idProvider+"/contact_informations/"+idInfo+".json", {member_type:memberType, "_method": "delete"}, function(data){
       if (data.resp == 'ok'){
        jQuery("#alert-msg p").html("Información de contacto eliminada");
        jQuery("#alert-msg").slideDown().delay(2500).slideUp();
        jQuery("#contact-info-"+idInfo).fadeOut("slow", function(){
          jQuery("#contact-info-"+idInfo).remove();
        });
        
       }
       else if(data.resp == 'error'){
        jQuery("#alert-msg p").html("Error actualizando los datos intenta más tarde");
        jQuery("#alert-msg").slideDown().delay(2500).slideUp();
       }        
    });
	});
	
	
  jQuery(".contact_information_submit").click(function(e){
    e.preventDefault();
    
      var form = jQuery(this).closest("form");
      var action = form.attr("action");
      var serialized_form = form.serialize();
      console.log(action);
      console.log(serialized_form);      
      action = action.substr(0,action.indexOf('?'));
        jQuery.post(action+".json", serialized_form, function(data){
           if (data.resp == 'ok'){
            jQuery("#alert-msg p").html("Información de contacto actualizada");
            jQuery("#alert-msg").slideDown().delay(2500).slideUp();
           }
           else if(data.resp == 'error'){
            jQuery("#alert-msg p").html("Error actualizando los datos intenta más tarde");
            jQuery("#alert-msg").slideDown().delay(2500).slideUp();
           }
        });      
    
  });
	
	
});
