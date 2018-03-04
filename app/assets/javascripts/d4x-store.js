$(document).ready(function(){
	
	$("#agreement").click(function(){
		var agreem = $("#agreement").attr('checked')
		
	});
	
	$("#user_firstname").focus(function(){
		
		$("#label_firstname").addClass('neon').text
		$("#label_lastname").removeClass('neon').text
		$("#label_nickname").removeClass('neon').text
		$("#label_email").removeClass('neon').text
		$("#label_password").removeClass('neon').text
		$("#label_confirm").removeClass('neon').text
		$("#label_gender").removeClass('neon').text
		$("#label_country").removeClass('neon').text
		$("#label_birthdate").removeClass('neon').text
	});
	
	$("#user_lastname").focus(function(){
		$("#label_firstname").removeClass('neon').text
		$("#label_lastname").addClass('neon').text
		$("#label_nickname").removeClass('neon').text
		$("#label_email").removeClass('neon').text
		$("#label_password").removeClass('neon').text
		$("#label_confirm").removeClass('neon').text
		$("#label_gender").removeClass('neon').text
		$("#label_country").removeClass('neon').text
		$("#label_birthdate").removeClass('neon').text
	});
	
	$("#user_nickname").focus(function(){
		$("#label_firstname").removeClass('neon').text
		$("#label_lastname").removeClass('neon').text
		$("#label_nickname").addClass('neon').text
		$("#label_email").removeClass('neon').text
		$("#label_password").removeClass('neon').text
		$("#label_confirm").removeClass('neon').text
		$("#label_gender").removeClass('neon').text
		$("#label_country").removeClass('neon').text
		$("#label_birthdate").removeClass('neon').text

	});
	
	
	$("#user_email").focus(function(){
		$("#label_firstname").removeClass('neon').text
		$("#label_lastname").removeClass('neon').text
		$("#label_nickname").removeClass('neon').text
		$("#label_email").addClass('neon').text
		$("#label_password").removeClass('neon').text
		$("#label_confirm").removeClass('neon').text
		$("#label_gender").removeClass('neon').text
		$("#label_country").removeClass('neon').text
		$("#label_birthdate").removeClass('neon').text

		
	
	});
	
	$("#user_password").focus(function(){
		$("#label_firstname").removeClass('neon').text
		$("#label_lastname").removeClass('neon').text
		$("#label_nickname").removeClass('neon').text
		$("#label_email").removeClass('neon').text
		$("#label_password").addClass('neon').text
		$("#label_confirm").removeClass('neon').text
		$("#label_gender").removeClass('neon').text
		$("#label_country").removeClass('neon').text
		$("#label_birthdate").removeClass('neon').text

		
	
	});
	
	$("#user_password_confirmation").focus(function(){
		$("#label_firstname").removeClass('neon').text
		$("#label_lastname").removeClass('neon').text
		$("#label_nickname").removeClass('neon').text
		$("#label_email").removeClass('neon').text
		$("#label_password").removeClass('neon').text
		$("#label_confirm").addClass('neon').text
		$("#label_gender").removeClass('neon').text
		$("#label_country").removeClass('neon').text
		$("#label_birthdate").removeClass('neon').text
	});
	
	$("#user_gender").focus(function(){
		$("#label_firstname").removeClass('neon').text
		$("#label_lastname").removeClass('neon').text
		$("#label_nickname").removeClass('neon').text
		$("#label_email").removeClass('neon').text
		$("#label_password").removeClass('neon').text
		$("#label_confirm").removeClass('neon').text
		$("#label_gender").addClass('neon').text
		$("#label_country").removeClass('neon').text
		$("#label_birthdate").removeClass('neon').text
	});
	
	$("#user_country").focus(function(){
		$("#label_firstname").removeClass('neon').text
		$("#label_lastname").removeClass('neon').text
		$("#label_nickname").removeClass('neon').text
		$("#label_email").removeClass('neon').text
		$("#label_password").removeClass('neon').text
		$("#label_confirm").removeClass('neon').text
		$("#label_gender").removeClass('neon').text
		$("#label_country").addClass('neon').text
		$("#label_birthdate").removeClass('neon').text
	});
	
	$("#user_birthday_1i").focus(function(){
		$("#label_firstname").removeClass('neon').text
		$("#label_lastname").removeClass('neon').text
		$("#label_nickname").removeClass('neon').text
		$("#label_email").removeClass('neon').text
		$("#label_password").removeClass('neon').text
		$("#label_confirm").removeClass('neon').text
		$("#label_gender").removeClass('neon').text
		$("#label_country").removeClass('neon').text
		$("#label_birthdate").addClass('neon').text
	});
	
	$("#user_birthday_2i").focus(function(){
		$("#label_firstname").removeClass('neon').text
		$("#label_lastname").removeClass('neon').text
		$("#label_nickname").removeClass('neon').text
		$("#label_email").removeClass('neon').text
		$("#label_password").removeClass('neon').text
		$("#label_confirm").removeClass('neon').text
		$("#label_gender").removeClass('neon').text
		$("#label_country").removeClass('neon').text
		$("#label_birthdate").addClass('neon').text
	});
	
	$("#user_birthday_3i").focus(function(){
		$("#label_firstname").removeClass('neon').text
		$("#label_lastname").removeClass('neon').text
		$("#label_nickname").removeClass('neon').text
		$("#label_email").removeClass('neon').text
		$("#label_password").removeClass('neon').text
		$("#label_confirm").removeClass('neon').text
		$("#label_gender").removeClass('neon').text
		$("#label_country").removeClass('neon').text
		$("#label_birthdate").addClass('neon').text
	});
	
	$("#user_firstname").blur(function(){
		if($("#user_firstname").val().length < 3){
			$("#pFirstname").removeClass().html('<img src="/images/error.png" alt="too short" class="d4xicon">').addClass('span-error');
		} else {
			
			$("#pFirstname").removeClass().html('<img src="/images/tick.png" alt="ok" class="d4xicon">').addClass('span-ok');		
			
		}
		
	});
	
	$("#user_lastname").blur(function(){
		if($("#user_lastname").val().length < 3){
			$("#pLastname").removeClass().html('<img src="/images/error.png" alt="too short" class="d4xicon">').addClass('span-error');
		} else {
			$("#pLastname").removeClass().html('<img src="/images/tick.png" alt="ok" class="d4xicon">').addClass('span-ok');
		}
		
	});
	
	$("#user_email").blur(function(){
		var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		var	sret = re.test($('#user_email').val());
		
		if(sret){
			$("#pEmail").removeClass().html('<img src="/images/tick.png" alt="ok" class="d4xicon">').addClass('span-ok');
				
		} else {
			$("#pEmail").removeClass().html('<img src="/images/error.png" alt="invalid" class="d4xicon">').addClass('span-error');
		}
		
	});
	
	$("#user_password").keyup(function(){
		
		if ($("#user_password").val().length < 6) {
			$("#strength").removeClass().html('<img src="/images/tooshort.png" alt="tooshort" class="d4xicon">').addClass('span-error')
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

			
			
			if (strength < 2 ) {
		        $("#strength").removeClass().html('<img src="/images/weak.png" alt="weak" class="d4xicon">').addClass('span-ok')
		    } else if (strength == 2 ) {
		        $("#strength").removeClass().html('<img src="/images/good.png" alt="good" class="d4xicon">').addClass('span-ok')
		    } else {
		        $("#strength").removeClass().html('<img src="/images/strong.png" alt="strong" class="d4xicon">').addClass('span-ok')
		    }

		}
		    //if length is 8 characters or more, increase strength value
     
		
	});
	
	
	$("#user_password_confirmation").keyup(function(){
		if ( ($("#user_password_confirmation").val()) == ($("#user_password").val()) ) {
			if ($("#user_password_confirmation").val().length < 1){
				$("#pmatch").removeClass().html('<img src="/images/error.png" alt="mismatch" class="d4xicon">').addClass('span-error');
			}else{
				$("#pmatch").removeClass().html('<img src="/images/tick.png" alt="ok" class="d4xicon">').addClass('span-ok');
			}
		} else {
			$("#pmatch").removeClass().html('<img src="/images/error.png" alt="mismatch" class="d4xicon">').addClass('span-error');
		}
		
	});
	
	
	$("#user_gender").change(function(){
		
		if ( ($("#user_gender").val() == 'M') || ($("#user_gender").val() == 'F') ){
			$("#pGender").removeClass().html('<img src="/images/tick.png" class="d4xicon">').addClass('span-ok');
		} else {
			$("#pGender").removeClass().html('<img src="/images/error.png" alt="invalid" class="d4xicon">').addClass('span-error');
		}
		
	});
	
	$("#user_country").change(function(){
		
		if ($("#user_country").val() == ' ') {
			$("#pCountry").removeClass().html('<img src="/images/error.png" alt="invalid" class="d4xicon">').addClass('span-error');
			
		} else {
			$("#pCountry").removeClass().html('<img src="/images/tick.png" class="d4xicon">').addClass('span-ok');
		}
		
	});
	

	$("#user_nickname").blur(function(){
		if ( ($("#user_nickname").val().length < 3) || ($("#user_nickname").val() =='') ) {
			
			$("#pNickname").removeClass().html('<img src="/images/error.png" alt="invalid" class="d4xicon">').addClass('span-error');
			return false
		} else {
			$("#pNickname").removeClass().html('<img src="/images/loader007.gif" alt="checking.." class="checking d4xicon">').addClass('span-ok');	
			$.post("/checknick",{nickname:$("#user_nickname").val() },function(data){
				if(data == 'false'){
						$("#pNickname").html('<img src="/images/taken.png" alt="taken" class="d4xicon">').addClass('span-error');	
				} else {
						$("#pNickname").html('<img src="/images/available.png" alt="available" class="d4xicon">').addClass('span-ok');	
				}
			})
		
		}
		
	});
	
});	



$(document).submit(function(){

	var whole_return = true;
		
		if($("#user_firstname").val().length < 3){
			$("#pFirstname").removeClass().html('<img src="/images/error.png" alt="too short" class="d4xicon">').addClass('span-error');
			whole_return = false;
		} else {
			$("#pFirstname").removeClass().html('<img src="/images/tick.png" alt="ok" class="d4xicon">').addClass('span-ok');
		}
		
	
		if($("#user_lastname").val().length < 3){
			$("#pLastname").removeClass().html('<img src="/images/error.png" alt="too short" class="d4xicon">').addClass('span-error');
			whole_return = false;
		} else {
			$("#pLastname").removeClass().html('<img src="/images/tick.png" alt="ok" class="d4xicon">').addClass('span-ok');
		}
		
		var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		var	sret = re.test($('#user_email').val());
		
		if(sret){
			$("#pEmail").removeClass().html('<img src="/images/tick.png" alt="ok" class="d4xicon">').addClass('span-ok');
				
		} else {
			$("#pEmail").removeClass().html('<img src="/images/error.png" alt="invalid" class="d4xicon">').addClass('span-error');
			whole_return = false;
		}
		
		
		if ($("#user_password").val().length < 6) {
			$("#strength").removeClass().html('<img src="/images/tooshort.png" alt="too short" class="d4xicon">').addClass('span-error')
			whole_return = false;
			
		} else {
			var strength = 0
			if ($("#user_password").val().length > 7) strength += 1
    		if ($("#user_password").val().match(/([a-z].*[A-Z])|([A-Z].*[a-z])/))  strength += 1
		    if ($("#user_password").val().match(/([a-zA-Z])/) && $("#user_password").val().match(/([0-9])/))  strength += 1 
		    if ($("#user_password").val().match(/([!,%,&,@,#,$,^,*,?,_,~])/))  strength += 1
		    if ($("#user_password").val().match(/(.*[!,%,&,@,#,$,^,*,?,_,~].*[!,",%,&,@,#,$,^,*,?,_,~])/)) strength += 1
			if (strength < 2 ) {
		        $("#strength").removeClass().html('<img src="/images/weak.png" alt="weak" class="d4xicon">').addClass('span-ok')
		    } else if (strength == 2 ) {
		        $("#strength").removeClass().html('<img src="/images/good.png" alt="good" class="d4xicon">').addClass('span-ok')
		    } else {
		        $("#strength").removeClass().html('<img src="/images/strong.png" alt="strong" class="d4xicon">').addClass('span-ok')
		    }
		}

		if ( ($("#user_password_confirmation").val()) == ($("#user_password").val()) ) {
			if ($("#user_password").val().length > 0)
			{
				$("#pmatch").removeClass().html('<img src="/images/tick.png" class="d4xicon">').addClass('span-ok');
			}else{
				$("#pmatch").removeClass().html('<img src="/images/error.png" class="d4xicon">').addClass('span-error')
				
			}
		} else {
			$("#pmatch").removeClass().html('<img src="/images/mismatch.png" alt="mismatch" class="d4xicon">').addClass('span-error')
			whole_return = false;
		}
		
		if ( ($("#user_gender").val() == 'M') || ($("#user_gender").val() == 'F') ){
			$("#pGender").removeClass().html('<img src="/images/tick.png" class="d4xicon">').addClass('span-ok');
		} else {
			$("#pGender").removeClass().html('<img src="/images/error.png" alt="invalid" class="d4xicon">').addClass('span-error');
			whole_return = false;
		}
		
		if ($("#user_country").val() == ' ') {
			$("#pCountry").removeClass().html('<img src="/images/error.png" alt="invalid" class="d4xicon">').addClass('span-error');
			whole_return = false;
			
		} else {
			$("#pCountry").removeClass().html('<img src="/images/tick.png" class="d4xicon">').addClass('span-ok');
		}
		
		if($("#user_nickname").val().length < 3){
			$("#pNickname").removeClass().html('<img src="/images/error.png" alt="invalid" class="d4xicon">').addClass('span-error');
			whole_return = false;
		} 
		
		if ($("#user_country").val() == ' ') {
			$("#pCountry").removeClass().html('<img src="/images/error.png" alt="invalid" class="d4xicon">').addClass('span-error');
			whole_return = false;
		}
		
		if (!$("#agreement").is(':checked')) {
			whole_return = false;
		}
		
		
		
	return whole_return;	
});	