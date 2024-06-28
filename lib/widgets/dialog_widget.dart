import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:network_issue_handle/constants/colors.dart';
import 'package:network_issue_handle/constants/styles.dart';
import 'package:network_issue_handle/locator.dart';
import 'package:network_issue_handle/model/dialog_model_service/alert_request.dart';
import 'package:network_issue_handle/model/dialog_model_service/alert_response.dart';
import 'package:network_issue_handle/service/common_service/dialog_service.dart';


class DialogWidget extends StatefulWidget {
  final Widget child;
  const DialogWidget({super.key,  required this.child});

  @override
  State<StatefulWidget> createState() {
    return _DialogWidgetState();
  }
}

class _DialogWidgetState extends State<DialogWidget> {
  final _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showInfoDialog, _showCustomAlertDialog, _showConfirmationDialog,_bottomSheet,);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: widget.child
        ),

      ],
    );
  }

  void _showInfoDialog(AlertRequest request) {
    showDialog(
        context: context,
        barrierDismissible: request.dismissable,
        builder: (context) {
          return PopScope(
              onPopInvoked: (value){
                _dialogService.dialogComplete(AlertResponse(status: false));
              },
              child: AlertDialog(
                backgroundColor: Colors.white,
                title: Text(
                  request.title ?? '',
                  style: AppTextStyle.titleMedium,
                ),
                content: Text(request.description ?? '', style: AppTextStyle.subtitleRegular),
                actions: <Widget>[
                  MaterialButton(
                    child: Text(
                      request.buttonTitle  ?? '',
                      style: AppTextStyle.button,
                    ),
                    onPressed: () {
                      _dialogService.dialogComplete(AlertResponse(status: true));
                    },
                  ),
                ],
              ));
        }
        );
  }

  void _showConfirmationDialog(AlertRequest request) {
    showDialog(
        context: context,
        barrierDismissible: request.dismissable,
        builder: (context) {
          return PopScope(
              onPopInvoked: (value){
                _dialogService.dialogComplete(AlertResponse(status: false));
              },
              child: AlertDialog(
                title: Text(
                  request.title  ?? '',
                  style: AppTextStyle.titleMedium,
                ),
                content: Text(request.description  ?? '', style: AppTextStyle.subtitleRegular),
                actions: <Widget>[

                  if (request.secondaryButtonTitle != null) MaterialButton(
                    child: Text(
                      request.secondaryButtonTitle  ?? '',
                      style: AppTextStyle.button,
                    ),
                    onPressed: () {
                      _dialogService.dialogComplete(AlertResponse(status: false));
                    },
                  ),

                  MaterialButton(
                    child: Text(
                      request.buttonTitle  ?? '',
                      style: AppTextStyle.button,
                    ),
                    onPressed: () {
                      _dialogService.dialogComplete(AlertResponse(status: true));
                    },
                  ),

                ],
              ));
        });
  }

  void _showCustomAlertDialog(AlertRequest request) {
    showDialog(context: context,
        builder: (context){
          return PopScope(
            onPopInvoked: (value){
              _dialogService.dialogComplete(AlertResponse(status: false));
            },
            child: AlertDialog(
              contentPadding: const EdgeInsets.all(20),
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24.0))),
              content: SizedBox(
                height: 340.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    //Image.asset(Images.appLogo, width: 100, height: 100,),



                    Text(request.title  ?? '', style: AppTextStyle.headerMedium,textScaler: const TextScaler.linear(1),),



                    Text(request.description  ?? '', textAlign: TextAlign.center, textScaler: const TextScaler.linear(1), style: AppTextStyle.subtitleRegular,),


                    ///Need to write a common button for this widget
                    // Button(request.buttonTitle ?? '', width: double.infinity, key: Key('btnPrimary'), onPressed: (){
                    //   _dialogService.dialogComplete(AlertResponse(status: true));
                    //   request.onTap!();
                    // }),

                    request.secondaryButtonTitle != null ? MaterialButton(onPressed: (){
                      _dialogService.dialogComplete(AlertResponse(status: false));
                    }, child: Text(request.secondaryButtonTitle ?? '', textScaler: const TextScaler.linear(1), style: AppTextStyle.button.copyWith(color: AppColor.primary),)) : Container()

                  ],
                ),
              ),
            ),
          );
        }
    );
  }

  void _bottomSheet(AlertRequest request) {

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        barrierColor:AppColor.barrierColor,
        backgroundColor: Colors.transparent,
        useRootNavigator: true,
        builder: (context) => Container(
          padding: MediaQuery.of(context).viewInsets,
          margin: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.bottom > 0 ? MediaQuery.of(context).viewPadding.bottom : 25),
          decoration: const BoxDecoration(
            color: AppColor.white,
            borderRadius:  BorderRadius.only(topLeft: Radius.circular(15),topRight:  Radius.circular(15)),
          ),
          child: Wrap(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 4.0,
                  width: 24.0,
                  margin: const EdgeInsets.only(top: 8.0),
                  decoration: const  BoxDecoration(
                    color: AppColor.swipeIndicator,
                    borderRadius: BorderRadius.all(Radius.circular(2.0)),
                  ),
                ),
              ),

              if (request.showActionBar == true)
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 5, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      if (request.iconWidget != null)
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: request.iconWidget,
                        ),

                      Expanded(
                          child: request.title == null ? Container() : Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(request.title ?? '', textScaler: const TextScaler.linear(1),
                              style: AppTextStyle.subtitleBold.copyWith(fontSize: 17,),
                            ),
                          )
                      ),

                      if(request.showCloseIcon == true)   IconButton(
                        onPressed: () {
                          _dialogService.dialogComplete(AlertResponse(status: false));
                        },
                        icon: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black12,
                          ),
                          padding: const EdgeInsets.all(5),
                          child: const Icon(
                            Icons.close, size: 20,
                            color: Colors.black54,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

              SingleChildScrollView(
                  child: Wrap(
                    children: [
                      SafeArea(child: request.contentWidget ?? Container()),
                    ],
                  )
              ),
            ],
          ),
        )
    );

  }

}