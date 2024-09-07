import 'package:flutter/widgets.dart';
import 'package:tasteclip/config/app_assets.dart';

class AppBackground extends StatelessWidget {
  final Widget child;
  final bool isLight;
  final bool isDark;
  final bool isDefault;

  const AppBackground({
    super.key,
    required this.child,
    this.isLight = false,
    this.isDark = false,
    this.isDefault = true,
  });

  @override
  Widget build(BuildContext context) {
    String backgroundImage = '';

    if (isLight) {
      backgroundImage = AppAssets.lightBg;
    } else if (isDark) {
      backgroundImage = AppAssets.darkBg;
    }

    return DecoratedBox(
      position: DecorationPosition.background,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(backgroundImage),
        ),
      ),
      child: child,
    );
  }
}
