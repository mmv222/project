import 'dart:convert';

import 'package:final_project_my/todo_user_vission.dart';
import 'package:final_project_my/user.dart';
import 'package:final_project_my/adress.dart';
import 'package:final_project_my/user_mission.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


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
            MaterialPageRoute(builder: (context)=>UserMission(user: data[index],)),
            );
          }
        );
        }

      );
}




class UserList2 extends StatefulWidget {
  const UserList2({Key? key}) : super(key: key);

  @override
  _UserList2State createState() => _UserList2State();
}

class _UserList2State extends State<UserList2> {
  late Future<List<User>> futureUsersList;
  late List<User> usersListData;

  @override
  void initState() {
    super.initState();
    futureUsersList = _fetchUsersList();
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text('Список пользователей'),),
          drawer: Drawer(
            child:ListTile(
              leading: const Icon(Icons.twenty_one_mp_outlined),
            ),
          ),
          body:
          Center(
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

        )
    );
  }
}


