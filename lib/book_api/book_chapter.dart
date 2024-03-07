import "dart:convert";

import "package:flutter/material.dart";
import 'package:http/http.dart' as http;

class BookChapter extends StatefulWidget {
  final String apiLink;

  const BookChapter({super.key, required this.apiLink});

  @override
  State<BookChapter> createState() => _BookChapterState();
}

class _BookChapterState extends State<BookChapter> {
  // Replace this with your actual API URL

  Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(Uri.parse(widget.apiLink));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error: Check your internet connection',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)));
          } else {
            final data = snapshot.data;

            String reference = data!['reference'];

            // Extract verses
            List<dynamic> verses = data['verses'];
            List<Map<String, dynamic>> parsedVerses =
                List<Map<String, dynamic>>.from(verses);

            return ListView(
              children: [
                const SizedBox(height: 15),
                Center(
                  child: Text('$reference',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 23)),
                ),
                const SizedBox(height: 15),

                // Display verses
                for (var verse in parsedVerses)
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      text: '${verse['verse']} ',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 19),
                      children: <TextSpan>[
                        TextSpan(
                          text: verse['text'],
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  )
              ],
            );
          }
        },
      ),
    );
  }
}
