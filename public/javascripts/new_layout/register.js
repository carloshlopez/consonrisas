var $jq = jQuery.noConflict();
$jq(document).ready(function($) {

    $jq(".register_wizzard").live('click', function(e){
      e.preventDefault();
      $jq('#reg_provider').removeAttr("checked");
      $jq('#reg_fundation').removeAttr("checked");
      $jq('#reg_facilitator').removeAttr("checked");
      $jq('#email_reg').val($jq('.member_email').val());
      $jq('#pass_reg').val($jq('.member_password').val());
      $jq('#pass_confirm_reg').val($jq('.member_password_confirmation').val());
      if($(this).attr("create")){
        if($(this).attr("create") == 'provider'){
          $jq('#reg_provider').attr("checked", "checked");
        }
        else if($(this).attr("create") == 'fundation'){
          $jq('#reg_fundation').attr("checked", "checked");
        }
        
      }
      $jq("#register_steps").dialog({modal:false, title:"Registrate", width: 780, closeText:"X", show:"clip"});
    });

    	// Smart Wizard     	
  		$jq('#wizard').smartWizard({
  		transitionEffect:'slideleft',
  		keyNavigation: false,
  		onLeaveStep:leaveAStepCallback,
  		onShowStep:showAStepCallback,  		
  		onFinish:onFinishCallback,
  		labelNext:'Siguiente', // label for Next button
      labelPrevious:'Anterior', // label for Previous button
      labelFinish:'Registrarse',  // label for Finish button      
      });

      function showAStepCallback(obj){
        var step_num= obj.attr('rel');
         $jq(".buttonNext").show();
         $jq(".buttonFinish").show();
         $jq(".buttonPrevious").show();
         $jq(".loader_login").hide();
        if(step_num == 2){
          $jq('#reg_facilitator_info').hide();
          $jq('#reg_fundation_info').hide();
          $jq('#reg_provider_info').hide(); 
          var selected = false;
          if($jq('#reg_facilitator').is(":checked")){
            $jq('#reg_facilitator_info').show();
            selected = true;
          }
          if($jq('#reg_fundation').is(":checked")){
            $jq('#reg_fundation_info').show();
            selected = true;
          }
          if($jq('#reg_provider').is(":checked")){
            $jq('#reg_provider_info').show();            
            selected = true;
          }
          if(!selected){
            $jq('#reg_facilitator_info').show();
            $jq('#reg_facilitator').attr("checked", "checked");
          }
        }
      }

      function leaveAStepCallback(obj){
        var step_num= obj.attr('rel');
        return validateSteps(step_num);
      }
      
      function onFinishCallback(){    
       if(validateAllSteps()){
         $jq(".msgBox").hide();
         $jq(".buttonNext").hide();
         $jq(".buttonFinish").hide();
         $jq(".buttonPrevious").hide();
         $jq(".loader_login").show();
         $jq("#wizzard_form").submit();
       }
      }
            
		});
	   
    function validateAllSteps(){
       var isStepValid = true;
       
       if(validateStep1() == false){
         isStepValid = false;
         $jq('#wizard').smartWizard('setError',{stepnum:1,iserror:true});         
       }else{
         $jq('#wizard').smartWizard('setError',{stepnum:1,iserror:false});
       }
       
       if(validateStep2() == false){
         isStepValid = false;
         $jq('#wizard').smartWizard('setError',{stepnum:2,iserror:true});         
       }else{
         $jq('#wizard').smartWizard('setError',{stepnum:2,iserror:false});
       }
       
       if(!isStepValid){
          $jq('#wizard').smartWizard('showMessage','Corrige los errores antes de continuar');
       }
              
       return isStepValid;
    } 	
		
		
		function validateSteps(step){
		  var isStepValid = true;
      // validate step 1
      if(step == 1){
        if(validateStep1() == false ){
          isStepValid = false; 
          $jq('#wizard').smartWizard('showMessage','Por favor corrige los errores en el paso '+step+ ' y  continua.');
          $jq('#wizard').smartWizard('setError',{stepnum:step,iserror:true});         
        }else{
          $jq('#wizard').smartWizard('setError',{stepnum:step,iserror:false});
        }
        
      }
      
      // validate step2
      if(step == 2){
        if(validateStep2() == false ){
          isStepValid = false; 
          $jq('#wizard').smartWizard('showMessage','Por favor corrigue los errores en el paso '+step+ ' y continua.');
          $jq('#wizard').smartWizard('setError',{stepnum:step,iserror:true});         
        }else{
          $jq('#wizard').smartWizard('setError',{stepnum:step,iserror:false});
        }
      }
      
      return isStepValid;
    }
		
		function validateStep1(){
       var isValid = true; 
       // Validate Username
       var un = $jq('#email_reg').val();
       if(!un && un.length <= 0){
         isValid = false;
         $jq('#email_warning').html('Debes ingresar el email').show();
       }else{
         $jq('#email_warning').html('').hide();
         if(!isValidEmailAddress($jq('#email_reg').val())){
           isValid = false;
           $jq('#email_warning').html('Ingresa un email correcto').show();           
         }else{
          $jq('#email_warning').html('').hide();
         }
       }
       
       // validate password
       var pw = $jq('#pass_reg').val();
       if(!pw && pw.length <= 0){
         isValid = false;
         $jq('#pass_warning').html('Debes ingresar una contraseña').show();         
       }else if(pw.length <= 5){
        isValid = false;
        $jq('#pass_warning').html('La contraseña debe tener por lo menos 6 caracteres').show();         
       }
       else{
         $jq('#pass_warning').html('').hide();
       }
       
       // validate confirm password
       var cpw = $jq('#pass_confirm_reg').val();
       if(!cpw && cpw.length <= 0){
         isValid = false;
         $jq('#pass_confirm_warning').html('Debes confirmar tu contraseña').show();         
       }else{
         $jq('#pass_confirm_warning').html('').hide();
       }  
       
       // validate password match
       if(pw && pw.length > 0 && cpw && cpw.length > 0){
         if(pw != cpw){
           isValid = false;
           $jq('#pass_confirm_warning').html('Las contraseñas con son iguales').show();            
         }else{
           $jq('#pass_confirm_warning').html('').hide();
         }
       }
       return isValid;
    }
    
    function validateStep2(){
      var isValid = true;    
      if($jq('#reg_facilitator').is(":checked")){
        if(!$jq('#reg_facilitator_name').val()){
          isValid = false;
          $jq("#reg_facilitator_info_warning").html("Debes ingresar tu nombre");
          $jq("#reg_facilitator_info_warning").show();
        }else{
          $jq("#reg_facilitator_info_warning").html("").hide();
        }
      }
      if($jq('#reg_fundation').is(":checked")){
        if(!$jq('#reg_fundation_name').val()){
          isValid = false;
          $jq("#reg_fundation_info_warning").html("Debes ingresar el nombre del Proyecto Social");
          $jq("#reg_fundation_info_warning").show();
        }else{
          $jq("#reg_fundation_info_warning").html("").hide();
        }
      }
      if($jq('#reg_provider').is(":checked")){
        if(!$jq('#reg_provider_name').val()){
          isValid = false;
          $jq("#reg_provider_info_warning").html("Debes ingresar el nombre del Proveedor");
          $jq("#reg_provider_info_warning").show();
        }else{
          $jq("#reg_provider_info_warning").html("").hide();
        }            
      } 
      return isValid;
    }
    
    // Email Validation
    function isValidEmailAddress(emailAddress) {
      var pattern = new RegExp(/^(("[\w-\s]+")|([\w-]+(?:\.[\w-]+)*)|("[\w-\s]+")([\w-]+(?:\.[\w-]+)*))(@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$)|(@\[?((25[0-5]\.|2[0-4][0-9]\.|1[0-9]{2}\.|[0-9]{1,2}\.))((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\.){2}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\]?$)/i);
      return pattern.test(emailAddress);
    } 
		
