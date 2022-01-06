import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reilak_app/models/chat_response.dart';
import 'package:reilak_app/models/user_response.dart';
import 'package:reilak_app/services/auth_service.dart';
import 'package:reilak_app/services/chat_service.dart';
import 'package:reilak_app/services/chat_users_service.dart';

class ChatCreateRoom extends StatefulWidget {
  const ChatCreateRoom({Key? key}) : super(key: key);

  @override
  State<ChatCreateRoom> createState() => _ChatCreateRoomState();
}

class _ChatCreateRoomState extends State<ChatCreateRoom> {
  ChatService? chatService;
  ChatUsersService? chatUsersService;
  AuthService? authService;

  
  List<Usuario> _usuarios = [];
List<Chat> _chats = [];

  @override
  void initState() {
    super.initState();
    this.chatService = Provider.of<ChatService>(context, listen: false);
    this.chatUsersService = Provider.of<ChatUsersService>(context, listen: false);
    this.authService = Provider.of<AuthService>(context, listen: false);
    _cargarUsers();
     _cargarPosts();
  }

 _cargarUsers() async {
    List<Usuario> chat = await this.chatService?.getUsers();
    List<Usuario> chatUser = chat.where((element) => element.id != authService!.usuario!.uid).toList();
    setState(() {
      _usuarios.insertAll(0, chatUser);
    });
  }

   void _cargarPosts() async {
    this._chats = await chatService!.getChats();
    setState(() {});

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar Conversacion'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: Column(
        children: [
          // TextButton(
          //   onPressed: () {
          //     Navigator.pushNamed(context, 'chat_create_group');
          //   },
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       Icon(Icons.video_call),
          //       Text('Crear grupo',
          //           style: TextStyle(
          //               fontSize: 20,
          //               fontWeight: FontWeight.bold,
          //               color: Colors.black)),
          //     ],
          //   ),
          // ),
          // TextButton(
          //   onPressed: () {
          //     //              final chatService =
          //     //     Provider.of<ChatService>(context, listen: false);
          //     // chatService.chatSelecionado = chatPara ;
          //     // print(chatPara);
          //     // Navigator.pushNamed(context, 'chat_info_videos');
          //   },
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       Icon(Icons.video_call),
          //       Text('Crear canal',
          //           style: TextStyle(
          //               fontSize: 20,
          //               fontWeight: FontWeight.bold,
          //               color: Colors.black)),
          //     ],
          //   ),
          // ),
          Divider(),
   
          ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: _usuarios.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: (){
                  _handlePreactiveChat(_usuarios[index]);
                  // Navigator.pushNamed(context, 'chat_history');
                },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(_usuarios[index].imgusuario),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(_usuarios[index].name +' '+ _usuarios[index].segundoNombre +' '+ _usuarios[index].apellidoPaterno +' '+ _usuarios[index].apellidoMaterno, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                ),
                              ],
                            ),
                ),
              );
            },
          ),

        ],
      ),
    );
  }

  void _handlePreactiveChat(dat){
    
  final data = _chats.where((element) => element.members.contains(dat.id)  && element.tipo == "personal");
  if(data.isNotEmpty){
    final activeChat = data.first;
    print('Existe chat');
                               final chatService =
                  Provider.of<ChatService>(context, listen: false);
              chatService.chatSelecionado =  activeChat;
    Navigator.pushNamed(context, 'chat_history');
    
    
  }else{
    print('No existe chat');

    // final preChat = {'name': dat.name, 'id':dat};

    final chatUsersService =
                  Provider.of<ChatUsersService>(context, listen: false);
              chatUsersService.usuarioSeleccionado =  dat;
                            final chatService =
                  Provider.of<ChatService>(context, listen: false);
              chatService.chatSelecionado =  null;
    Navigator.pushNamed(context, 'chat_history');
  }
}
}

