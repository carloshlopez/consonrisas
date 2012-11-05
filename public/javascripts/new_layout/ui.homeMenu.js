var $jq = jQuery.noConflict();
$jq.widget("ui.homeMenu", {
    _init: function() {
    	var self= this;
    	var $el= this.element;
    	var path = window.location.pathname;
    	if(path.indexOf('member') > 0){
        	self._updateCurrent('info');
    	}
    	else if(path.indexOf('facilitator') > 0){
        	self._updateCurrent('facilitators');
    	}
    	else if(path.indexOf('provider') > 0){
        	self._updateCurrent('providers');
    	}
    	else if(path.indexOf('fundation') > 0){
        	self._updateCurrent('fundations');
    	}
    	else if(path.indexOf('event') > 0){
        	self._updateCurrent('events');
    	}
    	else if(path.indexOf('info') > 0){
        	self._updateCurrent('info');
    	}
    	else
    	{
        	self._updateCurrent('home');
    	}    	
      
      $el.find("ul li a").mouseenter(function(e){
        var current = $jq(this).attr("class");
        if(current.indexOf(" ") > 0){
          current = current.substring(0, current.indexOf(" "));
        }
        self._showDesc(current);
      });
      
      $el.find("ul li a").mouseleave(function(e){
        var current = $jq(this).attr("class");
        if(current.indexOf(" ") > 0){
          current = current.substring(0, current.indexOf(" "));
        }        
        self._hideDesc(current);
      });
    },
    _showDesc: function(current){
      $jq("#descs").stop(true, true);
      $jq("#descs").css("background", color(current) );
      $jq("#descs").css("background-image", image(current));
      $jq("#descs").css("background-repeat", "no-repeat");
      $jq("#descs").css("background-position", "20px 50px");
      $jq("#descs").html(description(current));
      $jq("#descs").slideDown();
      $jq("."+current+"-arrow").css("border-top","15px solid white");
    },
    _hideDesc: function(current){
      $jq("."+current+"-arrow").css("border-top","15px solid transparent");
      $jq("#descs").slideUp();
    },
    _updateCurrent: function(current){
        var cur = $jq("a."+current);
        cur.addClass("current_page_item_"+current);
        cur.removeClass(current);        
        $jq("#left_div_top").css("background", color(current));
        $jq("#search-text").attr('class', current+'-color') ;
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
 if (current=="facilitators"){
  var desc = $jq('#facilitators-desc').html();
  return '<div class="desc-text">'+desc+'</div>';
 }
 if (current=="fundations"){
   var desc = $jq('#fundations-desc').html();
   return '<div class="desc-text">'+desc+'</div>';
 }
 if (current=="providers"){
  var desc = $jq('#providers-desc').html(); 
  return '<div class="desc-text">'+desc+ '</div>';
}
 if (current=="events"){
  var desc = $jq('#events-desc').html(); 
  return '<div class="desc-text">'+ desc + '</div>';
} 
 if (current=="info"){
  var desc = $jq('#info-desc').html(); 
  return '<div class="desc-text">'+desc + '</div>';
} 
  
}

$jq(document).ready(function($) {    
    $jq("#menu").homeMenu();
     	var path = window.location.toString();//pathname;
     	$jq(".nav-collapse ul.nav li").removeClass("active");
    	if(path.indexOf('msgs') > 0){
        $jq(".menu-messages").addClass("menu-messages-selected").removeClass("menu-messages");        
        $jq(".menu-messages-text").addClass("menu-messages-text-selected").removeClass("menu-messages-text");
        $jq(".home-mobile-menu").addClass("active");        
    	}     	
    	else if(path.indexOf('invites') > 0){
        $jq(".menu-invitations").addClass("menu-invitations-selected").removeClass("menu-invitations");
        $jq(".menu-invitations-text").addClass("menu-invitations-text-selected").removeClass("menu-invitations-text");
        $jq(".home-mobile-menu").addClass("active");        
    	}     	
    	else if(path.indexOf('member') > 0){
        $jq(".menu-home").addClass("menu-home-selected").removeClass("menu-home");        
        $jq(".menu-home-text").addClass("menu-home-text-selected").removeClass("menu-home-text");
        $jq(".home-mobile-menu").addClass("active");        
    	}
    	else if(path.indexOf('needs') > 0){
        $jq(".menu-help").addClass("menu-help-selected").removeClass("menu-help");        
        $jq(".menu-help-text").addClass("menu-help-text-selected").removeClass("menu-help-text");        
        $jq(".needs-mobile-menu").addClass("active");
    	}
    	else if(path.indexOf('provider') > 0 || path.indexOf('proveedor') > 0){
        $jq(".menu-register-providers").addClass("menu-register-providers-selected").removeClass("menu-register-providers");        
        $jq(".menu-register-providers-text").addClass("menu-register-providers-text-selected").removeClass("menu-register-providers-text");                
        $jq(".providers-mobile-menu").addClass("active");        
    	}
    	else if(path.indexOf('fundation') > 0 || path.indexOf('proyecto') > 0){
        $jq(".menu-register-fundations").addClass("menu-register-fundations-selected").removeClass("menu-register-fundations");        
        $jq(".menu-register-fundations-text").addClass("menu-register-fundations-text-selected").removeClass("menu-register-fundations-text");                
        $jq(".fundations-mobile-menu").addClass("active");        
    	}    	
    	else if(path.indexOf('find') > 0){
        $jq(".menu-search").addClass("container-selected");        	
        $jq(".home-mobile-menu").addClass("active");                
    	}
    	else if(path.indexOf('event') > 0){
        $jq(".menu-register-events").addClass("menu-register-events-selected").removeClass("menu-register-events");        
        $jq(".menu-register-events-text").addClass("menu-register-events-text-selected").removeClass("menu-register-events-text");                
        $jq(".events-mobile-menu").addClass("active");        
    	}
    	
    	$jq(".menu-register-events").click(function(){
    	  window.location = window.location.protocol + "//" + window.location.host + "/eventos"
    	});
    	$jq(".menu-register-fundations").click(function(){
    	  window.location = window.location.protocol + "//" + window.location.host + "/proyectos"
    	});    	
    	$jq(".menu-register-providers").click(function(){
    	  window.location = window.location.protocol + "//" + window.location.host + "/proveedores"
    	});
    	
    	$jq(".my-account-links").click(function(){
    	  window.location = window.location.protocol + "//" + window.location.host + "/members/edit_settings"
    	});    	    	

});
