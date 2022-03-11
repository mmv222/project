import 'dart:convert';
import 'dart:async';

import 'package:final_project_my/company.dart';
import 'package:final_project_my/todo.dart';
import 'package:final_project_my/todo_user_vission.dart';
import 'package:final_project_my/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

Future<List<ToDo>> _fetchToDo(int userid) async {
  final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/todos?userId=${userid}"));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);

    return jsonResponse.map((todo) => ToDo.fromJson(todo)).toList();
  } else {
    throw Exception('Failed to load users from API');
  }
}


class UserMission extends StatelessWidget {


   UserMission({Key? key, required this.user,}) : super(key: key);
   final User user;



   late Future<List<ToDo>> userTodo=_fetchToDo(user.id);
  @override
  Widget build(BuildContext context) {
    late List<ToDo> todo;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Задачи пользователя'),),

        body: SingleChildScrollView(
          child: Column(
            children:[
              Container(
                child: Text('user ID:${user.id} \n'
                    'name: ${user.name}\n'
                    'username: ${user.username}\n'
                    'email: ${user.email}\n'
                    'phone: ${user.phone}\n'
                    'website: ${user.website}\n'
                    'company: ${user.company}\n'
                    //'adrees: ${user.adress}'
                    ),
              ),

                  Center(
                    child: FutureBuilder<List<ToDo>>(
                      future: userTodo,
                      builder:(context, snapshot){
                        if (snapshot.hasData) {
                          todo=snapshot.data!;
                          return _userMission(todo);


                        }
                        else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }

                        // By default, show a loading spinner.
                        return const CircularProgressIndicator();
                      },

                    ),
                  )

            ],
          ),
        ),
        drawer: const Drawer(),
      ),
    );
  }
}




ListView _userMission(data){
  return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index){
        return   ListTile(title: Text('${data[index].title}',)
        );
      }
  );
}