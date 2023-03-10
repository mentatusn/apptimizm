import 'package:flutter/material.dart';

class CustomSlider2 extends StatefulWidget {
  final ValueNotifier<double> controller;

  CustomSlider2({required this.controller});

  @override
  _CustomSlider2State createState() => _CustomSlider2State();
}

class _CustomSlider2State extends State<CustomSlider2> {
  late double _value;

  @override
  void initState() {
    super.initState();
    _value = widget.controller.value;
    widget.controller.addListener(_handleControllerValueChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleControllerValueChanged);
    super.dispose();
  }

  void _handleControllerValueChanged() {
    setState(() {
      _value = widget.controller.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: _value,
      onChanged: (newValue) {
        widget.controller.value = newValue;
      },
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late ValueNotifier<double> _controller;
  late List<CustomSlider2> _sliders;

  @override
  void initState() {
    super.initState();
    _controller = ValueNotifier<double>(0.0);
    _sliders = List.generate(
      3,
          (_) => CustomSlider2(controller: _controller),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _sliders,
    );
  }
}