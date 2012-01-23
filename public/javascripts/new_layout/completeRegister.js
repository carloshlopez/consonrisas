var $jq = jQuery.noConflict();
$jq(document).ready(function($) {

    	// Smart Wizard     	
  		$jq('#complete_register_wizard').smartWizard({
  		transitionEffect:'slideleft',
      enableAllSteps: true,
  		keyNavigation: false,
  		onLeaveStep:leaveAStepCallback2,
  		onShowStep:showAStepCallback2,  		
  		onFinish:onFinishCallback2,
  		labelNext:'Siguiente', // label for Next button
      labelPrevious:'Anterior', // label for Previous button
      labelFinish:'Listo!',  // label for Finish button      
      });

      function showAStepCallback2(obj){
        var step_num= obj.attr('rel');
         $jq(".buttonNext").show();
         $jq(".buttonFinish").show();
         $jq(".buttonPrevious").show();
         $jq(".loader_login").hide();
        if(step_num == 2){
     
        }
      }

      function leaveAStepCallback2(obj){
        var step_num= obj.attr('rel');
        return validateSteps2(step_num);
      }
      
      function onFinishCallback2(){    

        if(validateAllSteps2()){
          var val = true;// confirm("¿Está toda la información completa?");
           if (val){
             $jq.post("/cleanInitialSession", function(data){
                //console.log(data);
                $jq("#complete_register").dialog('close');
             }); 

           }
       }
      }
       
     if ($jq("#showCompleteRegister").val() == 'yes'){
     $jq("#complete_register").dialog({modal:false, title:"Completa tu Registro", width: 900, closeText:"X", show:"clip"});
    //$jq("#complete_register").show();
     }
            
		});
	   
    function validateAllSteps2(){
       var isStepValid = true;
       
       if(valStep1() == false){
         isStepValid = false;
         $jq('#complete_register_wizard').smartWizard('setError',{stepnum:1,iserror:true});         
       }else{
         $jq('#complete_register_wizard').smartWizard('setError',{stepnum:1,iserror:false});
       }
       
       if(valStep2() == false){
         isStepValid = false;
         $jq('#complete_register_wizard').smartWizard('setError',{stepnum:2,iserror:true});         
       }else{
         $jq('#complete_register_wizard').smartWizard('setError',{stepnum:2,iserror:false});
       }
       if(valStep3() == false){
         isStepValid = false;
         $jq('#complete_register_wizard').smartWizard('setError',{stepnum:2,iserror:true});         
       }else{
         $jq('#complete_register_wizard').smartWizard('setError',{stepnum:2,iserror:false});
       }       
       
       if(!isStepValid){
          $jq('#complete_register_wizard').smartWizard('showMessage','Corrige los errores antes de continuar');
       }
              
       return isStepValid;
    } 	
		
		
		function validateSteps2(step){
		  var isStepValid = true;
      // validate step 1
      if(step == 1){
        if(valStep1() == false ){
          isStepValid = false; 
          $jq('#complete_register_wizard').smartWizard('showMessage','Por favor corrige los errores en el paso '+step+ ' y  continua.');
          $jq('#complete_register_wizard').smartWizard('setError',{stepnum:step,iserror:true});         
        }else{
          $jq('#complete_register_wizard').smartWizard('setError',{stepnum:step,iserror:false});
        }
        
      }
      
      // validate step2
      if(step == 2){
        if(valStep2() == false ){
          isStepValid = false; 
          $jq('#complete_register_wizard').smartWizard('showMessage','Por favor corrigue los errores en el paso '+step+ ' y continua.');
          $jq('#complete_register_wizard').smartWizard('setError',{stepnum:step,iserror:true});         
        }else{
          $jq('#complete_register_wizard').smartWizard('setError',{stepnum:step,iserror:false});
        }
      }
      
      // validate step3
      if(step == 3){
        if(valStep3() == false ){
          isStepValid = false; 
          $jq('#complete_register_wizard').smartWizard('showMessage','Por favor corrigue los errores en el paso '+step+ ' y continua.');
          $jq('#complete_register_wizard').smartWizard('setError',{stepnum:step,iserror:true});         
        }else{
          $jq('#complete_register_wizard').smartWizard('setError',{stepnum:step,iserror:false});
        }
      }      
      
      return isStepValid;
    }
		
		function valStep1(){
       var isValid = true; 
     
       return isValid;
    }
    
    function valStep2(){
      var isValid = true;    
   
      return isValid;
    }
    
    
    function valStep3(){
      var isValid = true;    
   
      return isValid;
    }    		
