var $jq = jQuery.noConflict();
$jq.widget("ui.eventAdmin", {
    _init: function() {
    	var self= this;
    	var $el= this.element;

    	$el.find('.admin_photos').click(function(e) {
            e.preventDefault();
            $el.find(".photo_upload").show();
        });
        
    	$el.find('.cancel_admin_photos').click(function(e) {
            e.preventDefault();
            $el.find(".photo_upload").hide();
        });
        
    	$el.find('.admin_videos').click(function(e) {
            e.preventDefault();
            $el.find(".video_upload").show();
        });
        
    	$el.find('.cancel_admin_videos').click(function(e) {
            e.preventDefault();
            $el.find(".video_upload").hide();
        });        
            	
    	$el.find('.ask_admin').click(function(e) {
            e.preventDefault();
            var event_id = $jq(this).closest("div").attr("event_id");
            var mem_id = $el.find("#member_id option:selected").val();
            var mail = $el.find("#ask_admin_mail").val();
            
            self._askAdmin(event_id, mem_id, mail);
        });
        
        $el.find('.remove_facilitator').click(function(e){
            e.preventDefault();
            var event_id = $jq(this).attr("event_id");
            var fac_id = $jq(this).attr("facilitator_id");
            self._removeFacilitator(event_id, fac_id);
        });
        
        $el.find('.add_facilitator').click(function(e){
            e.preventDefault();
            var event_id = $jq(this).attr("event_id");
            var fac_id = $jq(this).attr("facilitator_id");
            self._addFacilitator(event_id, fac_id);
        });
        
        $el.find('.remove_fundation').click(function(e){
            e.preventDefault();
            var event_id = $jq(this).attr("event_id");
            var fund_id = $jq(this).attr("fundation_id");
            self._removeFundation(event_id, fund_id);
        });        
        
        $el.find('.remove_provider').click(function(e){
            e.preventDefault();
            var event_id = $jq(this).attr("event_id");
            var prov_id = $jq(this).attr("provider_id");
            self._removeProvider(event_id, prov_id);
        });               
        
        $el.find(".edit-me").click(function(e){
          e.preventDefault();
          $jq("#event-edit").dialog({modal:true, title:"Editar Evento", width: 500, closeText:"X", show:"fadeIn"});
        });         
        
//        $jq('#comment_submit').click(function(e){
//            e.preventDefault();
//            var comment = $jq("#comment_comment").val();
//            self._toTwitter(comment, document.URL);
//            
//        });        
        
      	$el.find(".my-profile-menu a").click(function(e) {
    	    e.preventDefault();
    	    var to_show = $jq(this).attr("show"); 	    
          self._show(to_show);
        });

      	$el.find('.delete_comment').click(function(e) {
              e.preventDefault();
	            var answer = confirm("¿Seguro que desea eliminar este comentario?\n Esto no se puede deshacer")
              if (answer){
                var comment_id = $jq(this).attr("comment_id");
                var event_id = $jq("#event-id").val();                
                var elId = $jq(this).attr("id").split("-")[2];
                $jq("#comment-img-"+elId).css('display', 'inline');
                $jq(this).hide();
                self._deleteComment(comment_id,event_id, elId);
	            }
          });  
        
    }, _show: function(show){
      $jq(".arrow-up-profile").hide();
      $jq(".arrow-"+ show).show();
      if (show == "all" ){
        $jq(".mine").show();
      }
      else {
        $jq(".mine").hide();
        $jq(".my-"+ show).show(); 
      }
    },
    _askAdmin: function(event_id, mem_id, mail){
        var postData = {event_id:event_id, member_id:mem_id, mail:mail};
        $jq.post("/events/ask_admin", postData , function(data){
            if(data.error){
                alert("Ocurrió un error, intentar más tarde");
            }
            else{
                $jq("#ask_admin_message").show('blind',{},1000,function(){
                    setTimeout(function(){
                        $jq("#ask_admin_message").hide('blind',{}, 500);
                    }, 2000);
                });
                if($jq("#member_id option:selected").val() != "-1"){
                    $jq("#member_id option:selected").remove();
                }                
            }
        });
    },
    _addFacilitator: function(event_id, fac_id){
        var postData = {event_id:event_id, facilitator_id:fac_id};
        $jq.post("/events/add_facilitator", postData , function(data){
            if(data.error){
                alert("Ocurrió un error, intentar más tarde");
            }
            else{
                //alert("Vas a ir como facilitador a este evento");
                window.location.reload();
            }
        });
    },
    _removeFacilitator: function(event_id, fac_id){
        var postData = {event_id:event_id, facilitator_id:fac_id};
        $jq.post("/events/remove_facilitator", postData , function(data){
            if(data.error){
                alert("Ocurrió un error, intentar más tarde");
            }
            else{
                //alert("Ya no vas a ir como facilitador a este evento");
                window.location.reload();
            }
        });
    },
    _removeFundation: function(event_id, fund_id){
        var postData = {event_id:event_id, fundation_id:fund_id};
        $jq.post("/events/remove_fundation", postData , function(data){
            if(data.error){
                alert("Ocurrió un error, intentar más tarde");
            }
            else{
                alert("Esta fundación ya no va a ir a este evento");
                $jq("#fundation-going-"+fund_id).remove();
            }
        });
    },
    _removeProvider: function(event_id, prov_id){
        var postData = {event_id:event_id, provider_id:prov_id};
        $jq.post("/events/remove_provider", postData , function(data){
            if(data.error){
                alert("Ocurrió un error, intentar más tarde");
            }
            else{
                alert("Ya no vas a ir como proveedor a este evento");
                $jq("#provider-going-"+prov_id).remove();
            }
        });
    },
    _deleteComment: function(comment_id, event_id, elId){
        $jq.post( "/events/"+event_id+"/comments/"+ comment_id+".json", { "_method": "delete" },
            function(data, textStatus, XMLHttpRequest){
              var obj = $jq.parseJSON(data);
              if(obj.resp == "ok"){ 
                $jq("#comment-"+elId).fadeOut("slow", function(){
                  $jq("#comment-"+elId).remove();
                });

              }
              else{
                alert(data);
              }
        }, "text" );
    },
    _toTwitter: function(comment, url){
        $jq.getJSON("http://api.bit.ly/v3/shorten?login=carloshlopez&apiKey=R_0eb20408ca41a161a5e5d6ee90d11801&longUrl="+url+"&format=json",
          {},
          function(data) {
            if(data.status_code == "200"){
                //Trim coment to 110 characters
                if (comment.length > 110)
                {
                    comment = comment.substr(0, 110);
                }
                comment = comment + " ... " + data.data.url
            }
            else
            {
                alert(data);
            }
        });
    }
});



jQuery(document).ready(function($) {
    $jq("#ask_admin_message").hide();
    $jq("#eventAdmin").eventAdmin();
    $jq("a[rel^='prettyPhoto']").prettyPhoto({
        animation_speed:'normal',
        theme:'light_rounded',
        slideshow:3000, 
        autoplay_slideshow: false,
        opacity: 0.5,
        show_title: false,
        allow_resize: true,
        keyboard_shortcuts: true
    });    
});
