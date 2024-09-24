import 'package:flutter/material.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData? actionIcon;
  final VoidCallback? onActionPressed;
  final bool showBackArrow;

  const BasicAppBar({
    super.key,
    required this.title,
    this.actionIcon,
    this.onActionPressed,
    this.showBackArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: showBackArrow,
      title: Text(title),
      actions: actionIcon != null
          ? [
              IconButton(
                icon: Icon(actionIcon),
                onPressed: onActionPressed,
              ),
            ]
          : [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
