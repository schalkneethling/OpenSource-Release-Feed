/**
 * @author volume4
 */
google.load("maps", "2");

// Call this function when the page has been loaded
function initialize() {
  var map = new google.maps.Map2(document.getElementById("gmap"));
  map.setCenter(new google.maps.LatLng(3.864255, 46.933594), 3);
  map.setUIToDefault();
  
  // A function to create the marker and set up the event window 
  // Dont try to unroll this function. It has to be here for the function closure 
  // Each instance of the function preserves the contends of a different instance 
  // of the "marker" and "html" variables which will be needed later when the event triggers.
  // http://econym.org.uk/gmap/example_map.htm   
  function createMarker(point, html){
	  var marker = new google.maps.Marker(point);
	  google.maps.Event.addListener(marker, "click", function(){
		  marker.openInfoWindowHtml(html);
	  });
	  return marker;
  }

  var point = new google.maps.LatLng(-25.730633,28.186798); 
  var marker = createMarker(point,'<p>OSRF Release Party<br /><a href="http://wiki.ubuntu-za.org/Jaunty_Release_Party/Pretoria">Visit Wiki</a></p>')
  map.addOverlay(marker);
  
  var point = new google.maps.LatLng(45.460131,9.140625); 
  var marker = createMarker(point,'<p>Jaunty Release Party Milan<br /><a href="http://i3poli.org/">Visit Website</a></p>')
  map.addOverlay(marker);
  
  var point = new google.maps.LatLng(41.244772,-82.96875); 
  var marker = createMarker(point,'<p>Jaunty Release Party Ohio<br /><a href="https://wiki.ubuntu.com/OhioTeam/ReleaseParty/JauntyJackalope">Visit Wiki</a></p>')
  map.addOverlay(marker);
  
  var point = new google.maps.LatLng(36.738884,-106.523437); 
  var marker = createMarker(point,'<p>Jaunty Release Party New Mexico<br /><a href="https://wiki.ubuntu.com/NewMexicoTeam/JauntyJackalope">Visit Wiki</a></p>')
  map.addOverlay(marker);
  
  var point = new google.maps.LatLng(48.224673,16.347656); 
  var marker = createMarker(point,'<p>Jaunty Release Party Vienna, Austria<br /><a href="http://ubuntu-at.com/">Visit Website</a></p>')
  map.addOverlay(marker);
  
  var point = new google.maps.LatLng(53.435719,-2.285156); 
  var marker = createMarker(point,'<p>Jaunty Release Party Manchester, UK<br /><a href="http://upcoming.yahoo.com/event/2173360/?ps=5">Visit Website</a></p>')
  map.addOverlay(marker);
  
  var point = new google.maps.LatLng(14.604847,121.113281); 
  var marker = createMarker(point,'<p>Jaunty Release Party Philippines<br /><a href="https://wiki.ubuntu.com/PhilippineTeam/ReleaseParty">Visit Website</a></p>')
  map.addOverlay(marker);
  
  var point = new google.maps.LatLng(37.579413,126.914063); 
  var marker = createMarker(point,'<p>Jaunty Release Party Korea<br /><a href="http://ubuntu.or.kr/viewtopic.php?f=2&t=4721&st=0&sk=t&sd=a">Visit Website</a></p>')
  map.addOverlay(marker);
  
  var point = new google.maps.LatLng(45.477812,9.228269); 
  var marker = createMarker(point,'<p>Jaunty Release Party in Milan<br /><a href="http://i3poli.org/2009/04/16/jaunty-release-party/">Visit Website</a></p>')
  map.addOverlay(marker);
  
  var point = new google.maps.LatLng(45.58329,-73.652344); 
  var marker = createMarker(point,'<p>Jaunty Release Party Montreal<br /><a href="https://wiki.ubuntu.com/QuebecTeam/JauntyParty/Invitation">Visit Website</a></p>')
  map.addOverlay(marker);
  
  var point = new google.maps.LatLng(4.039618,9.667969); 
  var marker = createMarker(point,'<p>Jaunty Release Party Douala, Cameroon<br /><a href="https://wiki.ubuntu.com/CameroonianTeam/Events/JauntyReleaseParty">Visit Website</a></p>')
  map.addOverlay(marker);
  
  var point = new google.maps.LatLng(4.039618,9.140625); 
  var marker = createMarker(point,'<p>Jaunty Release Party Limbe, Cameroon<br /><a href="https://wiki.ubuntu.com/CameroonianTeam/Events/JauntyReleaseParty">Visit Website</a></p>')
  map.addOverlay(marker);
  
  var point = new google.maps.LatLng(32.795356,-96.797791); 
  var marker = createMarker(point,'<p>Jaunty Release Party Dallas, TX - 23 April<br /><a href="http://irc.freenode.net/#ubuntu-dallas">IRC</a></p>')
  map.addOverlay(marker);
  
  var point = new google.maps.LatLng(31.503629,-95.449219); 
  var marker = createMarker(point,'<p>Jaunty Release Party Houston, TX - 23 April<br /><a href="http://groups.google.com/group/ubuntu-houston-team?hl=en">Visit Website</a></p>')
  map.addOverlay(marker);
  
  var point = new google.maps.LatLng(32.10119,-97.734375); 
  var marker = createMarker(point,'<p>Jaunty Release Party Austin, TX - 24 April<br /><a href="http://blog.dustinkirkland.com/2009/04/jaunty-release-party-austin-texas.html">Visit Website</a></p>')
  map.addOverlay(marker);
  
  var point = new google.maps.LatLng(15.45368,-88.066406); 
  var marker = createMarker(point,'<p>Jaunty Release Party San Pedro Sula Honduras<br /><a href="https://wiki.ubuntu.com/HondurasTeam/Jaunty_Party">Visit Website</a></p>')
  map.addOverlay(marker);
  
  var point = new google.maps.LatLng(38.410558,-80.859375); 
  var marker = createMarker(point,'<p>Jaunty Release Party Galax, Virginia - 2 May<br /><a href="http://ls.net/node/861">Visit Website</a></p>')
  map.addOverlay(marker);
  
  var point = new google.maps.LatLng(38.924069,-77.05178); 
  var marker = createMarker(point,'<p>Jaunty Release Party Taste of India, DC - 24 April<br /><a href="http://dc.ubuntu-us.org/">Visit Website</a></p>')
  map.addOverlay(marker);
  
  var point = new google.maps.LatLng(-17.811456,31.113281); 
  var marker = createMarker(point,'<p>Jaunty Release Party Harare, Zimbabwe - 25 April<br /><a href="http://www.ubuntu.org.zw/node/16">Visit Website</a></p>')
  map.addOverlay(marker);
  
  var point = new google.maps.LatLng(37.857507,40.253906); 
  var marker = createMarker(point,'<p>Jaunty Release Party Turkey 25 April<br /><a href="http://amedcj.blogspot.com/2009/04/panela-linux-u-ubuntuye-ubuntu-9.html">Visit Website</a></p>')
  map.addOverlay(marker);
  
  var point = new google.maps.LatLng(40.438423,-80.001933); 
  var marker = createMarker(point,'<p>Jaunty Release Party Pittsburgh, Pennsylvania 23 April<br /><a href="https://wiki.ubuntu.com/PennsylvaniaTeam/EventsTeam/PittsburghJauntyRelease">Visit Website</a></p>')
  map.addOverlay(marker);
  
  var point = new google.maps.LatLng(42.940339,1.933594); 
  var marker = createMarker(point,'<p>Jaunty Release Party Terrassa, Barcelona<br /><a href="https://wiki.ubuntu.com/CatalanTeam/JauntyJackalope">Visit Website</a></p>')
  map.addOverlay(marker);
  
  var point = new google.maps.LatLng(33.760882,-84.38942); 
  var marker = createMarker(point,'<p>Jaunty Release Party Atlanta, GA - 25 April<br /><a href="http://www.ubuntu-georgia.org/node/33">Visit Website</a></p>')
  map.addOverlay(marker);
  
  var point = new google.maps.LatLng(41.891033,-87.624207); 
  var marker = createMarker(point,'<p>Jaunty Release Party Chicago, Illinois - 25 April<br /><a href="https://wiki.ubuntu.com/ChicagoTeam/ReleaseParty">Visit Website</a></p>')
  map.addOverlay(marker);
  
  var point = new google.maps.LatLng(41.376809,-75.234375); 
  var marker = createMarker(point,'<p>Jaunty Release Party Philadelphia, Pennsylvania - 2 May<br /><a href="https://wiki.ubuntu.com/PennsylvaniaTeam/EventsTeam/PhillyJauntyRelease">Visit Website</a></p>')
  map.addOverlay(marker);
  
  var point = new google.maps.LatLng(40.979898,-105.820312); 
  var marker = createMarker(point,'<p>Jaunty Release Party Colorado<br /><a href="http://coloco.ubuntu-rocks.org/2009/03/11/jaunty-jackalope-ubuntu-release-party/">Visit Website</a></p>')
  map.addOverlay(marker);
  
  var point = new google.maps.LatLng(46.679594,-94.746094); 
  var marker = createMarker(point,'<p>Jaunty Release Party Minnesota - 25 April<br /><a href="http://ubuntu-minnesota.org/">Visit Website</a></p>')
  map.addOverlay(marker);
  
  var point = new google.maps.LatLng(-32.249974,18.457031); 
  var marker = createMarker(point,'<p>Jaunty Release Party Cape Town - 25 April<br /><a href="http://wiki.ubuntu-za.org/Jaunty_Release_Party/Cape_Town">Visit Website</a></p>')
  map.addOverlay(marker);
}

google.setOnLoadCallback(initialize);