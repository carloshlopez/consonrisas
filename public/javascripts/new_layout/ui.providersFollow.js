var $jq = jQuery.noConflict();
$jq.widget("ui.providersFollow", {
    _init: function() {
    	var self= this;
    	var $el= this.element;
    	$jq(".prov-unfollow").live('click', function(e) {
    	    e.preventDefault();
    	    var provider_id = $jq(this).closest("div").attr("provider_id");
    	    var facilitator_id = $jq(this).closest("div").attr("facilitator_id");
    	    var elId = $jq(this).attr('id');
    	    $jq("#prov-img-"+elId.split("-")[1]).css('display', 'inline');
    	    $jq(this).hide();    	        	    
          self._unFollow(provider_id, facilitator_id, elId);
        });
        
    	$jq(".prov-follow").live('click', function(e){
    	    e.preventDefault();    	
    	    var provider_id = $jq(this).closest("div").attr("provider_id");
    	    var facilitator_id = $jq(this).closest("div").attr("facilitator_id");
    	    var elId = $jq(this).attr('id');
    	    $jq("#prov-img-"+elId.split("-")[1]).css('display', 'inline');
    	    $jq(this).hide();
          self._follow(provider_id, facilitator_id, elId);
        });        

    },
    _follow: function(provider_id, facilitator_id, element_id){
        $jq.post('/providers/add_follower', {provider_id:provider_id, facilitator_id:facilitator_id}, function(data, textStatus, XMLHttpRequest){
            if(data == "ok"){
                $jq("#"+element_id).text($jq("#unfollowtext").val());
                $jq("#"+element_id).removeClass("prov-follow");
                $jq("#"+element_id).addClass("prov-unfollow");
                $jq("#"+element_id).show();              
          	    $jq("#prov-img-"+element_id.split("-")[1]).hide();
            }
        }, "text");
    },
    _unFollow: function(provider_id, facilitator_id, element_id){
        $jq.post('/providers/remove_follower', {provider_id:provider_id, facilitator_id:facilitator_id}, function(data, textStatus, XMLHttpRequest){
             if(data == "ok"){
                $jq("#"+element_id).text($jq("#followtext").val());
                $jq("#"+element_id).removeClass("prov-unfollow");
                $jq("#"+element_id).addClass("prov-follow");
                $jq("#"+element_id).show(); 
          	    $jq("#prov-img-"+element_id.split("-")[1]).hide();
            }
        }, "text");
    }
});

$jq(document).ready(function($) {    
  $jq(".all-providers").providersFollow();
    
    
  $jq(".prov-send-msg").click(function(e){
    e.preventDefault();
    var elId = $jq(this).attr("id").split("-")[2];
    $jq("#prov-send-msg-"+elId).dialog({modal:true, title:"Mensaje", width: 500, closeText:"X", show:"slide"});
  });        
      
  $jq(".prov-send-msg-button").click(function(e){
    e.preventDefault();
    var elId = $jq(this).attr("id").split("-")[4];
    
    $jq.post( "/providers/send_msg_to_admins", { member_from: $jq("#member-from").val(), provider_id: $jq("#provider-id-"+elId).val(), msg:$jq("#prov-news-"+elId ).val()},
      function( data ) {
        if (data.message == "ok"){
          $jq("#prov-send-msg-message-"+elId).html("Mensaje Enviado!");
          $jq("#prov-send-msg-message-"+elId).show("slide");
          setTimeout(function(){
            $jq("#prov-send-msg-message-"+elId).hide("slide");
            $jq("#prov-send-msg-"+elId).dialog("close");
          }, 2000);
        }
        else{
          $jq("#prov-send-msg-message-"+elId).html(data);
          $jq("#prov-send-msg-message-"+elId).show("slide");
          setTimeout(function(){
            $jq("#prov-send-msg-message-"+elId).hide("slide"); 
            $jq("#prov-send-msg-"+elId).dialog("close");
            }, 2000);
        }
      }
    );    
    
  });          
});
