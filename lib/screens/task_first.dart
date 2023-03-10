import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_slider.dart';



class TaskFirstPage extends StatefulWidget {
  const TaskFirstPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TaskFirstPage> createState() => _TaskFirstPageState();
}

class _TaskFirstPageState extends State<TaskFirstPage> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  late final ValueNotifier<OffsetWrapper> _notifier =
  ValueNotifier<OffsetWrapper>(OffsetWrapper());

  int _selectedIndex = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final List<CustomSlider> _sliders = [
    CustomSlider(
      left: 0,
      title: 'Поскроль меня вправо',
    ),
    CustomSlider(
      right: 0,
      title: 'Поскроль меня влево',
    ),
    CustomSlider(),
  ];

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
            CupertinoSlidingSegmentedControl<int>(
              children: {
                0: Text('вправо'),
                1: Text('влево'),
                2: Text('вправо и влево'),
              },
              groupValue: _selectedIndex,
              onValueChanged: (value) {
                setState(() {
                  _selectedIndex = value ?? 0;
                });
              },
            ),
            SizedBox(height: 20),
            ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemCount: 4,
              itemBuilder: (_, index) {
                return _sliders[_selectedIndex];
              },
            ),
          ],
        ),
      ),
    );
  }
}