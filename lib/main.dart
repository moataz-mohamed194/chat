import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/auth/data/datasources/online_not_online.dart';
import 'features/auth/presentation/ pages/LoginPage.dart';
import 'features/auth/presentation/eyesBloc/CheckerCubit.dart';
import 'features/chat/ domain/type.dart';
import 'features/chat/presentation/CheckBoxBloc/CheckerCubit.dart';
import 'features/home/presentation/ pages/get_all_weight.dart';
import 'features/home/presentation/bloc/add_weight_bloc.dart';
import 'firebase_options.dart';
import 'injection_container.dart' as di;
import 'features/auth/presentation/bloc/login_bloc.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

Future<void> messageHandler(RemoteMessage message) async {
  print('notification from background : ${message.data}');

}

void firebaseMessagingListener() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('notification from foreground : ${message.data}');

  });
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(messageHandler);
  firebaseMessagingListener();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print('token: ${fcmToken}');
  await messaging.getNotificationSettings();
  await messaging.requestPermission(
    provisional: true,
  );
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   print('Got a message whilst in the foreground!');
  //   print('Message data: ${message.data}');
  //
  //   if (message.notification != null) {
  //     print(
  //         'Message also contained a notification: ${message.notification!.body}');
  //   }
  // });
  // FirebaseAuth.instance.authStateChanges().listen((User? user) {
  //   if (user == null) {
  //     print('User is currently signed out!');
  //   } else {
  //     // print("token: " + user.getIdToken()..toString());
  //     print('User is signed in!');
  //   }
  // });
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
    WidgetsBinding.instance.addObserver(this);

    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print(state);
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
          BlocProvider(
            create: (_) => CheckerCubit0(''),
          ),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'App',
            home: widget.login == true ? MainUserPage() : LoginPage()));
  }
}
