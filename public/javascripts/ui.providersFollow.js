var $jq = jQuery.noConflict();
$jq.widget("ui.providersFollow", {
    _init: function() {
    	var self= this;
    	var $el= this.element;
    	$jq(".unfollow").live('click', function() {
    	    var provider_id = $jq(this).closest("div").attr("provider_id");
    	    var facilitator_id = $jq(this).closest("div").attr("facilitator_id");
    	    var elId = $jq(this).attr('id');
            self._unFollow(provider_id, facilitator_id, elId);
        });
    	$jq(".follow").live('click', function(){
    	    var provider_id = $jq(this).closest("div").attr("provider_id");
    	    var facilitator_id = $jq(this).closest("div").attr("facilitator_id");
    	    var elId = $jq(this).attr('id');
            self._follow(provider_id, facilitator_id, elId);
        });        

    },
    _follow: function(provider_id, facilitator_id, element_id){
        $jq.post('/providers/add_follower', {provider_id:provider_id, facilitator_id:facilitator_id}, function(data, textStatus, XMLHttpRequest){
            console.log(data);
            console.log($jq("#"+element_id));                    
            if(data == "ok"){
                $jq("#"+element_id).text($jq("#unfollowtext").val());
                $jq("#"+element_id).removeClass("follow");
                $jq("#"+element_id).addClass("unfollow");
            }
        }, "text");
    },
    _unFollow: function(provider_id, facilitator_id, element_id){
        $jq.post('/providers/remove_follower', {provider_id:provider_id, facilitator_id:facilitator_id}, function(data, textStatus, XMLHttpRequest){
            console.log(data);
            console.log($jq("#"+element_id));        
             if(data == "ok"){
                $jq("#"+element_id).text($jq("#followtext").val());
                $jq("#"+element_id).removeClass("unfollow");
                $jq("#"+element_id).addClass("follow");
            }
        }, "text");
    }
});

$jq(document).ready(function($) {    
    var fb = $jq(".providersFollow").providersFollow();
    
});
