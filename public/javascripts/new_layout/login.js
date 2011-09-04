var $jq = jQuery.noConflict();
$jq(document).ready(function($) {    
    $jq(".login").click(function(e){
      e.preventDefault();
      $jq("#login-form").dialog({modal:true, title:"Ingresar", width: 400, closeText:"X", show:"clip"});
    });
});
