$(document).ready(function(){

    $('.imagelogo').mouseover(function(){
        $('.imagelogo').addClass('animated rotateIn');
    });
    $('.imagelogo').mouseout(function(){
        $('.imagelogo').removeClass('animated rotateIn');
    });

    $("#user_email").focus(function(){
		$("#label_email").removeClass().addClass('green-lcd center').text
	});
	
	$("#user_email").blur(function(){
		$("#label_email").removeClass().addClass('white-lcd center').text
	});

	$("#user_email").keypress(function(){
	    this.value = this.value.replace(/[^0-9a-z\@._-]/g,'');
    });
	$("#user_email").keydown(function(){
	    this.value = this.value.replace(/[^0-9a-z\@._-]/g,'');
    });
	$("#user_email").keyup(function(){
	    this.value = this.value.replace(/[^0-9a-z\@._-]/g,'');
    });


	
});	

$(document).submit(function(){

	var whole_return = true;
	var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	
		
	if($("#user_email").val().length < 4){
		return false
	}
	var	sret = re.test($('#user_email').val());
	if(sret){
		$("#checking-login").removeClass('none')
		return true
			
	} else {
		return false
	}
		
	
});	