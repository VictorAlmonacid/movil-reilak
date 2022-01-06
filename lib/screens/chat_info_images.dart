

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reilak_app/models/images_chat_response.dart';
import 'package:reilak_app/services/chat_service.dart';

class ChatInfoImages extends StatefulWidget {

  @override
  State<ChatInfoImages> createState() => _ChatInfoImagesState();
}

class _ChatInfoImagesState extends State<ChatInfoImages> {
    ChatService? chatService;
      List<Message> _images = [];
      

      @override
      void initState() {
        super.initState();
        this.chatService = Provider.of<ChatService>(context, listen: false);
        _cargarImgsChat(chatService!.chatSelecionado!.id);
      }

        void _cargarImgsChat(String chatId) async {
    List<Message> chat = await this.chatService?.getImgChat(chatId);
    print(chat);
    setState(() {
      _images.insertAll(0, chat);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Imagenes'),
      ),
      body:  SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: <Widget>[
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _images.length,
                    itemBuilder: (context, index) {
                      return FadeInImage(
                                      placeholder:
                                          AssetImage('assets/no-image.jpg'),
                                      image: NetworkImage(
                                        _images[index].message
                                          ),
                                      fit: BoxFit.cover,
                                    );
                    })
              ],
            ),
          ),
    );
  }
}
