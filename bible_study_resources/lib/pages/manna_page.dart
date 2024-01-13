import "package:bible_study_resources/components/DailyManna/manna_page_content.dart";
import "package:bible_study_resources/models/database.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import 'package:intl/intl.dart';
import "package:isar/isar.dart";
import 'package:tuple/tuple.dart';

class MannaPage extends StatefulWidget {
  double fontSize = 21;
  final int MANNA_TYPE;

  MannaPage({super.key, required this.MANNA_TYPE});

  @override
  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MannaPage> {
  final int ALL_VERSE = 0;
  final int VERSE_NO_REFERENCE = 1;
  final int ONLY_REFERENCE = 2;

  DateFormat dateFormat = DateFormat('MMMM', 'en_US');
  final dbHelper = DatabaseHelper();

  Future<String>? mannaContent;
  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    mannaContent =
        dbHelper.getMannaContent(now.month, now.day, widget.MANNA_TYPE);
  }

  final PageController _controller =
      PageController(initialPage: DateTime.now().day - 1);

  Tuple2<int, int> convertDayOfYear(int dayOfYear) {
    var now = DateTime.now();
    var date = DateTime(now.year, 1, 1).add(Duration(days: dayOfYear - 1));
    return Tuple2(date.month, date.day);
  }

  Future<Tuple4<String, String, String, String>> _getMannaContent(
      int dayOfYear) async {
    Tuple2 t2 = convertDayOfYear(dayOfYear);
    int month = t2.item1;
    int day = t2.item2;

    String monthName = DateFormat('MMMM').format(DateTime(0, month));

    final mannaOnlyVerse = await dbHelper.getMannaVerse(
        month, day, VERSE_NO_REFERENCE, widget.MANNA_TYPE);
    final mannaReference = await dbHelper.getMannaVerse(
        month, day, ONLY_REFERENCE, widget.MANNA_TYPE);
    final mannaContent =
        await dbHelper.getMannaContent(month, day, widget.MANNA_TYPE);

    return Tuple4(monthName, mannaOnlyVerse, mannaReference, mannaContent);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final sliderHeight = 50.0;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.MANNA_TYPE == 0
              ? 'Daily Heavenly Manna'
              : 'Songs in the Night',
          style: GoogleFonts.karla(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          SizedBox(
            height: screenHeight - sliderHeight - 90,
            child: PageView.builder(
              controller: _controller,
              itemBuilder: (context, index) {
                final date = DateTime(DateTime.now().year, 1, 1)
                    .add(Duration(days: index));

                return FutureBuilder<Tuple4<String, String, String, String>>(
                  future: _getMannaContent(index + 1),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: MannaPageContent(
                          month: snapshot.data!.item1,
                          day: date.day.toString(),
                          verse: snapshot.data!.item2,
                          reference: snapshot.data!.item3,
                          content: snapshot.data!.item4,
                          fontSize: widget.fontSize,
                        ),
                      );
                    } else {
                      return Center();
                    }
                  },
                );
              },
            ),
          ),
          Container(
            height: sliderHeight,
            child: Opacity(
              opacity: 0.4,
              child: Slider(
                activeColor: Colors.indigo,
                value: widget.fontSize,
                min: 14,
                max: 28,
                onChanged: (value) {
                  setState(() {
                    widget.fontSize = value;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
