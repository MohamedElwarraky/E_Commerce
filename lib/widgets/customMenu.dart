import 'package:flutter/material.dart';

class CustomPopUpMenuItem<T> extends PopupMenuItem<T> {
  final Widget child;
  final Function onClick;

  CustomPopUpMenuItem({@required this.child, @required this.onClick})
      : super(child: child);

  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    return CustomPopUpMenuItemState();
  }
}

class CustomPopUpMenuItemState<T, PopMenuItem>
    extends PopupMenuItemState<T, CustomPopUpMenuItem<T>> {
  @override
  void handleTap() {
    widget.onClick();
  }
}