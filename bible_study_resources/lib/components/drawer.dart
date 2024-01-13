import "package:bible_study_resources/components/drawer_tile.dart";
import "package:bible_study_resources/models/api_connection.dart";
import "package:bible_study_resources/pages/audio_player_test.dart";
import 'package:bible_study_resources/pages/manna_page.dart';
import "package:bible_study_resources/pages/songs_night_page.dart";
import "package:flutter/material.dart";

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    const int DAILY_MANNA = 0;
    const int NIGHT_MANNA = 1;
    return Drawer(
        backgroundColor: Colors.grey[200],
        child: Column(
          children: [
            // header
            DrawerHeader(
              child: Image.asset('lib/assets/books.png', height: 90, width: 90),
            ),

            const SizedBox(height: 25),

            // notes tile
            DrawerTile(
              title: "Bible",
              leading: const Icon(Icons.book),
              onTap: () => Navigator.pop(context),
            ),

            DrawerTile(
              title: "Daily Heavenly Manna",
              leading: const Icon(Icons.book_outlined),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MannaPage(
                      MANNA_TYPE: DAILY_MANNA,
                    ),
                  ),
                );
              },
            ),

            DrawerTile(
              title: "Songs in the Night",
              leading: const Icon(Icons.book_online_outlined),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MannaPage(
                      MANNA_TYPE: NIGHT_MANNA,
                    ),
                  ),
                );
              },
            ),

            DrawerTile(
              title: "Latest Sermons",
              leading: const Icon(Icons.audio_file),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ApiConnection(),
                  ),
                );
              },
            ),

            // set
          ],
        ));
  }
}
