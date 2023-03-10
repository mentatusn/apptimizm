import 'package:apptimizm/widgets/custom_slider_expert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_slider.dart';


class TaskThirdPage extends StatefulWidget {
  const TaskThirdPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TaskThirdPage> createState() => _TaskThirdPageState();
}

class _TaskThirdPageState extends State<TaskThirdPage>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  late final ValueNotifier<OffsetWrapper> _notifier =
  ValueNotifier<OffsetWrapper>(OffsetWrapper());


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<CustomSliderExpert> _sliders = [
      CustomSliderExpert(//1
        wController: _controller,
        wNotifier: _notifier,
        swipeMap: SwipeMap(
          swipeDirections: {
            SwipeDirection.left: {SwipeDirection.center},//proof
            SwipeDirection.center: {SwipeDirection.left}, //proof
           // SwipeDirection.center: {SwipeDirection.right},//-
            //SwipeDirection.right: {SwipeDirection.center},//-
          },
        ),
      ), CustomSliderExpert(//2
        wController: _controller,
        wNotifier: _notifier,
        swipeMap: SwipeMap(
          swipeDirections: {
            SwipeDirection.left: {SwipeDirection.center}, //proof
            SwipeDirection.center: {SwipeDirection.left},//proof
           // SwipeDirection.center: {SwipeDirection.right},//-
            //SwipeDirection.right: {SwipeDirection.center},//-
          },
        ),
      ), CustomSliderExpert(//3
        wController: _controller,
        wNotifier: _notifier,
        swipeMap: SwipeMap(
          swipeDirections: {
            SwipeDirection.left: {SwipeDirection.center},//proof
            SwipeDirection.center: {SwipeDirection.left},//proof
           // SwipeDirection.center: {SwipeDirection.right},//-
           // SwipeDirection.right: {SwipeDirection.center},//-
          },
        ),
      ), CustomSliderExpert(//4
        wController: _controller,
        wNotifier: _notifier,
        swipeMap: SwipeMap(
          swipeDirections: {
            SwipeDirection.left: {SwipeDirection.center},//proof
            SwipeDirection.center: {SwipeDirection.left},//proof
          //  SwipeDirection.center: {SwipeDirection.right},//-
            SwipeDirection.right: {SwipeDirection.center},//не пруф, но пускай будет
          },
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemCount: 4,
              itemBuilder: (_, index) {
                return _sliders[index];
              },
            ),
          ],
        ),
      ),
    );
  }
}