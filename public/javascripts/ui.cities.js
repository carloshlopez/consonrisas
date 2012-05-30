jQuery(document).ready(function($) {    
    var cities = [
			"Arauca, ARA, Colombia",    
			"Armenia, QUI, Colombia",		
			"Barranquilla, ATL, Colombia",				
			"Bogotá, DC, Colombia",
			"Bucaramanga, SAN, Colombia",						
			"Cartagena, BOL, Colombia",			
			"Cúcuta, NDS, Colombia",			
			"Florencia, CAQ, Colombia",			
			"Ibagué, TOL, Colombia",			
			"Leticia, AMA, Colombia",			
			"Manizales, CAL, Colombia",			
			"Medellín, ANT, Colombia",			
			"Mitú, VAU, Colombia",			
			"Mocoa, PUT, Colombia",			
			"Montería, COR, Colombia",			
			"Neiva, HUI, Colombia",	
			"Pereira, RIS, Colombia",					
			"Popayán, CAU, Colombia",			
			//"Puerto Carreño",			
			//"Puerto Inirida",			
			"Quibdó, CHO, Colombia",			
			"Rioacha, GUA, Colombia",			
			"San Andrés, BOL, Colombia",			
			"San José del Guaviare, GUA, Colombia",			
			"Pasto, NAR, Colombia",			
			"Santa Marta, MAG, Colombia ",			
			"Cali, VAL, Colombia",			
			"Sincelejo, SUC, Colombia",	
			"Tunja, BOY, Colombia",					
			"Valledupar, CES, Colombia",			
			"Villavicencio, MET, Colombia",			
			"Yopal, CAS, Colombia",			
			"Tabio, CUN, Colombia, ",
			"Tenjo, CUN, Colombia"
		];
		
//		jQuery( ".cities" ).autocomplete({
//			source: cities,
//			open: function(event, ui) { 
//			  jQuery('.ui-autocomplete').css('z-index', 5010);
//			 }
//		});

	 jQuery(".cities").autocomplete({
		source: function (request, response) {
		 jQuery.getJSON(
			"http://gd.geobytes.com/AutoCompleteCity?callback=?&q="+request.term,
			function (data) {
//			console.log(data);
        var filtered  = cities.filter(function(element, index, array){
          return (accentsTidy(element.toLowerCase()).indexOf(accentsTidy(request.term.toLowerCase())) > -1);
        });
			  //console.log(filtered);
			 data = filtered.concat(data);
			 response(data);
			}
		 );
		},
		minLength: 2,
		select: function (event, ui) {
		 var selectedObj = ui.item;
		 jQuery(".cities").val(selectedObj.value);
		 return false;
		},
		open: function () {
		 jQuery(this).removeClass("ui-corner-all").addClass("ui-corner-top");
		 jQuery('.ui-autocomplete').css('z-index', 5010);
		},
		close: function () {
		 jQuery(this).removeClass("ui-corner-top").addClass("ui-corner-all");
		}
	 });
	 jQuery(".cities").autocomplete("option", "delay", 0);
		
    
});

accentsTidy = function(s){
        var r=s.toLowerCase();
        r = r.replace(new RegExp("\\s", 'g'),"");
        r = r.replace(new RegExp("[àáâãäå]", 'g'),"a");
        r = r.replace(new RegExp("æ", 'g'),"ae");
        r = r.replace(new RegExp("ç", 'g'),"c");
        r = r.replace(new RegExp("[èéêë]", 'g'),"e");
        r = r.replace(new RegExp("[ìíîï]", 'g'),"i");
        r = r.replace(new RegExp("ñ", 'g'),"n");                            
        r = r.replace(new RegExp("[òóôõö]", 'g'),"o");
        r = r.replace(new RegExp("œ", 'g'),"oe");
        r = r.replace(new RegExp("[ùúûü]", 'g'),"u");
        r = r.replace(new RegExp("[ýÿ]", 'g'),"y");
        r = r.replace(new RegExp("\\W", 'g'),"");
        return r;
};

