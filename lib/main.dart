import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ToDo List',
        debugShowCheckedModeBanner: false,
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _toDoList = [];
  final _toDoController = TextEditingController();

  void _addToDo() {
    setState(() {
      Map<String, dynamic> newToDo = Map();
      newToDo["title"] = _toDoController.text;
      newToDo["done"] = false;
      _toDoList.add(newToDo);
    });
    _toDoController.clear();
  }

  void _deleteToDo(index) {
    setState(() {
     _toDoList.removeAt(index);
    });
  }

  void _changeToDoState(index) {
    if (_toDoList[index]["done"]) {
      setState(() {
        _toDoList[index]["done"] = false;
      });
    } else {
      setState(() {
        _toDoList[index]["done"] = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ToDo App"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(17, 1, 7, 7),
            child: Row(children: <Widget>[
              Expanded(child: TextField(
                controller: _toDoController,
              )),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: _addToDo,
              ),
            ]),
          ),
          Expanded(
            child: ListView.builder(itemCount: _toDoList.length, itemBuilder: (context, index) {
              return Slidable(
                key: ValueKey(index),
                actionPane: SlidableDrawerActionPane(),
                actions: <Widget>[
                  IconSlideAction(
                    caption:  _toDoList[index]["done"] ? 'Cancelar' : 'Concluir',
                    color:  _toDoList[index]["done"] ? Colors.red : Colors.blue,
                    icon:  _toDoList[index]["done"] ? Icons.do_not_disturb_alt : Icons.check_circle,
                    closeOnTap: true,
                    onTap: () => _changeToDoState(index),
                  )
                ],
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: 'Deletar',
                    color: Colors.red,
                    icon: Icons.delete,
                    closeOnTap: true,
                    onTap: () => _deleteToDo(index),
                  )
                ],
                child: ListTile(
                  leading: Icon(
                    _toDoList[index]["done"] ? Icons.check : Icons.do_not_disturb
                  ),
                  title: Text(_toDoList[index]["title"])
                )
              );
            })
          )
        ]
      ));
  }
}
