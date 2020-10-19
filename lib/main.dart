import 'package:clothic/providers/auth_provider.dart';
import 'package:clothic/providers/donation_provider.dart';
import 'package:clothic/providers/item_provider.dart';
import 'package:clothic/providers/user_provider.dart';
import 'package:clothic/views/ChatScreen.dart';
import 'package:clothic/views/Login.dart';
import 'package:clothic/views/Product.dart';
import 'package:clothic/views/Wrapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:provider/provider.dart';

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {}

  if (message.containsKey('notification')) {}
}

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
    final UserServices firebaseServices = UserServices();
    final ItemServices itemServices = ItemServices();
    final DonationService donationSerices = DonationService();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
        StreamProvider(
          create: (_) => firebaseServices.streamHero(),
        ),
        StreamProvider(create: (_) => itemServices.streamItems()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark(),
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
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
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();

    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("onMessage: $message");
          // _showItemDialog(message);
        },
        onBackgroundMessage: myBackgroundMessageHandler,
        onLaunch: (Map<String, dynamic> message) async {
          if (message['data']['notificationID'] == 'donation') {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                builder: (context) =>
                    ProductDetails(id: message['data']['donationID'])), ModalRoute.withName('/'));
          }

          if (message['data']['notificationID'] == 'chat') {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                builder: (context) =>
                    ChatScreen(remoteUser: message['data']['remoteUser'])), ModalRoute.withName('/'));
          }
        },
        onResume: (Map<String, dynamic> message) async {
          if (message['data']['notificationID'] == 'donation') {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                builder: (context) =>
                    ProductDetails(id: message['data']['donationID'])), ModalRoute.withName('/'));
          }

          if (message['data']['notificationID'] == 'chat') {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                builder: (context) =>
                    ChatScreen(remoteUser: message['data']['remoteUser'])), ModalRoute.withName('/'));
          }
        });

    _firebaseMessaging.getToken().then((String token) {
      String uid = auth.FirebaseAuth.instance.currentUser.uid;

      print(token);
      _firebaseMessaging.subscribeToTopic('newDonations');

      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({'token': token});
      assert(token != null);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    AuthProvider authProvider = Provider.of(context);

    return Scaffold(
        backgroundColor: Color(0xff1b1b1b),
        body: Padding(
            padding: EdgeInsets.only(top: statusBarHeight),
            child: authProvider.isAuthenticated ? WrapperPage() : LoginPage()));
  }
}
