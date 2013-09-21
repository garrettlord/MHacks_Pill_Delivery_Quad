function HudCtrl($scope) {
	const tickTimer = 100;

	$scope.leftItems = [
		{ name: "Longitude", data: "lon" },
		{ name: "Latitude", data: "lat" },
		{ name: "Relative Altitude", data: "relative_alt" },
		{ name: "Current Voltage", data: "voltage_battery" },
		{ name: "Groundspeed", data: "groundspeed" },
		{ name: "Battery Status", data: "flightBattery"}
	];

	$scope.rightItems = [
		{ name: "Yaw", data: "yaw" },
	];

	$scope.hudData = {
		lon: 0,
		lat: 0,
		relative_alt: 0,
		yaw: 0,     // Z
		pitch: -45, // X
		roll: 0,    // Y
		flightBattery: "75%",
		voltage_battery: 0,
		groundspeed: 0,
		heading: 0,
	};

	$scope.transformStr = function() {
		return "rotateX(" + (Math.PI/2-$scope.hudData.pitch)
			+ "rad) rotateY(" + $scope.hudData.roll
			+ "rad) rotateZ(0" //+ $scope.hudData.yaw
			+ "rad)";
	};

	setInterval(function() {
		$.ajax({
			url: 'http://169.254.0.1:8080/',
			type: 'GET',
			dataType: 'json',
			success: function(data) {
				data.yaw = +(+data.yaw).toFixed(2);
				data.pitch = +(+data.pitch).toFixed(2);
				data.roll = +(+data.roll).toFixed(2);
				data.lat = parseInt(data.lat)/10000000;
				data.lon = parseInt(data.lon)/10000000;
				data.flightBattery = data.flightBattery + "%";
				data.voltage_battery /= 1000;
				data.relative_alt = (data.relative_alt/(1000*100)).toFixed(2)
				$scope.hudData = data;
				$scope.$apply();
			},
			error: function () {}
		});
	}, tickTimer);
}