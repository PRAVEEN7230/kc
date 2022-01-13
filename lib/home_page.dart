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
                  //title: const Text('Scale'),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0))
                  ),
                  content: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: const DecorationImage(
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.medium,
                              image:  AssetImage('images/ScaleVertical.png'),)
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
                        top: arrowPosition,
                        //bottom: 50,
                        left: width*0.04,
                        child: Row(
                          children: [
                            const Icon(Icons.arrow_back,color: Colors.deepOrangeAccent,size: 45,),
                            SizedBox(width: width*0.315,),
                            const Icon(Icons.arrow_forward,color: Colors.deepOrangeAccent,size: 45,),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: greenArrowStatus,
                        child: Positioned(
                          top: arrowPosition+spacing,
                          //bottom: 50,
                          left: width*0.04,
                          child: Row(
                            children: [
                              const Icon(Icons.arrow_back,color: Colors.lightGreenAccent,size: 45,),
                              SizedBox(width: width*0.315,),
                              const Icon(Icons.arrow_forward,color: Colors.lightGreenAccent,size: 45,),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -5,
                        right: 0,
                        child: MaterialButton(
                          onPressed: _saveScale,
                          color: Colors.deepOrangeAccent,
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
        } on Exception catch (e) {
           _showSnackBar('Invalid Input!! Try Again');
        }
    });
  }

  void _showSnackBar(String message){
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(widget.title),
            ),
          ],
        ),
        actions: [
          Switch(
            onChanged: (bool value) { _greenArrowStatusChanger(); },
            value: greenArrowStatus,
            activeColor: Colors.lightGreenAccent,
          ),
          const SizedBox(width: 20,),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 40,),
            Container(
              height: MediaQuery.of(context).size.height*0.45,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(25.0),
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: const [
                  BoxShadow(color: Color(0xE5FF1B1B), blurRadius: 12.0 ),
                  BoxShadow(color: Color(0xADCB6D2F), blurRadius: 40.0)
                ],
                border: Border.all(
                  width: 3.0,
                  color: Colors.deepOrange,
                ),
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
            const SizedBox(height: 20,),
            SizedBox(
              height: 60,
              width: 200,
              child: FloatingActionButton.extended(
                  onPressed: _calculateFraction,
                  tooltip: 'Calculate',
                  label: const Text(
                      'Calculate',
                    style: TextStyle(
                              fontSize: 30,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                            ),
                  )
              ),
            )
            // SizedBox(
            //   height: 60,
            //   width: 220,
            //   child: ElevatedButton(
            //     onPressed: (){
            //       _calculateFraction();
            //     },
            //     style: ElevatedButton.styleFrom(
            //       onPrimary: Colors.white,
            //       textStyle: const TextStyle(
            //         fontSize: 30,
            //         fontStyle: FontStyle.italic,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //     child: const Text('Calculate',),
            //   ),
            // ),
          ],
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  Future<void> _saveScale() async {
    final imageFile = await screenshotController.capture(delay: const Duration(milliseconds: 10));
    if (imageFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = await File('${directory.path}/WaistSize-$waistSize-Kali-($parts).png').create();
      await imagePath.writeAsBytes(imageFile);
      print(imagePath);
      await Share.shareFiles([imagePath.path],text:'Waist Size : $waistSize and No of Kali : $parts');
    }
  }
}
