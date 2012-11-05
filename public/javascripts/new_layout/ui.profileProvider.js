var $jq = jQuery.noConflict();
$jq.widget("ui.profileProvider", {
    _init: function() {
    	var self= this;
    	var $el= this.element;          
    	
    	$el.find(".unfollow").live('click', function(e) {
    	    e.preventDefault();
    	    var provider_id = $jq(this).attr("provider_id");
    	    var facilitator_id = $jq(this).attr("facilitator_id");
    	    var elId = $jq(this).attr('id').split("-")[1];
    	    $jq(this).hide();   	    
    	    $jq('#prov-img-'+elId).css('display', 'inline');
          self._unFollow(provider_id, facilitator_id, elId);
      });
        
    	$el.find(".follow").live('click', function(e){
    	    e.preventDefault();
          var provider_id = $jq(this).attr("provider_id");
    	    var facilitator_id = $jq(this).attr("facilitator_id");
    	    var elId = $jq(this).attr('id').split("-")[1];
    	    $jq("#prov-img-"+elId).css('display', 'inline');
    	    $jq(this).hide();
          self._follow(provider_id, facilitator_id, elId);
      });      	
    	
    	$el.find(".my-profile-menu a").click(function(e) {
    	    e.preventDefault();
    	    var to_show = $jq(this).attr("show");    	    
          self._show(to_show);
        });
    }, _show: function(show){
      var newMargin = '15px';
      if(show == 'events'){    
        newMargin = '70px';
      }
      else if (show == 'contact'){
        newMargin = '140px';
      }
      else if(show == 'shows'){
        newMargin = '245px';
      }      
      $jq(".arrow-up-profile").animate({marginLeft: newMargin});        
      $jq(".mine").hide();
      $jq(".my-"+ show).show(); 
    },
    _follow: function(provider_id, facilitator_id, element_id){
        $jq.post('/providers/add_follower',{provider_id:provider_id, facilitator_id:facilitator_id}, function(data, textStatus, XMLHttpRequest){
            if(data == "ok"){
                $jq("#prov-"+element_id).text($jq("#unfollowtext").val());
                $jq("#prov-"+element_id).removeClass("follow");
                $jq("#prov-"+element_id).addClass("unfollow");
                $jq("#prov-"+element_id).show();
                $jq("#prov-img-"+element_id).hide();
            }
        }, "text");
    },
    _unFollow: function(provider_id, facilitator_id, element_id){
        $jq.post('/providers/remove_follower', {provider_id:provider_id, facilitator_id:facilitator_id}, function(data, textStatus, XMLHttpRequest){
             if(data == "ok"){
                $jq("#prov-"+element_id).text($jq("#followtext").val());
                $jq("#prov-"+element_id).removeClass("unfollow");
                $jq("#prov-"+element_id).addClass("follow");
                $jq("#prov-"+element_id).show();
                $jq("#prov-img-"+element_id).hide();
            }
        }, "text");
    }    
});

$jq(document).ready(function($) {    
  $jq("#provider-profile").profileProvider();
    
   
  $jq(".send-msg").click(function(e){
    e.preventDefault();
    var elId = $jq(this).attr("id").split("-")[2];
    $jq("#prov-send-msg-0").dialog({modal:true, title:"Mensaje", width: 500, closeText:"X", show:"slide"});
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
