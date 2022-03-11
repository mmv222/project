//import 'package:final_project_my/user_list.dart';
import 'package:final_project_my/todo_user_vission.dart';
import 'package:final_project_my/user_list_2.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(FinalProjectMy());
}

class FinalProjectMy extends StatefulWidget {
  @override
  _FinalProjectMyState createState()=>_FinalProjectMyState();}

  class _FinalProjectMyState extends State<FinalProjectMy>{
  final _messangerKey=GlobalKey<ScaffoldMessengerState>();
  String _phoneNumber='95123456';
  final String _loginUser='95123456';

  final _nameController=TextEditingController();
  final _nameLoginUser = TextEditingController();

  @override
  void dispose(){
    _nameController.dispose();
    _nameLoginUser.dispose();

  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _messangerKey,
      home: Scaffold(
        body: Column(
        children: [
          SizedBox( height: 50,),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              filled: true,
              labelText: 'Телефон',
            ),

          ),
          TextField(
            controller: _nameLoginUser,
            decoration: InputDecoration(
              filled: true,
              labelText: 'пароль',


            ),
            obscureText: true,
          ),
          SizedBox(height: 30,),

          ElevatedButton(onPressed: _submitUserForm, child: Text('войти')),
        ],
      ),
      ),
    );

  }
   void _submitUserForm(){

    if((_nameController.text.toString()==_phoneNumber) && (_nameLoginUser.text.toString()==_loginUser))
    {

      runApp(TodoUserVission());
    }
    else{
      _messangerKey.currentState!.showSnackBar(SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text(
          'неверный логин или пароль',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),
      )
      );
    }
   }
}






