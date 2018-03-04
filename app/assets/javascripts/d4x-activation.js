$(document).ready(function(){

    $('.imagelogo').mouseover(function(){
        $('.imagelogo').addClass('animated rotateIn');
    });
    $('.imagelogo').mouseout(function(){
        $('.imagelogo').removeClass('animated rotateIn');
    });

	$("#couponCode").focus(function(){
		$("#label_email").removeClass().addClass('green-lcd center').text
	});
	
	$("#couponCode").blur(function(){
		$("#label_email").removeClass().addClass('white-lcd center').text
	});

	$("#couponCode").keypress(function(){
	    this.value = this.value.replace(/[^0-9a-zA-Z\@._-]/g,'');
        this.value = this.value.toUpperCase();
    });
	$("#couponCode").keydown(function(){
	    this.value = this.value.replace(/[^0-9a-zA-Z\@._-]/g,'');
        this.value = this.value.toUpperCase();
    });
	$("#couponCode").keyup(function(){
	    this.value = this.value.replace(/[^0-9a-zA-Z\@._-]/g,'');
        this.value = this.value.toUpperCase();
    });

    $("#couponCode").blur(function(){
        if ( ($("#couponCode").val().length < 3) || ($("#couponCode").val() =='') ) {
            return false
        } else {
            $("#reg-title").html('Checking...');
            $.post("/addcoupon",{couponCode:$("#couponCode").val() },function(data){
                if(data == 'false'){

                } else {
                    window.location.replace("/coupon_activation?couponCode="+$("#couponCode").val()+"&amount="+data);

                    $('.stripe-button').attr('data-amount', data)
                    $(".stripe-button").attr("data-label", 'Activate and Pay '+ data/100 +'€ with Credit Card');
                    $(".stripe-button-el span").text('Activate and Pay '+ data/100 +'€ with Credit Card');
                    $("#js_activation").attr('data-amount', data)
                    $("#js_activation").attr("data-label", 'Activate and Pay '+ data/100 +'€ with Credit Card');
                }
            })
        }
    });

});	

$(document).submit(function(){

	var sRet = true;

	if(sret){
		$("#checking-login").removeClass('none')
        sRet = true;
	} else {
        sRet = false;
	}
		
    return sRet;
});	