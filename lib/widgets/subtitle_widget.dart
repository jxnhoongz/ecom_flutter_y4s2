import 'package:flutter/material.dart';

class SubtitleWidget extends StatelessWidget {
  String? subtitle;
  SubtitleWidget({super.key,this.subtitle});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(
          vertical: 5
      ),
      width: double.infinity,
      child: Text(
        textAlign: TextAlign.center,
        "$subtitle",
        style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500
        ),
      ),
    );
  }
}
