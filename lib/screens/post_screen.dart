import 'package:flutter/material.dart';
import 'package:reilak_app/widgets/widgets.dart';

class PostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
    
      child: Column(
        children: [
          // cunpleaños
          BirthdaySlider(),

          // publicaciones

          PostListScreen()
          
        ],
      ),
    );
  }
}
