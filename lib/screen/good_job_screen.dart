import 'package:alemeno_assignment/screen/landing_screen.dart';
import 'package:alemeno_assignment/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GoodJobScreen extends StatefulWidget {
  const GoodJobScreen({Key? key}) : super(key: key);

  @override
  State<GoodJobScreen> createState() => _GoodJobScreenState();
}

class _GoodJobScreenState extends State<GoodJobScreen> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to restart the game'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) =>
                    LandingScreen()
                )
            ),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold(
        body: new Center(
          child: new Text("GOOD JOB",style: title48_gr400,),
        ),
      ),
    );
  }
}
