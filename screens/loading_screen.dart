import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hava_durumu/screens/main_screen.dart';
import 'package:hava_durumu/utils/weather.dart';

import '../utils/location.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  LocationHelper?  locationData;

  Future<void> getLocationData() async {
    locationData = LocationHelper();
     await locationData?.getCurrentLocation();

     if(locationData!.latitude == null || locationData!.longitude == null)
       {
         print("Kullanıcı Konumu Alınamadı");
       }
     else{
       print("latitude : "+ locationData!.latitude.toString()+
              "longitude : "+ locationData!.longitude.toString());
     }
  }

  void getWeatherData() async {
    await getLocationData();

    WeatherData weatherData =  WeatherData(locationData: locationData);
    await weatherData.getCurrentTemperature();
    if(weatherData.currentCondition == null || weatherData.currentTemperature == null){
      print("Sıcakık veya durum bilgisi boş dönüyor");
    }
    else
      {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> MainScreen(weatherData: weatherData,)));
      }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeatherData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.yellowAccent, Colors.white70]
          )
        ),
        child: Center(
          child: SpinKitPouringHourGlassRefined(
            size: 100.0,
            color: Colors.brown,
            duration: Duration(microseconds: 2000000)
          ),
        ),
      ),
    );
  }
}
