$(document).ready(function(){
	$("#user_nickname").focus(function(){
		$("#msg-box").addClass().addClass('none').text;
	});
	
	$("#user_nickname").blur(function(){
		$("#msg-box").removeClass().addClass('message-box').text;
		$.post("/checknick",{nickname:$("#user_nickname").val() },function(data){
			if(data == 'false'){
					$("#msg-box").html('nick already taken').addClass('message-box-error');	
			} else {
					$("#msg-box").html('nick available').addClass('message-box-ok');	
			}
		});
	});
});	