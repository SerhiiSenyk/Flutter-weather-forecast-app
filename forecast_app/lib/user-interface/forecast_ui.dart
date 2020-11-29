import 'package:flutter/material.dart';
import 'package:forecast_app/bloc/forecast_bloc.dart';
import 'package:forecast_app/models/forecast.dart';
import 'package:forecast_app/models/weather.dart';
import 'package:forecast_app/user-interface/search_city_ui.dart';
import 'dart:math';


class ForecastPage extends StatefulWidget {
  //ForecastPage({Key key, this.title}) : super(key: key);
  //final String title;
  @override
  _ForecastPageState createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage>
                      with TickerProviderStateMixin{
  Random _rand = Random();
  final ForecastBloc _forecastBloc = ForecastBloc();
  Animation<double> _sunAnimation;
  AnimationController _sunAnimationController;
  Animation<double> _scaleAnimation;
  AnimationController _scaleAnimationController;

  List<Animation<Offset>> _cloudSlideAnimation = List<Animation<Offset>>();
  List<AnimationController> _cloudSlideAnimationController =
                                                  List<AnimationController>();

  Animation<double> _snowflakeAnimation;
  AnimationController _snowflakeAnimationController;
  List<Animation<Offset>> _snowAnimation = List<Animation<Offset>>();
  List<AnimationController> _snowAnimationController = List<AnimationController>();
  final countSnowflakes = 6;
  final countClouds = 2;
  @override
  void initState() {
    super.initState();
    initScaleAnimation();
    initSunAnimation();
    initCloudAnimation();
    initSnowAnimation();
    initSnowflakeRotationAnimation();
  }

  void initSunAnimation(){
    this._sunAnimationController = AnimationController(
        duration: const Duration(seconds:4),
        vsync: this
    )..repeat(reverse: true);
    this._sunAnimation =
        CurvedAnimation(
      parent: _sunAnimationController,
      curve: Curves.easeInOutCirc,
    );
  }

  void initCloudAnimation() {
    for (int i = 0; i < countClouds; ++i) {
      this._cloudSlideAnimationController.add(AnimationController(
        duration: Duration(seconds: 6 - i*2), //random
        vsync: this,
      )
        ..repeat(reverse: true));
      this._cloudSlideAnimation.add(
          Tween<Offset>(
              begin: Offset(-0.2 - i, 0.05 - i*0.6),
              end: Offset(0.1 - i*3, 0.05 - i*0.6)
          ).animate(CurvedAnimation(
              parent: _cloudSlideAnimationController[i],
              curve: Curves.linear
          )));
    }
  }

  void initScaleAnimation()
  {
    this._scaleAnimationController = AnimationController(
      duration: const Duration(seconds:3),
      vsync: this,
    )..repeat(reverse: true);
    this._scaleAnimation =
        Tween<double>(begin: 0.9, end: 1.1).animate(
            CurvedAnimation(
              parent: _scaleAnimationController,
              curve: Curves.easeInOutCirc,
            ));
  }

  void initSnowflakeRotationAnimation(){
    this._snowflakeAnimationController = AnimationController(
      duration:Duration(seconds:2),
      vsync: this,
    )..repeat(reverse: false);
    this._snowflakeAnimation =
        CurvedAnimation(
          parent: _snowflakeAnimationController,
          curve: Curves.linear,
        );
  }

  void initSnowAnimation(){
    var bottom = 5;
    var top = 0.0;
    final width = 4;
    final koef = 1.0 - width/countSnowflakes;
    for(int i = 0;i < countSnowflakes;++i) {
      this._snowAnimationController.add(AnimationController(
        duration: Duration(seconds: _rand.nextInt(4) + 3),//random
        vsync: this,
      )..repeat(reverse: false));
      this._snowAnimation.add(
          Tween<Offset>(
          begin: Offset(-i*koef , top + 1.2 * _rand.nextDouble()),
          end: Offset((_rand.nextDouble()*width - 1.2*i), bottom + 3 * _rand.nextDouble()),//rand.nextDouble()*k - i*0.5
          ).animate(CurvedAnimation(
          parent: _snowAnimationController[i],
          curve: Curves.linear
      )));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Flutter Weather Forecast'),//(widget.title),
      ),

      body:
        StreamBuilder<Forecast>(
        stream: _forecastBloc.forecastStream,
        builder: (context, snapshot) {
         if (snapshot.hasData) {
           var forecast = snapshot.data;
           return Column(
               children: <Widget>[
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Text("Temperature ", textScaleFactor: 2,
                     style: TextStyle(fontWeight: FontWeight.bold),),
                 ),
                 Padding(
                   padding: const EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 10.0),
                   child: Table(
                     children: [
                       TableRow(
                           children: [
                             Text("City", textScaleFactor: 1.3),
                             Text("Today", textScaleFactor: 1.3),
                             Text("Morrow", textScaleFactor: 1.3),
                             Text("In 2 Days", textScaleFactor: 1.3),
                           ]
                       ),

                       TableRow(
                           children: [
                             Text('${forecast.city.cityName}',
                                 textScaleFactor: 1.4),
                             Text('${forecast.weathers[0].temp}°C',
                                 textScaleFactor: 1.4),
                             Text('${forecast.weathers[1].temp}°C',
                                 textScaleFactor: 1.4),
                             Text('${forecast.weathers[2].temp}°C',
                                 textScaleFactor: 1.4),
                           ]
                       ),

                       TableRow(

                           children: [
                                       Text(''),
                                      _WeatherAnimationWidget(forecast.weathers[0]),
                                      _WeatherAnimationWidget(forecast.weathers[1]),
                                      _WeatherAnimationWidget(forecast.weathers[2]),
                           ]
                       ),
                     ],
                   ),
                 ),
               ]
           );
         }
         else {

           return Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                         Text('No forecast data', textScaleFactor: 1.3),
                        //_WeatherAnimationWidget(true),
                        //_WeatherAnimationWidget(false),
                        ]
           ),
           );
         }
    }),

      

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => SearhCityPage()))
              .then((value) => setState(() => {_forecastBloc.updateForecast()}));
        },
        tooltip: 'Search city',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _WeatherAnimationWidget(Weather weather) {
    if(weather.code >= 600 && weather.code <= 610){//snow
      List<Widget> snowflakeList = List<Widget>();
      for(int i = 0; i < countSnowflakes; ++i){
        snowflakeList.add(
            SlideTransition(
              position: _snowAnimation[i],
              child: RotationTransition(//snowflake rotation
                  turns:_snowflakeAnimation,
                  child: Image.asset(
                    'icons/snowflake.png',
                    height: 10 + 6*_rand.nextDouble(),
                    width: 10 + 6*_rand.nextDouble(),
                  ),
            ),
            ),
        );
      }
      return Row(children: snowflakeList);//Row
    }

    else if(weather.code >= 800 && weather.code <= 802){//sun
      return
        RotationTransition(
        turns:_sunAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Image.asset(
              'icons/sun.png',
              height: 65,
              width: 50,
            ),
          ),
      );
    }
    else { //clouds
      List<Widget> list = List<Widget>();
      List<String> icons = List<String>();
      icons.add('icons/clouds.png');
      icons.add('icons/clouds1.png');
      for (int i = 0; i < countClouds; ++i) {
        list.add(
            SlideTransition(
              position: _cloudSlideAnimation[i],
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Image.asset(
                  icons[i],
                  height: 62.0 - i*35,
                  width: 62.0 - i*35,
                ),
              ),
            ));
      }
      return Row(children: list);//Row
    }
  }

  @override
  void dispose() {
    _forecastBloc.dispose();
    super.dispose();
  }
}
