import 'package:flutter/material.dart';
import 'package:simple_pong/ball.dart';
import 'package:simple_pong/bat.dart';

class Pong extends StatefulWidget {
  const Pong({super.key});

  @override
  State<Pong> createState() => _PongState();
}

class _PongState extends State<Pong> {
  double width = 0;
  double height = 0;
  double posX = 0;
  double posY = 0;
  double batWidth = 0;
  double batHeight = 0;
  double batPosition = 0;

  @override
  Widget build(BuildContext context) {
    BoxConstraints constraints = const BoxConstraints();
    height = constraints.maxHeight;
    width = constraints.maxWidth;
    batWidth = width / 5;
    batHeight = height / 20;

    return Stack(
      children: [
        const Positioned(
          top: 0,
          child: Ball(),
        ),
        Positioned(
          bottom: 0,
          child: Bat(width: batWidth, height: batHeight),
        ),
      ],
    );
  }
}
