$(document).ready(function(){

	$('.imagelogo').mouseover(function(){
		$('.imagelogo').addClass('animated rotateIn');
	});
	$('.imagelogo').mouseout(function(){
		$('.imagelogo').removeClass('animated rotateIn');
	});


	$("#user_nickname").keypress(function(){
	    this.value = this.value.replace(/[^0-9a-zA-Z\@._-]/g,'');
   	    this.value = this.value.toLowerCase();
    });

	$("#user_nickname").keydown(function(){
	    this.value = this.value.replace(/[^0-9a-zA-Z\@._-]/g,'');
	    this.value = this.value.toLowerCase();
    });

	$("#user_nickname").keyup(function(){
	    this.value = this.value.replace(/[^0-9a-zA-Z\@._-]/g,'');
	    this.value = this.value.toLowerCase();
    });

	$("#user_email").blur(function(){
		var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		var	sret = re.test($('#user_email').val());
	});
	
	$("#bt-signin").click(function(){

        var whole_return = true;
		if ($("#user_nickname").val().length < 3) {
            $("#user_nickname").removeClass('border-green').addClass('border-red');
			whole_return = false;
		} 

		if ($("#user_password").val().length < 8) {
            $("#user_password").removeClass('border-green').addClass('border-red');
			whole_return = false;
		}

		if (whole_return == true) {
			$("#spinner").removeClass("none");
			$(".motto").html('Logging in.. Please Wait');
		}
		
		return whole_return;
	});
	
});	

