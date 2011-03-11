var $jq = jQuery.noConflict();
$jq.widget("ui.feedback", {
    _init: function() {
    	var self= this;
    	var $el= this.element;
        $jq(".show_feedback").click(function(){
            self._show();
        });
        
        $jq(".send_feedback").click(function(){
            self._send();
        });        
    },
    _show: function(){
        $jq("#feedback").show('blind');
        $jq(".send_feedback").show();
        $jq(".show_feedback").hide();
    },
    _send: function(){
        var men = $jq("#feedback_message").val();
        //console.log(men);
        $jq.post('/home/feedback', {men:men}, function(data, textStatus, XMLHttpRequest){
            $jq("#feedback").hide('blind');
            $jq(".send_feedback").hide();
            $jq(".show_feedback").show();
        
        }, 'text');
    }
    
});

$jq(document).ready(function($) {    
    var fb = $jq(".feedbacks").feedback();
    
});
