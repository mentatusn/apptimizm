import 'package:flutter/material.dart';

class OffsetWrapper {
  double currentX;
  double beginOffset;
  double endOffset;
  bool isDragged;

  OffsetWrapper({
    this.currentX = 0.0,
    this.beginOffset = 0.0,
    this.endOffset = 0.0,
    this.isDragged = false,
  });
}

class CustomSlider extends StatefulWidget {
  CustomSlider({
    required this.controller,
    required this.notifier,
    this.left = -100.0,
    this.center = 0.0,
    this.right = 100.0,
    Key? key,
  });

  final AnimationController controller;
  final ValueNotifier<OffsetWrapper> notifier;
  final double left;
  final double center;
  final double right;

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider>
    with SingleTickerProviderStateMixin {
  late OffsetWrapper _value;
  late double _dx_memory;

  @override
  void initState() {
    super.initState();
    _value = widget.notifier.value;
    _dx_memory = widget.center;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(
        "!widget.controller.isAnimating ${this} ${_value.currentX} ${_value.beginOffset} ${_value.endOffset} ${_value.isDragged}");

    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        //_dx_memory += details.delta.dx;
        if (widget.right >= _dx_memory + details.delta.dx &&
            _dx_memory + details.delta.dx >= widget.left) {
          _dx_memory += details.delta.dx;
        }
        print("details.delta.dx ${_dx_memory + details.delta.dx} ");
        if ((_dx_memory - _value.currentX).abs() > 1.5) {
          {
            setState(() {
              widget.notifier.value.currentX = _dx_memory;
              widget.notifier.value.isDragged = true;
              widget.notifier.notifyListeners();
            });
          }
        }
      },
      onHorizontalDragEnd: (details) {
        widget.controller.reset();
        if ((_value.currentX + details.velocity.pixelsPerSecond.dx / 20) >
            widget.right / 2) {
          _value.endOffset = widget.right;
        } else if (_value.currentX + details.velocity.pixelsPerSecond.dx / 20 <
            widget.left / 2) {
          _value.endOffset = widget.left;
        } else {
          _value.endOffset = widget.center;
        }
        _value.beginOffset = _value.currentX;
        _value.isDragged = false;
        widget.controller.forward();
        widget.notifier.value = _value;
        _dx_memory = _value.endOffset;
        widget.notifier.notifyListeners();
      },
      child: Container(
        height: 80,
        width: 500,
        alignment: Alignment.center,
        child: ValueListenableBuilder<OffsetWrapper>(
          valueListenable: widget.notifier,
          builder: (context, value, child) {
            return Stack(
              children: [
                AnimatedBuilder(
                  animation: widget.controller,
                  builder: (BuildContext context, Widget? child) {
                    return Positioned(
                      top: 0,
                      bottom: 0,
                      right: -1 *
                          (value.isDragged
                              ? value.currentX
                              : Tween<double>(
                                  begin: value.isDragged
                                      ? value.currentX
                                      : value.beginOffset,
                                  end: value.endOffset,
                                )
                                  .animate(CurvedAnimation(
                                      parent: widget.controller,
                                      curve: Curves.easeOutBack))
                                  .value),
                      left: value.isDragged
                          ? value.currentX
                          : Tween<double>(
                              begin: value.isDragged
                                  ? value.currentX
                                  : value.beginOffset,
                              end: value.endOffset,
                            )
                              .animate(CurvedAnimation(
                                  parent: widget.controller,
                                  curve: Curves.easeOutBack))
                              .value,
                      child: Container(
                        width: 200,
                        height: 50,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 24.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            width: 2,
                            color: Colors.green,
                          ),
                        ),
                        child: Text(
                          'Поскроль меня вправо или влево',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
