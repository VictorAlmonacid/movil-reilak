// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reilak_app/models/chat_response.dart';
import 'package:reilak_app/models/login_response.dart';
import 'package:reilak_app/models/messageResponse.dart';
import 'package:reilak_app/models/user.dart';
import 'package:reilak_app/services/auth_service.dart';
import 'package:reilak_app/services/chat_service.dart';
import 'package:better_player/better_player.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:reilak_app/services/chat_users_service.dart';
import 'package:reilak_app/services/socket_service.dart';
import 'package:jiffy/jiffy.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';

class ChatHistoryScreen extends StatefulWidget {
  @override
  State<ChatHistoryScreen> createState() => _ChatHistoryScreenState();
}

class _ChatHistoryScreenState extends State<ChatHistoryScreen> {
  ChatService? chatService;
  ChatUsersService? chatUsersService;
  SocketService? socketService;
  LoginResponse? usuario;
  AuthService? authService;

  List<Chat> chats = [];

  final _textController = new TextEditingController();
  bool emojiShowing = false;
  _onEmojiSelected(Emoji emoji) {
    _textController
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _textController.text.length));
  }

  _onBackspacePressed() {
    _textController
      ..text = _textController.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _textController.text.length));
  }

  File? fileSelected;

  final _focusNode = new FocusNode();
  bool _estaEscribiendo = false;
  List<Message> _messages = [];

  @override
  void initState() {
    this.chatService = Provider.of<ChatService>(context, listen: false);
    this.chatUsersService =
        Provider.of<ChatUsersService>(context, listen: false);
    this.socketService = Provider.of<SocketService>(context, listen: false);
    this.authService = Provider.of<AuthService>(context, listen: false);
    this.socketService!.socket.on('send-message', _escucharMensaje);
    if (chatService!.chatSelecionado != null) {
      chatUsersService!.usuarioSeleccionado = null;
      _cargarHistorial(chatService!.chatSelecionado!.id);
    }

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          emojiShowing = false;
        });
      }
    });
    super.initState();
  }

  void _cargarHistorial(String chatId) async {
    List<Message> chat = await this.chatService?.getChat(chatId);
    print(chat);
    setState(() {
      _messages.insertAll(0, chat);
    });
    initializeDateFormatting('es_ES', null);
  }

  void _escucharMensaje(dynamic payload) async{
    // if(payload['_id'] != chatService!.chatSelecionado!.id){
    //   chatService!.chatSelecionado = payload['_id'];
    //   _cargarHistorial(payload['_id']);
    // }
    print(payload['fecha']);
    Message message = new Message(
      id: payload['_id'],
      from: payload['from'],
      to: payload['to'],
      message: payload['message'],
      fecha: DateTime.parse(payload['fecha']),
      name: payload['name'],
      segundoNombre: payload['segundoNombre'],
      apellidoPaterno: payload['apellidoPaterno'],
      apellidoMaterno: payload['apellidoMaterno'],
      imgusuario: payload['imgusuario'],
    );
    if (chatService!.chatSelecionado == null) {
      print('chat nuevo');
      await _cargarPosts();
 
     List<Chat> data = chats.where((element) => element.id == payload['to']).toList();
      chatService!.chatSelecionado = data[0];
      setState(() {
        
      });
      print('chats: ${chats.toString()}');
      print('chatnuevo: ${chats[0].id.toString()}');
      print('chatpayload: ${payload['to']}');
      print('chatservice: ${chatService!.chatSelecionado}');
      print('data: ${data.toString()}');
      
    }
    if (chatService!.chatSelecionado != null){
      print('es distinto de null');
    if (payload['to'] == chatService!.chatSelecionado!.id) {
      setState(() {
        _messages.insert(0, message);
      });
    }
    }


  }

  _cargarPosts() async {
    this.chats = await chatService!.getChats();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final chatService = Provider.of<ChatService>(context);
    final chatPara = chatService.chatSelecionado;
    final chatUsersService = Provider.of<ChatUsersService>(context);
    final chatUsersPara = chatUsersService.usuarioSeleccionado;
    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;

    final dataChat = chatUsersPara != null ? chatUsersPara : chatPara;
    print('114: ${dataChat}');
    return Scaffold(
        appBar: appBar(dataChat),
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
                  itemBuilder: (
                    BuildContext context,
                    int index,
                  ) =>
                      Row(
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
                  reverse: true,
                ),
              ),
              chatPara?.tipo != null
                  ? chatPara!.tipo == 'canal'
                      ? chatPara.admin!.contains(authService.usuario!.uid)
                          ? _chatInputField()
                          : _ChatNada()
                      : _chatInputField()
                  : _chatInputField(),
              Offstage(
                offstage: !emojiShowing,
                child: SizedBox(
                  height: 250,
                  child: EmojiPicker(
                      onEmojiSelected: (Category category, Emoji emoji) {
                        _onEmojiSelected(emoji);
                      },
                      onBackspacePressed: _onBackspacePressed,
                      config: Config(
                          columns: 7,
                          // Issue: https://github.com/flutter/flutter/issues/28894
                          emojiSizeMax: 32 * 1.0,
                          verticalSpacing: 0,
                          horizontalSpacing: 0,
                          initCategory: Category.RECENT,
                          bgColor: const Color(0xFFF2F2F2),
                          indicatorColor: Colors.blue,
                          iconColor: Colors.grey,
                          iconColorSelected: Colors.blue,
                          progressIndicatorColor: Colors.blue,
                          backspaceColor: Colors.blue,
                          showRecentsTab: true,
                          recentsLimit: 28,
                          noRecentsText: 'No Recents',
                          noRecentsStyle: const TextStyle(
                              fontSize: 20, color: Colors.black26),
                          tabIndicatorAnimDuration: kTabScrollDuration,
                          categoryIcons: const CategoryIcons(),
                          buttonMode: ButtonMode.MATERIAL)),
                ),
              ),
            ],
          ),
        ]));
  }

  Widget _chatInputField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 8,
          ),
          // Icon(
          //   Icons.camera_alt,
          //   color: Color(0xFF9146FF),
          // ),
          SizedBox(
            width: 10,
          ),
          IconButton(
            icon: Icon(
              Icons.attach_file_rounded,
              color: Color(0xFF9146FF),
            ),
            onPressed: () async {
              final result = await FilePicker.platform.pickFiles();
              final file = result!.files.first;
              // fileSelected = file;
              print('es: $file');
            },
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
                  IconButton(
                    icon: Icon(
                      Icons.sentiment_satisfied_alt_outlined,
                      color: Color(0xFF9146FF),
                    ),
                    onPressed: () {
                      _focusNode.unfocus();
                      _focusNode.canRequestFocus = false;
                      setState(() {
                        emojiShowing = !emojiShowing;
                      });
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      onSubmitted: _handleSubmit,
                      onChanged: (String texto) {
                        setState(() {
                          if (texto.trim().length > 0) {
                            _estaEscribiendo = true;
                          } else {
                            _estaEscribiendo = false;
                          }
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Mensaje",
                        border: InputBorder.none,
                      ),
                      focusNode: _focusNode,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          IconTheme(
            data: IconThemeData(
              color: Color(0xFF9146FF),
            ),
            child: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Icon(
                Icons.send,
              ),
              onPressed: _estaEscribiendo
                  ? () => _handleSubmit(_textController.text)
                  : null,
            ),
          ),
          SizedBox(
            width: 5,
          ),
        ],
      ),
    );
  }

  Widget _ChatNada() {
    return Container(
      child: Center(
        child: null,
      ),
    );
  }

  AppBar appBar(chatPara) {
    return AppBar(
      automaticallyImplyLeading: true,
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage:
                NetworkImage(identical(chatService!.chatSelecionado, chatPara)
                    ? chatPara.img != null
                        ? chatPara.img
                        : chatPara.user[0].imgusuario.toString()
                    : identical(chatUsersService!.usuarioSeleccionado, chatPara)
                        ? chatPara.imgusuario.toString()
                        : ''),
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
                  // Text(
                  //   'Activo hace 3m',
                  //   style: TextStyle(fontSize: 12),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.info),
          onPressed: () {
            final chatService =
                Provider.of<ChatService>(context, listen: false);
            chatService.chatSelecionado = chatPara;
            print(chatPara);
            Navigator.pushNamed(context, 'chat_info');
          },
        ),
        SizedBox(
          width: 9,
        ),
      ],
    );
  }

  _handleSubmit(String texto) {
    _textController.clear();
    _focusNode.requestFocus();

    setState(() {
      _estaEscribiendo = false;
    });
    this.socketService!.emit('send-message', {
      'from': authService?.usuario!.uid,
      'to': chatService!.chatSelecionado != null
          ? chatService!.chatSelecionado!.id
          : chatUsersService!.usuarioSeleccionado!.id,
      'message': texto,
      'viewedby': [
        {'_id': authService!.usuario!.uid, 'fecha': DateTime.now().toString()}
      ],
    });
  }

  @override
  void dispose() {
    this.socketService!.socket.off('send-message');
    super.dispose();
  }
}
