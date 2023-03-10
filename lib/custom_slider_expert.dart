import 'package:apptimizm/custom_slider.dart';
import 'package:flutter/material.dart';


class SwipeMap {
  final Map<SwipeDirection, Set<SwipeDirection>> swipeDirections;

  SwipeMap({required this.swipeDirections});

  bool canSwipe(SwipeDirection from, SwipeDirection to) {
    return swipeDirections[from]?.contains(to) ?? false;
  }
}

enum SwipeDirection {
  left,
  center,
  right,
}


class CustomSliderExpert extends StatefulWidget {
  CustomSliderExpert({
    required this.wController,
    required this.wNotifier,
    required this.swipeMap,
    this.left = -100.0,
    this.center = 0.0,
    this.right = 100.0,
    this.title = 'Поскроль меня вправо или влево',
    Key? key,
  });

  final AnimationController wController;
  ValueNotifier<OffsetWrapper> wNotifier;
  final double left;
  final double center;
  final double right;
  final String title;
  final SwipeMap swipeMap;

  @override
  _CustomSliderExpertState createState() => _CustomSliderExpertState();
}

class _CustomSliderExpertState extends State<CustomSliderExpert>
    with SingleTickerProviderStateMixin {
  late double _dx_memory;
  late ValueNotifier<OffsetWrapper> notifierLocal;
  late AnimationController controllerLocal;

  @override
  void initState() {
    super.initState();
    notifierLocal = ValueNotifier<OffsetWrapper>(OffsetWrapper());
    controllerLocal = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _dx_memory = widget.center;
    widget.wNotifier.addListener(_handleControllerValueChanged);
  }


  void _handleControllerValueChanged() {
    setState(() {
    //  if(notifierLocal.value.isDragged==false) {
        notifierLocal.value = widget.wNotifier.value;
        print("directiorn3335 ${widget.wController.isAnimating}");
        if(widget.wController.isAnimating){
          controllerLocal.reset();
          controllerLocal.forward();
        }
     // }
    });
  }

  @override
  void dispose() {
    super.dispose();
    notifierLocal.dispose();
    controllerLocal.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //print("!widget.controller.isAnimating ${this} ${_value.currentX} ${_value.beginOffset} ${_value.endOffset} ${_value.isDragged}");




    return GestureDetector(
      onHorizontalDragStart: (details) {
        _dx_memory= notifierLocal.value.endOffset;
      },
      onHorizontalDragUpdate: (details) {
        notifierLocal.value.isDragged=true;
        //_dx_memory += details.delta.dx;
        if (widget.right >= _dx_memory + details.delta.dx &&
            _dx_memory + details.delta.dx >= widget.left) {
          _dx_memory += details.delta.dx;
        }
        print("details.delta.dx ${_dx_memory + details.delta.dx} ");
        if ((_dx_memory - notifierLocal.value.currentX).abs() > 1.5) {
          {
            setState(() {
              notifierLocal.value.currentX = _dx_memory;
              notifierLocal.value.isDragged = true;
              if(details.delta.dx>0){
                if(_dx_memory<=widget.right&&_dx_memory>=widget.center){
                  //из центра вправо
                  if(widget.swipeMap.canSwipe(SwipeDirection.center,SwipeDirection.right)){
                    widget.wNotifier.value = notifierLocal.value;
                    widget.wNotifier.notifyListeners();
                  }
                }else if(_dx_memory<=widget.center&&_dx_memory>=widget.left){
                  //из лево в центр
                  if(widget.swipeMap.canSwipe(SwipeDirection.left,SwipeDirection.center)){
                    widget.wNotifier.value = notifierLocal.value;
                    widget.wNotifier.notifyListeners();
                  }
                }
              }else{
                if(_dx_memory<=widget.right&&_dx_memory>=widget.center){
                  //из вправо в центр
                  if(widget.swipeMap.canSwipe(SwipeDirection.right,SwipeDirection.center)){
                    widget.wNotifier.value = notifierLocal.value;
                    widget.wNotifier.notifyListeners();
                  }
                }else if(_dx_memory<=widget.center&&_dx_memory>=widget.left){
                  //из центра влево
                  if(widget.swipeMap.canSwipe(SwipeDirection.center,SwipeDirection.left)){
                    widget.wNotifier.value = notifierLocal.value;
                    widget.wNotifier.notifyListeners();
                  }
                }
              }


            });
          }
        }
      },
      onHorizontalDragEnd: (details) {
        notifierLocal.value.isDragged=false;
        controllerLocal.reset();
        if ((notifierLocal.value.currentX ) > widget.right / 2) {
          notifierLocal.value.endOffset = widget.right;
        } else if (notifierLocal.value.currentX  < widget.left / 2) {
          notifierLocal.value.endOffset = widget.left;
        } else {
          notifierLocal.value.endOffset = widget.center;
        }
        notifierLocal.value.beginOffset = notifierLocal.value.currentX;
        notifierLocal.value.isDragged=false;

        controllerLocal.forward();
        //notifier.value = _value;
        _dx_memory = notifierLocal.value.endOffset;
        //notifier.notifyListeners();

        print("directiorn3331  ${notifierLocal.value.beginOffset} ${notifierLocal.value.endOffset}");
          if(notifierLocal.value.beginOffset>=widget.center&&notifierLocal.value.endOffset==widget.right){
            //из центра вправо
            print("directiorn3332 //из центра вправо");
            if(widget.swipeMap.canSwipe(SwipeDirection.center,SwipeDirection.right)){
              widget.wController.reset();
              widget.wController.forward();
              widget.wNotifier.value = notifierLocal.value;
              widget.wNotifier.notifyListeners();
            }
          } else if(notifierLocal.value.beginOffset>=widget.left&&notifierLocal.value.endOffset==widget.center&&notifierLocal.value.beginOffset<0){
            //из луво вцентр
            print("directiorn3332  //из луво вцентр");
            if(widget.swipeMap.canSwipe(SwipeDirection.left,SwipeDirection.center)){
              widget.wController.reset();
              widget.wController.forward();
              widget.wNotifier.value = notifierLocal.value;
              widget.wNotifier.notifyListeners();
            }
          }else if(notifierLocal.value.beginOffset<=widget.center&&notifierLocal.value.endOffset==widget.left){
            //из центра влево
            print("directiorn3332 //из центра влево");
            if(widget.swipeMap.canSwipe(SwipeDirection.center,SwipeDirection.left)){
              widget.wController.reset();
              widget.wController.forward();
              widget.wNotifier.value = notifierLocal.value;
              widget.wNotifier.notifyListeners();
            }
          }else if(notifierLocal.value.beginOffset<=widget.right&&notifierLocal.value.endOffset==widget.center){
            //из центра влево
            print("directiorn3332 //из права вцентр");
            if(widget.swipeMap.canSwipe(SwipeDirection.right,SwipeDirection.center)){
              widget.wController.reset();
              widget.wController.forward();
              widget.wNotifier.value = notifierLocal.value;
              widget.wNotifier.notifyListeners();
            }
          }
      },
      child: Container(
        height: 80,
        width: 500,
        alignment: Alignment.center,
        child: ValueListenableBuilder<OffsetWrapper>(
          valueListenable: notifierLocal,
          builder: (context, value, child) {
            return Stack(
              children: [
                AnimatedBuilder(
                  animation: controllerLocal,
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
                                      parent: controllerLocal,
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
                                  parent: controllerLocal,
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
