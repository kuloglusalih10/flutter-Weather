import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';

import 'location.dart';

const apiKey = "a18d779c269b0772b471803ca257806c";
class WeatherDisplayData{
  Icon? weatherIcon;
  AssetImage? weatherImage;

  WeatherDisplayData({@required this.weatherIcon, this.weatherImage});
}

class WeatherData {

  LocationHelper? locationData;
  double? currentTemperature;
  int?  currentCondition;
  String? city;

  WeatherData({@required this.locationData});


  Future<void> getCurrentTemperature() async {
    Response response = await get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=${locationData!.latitude}&lon=${locationData!.longitude}&appid=${apiKey}&units=metric"));

    if(response.statusCode ==200)
      {
        var currentWeather = jsonDecode(response.body);

        try{
          currentTemperature = currentWeather['main']['temp'];
          currentCondition = currentWeather['weather'][0]['id'];
          city = currentWeather['name'];
        }catch(e){
          print(e);
        }
      }
    else{
      print("Api'den Değer Gelmiyor");
    }
  }

  WeatherDisplayData? getWeatherDisplayData(){
    if(currentCondition! < 600)
      {
        return WeatherDisplayData(weatherIcon: Icon(
          FontAwesomeIcons.cloud,
          color:Colors.white,
          size: 120.0
        ),
        weatherImage: AssetImage('assets/bulutlu.png'));
      }
    else
      {
        var now = DateTime.now();
        if(now.hour>=19)
          {
            return WeatherDisplayData(weatherIcon: Icon(
                FontAwesomeIcons.moon,
                color:Colors.white,
                size: 120.0
            ),
                weatherImage: AssetImage('assets/gece.png'));
          }
        else{
          return WeatherDisplayData(weatherIcon: Icon(
              FontAwesomeIcons.sun,
              color:Colors.white,
              size: 120.0
          ),
              weatherImage: AssetImage('assets/gunesli.png'));
        }
      }
  }

}