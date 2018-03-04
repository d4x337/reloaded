$(document).ready(function(){
	
	$("#user_email").keypress(function(){
	    this.value = this.value.replace(/[^0-9A-Za-z\@._-]/g,'');
    });
	
	$("#user_email").keydown(function(){
	    this.value = this.value.replace(/[^0-9A-Za-z\@._-]/g,'');
    });

	$("#user_email").keyup(function(){
	    this.value = this.value.replace(/[^0-9A-Za-z\@._-]/g,'');
    });
	
});	

