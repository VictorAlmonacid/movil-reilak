import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reilak_app/models/login_response.dart';
import 'package:reilak_app/models/messageResponse.dart';
import 'package:reilak_app/models/user.dart';
import 'package:reilak_app/services/auth_service.dart';
import 'package:reilak_app/services/chat_service.dart';
import 'package:better_player/better_player.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class ChatHistoryScreen extends StatefulWidget {
  @override
  State<ChatHistoryScreen> createState() => _ChatHistoryScreenState();
}

class _ChatHistoryScreenState extends State<ChatHistoryScreen> {
  ChatService? chatService;
  LoginResponse? usuario;

  List<Message> _messages = [];

  @override
  void initState() {
    this.chatService = Provider.of<ChatService>(context, listen: false);
    _cargarHistorial(chatService!.chatSelecionado!.id);
    super.initState();
  }

  void _cargarHistorial(String chatId) async {
    List<Message> chat = await this.chatService?.getChat(chatId);
    print(chat);
    setState(() {
      _messages.insertAll(0, chat.reversed);
    });
    initializeDateFormatting('es_ES', null);
  }

  @override
  Widget build(BuildContext context) {
    final chatService = Provider.of<ChatService>(context);
    final chatPara = chatService.chatSelecionado;
    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;
    return Scaffold(
        appBar: appBar(chatPara),
        body: Stack(children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQr2MPe3L82v-Tq_zh6V37dh_O2URxnEnvEwB0lSCupIRC8tGkdHj4it79kjUA_YoWvnGM&usqp=CAU'),
                  fit: BoxFit.cover),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (BuildContext context, int index) => Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              _messages[index].from == usuario!.uid
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: _messages[index].from == usuario.uid
                                  ? EdgeInsets.only(top: 10, left: 90, right: 5)
                                  : EdgeInsets.only(
                                      top: 10, left: 5, right: 90),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: _messages[index].message.length > 3
                                  ? _messages[index].message.substring(
                                                  _messages[index].message.length -
                                                      3) ==
                                              'png' ||
                                          _messages[index].message.substring(
                                                  _messages[index].message.length -
                                                      3) ==
                                              'jpg' ||
                                          _messages[index].message.substring(
                                                  _messages[index].message.length -
                                                      3) ==
                                              'jpge' ||
                                          _messages[index].message.substring(
                                                  _messages[index].message.length -
                                                      3) ==
                                              'gif'
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            FadeInImage(
                                              placeholder:
                                                  AssetImage('assets/logo.png'),
                                              image: NetworkImage(
                                                  _messages[index].message),
                                              fit: BoxFit.cover,
                                            ),
                                            Text(
                                              DateFormat('kk:mm dd-MM').format(
                                                  _messages[index]
                                                      .fecha
                                                      .toUtc()
                                                      .toLocal()),
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        )
                                      : _messages[index].message.substring(
                                                  _messages[index].message.length -
                                                      3) ==
                                              'mp4'
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                BetterPlayer.network(
                                                  _messages[index].message,
                                                  betterPlayerConfiguration:
                                                      BetterPlayerConfiguration(
                                                    aspectRatio: 1.5,
                                                    looping: false,
                                                    autoPlay: false,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                                Text(
                                                  DateFormat('kk:mm dd-MM')
                                                      .format(_messages[index]
                                                          .fecha
                                                          .toUtc()
                                                          .toLocal()),
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 14),
                                                ),
                                              ],
                                            )
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  _messages[index].message,
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                                Text(
                                                  DateFormat('kk:mm dd-MM')
                                                      .format(_messages[index]
                                                          .fecha
                                                          .toUtc()
                                                          .toLocal()),
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 14),
                                                ),
                                              ],
                                            )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(_messages[index].message),
                                        Text(
                                          DateFormat('kk:mm dd-MM').format(
                                              _messages[index]
                                                  .fecha
                                                  .toUtc()
                                                  .toLocal()),
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ChatInputField()
            ],
          ),
        ]));
  }

  AppBar appBar(chatPara) {
    return AppBar(
      automaticallyImplyLeading: true,
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              chatPara.img != null
                  ? chatPara.img.toString()
                  : chatPara.user[0].imgusuario.toString(),
            ),
          ),
          SizedBox(
            width: 4,
          ),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      chatPara.name != null
                          ? chatPara.name.toString()
                          : '${chatPara.user[0].name} ${chatPara.user[0].segundoNombre} ${chatPara.user[0].apellidoPaterno} ${chatPara.user[0].apellidoMaterno}',
                      style: TextStyle(fontSize: 16),
                      overflow: TextOverflow.ellipsis),
                  Text(
                    'Activo hace 3m',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      actions: [
        Icon(Icons.info),
        SizedBox(
          width: 9,
        ),
      ],
    );
  }
}

class ChatInputField extends StatelessWidget {
  const ChatInputField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 8,
          ),
          Icon(
            Icons.camera_alt,
            color: Color(0xFF9146FF),
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.attach_file_rounded,
            color: Color(0xFF9146FF),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.sentiment_satisfied_alt_outlined,
                    color: Color(0xFF9146FF),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Mensaje",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.send,
            color: Color(0xFF9146FF),
          ),
          SizedBox(
            width: 5,
          ),
        ],
      ),
    );
  }
}
