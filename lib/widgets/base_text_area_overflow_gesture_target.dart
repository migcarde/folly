import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class HitTestCanvas extends SingleChildRenderObjectWidget {
  const HitTestCanvas({super.key, required Widget super.child});

  @override
  RenderHitTestCanvas createRenderObject(BuildContext context) {
    return RenderHitTestCanvas();
  }
}

class RenderHitTestCanvas extends RenderProxyBox {
  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    // Normally, this returns false if position is outside 'size'.
    // We bypass that check and hit test all children anyway.
    return hitTestChildren(result, position: position);
  }
}
