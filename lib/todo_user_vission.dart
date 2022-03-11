import 'package:final_project_my/todo.dart';
import 'package:final_project_my/user.dart';
import 'package:final_project_my/user_mission.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<User>> _fetchUsersList() async {
  final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((user) => User.fromJson(user)).toList();
  } else {
    throw Exception('Failed to load users from API');
  }
}

ListView _usersListView(data) {
  //int userid=data.id;
  return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        //User userid=data.id;
        return ListTile(

            title: Text('${data[index].name}',
                style: const TextStyle(
                  fontSize: 10,
                )),
            subtitle: Text('${data[index].email}'),

            leading: const Icon(
              Icons.add_to_home_screen,
              color: Colors.blue,
            ),
            onTap: (){

              Navigator.push(context,
                MaterialPageRoute(builder: (context)=>UserMission2(user: data[index],)),
              );
            }
        );
      }

  );
}


class TodoUserVission extends StatelessWidget {
  const TodoUserVission({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    late Future<List<User>> futureUsersList=_fetchUsersList();
    late List<User> usersListData;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Задачи пользователя'),),

        body: Center(
            child: FutureBuilder<List<User>>(
                future: futureUsersList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    usersListData = snapshot.data!;
                    return _usersListView(usersListData);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  return const CircularProgressIndicator();
                })
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.all(40),
            children: [ListTile(
              leading: Icon(Icons.settings),
              title: Text('Настройки'),
              onTap: (){},
            )],
          ),
        ),
      ),
    );
  }
}
/***********************************************/

Future<List<ToDo>> _fetchToDo(int userid) async {
  final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/todos?userId=${userid}"));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);

    return jsonResponse.map((todo) => ToDo.fromJson(todo)).toList();
  } else {
    throw Exception('Failed to load users from API');
  }
}

class UserMission2 extends StatelessWidget {
  //const UserMission2({Key? key}) : super(key: key);
  final User user;
  
  UserMission2({required this.user,});

  @override
  Widget build(BuildContext context) {

    late Future<List<ToDo>> userTodo=_fetchToDo(user.id);
    late List<ToDo> todo;
    return  MaterialApp(
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
        drawer:  Drawer(
          child: ListView(
            padding: EdgeInsets.all(40),
            children: [ListTile(
              leading: Icon(Icons.settings),
              title: Text('Настройки'),
              onTap: (){},
            )],
          ),
        ),
      ),
    );
  }
}

ListView _userMission(data){
  return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index){
        return   ListTile(title: Column(
          children: [
            Row(
              children: [
                Text('${data[index].title}',),
                Checkbox(value: data[index].completed, onChanged: (val){})
              ],
            ),
          ],
        )
        );
      }
  );
}