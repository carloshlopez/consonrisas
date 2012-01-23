var $jq = jQuery.noConflict();
$jq(document).ready(function($) {    
    var cities = [
			"Arauca",    
			"Armenia",		
			"Barranquilla",				
			"Bogotá",
			"Bucaramanga",						
			"Cartagena",			
			"Cúcuta",			
			"Florencia",			
			"Ibagué",			
			"Leticia",			
			"Manizales",			
			"Medellín",			
			"Mitú",			
			"Mocoa",			
			"Montería",			
			"Neiva",	
			"Pereira",					
			"Popayán",			
			"Puerto Carreño",			
			"Puerto Inirida",			
			"Quibdó",			
			"Rioacha",			
			"San Andrés",			
			"San José del Guaviare",			
			"Pasto",			
			"Santa Marta",			
			"Cali",			
			"Sincelejo",	
			"Tunja",					
			"Valledupar",			
			"Villavicencio",			
			"Yopal",			
			"Tabio",
			"Tenjo",			
			"Tobia"
		];
		$jq( ".cities" ).autocomplete({
			source: cities,
			open: function(event, ui) { 
			  $jq('.ui-autocomplete').css('z-index', 5010);
			 }
		});
		
	
    
});
