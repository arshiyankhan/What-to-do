import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
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

  late File tasksFile;

  TextEditingController _controller = TextEditingController();

  List<Task> tasks_data = [];

  void initState(){
    super.initState();
    getTasks();
  }

  void getTasks() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    
    String filePath = documentsDirectory.path + "/tasks.json";

    tasksFile = await File(filePath).create(recursive: true);

    String fileData = await tasksFile.readAsString();

    if(fileData==""){
      fileData = "[]";
      await tasksFile.writeAsString(fileData);
    }
    List<dynamic> json = jsonDecode(fileData);

    for (dynamic item in json){
      Task task = Task(
        item['title'],
        item['isCompleted']
        );
      tasks_data.add(task);
    }
    setState(() {});
  }



  void showAddTaskDialog(){
    _controller.text = "";
    
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Container(child: Text('Create New Task')),
        content: TextField(
          controller: _controller,
          autofocus: true,
        ),
        actions: [
          MaterialButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              ),
          ),
          MaterialButton(
            onPressed: (){
              if (_controller.text.isEmpty){
                return;
              }
              Navigator.pop(context);
              Task createdTask = Task(_controller.text, false);
              setState(() {
                tasks_data.add(createdTask);
              });
              addTaskToFile(createdTask);
            },
            color: Colors.blue,
            child: Text(
              'Done',
            style: TextStyle(
              color: Colors.white,
            ),
              ), 
            )
        ],
      ) 
      );
  }


  void addTaskToFile(Task task) async{
    Map<String,dynamic> taskMap = {
      "title": task.title,
      "isCompleted": task.isCompleted
    };
    String fileData = await tasksFile.readAsString();

    List<dynamic> json = jsonDecode(fileData);
    json.add(taskMap);
    
    String finalData = jsonEncode(json);
    tasksFile.writeAsString(finalData);
  }


   void showDeleteDialog(index){
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Container(child: Text('Do you want to delete it?'),margin: EdgeInsets.only(bottom: 14)),
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

  void showEditDialog(index){
    _controller.text = tasks_data[index].title;

    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Container(child: Text('Edit this task'),margin: EdgeInsets.only(bottom: 14)),
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
              Navigator.pop(context);
              setState(() {
                tasks_data[index].title = _controller.text;
              });
            },
            child: Text('Confirm'), 
            )
        ],
      ) 
      );
  }

  void showBottomModalSheet(index){
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context){
        return Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 20))
                    ),
                    onPressed: (){
                      Navigator.pop(context);
                      setState(() {
                        showDeleteDialog(index);
                      });
                    },
                    child: Text('Delete')
                    ),
                  SizedBox(
                    height:5
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 20))
                    ),
                    onPressed: (){
                      Navigator.pop(context);
                      setState(() {
                        showEditDialog(index);
                      });
                    },
                    child: Text('Edit')
                    )
                ],
              ),
            ),
          ],
        );
      },
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
                showBottomModalSheet(index);
                }
              );
            }
          )
        )
      )
    );
  }
}
