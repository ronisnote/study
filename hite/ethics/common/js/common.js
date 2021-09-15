jQuery(function($){

	$(window).load(function (){
		mnSC();
	});

	$(window).ready(function (){
	});

	$(window).resize(function (){
		
	});

	$("#wrap #lnb ul li").hover(
		function(){
			//alert('입장');
			$("#wrap #lnb > ul > li").removeClass("hover");
			$("#wrap #lnb > ul > li > ul > li").removeClass("hover");
			
		},
		function(){
			mnSC();
		}
	);

	function mnSC(){
		if(mnL1 != null){
			$("#wrap #lnb > ul > li:eq("+mnL1+")").addClass("hover");
		}
		
		if(mnL1 != null || mnL2 != null){
			$("#wrap #lnb > ul > li:eq("+mnL1+") > ul > li:eq("+mnL2+") a").addClass("hover");
		}

	}

	$(".global_menu .contactus").click(function(){
		layerOpen('#contactus');
		return false;
	});

	$(".global_menu .sitemap").click(function(){
		layerOpen('#sitemap');
		return false;
	});

	function layerOpen(act){
		// 화면의 중앙에 레이어를 띄운다. 
		temp = "#pop_layer "+ act
		if ($(temp).outerHeight() < $(document).height() ){
			$(temp).css('margin-top', '-'+$(temp).outerHeight()/2+'px'); 
		}else{
			$(temp).css('top', '0px');
		}

		if($(temp).outerWidth() < $(document).width() ){ 
			$(temp).css('margin-left', '-'+$(temp).outerWidth()/2+'px');
		}else{ 
			$(temp).css('left', '0px');
		}

		$("#pop_layer").show(function(){
			$("#pop_layer em").fadeIn();
			$(temp).fadeIn();
		});
		
	}

	$("#pop_layer em, #pop_layer .popup .close").click(function(){
			$("#pop_layer .popup").fadeOut(function(){
				$("#pop_layer em").fadeOut();	
				$("#pop_layer").fadeOut();	
			});
			return false;
	});

	$(".ifr_contactus .close").click(function(){
		$("#pop_layer .popup", parent.document).fadeOut(function(){
			$("#pop_layer em", parent.document).fadeOut();	
			$("#pop_layer", parent.document).fadeOut();	
		});
		return false;
	});

	$("#family img").click(function(){
		$("#family_on").slideToggle("fast");
	}); 


});