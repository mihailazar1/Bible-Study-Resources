import "package:bible_study_resources/pages/manna_page.dart";
import "package:flutter/material.dart";

class SongsNightPage extends StatefulWidget {
  const SongsNightPage({super.key});

  @override
  State<SongsNightPage> createState() => _SongsNightPageState();
}

class _SongsNightPageState extends State<SongsNightPage> {
  final int NIGHT_MANNA = 1;
  @override
  Widget build(BuildContext context) {
    return MannaPage(
      MANNA_TYPE: NIGHT_MANNA,
    );
  }
}
