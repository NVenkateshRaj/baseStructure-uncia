import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:network_issue_handle/model/dialog_model_service/alert_request.dart';
import 'package:network_issue_handle/model/dialog_model_service/alert_response.dart';




class DialogService {

  final _dialogNavigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get dialogNavigationKey => _dialogNavigationKey;
  Function(AlertRequest)? _showDialogListener;
  Function(AlertRequest)? _showCustomDialogListener;
  Function(AlertRequest)? _showConfirmationDialogListener;
  Function(AlertRequest)? _bottomSheetListener;

  Completer<AlertResponse>? _dialogCompleter;

  void registerDialogListener(Function(AlertRequest) showDialogListener, Function(AlertRequest) showCustomDialogListener, Function(AlertRequest) showConfirmationDialogListener, Function(AlertRequest) bottomSheetListener,) {
    _showDialogListener = showDialogListener;
    _showCustomDialogListener = showCustomDialogListener;
    _showConfirmationDialogListener = showConfirmationDialogListener;
    _showConfirmationDialogListener = showConfirmationDialogListener;
    _bottomSheetListener = bottomSheetListener;
  }

  Future<AlertResponse>? showDialog({String title = 'Message', String description = '', String buttonTitle = 'OK', bool disMissAble = true}) {
    _dialogCompleter = Completer<AlertResponse>();
    print("Show DIalog Called");
    _showDialogListener!(AlertRequest(
        description: description,
        buttonTitle: buttonTitle,
        title: title,
        dismissable: disMissAble
    ));

    return _dialogCompleter?.future;
  }

  Future<AlertResponse>? showCustomAlertDialog({String? image, String? title, String? subtitle, String primaryButton = 'OK', String? secondaryButton,Function? onTap}) {
    _dialogCompleter = Completer<AlertResponse>();
    _showCustomDialogListener!(AlertRequest(
        image: image,
        description: subtitle,
        buttonTitle: primaryButton,
        secondaryButtonTitle: secondaryButton,
        title: title,
        onTap: onTap
    ));

    return _dialogCompleter?.future;
  }


  Future<AlertResponse>? showConfirmationAlertDialog({String? image, String? title, String? subtitle, String primaryButton = 'OK', String? secondaryButton, bool dismissable = true}) {
    _dialogCompleter = Completer<AlertResponse>();
    _showConfirmationDialogListener!(AlertRequest(
        image: image,
        description: subtitle,
        buttonTitle: primaryButton,
        secondaryButtonTitle: secondaryButton,
        title: title,
        dismissable: dismissable
    ));

    return _dialogCompleter?.future;
  }

  Future<AlertResponse>? showBottomSheet({String? title, Widget? iconWidget, required Widget child, bool showActionBar = true, bool showCloseIcon = true}) {
    _dialogCompleter = Completer<AlertResponse>();
    _bottomSheetListener!(AlertRequest(title: title, iconWidget: iconWidget, contentWidget: child, showActionBar: showActionBar,showCloseIcon: showCloseIcon));

    return _dialogCompleter?.future;
  }

  void dialogComplete(AlertResponse alertResponse) {
    _dialogCompleter?.complete(alertResponse);
    _dialogNavigationKey.currentState?.pop(alertResponse);
    _dialogCompleter = null;
  }

}