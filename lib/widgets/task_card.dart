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
        margin: EdgeInsets.only(left: 10,right: 10,top:18,bottom: 18),
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
          onPressed: (){
            setState(() {
              widget.task.isCompleted=!widget.task.isCompleted;
            });
          },
          child: Row(
            children: [
              Text(
            widget.task.title,
            style: TextStyle(
              fontSize: 16,
              color: widget.task.isCompleted?Colors.grey[400]:Colors.grey[600],
              decoration: widget.task.isCompleted?TextDecoration.lineThrough:TextDecoration.none,
            ),
            ),
            Spacer(),
            Container(
              width: 26,
              height: 26,
              child: Icon(
              Icons.check,
              color:Colors.white,
              size: 18
              ),
              decoration: BoxDecoration(
                color: widget.task.isCompleted?Colors.green:Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(100)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(30, 0, 0, 0),
                    blurRadius: 4,
                    offset: Offset(0,4)
                  )
                ]
              ),
            )
          ],
          ),
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(500))
          ),
          padding: EdgeInsets.symmetric(horizontal: 20)
        ),
      ),
    );
  }
}