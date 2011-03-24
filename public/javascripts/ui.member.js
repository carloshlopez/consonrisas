var $jq = jQuery.noConflict();
$jq.widget("ui.member", {
    _init: function() {
    	var self= this;
    	var $el= this.element;
    	$jq('.fundation_admin_accept').click(function(e) {
            e.preventDefault();
            var fun_id = $jq(this).closest("div").attr("fundation_id");
            var mem_id = $jq(this).closest("div").attr("member_id");            
            self._respondFundationAdmin(fun_id, mem_id, "true");
        });
        
    	$jq('.fundation_admin_reject').click(function(e) {
            e.preventDefault();
            var fun_id = $jq(this).closest("div").attr("fundation_id");
            var mem_id = $jq(this).closest("div").attr("member_id");            
            self._respondFundationAdmin(fun_id, mem_id, "false");
        });     
        
    	$jq('.provider_admin_accept').click(function(e) {
            e.preventDefault();
            var prov_id = $jq(this).closest("div").attr("provider_id");
            var mem_id = $jq(this).closest("div").attr("member_id");            
            self._respondProviderAdmin(prov_id, mem_id, "true");
        });
        
    	$jq('.provider_admin_reject').click(function(e) {
            e.preventDefault();
            var prov_id = $jq(this).closest("div").attr("provider_id");
            var mem_id = $jq(this).closest("div").attr("member_id");            
            self._respondProviderAdmin(prov_id, mem_id, "false");
        });
        
    	$jq('.event_admin_accept').click(function(e) {
            e.preventDefault();
            var event_id = $jq(this).closest("div").attr("event_id");
            var mem_id = $jq(this).closest("div").attr("member_id");            
            self._respondEventAdmin(event_id, mem_id, "true");
        });
        
    	$jq('.event_admin_reject').click(function(e) {
            e.preventDefault();
            var event_id = $jq(this).closest("div").attr("event_id");
            var mem_id = $jq(this).closest("div").attr("member_id");            
            self._respondEventAdmin(event_id, mem_id, "false");
        });
        
    	$jq('.delete_alert').click(function(e) {
            e.preventDefault();
            var alert_id = $jq(this).attr("alert_id");
            self._deleteAlert(alert_id);
        });        
    },
    _respondFundationAdmin: function(fun_id, mem_id, active){
        var postData = {fundation_id:fun_id, member_id:mem_id, active:active};
        $jq.post("/members/respond_fundation_admin", postData , function(data){
            if(data.error){
                alert("Ocurrió un error, intentar más tarde");
                console.log(data);
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
                console.log(data);
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
                console.log(data);
            }
            else{
                alert("Ahora eres admin de este evento");
                window.location.reload();
            }
        });
    },
    _deleteAlert: function(alert_id){
        $jq.post( "/members/delete_alert", { alert_id: alert_id },
            function(data, textStatus, XMLHttpRequest){
            window.location.reload();
        }, "text" );
    }    
});



jQuery(document).ready(function($) {
    $jq("#member").member();
});
