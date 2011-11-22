var $jq = jQuery.noConflict();
$jq.widget("ui.fbConnect", {
    _init: function() {
    	var self= this;
    	var $el= this.element;
    	FB.init({ 
	        appId:'161667273881845', cookie:true, 
	        status: true, xfbml:true 
        });
         
        FB.Event.subscribe('auth.login', function(response) {
	        FB.api('/me', function(response) {
	          var fbId = response.id;
	          self._updateFbId(fbId);
	        });
        });
    },
    _updateFbId: function(fbId){
    	var self= this;
        var member_id = this.element.attr("member_id");
        jQuery.post( "/members/"+ member_id +"/update_facebook_id", { facebook_id: fbId },
            function(data, textStatus, XMLHttpRequest){
                self._addPermissions();
            }, "text" );

    },
    _addPermissions: function(){
    	$jq('.fblogginButton').hide();
    	var self= this;
        FB.ui({method: "permissions.request", "perms": 'publish_stream,create_event,rsvp_event,user_photos'} , 
	        function(response){
		        if(response.perms){
	            	$jq('.fbPermissions').hide();
			        self._postWelcome();	  
		        }
		        else{
                    alert("No podrás compartir tus noticias en facebook si no le das permiso a la aplicación en facebook");
                   	$jq('.fbPermissions').show();
		        }
	        }
        );
    },
    _postWelcome: function(){
        FB.api('/me/feed', 'post', 
		    {
		    link: 'http://www.conectandosonrisas.org', 
		    picture:'http://www.conectandosonrisas.org/images/conectando_sonrisas.png',
		    name:'Conectando Sonrisas',
		    description:'Tu puedes generar momentos mágicos',
		    message:'Me acabo de registrar en Conectando Sonrisas!',
		    caption:'Somos todos!'
		    }, function(response) {
	      		if (!response || response.error) {
	        	alert(response);
	      	} else {
	      	}
	    });  
    }
});

jQuery(document).ready(function($) {
    var fb = $jq("#fbConnect").fbConnect();
    $jq('.fbPermissions').bind('click', function() {
        alert("Pendiente");
    });
});
