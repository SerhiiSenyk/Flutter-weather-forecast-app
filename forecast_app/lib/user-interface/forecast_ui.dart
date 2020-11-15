import 'package:flutter/material.dart';
import 'package:forecast_app/bloc/forecast_bloc.dart';
import 'package:forecast_app/models/forecast.dart';
import 'package:forecast_app/user-interface/search_city_ui.dart';


class ForecastPage extends StatefulWidget {
  //ForecastPage({Key key, this.title}) : super(key: key);
  //final String title;
  @override
  _ForecastPageState createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  final ForecastBloc _forecastBloc = ForecastBloc();

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
                             Text("City", textScaleFactor: 1.3,),
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
  @override
  void dispose() {
    _forecastBloc.dispose();
    super.dispose();
  }
}
