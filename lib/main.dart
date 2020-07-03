import 'package:flutter/material.dart';
import 'package:todo/task.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To do app',
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var namecontroller = TextEditingController();
  final List<Tasks> tasklist = [];

  void addtask(String names) {
    var task = Tasks();
    task.name = names;
    task.date = DateTime.now();
    task.id = DateTime.now().toString();
    setState(() {
      tasklist.add(task);
    });
  }

  void deletetask(String dev) {
    setState(() {
      tasklist.removeWhere((element) => element.id == dev);
    });
  }

  _showdialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (params) {
          return AlertDialog(
            title: Text("Add task"),
            content: TextField(
              onSubmitted: (value) => value = null,
              controller: namecontroller,
              decoration: InputDecoration(
                  labelText: 'Add task', helperText: 'add task'),
            ),
            actions: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              RaisedButton(
                onPressed: () {
                  addtask(namecontroller.text);
                  namecontroller.clear();
                  Navigator.pop(context);
                },
                child: Text('Save'),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To do'),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _showdialog(context);
          },
          label: Text("Add Task")),
      body: SingleChildScrollView(
        child: Container(
          height: 700,
          child: ListView.builder(
              itemCount: tasklist.length,
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.black,
                  height: 65,
                  child: Card(
                    elevation: 15,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              tasklist[index].name,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 23,
                                
                              ),
                            ),
                            Text(DateFormat.yMMMMEEEEd()
                                .format(tasklist[index].date)),
                          ],
                        ),
                        IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              deletetask(tasklist[index].id);
                              print(index);
                            }),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
