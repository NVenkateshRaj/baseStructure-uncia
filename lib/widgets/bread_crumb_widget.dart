import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:network_issue_handle/constants/colors.dart';
import 'package:network_issue_handle/constants/styles.dart';
import 'package:network_issue_handle/model/bread_crumb_widget_model.dart';

class BreadCrumbWidget extends StatefulWidget{
  final List<BreadCrumbWidgetModel> breadCrumbList;

  const BreadCrumbWidget({super.key, required this.breadCrumbList});

  @override
  State<StatefulWidget> createState() {
   return _BreadCrumbWidget();
  }

}

class _BreadCrumbWidget extends State<BreadCrumbWidget>{
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 52.h,
          color: AppColor.primary,
          width: double.infinity,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.breadCrumbList.length,
              padding: EdgeInsets.only(left: 10.w,right: 10.w),
              itemBuilder: (context,index){
                BreadCrumbWidgetModel breadCrumb = widget.breadCrumbList[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration:  BoxDecoration(
                          border:  breadCrumb.isSelected ? const Border(
                              bottom: BorderSide(color:AppColor.white)) : null
                      ),
                      child: InkWell(
                        onTap: (){
                          selectScreen(index);
                        },
                        child: Text(breadCrumb.title,style: breadCrumb.isSelected ? AppTextStyle.breadCrumbSelect :AppTextStyle.breadCrumbUnSelect,),
                      ),

                    ),
                    index == widget.breadCrumbList.length-1 ? Container() : Padding(
                      padding: EdgeInsets.symmetric(horizontal:4.w),
                      child: Icon(Icons.arrow_forward_ios,size: 16.sp,color: AppColor.white,),
                    )
                  ],
                );
              },
          ),
        ),
        SingleChildScrollView(
          child: getWidget(),
        )
      ],
    );
  }

  selectScreen(int index){
    selectedIndex = index;
   widget.breadCrumbList.map((value){
     value.isSelected = false;
    }).toList();
    widget.breadCrumbList[index].isSelected = true;
    setState(() {});
  }

  getWidget(){
    return widget.breadCrumbList[selectedIndex].child;
    }

}
