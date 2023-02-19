import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hava_durumu/utils/weather.dart';

class MainScreen extends StatefulWidget {
  //const MainScreen({Key? key}) : super(key: key);
  final WeatherData weatherData;
  MainScreen({required this.weatherData});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int? temperature;
  Icon? weatherDispplayIcon;
  AssetImage? backgroundImage;
  String? city;
  void updateDisplayInfo(WeatherData weatherData){
    setState(() {
      temperature = weatherData.currentTemperature!.round();
      WeatherDisplayData weatherDisplayData = weatherData.getWeatherDisplayData()!;
      weatherDispplayIcon = weatherDisplayData.weatherIcon;
      backgroundImage = weatherDisplayData.weatherImage;
      city = weatherData.city;

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateDisplayInfo(widget.weatherData);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: backgroundImage!,
            fit: BoxFit.cover
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 50.0
            ),
            Container(
              child: weatherDispplayIcon
            ),
            SizedBox(
              height: 15.0,
            ),
            Center(
              child: Text("$temperature°",style: TextStyle(fontSize: 50,letterSpacing: -5))
            ),
            SizedBox(
              height: 15.0,
            ),
            Center(
                child: Text("$city°",style: TextStyle(fontSize: 50,letterSpacing: -5))
            ),


          ],
        ),

      ),


    );
  }
}
