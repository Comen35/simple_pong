import 'package:flutter/material.dart';
import 'package:simple_pong/pong.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pong Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Simple Pong'),
          ),
          body: const SafeArea(
            child: Pong(),
          )),
    );
  }
}
