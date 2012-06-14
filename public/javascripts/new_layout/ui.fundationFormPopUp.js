jQuery(document).ready(function(jQuery) {
      
    jQuery(".edit_fundation").submit(function(e){
      e.preventDefault();
      sendFormFundation();
     }); 
       
});

function sendFormFundation(doNotShowMessage){
  var form = jQuery(".edit_fundation").closest("form");
  var action = form.attr("action");
  var serialized_form = form.serialize();
  action = action.substr(0,action.indexOf('?'));
    jQuery.post(action+".json", serialized_form, function(data){
       if (data.resp == 'ok'){
        if(doNotShowMessage == null){       
          jQuery("#alert-msg p").html("Datos del Proyecto Social Actualizados");
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
