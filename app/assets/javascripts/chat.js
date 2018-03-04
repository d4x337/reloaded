
var windowFocus = true;
var username;
var chatHeartbeatCount = 0;
var minChatHeartbeat = 1000;
var maxChatHeartbeat = 33000;
var chatHeartbeatTime = minChatHeartbeat;
var originalTitle;
var blinkOrder = 0;

var chatboxFocus = new Array();
var newMessages = new Array();
var newMessagesWin = new Array();
var chatBoxes = new Array();

$(document).ready(function(){
	
	originalTitle = document.title;
	chatboxtitle  = "loading"
	createChatList(chatboxtitle,true);	
	
	$([window, document]).blur(function(){
		windowFocus = false;
	}).focus(function(){
		windowFocus = true;
		document.title = originalTitle;
	});
	
	$("#set_chat_status").click(function(){
		
		var status = $("#set_chat_status").html()
		var status_id;
		
		if (status =="Go Online"){
			status_id=1;
		}else if (status =="Go Offline"){
			status_id=0;
		}else if (status =="Set Away"){
			status_id=2;
		}else if (status =="Be Invisible"){
			status_id=3;
		}
		set_status(status_id);
	});

	$("#set_online").click(function(){
		set_status(1);
	});

	$("#set_offline").click(function(){
		set_status(0);
	});

	$("#set_offline").mouseover(function(){

	});

	$("#set_online").mouseover(function(){

	});
	
	$("#advanced_chat").click(function(){
		advancedStuff();
	});
	
	
	$(".chatboxoptions").click(function(){
		if ($(".chatmenu").css('display') != 'none') {
			$('.chatmenu').css('display','none');
			$('.chatmenu').css('display','none');
		} else {
			$('.chatmenu').css('display','block');
			$('.chatmenu').css('display','block');
		}
	});

});

function set_status(idstatus){
	var user;
	var status;
	$.ajax({
	  url: "/chat/set_status?ccc="+idstatus,
	  beforeSend: function(xhr){
		xhr.setRequestHeader('X-CSRF-Token',$('meta[name="csrf-token"]').attr('content')); 
	  },
	  cache: false,
	  type: 'POST',
	  data: { 
	  	status_id:idstatus
	  },
	 
	  success: function(data) {
		location.reload();
 	}});
}


function restructureChatBoxes() {
	align = 0;
	for (x in chatBoxes) {
		chatboxtitle = chatBoxes[x];

		if ($("#chatbox_"+chatboxtitle).css('display') != 'none') {
			if (align == 0) {
				$("#chatbox_"+chatboxtitle).css('right', '20px');
			} else {
				width = (align)*(225+7)+20;
				$("#chatbox_"+chatboxtitle).css('right', width+'px');
			}
			align++;
		}
	}
}

function chatWith(chatuser) {
	createChatBox(chatuser);
	$("#chatbox_"+chatuser+" .chatboxtextarea").focus();
}

function createChatList(chatboxtitle,minimizeChatBox) {
	if ($("#chatbox_"+chatboxtitle).length > 0) {
		if ($("#chatbox_"+chatboxtitle).css('display') == 'none') {
			$("#chatbox_"+chatboxtitle).css('display','block');
			restructureChatBoxes();
		}
		return;
	}
	
   $(" <div />" ).attr("id","chatbox_"+chatboxtitle)
	.addClass("chatbox")
   .html('<div class="chatboxhead"><a href="javascript:void(0)" onclick="javascript:toggleChatListGrowth(\''+chatboxtitle+
   '\')"><div class="chatboxtitle">'+chatboxtitle+
   '</div><div id="gear" class="chatboxoptions"><img src="images/cog.png" height="12" width="12"></div><div id="popup" class="chatmenu"> <div class="chatmenuitem" id="set_online"><img src="/images/tick.png" height="12" width="12" id="tick-online" class="middle">&nbsp;&nbsp;Go Online</div><div class="chatmenuitem" id="set_offline"><img src="/images/cancel.png" height="12" width="12" class="middle"  id="tick-offline">&nbsp;&nbsp;Go Offline</div><div class="chatmenuitem" id="advanced_chat"><img src="/images/cog_edit.png" height="12" width="12" class="middle"  id="icon-advanced-chat">&nbsp;&nbsp;Advanced</div></div></a><br clear="all"/></div><div class="chatboxlist"></div><div class="chatboxinput"></div>')
	.appendTo($( "body" ));
 	 
 	 
	$("#chatbox_"+chatboxtitle).css('bottom', '0px');
	
	chatBoxeslength = 0;

	for (x in chatBoxes) {
		if ($("#chatbox_"+chatBoxes[x]).css('display') != 'none') {
			chatBoxeslength++;
		}
	}

	if (chatBoxeslength == 0) {
		$("#chatbox_"+chatboxtitle).css('right', '20px');
	} else {
		width = (chatBoxeslength)*(225+7)+20;
		$("#chatbox_"+chatboxtitle).css('right', width+'px');
	}
	
	chatBoxes.push(chatboxtitle);

	if (minimizeChatBox == 1) {
		minimizedChatBoxes = new Array();

		if ($.cookie('chatbox_minimized')) {
			minimizedChatBoxes = $.cookie('chatbox_minimized').split(/\|/);
		}
		minimize = 0;
		for (j=0;j<minimizedChatBoxes.length;j++) {
			if (minimizedChatBoxes[j] == chatboxtitle) {
				minimize = 1;
			}
		}

		if (minimize == 1) {
			$('#chatbox_'+chatboxtitle+' .chatboxlist').css('display','none');
			$('#chatbox_'+chatboxtitle+' .chatboxinput').css('display','none');
		}
	}

	chatboxFocus[chatboxtitle] = false;

	$("#chatbox_"+chatboxtitle+" .chatboxtextarea").blur(function(){
		chatboxFocus[chatboxtitle] = false;
		$("#chatbox_"+chatboxtitle+" .chatboxtextarea").removeClass('chatboxtextareaselected');
	}).focus(function(){
		chatboxFocus[chatboxtitle] = true;
		newMessages[chatboxtitle] = false;
		$('#chatbox_'+chatboxtitle+' .chatboxhead').removeClass('chatboxblink');
		$("#chatbox_"+chatboxtitle+" .chatboxtextarea").addClass('chatboxtextareaselected');
	});

	$("#chatbox_"+chatboxtitle).click(function() {
		if ($('#chatbox_'+chatboxtitle+' .chatboxlist').css('display') != 'none') {
			$("#chatbox_"+chatboxtitle+" .chatboxtextarea").focus();
		}
	});
	
	$(".chatboxhead").click(function() {
		toggleChatListGrowth(chatboxtitle);
	});
	
	$(".chatboxtitle").click(function() {
		toggleChatListGrowth(chatboxtitle);
	});
	
	$(".chatboxsettings").click(function() {
		toggleChatListOptions();
	});

	
	
	$('#chatbox_'+chatboxtitle+' .chatboxlist').css('display','none');
	$('#chatbox_'+chatboxtitle+' .chatboxinput').css('display','none');
	$("#chatbox_"+chatboxtitle).show();

	var user;
	var online;
			
	$.ajax({
	  url: "/chat/load_chat_list",
	  cache: false,
	  type: 'POST',
      beforeSend: function(xhr){
		xhr.setRequestHeader('X-CSRF-Token',$('meta[name="csrf-token"]').attr('content')); 
	  },
	  data: { 
	  	last:user
	  },
	  dataType: "json",
	  success: function(data) {
 		
 		username = data.username;
 		online   = data.online;
 		status   = data.status;
 		tot_items = data.tot_items;
 		
 		if (status == 0)
		{
			$(".chatboxtitle").html('<img src="/images/bullet_black.png">&nbsp;&nbsp;'+username+' is offline ('+online+')');
		}else if (status == 1){
			$(".chatboxtitle").html('<img src="/images/bullet_green.png">&nbsp;&nbsp;'+username+' is online ('+online+')');
		}else if (status == 2){
			$(".chatboxtitle").html('<img src="/images/bullet_orange.png">&nbsp;&nbsp;'+username+' is away ('+online+')');
		}else if (status == 3){
			$(".chatboxtitle").html('<img src="/images/bullet_star.png">&nbsp;&nbsp;'+username+' is invisible ('+online+')');
		}
		
		var i;
		var xitems = tot_items.split('|');
		var output;
 		var type;
 		
		var single;
		var html;
		$.each(xitems,function(key,line){
			single = line.split(";")
			var x = 0;
			var nick;
			var avi;
			var mob;
			var on;
			html="";
			$.each(single,function(xkey,xline){ 
				if (x == 0){
					nick = xline;
				}else if (x == 1){
					avi = xline;
				}else if (x == 2){
					mob = xline;
				}else if (x == 3){
					on = xline;
				}
				x = x+1;
			});		
			if (nick != ""){
				if (on == "1")
				{
					if (mob != "false"){
						$(".chatboxlist").append('<a href="javascript:void(0)" onclick="javascript:chatWith(\''+nick+'\')"><div class="chatlistitem"><div class="chatavi"><img src="'+avi+'" class="chatpic"></div><div class="chatnick">'+nick+'</div><div class="chatonline"><img src="/images/phone.png" class="bullet">&nbsp;&nbsp;&nbsp;<img src="/images/bullet_green.png"></div></div></a><div class="chat_spacer"></div>');
					}else{
						$(".chatboxlist").append('<a href="javascript:void(0)" onclick="javascript:chatWith(\''+nick+'\')"><div class="chatlistitem"><div class="chatavi"><img src="'+avi+'" class="chatpic"></div><div class="chatnick">'+nick+'</div><div class="chatonline"><img src="/images/bullet_green.png"></div></div></a><div class="chat_spacer"></div>');
					}
			
				}else{
			    	$(".chatboxlist").append('<a href="javascript:void(0)" onclick="javascript:chatWith(\''+nick+'\')"><div class="chatlistitem"><div class="chatavi"><img src="'+avi+'" class="chatpic"></div><div class="chatnick">'+nick+'</div><div class="chatonline"><img src="/images/bullet_black.png"></div></div></a><div class="chat_spacer"></div>');
				
				} 
			}
		});
		
		
		
		for (i=0;i<chatBoxes.length;i++) {
			chatboxtitle = chatBoxes[i];
			$("#chatbox_"+chatboxtitle+" .chatboxlist").scrollTop($("#chatbox_"+chatboxtitle+" .chatboxlist")[0].scrollHeight);
			setTimeout('$("#chatbox_"+chatboxtitle+" .chatboxlist").scrollTop($("#chatbox_"+chatboxtitle+" .chatboxlist")[0].scrollHeight);', 100); // yet another strange ie bug
		}
		
		setTimeout('chatHeartbeat();',chatHeartbeatTime);	
	}});
		
}

function createChatBox(chatboxtitle,minimizeChatBox) {
	if ($("#chatbox_"+chatboxtitle).length > 0) {
		if ($("#chatbox_"+chatboxtitle).css('display') == 'none') {
			$("#chatbox_"+chatboxtitle).css('display','block');
			restructureChatBoxes();
		}
		
		$("#chatbox_"+chatboxtitle+" .chatboxtextarea").focus();
		return;
	}

	$(" <div />" ).attr("id","chatbox_"+chatboxtitle)
	.addClass("chatbox")
	.html('<a href="javascript:void(0)" onclick="javascript:toggleChatBoxGrowth(\''+chatboxtitle+'\')"><div class="chatboxhead"><div class="chatboxtitle">'+chatboxtitle+'</div><div class="chatboxoptions"><a href="javascript:void(0)" onclick="javascript:toggleChatBoxGrowth(\''+chatboxtitle+'\')">-</a> <a href="javascript:void(0)" onclick="javascript:closeChatBox(\''+chatboxtitle+'\')">X</a></div><br clear="all"/></div><div class="chatboxcontent"></div><div class="chatboxinput"><textarea class="chatboxtextarea" onkeydown="javascript:return checkChatBoxInputKey(event,this,\''+chatboxtitle+'\');"></textarea></div></a>')
	.appendTo($( "body" ));
			   
	$("#chatbox_"+chatboxtitle).css('bottom', '0px');
	
	chatBoxeslength = 0;

	for (x in chatBoxes) {
		if ($("#chatbox_"+chatBoxes[x]).css('display') != 'none') {
			chatBoxeslength++;
		}
	}

	if (chatBoxeslength == 0) {
		$("#chatbox_"+chatboxtitle).css('right', '20px');
	} else {
		width = (chatBoxeslength)*(225+7)+20;
		$("#chatbox_"+chatboxtitle).css('right', width+'px');
	}
	
	chatBoxes.push(chatboxtitle);

	if (minimizeChatBox == 1) {
		minimizedChatBoxes = new Array();

		if ($.cookie('chatbox_minimized')) {
			minimizedChatBoxes = $.cookie('chatbox_minimized').split(/\|/);
		}
		minimize = 0;
		for (j=0;j<minimizedChatBoxes.length;j++) {
			if (minimizedChatBoxes[j] == chatboxtitle) {
				minimize = 1;
			}
		}

		if (minimize == 1) {
			$('#chatbox_'+chatboxtitle+' .chatboxcontent').css('display','none');
			$('#chatbox_'+chatboxtitle+' .chatboxinput').css('display','none');
		}
	}

	chatboxFocus[chatboxtitle] = false;

	$("#chatbox_"+chatboxtitle+" .chatboxtextarea").blur(function(){
		chatboxFocus[chatboxtitle] = false;
		$("#chatbox_"+chatboxtitle+" .chatboxtextarea").removeClass('chatboxtextareaselected');
	}).focus(function(){
		chatboxFocus[chatboxtitle] = true;
		newMessages[chatboxtitle] = false;
		$('#chatbox_'+chatboxtitle+' .chatboxhead').removeClass('chatboxblink');
		$("#chatbox_"+chatboxtitle+" .chatboxtextarea").addClass('chatboxtextareaselected');
	});

	$("#chatbox_"+chatboxtitle).click(function() {
		if ($('#chatbox_'+chatboxtitle+' .chatboxcontent').css('display') != 'none') {
			$("#chatbox_"+chatboxtitle+" .chatboxtextarea").focus();
		}
	});

	$("#chatbox_"+chatboxtitle).show();
}

function chatHeartbeat(){

	var itemsfound = 0;
	
	if (windowFocus == false) {
 
		var blinkNumber = 0;
		var titleChanged = 0;
		for (x in newMessagesWin) {
			if (newMessagesWin[x] == true) {
				++blinkNumber;
				if (blinkNumber >= blinkOrder) {
					document.title = x+' says...';
					titleChanged = 1;
					break;	
				}
			}
		}
		
		if (titleChanged == 0) {
			document.title = originalTitle;
			blinkOrder = 0;
		} else {
			++blinkOrder;
		}

	} else {
		for (x in newMessagesWin) {
			newMessagesWin[x] = false;
		}
	}

	for (x in newMessages) {
		if (newMessages[x] == true) {
			if (chatboxFocus[x] == false) {
				//FIXME: add toggle all or none policy, otherwise it looks funny
				$('#chatbox_'+x+' .chatboxhead').toggleClass('chatboxblink');
			}
		}
	}
	
	$.ajax({
	  url: "/chat/chat_heartbeat",
	  cache: false,
	  dataType: "json",
	  success: function(data) {

		$.each(data.items, function(i,item)
		{
			if (item)	{ // fix strange ie bug

				chatboxtitle = item.f;

				if ($("#chatbox_"+chatboxtitle).length <= 0) {
					createChatBox(chatboxtitle);
				}
				if ($("#chatbox_"+chatboxtitle).css('display') == 'none') {
					$("#chatbox_"+chatboxtitle).css('display','block');
					restructureChatBoxes();
				}
				
				if (item.s == 1) {
					item.f = username;
				}

				if (item.s == 2) {
					$("#chatbox_"+chatboxtitle+" .chatboxcontent").append('<div class="chatboxmessage"><span class="chatboxinfo">'+item.m+'</span></div>');
				} else {
					newMessages[chatboxtitle] = true;
					newMessagesWin[chatboxtitle] = true;
					$("#chatbox_"+chatboxtitle+" .chatboxcontent").append('<div class="chatboxmessage"><span class="chatboxmessagefrom">'+item.f+':&nbsp;&nbsp;</span><span class="chatboxmessagecontent">'+item.m+'</span></div>');
				}

				$("#chatbox_"+chatboxtitle+" .chatboxcontent").scrollTop($("#chatbox_"+chatboxtitle+" .chatboxcontent")[0].scrollHeight);
				itemsfound += 1;
			}
		});

		chatHeartbeatCount++;

		if (itemsfound > 0) {
			chatHeartbeatTime = minChatHeartbeat;
			chatHeartbeatCount = 1;
		} else if (chatHeartbeatCount >= 10) {
			chatHeartbeatTime *= 2;
			chatHeartbeatCount = 1;
			if (chatHeartbeatTime > maxChatHeartbeat) {
				chatHeartbeatTime = maxChatHeartbeat;
			}
		}
		
		setTimeout('chatHeartbeat();',chatHeartbeatTime);
	}});
}

function closeChatBox(chatboxtitle) {
	$('#chatbox_'+chatboxtitle).css('display','none');
	restructureChatBoxes();

	$.post("/chat/close_chat", { chatbox: chatboxtitle} , function(data){	
	});

}

function toggleChatBoxGrowth(chatboxtitle) {
	if ($('#chatbox_'+chatboxtitle+' .chatboxcontent').css('display') == 'none') {  
		$('#chatbox_'+chatboxtitle+' .chatboxcontent').css('display','block');
		$('#chatbox_'+chatboxtitle+' .chatboxinput').css('display','block');
		$("#chatbox_"+chatboxtitle+" .chatboxcontent").scrollTop($("#chatbox_"+chatboxtitle+" .chatboxcontent")[0].scrollHeight);
	} else {
		$('#chatbox_'+chatboxtitle+' .chatboxcontent').css('display','none');
		$('#chatbox_'+chatboxtitle+' .chatboxinput').css('display','none');
	}
}

function minimizeChatList(){
	$('.chatboxlist').css('display','none');
}

function maximizeChatList(){
	$('.chatboxlist').css('display','block');
}

function toggleChatListGrowth(chatboxtitle) {
	if ($('#chatbox_'+chatboxtitle+' .chatboxlist').css('display') == 'none') {  
		$('#chatbox_'+chatboxtitle+' .chatboxlist').css('display','block');
		$("#chatbox_"+chatboxtitle+" .chatboxlist").scrollTop($("#chatbox_"+chatboxtitle+" .chatboxlist")[0].scrollHeight);
	} else {
		$('#chatbox_'+chatboxtitle+' .chatboxlist').css('display','none');
	}
}

function checkChatBoxInputKey(event,chatboxtextarea,chatboxtitle) {
	 
	if(event.keyCode == 13 && event.shiftKey == 0)  {
		message = $(chatboxtextarea).val();
		message = message.replace(/^\s+|\s+$/g,"");

		$(chatboxtextarea).val('');
		$(chatboxtextarea).focus();
		$(chatboxtextarea).css('height','40px');
		
		$.ajaxSetup({
			 beforeSend: function(xhr){
				xhr.setRequestHeader('X-CSRF-Token',$('meta[name="csrf-token"]').attr('content')); 
			  }
		});
		
		if (message != '') {
			$.post("/chat/send_chat", {to: chatboxtitle, message: message} , function(data){
				message = message.replace(/</g,"&lt;").replace(/>/g,"&gt;").replace(/\"/g,"&quot;");
				$("#chatbox_"+chatboxtitle+" .chatboxcontent").append('<div class="chatboxmessage"><span class="chatboxmessagefrom">'+username+':&nbsp;&nbsp;</span><span class="chatboxmessagecontent">'+message+'</span></div>');
				$("#chatbox_"+chatboxtitle+" .chatboxcontent").scrollTop($("#chatbox_"+chatboxtitle+" .chatboxcontent")[0].scrollHeight);
			});
		}
		chatHeartbeatTime = minChatHeartbeat;
		chatHeartbeatCount = 1;

		return false;
	}

	var adjustedHeight = chatboxtextarea.clientHeight;
	var maxHeight = 94;

	if (maxHeight > adjustedHeight) {
		adjustedHeight = Math.max(chatboxtextarea.scrollHeight, adjustedHeight);
		if (maxHeight)
			adjustedHeight = Math.min(maxHeight, adjustedHeight);
		if (adjustedHeight > chatboxtextarea.clientHeight)
			$(chatboxtextarea).css('height',adjustedHeight+8 +'px');
	} else {
		$(chatboxtextarea).css('overflow','auto');
	}
	 
}

function startChatSession(){  
	
	$.ajax({
	  url: "/chat/start_chat_session",
	  beforeSend: function(xhr){
		xhr.setRequestHeader('X-CSRF-Token',$('meta[name="csrf-token"]').attr('content')); 
	  },
	  cache: false,
	  dataType: "json",
	  success: function(data) {
 		username = data.username;
 		online   = data.online
 		status = data.status
		
		$.each(data.items, function(i,item){
			if (item)	{ // fix strange ie bug

				chatboxtitle = item.f;

				if ($("#chatbox_"+chatboxtitle).length <= 0) {
					createChatList(chatboxtitle,1);
				}
				
				if (item.s == 1) {
					item.f = username;
				}

				if (item.s == 2) {
					$("#chatbox_"+chatboxtitle+" .chatboxcontent").append('<div class="chatboxmessage"><span class="chatboxinfo">'+item.m+'</span></div>');
				} else {
					$("#chatbox_"+chatboxtitle+" .chatboxcontent").append('<div class="chatboxmessage"><span class="chatboxmessagefrom">'+item.f+':&nbsp;&nbsp;</span><span class="chatboxmessagecontent">'+item.m+'</span></div>');
				}

				var newCookie = chatboxtitle;
				if ($.cookie('chatbox_minimized')) {
					newCookie += '|'+$.cookie('chatbox_minimized');
				}
				$.cookie('chatbox_minimized',newCookie);
				$('#chatbox_'+chatboxtitle+' .chatboxcontent').css('display','none');
				$('#chatbox_'+chatboxtitle+' .chatboxinput').css('display','none');
				
				if (online != null)
				{  
					$('.chatboxtitle').html('Chat('+online+')');
				} else {
					if (status == 'online')
					{
						$('.chatboxtitle').html('<img src="/images/bullet_green.png">&nbsp;&nbsp;Chat (0)');
						
					}else{
						$('.chatboxtitle').html('<img src="/images/bullet_black.png">&nbsp;&nbsp;Chat (0)');
						
					}
				}
			}
		});
		
		for (i=0;i<chatBoxes.length;i++) {
			chatboxtitle = chatBoxes[i];
			$("#chatbox_"+chatboxtitle+" .chatboxcontent").scrollTop($("#chatbox_"+chatboxtitle+" .chatboxcontent")[0].scrollHeight);
			setTimeout('$("#chatbox_"+chatboxtitle+" .chatboxcontent").scrollTop($("#chatbox_"+chatboxtitle+" .chatboxcontent")[0].scrollHeight);', 100); // yet another strange ie bug
		}
	
	setTimeout('chatHeartbeat();',chatHeartbeatTime);
		
	}});
}

jQuery.cookie = function(name, value, options) {
    if (typeof value != 'undefined') { // name and value given, set cookie
        options = options || {};
        if (value === null) {
            value = '';
            options.expires = -1;
        }
        var expires = '';
        if (options.expires && (typeof options.expires == 'number' || options.expires.toUTCString)) {
            var date;
            if (typeof options.expires == 'number') {
                date = new Date();
                date.setTime(date.getTime() + (options.expires * 24 * 60 * 60 * 1000));
            } else {
                date = options.expires;
            }
            expires = '; expires=' + date.toUTCString(); // use expires attribute, max-age is not supported by IE
        }
        var path = options.path ? '; path=' + (options.path) : '';
        var domain = options.domain ? '; domain=' + (options.domain) : '';
        var secure = options.secure ? '; secure' : '';
        document.cookie = [name, '=', encodeURIComponent(value), expires, path, domain, secure].join('');
    } else { // only name given, get cookie
        var cookieValue = null;
        if (document.cookie && document.cookie != '') {
            var cookies = document.cookie.split(';');
            for (var i = 0; i < cookies.length; i++) {
                var cookie = jQuery.trim(cookies[i]);
     
                if (cookie.substring(0, name.length + 1) == (name + '=')) {
                    cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                    break;
                }
            }
        }
        return cookieValue;
    }
};