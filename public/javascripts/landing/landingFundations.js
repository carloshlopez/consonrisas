var $jq = jQuery.noConflict();
$jq(document).ready(function(){

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
          if($jq("#fundation_name").val().length < 2 ||
              $jq("#fundation_description").val().length < 2 ||
              $jq("#fundation_city").val().length < 2
          )
          {
            alert("Por favor ingresa la información de tu proyecto social (Nombre, descripción, y Ciudad)");
            return
          }
          checkExistingFundName();

        break;

        case 3:
          //display message registration complete and redirect to profile
        break;
      }
  });
});

function doRegistration(){
  console.log("Member to create: " + $jq("#new_fundation").serialize() + "&" + $jq("#new_member").serialize());
  $jq.post("/members.json", $jq("#new_fundation").serialize() + "&" + $jq("#new_member").serialize(), function(resp){
    console.log(resp);
    if(resp.member.id == undefined){
      alert("Corrige estos errores antes de continuar:/n"+JSON.stringify(resp));
      return;
    }
    $jq(".step1 :input, .step2 :input").attr('disabled', true);
    $jq(".step1 a, .step2 a").attr('style', 'display:none');
    $jq.get("/members/"+resp.member.id+"/get_fundations", function(resp2){
      console.log(resp2);
      if(resp2[0].fundation_admin != undefined){
        //console.log(resp2[0].fundation_admin.fundation_id)
        $jq("#step3-form").load("/fundations/"+resp2[0].fundation_admin.fundation_id+"/needs", function(resp3){
          //console.log(resp3);
          $jq('#the-needs').needs();
          $jq(".big-loader").hide();
          $jq(".step3").fadeTo(500, 1);
          $jq(".done-container").show();
        });
      }
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

function checkExistingFundName(){
  var fundName = $jq("#fundation_name").val();
  console.log(fundName);
  $jq.post("/fundations/check_name",{name:fundName}, function(data){
    console.log(data);
    if(data != null){
      if(data.fundation != undefined)
      {
        alert("Esta fundación ya existe, ingresa con el mail ya está registrado");
      }
      else
      {
        doFundationRegistration();
      }
    }
    else{
      doFundationRegistration();
    }
  });

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


function doFundationRegistration()
{
    $jq(".step2").fadeTo(500, 0.2).hover(function(){
      $jq(".step2").stop(true, true);
      $jq(".step2").fadeTo(500, 1);
      }, function(){
        $jq(".step2").stop(true, true);
        $jq(".step2").fadeTo(500, 0.2);
    });
    $jq(".big-loader").show();
    $jq(".step3 :input").attr('disabled', false);
    $jq(".step3 a").attr('style', 'display:block');
    $jq('#member_new :input').not(':submit, :hidden').clone().hide().appendTo('#new_fundation');
    doRegistration();
}

