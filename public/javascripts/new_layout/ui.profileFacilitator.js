var $jq = jQuery.noConflict();
$jq.widget("ui.profileFacilitator", {
    _init: function() {
    	var self= this;
    	var $el= this.element;
    	
    	$el.find(".unfollow").live('click', function(e) {
    	    e.preventDefault();
    	    var followed_id = $jq(this).attr("followed_id");
    	    var facilitator_id = $jq(this).attr("facilitator_id");
    	    var elId = $jq(this).attr('id').split("-")[1];
    	    $jq(this).hide();   	    
    	    $jq('#fac-img-'+elId).css('display', 'inline');
    	    console.log(followed_id +" " + facilitator_id + " " + elId);    	    
          self._unFollow(followed_id, facilitator_id, elId);
      });
        
    	$el.find(".follow").live('click', function(e){
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
  $jq("#facilitator-profile").profileFacilitator();
  
  $jq(".see-all").click(function(e){
    e.preventDefault();
    $jq("#following").dialog({modal:true, title:"Conecciones", width: 550, closeText:"X", show:"slide"});
  });  
  
  $jq(".send-msg").click(function(e){
    e.preventDefault();
    console.log("Clicked message send");
    $jq("#send-msg-0").dialog({modal:true, title:"Mensaje", width: 500, closeText:"X", show:"slide"});
  });
  
  $jq("#send-msg-button-0").click(function(e){
    e.preventDefault();
    var alert ={news: null, member_id: null, alert_type: 2, member_from: null};
    alert.news = $jq( 'textarea[name="alert[news]"]' ).val();
    alert.member_id = $jq( 'input[name="alert[member_id]"]' ).val();
    alert.member_from = $jq( 'input[name="alert[member_from]"]' ).val();
    
    $jq.post( "/facilitators/send_msg", { alert: alert },
      function( data ) {
        console.log(data);
        if (data.resp == "ok"){
          $jq(".send-msg-message").html("Mensaje Enviado!");
          $jq(".send-msg-message").show("slide");
          setTimeout(function(){
            $jq(".send-msg-message").hide("slide");
            $jq("#send-msg-0").dialog("close");
          }, 2000);
        }
        else{
          $jq(".send-msg-message").html(data.message);
          $jq(".send-msg-message").show("slide");
          setTimeout(function(){
            $jq(".send-msg-message").hide("slide"); 
            $jq("#send-msg-0").dialog("close");
            }, 2000);
        }
      }
    );    
    
  });
  
});
