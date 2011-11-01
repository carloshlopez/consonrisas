jQuery(document).ready(function($) {
    $('.use_facebook_pic').bind('change', function() {
        if($('.use_facebook_pic').attr('checked')){
            $('.custom_pic').hide();
        }
        else{
            $('.custom_pic').show();
        }
    });
    
    $('#facilitator_isCompany').bind('change', function() {
        if($(this).attr('checked')){
            $('#company_info').slideDown();
        }
        else{
            $('#company_info').slideUp();
        }
    });
    
    if($('#facilitator_isCompany').attr('checked')){
            $('#company_info').show();
    }
       
});
