import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/utils/constants.dart';
import 'package:weather_app/utils/helper_function.dart';
import 'package:weather_app/utils/location_utils.dart';
import 'package:weather_app/utils/text_style.dart';

class WeatherPage extends StatefulWidget {
  static const String routeName = '/';

  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late WeatherProvider provider;
  bool isFirst = true;

  @override
  void didChangeDependencies() {
    if (isFirst) {
      provider = Provider.of<WeatherProvider>(context);
      _getData();
      isFirst = false;
    }
    super.didChangeDependencies();
  }

  _getData() {
    determinePosition().then((position) {
      provider.setNewLocation(position.latitude, position.longitude);
      provider.getWeatherData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Weater'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.my_location),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: Center(
        child: provider.hasDataLoaded
            ? ListView(
                padding: EdgeInsets.all(8),
                children: [_currentWeatherSection(), _forecastWeatherSection()],
              )
            : const Text(
                'Please Wait.....',
                style: txtNormal16,
              ),
      ),
    );
  }

  Widget _currentWeatherSection() {
    final response = provider.currentResponseModel;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          getFormattedDateTime(response!.dt!, 'MMM dd, yyyy'),
          style: txtDateheader18,
        ),
        Text(
          '${response.name}, ${response.sys!.country}',
          style: txtAddress24,
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                '$iconPrefix${response.weather![0].icon}$iconSuffix',
                fit: BoxFit.cover,
              ),
              Text(
                '${response!.main!.temp!.round()}$degree$celsius',
                style: txtTempBig80,
              ),
            ],
          ),
        ),
        Wrap(
          children: [
            Text(
              'feels like ${response!.main!.feelsLike!.round()}%',
              style: txtNormal16,
            ),
            SizedBox(width: 10,),
            Text('${response.weather![0].main}, ${response.weather![0].description}',style: txtNormal16,),
          ],
        ),
        SizedBox(height: 20,),
        Wrap(
          children: [
            Text(
              'humidity ${response!.main!.humidity!}%',
              style: txtNormal16White54,
            ),
            SizedBox(width: 10,),
            Text('Pressure ${response.main!.pressure}hPa',style: txtNormal16White54,),
            SizedBox(width: 10,),
            Text('Visibility ${response.visibility}meter',style: txtNormal16White54,),
            SizedBox(width: 10,),
            Text('Wind ${response.wind!.speed}m/s',style: txtNormal16White54,),
            SizedBox(width: 10,),
            Text('Degree ${response.wind!.deg}$degree',style: txtNormal16White54,),
          ],
        ),
        Wrap(
          children: [
            Text(
              'Sunrise ${getFormattedDateTime(response.sys!.sunrise!, 'hh:mm a')}',
              style: txtNormal16,
            ),
            SizedBox(width: 10,),
            Text(
              'Sunset ${getFormattedDateTime(response.sys!.sunset!, 'hh:mm a')}',
              style: txtNormal16,
            ),
          ],
        ),
      ],
    );
  }

  Widget _forecastWeatherSection() {
    return Center();
  }
}
