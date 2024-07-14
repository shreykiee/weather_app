import 'dart:ffi';
// testing git commit

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/services/weather_service.dart';

import '../models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage>
{
  // api key 
  final _weatherService = WeatherService('47bb5d9a5aa5b614250c1fd3bbc0cdc5');
  Weather? _weather;

  //fetch weather 
  _fetchWeather( ) async {
    //get city
    String cityName = await _weatherService.getCurrentCity();
    //get weather for city 
    try{
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }
    catch(e)
    {
      print(e);
    }
  }
  // weather animations 
  // weather animations
String getWeatherAnimation (String? mainCondition) {

    switch (mainCondition?.toLowerCase()) {
      case 'clouds':
        return 'assets/cloud.json';
      case 'mist':
        return 'assets/foggy_cloud.json';
      case 'smoke':
        return 'assets/foggy_cloud.json';
      case 'haze':
        return 'assets/foggy_cloud.json';
      case 'dust':
        return 'assets/foggy_cloud.json';
      case 'fog':
        return 'assets/foggy_cloud.json';
      case 'rain':
        return 'assets/rain.json';
      case 'drizzle':
        return 'assets/rain.json';
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/loading.json' ;

      }
}

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchWeather();
  }


  @override
  Widget build(BuildContext context) {
  
    return  Scaffold(
     
      body: Stack(
        children: [


          // background animation
          
           
             Container(
              color: Colors.black,
              
              
             ),
             
                Center(
                  child: Container(
                    child: Lottie.asset(
                             'assets/background_animation3.json',
                            fit: BoxFit.cover // Fills the entire background area
                    ),
                  ),
                ),
             
          
          
          Center(
          
            child: Column(
              mainAxisAlignment:MainAxisAlignment.center ,
              children: [
                // ciry name 
                
                Text(_weather?.cityName ?? "loading city.. " , style: const TextStyle
                (
                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 25,
                ),),
          
                SizedBox(height: 140,),
          
                //animations
                Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
                const SizedBox(height: 0,),
               
                  //condition
                 Text(_weather?.mainCondition ?? "",style: const TextStyle(
                  fontWeight: FontWeight.w300,
                                  color: Color.fromARGB(255, 21, 187, 101),
                                  fontSize: 18,
                                  
                 ), ),
                 SizedBox(height: 130,),
            
                //temperature 
                Text('${_weather?.temperature.round()}°C', style: const TextStyle(
                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 40,
                ),),
                
          
              
              ],
            ),
          ),
        ],
      ),

    );
  }
}

