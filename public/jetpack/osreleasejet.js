/*
The MIT License

Copyright(c) 2009 OpenSource Release Feed

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

var feed = "http://opensourcereleasefeed.com/release/master_feed";

var initReleaseIcon = '<img src="http://opensourcereleasefeed.com/images/icons/new_release_icon.png"/>';
var newReleaseIcon = 'http://opensourcereleasefeed.com/images/icons/new_release_icon.png';
var noReleaseIcon = 'http://opensourcereleasefeed.com/images/icons/no_release_icon.png';

var previousRelease;
var currentRelease;
var releaseLink;

var setIcon = true;
var statusBarWidget;

function notify() {
	$.get(feed, function(xml) {	
		currentRelease = $(xml).find("item > title:first").get(0).textContent;
		releaseLink = $(xml).find("item > link:first").get(0).textContent;
		
		if(previousRelease != currentRelease) {
			jetpack.notifications.show(currentRelease);            

            if(setIcon) {
    			setReleaseLink(releaseLink, currentRelease);
            } else {
                updateReleaseLink(releaseLink, newReleaseIcon, statusBarWidget);
            }
		} else {
			jetpack.notifications.show("No new releases.");
			updateReleaseIcon(noReleaseIcon, statusBarWidget);
		}
	});
}

// Opens a new tab pointing to the release and shifts focus to this new tab.
function openRelease() {
    jetpack.tabs.open(releaseLink);
    jetpack.tabs[jetpack.tabs.length - 1].focus();
}

function setReleaseLink(releaseLink, currentRelease) {
	jetpack.statusBar.append({  
		html: initReleaseIcon,  
		width: 20,
		onReady: function(widget) {
                        _icon = $(widget).find("img");
                        _icon.css("padding", "4px");
                        _icon.css("padding-left", "1px");

			$(widget).click(openRelease);
            statusBarWidget = $(widget);
		}
	});
	previousRelease = currentRelease;
    setIcon = false;
}

function updateReleaseLink(releaseLink, statusImage, statusBarWidget) {
    _releaseIcon = statusBarWidget.find("img");
    _releaseIcon.attr("src", statusImage);
    _releaseIcon.css("padding", "4px");
    _releaseIcon.css("padding-left", "1px");

    statusBarWidget.unbind('click', openRelease);
    statusBarWidget.click(openRelease);
    previousRelease = currentRelease;
}

function updateReleaseIcon(noReleaseImage, statusBarWidget) {
	statusBarWidget.unbind('click', openRelease);
    console.log("Inside updateReleaseIcon");
    _releaseIcon = statusBarWidget.find("img");
    _releaseIcon.attr("src", noReleaseIcon);
    _releaseIcon.css("padding", "4px");
    _releaseIcon.css("padding-left", "1px");
}

notify();
setInterval(notify, 500*60); <!-- 3 600 000 -->