import 'package:flutter/material.dart';
import 'package:todolist/constants/colors.dart';
import 'package:todolist/models/todo.dart';
import 'package:todolist/widgets/todolist.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList=Todo.todolist();
  List<Todo> _foundTodo =[];
  final _todoController = TextEditingController();

  @override
  void initState(){
    _foundTodo = todosList;
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBgColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                    child:ListView(
                      children: [
                        Container(
                          margin:const EdgeInsets.only(
                            top: 50,
                            bottom: 20,
                          ),
                          child:const Text(
                            'To Do List',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        for(Todo todo in _foundTodo.reversed)
                        ToDoList(
                          todo: todo,
                          onToDoChanged: _handleToDoChange,
                          onDeleteItem: _deleteToDoList,
                        ),
                      ],
                    ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                  child:Container(
                    margin:const EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                      left: 20,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                    decoration:  BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0,0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                      ),],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                        hintText: 'Add a new todo item',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                ),
                child: ElevatedButton(
                  child:const Text('+',style: TextStyle(fontSize: 40,),),
                  onPressed: (){
                    _addToDoItem(_todoController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: tdBlue,
                    minimumSize: Size(60,60),
                    elevation: 10,
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  void _handleToDoChange(Todo todo){
    setState(() {
      todo.isDone=!todo.isDone;
    });
  }

  void _deleteToDoList(String id){
    setState(() {
      todosList.removeWhere((item)=>item.id==id);
    });
  }

  void _addToDoItem(String todo){
    setState(() {
      todosList.add(Todo(id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: todo,
      ));
    });
    _todoController.clear();
  }

  void _runFilter(String enterKeyword){
    List<Todo> results=[];
    if(enterKeyword.isEmpty){
      results=todosList;
    }else{
      results=todosList.where((item) => item.todoText!.toLowerCase().contains(enterKeyword.toLowerCase())).toList();
    }

    setState(() {
      _foundTodo =results;
    });
  }
  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 20,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  AppBar _buildAppBar(){
    return AppBar(
      backgroundColor: tdBgColor,
      elevation: 0,
    );
  }
}
