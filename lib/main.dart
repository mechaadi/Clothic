import 'package:clothic/providers/auth_provider.dart';
import 'package:clothic/providers/user_provider.dart';
import 'package:clothic/views/Login.dart';
import 'package:clothic/views/Wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Color(0xff1b1b1b)));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseServices firebaseServices = FirebaseServices();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
        StreamProvider(
          create: (_) => firebaseServices.streamHero(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark(),
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    AuthProvider authProvider = Provider.of(context);

    return Padding(
        padding: EdgeInsets.only(top: statusBarHeight),
        child: authProvider.isAuthenticated ? WrapperPage() : LoginPage());
  }
}
