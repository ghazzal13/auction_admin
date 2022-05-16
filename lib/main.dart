import 'package:auction_admin/cubit/cubit.dart';
import 'package:auction_admin/cubit/states.dart';
import 'package:auction_admin/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBLsVz0BvC-E2f0A2wTwHw3wBasdboa-gc",
        authDomain: "auction-15d90.firebaseapp.com",
        databaseURL: "https://auction-15d90-default-rtdb.firebaseio.com",
        projectId: "auction-15d90",
        storageBucket: "auction-15d90.appspot.com",
        messagingSenderId: "1094522114640",
        appId: "1:1094522114640:web:5ac676e3e3165385157755",
        measurementId: "G-2CL1WLLMTX",
      ),
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AuctionCubit()),
      ],
      child: BlocConsumer<AuctionCubit, AuctionStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(),
              home: const LoginScreen(),
              // StreamBuilder(
              //   stream: FirebaseAuth.instance.authStateChanges(),
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.active) {
              //       if (snapshot.hasData) {
              //         // AuctionCubit.get(context).getUserData();
              //         return const HomeScreeen();
              //       } else if (snapshot.hasError) {
              //         return Center(
              //           child: Text('${snapshot.error}'),
              //         );
              //       }
              //     }
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return const Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     }
              //     return const LoginScreen();
              //   },
              // ),
            );
          }),
    );
  }
}

/*
 
 
 flutter run -d chrome --web-renderer html
 
 
 */