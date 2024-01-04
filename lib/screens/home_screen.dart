import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_cool/bloc/weather_bloc.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  String getWeatherIcon(int code){
    switch(code){
      case>=200 && <300:
        return 'assets/thunderstorm.png';
      case>=300 && <400:
        return 'assets/drizzle.png';
      case>=500 && <600:
        return 'assets/drizzle.png';
      case>=600 && <700:
        return 'assets/snow.png';
      case>=700 && <800:
        return 'assets/atmo.png';
      case == 800:
        return 'assets/sun.png';
      case>800 && <900:
        return 'assets/cloud_sun.png';
      default:
        return 'assets/cloud_sun.png';
    }

  }
  String getGreeting(int hour) {

    if (hour >= 5 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon';
    } else if (hour >= 17 && hour < 21) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: Alignment(2.5, -0.3),
                child: Container(
                  height: 230,
                  width: 230,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.deepPurple
                  ),
                ),
              ),
              Align(
                alignment: Alignment(-2.5, -0.3),
                child: Container(
                  height: 230,
                  width: 230,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.deepPurple
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, -1.2),
                child: Container(
                  height: 230,
                  width: 230,
                  decoration: const BoxDecoration(

                      color: Colors.deepOrangeAccent
                  ),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0,sigmaY: 100.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent
                  ),
                ),
              ),
              BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if(state is WeatherSuccess) {
                    print(state.weather.date!.hour);
                    return SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ' 🌐 ${state.weather.areaName}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300
                            ),
                          ),
                          SizedBox(height: 8,),
                           Text(
                            getGreeting(state.weather.date!.hour),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Center(
                            child: Image.asset(
                              getWeatherIcon(state.weather.weatherConditionCode!), scale: 18,),
                          ),
                          Center(
                            child: Text(
                              '${state.weather.temperature!.celsius!.round()}°C',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              state.weather.weatherMain!.toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              DateFormat('EEEE DD •').add_jm().format(state.weather.date!),
                              // 'Friday 16 • 09.41am',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300
                              ),
                            ),
                          ),
                          SizedBox(height: 30,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset('assets/sunset.png', scale: 18,),
                                  SizedBox(width: 5,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Sunrise',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300
                                        ),
                                      ),
                                      SizedBox(height: 3,),
                                      Text(
                                        DateFormat().add_jm().format(state.weather.sunrise!),

                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700
                                        ),
                                      )
                                    ],
                                  )

                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset('assets/moon-star.png', scale: 12,),
                                  SizedBox(width: 5,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Sunset',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300
                                        ),
                                      ),
                                      SizedBox(height: 3,),
                                      Text(
                                        DateFormat().add_jm().format(state.weather.sunset!),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700
                                        ),
                                      )
                                    ],
                                  )

                                ],
                              )
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset('assets/max.png', scale: 2,),
                                  SizedBox(width: 5,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Temp Max',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300
                                        ),
                                      ),
                                      SizedBox(height: 3,),
                                      Text(
                                        '${state.weather.tempMax!.celsius!.round()}°C',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700
                                        ),
                                      )
                                    ],
                                  )

                                ],
                              ),

                              Row(
                                children: [
                                  Image.asset('assets/min.png', scale: 2,),
                                  SizedBox(width: 5,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Temp Min',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300
                                        ),
                                      ),
                                      SizedBox(height: 3,),
                                      Text(
                                        '${state.weather.tempMin!.celsius!.round()}°C',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700
                                        ),
                                      )
                                    ],
                                  )

                                ],
                              )
                            ],
                          ),

                        ],
                      ),
                    );
                  }else{
                    return Container();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

