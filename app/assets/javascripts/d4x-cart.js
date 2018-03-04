$(document).ready(function(){
	
	$("#prod_id").change(function(){
		$.post("/update-cart",{cart_id:$("#cart_id").val(),prod_id:$("#prod_id").val(),items:$("#cart_items").val()},function(data){
			if(data == 'false'){
		
			} else {
				
				$('#product-name').html("Agadanga "+$("#prod_id").find('option:selected').text()+" "+$("#choosen-address").text()+" ("+$("#cart_items").find('option:selected').text()+" subscription)")
				
				switch($('#prod_id').val()){
					case "2":
					$("#total_price").html(" "+24+".00")
					$("#total_cart").html(" "+24*$("#cart_items").val()+".00")
					$("#total_month").html(" "+24/12+".00")
					$('#express-paypal').attr('href','https://www.sandbox.paypal.com/cgi-bin/webscr?amount_1='+$('#total_price').html()+'&business=system-facilitator%40agadanga.com&cmd=_cart&invoice='+$('#cart_id').val()+'&item_name_1='+$('#product-name').html()+'&item_number_1=2&quantity_1='+$('#cart_items').val()+'&return=http%3A%2F%2F127.0.0.1%3A3000%2Fproducts%3Flocale%3Den&upload=1')
						
					return
					
					case "3":
					$("#total_price").html(" "+60+".00")
					$("#total_cart").html(" "+60*$("#cart_items").val()+".00")
					$("#total_month").html(" "+60/12+".00")
					$('#express-paypal').attr('href','https://www.sandbox.paypal.com/cgi-bin/webscr?amount_1='+$('#total_price').html()+'&business=system-facilitator%40agadanga.com&cmd=_cart&invoice='+$('#cart_id').val()+'&item_name_1='+$('#product-name').html()+'&item_number_1=3&quantity_1='+$('#cart_items').val()+'&return=http%3A%2F%2F127.0.0.1%3A3000%2Fproducts%3Flocale%3Den&upload=1')
					return
					
					case "4":
					$("#total_price").html(" "+180+".00")
					$("#total_cart").html(" "+180*$("#cart_items").val()+".00")
					$("#total_month").html(" "+180/12+".00")
					$('#express-paypal').attr('href','https://www.sandbox.paypal.com/cgi-bin/webscr?amount_1='+$('#total_price').html()+'&business=system-facilitator%40agadanga.com&cmd=_cart&invoice='+$('#cart_id').val()+'&item_name_1='+$('#product-name').html()+'&item_number_1=4&quantity_1='+$('#cart_items').val()+'&return=http%3A%2F%2F127.0.0.1%3A3000%2Fproducts%3Flocale%3Den&upload=1')
					return
					
				}
			}
		})

	});
	
	$("#cart_items").change(function(){
		$.post("/update-cart",{cart_id:$("#cart_id").val(),prod_id:$("#prod_id").val(),items:$("#cart_items").val()},function(data){
			if(data == 'false'){

			} else {
				$('#product-name').html("Agadanga "+$("#prod_id").find('option:selected').text()+" "+$("#choosen-address").text()+" ("+$("#cart_items").find('option:selected').text()+" subscription)")
	
				switch($('#prod_id').val()){
					case "2":
					$("#total_cart").html(" "+24*$("#cart_items").val()+".00")
					$('#express-paypal').attr('href','https://www.sandbox.paypal.com/cgi-bin/webscr?amount_1='+$('#total_price').html()+'&business=system-facilitator%40agadanga.com&cmd=_cart&invoice='+$('#cart_id').val()+'&item_name_1='+$('#product-name').html()+'&item_number_1=4&quantity_1='+$('#cart_items').val()+'&return=http%3A%2F%2F127.0.0.1%3A3000%2Fproducts%3Flocale%3Den&upload=1')
					return
					
					case "3":
					$("#total_cart").html(" "+60*$("#cart_items").val()+".00")
					$('#express-paypal').attr('href','https://www.sandbox.paypal.com/cgi-bin/webscr?amount_1='+$('#total_price').html()+'&business=system-facilitator%40agadanga.com&cmd=_cart&invoice='+$('#cart_id').val()+'&item_name_1='+$('#product-name').html()+'&item_number_1=4&quantity_1='+$('#cart_items').val()+'&return=http%3A%2F%2F127.0.0.1%3A3000%2Fproducts%3Flocale%3Den&upload=1')
					return
					
					case "4":
					$("#total_cart").html(" "+180*$("#cart_items").val()+".00")
					$('#express-paypal').attr('href','https://www.sandbox.paypal.com/cgi-bin/webscr?amount_1='+$('#total_price').html()+'&business=system-facilitator%40agadanga.com&cmd=_cart&invoice='+$('#cart_id').val()+'&item_name_1='+$('#product-name').html()+'&item_number_1=4&quantity_1='+$('#cart_items').val()+'&return=http%3A%2F%2F127.0.0.1%3A3000%2Fproducts%3Flocale%3Den&upload=1')
					return
				}

			}
		})
	});
});	

