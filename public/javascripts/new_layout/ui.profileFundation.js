var $jq = jQuery.noConflict();
$jq.widget("ui.profileFundation", {
    _init: function() {
    	var self= this;
    	var $el= this.element;
    	
    	$el.find(".unfollow").live('click', function(e) {
    	    e.preventDefault();
    	    var fundation_id = $jq(this).attr("fundation_id");
    	    var facilitator_id = $jq(this).attr("facilitator_id");
    	    var elId = $jq(this).attr('id').split("-")[1];
    	    $jq(this).hide();   	    
    	    $jq('#fund-img-'+elId).css('display', 'inline');
    	    console.log(fundation_id +" " + facilitator_id + " " + elId);    	    
          self._unFollow(fundation_id, facilitator_id, elId);
      });
        
    	$el.find(".follow").live('click', function(e){
    	    e.preventDefault();
        	console.log($jq(this));
          var fundation_id = $jq(this).attr("fundation_id");
    	    var facilitator_id = $jq(this).attr("facilitator_id");
    	    var elId = $jq(this).attr('id').split("-")[1];
    	    $jq("#fund-img-"+elId).css('display', 'inline');
    	    $jq(this).hide();
    	    console.log(fundation_id +" " + facilitator_id + " " + elId);
          self._follow(fundation_id, facilitator_id, elId);
      });      	
    	
    	$el.find(".my-profile-menu a").click(function(e) {
    	    e.preventDefault();
    	    var to_show = $jq(this).attr("show");
    	    console.log(to_show);    	    
          self._show(to_show);
        });
    }, _show: function(show){
      $jq(".arrow-up-profile").hide();
      $jq(".arrow-"+ show).show();
      $jq(".mine").hide();
      $jq(".my-"+ show).show(); 
    },
    _follow: function(fundation_id, facilitator_id, element_id){
        $jq.post('/fundations/add_follower',{fundation_id:fundation_id, facilitator_id:facilitator_id}, function(data, textStatus, XMLHttpRequest){
            console.log(data);
            console.log($jq("#fund-"+element_id));                    
            if(data == "ok"){
                $jq("#fund-"+element_id).text($jq("#unfollowtext").val());
                $jq("#fund-"+element_id).removeClass("follow");
                $jq("#fund-"+element_id).addClass("unfollow");
                $jq("#fund-"+element_id).show();
                $jq("#fund-img-"+element_id).hide();
            }
        }, "text");
    },
    _unFollow: function(fundation_id, facilitator_id, element_id){
        $jq.post('/fundations/remove_follower', {fundation_id:fundation_id, facilitator_id:facilitator_id}, function(data, textStatus, XMLHttpRequest){
            console.log(data);
            console.log($jq("#fund-"+element_id));        
             if(data == "ok"){
                $jq("#fund-"+element_id).text($jq("#followtext").val());
                $jq("#fund-"+element_id).removeClass("unfollow");
                $jq("#fund-"+element_id).addClass("follow");
                $jq("#fund-"+element_id).show();
                $jq("#fund-img-"+element_id).hide();
            }
        }, "text");
    }    
});

$jq(document).ready(function($) {    
  $jq("#fundation-profile").profileFundation();
    
   
  $jq(".send-msg").click(function(e){
    e.preventDefault();
    var elId = $jq(this).attr("id").split("-")[1];
    $jq("#send-msg-0").dialog({modal:true, title:"Mensaje", width: 500, closeText:"X", show:"slide"});
  });        
      
  $jq(".send-msg-button").click(function(e){
    e.preventDefault();
    var elId = $jq(this).attr("id").split("-")[3];
    console.log("Id del form: " + elId);
    
    $jq.post( "/fundations/send_msg_to_admins", { member_from: $jq("#member-from-"+elId).val(), fundation_id: $jq("#fundation-id-"+elId).val(), msg:$jq("#news-"+elId ).val()},
      function( data ) {
        console.log(data);
        if (data.message == "ok"){
          console.log(data);
          $jq("#send-msg-message-"+elId).html("Mensaje Enviado!");
          $jq("#send-msg-message-"+elId).show("slide");
          setTimeout(function(){
            $jq("#send-msg-message-"+elId).hide("slide");
            $jq("#send-msg-"+elId).dialog("close");
          }, 2000);
        }
        else{
          $jq("#send-msg-message-"+elId).html(data);
          $jq("#send-msg-message-"+elId).show("slide");
          setTimeout(function(){
            $jq("#send-msg-message-"+elId).hide("slide"); 
            $jq("#send-msg-"+elId).dialog("close");
            }, 2000);
        }
      }
    );    
  });    
    
});
