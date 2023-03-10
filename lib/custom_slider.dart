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
    this.wController,
    this.wNotifier,
    this.left = -100.0,
    this.center = 0.0,
    this.right = 100.0,
    this.title = 'Поскроль меня вправо или влево',
    Key? key,
  });

  final AnimationController? wController;
  ValueNotifier<OffsetWrapper>? wNotifier;
  final double left;
  final double center;
  final double right;
  final String title;

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider>
    with SingleTickerProviderStateMixin {
  late OffsetWrapper _value;
  late double _dx_memory;
  late ValueNotifier<OffsetWrapper> notifier;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    notifier = (widget.wNotifier != null)
        ? (widget.wNotifier!)
        : ValueNotifier<OffsetWrapper>(OffsetWrapper());
    controller = (widget.wController != null)
        ? (widget.wController!)
        : AnimationController(
            duration: const Duration(milliseconds: 300),
            vsync: this,
          );
    _value = notifier.value;
    _dx_memory = widget.center;
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    notifier.dispose();
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
              notifier.value.currentX = _dx_memory;
              notifier.value.isDragged = true;
              notifier.notifyListeners();
            });
          }
        }
      },
      onHorizontalDragEnd: (details) {
        controller.reset();
        if ((_value.currentX ) > widget.right / 2) {
          _value.endOffset = widget.right;
        } else if (_value.currentX< widget.left / 2) {
          _value.endOffset = widget.left;
        } else {
          _value.endOffset = widget.center;
        }
        _value.beginOffset = _value.currentX;
        _value.isDragged = false;
        controller.forward();
        notifier.value = _value;
        _dx_memory = _value.endOffset;
        notifier.notifyListeners();
      },
      child: Container(
        height: 80,
        width: 500,
        alignment: Alignment.center,
        child: ValueListenableBuilder<OffsetWrapper>(
          valueListenable: notifier,
          builder: (context, value, child) {
            return Stack(
              children: [
                AnimatedBuilder(
                  animation: controller,
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
                                      parent: controller,
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
                                  parent: controller,
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
                          widget.title,
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
