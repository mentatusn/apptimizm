import 'package:flutter/material.dart';

class SwipeableContainer extends StatefulWidget {
  final Widget child;
  final bool swipeEnabled;

  const SwipeableContainer({
    Key? key,
    required this.child,
    this.swipeEnabled = true,
  }) : super(key: key);

  @override
  _SwipeableContainerState createState() => _SwipeableContainerState();
}

class _SwipeableContainerState extends State<SwipeableContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  bool _swipeRightEnabled = true;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _animation = Tween<Offset>(
      begin: Offset(-0.5, 0.0),
      end: Offset(0.5, 0.0),
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    //print("APPTIMIZM2 ${details}");
    print("APPTIMIZM2 ${details.delta.dx}");
    if (widget.swipeEnabled) {
       if(details.delta.dx>0){
         _animationController.forward();
       } else {
         _animationController.reverse();
       }
      //_animationController.value -= details.primaryDelta! / context.size!.width;
    }
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    print("APPTIMIZM2 DragEnd ${details}");
   /* if (widget.swipeEnabled) {
      if (_animationController.value > 0.5) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }*/
  }
  void _onHorizontalDragStart(DragStartDetails details) {
    print("APPTIMIZM2 DragStart ${details}");
    /*if (widget.swipeEnabled) {
      if (_animationController.value > 0.5) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      onHorizontalDragStart: _onHorizontalDragStart,
      child: SlideTransition(
        position: _animation,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32.0),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}