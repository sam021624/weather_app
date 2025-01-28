import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/additional_info_item.dart';
import 'package:weather_app/hourly_forecast_item.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/secrets.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  
  @override
  void initState(){
    super.initState();
    getCurrentWeather();
  }

  Future getCurrentWeather() async {
    String cityName = 'London';
    final res = await http.get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&APPID=$openWeatherAPIKey',
        ),
    );
    print(res);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App', style: TextStyle(
          fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, 
          icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 10,
                        sigmaY: 10,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text('300°C', style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              ),
                            ),
                        
                            SizedBox(height: 16),
                        
                            Icon(Icons.cloud, size: 64),
                        
                            SizedBox(height: 16),
                        
                            Text('Rain', style: TextStyle(
                              fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        
            const SizedBox(height: 20),

            const Text('Weather Forecast', style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,              
              ),
            ),
        
            const SizedBox(height: 10),

            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  HourlyForecastItem(
                    time: '9:00',
                    icon: Icons.cloud,
                    temperature: '301.17',
                  ),
                  HourlyForecastItem(
                    time: '12:00',
                    icon: Icons.cloud,
                    temperature: '301.54',
                  ),
                  HourlyForecastItem(
                    time: '15:00',
                    icon: Icons.cloud,
                    temperature: '301.11',
                  ),
                  HourlyForecastItem(
                    time: '18:00',
                    icon: Icons.cloud,
                    temperature: '300.76',
                  ),
                  HourlyForecastItem(
                    time: '21:00',
                    icon: Icons.cloud,
                    temperature: '302.12',
                  ),
                ],
              ),
            ),
        
            const SizedBox(height: 20),

            const Text('Additional Information', style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,              
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AdditionalInfoItem(
                  icon: Icons.water_drop,
                  label: 'Humidity',
                  value: '91',
                ),
                AdditionalInfoItem(
                  icon: Icons.air,
                  label: 'Wind Speed',
                  value: '7.67',
                ),
                AdditionalInfoItem(
                  icon: Icons.beach_access,
                  label: 'Pressure',
                  value: '1006',
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}

