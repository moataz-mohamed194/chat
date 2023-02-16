import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/auth/data/datasources/online_not_online.dart';
import 'features/auth/presentation/ pages/LoginPage.dart';
import 'features/auth/presentation/eyesBloc/CheckerCubit.dart';
import 'features/home/presentation/ pages/get_all_weight.dart';
import 'features/home/presentation/bloc/add_weight_bloc.dart';
import 'firebase_options.dart';
import 'injection_container.dart' as di;
import 'features/auth/presentation/bloc/login_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? uLogin = prefs.getBool('login');
  runApp(MyApp(login: uLogin));
  // runApp(MyApp());
}

class MyApp extends StatefulWidget {
  final bool? login;
  MyApp({super.key, this.login});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> with WidgetsBindingObserver {
  void closeAppUsingSystemPop() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        OnlineNotOnline().changeStatusToBeOnline();
        break;
      case AppLifecycleState.inactive:
        OnlineNotOnline().changeStatusToBeOffline();
        break;
      case AppLifecycleState.paused:
        OnlineNotOnline().changeStatusToBeOffline();
        break;
      case AppLifecycleState.detached:
        OnlineNotOnline().changeStatusToBeOffline();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => di.sl<AddUpdateGetWeightBloc>()),
          BlocProvider(create: (_) => di.sl<LoginBloc>()),
          BlocProvider(create: (_) => di.sl<AddUpdateGetWeightBloc>()),
          BlocProvider(
            create: (_) => CheckerCubit(),
          ),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'App',
            home: widget.login == true ? MainUserPage() : LoginPage()));
  }
}
