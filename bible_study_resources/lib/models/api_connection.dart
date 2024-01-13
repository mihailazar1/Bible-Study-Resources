import 'dart:convert';

import 'package:bible_study_resources/models/album.dart';
import 'package:bible_study_resources/models/audio_player_widget.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';

class ApiConnection extends StatefulWidget {
  const ApiConnection({super.key});

  @override
  State<ApiConnection> createState() => _ApiConnectionState();
}

class _ApiConnectionState extends State<ApiConnection> {
  bool _isPlayerVisible = false;

  Future<List<Album>> fetchAlbum() async {
    final response = await http
        .get(Uri.parse('https://5694-86-124-6-207.ngrok-free.app/api/sermons'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<Album> albums = [];
      List<dynamic> albumsJson = jsonDecode(response.body);

      albumsJson.forEach((oneAlbum) {
        Album album = Album.fromJson(oneAlbum);
        albums.add(album);
      });

      return albums;
    } else {
      throw Exception('Failed to load album');
    }
  }

  late Future<List<Album>> futureAlbums;

  @override
  void initState() {
    super.initState();
    futureAlbums = fetchAlbum();
  }

  AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue,
          title: Text("Latest Sermons",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white)),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: FutureBuilder<List<Album>>(
          future: futureAlbums,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    snapshot.data!.sort((a, b) {
                      int aNumber =
                          int.parse(a.Time.replaceAll(RegExp('[^0-9]'), ''));
                      int bNumber =
                          int.parse(b.Time.replaceAll(RegExp('[^0-9]'), ''));
                      return aNumber.compareTo(bNumber);
                    });

                    return Column(
                      children: ListTile.divideTiles(
                        context: context,
                        tiles: [
                          ListTile(
                            onTap: () {
                              setState(() {
                                _isPlayerVisible = true;
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AudioPlayerWidget(
                                      url: snapshot.data![index].Link,
                                      title: snapshot.data![index].Audio,
                                      subtitle: snapshot.data![index].Subfolder,
                                    ),
                                  ));
                            },
                            title: Text(snapshot.data![index].Audio),
                            subtitle: Text(
                              '${snapshot.data![index].Subfolder} - ${snapshot.data![index].Time}',
                              style: TextStyle(color: Colors.grey),
                            ),
                            dense: false,
                            textColor: Colors.blue[700],
                            contentPadding: EdgeInsets.all(5),
                          ),
                          Container(),
                        ],
                      ).toList(),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return Container();
          },
        ));
  }
}
