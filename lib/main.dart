import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:network_issue_handle/bloc/login_bloc/login_bloc.dart';
import 'package:network_issue_handle/bloc/login_bloc/login_repo.dart';
import 'package:network_issue_handle/firebase_options.dart';
import 'package:network_issue_handle/locator.dart';
import 'package:network_issue_handle/routes/router.dart';
import 'package:network_issue_handle/service/common_service/dialog_service.dart';
import 'package:network_issue_handle/service/common_service/network_service.dart';
import 'package:network_issue_handle/service/remote_config_service/firebase_helper.dart';
import 'package:network_issue_handle/service/remote_config_service/remote_config_service.dart';
import 'package:network_issue_handle/widgets/dialog_widget.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();
  locator<ConnectivityService>().init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await locator<FirebaseRemoteHelper>().configure();
  locator<RemoteConfigService>().config;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LoginBloc(logInRepo: LoginRepoImplement())),
        ],
        child: ScreenUtilInit(
          builder: (context,child) => MaterialApp(
            title: 'Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            initialRoute:  '/',
            builder: _setupDialogManager,
            debugShowCheckedModeBanner: false,
            navigatorKey: navigationService.navigatorKey,
            onGenerateRoute: (settings) => AppRouter.generateRoute(settings),
          ),
        )
    );
  }

  Widget _setupDialogManager(context, widget) {
    return Navigator(
      key: locator<DialogService>().dialogNavigationKey,
      onGenerateRoute: (settings) => MaterialPageRoute(builder: (context) {
        final MediaQueryData data = MediaQuery.of(context);
        return DialogWidget(
            child: widget
        );
      }),
    );
  }
}