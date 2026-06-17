import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_bg.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/weather_model.dart';

class TodaysWeather extends StatelessWidget {
  final WeatherModel? weatherModel;
  const TodaysWeather({super.key, this.weatherModel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WeatherBg(
          weatherType: WeatherType.cloudyNight,
          width: double.infinity,
          height: 300,
        ),
        SizedBox(
          width: double.infinity,
          height: 300,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      weatherModel?.location?.name ?? "",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      DateFormat.yMMMMEEEEd().format(
                        DateTime.parse(
                          weatherModel?.current?.lastUpdated.toString() ?? "",
                        ),
                      ),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white10,
                    ),
                    child: Image.network(
                      "https:${weatherModel?.current?.condition?.icon ?? ""}",
                    ),
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Text(
                              weatherModel?.current?.tempC?.round().toString()??"",style: TextStyle(
                              fontSize: 80,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink
                            ),
                            ),
                          ),
                          Text(
                            "o",style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink,
                          ),
                          ),

                        ],
                      ),
                      Text(
                        weatherModel?.current?.condition?.text ??"",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white
                      ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
