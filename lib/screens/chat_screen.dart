import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reilak_app/models/chat_response.dart';
import 'package:reilak_app/services/chat_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';



class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  final chatService = new ChatService();

  List<Chat> chats = [];

  @override
  void initState() {
    _cargarPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (AppBar(
        title: Text('Chats'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      )),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (
                BuildContext context,
                int index,
              ) =>
                  Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {
                    final chatService = Provider.of<ChatService>(context, listen: false);
                    chatService.chatSelecionado = chats[index];
                    Navigator.pushNamed(context, 'chat_history');
                  },
                  child: Row(
                    children: [
                      ClipOval(
                        child: Image.network(
                          chats[index].img != null
                              ? chats[index].img.toString()
                              : chats[index].user[0].imgusuario.toString(),
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                chats[index].name != null
                                    ? chats[index].name.toString()
                                    : '${chats[index].user[0].name} ${chats[index].user[0].segundoNombre} ${chats[index].user[0].apellidoPaterno} ${chats[index].user[0].apellidoMaterno}',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Opacity(
                                opacity: 0.64,
                                child: Text(
                                  chats[index].lastmessage?[0].message ?? '' ,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Opacity(opacity: 0.64, child: Text(DateFormat('kk:mm dd-MM').format(
                                            chats[index].lastmessage![0]
                                                .fecha
                                                .toUtc()
                                                .toLocal()))),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.person_add_alt_1,
          color: Colors.white,
        ),
      ),
    );
  }

  _cargarPosts() async {
    this.chats = await chatService.getChats();
    setState(() {});

    _refreshController.refreshCompleted();
  }
}
