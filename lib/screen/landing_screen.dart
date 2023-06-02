import 'package:alemeno_assignment/colors.dart';
import 'package:alemeno_assignment/styles.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../const.dart';
import 'game_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery. of(context). size. width ;
    double height = MediaQuery. of(context). size. height;
    double wu = width*wf;
    double hu = height*hf;

    return Scaffold(
      body: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) =>
                    GameScreen()
                )
            );
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 16),
            margin: EdgeInsets.only(bottom: 92*hu,left: 65*wu,right: 65*wu),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: btn_clr
            ),
            child: Text("Share your meal",
              textAlign: TextAlign.center,
              style: subtitle25_wh400,
            ),
          ),
        ),
      ),
    );
  }
}
