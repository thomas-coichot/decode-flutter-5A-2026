import 'package:flutter/cupertino.dart';

enum DeviceSize {
  xs,
  md,
  lg,
  xl,
  xxl;

  double get maxWidth {
    switch (this) {
      case DeviceSize.xs:
        return 640;
      case DeviceSize.md:
        return 960;
      case DeviceSize.lg:
        return 1280;
      case DeviceSize.xl:
        return 1920;
      case DeviceSize.xxl:
        return 2560;
    }
  }
}

class ResponsiveBox extends StatelessWidget {
  const ResponsiveBox({
    required this.child,
    this.deviceSize,
    this.alignment = .topCenter,
    super.key,
  });

  final DeviceSize? deviceSize;
  final Alignment alignment;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: SizedBox(
        width: deviceSize?.maxWidth,
        child: child,
      ),
    );
  }
}
