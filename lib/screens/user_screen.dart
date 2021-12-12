import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reilak_app/services/auth_service.dart';

class userScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5.0, top: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                      //   backgroundImage: NetworkImage(
                      //       'https://www.anmosugoi.com/wp-content/uploads/2021/04/Konata-Izumi.3-1068x601.jpg'),
                      //   radius: 40,
                      // ),
                      backgroundImage: NetworkImage(usuario?.imgusuario.toString() ?? 'assets/no-image.jpg'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${usuario?.name ?? ''} ${usuario?.segundoNombre ?? ''}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${usuario?.apellidoPaterno ?? ''} ${usuario?.apellidoMaterno ?? ''}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              Icon(
                Icons.settings,
                size: 40,
              ),
            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  disabledColor: Colors.blueGrey[50],
                  elevation: 0,
                  color: Colors.grey,
                  child: Container(
            
                    child: Row(
                      children: [
                        Text(
                          'Cerrar Sesion',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Icon(Icons.exit_to_app, color: Colors.white,),
                        Divider(color: Colors.transparent,)
                      ],
                    
                    ),
                  ),
                  // Navigator.pushNamed(context, 'home',
                  //     arguments: 'home')
                  onPressed: () {
                    //TODO: desconectarse socket servers

                  AuthService.deleteToken();
                  Navigator.pushReplacementNamed(context, 'login');
                  AuthService.deleteToken();

                  },
                ),
              ],
            )
          ],
        ),
        Divider(),
        // Text(
        //   'Dedicatorias por tu cumpleaños',
        //   style: TextStyle(
        //       fontSize: 17,
        //       fontWeight: FontWeight.bold,
        //       color: Color(0xFF9146FF)),
        // ),
        // Expanded(
        //   child: ListView.builder(
        //     itemCount: 2,
        //     itemBuilder: (BuildContext context, int index) => Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Container(
        //         color: Colors.white,
        //         child: Column(
        //           children: [
        //             Row(
        //               children: [
        //                 CircleAvatar(
        //                   backgroundImage: NetworkImage(
        //                       'https://facesymmetry.fun/images/person/sergio-ramos.jpg'),
        //                 ),
        //                 Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     Text(
        //                       'Yonathan Esteban Soto Martinez',
        //                       style: TextStyle(fontSize: 16),
        //                     ),
        //                     Text(
        //                       'Hace 5h',
        //                       style:
        //                           TextStyle(fontSize: 12, color: Colors.grey),
        //                     ),
        //                   ],
        //                 )
        //               ],
        //             ),
        //             Container(
        //               child: Text(
        //                 'Culpa velit anim velit ipsum in veniam ex in nisi nostrud excepteur elion ut. Labore deserunt labore enim et. Aliquip excepteur dolore eiusmod aliqua.',
        //                 style: TextStyle(fontSize: 16),
        //               ),
        //             ),
        //             FadeInImage(
        //               placeholder: AssetImage('assets/logo.png'),
        //               image: NetworkImage(
        //                   'https://images2-mega.cdn.mdstrm.com/etcetera/2021/01/04/14105_1_5ff3a618c952a.jpg?d=1200x500'),
        //               fit: BoxFit.cover,
        //             ),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.end,
        //               crossAxisAlignment: CrossAxisAlignment.end,
        //               children: [
        //                 Icon(
        //                   Icons.check_circle,
        //                   color: Color(0xFF9146FF),
        //                   size: 35,
        //                 ),
        //               ],
        //             )
        //           ],
        //         ),
        //       ),
        //     ),
        //   ),
        // )
      ],
    );
  }
}
