import 'package:flutter/material.dart';
import 'package:what_to_do_app/data/task.dart';

class TaskCard extends StatefulWidget {
  TaskCard({ Key? key, required this.task }) : super(key: key);

  Task task;

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 10,right: 10,top:20,bottom: 20),
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(500)),
          boxShadow: [
            BoxShadow(
            color: Color.fromARGB(30, 0, 0, 0),
            blurRadius: 4,
            offset: Offset(0,4)
          )
          ]
        ),
        child: TextButton(
          onPressed: (){},
          child: Text(
            widget.task.title,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600]
            ),),
        ),
    );
  }
}