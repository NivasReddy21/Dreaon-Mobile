import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../global_widgets/badge.dart';

import '../global_widgets/animations/bounce.dart';
import '../global_widgets/animations/fade_in.dart';
import 'package:flutter/widgets.dart';

extension AnimatedWidgetExtension on Widget {
  fadeIn(double delay) {
    return FadeIn(delay, this);
  }

  bounce() {
    return Bounce(this);
  }

  fadeInList(int index, bool isVerical) {
    double offset = 50.0;
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 500),
      child: SlideAnimation(
        horizontalOffset: isVerical ? 0.0 : offset,
        verticalOffset: !isVerical ? 0.0 : offset,
        child: FadeInAnimation(
          child: this,
        ),
      ),
    );
  }
}

extension ContainerExtension on Widget {
  badge(int value) {
    return Badge(child: this, value: value);
  }
}

extension StringExtension on String {
  String get firstName {
    if (this.isEmpty) {
      return this;
    } else {
      var arr = this.split(" ");
      return arr.length != 0 ? arr[0] : this;
    }
  }
}
