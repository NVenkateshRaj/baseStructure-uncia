import 'package:flutter/material.dart';

class CommonDivider extends StatelessWidget{
  final Color? dividerColor;

  const CommonDivider({super.key, required this.dividerColor});
  @override
  Widget build(BuildContext context) {
    return  Divider(color: dividerColor ?? Colors.black);
  }

}