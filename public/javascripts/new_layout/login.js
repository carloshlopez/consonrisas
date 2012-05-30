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
    
    $jq(".edit-my-account-container").mouseenter(function(){
        $jq("#edit-my-account-options").stop(true, true);
        $jq("#edit-my-account-options").slideDown();
    });
    
    $jq(".edit-my-account-container").mouseleave(function(){
        $jq("#edit-my-account-options").stop(true, true);    
        $jq("#edit-my-account-options").slideUp();
    });   
    
    $jq(".edit-me-menu").click(function(){
        var dir = $(this).attr("href");
        window.location = location.protocol+"//"+location.host + "/members/edit_settings#" + dir;
    });   
    
});
