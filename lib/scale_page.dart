import 'package:flutter/material.dart';
class ScalePage extends StatefulWidget {
  final double arrowPosition;

  final List<int> nums;

  final bool greenArrowStatus;
  final double spacing;

  const ScalePage(List<int> this.nums, double this.arrowPosition, bool this.greenArrowStatus, double this.spacing, {Key? key,}) : super(key: key);

  @override
  _ScalePageState createState() => _ScalePageState();
}

class _ScalePageState extends State<ScalePage>{

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.all(50.0),
          decoration: const BoxDecoration(
            //borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
              image: DecorationImage(fit: BoxFit.cover,
                image:  AssetImage('images/ScaleVertical.png'),)
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: widget.nums.map<Widget>((int num) {
            return Padding(
              padding: const EdgeInsets.only(top: 55,bottom: 55),
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
          top: widget.arrowPosition,
          //bottom: 50,
          left: 70,
          child: Row(
            children: const [
              Icon(Icons.arrow_back,color: Colors.deepOrangeAccent,size: 45,),
              SizedBox(width: 130,),
              Icon(Icons.arrow_forward,color: Colors.deepOrangeAccent,size: 45,),
            ],
          ),
        ),
        Visibility(
          visible: widget.greenArrowStatus,
          child: Positioned(
            top: widget.arrowPosition+widget.spacing,
            //bottom: 50,
            left: 70,
            child: Row(
              children: const [
                Icon(Icons.arrow_back,color: Colors.lightGreenAccent,size: 45,),
                SizedBox(width: 130,),
                Icon(Icons.arrow_forward,color: Colors.lightGreenAccent,size: 45,),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
