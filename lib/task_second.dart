import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_slider.dart';



class TaskSecondPage extends StatefulWidget {
  const TaskSecondPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TaskSecondPage> createState() => _TaskSecondPageState();
}

class _TaskSecondPageState extends State<TaskSecondPage> with TickerProviderStateMixin {
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
                return CustomSlider(
                  wController: _controller,
                  wNotifier: _notifier,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}