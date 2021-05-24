import 'package:flutter/material.dart';
import 'package:flutter_app/models/cart_model.dart';
import 'package:flutter_app/models/models.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class News extends StatefulWidget {
  News({
    Key key,
  }) : super(key: key);
  @override
  _NewsState createState() => new _NewsState();
}
class _NewsState extends State<News> {
  Future<List<User>> _getUsers() async {
    var data = await http.get("http://10.0.30.58:8000/news/News/");
    var jsonData = json.decode(data.body) ?? '';
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
          future: _getUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot.data);
            if (snapshot.data == null) {
              return Container(child: Center(child: Text("Loading...")));
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(snapshot.data[index].publication_date),
                      minRadius: 40,
                      maxRadius: 40,
                    ),
                    title: Text(snapshot.data[index].text),
                    // subtitle: Text(snapshot.data[index].title),
                    //  trailing: Icon(Icons.favorite_border),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) =>
                                  DetailPage(snapshot.data[index])));
                    },
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

class DetailPage extends StatefulWidget {
  final User user;

  DetailPage(this.user);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {


  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartItems>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.text.toString()),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                left: 2.0,
                right: 2.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  new GestureDetector(
                    child: IconButton(
                      splashColor: Colors.red,
                      onPressed: () {
                        cart.addItem(
                            widget.user.author,
                            widget.user.title,
                            widget.user.text,
                            widget.user.publication_date);
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 1),
              child: new ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(200)),
                child: Image.network(
                  widget.user.publication_date,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 1),
              child: ListTile(
                title: Text(widget.user.text),
                subtitle: Text(widget.user.title),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


