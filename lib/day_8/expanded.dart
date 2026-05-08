import 'package:flutter/material.dart';

class ExpandedDay8 extends StatelessWidget {
  const ExpandedDay8({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expanded"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        children: [
          Container(height: 300, width: 200, color: Colors.blue),
          Expanded(child: Container(color: Colors.yellow)),
          Expanded(
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.red,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [Text("500"), Text("Following")],
                      ),
                    ),
                  ),

                  Expanded(
                    child: Container(
                      color: Colors.yellow,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [Text("2k"), Text("Followers")],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.blue,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [Text("900"), Text("Likes")],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(child: Container(color: Colors.green)),
          Expanded(
            child: Row(
              children: [
                Expanded(flex: 2, child: Container(color: Colors.red)),

                Expanded(child: Container(color: Colors.yellow)),
                Expanded(child: Container(color: Colors.blue)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
