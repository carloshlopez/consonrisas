var $jq = jQuery.noConflict();
$jq.widget("ui.needs", {
    _init: function() {
    	var self= this;
    	var $el= this.element;
    	
       $el.find('.delete_need').live('click', function(e) {
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
        
       $el.find('.help_need').live('click', function(e) {
            var need_id = $jq(this).attr("need_id");
            var fundation_id = $jq(this).attr("fundation_id");
            var member_id = $jq(this).attr("member_id");    
            $jq("#need-help-img-"+need_id).css('display', 'inline');
            $jq(this).hide();        
            self._helpNeed(need_id,fundation_id, member_id);
        });  
        
       $el.find('.add_need').click(function(e) {
            e.preventDefault();
            if($jq("#project_need_name").val() == ""){
              alert("Debes agregar un nombre, antes de crear una necesidad");
            }
            else if($jq("#project_need_recurrence").val() == ""){
              alert("Genera una recurrencia para la necesidad. \nEjemplo: Una vez\n Cada quince días \n Mensual");
            }            
            else{
              $jq('body').css('cursor', 'wait');
              var fundation_id = $jq(this).attr("fundation_id");
              self._addNeed(fundation_id);
            }
        });                       
        
        $el.find("#need_cat_select").change(function(){
          if($jq(this).val() == ""){
            $jq("#other_need_category").show();
          }
          else{
            $jq("#other_need_category").hide();
          }
        });
        
        
    },_helpNeed: function(need_id, fundation_id, memberId){
        $jq.post( "/fundations/"+fundation_id+"/project_needs/"+ need_id + "/help.json" , {member_id:memberId},
            function(data, textStatus, XMLHttpRequest){
              var obj = $jq.parseJSON(data);
              if(obj.resp == "ok"){ 
                $jq("#need-help-img-"+need_id).css('display', 'none');
                $jq("#need-state-"+need_id).html(obj.new_state);
                $jq("#need-state-"+need_id).effect("highlight", {color:'#973B8C'}, 3500);
                $jq("#alert-msg p").html("Te hemos conectado con el Proyecto Social para que ayudes a suplir esta necesidad");
                $jq("#alert-msg").slideDown().delay(3000).slideUp();
              }
              else{
                alert("Error: " + obj.msgs);
              }
        }, "text" );
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
    }
    ,_addNeed: function(fundation_id){
      $jq.post("/proyectos/"+fundation_id+"/project_needs.json",$jq("#new_project_need").serialize(), function(data){
          $jq.get("/proyectos/"+fundation_id+"/project_needs/"+data.project_need.id, function(resp){
              $jq("#the-needs").append(resp);
              $jq(".help_need").closest(".need_action").hide();
              $jq('html, body').animate({ scrollTop: $jq('#need-'+data.project_need.id).offset().top }, '1500');
              $jq("#need-"+data.project_need.id).effect("highlight", {color:'#973B8C'}, 3000);
              $jq('body').css('cursor', 'auto');
          });
      });
    }
});

$jq(document).ready(function($jq) {
  $jq("#the-needs").needs();    
});
