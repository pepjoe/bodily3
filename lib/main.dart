import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:bodily3/API.dart';
import 'package:bodily3/UserDetail.dart';
import 'package:bodily3/models/User.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fetching from API',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyListScreen(),
    );
  }
}

class MyListScreen extends StatefulWidget {
  @override
  createState() => _MyListScreenState();
}

class _MyListScreenState extends State {
  var users = new List<User>();

  _getUsers() {
    API.getUsers().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        users = list.map((model) => User.fromJson(model)).toList();
      });
    });
  }

  initState() {
    super.initState();
    _getUsers();
  }

  dispose() {
    super.dispose();
  }

  @override
  build(context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.deepPurpleAccent,
            centerTitle: true,
            leading: Image.asset("assets/images/bodily.png"),
          title: Text("Users List"),
        ),
        backgroundColor: Colors.white,
        body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {

            return ListTile(
              leading: Image.asset('assets/images/user_image.png',),//Image(
              title: Text(users[index].name),
              subtitle: Text(users[index].email),

              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UserDetail(
                    post: users[index],

                  ),
                ),
              ),
            );
          },
        ));

  }
}
