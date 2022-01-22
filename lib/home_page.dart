import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final t1 = TextEditingController();
  final t2 = TextEditingController();

  ScreenshotController screenshotController = ScreenshotController();

  double waistSize=0, _fraction = 0,arrowPosition=0,spacing=0;
  int parts=1;
  bool greenArrowStatus = false;
  List<int> numbers = [0,1,2,3];

  void _greenArrowStatusChanger(){
    setState(() {
      greenArrowStatus=greenArrowStatus?false:true;
    });
  }

  void _calculateFraction() {
    setState(() {
        try {
          waistSize = double.parse(t1.text);
          parts = int.parse(t2.text);
          if (parts<1) {
            throw Exception();
          }
          _fraction = waistSize/parts;
          int _frac = _fraction.round();

          for(int i=0;i<4;i++) {
            numbers[i]=i+_frac-1;
          }
          double height= MediaQuery.of(context).size.height;
          double width= MediaQuery.of(context).size.width;
          if (kDebugMode) {
            print('Height $height,width $width');
          }
          spacing = (height)*0.25;
          arrowPosition = (_fraction-_frac+1)*spacing;
          if (kDebugMode) {
            print([_fraction,_frac,waistSize,parts,arrowPosition,spacing]);
          }
          showDialog(
            context: context,
            builder: (context) {
              return Screenshot(
                controller: screenshotController,
                child: AlertDialog(
                  backgroundColor: Colors.grey[200],
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0))
                  ),
                  content: Stack(
                    alignment: Alignment.center,
                    children: [
                      ColorFiltered(
                        colorFilter: ColorFilter.mode(Colors.deepOrange.shade200, BlendMode.hue),
                        child: Container(
                          //height: MediaQuery.of(context).size.height,
                          //width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                              image: const DecorationImage(
                                fit: BoxFit.fill,
                                filterQuality: FilterQuality.medium,
                                image:  AssetImage('images/ScaleVertical.png'),
                              )
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: numbers.map<Widget>((int num) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 5,bottom: 5),
                            child: Text(
                              num.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      Positioned(
                        top: 390,//arrowPosition,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.arrow_back,color: Colors.deepOrangeAccent,size: 45,),
                            SizedBox(width: 100,),//width*0.315,),
                            Icon(Icons.arrow_forward,color: Colors.deepOrangeAccent,size: 45,),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: greenArrowStatus,
                        child: Positioned(
                          top: arrowPosition+spacing,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.arrow_back,color: Colors.lightGreen,size: 45,),
                              SizedBox(width: width*0.315,),
                              const Icon(Icons.arrow_forward,color: Colors.lightGreen,size: 45,),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -5,
                        right: 0,
                        child: MaterialButton(
                          onPressed: _saveScale,
                          color: Colors.deepOrange[300],
                          child: const Text(
                            "Share",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } on Exception{
           _showSnackBar('Invalid Input!! Try Again');
        }
    });
  }

  void _showSnackBar(String message){
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
  final snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.blueGrey,
    content: Text(message),
    action: SnackBarAction(
      label: 'Close', onPressed: () {  },
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.deepOrange[200],
      // appBar: AppBar(
      //   title: Row(
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     mainAxisSize: MainAxisSize.max,
      //     children: [
      //       Padding(
      //         padding: const EdgeInsets.only(left: 16.0),
      //         child: Text(widget.title),
      //       ),
      //     ],
      //   ),
      //   actions: [
      //     Switch(
      //       onChanged: (bool value) { _greenArrowStatusChanger(); },
      //       value: greenArrowStatus,
      //       activeColor: Colors.lightGreenAccent,
      //     ),
      //     const SizedBox(width: 20,),
      //   ],
      // ),
      body: Column(
        children: [
          SizedBox(height: _size.height*0.07,),
          Container(
              height: _size.height*0.1,
              margin: const EdgeInsets.only(left: 25.0,right: 25),
              decoration: BoxDecoration(
                color: Colors.deepOrange[200],
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade800,
                    offset: const Offset(4,4),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                  const BoxShadow(
                    color: Colors.white70,
                    offset: Offset(-4,-4),
                    blurRadius: 15,
                    spreadRadius: 1,
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                        widget.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Switch(
                    onChanged: (bool value) { _greenArrowStatusChanger(); },
                    value: greenArrowStatus,
                    activeColor: Colors.deepOrange[300],
                  ),
                ],
              )
          ),
          Center(
            child: Column(
              children: [
                SizedBox(height: _size.height*0.05,),
                Container(
                  height: _size.height*0.45,
                  margin: const EdgeInsets.all(25.0),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange[200],
                    borderRadius: BorderRadius.circular(25.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade800,
                        offset: const Offset(4,4),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                      const BoxShadow(
                        color: Colors.white70,
                        offset: Offset(-4,-4),
                        blurRadius: 15,
                        spreadRadius: 1,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: TextField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              labelText: 'Waist Size',
                              hintText: 'Enter Waist Size',
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(r'([0-9]+\.?[0-9]*|\.[0-9]+)')),
                            ],
                            controller: t1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: TextField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              labelText: 'Fractions',
                              hintText: 'Enter no of Kali',
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            ],
                            controller: t2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: _size.height*0.03,),
                Container(
                  height: 60,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.deepOrange[300],
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade800,
                        offset: const Offset(4,4),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                      const BoxShadow(
                        color: Colors.white70,
                        offset: Offset(-4,-4),
                        blurRadius: 15,
                        spreadRadius: 1,
                      )
                    ],
                  ),
                  child: TextButton(
                      onPressed: _calculateFraction,
                      child: const Text(
                            'Calculate',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveScale() async {
    final imageFile = await screenshotController.capture(delay: const Duration(milliseconds: 10));
    if (imageFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = await File('${directory.path}/WaistSize-$waistSize-Kali-($parts).png').create();
      await imagePath.writeAsBytes(imageFile);
      await Share.shareFiles([imagePath.path],text:'Waist Size : $waistSize and No of Kali : $parts');
    }
  }
}
