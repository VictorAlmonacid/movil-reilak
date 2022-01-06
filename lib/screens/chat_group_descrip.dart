import 'package:flutter/material.dart';

class ChatGroupDescrip extends StatelessWidget {
  const ChatGroupDescrip({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
        title: Text('Descripcion'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: Column(children: [
        
      ],),
       floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'chat');
        },
        child: Icon(
          Icons.check,
          color: Colors.white,
        ),
      )
      ,
    );
  }
}