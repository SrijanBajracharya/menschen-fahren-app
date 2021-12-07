import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


// TODO: Custom Error Message for normal User
// TODO: Expandable Details Section for Analysis
class ErrorPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Error"),
        ),
        body: Center(
            child: Card(
          child: Padding(
            child: Text(
              "Something is not right here...",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            padding: const EdgeInsets.all(8.0),
          ),
          color: Colors.red,
          margin: EdgeInsets.zero,
        )));
  }
}
