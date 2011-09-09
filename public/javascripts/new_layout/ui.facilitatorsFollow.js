var $jq = jQuery.noConflict();
$jq.widget("ui.facilitatorsFollow", {
    _init: function() {
    	var self= this;
    	var $el= this.element;
    	$jq(".fac-unfollow").live('click', function(e) {
    	    e.preventDefault();
    	    var followed_id = $jq(this).attr("followed_id");
    	    var facilitator_id = $jq(this).attr("facilitator_id");
    	    var elId = $jq(this).attr('id').split("-")[1];
    	    $jq(this).hide();   	    
    	    $jq('#fac-img-'+elId).css('display', 'inline');
          self._unFollow(followed_id, facilitator_id, elId);
      });
        
    	$jq(".fac-follow").live('click', function(e){
    	    e.preventDefault();
          var followed_id = $jq(this).attr("followed_id");
    	    var facilitator_id = $jq(this).attr("facilitator_id");
    	    var elId = $jq(this).attr('id').split("-")[1];
    	    $jq("#fac-img-"+elId).css('display', 'inline');
    	    $jq(this).hide();
          self._follow(followed_id, facilitator_id, elId);
      });        
        
      $jq(".fac-send-msg").click(function(e){
          e.preventDefault();
         var elId = $jq(this).attr("id").split("-")[2];
         $jq("#fac-send-msg-"+elId).dialog({modal:true, title:"Mensaje", width: 500, closeText:"X", show:"slide"});
      });        
      
      $jq(".fac-send-msg-button").click(function(e){
        e.preventDefault();
        var elId = $jq(this).attr("id").split("-")[4];
        var alert ={news: null, member_id: null, alert_type: 2, member_from: null};
        alert.news = $jq("#fac-news-"+elId ).val();
        alert.member_id = $jq("#fac-member-id-"+elId).val();
        alert.member_from = $jq("#member-from").val();
        
        $jq.post( "/facilitators/send_msg", { alert: alert },
          function( data ) {
            if (data.resp == "ok"){
              $jq("#fac-send-msg-message-"+elId).html("Mensaje Enviado!");
              $jq("#fac-send-msg-message-"+elId).show("slide");
              setTimeout(function(){
                $jq("#fac-send-msg-message-"+elId).hide("slide");
                $jq("#fac-send-msg-"+elId).dialog("close");
              }, 2000);
            }
            else{
              $jq("#fac-send-msg-message-"+elId).html(data.message);
              $jq("#fac-send-msg-message-"+elId).show("slide");
              setTimeout(function(){
                $jq("#fac-send-msg-message-"+elId).hide("slide"); 
                $jq("#fac-send-msg-"+elId).dialog("close");
                }, 2000);
            }
          }
        );    
        
      });      

    },
    _follow: function(followed_id, facilitator_id, element_id){
        $jq.post('/facilitators/add_follower', {followed_id:followed_id, facilitator_id:facilitator_id}, function(data, textStatus, XMLHttpRequest){
            if(data == "ok"){
                $jq("#fac-"+element_id).text($jq("#unfollowtext").val());
                $jq("#fac-"+element_id).removeClass("fac-follow");
                $jq("#fac-"+element_id).addClass("fac-unfollow");
                $jq("#fac-"+element_id).show();
                $jq("#fac-img-"+element_id).hide();
            }
        }, "text");
    },
    _unFollow: function(followed_id, facilitator_id, element_id){
        $jq.post('/facilitators/remove_follower', {followed_id:followed_id, facilitator_id:facilitator_id}, function(data, textStatus, XMLHttpRequest){
             if(data == "ok"){
                $jq("#fac-"+element_id).text($jq("#followtext").val());
                $jq("#fac-"+element_id).removeClass("fac-unfollow");
                $jq("#fac-"+element_id).addClass("fac-follow");
                $jq("#fac-"+element_id).show();
                $jq("#fac-img-"+element_id).hide();
            }
        }, "text");
    }
});

$jq(document).ready(function($) {    
  $jq(".all-facilitators").facilitatorsFollow();
});
