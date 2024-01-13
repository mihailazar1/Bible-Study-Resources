import "package:flutter/material.dart";

class MyScreen extends StatefulWidget {
  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  bool _isContainerVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Screen'),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Tile $index'),
                onTap: () {
                  setState(() {
                    _isContainerVisible = true;
                  });
                },
              );
            },
          ),
          if (_isContainerVisible)
            AnimatedContainer(
              duration: Duration(milliseconds: 3000),
              curve: Curves.easeInOut,
              height: 100,
              color: Colors.grey[300],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Button 1'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Button 2'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Button 3'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
