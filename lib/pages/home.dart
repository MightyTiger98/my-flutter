import 'package:flutter/material.dart';
import 'package:minapp/minapp.dart' ;
class HomePage extends StatefulWidget{

  @override
  _HomePageState createState() =>_HomePageState();
}

class _HomePageState extends State<HomePage> {

  final inputController = TextEditingController();

  TableObject tableObject = new TableObject('todo_demo');

  List todoList = [
  ];
  // List todoList = [
  //   {"name": "hx", "isDone": false},
  //   {"name": "hei", "isDone": true},
  // ];

  // 创建todo

  void addTodo() async{

    try{
      TableRecord record = tableObject.create();
      record.set('name', inputController.text);
      var data = await record.save();
      print(data.recordInfo);
      getTodoList();
    }catch(e){
      print(e.toString());
    }
  }

  // 获取列表数据
  void getTodoList() async{

    try{
      TableRecordList recordList = await tableObject.find();
      setState(() {
        todoList = recordList.records;
      });
    }catch(e){
      print(e.toString());
    }
  }

  // 修改数据
  void updateTodoItem(String id) async{

    try{
      TableRecord record = await tableObject.getWithoutData(recordId: id);
      record.set("isDone", true);
      var data = await record.update();
      print(data.recordInfo);
      getTodoList();
    }catch(e){
      print(e.toString());
    }
  }

  // 删除数据
  void removeTodoItem(String id) async{
    try {
      var data = await tableObject.delete(recordId: id);
      getTodoList();
      print(data);
    }catch(e){
      print(e.toString());
    }
  }
  
  // 匿名登录

  void anonymousLogin() async{
    try{
      await Auth.anonymousLogin();
      print("登录成功");
    }catch(e) {
      print(e.toString());
    }
  }


  // 初始化
  @override
  void initState(){
    super.initState();
    anonymousLogin();
    getTodoList();
  }
  // 页面
  @override
  Widget build(BuildContext context) {

   return Scaffold(
     appBar: AppBar(
       title: Text("my flutter demo"),
     ),
     body: Padding(
       padding: const EdgeInsets.all(8.0),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.stretch,
         children: [
           Form(
             child: TextFormField(
               controller: inputController,
               decoration: InputDecoration(labelText: "请输入内容"),
             ),
           ),
           SizedBox(
             height: 5.0,
           ),
           ButtonTheme(
             height: 50.0,
             child:RaisedButton(
               onPressed: addTodo,
               child: Text(
                 "添加按钮",
                 style: TextStyle(color: Colors.white),
               ),
               color: Colors.lightBlue,
             )
           ),
           ListView(
             shrinkWrap: true,
             children: todoList.map((todo)  {
               return Row(
                 children: [
                   Expanded(
                      child: Text(
                        todo.recordInfo['name'],
                        style: TextStyle(
                          fontSize: 18.0,
                          color: todo.recordInfo["isDone"] == true ? Colors.black26 : Colors.black,
                          decoration: todo.recordInfo["isDone"] == true ? TextDecoration.lineThrough: TextDecoration.none,
                        ),
                      ),
                   ),
                   if (todo.recordInfo['isDone'] == false)
                     RaisedButton(
                       onPressed:() => updateTodoItem(todo.recordInfo['id']),
                       child: Text(
                           '完成',
                           style: TextStyle(color: Colors.white)),
                       color: Colors.green,
                     ),
                   SizedBox(width: 5.0),
                   RaisedButton(
                     onPressed: () => removeTodoItem(todo.recordInfo['id']),
                     child: Text(
                         '删除',
                         style: TextStyle(color: Colors.white)),
                     color: Colors.red,
                   ),
                 ],
               );
             }).toList()

           )
         ],
       ),
     )
   );
  }

}