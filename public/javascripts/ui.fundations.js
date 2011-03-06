var $jq = jQuery.noConflict();
$jq.widget("ui.fundations", {
    _init: function() {
    	var self= this;
    	var $el= this.element;
    	$jq('.ask_admin').click(function(e) {
            e.preventDefault();
            var fun_id = $jq(this).closest("div").attr("fundation_id");
            var mem_id = $jq("#member_id option:selected").val();
            var mail = $jq("#ask_admin_mail").val();
            
            self._askAdmin(fun_id, mem_id, mail);
        });
    },
    _askAdmin: function(fun_id, mem_id, mail){
        var postData = {fundation_id:fun_id, member_id:mem_id, mail:mail};
        $jq.post("/fundations/ask_admin", postData , function(data){
            if(data.error){
                alert("Ocurrió un error, intentar más tarde");
                console.log(data);
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
    }
});



jQuery(document).ready(function($) {
    $jq("#ask_admin_message").hide();
    $jq("#fundations").fundations();    
});
