class WeatherModel {
  final name;
  final region;
  final country;
  final lat;
  final lng;
  final localtime_epoch;
  final localtime;

  WeatherModel({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lng,
    required this.localtime,
    required this.localtime_epoch,
  });

  factory WeatherModel.fromMap(dynamic map) {
    return WeatherModel(
      name: map['name'],
      region: map['region'],
      country: map['country'],
      lat: map['lat'],
      lng: map['lng'],
      localtime: map['localtime'],
      localtime_epoch: map['localtime_epoch'],
    );
  }

  factory WeatherModel.fromJson(dynamic jsonData) {
    return WeatherModel(
      name: jsonData['name'],
      region: jsonData['region'],
      country: jsonData['country'],
      lat: jsonData['lat'],
      lng: jsonData['lng'],
      localtime: jsonData['localtime'],
      localtime_epoch: jsonData['localtime_epoch'],
    );
  }

  // Map<String, dynamic> getWeatherData() {
  //   return {
  //     'name': name,
  //     'region': region,
  //     'country': country,
  //     'lat': lat,
  //     'lng': lng,
  //     'localtime': localtime,
  //     'localtime_epoch': localtime_epoch
  //   };
  // }

  factory WeatherModel.fromString(String name, String region, String country,
      String lat, String lng, String localtime, String localtime_epoch) {
    return WeatherModel(
      name: name,
      region: region,
      country: country,
      lat: lat,
      lng: lng,
      localtime: localtime,
      localtime_epoch: localtime_epoch,
    );
  }
}
