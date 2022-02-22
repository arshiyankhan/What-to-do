import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:what_to_do_app/data/task.dart';
import 'package:what_to_do_app/widgets/task_card.dart';

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TextEditingController _controller = TextEditingController();

  List<Task> tasks_data = [];

  void showAddTaskDialog(){
    _controller.text = "";
    
    showDialog(
      context: context, 
      builder: (context) => CupertinoAlertDialog(
        title: Container(child: Text('Create New Task'),margin: EdgeInsets.only(bottom: 14)),
        content: CupertinoTextField(
          controller: _controller,
          autofocus: true,
        ),
        actions: [
          CupertinoButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.red
              )),
          ),
          CupertinoButton(
            onPressed: (){
              if (_controller.text.isEmpty){
                return;
              }
              Navigator.pop(context);
              Task createdTask = Task(_controller.text, false);
              setState(() {
                tasks_data.add(createdTask);
              });
            },
            child: Text('Done'), 
            )
        ],
      ) 
      );
  }

   void showDeleteDialog(index){

    showDialog(
      context: context, 
      builder: (context) => CupertinoAlertDialog(
        title: Container(child: Text('Do you want to delete it?'),margin: EdgeInsets.only(bottom: 14)),
        content: CupertinoTextField(
          controller: _controller,
          readOnly: true,
        ),
        actions: [
          CupertinoButton(
            onPressed: (){
              Navigator.pop(context);
              setState(() {
                tasks_data.removeAt(index);
              });
            },
            child: Text(
              'Yes',
              style: TextStyle(
                color: Colors.red
              )),
          ),
          CupertinoButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text('No'), 
            )
        ],
      ) 
      );
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFFDFDFD),
          elevation: 0,
          toolbarHeight: 60,
          title: Text(
            'All Tasks',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.manage_search,
              color: Colors.blue,
              size: 30,
            ),
            splashRadius: 20,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showAddTaskDialog();
          },
          child: Icon(
            Icons.add,
            size: 30,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: ListView.builder(
          itemCount: tasks_data.length,
          itemBuilder: (((context, index) {
            return TaskCard(
              task: tasks_data[index],
              onTap: (){
                setState(() {
                  tasks_data[index].isCompleted =!tasks_data[index].isCompleted;
                  });
                },
              onLongPress: (){
                showDeleteDialog(index);
              }
              );
            }
          )
        )
      )
    );
  }
}
