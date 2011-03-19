var $jq = jQuery.noConflict();
$jq.widget("ui.homeMenu", {
    _init: function() {
    	var self= this;
    	var $el= this.element;
    	var path = window.location.pathname;
    	$el.find("li").removeClass("current_page_item");
    	if(path.indexOf('member') > 0){
        	self._updateCurrent('profile');
    	}
    	else if(path.indexOf('facilitator') > 0){
        	self._updateCurrent('facilitators');
    	}
    	else if(path.indexOf('provider') > 0){
        	self._updateCurrent('providers');
    	}
    	else if(path.indexOf('fundation') > 0){
        	self._updateCurrent('fundations');
    	}
    	else if(path.indexOf('event') > 0){
        	self._updateCurrent('events');
    	}
    	else if(path.indexOf('info') > 0){
        	self._updateCurrent('info');
    	}
    	
        $el.find("ul li a").click(function(e){
            //e.preventDefault();
            $el.find("li").removeClass("current_page_item");
            console.log($jq(this));
            var current = $jq(this).attr("class");
            self._updateCurrent(current);
        });
        
    },
    _updateCurrent: function(current){
        $jq("."+current).closest("li").addClass("current_page_item");
    }
    
});

$jq(document).ready(function($) {    
    var fb = $jq("#menu").homeMenu();
});
