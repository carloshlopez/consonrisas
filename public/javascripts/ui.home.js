var $jq = jQuery.noConflict();
$jq.widget("ui.home", {
    _init: function() {
    	var self= this;
    	var $el= this.element;
		$jq("div#makeMeScrollable").smoothDivScroll({ autoScroll: "onstart", autoScrollDirection: "backandforth", autoScrollStep: 1, autoScrollInterval: 15});
        
    },
    _updateCurrent: function(current){
        $jq("."+current).closest("li").addClass("current_page_item");
    }
    
});

$jq(document).ready(function($) {    
    var fb = $jq("#home").home();
});
