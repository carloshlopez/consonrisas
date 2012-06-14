jQuery(document).ready(function(jQuery) {
    jQuery('.use_facebook_pic').bind('change', function() {
        if(jQuery('.use_facebook_pic').attr('checked')){
            jQuery('.custom_pic').hide();
        }
        else{
            jQuery('.custom_pic').show();
        }
    });
    
    jQuery('#facilitator_isCompany').bind('change', function() {
        if(jQuery(this).attr('checked')){
            jQuery('#company_info').slideDown();
        }
        else{
            jQuery('#company_info').slideUp();
        }
    });
    
    if(jQuery('#facilitator_isCompany').attr('checked')){
            jQuery('#company_info').show();
    }
    
    jQuery(".edit_facilitator").submit(function(e){
      e.preventDefault();
      sendFormFacilitator();  
     }); 
       
});

function sendFormFacilitator(doNotShowMessage){
  var form = jQuery(".edit_facilitator").closest("form");  
  var action = form.attr("action");
  var serialized_form = form.serialize();
  action = action.substr(0,action.indexOf('?'));
    jQuery.post(action+".json", serialized_form, function(data){
       if (data.resp == 'ok'){
        if(doNotShowMessage == null){
          jQuery("#alert-msg p").html("Datos del Facilitador Actualizados");
          jQuery("#alert-msg").slideDown().delay(2500).slideUp();
        }
       }
       else if(data.resp == 'error'){
        if(doNotShowMessage == null){
          jQuery("#alert-msg p").html("Error actualizando los datos intenta más tarde");
          jQuery("#alert-msg").slideDown().delay(2500).slideUp();
        }
       }
    });
}
