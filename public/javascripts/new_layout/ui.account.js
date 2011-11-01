var $jq = jQuery.noConflict();
$jq.widget("ui.account", {
    _init: function() {
    	var self= this;
    	var $el= this.element;
    	$el.find('#cancel_account').click(function(e){
    	  e.preventDefault();
    	  if (confirm("Esto borrará tu cuenta para siempre, seguro que deseas continuar?\nEsto no se puede deshacer")){
      	  self._showDelete();
    	  }
    	});
    	
    	$el.find('#no_cancel_account').click(function (e){
    	  e.preventDefault();
        $jq("#cancel_account").show();
        $jq('#remove_account').hide();         	  
    	});
    	
    	$el.find("#click_cancel_account").click(function(e){
    	  e.preventDefault();
    	  var url = $jq(this).attr("href");
        $jq.post( url, { "_method": "delete" },
            function(data, textStatus, XMLHttpRequest){
                alert(data);
        }, "text" );
    	});
    	
    	
    	$el.find(".auth-remove").click(function(e){
    	  e.preventDefault();
    	  if (confirm("Ya no podrás ingresar con este servicio, y no nos ayudarás a regar la voz por medio de este medio :(.\n Seguro que deseas continuar?")){
      	  var url = $jq(this).attr("href");
          $jq.post( url, { "_method": "delete" },
              function(data, textStatus, XMLHttpRequest){
                  window.location.reload(); 
          }, "text" );
        }
    	});    	
    	
 }, _showDelete: function(){
      $jq("#cancel_account").hide();
      $jq('#remove_account').show();      
    }
});

$jq(document).ready(function($) {
    $jq("#account").account();
});
