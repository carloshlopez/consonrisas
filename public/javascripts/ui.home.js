var $jq = jQuery.noConflict();
$jq.widget("ui.home", {
    _init: function() {
    	var self= this;
    	var $el= this.element;
		$jq("div#makeMeScrollable").smoothDivScroll({ autoScroll: "onstart", autoScrollDirection: "backandforth", autoScrollStep: 1, autoScrollInterval: 15});
		
		setInterval(self._moveComments, 7000 );
        
    },
    _updateCurrent: function(current){
        $jq("."+current).closest("li").addClass("current_page_item");
    },
    _moveComments: function(){
        $jq("#events_comments").prepend($jq(".a_comment:last").hide().slideDown());
    }
    
});

$jq(document).ready(function($) {    
    var fb = $jq("#pics").home();
    $jq('#home_event_comments').load('/home/event_comments', function() {});    
    
    $jq(".show_login_form").click(function(e){
      e.preventDefault();
      $jq(".register_from_home").hide();
      $jq(".login_from_home").show();      
    });
    
    $jq(".show_register_form").click(function(e){
      e.preventDefault();    
      $jq(".register_from_home").show();
      $jq(".login_from_home").hide();      
    });    
    
});
