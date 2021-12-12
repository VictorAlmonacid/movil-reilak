import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reilak_app/providers/ui_provider.dart';
import 'package:reilak_app/providers/ui_provider.dart';
import 'package:reilak_app/screens/screens.dart';
import 'package:reilak_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      appBar: uiProvider.getSelectedMenuOpt!=2? AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Image.asset('assets/logo.png', fit: BoxFit.cover,
                  height: 22,),
            Container(padding: EdgeInsets.all(4.0), child: Text('Reilak', style: TextStyle(color: Color(0xFF9146FF), fontWeight: FontWeight.bold, fontSize: 28),)),
          ],
        ),
      ): null,

      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.getSelectedMenuOpt;

    switch(currentIndex){
      case 0:
      return PostScreen();

            case 1:
      return CalendarioScreen();

            case 2:
      return ChatScreen();

            case 3:
      return userScreen();

      default:
      return PostScreen();
    }
  }
}