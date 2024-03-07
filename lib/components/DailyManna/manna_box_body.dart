import "package:bible_study_resources/models/database.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class MannaBoxBody extends StatefulWidget {
  final int MANNA_TYPE;
  const MannaBoxBody({super.key, required this.MANNA_TYPE});

  @override
  State<MannaBoxBody> createState() => _MannaBoxBodyState();
}

class _MannaBoxBodyState extends State<MannaBoxBody> {
  final int ALL_VERSE = 0;
  final int VERSE_NO_REFERENCE = 1;
  final int ONLY_REFERENCE = 2;

  final dbHelper = DatabaseHelper();
  Future<String>? mannaVerse;

  @override
  void initState() {
    super.initState();

    DateTime now = DateTime.now();
    mannaVerse = dbHelper.getMannaVerse(
        now.month, now.day, ALL_VERSE, widget.MANNA_TYPE);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: mannaVerse,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Handle errors
          return Text('Error: ${snapshot.error}');
        } else {
          // Data is ready
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            // Use the first item from the list (assuming it contains the desired data)
            String verse = snapshot.data!;

            return Container(
              width: MediaQuery.of(context).size.width - 30,
              color: Colors.white,
              child: Column(
                children: [
                  Text(
                    verse,
                    style: GoogleFonts.karla(
                        fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          } else {
            return Text('No data available');
          }
        }
      },
    );
  }
}


/*






    

*/