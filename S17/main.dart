
class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Bazaar"),
        ),
        body: Container(
          //color: Colors.lightBlueAccent,
          height: 200.0,
          width: MediaQuery.of(context).size.width,
          child: ClipPath(
            clipper: WaveClipper(),
            child: Container(
              color: Colors.blueAccent,
              child: Center(child: Text("Hello"),),
            ),
          ),
        ));
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    final paint = Paint()
        ..strokeWidth = 8.0
        ..color = Colors.blueAccent
        ..style = PaintingStyle.fill;

    var path = Path();
    path.lineTo(0.0, size.height);
    var first_controller = Offset(size.width*0.25, size.height);
    var first_end = Offset(size.width*0.5, size.height-50.0);
    path.quadraticBezierTo(first_controller.dx, first_controller.dy,
        first_end.dx , first_end.dy);

    
    var secon_controll = Offset(size.width*0.75, size.height-100);
    var second_end = Offset(size.width, size.height-50);
    path.quadraticBezierTo(secon_controll.dx, secon_controll.dy, second_end.dx, second_end.dy);
  path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}

class MyPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    final paint = Paint()
      ..strokeWidth = 8.0
      ..color = Colors.redAccent
      ..style = PaintingStyle.stroke;

    /*
    example #1
     */
    // canvas.drawLine(
    //     Offset(size.width*0.2, size.height*0.5),
    //     Offset(size.width*0.8, size.height*0.9),
    //     paint);

    /*
    example #2
     */

    // final rect = Rect.fromPoints(
    //     Offset(size.width*0.25,size.height*0.25),
    //     Offset(size.width*0.75,size.height*0.75));
    //
    // canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(15.0)), paint);
    // canvas.drawRect(rect, paint);

    /*
    example #3
     */
    //   canvas.drawCircle(Offset(size.width/2,size.height/2), 100.0, paint);

    /*
    example 4
     */

    final arc = Path();
    arc.moveTo(size.width * 0.2, size.height * 0.2);
    arc.arcToPoint(Offset(size.width * 0.5, size.height * 0.3),
        radius: Radius.circular(200));

    arc.moveTo(size.width * 0.5, size.height * 0.3);
    arc.arcToPoint(Offset(size.width * 0.8, size.height * 0.2),
        radius: Radius.circular(200));
    canvas.drawPath(arc, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
