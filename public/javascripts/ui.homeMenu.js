var $jq = jQuery.noConflict();
$jq.widget("ui.homeMenu", {
    _init: function() {
    	var self= this;
    	var $el= this.element;
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
