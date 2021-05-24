import 'package:flutter/material.dart';
import 'package:flutter_app/models/models.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';

class Profile extends StatefulWidget {
  Profile({Key key,}) : super(key: key);

  @override
  _ProfileState createState() => new _ProfileState();
}

class _ProfileState extends State<Profile> {
  final String apiUrl = "http://10.0.30.58:8000/news/cars/";
  Future<List<dynamic>> fetchUsers() async {
    var data = await http.get(apiUrl);
    var jsonData = json.decode(data.body);
    List<User> users = [];
    for (var u in jsonData) {
      User user = User(u["id"], u["author"], u["publication_date"], u["title"],
          u["image"], u["text"]);
      users.add(user);
    }
    print(users.length);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        child: FutureBuilder(
          future: fetchUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot.data);
            if (snapshot.data == null) {
              return Container(child: Center(child: Text("Loading...")));
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Column(children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          child: CircleAvatar(
                            backgroundColor: Color.fromRGBO(50, 65, 85, 1),
                            radius: 113,
                            child: CircleAvatar(
                              backgroundColor: Colors.blueAccent[100],
                              radius: 110,
                              child: CircleAvatar(
                                backgroundImage:NetworkImage(snapshot.data[index].publication_date),//NetworkImage
                                radius: 100,
                              ), //CircleAvatar
                            ), //CircleAvatar
                          ),
                        //CircleAvatar
                        ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                        child: Text(
                          snapshot.data[index].text,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ]),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
// final FirebaseAuth _fAuth = FirebaseAuth.instance;
// getProfileImage() {
//
//   if(_fAuth.currentUser.photoUrl != null) {
//     return Image.network(_fAuth.currentUser.photoUrl, height: 100, width: 100);
//   } else {
//     return Icon(Icons.account_circle, size: 100);
//   }
// }