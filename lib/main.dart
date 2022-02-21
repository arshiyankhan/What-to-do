import 'package:flutter/material.dart';
import 'package:what_to_do_app/data/task.dart';
import 'package:what_to_do_app/widgets/task_card.dart';

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  List<Task> tasks_data = [
    Task('Create a new Project', false),
    Task('Working Call', false),
    Task('Meet with doctor', false),
    Task('Go to the shop', true)
  ];

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
          onPressed: () {},
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
            );
          }
          )
          )));
  }
}
