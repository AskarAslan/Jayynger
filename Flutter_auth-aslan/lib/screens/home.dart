import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/components/Chosen.dart';
import 'package:flutter_app/components/Search.dart';
import 'package:flutter_app/components/Profile.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/components/News.dart';


class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  int sectionIndex = 0;

  @override
  Widget build(BuildContext context) {
    var navigationBar = CurvedNavigationBar(
      items: const <Widget>[
        Icon(Icons.library_books),
        Icon(Icons.search),
        Icon(Icons.star),
        Icon(Icons.account_circle),
      ],
      index: 0,
      height: 50,
      color: Colors.black26.withOpacity(0.5),
      buttonBackgroundColor: Colors.black12,
      backgroundColor: Colors.grey.withOpacity(0.5),
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 500),
      onTap: (int index) {
        setState(() => sectionIndex = index);
      },
    );

    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text((sectionIndex == 0)
              ? 'News'
              : (sectionIndex == 1)
                  ? 'Search'
                  : (sectionIndex == 2) ? 'Chosen' : 'Profile'),
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () {
                  AuthService().logOut();
                },
                icon: Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
                label: SizedBox.shrink())
          ],
        ),
        body: (sectionIndex == 0)
            ? News()
            : (sectionIndex == 1)
                ? Search()
                : (sectionIndex == 2) ? Chosen() : Profile(),
        bottomNavigationBar: navigationBar,
      ),
    );
  }
}
