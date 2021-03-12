import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'package:crypto_vault/constants.dart';

class CustomTabIndicator extends Decoration {
  @override
  _CustomPainter createBoxPainter([VoidCallback onChanged]) {
    return new _CustomPainter(this, onChanged);
  }
}

class _CustomPainter extends BoxPainter {
  final CustomTabIndicator decoration;

  _CustomPainter(this.decoration, VoidCallback onChanged)
      : assert(decoration != null),
        super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);

    // offset is the position from where the decoration should be drawn.
    // configuration.size tells us about the height and width of the tab.
    final Rect rect = Offset(offset.dx + 6, (configuration.size.height/2) - 46/2) & Size(configuration.size.width - 12, 46);
    final Paint paint = Paint();
    paint.color = backgroundColorLight;
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(14.0)),
      paint,
    );
  }
}
