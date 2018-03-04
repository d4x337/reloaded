$(document).ready(function(){


    $("#htmlmsg").change(function(){
        if ($("#htmlmsg").is(':checked')){
          $("#html-message").removeClass('none')
          $("#text-message").removeClass().addClass('none')
        }else{
          $("#html-message").removeClass().addClass('none')
          $("#text-message").removeClass('none')
        }
    });
	
	$("#send").click(function(){
		
		if ($("#to").val().length < 1) 
	  	{
	  		alert("recipient is empty")
	  		return false;
	  	}
	  	$("#sending").removeClass('none')
    });
	
	$("#user_email_login").focus(function(){
		$("#label_email_login").addClass('neon').text
		$("#label_pass_login").removeClass('neon').text
	});
	
	$("#user_pass_login").focus(function(){
		$("#label_email_login").removeClass('neon').text
		$("#label_pass_login").addClass('neon').text
	});
	
	$("#user_email_login").blur(function(){
		var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		var	sret = re.test($('#user_email_login').val());
		if(sret){
			$("#user_email_login").addClass('green-border').text	
		} else {
			$("#user_email_login").addClass('red-border').text
		}
	});
	
	$("#user_email_login").keypress(function(){
	    this.value = this.value.replace(/[^0-9A-Za-z\@._-]/g,'');
    });
	
	$("#user_email_login").keydown(function(){
	    this.value = this.value.replace(/[^0-9A-Za-z\@._-]/g,'');
    });

	$("#user_email_login").keyup(function(){
	    this.value = this.value.replace(/[^0-9A-Za-z\@._-]/g,'');
    });

	
});	

