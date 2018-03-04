$(document).ready(function(){
	
	$("#wait-please").removeClass().addClass('none');
	
	$("#agreement").click(function(){
		var agreem = $("#agreement").attr('checked')
	});

    $('.imagelogo').mouseover(function(){
        $('.imagelogo').addClass('animated rotateIn');
    });
    $('.imagelogo').mouseout(function(){
        $('.imagelogo').removeClass('animated rotateIn');
    });
		
	$("#user_firstname").keypress(function(){
	    this.value = this.value.replace(/[^A-Za-z]/g/' ','');
    });
	$("#user_firstname").keydown(function(){
	    this.value = this.value.replace(/[^A-Za-z]/g/' ','');
    });
	$("#user_firstname").keyup(function(){
	    this.value = this.value.replace(/[^A-Za-z]/g/' ','');
    });

	$("#user_nickname").keypress(function(){
	    this.value = this.value.replace(/[^0-9a-z\._-]/g,'');
   	    this.value = this.value.toLowerCase();

    });
	$("#user_nickname").keydown(function(){
	    this.value = this.value.replace(/[^0-9a-z\._-]/g,'');
	    this.value = this.value.toLowerCase();
    });
	$("#user_nickname").keyup(function(){
	    this.value = this.value.replace(/[^0-9a-z\._-]/g,'');
	    this.value = this.value.toLowerCase();
    });

	$("#user_email").keypress(function(){
	    this.value = this.value.replace(/[^0-9a-z\@._-]/g,'');
	    this.value = this.value.toLowerCase();
    });
	$("#user_email").keydown(function(){
	    this.value = this.value.replace(/[^0-9a-z\@._-]/g,'');
	    this.value = this.value.toLowerCase();
    });
	$("#user_email").keyup(function(){
	    this.value = this.value.replace(/[^0-9a-z\@._-]/g,'');
	    this.value = this.value.toLowerCase();
    });

	$("#user_firstname").blur(function(){
		if($("#user_firstname").val().length < 3){
			$("#user_firstname").removeClass('border-green').addClass('border-red')
		} else {
			$("#user_firstname").removeClass('border-red').addClass('border-green')
		}
		
	});
		
	$("#user_nickname").blur(function(){
		if ( ($("#user_nickname").val().length < 3) || ($("#user_nickname").val() =='') ) {
		$("#user_nickname").removeClass('border-green').addClass('border-red')
			$("#reg-title").html('Username too short (3)');
			$("#group-nick").removeClass('has-success').addClass('has-error has-feedback');
			$("#nick-icon").removeClass('zmdi zmdi-check').addClass('zmdi zmdi-alert-circle-o');
			return false
		} else {
				$("#reg-title").html('Checking...');
	
					$.post("/checknick",{nickname:$("#user_nickname").val() },function(data){
				  
					if(data == 'false'){
						$("#user_nickname").removeClass('border-green').addClass('border-orange')
						$("#user_nickname").removeClass('border-green').removeClass('border-red').addClass('border-orange')
						$("#reg-title").html('Username is taken');
						$("#group-nick").removeClass('has-success').addClass('has-error has-feedback');
						$("#nick-icon").removeClass('zmdi zmdi-check').addClass('zmdi zmdi-alert-circle-o');
					} else {
						$("#user_nickname").removeClass('border-orange').removeClass('border-red').addClass('border-green')
						$("#reg-title").html('Username is available');
						$("#group-nick").removeClass('has-error').addClass('has-success has-feedback');
						$("#nick-icon").removeClass('zmdi zmdi-alert-circle-o').addClass('zmdi zmdi-check');
					}
			})
		
		}
	});

	$("#user_email").blur(function(){
		var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		var	sret = re.test($('#user_email').val());
		if(sret){
			$("#reg-title").html('Checking...');
				$.post("/checkemail",{email:$("#user_email").val() },function(data){
					if(data == 'false'){
						$("#user_email").removeClass('border-green').removeClass('border-red').addClass('border-orange')
						$("#reg-title").html('E-Mail already registered');
						$("#group-email").removeClass('has-success has-feedback').addClass('has-error has-feedback');
						$("#email-icon").removeClass('zmdi zmdi-check').addClass('zmdi zmdi-alert-circle-o');
					} else {
						$("#user_email").removeClass('border-orange').removeClass('border-red').addClass('border-green')
						$("#reg-title").html('E-Mail is Good');
						$("#group-email").removeClass('has-error has-feedback').addClass('has-success has-feedback');
						$("#email-icon").removeClass('zmdi zmdi-alert-circle-o').addClass('zmdi zmdi-check');
					}
				})
		} else {
			$("#user_email").removeClass('border-orange').removeClass('border-green').addClass('border-red')
			$("#reg-title").html('E-Mail is invalid');
			$("#group-email").removeClass('has-success has-feedback').addClass('has-error has-feedback');
			$("#email-icon").removeClass('zmdi zmdi-check').addClass('zmdi zmdi-alert-circle-o');
		}
	});
	
	
	
	$("#user_password").keyup(function(){
		
		if ($("#user_password").val().length < 8) {
			$("#reg-title").html('Password is too weak');
			$("#group-pass").removeClass('has-success has-feedback').addClass('has-error has-feedback');
			$("#pass-icon").removeClass('zmdi zmdi-check').addClass('zmdi zmdi-alert-circle-o');
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
				$("#user_password").removeClass('border-green').removeClass('border-orange').addClass('border-red')
		 		$("#reg-title").html('Password is too Weak');
	 			$("#group-pass").removeClass('has-success has-feedback').addClass('has-error has-feedback');
				$("#pass-icon").removeClass('zmdi zmdi-check').addClass('zmdi zmdi-alert-circle-o');
		    } else if (strength == 3 ) {
				$("#user_password").removeClass('border-orange').removeClass('border-red').addClass('border-green')
				$("#reg-title").html('Password is Good');
				$("#group-pass").removeClass('has-error has-feedback').addClass('has-success has-feedback');
				$("#pass-icon").removeClass('zmdi zmdi-alert-circle-o').addClass('zmdi zmdi-check');
	       } else {
	   			$("#user_password").removeClass('border-red').removeClass('border-orange').addClass('border-green')	
				$("#reg-title").html('Password is Strong!');
				$("#group-pass").removeClass('has-success has-feedback').addClass('has-error has-feedback');
				$("#pass-icon").removeClass('zmdi zmdi-check').addClass('zmdi zmdi-alert-circle-o');
			}

		}
		    //if length is 8 characters or more, increase strength value
     
		
	});
	
	
		

	$("#signup-submit").click(function(){
		
		var whole_return = true;
		
		if($("#user_firstname").val().length < 3){
			$("#user_firstname").removeClass('border-green').addClass('border-red');
			return false;
		} else {
			$("#user_firstname").removeClass('border-red').addClass('border-green');
		}
		
		if ( ($("#user_nickname").val().length < 3) || ($("#user_nickname").val() =='') ) {
			$("#user_nickname").removeClass('border-green').addClass('border-red');
			$("#reg-title").html('Username too short (3)');
			return false;
		} else {
			$("#user_nickname").removeClass('border-red').addClass('border-green');
		}
			
		var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		var	sret = re.test($('#user_email').val());
		if(sret){
			$("#user_email").removeClass('border-red').addClass('border-green');
		} else {
			$("#user_email").removeClass('border-green').addClass('border-red');
			$("#reg-title").html('Email is not Valid');
			return false;
		}
		
		if ($("#user_password").val().length < 8) {
			$("#user_password").removeClass('border-green').addClass('border-red');
			$("#reg-title").html('Password is too weak');
			return false;
		} else {
			var strength = 0
			if ($("#user_password").val().length > 7) strength += 1
    		if ($("#user_password").val().match(/([a-z].*[A-Z])|([A-Z].*[a-z])/))  strength += 1
		    if ($("#user_password").val().match(/([a-zA-Z])/) && $("#user_password").val().match(/([0-9])/))  strength += 1 
		    if ($("#user_password").val().match(/([!,%,&,@,#,$,^,*,?,_,~])/))  strength += 1
		    if ($("#user_password").val().match(/(.*[!,%,&,@,#,$,^,*,?,_,~].*[!,",%,&,@,#,$,^,*,?,_,~])/)) strength += 1
			if (strength < 3 ) {
				$("#user_password").removeClass('border-green').removeClass('border-orange').addClass('border-red');
		 		$("#reg-title").html('Password is too Weak');
				return false;
		    } else if (strength == 3 ) {
				$("#user_password").removeClass('border-orange').removeClass('border-red').addClass('border-green');
				$("#reg-title").html('Password is Good');
		    } else {
	   			$("#user_password").removeClass('border-red').removeClass('border-orange').addClass('border-green');	
				$("#reg-title").html('Password is Strong!');
			}
		}

		if (!$("#agreement").is(':checked')) {
			$("#reg-title").html('Please Accept Terms and Conditions');
			return false;
		}
		
		if (whole_return == true){
			$("#wait-please").removeClass();
		}
		
		return true;	
		
	});

});	

