import 'package:flutter/material.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/services/weather_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final _cityNameController = TextEditingController();
  final _weatherService = WeatherService();
  WeatherParameters _response = WeatherParameters();



  void _search() async {
    final response = await _weatherService.getWeather(_cityNameController.text);
    setState(() => _response = response);
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

                      // ElevatedButton(
                      //       onPressed: _search,
                      //       child: Text('Search')),
                    ]
                  ),
                  SizedBox(height: 40),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${_response.temperature}°C',
                          style: TextStyle(
                            fontSize: 70,
                            letterSpacing: 3,
                            color: Colors.blue[900]
                          ),
                        ),
                        SizedBox(width: 40),
                        Column(
                          children: [
                            Image.network(generateIconURL(_response.icon)),
                            SizedBox(height: 5),
                            Text(
                              '${_response.description}',
                              style: TextStyle(
                                fontSize: 11,
                              ),
                            )
                          ],
                        )

                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${_response.cityName}',
                        style: TextStyle(
                          color: Colors.indigo[800],
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        ' / ',
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${_response.countyName}',
                        style: TextStyle(
                          color: Colors.blueGrey[600],
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [
                                Text(
                                  'Wind: ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.green[600],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${_response.windSpeed} km/h',
                                  style: TextStyle(
                                    color: Colors.lightBlue[400],
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [
                                Text(
                                  'Sensed: ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.green[600],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${_response.feelsTemp} °C',
                                  style: TextStyle(
                                    color: Colors.lightBlue[400],
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [
                                Text(
                                  'Clouds cover: ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.green[600],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${_response.clouds} %',
                                  style: TextStyle(
                                    color: Colors.lightBlue[400],
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 60),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [
                                Text(
                                  'Air quality index: ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.green[600],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${_response.airQuality}',
                                  style: TextStyle(
                                    color: Colors.lightBlue[400],
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [
                                Text(
                                  'Pressure: ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.green[600],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${_response.pressure} hPa',
                                  style: TextStyle(
                                    color: Colors.lightBlue[400],
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [
                                Text(
                                  'UV index: ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.green[600],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${_response.uv}',
                                  style: TextStyle(
                                    color: Colors.lightBlue[400],
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
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
                      onPressed: () {},
                      icon: Icon(
                        Icons.save_alt_sharp,
                        color: Colors.lightBlue[500],
                      ),
                      label: Text(
                        'Save Location',
                        style: TextStyle(
                          color: Colors.lightBlue[500],
                        ),
                      )
                  ),
                  FlatButton.icon(
                      onPressed: () {
                        dynamic result = Navigator.pushNamed(context, '/locations');
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
