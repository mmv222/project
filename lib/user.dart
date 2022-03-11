import 'package:final_project_my/adress.dart';
import 'package:final_project_my/company.dart';

class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;
  //final Address adress;
  final Map<String, dynamic>company;
  //final Geo geo;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.phone,
    required this.website,
   // required this.adress,
    required this.company,
    //required this.geo,

  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      phone: json['phone'],
      website: json['website'],
     /* adress: Address(
          street: json['adress']['street'],
          suite: json['adress']['suite'],
          city: json['address']['city'],
          zipcode: json['address']['zipcode'],
        geo: Geo(
          lat: json['address']['geo']['lat'],
          lng: json['address']['geo']['lng'],
        ),),
      //geo:  json['geo'] ,*/
      company: json['company'] as Map<String, dynamic>,
    );
  }
}