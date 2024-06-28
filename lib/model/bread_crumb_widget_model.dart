import 'package:flutter/material.dart';

class BreadCrumbWidgetModel{
  final String title;
  final Widget child;
  bool isSelected;
  BreadCrumbWidgetModel({required this.title, required this.child,required this.isSelected});
}

/*


Class DropDownModel{
int id;
String value;
}


DropdownWidget<DropDownModel>{
}

SlautationTypeModel{
String value;
int id;
}
List<DropDownModel> dropdownModel;
for(int i=0;i<SlautationTypeModel.l;i++){

 */