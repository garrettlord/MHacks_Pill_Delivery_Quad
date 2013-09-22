var line;

function initialize() {
  var mapOptions = {
    center: new google.maps.LatLng(20.291, 153.027),
    zoom: 6,
    mapTypeId: google.maps.MapTypeId.TERRAIN
  };
  var marker = null;

  var map = new google.maps.Map(document.getElementById('map-canvas'),
      mapOptions);

  if (marker) { marker.setMap(null); }
  marker = new google.maps.Marker({ position: event.latLng, map: map});

  google.maps.event.addListener(map, "rightclick", function(event) {
    var lat = event.latLng.lat();
    var lng = event.latLng.lng();
    // populate yor box/field with lat, lng
    alert("Lat=" + lat + "; Lng=" + lng);
  });
  
  var lineCoordinates = [
      new google.maps.LatLng(37.772323, -122.214897),
      new google.maps.LatLng(21.291982, -157.821856),
      new google.maps.LatLng(-18.142599, 178.431),
      new google.maps.LatLng(-27.46758, 153.027892)
  ];

  var lineSymbol = {
    path: google.maps.SymbolPath.CIRCLE,
    scale: 8,
    strokeColor: '#393'
  };

  line = new google.maps.Polyline({
    path: lineCoordinates,
    icons: [{
      icon: lineSymbol,
      offset: '100%'
    }],
    map: map
  });

  animateCircle();
}

function animateCircle() {
  var count = 0;
  window.setInterval(function() {
    count = (count + 1) % 200;

    var icons = line.get('icons');
    icons[0].offset = (count / 2) + '%';
    line.set('icons', icons);
  }, 20);
}

var path = window.location.pathname.split('/');
if (path.length === 3 && path[1] === 'hospitals') {
  console.log('asdf');
  google.maps.event.addDomListener(window, 'load', initialize);
}