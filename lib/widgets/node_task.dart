import 'package:admin_task/widgets/error_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NodeTask extends StatefulWidget {
  

  @override
  State<NodeTask> createState() => _NodeTaskState();
}

class _NodeTaskState extends State<NodeTask> {




  _validationtask() {
    if (_taskController.text.isNotEmpty &&
        _categoryController.text.isNotEmpty) {
      _addTasktoFirebase();
       Navigator.pop(context);
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
    Future _addTasktoFirebase() async {


      await FirebaseFirestore.instance.collection("admintask").doc("Node").set({
      "id":"Node"
    });
    await FirebaseFirestore.instance.collection("admintask").doc("Node").collection("usertask").add({
      "taskname":_taskController.text,
      "taskcatgory":_categoryController.text
      
    });
    // await FirebaseFirestore.instance
    //     .collection("user")
    //     .doc("Node")
    //     .collection("user_task")
    //     .add({
    //   "taskname": _taskController.text,
    //   "taskCategory": _categoryController.text
    // });
  }

  final _taskController = TextEditingController();

  final _categoryController = TextEditingController();
   @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _taskController.dispose();
    _categoryController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text("Node"),),
            body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.amberAccent, Colors.tealAccent])),
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
                controller: _taskController,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: "Task Name"),
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
                controller: _categoryController,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: "Category"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {

                _validationtask();

              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                    child: Text(
                  "ADD TASK",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            // InkWell(
            //   onTap: (){
            //     FirebaseAuth.instance.signOut().then((value){
            //       Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
            //     });

            //   },
            //   child: Container(
            //     height: 30,
            //     width: 120,
            //     decoration: BoxDecoration(
            //         color: Colors.white, borderRadius: BorderRadius.circular(30)),
            //         child: Center(child: Text("logout"),),
            //   ),
            // )
                  ],
                )
      ),
      
    );
  }
}