var line;

function initialize() {
  var mapOptions = {
    center: new google.maps.LatLng(35.926,35.921),
    zoom: 14,
    mapTypeId: google.maps.MapTypeId.HYBRID
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
      new google.maps.LatLng(35.931064, 35.920808),
      new google.maps.LatLng(35.927753, 35.919263),
      new google.maps.LatLng(35.926007, 35.921409),
      new google.maps.LatLng(35.924017, 35.922868),
      new google.maps.LatLng(35.922679, 35.92452)
  ];
  

  var lineSymbol = {
    path: google.maps.SymbolPath.FORWARD_OPEN_ARROW,
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
    count = (count + 1) % 400;

    var icons = line.get('icons');
    icons[0].offset = (count / 4.5) + '%';
    line.set('icons', icons);
  }, 20);
}

var path = window.location.pathname.split('/');
if (path.length === 3 && path[1] === 'hospitals') {
  console.log('asdf');
  google.maps.event.addDomListener(window, 'load', initialize);
}