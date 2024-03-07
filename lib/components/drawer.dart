import 'package:bible_study_resources/book_api/book_page_api.dart';
import "package:bible_study_resources/components/drawer_tile.dart";
import 'package:bible_study_resources/pages/sermons_page.dart';
import 'package:bible_study_resources/pages/manna_page.dart';
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
              title: "The Bible",
              leading:
                  Image.asset('lib/assets/book.png', height: 50, width: 50),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookPageAPI(),
                  ),
                );
              },
            ),
            const SizedBox(height: 25),
            DrawerTile(
              title: "Daily Heavenly Manna",
              leading: Image.asset('lib/assets/manna_daily.png',
                  height: 50, width: 50),
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
            const SizedBox(height: 25),
            DrawerTile(
              title: "Songs in the Night",
              leading: Image.asset('lib/assets/manna_night.png',
                  height: 50, width: 50),
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
            const SizedBox(height: 25),
            DrawerTile(
              title: "Latest Sermons",
              leading:
                  Image.asset('lib/assets/sermon.png', height: 50, width: 50),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SermonsPage(),
                  ),
                );
              },
            ),

            // set
          ],
        ));
  }
}
