import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:forecast_app/bloc/city_bloc.dart';
import 'package:forecast_app/rest-api/city_api.dart';

class SearhCityPage extends StatefulWidget {
  @override
  _SearhCityPageState createState() => new _SearhCityPageState();
}

class _SearhCityPageState extends State<SearhCityPage> {
  List<String> added = [];
  String cityName = "";
  String currentText = "";
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  CityBloc _cityBloc = CityBloc();
  CityAPI api = CityAPI();
  SimpleAutoCompleteTextField textField;
  bool showWhichErrorText = false;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
            title: new Text('Search city')),

        body : Center(
          child : Column(
            children :  [
              StreamBuilder<List<String>>(
                
                  stream: _cityBloc.cityStream,
                  builder: (context, snapshot) {
                    return ListTile(
                        title:  !snapshot.hasData
                            ? CircularProgressIndicator()
                            : textField = SimpleAutoCompleteTextField(
                            key: key,
                            decoration: InputDecoration(errorText: "City"),
                            controller: TextEditingController(text: ""),
                            suggestions: snapshot.data,
                            textChanged: (text) => currentText = text,
                            clearOnSubmit: false,
                            textSubmitted: (text) => setState(() {
                              if (text != "") {
                                cityName = text;
                                added.add(text);
                              }
                            }),
                      ),
                        trailing: new IconButton(
                            icon: new Icon(Icons.add),
                            onPressed: () {
                              _cityBloc.save(cityName);
                              Navigator.pop(context);
                            }),
                  );
              }),
            ],
          ),
        ),
    );
  }
  @override
  void dispose() {
    _cityBloc.dispose();
    super.dispose();
  }
}



