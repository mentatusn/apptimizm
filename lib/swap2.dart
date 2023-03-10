import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  double _dx = 0.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  var beginOffset = Offset(0.0, 0.0);
  var endOffset = Offset(0.0, 0.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        print("APPTIMIZM2 dx ${details.delta.dx}");
        print("APPTIMIZM2 _dx ${_dx}");
        setState(() {
          _dx += details.delta.dx;
        });
      },
      onHorizontalDragEnd: (details) {
        print("APPTIMIZM2 details ${details}");
        _animationController.reset();
        if (_dx > 50) {
          print("APPTIMIZM2 onHorizontalDragEnd rigth");
          beginOffset = endOffset;
          endOffset = Offset(0.3, 0.0);
        } else if (_dx < -50) {
          print("APPTIMIZM2 onHorizontalDragEnd left");
          beginOffset = endOffset;
          endOffset = Offset(-0.3, 0.0);
        } else {
          print("APPTIMIZM2 onHorizontalDragEnd center");
          beginOffset = endOffset;
          endOffset = Offset(0.0, 0.0);
        }
        _animationController.forward();
        _dx = 0.0;
      },
      child: Container(
        width: double.infinity,
        height: 200,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: beginOffset,
            end: endOffset,
          ).animate(_animationController),
          child: Container(
            width: double.infinity,
            height: 200,
            color: Colors.red,
            margin: EdgeInsets.symmetric(horizontal: 32.0),
          ),
        ),
      ),
    );
  }
}
