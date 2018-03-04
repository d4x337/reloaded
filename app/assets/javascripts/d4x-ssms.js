$(document).ready(function(){
	var fullnumber = document.getElementById('full_number');

	$("#dest_int_prefix").change(function(){
		if ($("#dest_int_prefix").val() == '39'){
			$("#other-prefix").addClass('none');
			$("#italian-prefix").removeClass('none');
			fullnumber.value = "+"+$("#dest_int_prefix").val()+" "+$("#dest_loc_prefix").val()+" "+$("#dest_number").val();
		} else {
			$("#other-prefix").removeClass('none');
			$("#italian-prefix").addClass('none');
			fullnumber.value = "+"+$("#dest_int_prefix").val()+" "+$("#dest_local_prefix2").val()+" "+$("#dest_number").val();
		}
	});
	
	$("#dest_loc_prefix").change(function(){
		if ($("#dest_int_prefix").val() == '39'){
			fullnumber.value = "+"+$("#dest_int_prefix").val()+" "+$("#dest_loc_prefix").val()+" "+$("#dest_number").val();
		}else{
			fullnumber.value = "+"+$("#dest_int_prefix").val()+" "+$("#dest_local_prefix2").val()+" "+$("#dest_number").val();
		}
	});
	
	$("#dest_local_prefix2").keyup(function(){
		fullnumber.value = "+"+$("#dest_int_prefix").val()+" "+$("#dest_local_prefix2").val()+" "+$("#dest_number").val();
	});
	
	$("#dest_number").keyup(function(){
		fullnumber.value = "+"+$("#dest_int_prefix").val()+" "+$("#dest_loc_prefix").val()+" "+$("#dest_number").val();
	});
	
	$("#message").keyup(function(){
		var remaining = document.getElementById('remainingchars');
		var message = document.getElementById('message');
		remaining.value =  150 - $("#message").val().length;
	});
	
});	
	