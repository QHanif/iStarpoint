import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final void Function()? onPressed;
  const MyTextBox({
    super.key,
    required this.text,
    required this.sectionName,
    required this.onPressed,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent),
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: const EdgeInsets.only(left: 15,bottom:15),
      margin: const EdgeInsets.only(left:20,right:20,top:20),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(sectionName,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              IconButton(
                onPressed: onPressed,
                icon: Icon(Icons.edit),
              )
            ],
          )
        ],
      )
    );
  }
}