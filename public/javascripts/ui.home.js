var $jq = jQuery.noConflict();
$jq.widget("ui.home", {
    _init: function() {
    	var self= this;
    	var $el= this.element;
		$jq("div#makeMeScrollable").smoothDivScroll({ autoScroll: "onstart", autoScrollDirection: "backandforth", autoScrollStep: 1, autoScrollInterval: 15});
		
		setInterval(self._moveComments, 5000 );
        
    },
    _updateCurrent: function(current){
        $jq("."+current).closest("li").addClass("current_page_item");
    },
    _moveComments: function(){

        $jq('.last').hide('blind', 'slow');
        $jq('.show_me').show('blind', 'slow', function(){
            $jq("#events_comments").prepend($jq(".a_comment:last"));
            $jq(".a_comment:last").addClass("last");
            $jq(".a_comment:first").removeClass("last");
            $jq(".show_me").prev().addClass('show_me');
            $jq(".show_me:last").removeClass('show_me');
        });
    }
    
});

$jq(document).ready(function($) {    
    var fb = $jq("#pics").home();
    $jq('#home_event_comments').load('/home/event_comments', function() {});
});
