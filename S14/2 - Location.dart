
final counterProvider = StateProvider.autoDispose((ref)=>0);

void main(){
  runApp(
      ProviderScope(child: MaterialApp(
        home: MyApp(),
      ))
  );
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

late MapController _controller;



  Future<Position> _getLocation() async{

    bool seriveEnabled;
    LocationPermission permission;
    seriveEnabled = await Geolocator.isLocationServiceEnabled();
    if(!seriveEnabled){
      return Future.error('Location service is disables.');
    }
    permission = await Geolocator.checkPermission();
    if(permission==LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission==LocationPermission.denied){
        return Future.error('Location permission are denied');
      }
    }
    if(permission==LocationPermission.deniedForever){
      return Future.error('Location permission are denied forever');
    }
    var pos = await Geolocator.getCurrentPosition();
    print(pos.longitude);
    return pos;
  }

@override
  void initState() {

    _controller = MapController(
      initMapWithUserPosition: false,
      initPosition: GeoPoint(latitude: 35.7500729,longitude: 51.4349451)
    );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_on_outlined),
        onPressed: ()async{

          var pos = await _getLocation();
          _controller.changeLocation(GeoPoint(latitude: pos.latitude, longitude: pos.longitude));

        },
      ),
      body: OSMFlutter(
        controller: _controller,
        initZoom: 14,
        minZoomLevel: 10,
        maxZoomLevel: 16,
        stepZoom: 1.0,
      )
    );
  }
}


