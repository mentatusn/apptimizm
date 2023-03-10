import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    List<CustomSlider> _sliders = [
      CustomSlider(
        left: 0,
      ),
      CustomSlider(
        right: 0,
      ),
      CustomSlider(),
      CustomSlider(
        wController: _controller,
        wNotifier: _notifier,
      ),
      CustomSlider(
        wController: _controller,
        wNotifier: _notifier,
      )
    ];

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
                0: Text('№ 1.1'),
                1: Text('№ 1.2'),
                2: Text('№ 1.3'),
                3: Text('№ 2'),
                4: Text('№ 3'),
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
                print(
                    "_selectedIndex ${_selectedIndex} ${_sliders[_selectedIndex].wNotifier?.value.currentX}");
                return _sliders[_selectedIndex];
              },
            ),
          ],
        ),
      ),
    );
  }
}
