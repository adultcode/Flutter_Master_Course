class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

late MapZoomPanBehavior _zoomPan;
late MapLatLng _markerPosition;
late MapTileLayerController _controller;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _zoomPan = MapZoomPanBehavior();

    _controller = MapTileLayerController();

    _zoomPan.enableMouseWheelZooming=true;
    _zoomPan.enableDoubleTapZooming=true;
  }

  void updateMarker(Offset position){

  _markerPosition = _controller.pixelToLatLng(position);
  print(_markerPosition.latitude);
  print(_markerPosition.longitude);

  if(_controller.markersCount>0){
    _controller.clearMarkers();
  }
  _controller.insertMarker(0);


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_on_outlined),
        onPressed: (){
          _zoomPan.zoomLevel = 14.0;
        },
      ),
      body: GestureDetector(
        onTapUp: (TapUpDetails details){

          updateMarker(details.localPosition);
        },
        child: SfMaps(
          layers: [
            MapTileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              zoomPanBehavior: _zoomPan,
              initialZoomLevel: 10,
              controller: _controller,
              initialFocalLatLng: MapLatLng(35.7500729,51.4349451),
              markerBuilder: (context,index){
                return MapMarker(
                  latitude: _markerPosition.latitude,
                  longitude: _markerPosition.longitude,
                  child: Icon(Icons.location_on,color: Colors.red,),
                );
              },
            )
          ],
        ),
      )
    );
  }
}



