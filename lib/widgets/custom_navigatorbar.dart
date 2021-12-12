import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reilak_app/providers/ui_provider.dart';

class CustomNavigationBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

        final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.getSelectedMenuOpt;
    
    return BottomNavigationBar(
      onTap: (int i)=> uiProvider.setSelectedMenuOpt = i,
      elevation: 0,
      currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Calendario'),

          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      );
  }
}