/**
 * @author ossreleasefeed
 */
jQuery.fn.jqlang = function() {
	this.each(function(){
		if(this['hreflang']) {
			$(this).after("<img src='images/icons/" + this['hreflang'] + ".png' style='margin-left:.3em;' alt='" + getLanguage(this['hreflang']) + "' title='" + getLanguage(this['hreflang']) + "'/>");	
		}		
	});
}	

function getLanguage(country_code) {
	language = "The target document is written in ";
	
	switch(country_code)
	{
		case 'ar': language += "Arabic"
		break;
		case 'ca': language += "Canadian"
		break;
		case 'cn': language += "Chinese"
		break;
		case 'de': language += "German"
		break;
		case 'el': language += "Greek"
		break;
		case 'en': language += "English"
		break;
		case 'es': language += "Spanish"
		break;
		case 'fr': language += "French"
		break;
		case 'it': language += "Italian"
		break;
		case 'jp': language += "Japanese"
		break;
		case 'kr': language += "Korean"
		break;
		case 'mx': language += "Mexican"
		break;
		case 'nl': language += "Dutch"
		break;
		case 'ru': language += "Russian"
		break;
		case 'se': language += "Swedish"
		break;
		case 'za': language += "Afrikaans"
		break;
	}
	
	return language;
}