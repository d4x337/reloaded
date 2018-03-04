$(document).ready(function(){
	$("#user_password").keyup(function(){
		if ($("#user_password").val().length < 8) {
			$("#change-title").html('Password is too weak');
			$("#group-pass").removeClass('has-success has-feedback').addClass('has-error has-feedback');
			$("#pass-icon").removeClass('glyphicon-ok').addClass('glyphicon-remove');
		} else {
			var strength = 0
			
			if ($("#user_password").val().length > 7) strength += 1
		
		    //if password contains both lower and uppercase characters, increase strength value
    	  	if ($("#user_password").val().match(/([a-z].*[A-Z])|([A-Z].*[a-z])/))  strength += 1
 
		    //if it has numbers and characters, increase strength value
		    if ($("#user_password").val().match(/([a-zA-Z])/) && $("#user_password").val().match(/([0-9])/))  strength += 1 
		 
		    //if it has one special character, increase strength value
	        if ($("#user_password").val().match(/([!,%,&,@,#,$,^,*,?,_,~])/))  strength += 1
		 
		    //if it has two special characters, increase strength value
		    if ($("#user_password").val().match(/(.*[!,%,&,@,#,$,^,*,?,_,~].*[!,",%,&,@,#,$,^,*,?,_,~])/)) strength += 1

			
	    	if (strength < 3 ) {
		 		$("#change-title").html('Password is too Weak');
	 			$("#group-pass").removeClass('has-success has-feedback').addClass('has-error has-feedback');
				$("#pass-icon").removeClass('glyphicon-ok').addClass('glyphicon-remove');
		    } else if (strength == 3 ) {
				$("#change-title").html('Password is Good');
				$("#group-pass").removeClass('has-error has-feedback').addClass('has-success has-feedback');
				$("#pass-icon").removeClass('glyphicon-remove').addClass('glyphicon-ok');
	        } else {
	   			$("#change-title").html('Password is Strong!');
				$("#group-pass").removeClass('has-error has-feedback').addClass('has-success has-feedback');
				$("#pass-icon").removeClass('glyphicon-remove').addClass('glyphicon-ok');
			}
		}
		    //if length is 8 characters or more, increase strength value
	});
	
	
	$("#user_password_confirmation").blur(function(){
		if ($("#user_password").val() == $("#user_password_confirmation").val())
		{
			$("#change-title").html('Passwords Match!');
			$("#group-pass-confirmation").removeClass('has-error has-feedback').addClass('has-success has-feedback');
			$("#pass-confirmation-icon").removeClass('glyphicon-remove').addClass('glyphicon-ok');
		}else{
			$("#change-title").html('Passwords Do Not Match');
			$("#group-pass-confirmation").removeClass('has-success has-feedback').addClass('has-error has-feedback');
			$("#pass-confirmation-icon").removeClass('glyphicon-ok').addClass('glyphicon-remove');
		}
	});
	
	
});	

