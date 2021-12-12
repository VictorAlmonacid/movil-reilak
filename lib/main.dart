import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reilak_app/providers/ui_provider.dart';
import 'package:reilak_app/screens/chat_history.dart';
import 'package:reilak_app/screens/loading_screen.dart';
import 'package:reilak_app/screens/screens.dart';
import 'package:reilak_app/services/auth_service.dart';
import 'package:reilak_app/services/chat_service.dart';
import 'package:reilak_app/services/post_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> new UiProvider()),
        ChangeNotifierProvider(create: (_)=> AuthService()),
        ChangeNotifierProvider(create: (_)=> PostService()),
        ChangeNotifierProvider(create: (_)=> ChatService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Reilak App',
        initialRoute: 'loading',
        routes: {
          'home':(_)=> HomeScreen(),
          'task':(_)=> TaskScreen(),
          'chat':(_)=> ChatScreen(),
          'calendario':(_)=> CalendarioScreen(),
          'user':(_)=> userScreen(),
          'chat_history':(_)=> ChatHistoryScreen(),
          'login':(_)=> LoginScreen(),
          'loading':(_)=> LoadingScreen(),
        },
        theme: ThemeData(
          primarySwatch: colorCustom,
          
        ),
      ),
    );
  }
}

Map<int, Color> color =
{
50:Color.fromRGBO(136,14,79, .1),
100:Color.fromRGBO(136,14,79, .2),
200:Color.fromRGBO(136,14,79, .3),
300:Color.fromRGBO(136,14,79, .4),
400:Color.fromRGBO(136,14,79, .5),
500:Color.fromRGBO(136,14,79, .6),
600:Color.fromRGBO(136,14,79, .7),
700:Color.fromRGBO(136,14,79, .8),
800:Color.fromRGBO(136,14,79, .9),
900:Color.fromRGBO(136,14,79, 1),
};
MaterialColor colorCustom = MaterialColor(0xFF9146FF, color);