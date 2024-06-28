import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:network_issue_handle/model/bread_crumb_widget_model.dart';
import 'package:network_issue_handle/widgets/common_appbar.dart';
import 'package:network_issue_handle/widgets/common_text_field.dart';

class DashboardScreen extends StatefulWidget{
  const DashboardScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DashboardState();
  }
}


class _DashboardState extends State<DashboardScreen>{

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController decimalController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<String> searchList = ["Abc","DEF","Ghi","jkl"];
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  String? selectedValue;

  void _submit() {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKey.currentState!.save();
  }

  List<BreadCrumbWidgetModel> breadCrumbWidgetList = [
    BreadCrumbWidgetModel(title: "Income Details",child:const Center(child: Text("Income Details"),),isSelected: true),
    BreadCrumbWidgetModel(title: "Bureau",child:const Center(child:  Text("Bureau"),),isSelected: false),
    BreadCrumbWidgetModel(title: "Step 5",child:const Center(child:  Text("Step 5"),),isSelected: false),
    BreadCrumbWidgetModel(title: "Step 6",child:const Center(child:  Text("Step 6"),),isSelected: false),
    BreadCrumbWidgetModel(title: "Step 7",child:const Center(child:  Text("Step 7"),),isSelected: false),
  ];


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const CommonAppbar(),
      body: Column(
        children: [
          CommonTextField(
              textFieldTitle: "Enter Name",
              controller: nameController,
              hintText: "Enter Name",
              onChanged: (val){},
              onSubmitted: (val){}
          ),
          SizedBox(height: 20.h,),
          CommonTextField(
              textFieldTitle: "Enter Name",
              controller: nameController,
              hintText: "Enter Name",
              onChanged: (val){},
              onSubmitted: (val){},
            isSearchField: true,
            suggestions: searchList,
          ),
          SizedBox(height: 20.h,),
        ],
      ),
    );
  }
}