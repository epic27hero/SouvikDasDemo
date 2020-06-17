import 'package:flutter/material.dart';
import 'package:github_flutter/screen/user_details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _usernameController = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  void submit() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => UserDetailsScreen(
              username: _usernameController.text,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
              child: Container(
          margin: EdgeInsets.only(
              left: 15,
              right: 15,
              bottom: 15,
              top: MediaQuery.of(context).size.height * 0.3),
          child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: 80.0,
                    backgroundColor: Color(0xff33ffff) ,
                    child: CircleAvatar(
                      radius: 70.0,
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage('https://library.kissclipart.com/20190405/hve/kissclipart-computer-icons-github-clip-art-logo-dc9f8834e57de4e9.png'),
                     // backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRWjScmaue5Mtd_4MMkAZoc5IbfRml3uZb2fGfcYJt8-QXgJeE9&usqp=CAU'),

                    ),
                  ),
//                  Image.asset('assets/images/github--v1.png'),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(50)),
                    child: TextFormField(
                      controller: _usernameController,
                      style: TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please write Something';
                        }
                      },
                      onFieldSubmitted: (ctx) {
                        submit();
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          hintStyle: TextStyle(color: Colors.black),
                          hintText: "Your Github Username Here",
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xff33ffff), Color(0xff000099)],
                        begin: FractionalOffset.topRight,
                        end: FractionalOffset.bottomLeft,
                      ),
                        borderRadius: BorderRadius.circular(50),
//                        color: Colors.red,

                    ),
                    child: FlatButton(

                      onPressed: () {
                        submit();
                      },
                      child: Text(
                        'Check',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
