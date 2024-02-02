import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

// ignore: must_be_immutable
class MannaPageContent extends StatefulWidget {
  String month;
  String day;
  String verse;
  String reference;
  String content;
  double fontSize;

  MannaPageContent({
    super.key,
    required this.month,
    required this.day,
    required this.verse,
    required this.reference,
    required this.content,
    required this.fontSize,
  });

  @override
  State<MannaPageContent> createState() => _MannaPageContentState();
}

class _MannaPageContentState extends State<MannaPageContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Text(
          '${widget.month} ${widget.day}',
          style: GoogleFonts.karla(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: Colors.indigo[800]),
        ),
        const SizedBox(height: 20),
        Text(
          widget.verse,
          textAlign: TextAlign.center,
          style: GoogleFonts.karla(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.indigo[800]),
        ),
        const SizedBox(height: 5),
        Text(
          widget.reference,
          textAlign: TextAlign.center,
          style: GoogleFonts.karla(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.indigo[800]),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: SingleChildScrollView(
            child: Text(
              widget.content,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontSize: widget.fontSize,
                  fontWeight: FontWeight.w300,
                  color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
