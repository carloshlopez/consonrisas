var $jq = jQuery.noConflict();
$jq.widget("ui.fundationsFollow", {
    _init: function() {
    	var self= this;
    	var $el= this.element;
    	$jq(".fund-unfollow").live('click', function(e) {
    	    e.preventDefault();
    	    var fundation_id = $jq(this).attr("fundation_id");
    	    var facilitator_id = $jq(this).attr("facilitator_id");
    	    var elId = $jq(this).attr('id').split("-")[1];
    	    $jq(this).hide();   	    
    	    $jq('#fund-img-'+elId).css('display', 'inline');
          self._unFollow(fundation_id, facilitator_id, elId);
      });
        
    	$jq(".fund-follow").live('click', function(e){
    	    e.preventDefault();
          var fundation_id = $jq(this).attr("fundation_id");
    	    var facilitator_id = $jq(this).attr("facilitator_id");
    	    var elId = $jq(this).attr('id').split("-")[1];
    	    $jq("#fund-img-"+elId).css('display', 'inline');
    	    $jq(this).hide();
          self._follow(fundation_id, facilitator_id, elId);
      });        
        
    },
    _follow: function(fundation_id, facilitator_id, element_id){
        $jq.post('/fundations/add_follower', {fundation_id:fundation_id, facilitator_id:facilitator_id}, function(data, textStatus, XMLHttpRequest){
            if(data == "ok"){
                $jq("#fund-"+element_id).text($jq("#unfollowtext").val());
                $jq("#fund-"+element_id).removeClass("fund-follow");
                $jq("#fund-"+element_id).addClass("fund-unfollow");
                $jq("#fund-"+element_id).show();
                $jq("#fund-img-"+element_id).hide();
            }
        }, "text");
    },
    _unFollow: function(fundation_id, facilitator_id, element_id){
        $jq.post('/fundations/remove_follower', {fundation_id:fundation_id, facilitator_id:facilitator_id}, function(data, textStatus, XMLHttpRequest){
             if(data == "ok"){
                $jq("#fund-"+element_id).text($jq("#followtext").val());
                $jq("#fund-"+element_id).removeClass("fund-unfollow");
                $jq("#fund-"+element_id).addClass("fund-follow");
                $jq("#fund-"+element_id).show();
                $jq("#fund-img-"+element_id).hide();
            }
        }, "text");
    }
});

$jq(document).ready(function($) {    
  $jq(".all-fundations").fundationsFollow();
  
  $jq(".fund-send-msg").click(function(e){
    e.preventDefault();
    var elId = $jq(this).attr("id").split("-")[2];
    $jq("#fund-send-msg-"+elId).dialog({modal:true, title:"Mensaje", width: 500, closeText:"X", show:"slide"});
  });        
      
  $jq(".fund-send-msg-button").click(function(e){
    e.preventDefault();
    var elId = $jq(this).attr("id").split("-")[4];
    
    $jq.post( "/fundations/send_msg_to_admins", { member_from: $jq("#member-from").val(), fundation_id: $jq("#fundation-id-"+elId).val(), msg:$jq("#fund-news-"+elId ).val()},
      function( data ) {
        if (data.message == "ok"){
          $jq("#fund-send-msg-message-"+elId).html("Mensaje Enviado!");
          $jq("#fund-send-msg-message-"+elId).show("slide");
          setTimeout(function(){
            $jq("#fund-send-msg-message-"+elId).hide("slide");
            $jq("#fund-send-msg-"+elId).dialog("close");
          }, 2000);
        }
        else{
          $jq("#fund-send-msg-message-"+elId).html(data);
          $jq("#fund-send-msg-message-"+elId).show("slide");
          setTimeout(function(){
            $jq("#fund-send-msg-message-"+elId).hide("slide"); 
            $jq("#fund-send-msg-"+elId).dialog("close");
            }, 2000);
        }
      }
    );
  });            
  
});
