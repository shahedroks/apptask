import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ecommerces_project/Bloc/bloc.dart';
import 'package:firebase_ecommerces_project/Pages/about.dart';
import 'package:firebase_ecommerces_project/Pages/user_copy.dart';
import 'package:firebase_ecommerces_project/Pages/user_home.dart';
import 'package:firebase_ecommerces_project/Pages/sign_in.dart';
import 'package:firebase_ecommerces_project/Pages/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MainApp());}
class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CounterBolc())
      ],
      child: MaterialApp(initialRoute: '/',
          routes: {
            '/': (context)=>UserCopy(),
            '/signup':(context)=>SignUp(),
            '/homepage':(context)=> UsersHomePage()
          },debugShowCheckedModeBanner: false,
      ),
    );
  }
}
