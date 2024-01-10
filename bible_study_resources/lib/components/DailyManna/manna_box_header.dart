import "package:bible_study_resources/models/database.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class MannaBoxHeader extends StatefulWidget {
  final int MANNA_TYPE;
  const MannaBoxHeader({super.key, required this.MANNA_TYPE});

  @override
  State<MannaBoxHeader> createState() => _MannaBoxHeaderState();
}

class _MannaBoxHeaderState extends State<MannaBoxHeader> {
  final dbHelper = DatabaseHelper();

  Future<String>? mannaTitle;

  @override
  void initState() {
    super.initState();

    DateTime now = DateTime.now();
    mannaTitle =
        dbHelper.getMannaDisplayTitle(now.month, now.day, widget.MANNA_TYPE);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: mannaTitle,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the data, you can display a loading indicator.
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Handle errors
          return Text('Error: ${snapshot.error}');
        } else {
          // Data is ready
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            // Use the first item from the list (assuming it contains the desired data)
            String displayTitle = snapshot.data!;

            return Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Image.asset(
                    'lib/assets/manna_icon.png',
                    height: 60,
                    width: 60,
                  ),
                ),
                Text(
                  displayTitle,
                  style: GoogleFonts.karla(
                      fontSize: 19, color: Colors.indigo[800]),
                ),
              ],
            );
          } else {
            // Handle the case where no data is available
            return Text('No data available');
          }
        }
      },
    );
  }
}
