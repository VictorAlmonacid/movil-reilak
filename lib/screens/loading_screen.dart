import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reilak_app/screens/home_screen.dart';
import 'package:reilak_app/screens/login_screen.dart';
import 'package:reilak_app/services/auth_service.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: checkLoginState(context),
          builder: (context, snapshot) {
            return Center(
              child: Text('Espere...'),
            );
          }),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);

    final autenticado = await authService.isLoggedIn();

    if (autenticado) {
      // conectar al socket sever
      // Navigator.pushReplacementNamed(context, 'home');
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => HomeScreen(),
            transitionDuration: Duration(milliseconds: 0),
          ));
    } else {
      // Navigator.pushReplacementNamed(context, 'login');
       Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => LoginScreen(),
            transitionDuration: Duration(milliseconds: 0),
          ));
    }
  }
}
