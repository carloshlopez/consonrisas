var $jq = jQuery.noConflict();
$jq(document).ready(function($) {    
    $jq(".login").click(function(e){
      e.preventDefault();
      var dir = $(this).attr("direction");
      if(dir == "down"){
        $(this).attr("direction", "up");
        $jq("#login-form").slideDown();
      }
      else{
        $(this).attr("direction", "down");
        $jq("#login-form").slideUp();
      }
    });
    
    $jq(".register").live('click', function(e){
      e.preventDefault();
      $jq("#register-form").dialog({modal:true, title:"Registrate", width: 345, closeText:"X", show:"clip"});
    });
    
//    $jq(".register_wizzard").live('click', function(e){
//      e.preventDefault();
//      $jq("#register-wizzard").dialog({modal:true, title:"Registrate", width: 345, closeText:"X", show:"clip"});
//    });
    
});
