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
          self._unFollow(fundation_id, facilitator_id, elId);
      });
        
    	$el.find(".follow").live('click', function(e){
    	    e.preventDefault();
          var fundation_id = $jq(this).attr("fundation_id");
    	    var facilitator_id = $jq(this).attr("facilitator_id");
    	    var elId = $jq(this).attr('id').split("-")[1];
    	    $jq("#fund-img-"+elId).css('display', 'inline');
    	    $jq(this).hide();
          self._follow(fundation_id, facilitator_id, elId);
      });      	
    	
    	$el.find(".my-profile-menu a").click(function(e) {
    	    e.preventDefault();
    	    var to_show = $jq(this).attr("show");
          self._show(to_show);
        });
        
       $el.find('.delete_need').click(function(e) {
            e.preventDefault();
            var answer = confirm("¿Seguro que desea eliminar está necesidad?")
            if (answer){
              var need_id = $jq(this).attr("need_id");
              var fundation_id = $jq(this).attr("fundation_id");                
              var elId = $jq(this).attr("id").split("-")[2];
              $jq("#need-img-"+elId).css('display', 'inline');
              $jq(this).hide();
              self._deleteNeed(need_id,fundation_id, elId);
            }
        });          
        
        
    },_deleteNeed: function(need_id, fundation_id, elId){
        $jq.post( "/fundations/"+fundation_id+"/project_needs/"+ need_id+".json", { "_method": "delete" },
            function(data, textStatus, XMLHttpRequest){
              var obj = $jq.parseJSON(data);
              if(obj.resp == "ok"){ 
                $jq("#need-"+elId).fadeOut("slow", function(){
                  $jq("#need-"+elId).remove();
                });

              }
              else{
                alert(data);
              }
        }, "text" );
    }, _show: function(show){
      var newMargin = '35px';
      if(show == 'needs'){    
        newMargin = '122px';
      }      
      else if(show == 'events'){    
        newMargin = '208px';
      }
      else if(show == 'contact'){
        newMargin = '326px';
      }      
      $jq(".arrow-up-profile").animate({marginLeft: newMargin});    
      $jq(".mine").hide();
      $jq(".my-"+ show).show(); 
    },
    _follow: function(fundation_id, facilitator_id, element_id){
        $jq.post('/fundations/add_follower',{fundation_id:fundation_id, facilitator_id:facilitator_id}, function(data, textStatus, XMLHttpRequest){
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
    $jq("#fund-send-msg-0").dialog({modal:true, title:"Mensaje", width: 500, closeText:"X", show:"slide"});
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
