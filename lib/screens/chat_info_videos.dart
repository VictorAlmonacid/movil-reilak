

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reilak_app/models/images_chat_response.dart';
import 'package:reilak_app/services/chat_service.dart';
import 'package:better_player/better_player.dart';

class ChatInfoVideo extends StatefulWidget {

  @override
  State<ChatInfoVideo> createState() => _ChatInfoVideoState();
}

class _ChatInfoVideoState extends State<ChatInfoVideo> {
    ChatService? chatService;
      List<Message> _videos = [];
      

      @override
      void initState() {
        super.initState();
        this.chatService = Provider.of<ChatService>(context, listen: false);
        _cargarVideosChat(chatService!.chatSelecionado!.id);
      }

        void _cargarVideosChat(String chatId) async {
    List<Message> chat = await this.chatService?.getVideoChat(chatId);
    print(chat);
    setState(() {
      _videos.insertAll(0, chat);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Videos'),
      ),
      body:  SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: <Widget>[
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _videos.length,
                    itemBuilder: (context, index) {
                      return Container(
                                      child: BetterPlayer.network(
                                        _videos[index].message,
                                        betterPlayerConfiguration:
                                            BetterPlayerConfiguration(
                                          aspectRatio: 1.5,
                                          looping: false,
                                          autoPlay: false,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    );
                    })
              ],
            ),
          ),
    );
  }
}
