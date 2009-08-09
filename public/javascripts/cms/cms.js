/**
 * @author volume4
 */
$(document).ready(function() {
	
	$("input[@type=text], textarea").addClass("idleField");
	$("#accordion").accordion(
	{
		header: 'h2', 
		autoHeight: false,
		collapsible: true
	});
	
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
});