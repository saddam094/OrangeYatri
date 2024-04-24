import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateTime.now().hour.toString() +
                  ":" +
                  DateTime.now().minute.toString() +
                  ":" +
                  DateTime.now().second.toString(),
              style:
                  TextStyle(fontSize: 40, backgroundColor: Colors.yellowAccent),
            ),
            Text(
              '0',
              style:
                  TextStyle(fontSize: 40, backgroundColor: Colors.greenAccent),
            )
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(100)
          ),
          child: Icon(Icons.add, size: 40,)
      ),
    );
  }
}
