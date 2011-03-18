var $jq = jQuery.noConflict();
$jq.widget("ui.feedback", {
    _init: function() {
    	var self= this;
    	var $el= this.element;
    	$jq( "#feedback" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "blind"
		});

        $jq(".show_feedback").click(function(e){
            e.preventDefault();
            self._show();
        });
        
        $jq(".send_feedback").click(function(e){
            e.preventDefault();
            self._send();
        });        
    },
    _show: function(){
        $jq("#feedback_message").val("");
        $jq( "#feedback" ).dialog( "open" );

    },
    _send: function(){
        var men = $jq("#feedback_message").val();
        //console.log(men);
        $jq.post('/home/feedback', {men:men}, function(data, textStatus, XMLHttpRequest){
            $jq("#feedback_thx").show('blind');
            setTimeout(function() {
	            $jq("#feedback_thx").hide('blind');
                $jq( "#feedback" ).dialog( "close" );
			}, 2000 );

        
        }, 'text');
    }
    
});

$jq(document).ready(function($) {    
    var fb = $jq("#feedbacks").feedback();
    
});
