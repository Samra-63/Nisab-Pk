import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class AppBox extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final Color color;
  final Border? border;
  final double radius;

  const AppBox({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16.0),
    this.onTap,
    this.color = AppColors.surface,
    this.border,
    this.radius = 16,
  });

  @override
  Widget build(BuildContext context) {
    Widget box = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        border: border ?? Border.all(color: AppColors.surfaceBorder, width: 1),
      ),
      child: child,
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(radius),
          splashColor: AppColors.primary.withOpacity(0.05),
          highlightColor: Colors.transparent,
          child: box,
        ),
      );
    }
    return box;
  }
}
