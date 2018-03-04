$(document).ready(function(){
	
	$("#contact_name").click(function(){
		$("#contact_name").val('');
	
	});
	$("#contact_surname").click(function(){
		$("#contact_surname").val('');
	
	});
	$("#contact_email").click(function(){
		$("#contact_email").val('');
	
	});
	$("#contact_age").click(function(){
		$("#contact_age").val('');
	
	});
	
	$("#add-contact").click(function(){
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
		
		if ($("#user_country").val() == ' ') {
			$("#pCountry").removeClass().html('<img src="/images/error.png" alt="invalid" class="d4xicon">').addClass('span-error');
			whole_return = false;
		}
		
		return whole_return;	
	});

	$("#select_all").click(function(){
		var checkall = $('#select_all')
		if (!$(checkall).is(':checked'))
		{
	    	 $("input:checkbox").each(function(){
	        	   $(this).removeAttr('checked');
	         });
	         $(checkall).removeAttr('checked')
	    }else{
	         $("input:checkbox").each(function(){
	               $(this).attr('checked',true);
	         });
	         $(checkall).attr('checked')
	    }
	});
	
	$("#current_account").change(function(){
		var user;
		var fromname;
		var fromaddress;
	
		$.ajax({
		  url: "/mail_accounts/change",
		  cache: false,
		  type: 'POST',
		  beforeSend: function(xhr){
		  	// IMPORTANTO FOR APPSEC AGAINST CSRF ATTACKS, Add this header to ALL Ajax Requests!!!!!!!!!!!!!! :)
		 		xhr.setRequestHeader('X-CSRF-Token',$('meta[name="csrf-token"]').attr('content')) 
		  },
		  data: { 
		  	account_id:this.value
		  },
		  dataType: "json",

		  success: function(data) {
			fromname = data.fromname;
			fromaddress = data.fromaddress;
			$("#from_name").html(fromname);
			$("#from").val(fromaddress);
			document.refresh;
	
	 	}});
	});

	
});
