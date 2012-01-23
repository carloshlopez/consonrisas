jQuery(document).ready(function($) {
      
    $(".edit_fundation").submit(function(e){
      e.preventDefault();
      var form = $(this).closest("form");
      var action = form.attr("action");
      var serialized_form = form.serialize();
      //console.log(action);
      //console.log(serialized_form);      
      action = action.substr(0,action.indexOf('?'));
        $.post(action+".json", serialized_form, function(data){
           if (data.resp == 'ok'){
            $("#alert-msg p").html("Datos del Proyecto Social Actualizados");
            $("#alert-msg").slideDown().delay(2500).slideUp();           
           }
           else if(data.resp == 'error'){
            $("#alert-msg p").html("Error actualizando los datos intenta más tarde");
            $("#alert-msg").slideDown().delay(2500).slideUp();
           }
        });        
     }); 
       
});
