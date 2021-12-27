import 'package:flutter/material.dart';
import 'package:weather_app/services/weather_service.dart';

class Locations extends StatefulWidget {
  const Locations({Key? key}) : super(key: key);

  @override
  _LocationsState createState() => _LocationsState();
}

class _LocationsState extends State<Locations> {

  final _weatherService = WeatherService();

  List<String> locationsAndTemps = [];
  List<String> locations = ['Bialystok'];
  List<String> temperatures = ['-9'];


  void goHome(index) async {
    final response = await _weatherService.getWeather(locations[index]);
    Map data = _weatherService.toMap(response);
    Navigator.pushReplacementNamed(context, '/home', arguments: data);
  }



  @override
  Widget build(BuildContext context)  {
    locationsAndTemps = ModalRoute.of(context)!.settings.arguments as List<String>;
    int listLength = ((locationsAndTemps.length)/2).floor();
    locations = List.filled(listLength, '');
    temperatures = List.filled(listLength, '');
    for(int i = 0; i < listLength; i++){
      locations[i] = locationsAndTemps[i];
      temperatures[i] = locationsAndTemps[i + listLength];
    }
    print(locations);
    print(temperatures);



    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: Text('Locations'),
        centerTitle: true,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () async {
              await _weatherService.deleteMyLocations();
              List<String> newLocationsList = await _weatherService.locationsList();
              Navigator.pushReplacementNamed(context, '/');
            },
          )
        ],
      ),
      body: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
              child: Card(
                child: ListTile(
                  onTap: () => goHome(index),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(80, 0, 0, 0),
                        child: Text(
                          locations[index],
                          style: TextStyle(
                            color: Colors.lightBlue[800],
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 80, 0),
                        child: Text(
                          '${temperatures[index]} °C',
                          style: TextStyle(
                            color: Colors.lightGreen[700],
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}
