var $jq = jQuery.noConflict();
$jq.widget("ui.myProfile", {
    _init: function() {
    	var self= this;
    	var $el= this.element;
    	
    	$jq(".div-for-menu-space").css("padding-top","105px");;
    	
    	$el.find('.fundation_admin_accept').click(function(e) {
            e.preventDefault();
            var fun_id = $jq(this).closest("div").attr("fundation_id");
            var mem_id = $jq(this).closest("div").attr("member_id");            
            self._respondFundationAdmin(fun_id, mem_id, "true");
        });
        
    	$el.find('.fundation_admin_reject').click(function(e) {
            e.preventDefault();
            var fun_id = $jq(this).closest("div").attr("fundation_id");
            var mem_id = $jq(this).closest("div").attr("member_id");            
            self._respondFundationAdmin(fun_id, mem_id, "false");
        });     
        
    	$el.find('.provider_admin_accept').click(function(e) {
            e.preventDefault();
            var prov_id = $jq(this).closest("div").attr("provider_id");
            var mem_id = $jq(this).closest("div").attr("member_id");            
            self._respondProviderAdmin(prov_id, mem_id, "true");
        });
        
    	$el.find('.provider_admin_reject').click(function(e) {
            e.preventDefault();
            var prov_id = $jq(this).closest("div").attr("provider_id");
            var mem_id = $jq(this).closest("div").attr("member_id");            
            self._respondProviderAdmin(prov_id, mem_id, "false");
        });
        
    	$el.find('.event_admin_accept').click(function(e) {
            e.preventDefault();
            var event_id = $jq(this).closest("div").attr("event_id");
            var mem_id = $jq(this).closest("div").attr("member_id");            
            self._respondEventAdmin(event_id, mem_id, "true");
        });
        
    	$el.find('.event_admin_reject').click(function(e) {
            e.preventDefault();
            var event_id = $jq(this).closest("div").attr("event_id");
            var mem_id = $jq(this).closest("div").attr("member_id");            
            self._respondEventAdmin(event_id, mem_id, "false");
        });
        
    	$el.find('.delete_alert').click(function(e) {
            e.preventDefault();
	          var answer = confirm("¿Seguro que deseas eleminar este mensaje?")
            if (answer){
              var alert_id = $jq(this).attr("alert_id");
              var elId = $jq(this).attr("id").split("-")[2];
              $jq("#alert-img-"+elId).css('display', 'inline');
              $jq(this).hide();
              self._deleteAlert(alert_id, elId);
	          }
        }); 
      $el.find('.accept_invite').click(function(e) {
        e.preventDefault();
        var alert_id = $jq(this).attr("alert_id");
        var event_id = $jq(this).attr("event_id");
        var role_id = $jq(this).attr("role_id");
        var elId = $jq(this).attr("id").split("-")[2];
        $jq("#alert-img-"+elId).css('display', 'inline');
        $jq(this).hide();
        self._acceptInvite(event_id, role_id, elId);
      });

      $el.find('.reject_invite').click(function(e) {
        e.preventDefault();
        var alert_id = $jq(this).attr("alert_id");
        var event_id = $jq(this).attr("event_id");
        var role_id = $jq(this).attr("role_id");
        var elId = $jq(this).attr("id").split("-")[2];
        $jq("#alert-img-"+elId).css('display', 'inline');
        $jq(this).hide();
        self._rejectInvite(event_id, role_id, elId);
      });         
        
    	$el.find('.delete_msg').click(function(e) {
            e.preventDefault();
	          var answer = confirm("¿Seguro que deseas eleminar este mensaje?")
            if (answer){
              var alert_id = $jq(this).attr("alert_id");
              var elId = $jq(this).attr("id").split("-")[2];
              $jq("#msg-img-"+elId).css('display', 'inline');
              $jq(this).hide();
              self._deleteMsg(alert_id, elId);
	          }
        });              
        
    	$el.find('.delete_event').click(function(e) {
            e.preventDefault();
	          var answer = confirm("¿Seguro que la deseas eleminar este evento?\n Esto no se puede revertir")
            if (answer){
              var event_id = $jq(this).attr("event_id");
              var elId = $jq(this).attr("id").split("-")[2];
              $jq("#event-img-"+elId).css('display', 'inline');
              $jq(this).hide();
              self._deleteEvent(event_id, elId);
	          }
        });         
        
    	$el.find('.delete_fundation').click(function(e) {
            e.preventDefault();
	          var answer = confirm("¿Seguro que la deseas eleminar este Proyecto Social?\n Esto no se puede deshacer")
            if (answer){
              var fundation_id = $jq(this).attr("fundation_id");
              var elId = $jq(this).attr("id").split("-")[2];
              $jq("#fundation-img-"+elId).css('display', 'inline');
              $jq(this).hide();
              self._deleteFundation(fundation_id, elId);
	          }
        });        
        
    	$el.find('.delete_provider').click(function(e) {
            e.preventDefault();
	          var answer = confirm("¿Seguro que la deseas eleminar este Proveedor?\n Esto no se puede deshacer")
            if (answer){
              var provider_id = $jq(this).attr("provider_id");
              var elId = $jq(this).attr("id").split("-")[2];
              $jq("#provider-img-"+elId).css('display', 'inline');
              $jq(this).hide();
              self._deleteProvider(provider_id, elId);
	          }
        });                                 	
    	
    	$el.find(".my-profile-menu span a,.sub_menu_link").click(function() {
    	    var to_show = $jq(this).attr("show");
          self._show(to_show);
        });
        
    }, 
    _show: function(show){
      $jq(".sub-menu-inner-bar ul li").removeClass("sub_menu_selected");    
      $jq(".sub-menu-mobile ul li").removeClass("active");          
      var newMargin = '60px';
      if( show == 'events'){
        newMargin = '160px';
      }
      else if( show == 'fundations'){
        newMargin = '260px';
      }
      else if(show == 'providers'){
        newMargin = '370px';
      }
      else{
        show = 'news_feed';
      }
      $jq(".arrow-up-profile").animate({marginLeft: newMargin});    
      $jq(".mine").hide();
      $jq(".my-"+ show).show(); 
      $jq(".sub_menu_link."+show).parent().addClass("sub_menu_selected");
      $jq(".sub_menu_link."+show).parent().addClass("active");      
    },
    _respondFundationAdmin: function(fun_id, mem_id, active){
        var postData = {fundation_id:fun_id, member_id:mem_id, active:active};
        $jq.post("/members/respond_fundation_admin", postData , function(data){
            if(data.error){
                alert("Ocurrió un error, intentar más tarde");
            }
            else{
                alert("Ahora eres admin de esta fundación");
                window.location.reload();         
            }
        });
    },
    _respondProviderAdmin: function(prov_id, mem_id, active){
        var postData = {provider_id:prov_id, member_id:mem_id, active:active};
        $jq.post("/members/respond_provider_admin", postData , function(data){
            if(data.error){
                alert("Ocurrió un error, intentar más tarde");
            }
            else{
                alert("Ahora eres admin de este proveedor");
                window.location.reload();    
            }
        });
    },
    _respondEventAdmin: function(event_id, mem_id, active){
        var postData = {event_id:event_id, member_id:mem_id, active:active};
        $jq.post("/members/respond_event_admin", postData , function(data){
            if(data.error){
                alert("Ocurrió un error, intentar más tarde");
            }
            else{
                alert("Ahora eres admin de este evento");
                window.location.reload();
            }
        });
    },
    _deleteAlert: function(alert_id, elId){
        $jq.post( "/members/delete_alert", { alert_id: alert_id },
            function(data, textStatus, XMLHttpRequest){
              var obj = $jq.parseJSON(data);
              if(obj.resp == "ok"){
                $jq("#alert-item-"+elId).fadeOut("slow", function(){
                  $jq("#alert-item-"+elId).remove();
                });

              }
              else{
                alert(data.message);
              }
        }, "text" );
    },
    _acceptInvite: function(event_id, role_id, elId){
        $jq.post( "/accept_invite/"+event_id+"/"+role_id, { },
            function(data, textStatus, XMLHttpRequest){
              $jq("#alert-img-"+elId).css('display', 'none');
        }, "text" );
    },
    _rejectInvite: function(event_id, role_id, elId){
        $jq.post( "/reject_invite/"+event_id+"/"+role_id, { },
            function(data, textStatus, XMLHttpRequest){
              $jq("#alert-img-"+elId).css('display', 'none');
        }, "text" );
    },
    _deleteMsg: function(alert_id, elId){
        $jq.post( "/members/delete_alert", { alert_id: alert_id },
            function(data, textStatus, XMLHttpRequest){
              var obj = $jq.parseJSON(data);
              if(obj.resp == "ok"){
                $jq("#msg-item-"+elId).fadeOut("slow", function(){
                  $jq("#msg-item-"+elId).remove();
                });

              }
              else{
                alert(data.message);
              }
        }, "text" );
    },    
    _deleteEvent: function(event_id, elId){
        $jq.post( "/events/"+event_id+".json", { "_method": "delete" },
            function(data, textStatus, XMLHttpRequest){
              var obj = $jq.parseJSON(data);
              if(obj.resp == "ok"){
                $jq("#event-item-"+elId).fadeOut("slow", function(){
                  $jq("#event-item-"+elId).remove();
                });

              }
              else{
                alert(data);
              }
        }, "text" );
    },
    _deleteFundation: function(fundation_id, elId){
        $jq.post( "/fundations/"+fundation_id+".json", { "_method": "delete" },
            function(data, textStatus, XMLHttpRequest){
              var obj = $jq.parseJSON(data);
              if(obj.resp == "ok"){
                $jq("#fundation-item-"+elId).fadeOut("slow", function(){
                  $jq("#fundation-item-"+elId).remove();
                });

              }
              else{
                alert(data);
              }
        }, "text" );
    },
    _deleteProvider: function(provider_id, elId){
        $jq.post( "/providers/"+provider_id+".json", { "_method": "delete" },
            function(data, textStatus, XMLHttpRequest){
              var obj = $jq.parseJSON(data);
              if(obj.resp == "ok"){
                $jq("#provider-item-"+elId).fadeOut("slow", function(){
                  $jq("#provider-item-"+elId).remove();
                });

              }
              else{
                alert(data);
              }
        }, "text" );
    }    
});


function showInvites(){
  $jq("#invites-div").dialog({modal:true, title:"Invitaciones a eventos de tu interés", width: 600, height: 500, closeText:"x", show:"slide"
    , open: function(){
      var member_id = $jq('input[name="facilitator[member_id]"]').val();
      $jq.post('/members/' + member_id + '/seen_invites.json', function(data){
        if(data.resp == 'ok'){
          $jq("#num_new_invites").hide();
          $jq("#num_new_invites_sub").html('0');
        }
      })
  }});
}

function showMsgs(){
  $jq("#msgs-div").dialog({modal:true, title:"Mensajes enviados a ti", width: 600, height: 500, closeText:"X", show:"slide"
    , open: function(){
      var member_id = $jq('input[name="facilitator[member_id]"]').val();
      $jq.post('/members/' + member_id + '/seen_msgs.json', function(data){
        if(data.resp == 'ok'){
          $jq("#num_new_msgs").hide();
          $jq("#num_new_msgs_sub").html('0');
        }        
      })
  }});
}

function showNeeds(){
  $jq("#needs-div").dialog({modal:true, title:"Ayuda con las necesidades de los proyectos sociales", width: 650, height: 550, closeText:"X", show:"slide"});
}

function showEdit(e){
  if (e != undefined){
    e.preventDefault();
  }
  $jq("#edit-facilitator").dialog({modal:true, title:"Ingresa tu información", width: 400, closeText:"X", show:"slide"});
}

function showMenu(show){
  $jq(".sub-menu-inner-bar ul li").removeClass("sub_menu_selected");    
  var newMargin = '60px';
  if( show == 'events'){
    newMargin = '160px';
  }
  else if( show == 'fundations'){
    newMargin = '260px';
  }
  else if(show == 'providers'){
    newMargin = '370px';
  } 
  else{
    show = 'news_feed';
  }
  $jq(".arrow-up-profile").animate({marginLeft: newMargin});    
  $jq(".mine").hide();
  $jq(".my-"+ show).show(); 
  $jq(".sub_menu_link."+show).parent().addClass("sub_menu_selected");  
}

$jq(document).ready(function($) {    
  $jq("#my-profile").myProfile();
  
  $jq(".see-all").click(function(e){
    e.preventDefault();
    $jq("#following").dialog({modal:true, title:"Conexiones", width: 680, closeText:"X", show:"slide"});
  });
  
  $jq(".show-results-2012").click(function(e){
    e.preventDefault();
    $jq("#results_2012").dialog({modal:true, title:"Resultados del 2012", width: 600, closeText:"X", show:"slide"});
  });  

  $jq(".show-results-2013").click(function(e){
    e.preventDefault();
    $jq("#results_2013").dialog({modal:true, title:"Resultados del 2013", width: 600, closeText:"X", show:"slide"});
  });

  $jq(".show-results-2014").click(function(e){
    e.preventDefault();
    $jq("#results_2014").dialog({modal:true, title:"Resultados del 2014", width: 600, closeText:"X", show:"slide"});
  });
  
  $jq(".show-results-2015").click(function(e){
    e.preventDefault();
    $jq("#results_2015").dialog({modal:true, title:"Resultados del 2015", width: 600, closeText:"X", show:"slide"});
  });  
  
  $jq(".edit-me").click(showEdit); 
  
  if($jq("#show_edit").val() == "show"){
    showEdit();
  }
  
  $jq(".invites").click(showInvites);
  $jq(".msgs").click(showMsgs);
  $jq(".needs").click(showNeeds);
  

	$jq(".auth-remove").click(function(e){
	  e.preventDefault();
	  if (confirm("Ya no podrás ingresar con este servicio, y no nos ayudarás a regar la voz por medio de este medio :(.\n Seguro que deseas continuar?")){
  	  var url = $jq(this).attr("href");
      $jq.post( url, { "_method": "delete" },
          function(data, textStatus, XMLHttpRequest){
              window.location.reload(); 
      }, "text" );
    }
	}); 
	
	if(window.location.hash){
   var hash = window.location.hash.substring(1); 
   if(hash == "msgs"){
    showMsgs();
   }
   else if(hash == "invites"){
    showInvites();
   }
   else if(hash == "needs"){
    showNeeds();
   }
   else{
    showMenu(hash);
   }
	}
  
});

