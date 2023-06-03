import 'dart:async';
import 'dart:io';

import 'package:alemeno_assignment/colors.dart';
import 'package:alemeno_assignment/screen/good_job_screen.dart';
import 'package:alemeno_assignment/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../const.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  final ImagePicker imagePicker = ImagePicker();

  XFile? _img1;
  bool _changeSize = false;

  void selectImage(int index, ImageSource source) async {
    var status = await Permission.camera.status;
    print(status);
    if (status.isDenied) {
      await Permission.camera.request();
      selectImage(index, source);
    }else if(status.isGranted) {
      var image = await imagePicker.pickImage(source: source);
      if (image == null) return;

      _img1 = image;
    }
    setState(() {

    });
  }

  FirebaseStorage storage = FirebaseStorage.instance;


  @override
  void initState() {
    super.initState();
  }

  final String smallAnimalUrl='';
  final String bigAnimalUrl='';
  bool downloadDone = false;

  Future<List<String>> getImages() async {
    Reference ref = storage.ref().child('small_lion.jpg');
    String smallAnimalUrl = await ref.getDownloadURL();
    Reference ref2 = storage.ref().child('big_lion.jpg');
    String bigAnimalUrl = await ref2.getDownloadURL();
    return [smallAnimalUrl,bigAnimalUrl];
  }




  @override
  Widget build(BuildContext context) {
    double width = MediaQuery. of(context). size. width ;
    double height = MediaQuery. of(context). size. height;
    double wu = width*wf;
    double hu = height*hf;

    String str = (_img1 == null) ? 'Click your meal':"Will you eat this?";
    if(_changeSize){
      str = "Lion become big";
    }
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top:24*hu,
            left: 24*wu,
            child: FloatingActionButton(
              backgroundColor: btn_clr,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
                width: 200,
                height: 200,
                margin: EdgeInsets.only(top: 50*hu),
                child: FutureBuilder(
                    future: getImages(),
                    builder: (context, snapshot) {

                        if(snapshot.hasData){
                          List<String>? links = snapshot.data;
                          String sm = links!.first;
                          String bg = links[1];
                          return (!_changeSize) ?
                          CachedNetworkImage(
                              imageUrl: "$sm"
                          ):
                          Container(
                              width: 200,
                              height: 200,
                              child: CachedNetworkImage(
                                  imageUrl: "$bg"
                              )
                          );
                        }else{
                          return Container();
                        }
                    },
                ),

            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Wrap(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 15*hu,bottom: 40*hu,left: 25*wu,right: 25*wu),
                  decoration: BoxDecoration(
                    color: milk_clr,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                  ),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset("assets/images/spoon1.svg"),
                            (_img1 != null) ?
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(200),
                                  child: Image.file(
                                    File(_img1!.path),
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.fill,
                                  ),
                                ) : Container(),
                            SvgPicture.asset("assets/images/spoon2.svg"),
                          ],
                      ),
                      Text(str,
                        textAlign: TextAlign.center,
                        style: subtitle24_prim400,
                      ),
                      SizedBox(
                        height: 11*hu,
                      ),
                      GestureDetector(
                        onTap: (){

                        },
                        child: Container(
                          padding: EdgeInsets.all(19*wu),
                          decoration: BoxDecoration(
                            color: btn_clr,
                            borderRadius: BorderRadius.circular(90)
                          ),
                          child: (_img1 == null)?
                            GestureDetector(
                            onTap: (){
                              selectImage(0, ImageSource.camera);
                            },
                            child: SizedBox(
                              width: 32*wu,
                                height: 26*hu,
                                child: SvgPicture.asset('assets/images/camera.svg')),
                          ):
                          InkWell(
                            onTap: (){
                              _changeSize = true;
                              setState(() {

                              });
                              Timer(Duration(seconds: 3), () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) =>
                                        GoodJobScreen()
                                    )
                                );
                              });

                            },
                            child: SizedBox(
                                width: 32*wu,
                                height: 26*hu,
                                child: SvgPicture.asset('assets/images/ok.svg')),
                          )
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
