import 'package:flutter/material.dart';


class LoadingColumn extends StatelessWidget {
   LoadingColumn({Key? key, required this.message}) : super(key: key);

  String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        CircularProgressIndicator(),
        SizedBox(height: 10,),
        Text('$message.....'),
      ],),
    );
  }
}