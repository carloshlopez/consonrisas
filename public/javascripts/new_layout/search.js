var $jq = jQuery.noConflict();
$jq(document).ready(function($) {    
    $jq("#search-text").val("Buscar ...");
    
    $jq("#search-text").focusin(function(e){
      if($(this).val() == "Buscar ..."){
        $(this).val("");
      }
    });
    
    $jq("#search-text").focusout(function(e){
      if($(this).val() == ""){
        $(this).val("Buscar ...");
      }
    });
    
    $jq(".search-triangle-button").click(function(e){
      e.preventDefault();
      if($jq("#search-text").val() == "Buscar ..."){
        $jq("#search-text").val("");
      }
      $jq("#searchform").submit();
    });
});
