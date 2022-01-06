import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reilak_app/models/user_response.dart';
import 'package:reilak_app/services/chat_service.dart';

class ChatCreateGroup extends StatefulWidget {
  const ChatCreateGroup({ Key? key }) : super(key: key);

  @override
  State<ChatCreateGroup> createState() => _ChatCreateGroupState();
}

class _ChatCreateGroupState extends State<ChatCreateGroup> {

    ChatService? chatService;
  List<Usuario> _usuarios = [];

  List<int> _selectedItems = [];

  @override
  void initState() {
    super.initState();
    this.chatService = Provider.of<ChatService>(context, listen: false);
    _cargarUsers();
  }

  void _cargarUsers() async {
    List<Usuario> chat = await this.chatService?.getUsers();

    setState(() {
      _usuarios.insertAll(0, chat);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccionar miembros'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: Column(
        children: [
          Divider(),
          ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: _usuarios.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                color: (_selectedItems.contains(index)) ? Colors.blue.withOpacity(0.5) : Colors.transparent,
                child: GestureDetector(
                  onTap: (){
                    if(_selectedItems.contains(index)){
                      setState(() {
                        print('si');
                        _selectedItems.removeWhere((val) => val == index);
                      });
                    }
                  },
                  onLongPress: (){
                    if(! _selectedItems.contains(index)){
                    setState(() {
                      _selectedItems.add(index);
                    });
                  }
                  },
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
            floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'chat_group_descrip');
        },
        child: Icon(
          Icons.send,
          color: Colors.white,
        ),
      ),
    );
  }
}