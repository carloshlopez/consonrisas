var $jq = jQuery.noConflict();
$jq(document).ready(function($) {    
    $jq(".search-text").val("Buscar ...");
    
    $jq(".search-text").focusin(function(e){
      if($(this).val() == "Buscar ..."){
        $(this).val("");
      }
    });
    
    $jq(".search-text").focusout(function(e){
      if($(this).val() == ""){
        $(this).val("Buscar ...");
      }
    });
    
    $jq(".search-triangle-button").click(function(e){
      e.preventDefault();
      if($jq(".search-text").val() == "Buscar ..."){
        $jq(".search-text").val("");
      }
      $jq("#searchform").submit();
    });
    
    $jq(".menu-search").click(function(){
      if($jq("#search-text-new").attr("style").indexOf("none") > 0){
        $jq("#search-text-new").show("drop", function(){
          $jq(".close-search").show();
        });
      }
      else{
        if($jq("#search-text-new").val() == "Buscar ..."){
          $jq("#search-text-new").val("");
        }   
        $jq("#searchform_new").submit();   
      }      
    });
    
    $jq(".close-search").click(function(){
      $jq(".close-search").hide();
      $jq("#search-text-new").hide("drop");
    });
});
