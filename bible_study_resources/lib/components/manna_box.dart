import "package:bible_study_resources/components/manna_box_body.dart";
import "package:bible_study_resources/components/manna_box_header.dart";
import "package:bible_study_resources/pages/manna_page.dart";
import "package:flutter/material.dart";

class MannaBox extends StatelessWidget {
  const MannaBox({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MannaPage()),
        );
      },
      child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Stack(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: MannaBoxHeader(),
              ),
              const Positioned(
                top: 80,
                left: 10,
                child: MannaBoxBody(),
              ),
            ],
          )),
    );
  }
}
