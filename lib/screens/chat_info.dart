import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reilak_app/models/chat_response.dart';
import 'package:reilak_app/models/members_chat.dart';
import 'package:reilak_app/services/chat_service.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class ChatInfo extends StatefulWidget {
  @override
  State<ChatInfo> createState() => _ChatInfoState();
}

class _ChatInfoState extends State<ChatInfo> {
  ChatService? chatService;
  List<Miembro> _members = [];
  @override
  void initState() {
    super.initState();
    this.chatService = Provider.of<ChatService>(context, listen: false);
    _cargarMembers(chatService!.chatSelecionado!.id);
  }

  void _cargarMembers(String chatId) async {
    List<Miembro> chat = await this.chatService?.getMembersChat(chatId);

    setState(() {
      _members.insertAll(0, chat);
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatPara = chatService!.chatSelecionado;
    return Scaffold(
      appBar:
          AppBar(automaticallyImplyLeading: true, title: Text('Informacion')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        chatPara!.img != null
                            ? chatPara.img.toString()
                            : chatPara.user[0].imgusuario.toString(),
                      ),
                      radius: 75,
                    ),
                    Text(
                      chatPara.name != null
                          ? chatPara.name.toString()
                          : chatPara.user.first.name +
                              ' ' +
                              chatPara.user.first.segundoNombre +
                              ' ' +
                              chatPara.user.first.apellidoPaterno +
                              ' ' +
                              chatPara.user.first.apellidoMaterno,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Conversacion iniciada el ${DateFormat('dd-MM-yyyy').format(chatPara.fecha.toUtc().toLocal())}',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),

                    Container(
                      width: 350,
                      child: Text(
                        chatPara.descripcion != null? chatPara.descripcion as String : '',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                final chatService =
                    Provider.of<ChatService>(context, listen: false);
                chatService.chatSelecionado = chatPara;
                print(chatPara);
                Navigator.pushNamed(context, 'chat_info_images');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_alt),
                  Text(
                    'Imagenes',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                final chatService =
                    Provider.of<ChatService>(context, listen: false);
                chatService.chatSelecionado = chatPara;
                print(chatPara);
                Navigator.pushNamed(context, 'chat_info_videos');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.video_call),
                  Text('Videos',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Icon( chatPara.tipo != 'personal' ? Icons.people_alt: null),
                        Text(
                        chatPara.tipo != 'personal' ?  'Participantes ${chatPara.members.length}' : '',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    )
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        IconButton(onPressed: () {}, icon: Icon(chatPara.tipo != 'personal' ? Icons.add : null)),
                        IconButton(onPressed: () {}, icon: Icon(chatPara.tipo != 'personal' ? Icons.remove: null)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
         
          SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: <Widget>[
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _members.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(_members[index].imgusuario),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                _members[index].name +
                                    ' ' +
                                    _members[index].segundoNombre +
                                    ' ' +
                                    _members[index].apellidoPaterno +
                                    ' ' +
                                    _members[index].apellidoMaterno,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      );
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
