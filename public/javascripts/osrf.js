/**
 * 
 * @depends jquery126.js
 * @depends ../theme/jquery.ui.all.js
 * @depends superfish.js
 * @depends jstarget.js
 * @depends osrf_validate.js
 * 
 */

/**
 * @author david walsh
 * http://davidwalsh.name/jquery-top-link
 */
jQuery.fn.topLink = function(settings) {
	settings = jQuery.extend({
		min: 1,
		fadeSpeed: 200
	}, settings);
	return this.each(function() {
		//listen for scroll
		var el = $(this);
		el.hide(); //in case the user forgot
		$(window).scroll(function() {
			if($(window).scrollTop() >= settings.min)
			{
				el.fadeIn(settings.fadeSpeed);
			}
			else
			{
				el.fadeOut(settings.fadeSpeed);
			}
		});
	});
};
/**
 * @author volume4
 */
$(document).ready(function() {
	
	$('a').jqlang();
	$('.user_list').hide();
	$('#osrf_feedburner').hide();
	$('#tools').hide();
	
	$("input[@type=text], textarea, input[@type=password]").addClass("idleField");
	$('ul#nav').superfish();
	
	if($("#release_release_date").length)
	{
		$("#release_release_date").datepicker();
	}
	if($("#event_event_date").length)
	{
		$("#event_event_date").datepicker();
	}
	
	if ($('a[@rel*=lightbox]').length)
	{
		$('a[@rel*=lightbox]').lightBox();
	}
	
	// Adds alternate row colors to tables in articles
	if($(".article_table").length)
	{
		$("table.article_table > tbody > tr:odd").addClass("odd");
	}
	// Pulquotes
	$('span.pq').each(function() {
		var quote = $(this).clone();
		quote.removeClass('pq');
		quote.addClass('pullquote');
		$(this).before(quote);
	});
	
	$("#osrf_tools h2").toggle(
		function() {
			$("#tools").show();
		},
		function() {
			$("#tools").hide();
	});
	
	$("#custom_feeds_page h3").toggle(
		function() {
			$("#osrf_feedburner").show();
		},
		function() {
			$("#osrf_feedburner").hide();
	});
	
	$("input[@type=text], textarea, input[@type=password]").focus(function() {
		$(this).removeClass("idleField").addClass("focusField");		
	});
	
	$("input[@type=text], textarea, input[@type=password]").blur(function() {
		$(this).removeClass("focusField").addClass("idleField");		
	});
	
	//Top Link By David Walsh - http://davidwalsh.name/jquery-top-link
	$('#top-link').topLink({
		min: 400,
		fadeSpeed: 500
	});
	//smoothscroll
	$('#top-link').click(function(e) {
		e.preventDefault();
		$.scrollTo(0,300);
	});
	
	/* grabbing and embedding webpage thumbnails */
	var container = document.getElementById('website_thumbnail'), 
    thumbs = Thumbnails({ devkey:'705109731d646d71d5bb171a6da9fd0b' });
	
	var weburl = $('#download_link > a').attr('href');
	
	thumbs.get(weburl, append);
	
	function append ( url, img ) { 
	    var link = document.createElement('a'); 
	    link.href = url; 
	    link.appendChild(img); 
	    container.appendChild(link); 
	}
});