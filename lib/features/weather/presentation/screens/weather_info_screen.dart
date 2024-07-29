import 'package:flutter/material.dart';

import 'package:weather_app/features/internals/common_widgets/common_widget_helpers.dart';

import 'package:weather_app/features/weather/data/models/weather_model.dart';

class WeatherInfoScreen extends StatelessWidget {
  final WeatherModel weatherModel;

  const WeatherInfoScreen({super.key, required this.weatherModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: backgroundColorConverter(
            weatherModel.weather?.first.description ?? ''),
        title: Text('Weather Info'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              weatherModel.name ?? '-',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              dateConverter(weatherModel.dt),
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 50),
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: backgroundColorConverter(
                  weatherModel.weather?.first.description ?? '',
                ),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: backgroundColorConverter(
                        weatherModel.weather?.first.description ?? '',
                      ).withOpacity(0.5),
                      blurRadius: 10,
                      blurStyle: BlurStyle.outer),
                ],
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -40,
                    left: 20,
                    child: Image.asset(
                      backgroundImageConverter(
                          weatherModel.weather?.first.description ?? ''),
                    ),
                    height: 100,
                    width: 150,
                  ),
                  Positioned(
                    bottom: 30,
                    left: 20,
                    child: Text(
                      '${weatherModel.weather?.first.main}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Row(
                      children: [
                        Text(
                          '${(weatherModel.main?.temp ?? 0).toInt()}° C',
                          style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonRow(
                    text: 'Wind Speed',
                    imageSelect: 'assets/images/windspeed.png',
                    speedText:
                        '${weatherModel.wind?.speed.toString() ?? ''} m/s',
                  ),
                  CommonRow(
                    text: 'Humidity',
                    imageSelect: 'assets/images/humidity.png',
                    speedText: weatherModel.main?.humidity.toString() ?? '',
                  ),
                  CommonRow(
                    text: 'Max Temperature',
                    imageSelect: 'assets/images/max-temp.png',
                    speedText:
                        '${weatherModel.main?.tempMax?.toInt() ?? 0} ° C',
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Today',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Next 7 days',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                itemCount: 7,
                itemBuilder: (context, index) {
                  return Container(
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '${(weatherModel.main?.temp ?? 0).toInt()}° C',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(weatherModel.weather?.first.description ?? ''),
                        Image.asset(
                          backgroundImageConverter(
                              weatherModel.weather?.first.description ?? ''),
                          width: 50,
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 10);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
