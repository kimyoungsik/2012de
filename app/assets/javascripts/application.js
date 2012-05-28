// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require jquery.tokeninput
//= require jquery.purr
//= require jquery.elastic.source
//= require best_in_place
//= require rails.validations
//= require_tree .


$(document).ready(function() {
	// notification
	$(".notification-item").hover(function(){
		$(this).children(".item-content").children("h3").children("a").addClass("hover-headline");
	},function(){
		$(this).children(".item-content").children("h3").children("a").removeClass("hover-headline");
	});
	$("#notification .notification-selector").remove();
	$("#notification").hide();
	$("#notification-count").click(function(){
		$("#notification").toggle();
		$("#notification-count > p").html("0");
		$.ajax({
			type: "GET",
			url:    "/notifications_reset_count", // should be mapped in routes.rb
			datatype:"js", // check more option
			async:   true
		});
	});

	$("#notification-count p:contains('0')").css({
			"background": "#666",
			"color": "#aaa"
	});

	// dropdown menu
	$("#dropdown-button").parent().click(function(){
		$("#top-user-item").toggle();
	});

	// error-image restore	  	
	$("img").error(function(){	  	
		$(this).attr("src", "/assets/default_profile.png");
	});
	
	// message
	var height = $(window).height()-60;
	$('#message-sidebar').css("height", height);
	$('#message-main').css("max-height", height);

	// search
	$("#search").click(function(){
		$(this).css({"width" : "200px", 
		"background" : "#fff"});
		$(this).siblings("i").css("background-position", "-21px -26px");		
	});

	// watermark
	$("#kit-field textarea").watermark('새로운 Kit을 입력해주십시오.');
	$(".comment-field textarea").watermark('댓글을 달아주세요.');
	$("#message-textarea").watermark("메시지를 입력해주십시오.");
	$("input#seed-title-fake").watermark("당신의 꿈은 무엇입니까?");
	$("#seed_title").watermark("당신의 꿈을 한마디로 표현하자면?");	
	$("#seed_description").watermark("꿈과 관련된 내용을 입력해주세요.");
	$("input#user_email").watermark("이메일");
	$("input#user_password").watermark("비밀번호");
	$("#search").watermark("Search");
	$("#network-search").watermark("네트워크를 찾아보세요.");
	$("#network_participation_network_name").watermark("학교 / 네트워크 찾아보기");

	$("#tabs-2 input#user_email").watermark("발송할 이메일을 입력해주십시오.");
	$("#tabs-3 input#user_name").watermark("이름(한글실명)");	
	$("#tabs-3 input#user_email").watermark("이메일");
	$("#tabs-3 input#user_password_confirmation").watermark("비밀번호 확인");

	$("#message_title").watermark("간략한 제목을 입력해주세요.");
	$("#message-form-text").watermark("전달할 메시지를 입력해주세요.");
	$("#token-input-message_user_tokens").watermark("누구에게 보내시겠습니까?");

	$(".user-edit input#user_email").watermark("이메일");
	$(".user-edit input#user_password").watermark("변경할 비밀번호");
	$(".user-edit input#user_password_confirmation").watermark("변경할 비밀번호 확인");
	$(".user-edit input#user_current_password").watermark("입력하셔야 변경이 가능합니다.");
	// dreamkit login
	$("#dreamkit-login-text").click(function(){
		$("#signup-box").css("height", "580px");
		$("#dreamkit-login-box").show();
		$(".popup-text").hide();
	});


	$("#signup-box, #tutorial-box").each(function(){
		$(this).css("top", ($(window).height()-$(this).outerHeight())/ 2 + "px");
		$(this).css('left',($(window).width()-$(this).outerWidth())/ 2 + "px");
	});
	

	// tutorial slide : condition
	if($("#tutorial-part1").length == 0){
		$("#tutorial-part2").css("left", "0px");
	}
	if($("#tutorial-part1, #tutorial-part2").length == 0){
		$("#tutorial-part3").css("left", "0px");
	}
	if($("#tutorial-part1, #tutorial-part2, #tutorial-part3").length == 0){
		$("#tutorial-part4").css("left", "0px");
	}

	// tutorial button : condition
	// tutorial button 1
	$("#tutorial-button1").click(function(){
		if($("#tutorial-part2, #tutorial-part3, #tutorial-part4").length == 0){
			$(".popup-wrapper").fadeOut(500);
		}
		if($("#tutorial-part2, #tutorial-part3").length == 0){
			$("#tutorial-part1").animate({left: "-400px"});
			$("#tutorial-part4").animate({left: "0px"});
		}
		if($("#tutorial-part2").length == 0){
			$("#tutorial-part1").animate({left: "-400px"});
			$("#tutorial-part3").animate({left: "0px"});
		}
		else{
			$("#tutorial-part1").animate({left: "-400px"});
			$("#tutorial-part2").animate({left: "0px"});	
		}
	});

	// tutorial button 2
	$("#tutorial-button2").click(function(){
		if($("#tutorial-part3, #tutorial-part4").length == 0){
			$(".popup-wrapper").fadeOut(500);
		}
		if($("#tutorial-part3").length == 0){
			$("#tutorial-part2").animate({left: "-400px"});
			$("#tutorial-part4").animate({left: "0px"});
		}
		else{
			$("#tutorial-part2").animate({left: "-400px"});
			$("#tutorial-part3").animate({left: "0px"});	
		}
	});
	// $("#tutorial-back-button2").click(function(){
	// 	$("#tutorial-part1").animate({left: "0px"});
	// 	$("#tutorial-part2").animate({left: "400px"});
	// });

	// tutorial button 3	
	$("#tutorial-button3").click(function(){
		if($("#tutorial-part4").length == 0){
			$(".popup-wrapper").fadeOut(500);
		}
		else{
			$("#tutorial-part3").animate({left: "-400px"});
			$("#tutorial-part4").animate({left: "0px"});
		}
	});
	// $("#tutorial-back-button2").click(function(){
	// 	$("#tutorial-part2").animate({left: "0px"});
	// 	$("#tutorial-part3").animate({left: "400px"});
	// });	
	
	// tutorial button 4
	$("#tutorial-button4").click(function(){
		$(".popup-wrapper").fadeOut(500);
	});	
	$("#tutorial-back-button4").click(function(){
		$("#tutorial-part3").animate({left: "0px"});
		$("#tutorial-part4").animate({left: "400px"});
	});
	
	// tutorial reaction
	$("#tutorial-button1, #tutorial-button2").css("right", "-46px");
	$("#tutorial-part1 .best_in_place").click(function(){
		$("#tutorial-button1").css("right", "0");
	});
	$("#tutorial-part2 #network-button").click(function(){
		$("#tutorial-button2").css("right", "0");
	});	
	// $("#tutorial-part3 #interests .best_in_place").click(function(){
	// 	$("#tutorial-button3").css("right", "0");
	// });


	// dreamkit login tab
	$( "#dreamkit-login-box" ).tabs();

	// dreamkit signup
	$("#dreamkit-login-box ul li:last a").click(function(){
		$("#signup-box").css("height", "610px");
	});

	// reply form(message)
	// $("#reply-button-box").hide();
	// $(".reply-field > .item-left > img").hide();

	$("#new_reply").click(function(){
		// $("#reply-button-box").show();
		// $(".reply-field > .item-left > img").show();
		$("#message-textarea").css("background", "#fff");
	});

	// comment form
	$(".comment-button-box").hide();
	$(".comment-field > .item-left > img").hide();

	$(".new_comment").click(function(event){
		$(this).children(".comment-button-box").show();
		$(this).children(".comment-textarea").css("background", "#fff");
		$(this).parent().prev().children().show();
	});
	$("a.comment-cancel").click(function(){
		$(this).parent().hide();
		$(this).parent().parent().parent(".item-content").siblings().children("img").hide();
		$(this).parent().siblings(".comment-textarea").css("background", "#fafafa");
		return false;
	});

	// kit form
	$("#kit-field").children().children("img").hide();
	$("#new_kit").click(function(event){
		$(this).children().children(".kit-submit").show();
		$(this).parent().prev().children().show();
		// $("#kit-field > .item-content").css("margin-left", "70px");
	});

	// seed form
	$("#seed-title-fake").click(function(){
		$("#seed-title-fake, #seed-box-wedge").hide();
		$("#seed_title, #seed_description, #seed-button-box").show();
		$("#seed_title").watermark("당신의 꿈을 한마디로 표현하자면?");
		$(this).parent(".input-box").attr("id", "input-box-switch");
	});

	$("#seed-cancel").click(function(){
		$("#seed-title-fake, #seed-box-wedge").show();
		$("#seed_title, #seed_description, #seed-button-box").hide();
		$("#seed_title").watermark("당신의 꿈은 무엇입니까?");	
		$(this).parent("#seed-button-box").siblings(".input-box").removeAttr('id');
	});	

	// sidebar-network form
	$("#network-button-box").hide();
	$("#new_network_participation").click(function(){
		$("#network-button-box").show();
	});

	// sidebar:hover
	$(".item-box, a.item-link").mouseover(function(event){
		$(this).children(".sidebar-selector, .selector, .notification-selector").css("background-position", "0 -20px");

	});
	$(".item-box, a.item-link").mouseout(function(event){
		$(this).children(".sidebar-selector, .selector, .notification-selector").css("background-position", "0 0");
	});

	// seeds:hover
	$("#seeds > .item-box").mouseover(function(event){
		$(this).children(".item-content").children("h2").children().addClass("hover-headline");
	});
	$("#seeds > .item-box").mouseout(function(event){	
		$(this).children(".item-content").children("h2").children().removeClass("hover-headline");
	});

	// seed-show:hover
	// $(".seed-show").mouseenter(function(){
	// 	$(this).siblings("#seed-show-control").children("#seed-show-delete").show();
	// });
	// $(".seed-show").mouseleave(function(){
	// 	$(this).siblings("#seed-show-control").children("#seed-show-delete").hide();
	// });	


	// append selector
	$("<i></i>").appendTo($("a.item-link"));
	$("a.item-link i").addClass("sidebar-selector");

	// comment enter key 
  $("textarea.comment-textarea").bind("keypress", function(e){
		var code = e.keyCode ? e.keyCode : e.which;
		if(code == 13){
			$(this).blur();
			$(this).siblings().children(".comment-submit").focus().click();
			e.preventDefault();
		}
  });

	// seed-show more-info
	$(".box-control").each(function(){
		var $maxHeight = 120;
		if ($(this).height() >= $maxHeight){
			$(this).parent().append("<div></div>");
			$(this).siblings().addClass("more-info").append("…<br />본문 더 보기");

			$(".more-info").click(function(){
				$(".box-control").css("max-height", "none");
				$(".more-info").hide();
			});
		}
	});

	// seed-show status
	$("div.status-control").not(".li-freeze").mouseenter(function(){
		$(this).addClass("li-active");
		$(this).children(".seed-digit").css("color", "#777");
		$(this).children().children().children("input:last").addClass("button-hover");
	});
	$("div.status-control").not(".li-freeze").mouseleave(function(){
		$(this).removeClass("li-active");
		$(this).children(".seed-digit").css("color", "#ccc");
		$(this).children().children().children("input:last").removeClass("button-hover");		
	});

	// seed-show lead-to-kit
	$(".seed-participation-button").click(function(){
		$("#kit_content").watermark("이 시드를 달성할 수 있는 당신만의 아이디어가 있다면?");
		$("#kit_content").addClass("textarea-focus");
		$(".kit-submit").fadeIn(1000);
		$("#kit-field").children().children("img").fadeIn(1000);
	});

	$(".seed-support-button").click(function(){
		$("#kit_content").watermark("시드 참여자에게 응원의 한마디를 남겨보세요.");
		$("#kit_content").addClass("textarea-focus");
		$(".kit-submit").fadeIn(1000);
		$("#kit-field").children().children("img").fadeIn(1000);
	});

	$(".seed-complete-button").click(function(){
		$("#kit_content").watermark("이제 당신은 이 시드의 멘토입니다! 참여자에게 성공비결을 전수해 주세요.");
		$("#kit_content").addClass("textarea-focus");
		$(".kit-submit").fadeIn(1000);
		$("#kit-field").children().children("img").fadeIn(1000);
	});

	// friend cancel
	$(".friend-pending").hover(function(){
		$(this).html("신청취소");
	}, function(){
		$(this).html("수락대기");
	}).click(function(){
		$(".cancel-friend-request").click();
	});

	$(".friend").hover(function(){
		$(this).html("친구취소");
	}, function(){
		$(this).html("내 친구");
	}).click(function(){
		$(".cancel-friend").click();
	});

	// best in place
	$(".best_in_place").hover(function(){
		// $(this).css("background", "red");
	}, function(){
		// $(this).fadeIn(500);
	});
	
	$("#tutorial_next").click(function(){
		$("#tutorial-box").remove();
	})
	
	// facebook invitation
	$("#dreamers-facebook").hide();
	$("#facebook-invite a").hide();
	$("#dreamers").mouseover(function(){
		$("#facebook-invite a").click();
		$("#dreamers, #facebook-invite a").unbind();
		$("#dreamers-facebook").fadeIn();
		$("#facebook-invite a").remove();
	});
	
	// image upload
	$("input#photo-submit").hide();
	$("input#photo_image").change(function(){
		var value = $(this).val();
		value = value.substring($(this).val().lastIndexOf("\\")+1);
		if (value)
		{
			$("span#photo-text").text(value + "파일을 업로드하고 있습니다.");
			$("input#photo-submit").click();
		}
	});
	$("#photo_image").hover(function(){
		$("#photo-selector").css("background", "#444");
	}, function(){
		$("#photo-selector").css("background", "#039FD3");
	});
	
	// image upload:kit
	$("input#kit_photos_attributes__image").change(function(){
		var value = $(this).val();
		if (value)
		{
			$("#photo-text").text(" 파일이 업로드되었습니다.");
			$("#kit-field textarea").watermark('내용을 입력하셔야 킷을 올릴 수 있습니다.');
		}
	});
	
	$("#kit_photos_attributes__image").hover(function(){
		$("#photo-selector").css({
			"background-position" : "-43px -20px",
			"color" : "#aaa"
		});
	}, function(){
		$("#photo-selector").css({
			"background-position" : "-43px -0px",
			"color" : "#ccc"
		});
	});
	
	// ie6 alert
	$(".ie6 body").mouseover(function(){
		alert("익스플로러6 이하의 버전은 지원하지 않습니다. 익스플로러7 이상으로 업그레이드하거나 다른 브라우저를 설치해주십시오.");
	});
});


$(document).ready(function() {
	$('#message_user_tokens').tokenInput('/users.json', { 
		crossDomain: false,
		prePopulate: $('#message_user_tokens').data('pre'),  
		theme: 'facebook',
		preventDuplicates: true
	});	
});



// JQuery Popup, 20110330, Hasang Cheon
$(document).ready(function() {
	//When you click on a link with class of poplight and the href starts with a #
	$('a.poplight[href^=#]').live("click", function() {

		var popID = $(this).attr('rel'); //Get Popup Name
		var popURL = $(this).attr('href'); //Get Popup href to define size

		//Pull Query & Variables from href URL
		var query= popURL.split('?');
		var dim= query[1].split('&');
		var popWidth = dim[0].split('=')[1]; //Gets the first query string value

		//Fade in the Popup and add close button
		$('#' + popID).fadeIn().css({ 'width': Number( popWidth ) }).prepend('<a href="#" class="close"><img src="/assets/popup_selector.png" title="Close Window" alt="Close" /></a>');

		//Define margin for center alignment (vertical   horizontal) - we add 80px to the height/width to accomodate for the padding  and border width defined in the css
		var popMargTop = ($('#' + popID).height() + 80) / 2;
		var popMargLeft = ($('#' + popID).width() + 80) / 2;
		
		//Apply Margin to Popup
		$('#' + popID).css({
			'margin-top' : -popMargTop,
			'margin-left' : -popMargLeft
		});
		
		$(".popup-prev, .popup-next").each(function(){
			$(this).css("top", ($('#' + popID).height()-$(this).height())/ 2 + "px");
		});
		

		//Fade in Background
		$('body').append('<div id="fade"></div>'); //Add the fade layer to bottom of the body tag.
		$('#fade').css({'filter' : 'alpha(opacity=80)'}).fadeIn(); //Fade in the fade layer - .css({'filter' : 'alpha(opacity=80)'}) is used to fix the IE Bug on fading transparencies 

		return false;
	});
	
	$('a.poplight_next[href^=#]').live("click", function() {

		$('.popup_block').hide();		

		var popID = $(this).attr('rel'); //Get Popup Name
		var popURL = $(this).attr('href'); //Get Popup href to define size

		//Pull Query & Variables from href URL
		var query= popURL.split('?');
		var dim= query[1].split('&');
		var popWidth = dim[0].split('=')[1]; //Gets the first query string value

		//Fade in the Popup and add close button
		$('#' + popID).fadeIn().css({ 'width': Number( popWidth ) }).prepend('<a href="#" class="close"><img src="/assets/popup_selector.png" class="btn_close" title="Close Window" alt="Close" /></a>');

		//Define margin for center alignment (vertical   horizontal) - we add 80px to the height/width to accomodate for the padding  and border width defined in the css
		var popMargTop = ($('#' + popID).height() + 80) / 2;
		var popMargLeft = ($('#' + popID).width() + 80) / 2;

		//Apply Margin to Popup
		$('#' + popID).css({
			'margin-top' : -popMargTop,
			'margin-left' : -popMargLeft
		});
		
		$(".popup-prev, .popup-next").each(function(){
			$(this).css("top", ($('#' + popID).height()-$(this).height())/ 2 + "px");
		});

		return false;
	});
	

	//Close Popups and Fade Layer
	$('a.close, #fade').live('click', function() { //When clicking on the close or fade layer...
		$('#fade , .popup_block').fadeOut(function() {
			$('#fade, a.close').remove();  //fade them both out
		});
		return false;
	});
	$(".popup_block").hover(function(){
		$(".popup-prev, .popup-next").fadeIn();
	}, function(){
		$(".popup-prev, .popup-next").fadeOut();		
	});
});

// Kit Ajax if no photo is attached
$(document).ready(function() {
	$("form#new_kit").submit(function() {
		if ($("input#kit_photos_attributes__image").val() == "")
		{
			var i = $(this).find("input[type=submit]");
			if ($("textarea#kit-form-text").val() == "")
				return false;
			var t =  i.attr("data-disable-with");
			if (t != null && t != "")
				i.val(t);
			i.attr("disabled", "disabled");
			$.post(this.action, $(this).serialize(), null, "script")
			.complete(function(){
				i.removeAttr("disabled");
				i.val("Kit");
			})
			.error(function(){
				i.val("Kit");
			});
			return false;
		}
		return true;
	});
});

jQuery(function($) {
  $("#new_user").bind("ajax:error", function(event, data, status, xhr) {
    $("#signin-failure").html("이메일과 비밀번호를 확인해주세요.");
  });
});