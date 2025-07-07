import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({
    super.key,
    this.title,
    this.backgroundColor,
    this.surfaceTintColor,
    this.leading,
    this.actions,
    this.bottom,
    this.isIconBack = true,
    this.leadingWidth,
    this.shadowColor,
    this.elevation,
  });

  final Widget? title;
  final Widget? leading;
  final Color? backgroundColor;
  final Color? surfaceTintColor;
  final double? elevation;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final bool? isIconBack;
  final double? leadingWidth;
  final Color? shadowColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.white,
      surfaceTintColor: surfaceTintColor ?? Colors.white,
      elevation: elevation,
      shadowColor: shadowColor,
      leadingWidth: leadingWidth,
      leading: leading,
      automaticallyImplyLeading: isIconBack!,
      title: title,
      centerTitle: true,
      actions: actions,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize {
    final bottomHeight = bottom?.preferredSize.height ?? 0;

    return Size.fromHeight(kToolbarHeight + bottomHeight);
  }
}
