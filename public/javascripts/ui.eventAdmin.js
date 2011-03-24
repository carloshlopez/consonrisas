var $jq = jQuery.noConflict();
$jq.widget("ui.eventAdmin", {
    _init: function() {
    	var self= this;
    	var $el= this.element;
    	$jq('.ask_admin').click(function(e) {
            e.preventDefault();
            var event_id = $jq(this).closest("div").attr("event_id");
            var mem_id = $jq("#member_id option:selected").val();
            var mail = $jq("#ask_admin_mail").val();
            
            self._askAdmin(event_id, mem_id, mail);
        });
        
        $jq('.remove_facilitator').click(function(e){
            e.preventDefault();
            var event_id = $jq(this).attr("event_id");
            var fac_id = $jq(this).attr("facilitator_id");
            self._removeFacilitator(event_id, fac_id);
        });
        
        $jq('.add_facilitator').click(function(e){
            e.preventDefault();
            var event_id = $jq(this).attr("event_id");
            var fac_id = $jq(this).attr("facilitator_id");
            self._addFacilitator(event_id, fac_id);
        });        
        
    },
    _askAdmin: function(event_id, mem_id, mail){
        var postData = {event_id:event_id, member_id:mem_id, mail:mail};
        $jq.post("/events/ask_admin", postData , function(data){
            if(data.error){
                alert("Ocurrió un error, intentar más tarde");
                //console.log(data);
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
                //console.log(data);
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
                //console.log(data);
            }
            else{
                //alert("Ya no vas a ir como facilitador a este evento");
                window.location.reload();
            }
        });
    }
});



jQuery(document).ready(function($) {
    $jq("#ask_admin_message").hide();
    $jq("#eventAdmin").eventAdmin();
});
