// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart';

import 'package:weatherapp/models/weather.dart';
import 'package:weatherapp/service/location.dart';

class Service {
  LocationHelper locationHelper;
  Service({
    required this.locationHelper,
  });

  static const apiKey = 'a444db179d1c4f7f3b4169f8cc39f837';
  Future<Current> getCurrent({double latitude = 40.193298, double longitude = 29.074202}) async {
    var path = Uri.parse(
        // 'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric&lang=tr');
        'https://api.openweathermap.org/data/2.5/weather?lat=${locationHelper.latitude}&lon=${locationHelper.longitude}&appid=$apiKey&units=metric&lang=tr');
    Response response = await get(path);

    if (response.statusCode == 200) {
      var data = response.body;
      print(data);
      return Current.fromJson(jsonDecode(data));
    } else {
      throw Exception('hata');
    }
  }
}
