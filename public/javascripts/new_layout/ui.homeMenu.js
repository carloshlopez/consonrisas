var $jq = jQuery.noConflict();
$jq.widget("ui.homeMenu", {
    _init: function() {
    	var self= this;
    	var $el= this.element;
    	var path = window.location.pathname;
      
      $el.find("ul li a").mouseenter(function(e){
        //console.log('mouse over');
        var current = $jq(this).attr("class");
        self._showDesc(current);
      });
      
      $el.find("ul li a").mouseleave(function(e){
        //console.log('mouse leave');
        var current = $jq(this).attr("class");
        self._hideDesc(current);
      });
    },
    _showDesc: function(current){
      //console.log(current);
      $jq("#descs").css("background", color(current) );
      $jq("#descs").css("background-image", image(current));
      $jq("#descs").css("background-repeat", "no-repeat");
      $jq("#descs").css("background-position", "20px 50px");
      $jq("#descs").html(description(current));
      $jq("#descs").slideDown();
      $jq("."+current+"-arrow").css("border-top","15px solid white");
    },
    _hideDesc: function(current){
      //console.log(current);
      $jq("."+current+"-arrow").css("border-top","15px solid transparent");
      $jq("#descs").slideUp();
    }
    
});

function color(current){
 if (current=="facilitators"){return "red";}
 if (current=="fundations"){return "#973B8C";}
 if (current=="providers"){return "#E3BB00";}
 if (current=="events"){return "#00BCFA";} 
 if (current=="info"){return "#5AB446";} 
  
}

function image(current){
 if (current=="facilitators"){return "url('/images/IconosFacilitadoresNoFondo.png')";}
 if (current=="fundations"){return "url('/images/IconosProyectosSocialesNoFondo.png')";}
 if (current=="providers"){return "url('/images/IconosProveedoresNoFondo.png')";}
 if (current=="events"){return "url('/images/IconosEventosNoFondo.png')";} 
 if (current=="info"){return "url('/images/IconosInfoNoFondo.png')";} 
  
}

function description(current){
 if (current=="facilitators"){return '<div class="desc-text">Facilitadores son: ...</div>';}
 if (current=="fundations"){return '<div class="desc-text">Proyectos Sociales son: ...</div>';}
 if (current=="providers"){return '<div class="desc-text">Proveedores de Entretenimiento son: ...</div>';}
 if (current=="events"){return '<div class="desc-text">Eventos son: ...</div>';} 
 if (current=="info"){return '<div class="desc-text">Conectando Sonrisas es: ...</div>';} 
  
}

$jq(document).ready(function($) {    
    $jq("#menu").homeMenu();

    $jq("#left_div a").click(function(e){
      e.preventDefault();
      $jq("#login-form").dialog({modal:true, title:"Ingresar", width: 400, closeText:"X", show:"clip"});
    });
});
