import 'package:admin_task/widgets/progress_bar.dart';
import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {

final String? message;
LoadingDialog({required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      
  
   content: Column(
     mainAxisSize: MainAxisSize.min,
     children: [
       circularprogress(),
       SizedBox(height: 10,),
       Text(message!+",Please wait")

     ],
   ),
    );
  }
}