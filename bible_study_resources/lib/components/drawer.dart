import "package:bible_study_resources/components/drawer_tile.dart";
import 'package:bible_study_resources/pages/manna_page.dart';
import "package:bible_study_resources/pages/songs_night_page.dart";
import "package:flutter/material.dart";

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
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
                    builder: (context) => MannaPage(),
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
                    builder: (context) => SongsNightPage(),
                  ),
                );
              },
            ),

            // set
          ],
        ));
  }
}
