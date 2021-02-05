import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_scramble_frontend/lib/auth/bloc/auth_bloc.dart';
import 'package:word_scramble_frontend/lib/init/bloc/init_bloc.dart';
import 'package:word_scramble_frontend/routes.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<InitBloc>(
        create: (context) => InitBloc(),
      ),
      BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(),
      )
    ],
    child: WordScrambleApp(),
  ));
}

class WordScrambleApp extends StatefulWidget {
  @override
  _WordScrambleApp createState() => _WordScrambleApp();
}

class _WordScrambleApp extends State<WordScrambleApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    BlocProvider.of<InitBloc>(context).add(InitAppsEvent());
  }

  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      navigatorKey: _navigatorKey,
      routes: Routes.routes,
      initialRoute: '/',
    );
  }
}
