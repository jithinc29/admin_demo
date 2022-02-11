import 'package:admin_task/global/user_sharedpreferneces.dart';
import 'package:admin_task/login.dart';
import 'package:admin_task/register.dart';
import 'package:admin_task/task_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();



  await Firebase.initializeApp();

  await UserSharedpreference.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)
   {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
         primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
         builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) 
         { 
           if(snapshot.connectionState==ConnectionState.active)
           {
             if(snapshot.hasData)
             {
               return TaskScreen();
             }
             else if(snapshot.hasError)
             {
               return Center(child: Text("error"),);
             }
           }
           if(snapshot.connectionState==ConnectionState.waiting)
           {
             return Center(child: CircularProgressIndicator(color: Colors.amberAccent,),);
           }
           return LoginScreen();

          },)
    );
  }
}

