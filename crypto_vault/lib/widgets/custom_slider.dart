import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final int divisions;
  final Color activeColor;
  final String label;
  final Function onChanged;

  CustomSlider({
    @required this.value,
    @required this.min,
    @required this.max,
    this.divisions,
    this.activeColor,
    this.label,
    @required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackShape: RoundedRectSliderTrackShape(),
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
        overlayColor: Colors.red.withAlpha(32),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
        tickMarkShape: RoundSliderTickMarkShape(),
        valueIndicatorShape: PaddleSliderValueIndicatorShape(),
      ),
      child: Slider(
        value: this.value,
        min: this.min,
        max: this.max,
        divisions: this.divisions,
        activeColor: this.activeColor,
        label: this.label,
        onChanged: this.onChanged,
      ),
    );
  }
}
