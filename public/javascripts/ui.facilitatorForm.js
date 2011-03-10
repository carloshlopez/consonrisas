jQuery(document).ready(function($) {
    $('.use_facebook_pic').bind('change', function() {
        if($('.use_facebook_pic').attr('checked')){
            $('.custom_pic').hide();
        }
        else{
            $('.custom_pic').show();
        }
    });
    
    var cities = [
			"Bogotá",
			"Medellín",
			"Cali",
			"Cartagena",
			"Chia",
			"Cota",
			"Barranquilla",
			"Santa Marta",
			"Envigado",
			"Guasca",
			"Bucaramanga"
		];
		$( "#facilitator_city" ).autocomplete({
			source: cities
		});
    
});
