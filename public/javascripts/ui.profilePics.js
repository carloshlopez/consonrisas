var $jq = jQuery.noConflict();
jQuery(document).ready(function($) {
	$jq(".change_pic").click(function(e) {
    e.preventDefault();
    $jq("#change_pic").dialog({modal:true, title:"Cambia la foto de perfil", width: 400, closeText:"X"});
  });
});
