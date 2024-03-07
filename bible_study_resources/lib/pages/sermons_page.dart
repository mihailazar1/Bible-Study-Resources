import 'dart:convert';

import 'package:bible_study_resources/models/album.dart';
import 'package:bible_study_resources/models/audio_player_widget.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';

class SermonsPage extends StatefulWidget {
  const SermonsPage({super.key});

  @override
  State<SermonsPage> createState() => _SermonsPageState();
}

class _SermonsPageState extends State<SermonsPage> {
  Future<List<Album>> fetchAlbum() async {
    final response = await http.get(
        Uri.parse('https://72ec-109-166-137-50.ngrok-free.app/api/sermons'));

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
      throw Exception('Error: Check your internet connection!');
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
          title: const Text("Latest Sermons",
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
                            title: Text(snapshot.data![index].Audio,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500)),
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
