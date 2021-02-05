import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_scramble_frontend/lib/auth/bloc/auth_bloc.dart';
import 'package:word_scramble_frontend/lib/init/bloc/init_bloc.dart';
import 'package:word_scramble_frontend/lib/util/mix_util.dart';

class SplashScreen extends StatefulWidget {
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  InitBloc _initBloc;
  AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _initBloc = BlocProvider.of<InitBloc>(context);
    _initBloc.listen((state) {
      if (state is InitializedState) {
        _authBloc.add(new ForTokenEvent());
      } else if (state is FailToInitState) {
        MixUtil.showAlert(context, "Fail to Init Application", () {
          _initBloc.add(InitAppsEvent());
        });
      }
    });
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _authBloc.listen((state) {
      if (state is AnonymousState || state is AuthenticatedState) {
        Navigator.of(context).pushReplacementNamed("/home");
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SizedBox(
          width: 210,
          height: 100,
          child: Image(
            image: AssetImage("assets/logo.png"),
          ),
        ),
      ),
    );
  }
}
