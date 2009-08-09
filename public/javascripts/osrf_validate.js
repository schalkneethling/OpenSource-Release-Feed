/**
 * @author volume4
 */
$(document).ready(function(){
	
	var doc_url = document.location.href;
	
	if(doc_url.indexOf('feedback'))
	{
		$("#contact").validate();		
	}
	
	if(doc_url.indexOf('login'))
	{
		$("#login").validate();
	}
	
	if(doc_url.indexOf('password_reminder'))
	{
		$("#reminder").validate();
	}
	
	if(doc_url.indexOf('register'))
	{
		$("#register").validate();
	}	
	
	if(doc_url.indexOf('new'))
	{
		$("#newrelease").validate();
	}
});