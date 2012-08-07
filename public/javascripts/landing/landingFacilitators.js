var $jq = jQuery.noConflict();
$jq(document).ready(function(){

  if($jq("#soyfacilitador").val() != undefined){
    $jq(".input-landing").addClass("input-landing-facilitators").removeClass("input-landing");    
    $jq(".next-step-landing").addClass("next-step-landing-facilitators");
  }

  $jq(".step2, .step3").fadeTo(500, 0.2);
  $jq(".step2 :input, .step3 :input").attr('disabled', true);
  $jq(".step2 a, .step3 a").attr('style', 'display:none');  

  $jq("#member_email").blur(checkExistingEmail);

  $jq('.next-step-landing').click(function() {
      var step = parseInt($jq(this).attr("step_number"));
      switch(step){
        case 1:
          //validate registration info {email, pass, pass_conf} 
          //enable step 2
          if(!isValidEmailAddress($jq("#member_email").val()))
          {
            alert("Porfavor ingresa una dirección de correo valida");
            return
          }
          
          if($jq("#member_password_confirmation").val() != $jq("#member_password").val())
          {
            alert("Tu contraseña y confirmación no coinciden");
            return          
          }
          
          if($jq("#member_password").val().length < 6)
          {
            alert("Tu contraseña debe tener más de 6 caracteres");
            return          
          }
          checkExistingEmail();
          
          $jq(".step1").fadeTo(500, 0.2).hover(function(){
            $jq(".step1").stop(true, true);
            $jq(".step1").fadeTo(500, 1);
            }, function(){
              $jq(".step1").stop(true, true);            
              $jq(".step1").fadeTo(500, 0.2);
          });
          $jq(".step2").fadeTo(500, 1);
          $jq(".step2 :input").attr('disabled', false);
          $jq(".step2 a").attr('style', 'display:block');            
          
        break;
        case 2:
          //registration via devise, register member an fudation
          if($jq("#facilitator_name").val().length < 2 ||
              $jq("#facilitator_city").val().length < 2
          )
          {
            alert("Por favor ingresa tu información de perfil (Nombre, y Ciudad)");
            return          
          }
          $jq(".step2").fadeTo(500, 0.2).hover(function(){
            $jq(".step2").stop(true, true);          
            $jq(".step2").fadeTo(500, 1);
            }, function(){
              $jq(".step2").stop(true, true);            
              $jq(".step2").fadeTo(500, 0.2);
          });
          $jq(".big-loader").show();
          $jq('html, body').animate({scrollTop:0}, 'slow', function(){
            $jq(".step3 :input").attr('disabled', false);          
            $jq(".step3 a").attr('style', 'display:block');  
            $jq('#member_new :input').not(':submit, :hidden').clone().hide().appendTo('#new_facilitator');
            doRegistration();          
          });

        break;
        
        case 3:
        
          //display message registration complete and redirect to profile
        break;
      }
  });
  
  
});

function doRegistration(){
  $jq.post("/members.json", $jq("#new_facilitator").serialize(), function(resp){
    console.log(resp);
    if(resp.member.id == undefined){
      alert("Corrige estos errores antes de continuar:/n"+JSON.stringify(resp));
      return;
    }
    $jq(".step1 :input, .step2 :input").attr('disabled', true);
    $jq(".step1 a, .step2 a").attr('style', 'display:none');  
    $jq("#step3-form").load("/project_needs/all_needs_landing", function(resp3){
          //console.log(resp3);
          $jq('#the-needs').needs();
          $jq(".big-loader").hide();
          $jq(".step1").fadeTo(500, 0).hide().remove();
          $jq(".step2").fadeTo(500, 0).hide().remove();
          $jq(".step3").fadeTo(500, 1);          
          $jq(".done-container-facilitators").show();
          $jq(".steps").css("width", "610px");
     });
  
  });
}

function checkExistingEmail(){
  var email = $jq("#member_email").val();
  if(isValidEmailAddress(email)){
    //console.log(email);
    $jq.post("/members/check_email",{email:email}, function(data){
      //console.log(data);
      if(data != null){
        if(data.member != undefined)
        {
          alert("Este mail ya está registrado, ingresa a www.consonrisas.co y en tu perfil podrás agregar necesidades de tu proyecto social");
        }
      }
    });
  }
  else{
    alert("Por favor ingresa un email valido"); 
  }
}

function isValidEmailAddress(emailAddress) {
  //console.log(emailAddress);
  var pattern = new RegExp(/^(("[\w-\s]+")|([\w-]+(?:\.[\w-]+)*)|("[\w-\s]+")([\w-]+(?:\.[\w-]+)*))(@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$)|(@\[?((25[0-5]\.|2[0-4][0-9]\.|1[0-9]{2}\.|[0-9]{1,2}\.))((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\.){2}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\]?$)/i);
  return pattern.test(emailAddress);
} 

function validateEmail(email) { 
  // http://stackoverflow.com/a/46181/11236
  //console.log(email);  
    var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}


