import 'package:flutter/material.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/services/weather_model.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  final _cityNameController = TextEditingController();
  final _weatherService = WeatherService();

  void _search() async {
    final response = await _weatherService.getWeather(_cityNameController.text);
    Map data = _weatherService.toMap(response);
    Navigator.pushReplacementNamed(context, '/home', arguments: data);
  }

  String generateIconURL(String? dataURL){
    String url = 'https:';
    if (dataURL == null) {
      return('');
    }
    url = url + dataURL;
    return url;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          width: 300,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius:  BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(1),
                            child: TextField(
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                              controller: _cityNameController,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(fontSize: 22),
                                hintText: 'City Name',
                                suffixIcon: FlatButton.icon(
                                  onPressed: _search,
                                  icon: Icon(
                                    Icons.search,
                                    color: Colors.lightBlue[500],
                                  ),
                                  label: Text(''),
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                              ),
                            ),
                          ),
                        ),
                      ]
                  ),
                  SizedBox(height: 200),
                  FlatButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.gps_fixed,
                        color: Colors.green[500],
                      ),
                      label: Text(
                        'Find My Location',
                        style: TextStyle(
                          color: Colors.green[500],
                        ),
                      )
                  ),
                  FlatButton.icon(
                      onPressed: () async {
                        // await _weatherService.deleteMyLocations();    // test
                        List<String> locationsAndTemps = await _weatherService.locationsAndTemps();
                        dynamic result = Navigator.pushNamed(context, '/locations', arguments: locationsAndTemps);
                      },
                      icon: Icon(
                        Icons.edit_location,
                        color: Colors.lightBlue[500],
                      ),
                      label: Text(
                        'My Locations',
                        style: TextStyle(
                          color: Colors.lightBlue[500],
                        ),
                      )
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
