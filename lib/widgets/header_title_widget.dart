import 'package:flutter/material.dart';

class HeaderTitleWidget extends StatelessWidget {
  String? title;
  HeaderTitleWidget({super.key,this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 20
      ),
      width: double.infinity,
      child: Text(
        textAlign: TextAlign.center,
        "$title",
        style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700
        ),
      ),
    );
  }
}
