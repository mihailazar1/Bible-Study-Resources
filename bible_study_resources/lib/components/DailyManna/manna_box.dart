import "package:bible_study_resources/components/DailyManna/manna_box_body.dart";
import "package:bible_study_resources/components/DailyManna/manna_box_header.dart";
import "package:flutter/material.dart";

class MannaBox extends StatelessWidget {
  const MannaBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Stack(
          children: [
            Container(
              height: 210,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            const Positioned(
              top: 10,
              left: 10,
              child: MannaBoxHeader(
                MANNA_TYPE: 0,
              ),
            ),
            const Positioned(
              top: 80,
              left: 10,
              child: MannaBoxBody(
                MANNA_TYPE: 0,
              ),
            ),
          ],
        ));
  }
}
