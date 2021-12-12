import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reilak_app/models/post_response.dart';
import 'package:reilak_app/services/auth_service.dart';
import 'package:reilak_app/services/post_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:reilak_app/widgets/widgets.dart';
import 'package:video_player/video_player.dart';
import 'package:better_player/better_player.dart';

class PostListScreen extends StatefulWidget {
  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  VideoPlayerController? _controller;
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  final postService = new PostService();

  List<Publicacione> posts = [];

  @override
  void initState() {
    // TODO: implement initState
    this._cargarPosts();
    super.initState();
    initializeDateFormatting('es_ES', null);
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;
    return Column(
      children: [
        Divider(
          color: Colors.white.withOpacity(0.3),
        ),
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: posts.length,
            itemBuilder: (_, int index) => Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Container(
                      padding: EdgeInsets.only(top: 10, bottom: 5),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        posts[index].titulo,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        DateFormat('dd-MM-yyyy kk:mm').format(
                                            posts[index]
                                                .fecha
                                                .toUtc()
                                                .toLocal()),
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  // IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))
                                ],
                              ),
                            ),
                            Container(
                                child: Html(
                              data: posts[index].contenido,
                            )),
                            for (int i = 0;
                                i < posts[index].multimedia.length;
                                i++)
                              posts[index].multimedia[i].substring(posts[index].multimedia[i].length-3) ==
                                      'mp4'
                                  ? Container(
                                      child: BetterPlayer.network(
                                        posts[index].multimedia[i],
                                        betterPlayerConfiguration:
                                            BetterPlayerConfiguration(
                                          aspectRatio: 1.5,
                                          looping: false,
                                          autoPlay: false,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    )
                                  : FadeInImage(
                                      placeholder:
                                          AssetImage('assets/logo.png'),
                                      image: NetworkImage(
                                          posts[index].multimedia[i]),
                                      fit: BoxFit.cover,
                                    ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 3.0),
                              child: Row(
                                children: [
                                  posts[index].reaccion.contains(usuario?.uid)
                                      ? IconButton(
                                          onPressed: () async {
                                            final loginOk = await postService
                                                .reaction(posts[index].id);
                                            if (loginOk) {
                                              setState(() {_cargarPosts();});
                                            }
                                          },
                                          icon: Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                            size: 40,
                                          ),
                                        )
                                      : IconButton(
                                          onPressed: () async {
                                            final loginOk = await postService
                                                .reaction(posts[index].id);
                                            
                                              setState(() {_cargarPosts();});
                                            
                                          },
                                          icon: Icon(
                                            Icons.favorite_border_outlined,
                                            // color: Colors.red,
                                            size: 40,
                                          ),
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Text(
                                      posts[index].reaccion.length.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
      ],
    );
  }

  _cargarPosts() async {
    this.posts = await postService.getPosts();
    setState(() {});

    _refreshController.refreshCompleted();
  }
}
