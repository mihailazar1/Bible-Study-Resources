import "package:bible_study_resources/pages/manna_page.dart";
import "package:flutter/material.dart";

class DailyMannaPage extends StatefulWidget {
  const DailyMannaPage({super.key});

  @override
  State<DailyMannaPage> createState() => _DailyMannaPageState();
}

class _DailyMannaPageState extends State<DailyMannaPage> {
  final int DAILY_MANNA = 0;
  @override
  Widget build(BuildContext context) {
    return MannaPage(
      MANNA_TYPE: DAILY_MANNA,
    );
  }
}
