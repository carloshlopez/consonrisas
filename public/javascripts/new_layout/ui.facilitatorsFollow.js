var $jq = jQuery.noConflict();
$jq.widget("ui.facilitatorsFollow", {
    _init: function() {
    	var self= this;
    	var $el= this.element;
    	$jq(".unfollow").live('click', function(e) {
    	    e.preventDefault();
    	    var followed_id = $jq(this).attr("followed_id");
    	    var facilitator_id = $jq(this).attr("facilitator_id");
    	    var elId = $jq(this).attr('id').split("-")[1];
    	    $jq(this).hide();   	    
    	    $jq('#fac-img-'+elId).css('display', 'inline');
    	    console.log(followed_id +" " + facilitator_id + " " + elId);    	    
          self._unFollow(followed_id, facilitator_id, elId);
      });
        
    	$jq(".follow").live('click', function(e){
    	    e.preventDefault();
        	console.log($jq(this));
          var followed_id = $jq(this).attr("followed_id");
    	    var facilitator_id = $jq(this).attr("facilitator_id");
    	    var elId = $jq(this).attr('id').split("-")[1];
    	    $jq("#fac-img-"+elId).css('display', 'inline');
    	    $jq(this).hide();
    	    console.log(followed_id +" " + facilitator_id + " " + elId);
          self._follow(followed_id, facilitator_id, elId);
      });        
        
      $jq(".send-msg").click(function(e){
          e.preventDefault();
         var elId = $jq(this).attr("id").split("-")[1];
         console.log("Clicked message send " + elId);
         $jq("#send-msg-"+elId).dialog({modal:true, title:"Mensaje", width: 500, closeText:"X", show:"slide"});
      });        
      
      $jq(".send-msg-button").click(function(e){
        e.preventDefault();
        var elId = $jq(this).attr("id").split("-")[3];
        console.log("Id del form: " + elId);
        var alert ={news: null, member_id: null, alert_type: 2, member_from: null};
        alert.news = $jq("#news-"+elId ).val();
        alert.member_id = $jq("#member-id-"+elId).val();
        alert.member_from = $jq("#member-from-"+elId ).val();
        
        $jq.post( "/facilitators/send_msg", { alert: alert },
          function( data ) {
            console.log(data);
            if (data.resp == "ok"){
              $jq("#send-msg-message-"+elId).html("Mensaje Enviado!");
              $jq("#send-msg-message-"+elId).show("slide");
              setTimeout(function(){
                $jq("#send-msg-message-"+elId).hide("slide");
                $jq("#send-msg-"+elId).dialog("close");
              }, 2000);
            }
            else{
              $jq("#send-msg-message-"+elId).html(data.message);
              $jq("#send-msg-message-"+elId).show("slide");
              setTimeout(function(){
                $jq("#send-msg-message-"+elId).hide("slide"); 
                $jq("#send-msg-"+elId).dialog("close");
                }, 2000);
            }
          }
        );    
        
      });      

    },
    _follow: function(followed_id, facilitator_id, element_id){
        $jq.post('/facilitators/add_follower', {followed_id:followed_id, facilitator_id:facilitator_id}, function(data, textStatus, XMLHttpRequest){
            console.log(data);
            console.log($jq("#fac-"+element_id));                    
            if(data == "ok"){
                $jq("#fac-"+element_id).text($jq("#unfollowtext").val());
                $jq("#fac-"+element_id).removeClass("follow");
                $jq("#fac-"+element_id).addClass("unfollow");
                $jq("#fac-"+element_id).show();
                $jq("#fac-img-"+element_id).hide();
            }
        }, "text");
    },
    _unFollow: function(followed_id, facilitator_id, element_id){
        $jq.post('/facilitators/remove_follower', {followed_id:followed_id, facilitator_id:facilitator_id}, function(data, textStatus, XMLHttpRequest){
            console.log(data);
            console.log($jq("#fac-"+element_id));        
             if(data == "ok"){
                $jq("#fac-"+element_id).text($jq("#followtext").val());
                $jq("#fac-"+element_id).removeClass("unfollow");
                $jq("#fac-"+element_id).addClass("follow");
                $jq("#fac-"+element_id).show();
                $jq("#fac-img-"+element_id).hide();
            }
        }, "text");
    }
});

$jq(document).ready(function($) {    
  $jq(".all-facilitators").facilitatorsFollow();
});
