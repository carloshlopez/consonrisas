jQuery(document).ready(function($) {
    $('.use_facebook_pic').bind('change', function() {
        if($('.use_facebook_pic').attr('checked')){
            $('.custom_pic').hide();
        }
        else{
            $('.custom_pic').show();
        }
    });
    
    $('#facilitator_isCompany').bind('change', function() {
        if($(this).attr('checked')){
            $('#company_info').slideDown();
        }
        else{
            $('#company_info').slideUp();
        }
    });
    
    if($('#facilitator_isCompany').attr('checked')){
            $('#company_info').show();
    }
    
    $(".edit_facilitator").submit(function(e){
      e.preventDefault();
      var form = $(this).closest("form");
      var action = form.attr("action");
      var serialized_form = form.serialize();
      //console.log(action);
      //console.log(serialized_form);      
      action = action.substr(0,action.indexOf('?'));
        $.post(action+".json", serialized_form, function(data){
           if (data.resp == 'ok'){
            $("#alert-msg p").html("Datos del Facilitador Actualizados");
            $("#alert-msg").slideDown().delay(2500).slideUp();
           }
           else if(data.resp == 'error'){
            $("#alert-msg p").html("Error actualizando los datos intenta más tarde");
            $("#alert-msg").slideDown().delay(2500).slideUp();
           }
        });        
     }); 
       
});
