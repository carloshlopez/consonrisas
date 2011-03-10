jQuery(document).ready(function($) {    
   /* $.datepicker.setDefaults( $.datepicker.regional[ "" ] );
	$( ".calendar" ).datepicker( $.datepicker.regional[ "es" ] );
    $( ".calendar" ).datepicker( "option", $.datepicker.regional[ $( '#el_locale' ).val() ] );*/
    $('.calendar').datetimepicker({
        ampm: true,
        dateFormat: 'yy-mm-dd',
        timeText: '',
	    hourText: 'Hora',
	    minuteText: 'Mins',
	    currentText: 'Ahora',
	    closeText: 'X'
    });
});
