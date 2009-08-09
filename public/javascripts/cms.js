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
	
	$("input[@type=text], textarea").addClass("idleField");
	
	if($("#release_release_date").length)
	{
		$("#release_release_date").datepicker();
	}
	
	// Adds alternate row colors to tables in articles
	if($(".cms_table").length)
	{
		$("table.cms_table > tbody > tr:odd").addClass("odd");
	}
	// Pulquotes
	$('span.pq').each(function() {
		var quote = $(this).clone();
		quote.removeClass('pq');
		quote.addClass('pullquote');
		$(this).before(quote);
	});
	
	$("input[@type=text], textarea").focus(function() {
		$(this).removeClass("idleField").addClass("focusField");		
	});
	
	$("input[@type=text], textarea").blur(function() {
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
});