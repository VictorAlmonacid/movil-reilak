import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reilak_app/helpers/show_alert.dart';
import 'package:reilak_app/services/auth_service.dart';
import 'package:reilak_app/services/socket_service.dart';

class LoginScreen extends StatelessWidget {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 100.0),
              child: Container(
                decoration: BoxDecoration(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        child: Image(
                          image: AssetImage('assets/logo.png'),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Login',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: emailCtrl,
                        enableInteractiveSelection: false,
                        autofocus: true,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: 'Email',
                            labelText: 'Email',
                            suffixIcon: Icon(Icons.alternate_email),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0))),
                      ),
                      Divider(
                        height: 20,
                        color: Colors.transparent,
                      ),
                      TextField(
                        autocorrect: false,
                        controller: passwordCtrl,
                        obscureText: true,
                        enableInteractiveSelection: false,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            labelText: 'Password',
                            suffixIcon: Icon(Icons.lock_outline),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0))),
                      ),
                      Divider(
                        height: 20,
                        color: Colors.transparent,
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        disabledColor: Colors.grey,
                        elevation: 0,
                        color: Color(0xFF9146FF),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 80, vertical: 15),
                          child: Text(
                            'Ingresar',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        // Navigator.pushNamed(context, 'home',
                        //     arguments: 'home')
                        onPressed: authService.getAutenticando ? null : ()async {
                          FocusScope.of(context).unfocus();
                          final loginOk = await authService.login(emailCtrl.text.trim(), passwordCtrl.text.trim());
                          if(loginOk){
                            socketService.connect();
                            //navegar
                            Navigator.pushReplacementNamed(context, 'home');
                          }else{
                            //mostrar alerta
                            showAlert(context, 'Login incorrecto', 'Revise sus credenciales');

                          }
                        } ,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
