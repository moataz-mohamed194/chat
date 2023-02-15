import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/auth/presentation/ pages/AuthenticationPhoneNumber.dart';
import 'features/auth/presentation/ pages/LoginPage.dart';
import 'features/auth/presentation/ pages/MainUserPage.dart';
import 'features/auth/presentation/eyesBloc/CheckerCubit.dart';
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
  print(uLogin);
  runApp( MyApp(login:uLogin));
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final bool? login;
  MyApp({super.key, this.login});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => di.sl<LoginBloc>()),
          BlocProvider(
            create: (_) => CheckerCubit(),
          ),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'App',
            home:login==true?MainUserPage():LoginPage()        ));
  }
}
