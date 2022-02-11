import 'package:admin_task/login.dart';
import 'package:admin_task/task_screen.dart';
import 'package:admin_task/widgets/error_dialog.dart';
import 'package:admin_task/widgets/loading_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  final _passController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passController.dispose();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
 

  Future<void> uservalidation() async {
    if (_nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passController.text.isNotEmpty) {
      showDialog(
          context: context,
          builder: (c) {
            return LoadingDialog(
              message: "Registering Account",
            );
          });
      userRegister();
    } 
    else 
    {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: "Please write complete user detail",
            );
          });
    }
  }

  Future userRegister() async {
    User? currentuser;
    await _auth
        .createUserWithEmailAndPassword(
            email: _emailController.text, password: _passController.text)
        .then((auth) {
      currentuser = auth.user;
    }).catchError((error){
      Navigator.pop(context);
      showDialog(context: context, builder: (c){
        return ErrorDialog(message: error.message.toString(),);
      });
    });

    if (currentuser != null) {
      savaDatatofirestore(currentuser!).then((value) {
        Navigator.pop(context);
       Route newRoute=MaterialPageRoute(builder: (c)=>TaskScreen());
        Navigator.pushReplacement(context, newRoute);
      });
     
    }
  }

  Future savaDatatofirestore(User currentuser) async {
    await FirebaseFirestore.instance
        .collection("admin")
        .doc(currentuser.uid)
        .set({
      "email": _emailController.text,
      "name": _nameController.text,
      "uid":currentuser.uid
      
    });


    
      SharedPreferences? sharedPreferences=await SharedPreferences.getInstance();
   
    await sharedPreferences.setString("uid", currentuser.uid);
    await sharedPreferences.setString("name", _nameController.text);
    await sharedPreferences.setString("email", _emailController.text);



  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.amberAccent,
        Colors.tealAccent,
      ])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.only(left: 10),
            height: 50,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: TextField(
              controller: _nameController,
              decoration:
                  InputDecoration(border: InputBorder.none, hintText: "name"),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.only(left: 10),
            height: 50,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: TextField(
              controller: _emailController,
              decoration:
                  InputDecoration(border: InputBorder.none, hintText: "email"),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.only(left: 10),
            height: 50,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: TextField(
              controller: _passController,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: "password"),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              uservalidation();
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: Center(
                  child: Text(
                "REGISTER",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )),
            ),
          ),
          SizedBox(height: 50,),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (c)=>LoginScreen()));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 20,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: Center(
                  child: Text(
                "GO TO LOGIN",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )),
            ),
          )



        ],
      ),
    ));
  }
}
