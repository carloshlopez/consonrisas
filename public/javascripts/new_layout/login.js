var $jq = jQuery.noConflict();
$jq(document).ready(function($) {    
    $jq(".login").click(function(e){
      e.preventDefault();
      $jq("#login-form").dialog({modal:true, title:"Ingresar", width: 400, closeText:"X", show:"clip"});
    });
    
    $jq(".register").click(function(e){
      e.preventDefault();
      $jq("#register-form").dialog({modal:true, title:"Registrate", width: 400, closeText:"X", show:"clip"});
    });
    
});
