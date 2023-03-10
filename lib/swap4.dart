import 'package:flutter/material.dart';

const left = -150.0;
const center = 0.0;
const right = 150.0;


class OffsetWrapper {
  double currentX;
  double beginOffset;
  double endOffset;
  bool isDragged;
  OffsetWrapper({required this.currentX, required this.beginOffset, required this.endOffset, required this.isDragged});
}
class CustomSlider extends StatefulWidget {
  CustomSlider({required this.controller, required this.notifier, Key? key});

  AnimationController controller;
  final ValueNotifier<OffsetWrapper> notifier;

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider>
    with SingleTickerProviderStateMixin {

  late OffsetWrapper _value;

  @override
  void initState() {
    super.initState();
    print("_handleControllerValueChanged initState ");
    _value = widget.notifier.value;
    widget.notifier.addListener(_handleControllerValueChanged);
  }

  void _handleControllerValueChanged() {
    print("_handleControllerValueChanged ${this} ${widget.notifier.value} ");
    setState(() {
      _value = widget.notifier.value;
    });
  }


  double _dx_memory = center;
  //double _dx = center;

  @override
  void dispose() {
    widget.notifier.removeListener(_handleControllerValueChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    print("!widget.controller.isAnimating ${widget.controller.isAnimating}");
    print("!widget.controller.isAnimating ${_value.currentX} ${_value.beginOffset} ${_value.endOffset} ${_value.isDragged}");

    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        //print("APPTIMIZM2 primaryDelta ${details.primaryDelta}");
        //print("APPTIMIZM2 primaryDelta ${details.globalPosition}");

        _dx_memory += details.delta.dx;
        if ((_dx_memory - _value.currentX).abs() > 1.5) {
          //print("APPTIMIZM2 _dx_memory ${_dx_memory}");
          //print("APPTIMIZM2 _dx ${_dx}");
          setState(() {
            //_value.currentX = _dx_memory;
            print("_handleControllerValueChanged setState1 ${widget.notifier.value.currentX}");
            _value.currentX = _dx_memory;
            widget.notifier.value = OffsetWrapper(currentX:_value.currentX,beginOffset:_value.beginOffset,endOffset:_value.endOffset,isDragged:  true);
            print("_handleControllerValueChanged setState2 ${widget.notifier.value.currentX}");
            //print("APPTIMIZM2 dx ${_dx}");
          });

        }
        /*widget.controller.forward();

        if ((_dx) > right) {
          //print("APPTIMIZM2 onHorizontalDragEnd rigth");
          beginOffset = endOffset;
          endOffset = right;
          _dx = right;
        } else if (_dx < left) {
          //print("APPTIMIZM2 onHorizontalDragEnd left");
          beginOffset = endOffset;
          endOffset = left;
          _dx = left;
        } else {
          //print("APPTIMIZM2 onHorizontalDragEnd center");
          beginOffset = endOffset;
          endOffset = center;
          //_dx = center;
        }*/
      },
      onHorizontalDragEnd: (details) {

        print("APPTIMIZM2 details ${details.velocity}");

        widget.controller.reset();
        if ((_value.currentX + details.velocity.pixelsPerSecond.dx / 20) > right / 2) {
          //print("APPTIMIZM2 onHorizontalDragEnd rigth");
          _value.endOffset = right;
        } else if (_value.currentX + details.velocity.pixelsPerSecond.dx / 20 < left / 2) {
          //print("APPTIMIZM2 onHorizontalDragEnd left");
          _value.endOffset = left;
        } else {
          //print("APPTIMIZM2 onHorizontalDragEnd center");
          _value.endOffset = center;
        }
        _value.beginOffset = _value.currentX;
        OffsetWrapper(currentX:_value.currentX,beginOffset:_value.beginOffset,endOffset:_value.endOffset,isDragged:false);
        print("APPTIMIZM2 beginOffset ${widget.notifier.value.beginOffset}");
        print("APPTIMIZM2 endOffset ${widget.notifier.value.endOffset}");
        widget.controller.forward();
        widget.notifier.value = OffsetWrapper(currentX:_value.currentX,beginOffset:_value.beginOffset,endOffset:_value.endOffset,isDragged: false);
      },
      child: Container(
        height: 80,
        width: 500,
        alignment: Alignment.center,
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: widget.controller,
              builder: (BuildContext context, Widget? child) {
                return Positioned(
                  top: 0,
                  bottom: 0,
                  right: -1 *
                      //((_value.currentX != 0)
                      //((!widget.controller.isAnimating)
                         // ((false)
                          ((_value.isDragged)
                          ? (_value.currentX)
                          : (Tween<double>(
                              begin: _value.beginOffset,
                              end: _value.endOffset,
                            ).animate(widget.controller).value)),
                 // left: (_value.currentX != 0)
                      //left: (false)
                      left: (_value.isDragged)
                      //left: (!widget.controller.isAnimating)
                      ? (_value.currentX)
                      : (Tween<double>(
                          begin: _value.beginOffset,
                          end: _value.endOffset,
                        ).animate(widget.controller).value),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.red,
                    margin: EdgeInsets.symmetric(horizontal: 40.0),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
