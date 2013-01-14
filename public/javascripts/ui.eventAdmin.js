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
            var event_facilitator_id = $jq(this).attr("event_facilitator_id");
            self._removeFacilitator(event_facilitator_id);
        });
        
        $el.find('.add_facilitator').click(function(e){
            e.preventDefault();
            var going = $jq("#going_already").val();

            if (going != undefined){
              $jq("#alert-msg p").html("Para este evento tu ya haces parte de los asistentes");
              $jq("#alert-msg").slideDown().delay(2500).slideUp();  
            }
            else{
              var event_id = $jq(this).attr("event_id");
              var fac_id = $jq(this).attr("facilitator_id");
              self._addFacilitator(event_id, fac_id);
            }
        });

        $el.find('.rsvp_event').click(function(e) {
            e.preventDefault();

            var event_id = $jq(this).attr("event_id");
            var fac_id = $jq(this).attr("facilitator_id");
            self._rsvpEvent(event_id, fac_id);
        });
        
        $el.find('.remove_fundation').click(function(e){
            e.preventDefault();
            var event_fundation_id = $jq(this).attr("event_fundation_id");
            self._removeFundation(event_fundation_id);
        });       
        
        $el.find('.remove_provider').click(function(e){
            e.preventDefault();
            var event_provider_id = $jq(this).attr("event_provider_id");
            self._removeProvider(event_provider_id);
        });               
        
        $el.find(".edit-me").click(function(e){
          e.preventDefault();
          $jq("#event-edit").dialog({modal:true, title:"Editar Evento", width: 500, closeText:"X", show:"fadeIn"});
        });         
          
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
          
          
         $el.find('.delete_need').click(function(e) {
              e.preventDefault();
	            var answer = confirm("¿Seguro que desea eliminar está necesidad?\n Esto no se puede deshacer")
              if (answer){
                var need_id = $jq(this).attr("need_id");
                var event_id = $jq("#event-id").val();                
                var elId = $jq(this).attr("id").split("-")[2];
                $jq("#need-img-"+elId).css('display', 'inline');
                $jq(this).hide();
                self._deleteNeed(need_id,event_id, elId);
	            }
          });  
          
          $el.find('.help_need-event').click(function(){
            var need_id = $jq(this).attr("need_id");
            $jq(this).hide();
            $jq("#need-help-img-"+need_id).css('display', 'inline');
            var member_id = $jq(this).attr("member_id");    
            self._completeNeed(need_id, member_id);  
          });
          
          $el.find(".show-more").live('click', function(e){
            e.preventDefault();

            var targetDiv = $jq(this).attr("target_div");
            //var height = $jq("#"+targetDiv).attr('scrollHeight');            
            var height = $jq('#'+targetDiv)[0].scrollHeight;
            $jq("#"+targetDiv).animate({"height":height},"slow");
            
            $jq(this).removeClass('show-more');
            $jq(this).addClass('show-less');
            var label = $jq(this).attr("label");
            $jq("#"+label+"_less").show();
            $jq("#"+label+"_more").hide();            
          });
          
          $el.find(".show-less").live('click', function(e){
            e.preventDefault();
            var targetDiv = $jq(this).attr("target_div");
            var initialHeight = $jq(this).attr("initial_height");            
            $jq("#"+targetDiv).animate({'height':initialHeight}, "slow");
            $jq(this).removeClass('show-less');
            $jq(this).addClass('show-more');            
            var label = $jq(this).attr("label");
            $jq("#"+label+"_less").hide();
            $jq("#"+label+"_more").show();                        
          });          
        
    }, _show: function(show){
      var newMargin = '15px';
      if(show == 'comments'){    
        newMargin = '180px';
      }
      else if(show == 'needs'){
        newMargin = '80px';
      }  
      else if(show == 'pics'){
        newMargin = '270px';
      }      
      else if (show == 'assistants'){
        newMargin = '360px';
      }  
      $jq(".arrow-up-profile").animate({marginLeft: newMargin});    
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
    _rsvpEvent: function() {
      $jq("#rsvp-event").dialog({modal:true, title:"Selecciona los roles con los que asistirás", width: 550, closeText:"X", show:"fadeIn",
        open: function(){
          $jq(".ui-dialog").addClass("event-dialog");
        },
        close: function() {
          window.location.reload();
        }
      });   
    },
    _removeFacilitator: function(event_facilitator_id){
        var postData = {event_facilitator_id:event_facilitator_id};
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
    _removeFundation: function(event_fundation_id){
        var postData = {event_fundation_id:event_fundation_id};
        $jq.post("/events/remove_fundation", postData , function(data){
            if(data.error){
                alert("Ocurrió un error, intentar más tarde");
            }
            else{
                $jq("#alert-msg p").html("Este Proyecto Social ya no hace parte de los asistentes a este evento");
                $jq("#alert-msg").slideDown().delay(2500).slideUp();                  
                $jq("#fundation-going-" + event_fundation_id).remove();
            }
        });
    },
    _removeProvider: function(event_provider_id){
        var postData = {event_provider_id:event_provider_id};
        $jq.post("/events/remove_provider", postData , function(data){
            if(data.error){
                alert("Ocurrió un error, intentar más tarde");
            }
            else{
                $jq("#alert-msg p").html("Este Proveedor de Sonrisas ya no hará parte de este evento");
                $jq("#alert-msg").slideDown().delay(2500).slideUp();  
                $jq("#provider-going-" + event_provider_id).remove();
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
    _deleteNeed: function(need_id, event_id, elId){
        $jq.post( "/events/"+event_id+"/needs/"+ need_id+".json", { "_method": "delete" },
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
    },
    _completeNeed: function(need_id, memberId){
        $jq.post( "/needs/complete/"+ need_id+".json",{member_id:memberId},
            function(data, textStatus, XMLHttpRequest){
              var obj = $jq.parseJSON(data);
              if(obj.resp == "ok"){ 
                $jq("#need-help-img-"+need_id).css("display", "none");
                $jq("#need-state-"+need_id).html(obj.new_state);
                $jq("#need-state-"+need_id).effect("highlight", {color:'#00BCFA'}, 3500);
                $jq("#alert-msg p").html("Te hemos conectado con el creador del Evento para que le puedas ayudar a suplir esta necesidad");
                $jq("#alert-msg").slideDown().delay(3250).slideUp();
              }
              else{
                alert(data);
              }
        }, "text" );
    }
});

jQuery(document).ready(function($) {
    $jq("#ask_admin_message").hide();
    $jq("#eventAdmin").eventAdmin();
    $jq(".invite-facilitators-button").click(function(){
      if($jq("#is_mobile").val() == "1"){
        $jq("#invite-facilitators").dialog({modal:true, width:200, title:"Invita a tus Conexiones",closeText:"X",
        open: function(){
          $jq(".ui-dialog").addClass("event-dialog");
        }
        });
      }    
      else
      {
        $jq("#invite-facilitators").dialog({modal:true, title:"Invita a tus Conexiones", width: 550,         closeText:"X", show:"fadeIn",
        open: function(){
          $jq(".ui-dialog").addClass("event-dialog");
        }
        });      
      }      
    });
    
    $jq(".invite-fundations-button").click(function(){
      $jq("#invite-fundations").dialog({modal:true, title:"Asiste como Proyecto Social", width: 550,         closeText:"X", show:"fadeIn",
      open: function(){
        $jq(".ui-dialog").addClass("event-dialog");
      }
      });    
    });
    
    $jq(".invite-providers-button").click(function(){
      $jq("#invite-providers").dialog({modal:true, title:"Asiste como Proveedor de Sonrisas", width: 550,         closeText:"X", show:"fadeIn",
      open: function(){
        $jq(".ui-dialog").addClass("event-dialog");
      }
      });    
    });        

    $jq(".close-rsvp").click(function(e){
      e.preventDefault();
      $jq("#rsvp-event").dialog("close");
    });
    
    $jq(".invite_facilitators_send").click(function(e){
      e.preventDefault();
      var ids = new Array();
      $jq(".check_invite_fac:checked").each(function(){
        ids.push($jq(this).val());
      });
      var postData = {event_id:$jq(this).attr("event_id"), facilitators_ids:ids};
      $jq.post("/events/add_facilitators.json", postData , function(data){
          if(data.resp == "ok"){
            $jq("#alert-msg p").html("Los facilitadores serán invitados");
            $jq("#alert-msg").slideDown().delay(2500).slideUp(function(){
              window.location.reload();
            });
          }
          else{
            $jq("#alert-msg p").html(data.message);
            $jq("#alert-msg").slideDown().delay(2500).slideUp();          
          }
      });      
      
    });

    $jq('.check_add_facil').click(function(e) {
      
      var event_id = $jq(this).attr("event_id");
      var fac_id = $jq(this).attr("facilitator_id");
      var postData = {event_id:event_id, facilitator_id:fac_id};

      if ( $(e.currentTarget).is(':checked') ) {
        $jq.post("/events/add_facilitator", postData , function(data){
            if(data.error){
                alert("Ocurrió un error, intentar más tarde");
            }
        });
      } else {
        $jq.post("/events/remove_facilitator", postData , function(data){
            if(data.error){
                alert("Ocurrió un error, intentar más tarde");
            }
        });
      }
    }); 

    $jq('.check_add_fund').click(function(e) {
      var event_id = $jq(this).attr("event_id");
      var fund_id = $jq(this).attr("fundation_id");
      var postData = {event_id:event_id, fundation_id:fund_id};

      if ( $(e.currentTarget).is(':checked') ) {
        $jq.post("/events/add_fundation", postData , function(data){
            if(data.error){
                alert("Ocurrió un error, intentar más tarde");
            }
        });
      } else {
        $jq.post("/events/remove_fundation", postData , function(data){
            if(data.error){
                alert("Ocurrió un error, intentar más tarde");
            }
        });
      }
    });

    $jq('.check_add_prov').click(function(e) {
      var event_id = $jq(this).attr("event_id");
      var prov_id = $jq(this).attr("provider_id");
      var postData = {event_id:event_id, provider_id:prov_id};

      if ( $(e.currentTarget).is(':checked') ) {
        $jq.post("/events/add_provider", postData , function(data){
            if(data.error){
                alert("Ocurrió un error, intentar más tarde");
            }
        });
      } else {
        $jq.post("/events/remove_provider", postData , function(data){
            if(data.error){
                alert("Ocurrió un error, intentar más tarde");
            }
        });
      }
    });
    
    $jq(".invite_fundations_send").click(function(e){
      e.preventDefault();
      var ids = new Array();
      $jq(".check_invite_fund:checked").each(function(){
        ids.push($jq(this).val());
      });

      var postData = {event_id:$jq(this).attr("event_id"), fundations_ids:ids};
      $jq.post("/events/add_fundations.json", postData , function(data){
          if(data.resp == "ok"){
            $jq("#alert-msg p").html("Los Poyectos Sociales escogidos hacen parte de los asistentes al evento");
            $jq("#alert-msg").slideDown().delay(2500).slideUp(function(){
              window.location.reload();
            });
          }
          else{
            $jq("#alert-msg p").html(data.message);
            $jq("#alert-msg").slideDown().delay(2500).slideUp();          
          }
      });      
      
    });    

    $jq(".invite_providers_send").click(function(e){
      e.preventDefault();
      var ids = new Array();
      $jq(".check_invite_prov:checked").each(function(){
        ids.push($jq(this).val());
      });

      var postData = {event_id:$jq(this).attr("event_id"), providers_ids:ids};
      $jq.post("/events/add_providers.json", postData , function(data){
          if(data.resp == "ok"){
            $jq("#alert-msg p").html("Los Proveedores de Sonrisas escogidos ahora hacen parte de los asistentes al evento");
            $jq("#alert-msg").slideDown().delay(2500).slideUp(function(){
              window.location.reload();
            });
          }
          else{
            $jq("#alert-msg p").html(data.message);
            $jq("#alert-msg").slideDown().delay(2500).slideUp();          
          }
      });      
      
    });    


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
    
    if ($jq("#can_edit").val() == "true")
    {
      jQuery('.upload').fileUploadUI({
            uploadTable: jQuery('.upload_files'),
            downloadTable: jQuery('.download_files'),
            buildUploadRow: function (files, index) {
                var file = files[index];
                return jQuery('<tr><td>' + file.name + '<\/td>' +
                        '<td class="file_upload_progress"><div><\/div><\/td>' +
                        '<td class="file_upload_cancel">' +
                        '<button class="ui-state-default ui-corner-all" title="Cancel">' +
                        '<span class="ui-icon ui-icon-cancel">Cancel<\/span>' +
                        '<\/button><\/td><\/tr>');
            },
            buildDownloadRow: function (file) {
                return jQuery('<tr><td><img alt="Photo" width="40" height="40" src="' + file.pic_path + '">' + file.name + '<\/td><\/tr>');
            },
            onCompleteAll: onCompleteAllCallback
      });       
    }
});

function onCompleteAllCallback (event, files, index, xhr, handler) {
  jQuery('.download_files').fadeOut();
  var t = setTimeout(showGallery, 10000);

}

function showGallery(){
  var eventId = jQuery('#theEventId').val();
  jQuery('#the_photo_gallery').load('/events/' + eventId + '/show_gallery', function(){
        jQuery('#the_photo_gallery').effect("highlight", {}, 3000);
        jQuery("a[rel^='prettyPhoto']").prettyPhoto({
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
}
