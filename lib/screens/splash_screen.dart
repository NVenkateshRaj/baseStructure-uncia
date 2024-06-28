import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_issue_handle/bloc/login_bloc/login_bloc.dart';
import 'package:network_issue_handle/bloc/login_bloc/login_events.dart';
import 'package:network_issue_handle/bloc/login_bloc/login_state.dart';
import 'package:network_issue_handle/locator.dart';
import 'package:network_issue_handle/routes/router.dart';


class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SpalshScreenState();
  }
}

class _SpalshScreenState extends State<SplashScreen>{

  LoginBloc? loginBloc;

  @override
  void initState() {
    loginBloc = BlocProvider.of<LoginBloc>(context);
    loginBloc!
      ..add(LoginEvents.alreadyLogin)
      ..body = {}
      ..loginId = 1;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        builder: (BuildContext context, LoginState state) {

          return  Scaffold(
            backgroundColor: Colors.blue,
            appBar: AppBar(title: const Text("Splash Screen"),),
            body: const Center(
              child: Text("Splash Screen"),
            ),
          );
        }
    );
  }
}