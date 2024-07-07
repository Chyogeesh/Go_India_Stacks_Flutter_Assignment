import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';

class WeatherDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              final city = Provider.of<WeatherProvider>(context, listen: false).weather?.cityName;
              if (city != null) {
                Provider.of<WeatherProvider>(context, listen: false).fetchWeather(city);
              }
            },
          ),
        ],
      ),
      body: Consumer<WeatherProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null) {
            return Center(child: Text(provider.errorMessage!));
          }

          if (provider.weather == null) {
            return Center(child: Text('No weather data available'));
          }

          final weather = provider.weather!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('City: ${weather.cityName}', style: TextStyle(fontSize: 20)),
                Text('Temperature: ${weather.temperature}°C', style: TextStyle(fontSize: 20)),
                Text('Condition: ${weather.description}', style: TextStyle(fontSize: 20)),
                Image.network('http://openweathermap.org/img/wn/${weather.icon}.png'),
                Text('Humidity: ${weather.humidity}%', style: TextStyle(fontSize: 20)),
                Text('Wind Speed: ${weather.windSpeed} m/s', style: TextStyle(fontSize: 20)),
              ],
            ),
          );
        },
      ),
    );
  }
}
