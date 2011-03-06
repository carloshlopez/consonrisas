var $jq = jQuery.noConflict();
$jq.widget("ui.member", {
    _init: function() {
    	var self= this;
    	var $el= this.element;
    	$jq('.admin_accept').click(function(e) {
            e.preventDefault();
            var fun_id = $jq(this).closest("div").attr("fundation_id");
            var mem_id = $jq(this).closest("div").attr("member_id");            
            self._respondAdmin(fun_id, mem_id, "true");
        });
        
    	$jq('.admin_reject').click(function(e) {
            e.preventDefault();
            var fun_id = $jq(this).closest("div").attr("fundation_id");
            var mem_id = $jq(this).closest("div").attr("member_id");            
            self._respondAdmin(fun_id, mem_id, "false");
        });        
    },
    _respondAdmin: function(fun_id, mem_id, active){
        var postData = {fundation_id:fun_id, member_id:mem_id, active:active};
        $jq.post("/members/respond_admin", postData , function(data){
            if(data.error){
                alert("Ocurrió un error, intentar más tarde");
                console.log(data);
            }
            else{
                alert("Ahora eres admin de esta fundación");         
            }
        });
    }
});



jQuery(document).ready(function($) {
    $jq("#member").member();
});
