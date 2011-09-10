var $jq = jQuery.noConflict();
$jq.widget("ui.myProfile", {
    _init: function() {
    	var self= this;
    	var $el= this.element;
    	
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
    	
    	$el.find(".my-profile-menu span a").click(function(e) {
    	    e.preventDefault();
    	    var to_show = $jq(this).attr("show");
          self._show(to_show);
        });
        
    }, 
    _show: function(show){
      $jq(".arrow-up-profile").hide();
      $jq(".arrow-"+ show).show();
      $jq(".mine").hide();
      $jq(".my-"+ show).show(); 
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

$jq(document).ready(function($) {    
  $jq("#my-profile").myProfile();
  
  $jq(".see-all").click(function(e){
    e.preventDefault();
    $jq("#following").dialog({modal:true, title:"Conexiones", width: 600, closeText:"X", show:"slide"});
  });
  
  $jq(".edit-me").click(showEdit); 
  
  if($jq("#show_edit").val() == "show"){
    showEdit();
  }
  
});

function showEdit(){
  $jq("#edit-facilitator").dialog({modal:true, title:"Ingresa tu información", width: 400, closeText:"X", show:"slide"});
}
