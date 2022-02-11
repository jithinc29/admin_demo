

import 'package:admin_task/global/user_sharedpreferneces.dart';
import 'package:admin_task/login.dart';
import 'package:admin_task/widgets/error_dialog.dart';
import 'package:admin_task/widgets/flutter_task.dart';
import 'package:admin_task/widgets/node_task.dart';
import 'package:admin_task/widgets/php_task.dart';
import 'package:admin_task/widgets/react_task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final _taskController = TextEditingController();
  final _categoryController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _taskController.dispose();
    _categoryController.dispose();
  }

  validationtask() {
    if (_taskController.text.isNotEmpty &&
        _categoryController.text.isNotEmpty) {
      addTasktoFirebase();
    } else {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: "task fields are empty",
            );
          });
    }
  }

  Future addTasktoFirebase() async {
    await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("user_task")
        .add({
      "taskname": _taskController.text,
      "taskCategory": _categoryController.text
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(UserSharedpreference.getName()!),
       actions: [
         Text(UserSharedpreference.getUID()!)
       ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.amberAccent, Colors.tealAccent])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(onPressed:(){

              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FlutterTask()));

            } , child: Text("flutter task"),),

            ElevatedButton(onPressed:(){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NodeTask()));

            } , child: Text("node task"),),

           ElevatedButton(onPressed:(){
             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PhpTask()));

            } , child: Text("php task"),),

            ElevatedButton(onPressed:(){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ReactTask()));

            } , child: Text("react task"),),

            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: 20),
            //   padding: EdgeInsets.only(left: 10),
            //   height: 50,
            //   decoration: BoxDecoration(
            //       color: Colors.white, borderRadius: BorderRadius.circular(30)),
            //   child: TextField(
            //     controller: _taskController,
            //     decoration: InputDecoration(
            //         border: InputBorder.none, hintText: "Task Name"),
            //   ),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: 20),
            //   padding: EdgeInsets.only(left: 10),
            //   height: 50,
            //   decoration: BoxDecoration(
            //       color: Colors.white, borderRadius: BorderRadius.circular(30)),
            //   child: TextField(
            //     controller: _categoryController,
            //     decoration: InputDecoration(
            //         border: InputBorder.none, hintText: "Category"),
            //   ),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // InkWell(
            //   onTap: () {

            //     // validationtask();

            //   },
            //   child: Container(
            //     margin: EdgeInsets.symmetric(horizontal: 20),
            //     height: 50,
            //     width: double.infinity,
            //     decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.circular(30)),
            //     child: Center(
            //         child: Text(
            //       "ADD TASK",
            //       style: TextStyle(fontWeight: FontWeight.bold),
            //       textAlign: TextAlign.center,
            //     )),
            //   ),
            // ),

            ElevatedButton(onPressed: (){

              getuserdata();



            }, child: Text("get authenticated employees")),
            SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: (){
                FirebaseAuth.instance.signOut().then((value){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                });

              },
              child: Container(
                height: 30,
                width: 120,
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(30)),
                    child: Center(child: Text("logout"),),
              ),
            )
          ],
        ),
      ),
    );
  }


  Future getuserdata()async{


  final emp=  await FirebaseFirestore.instance.collection("employee").where("department",isEqualTo: "Node").get();

  

  print(emp.docs.length);

  }
}
