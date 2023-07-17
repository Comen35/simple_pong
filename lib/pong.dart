import 'package:flutter/material.dart';
import 'package:simple_pong/ball.dart';
import 'package:simple_pong/bat.dart';

class Pong extends StatefulWidget {
  const Pong({super.key});

  @override
  State<Pong> createState() => _PongState();
}

class _PongState extends State<Pong> with SingleTickerProviderStateMixin {
  double width = 0;
  double height = 0;
  late double posX;
  late double posY;
  double batWidth = 0;
  double batHeight = 0;
  double batPosition = 0;
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    posX = 0;
    posY = 0;
    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 100).animate(controller);
    animation.addListener(() {
      setState(() {
        posX++;
        posY++;
      });
    });
    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        height = constraints.maxHeight;
        width = constraints.maxWidth;
        batWidth = width / 5;
        batHeight = height / 20;
        return Stack(
          children: [
            Positioned(
              top: posY,
              left: posX,
              child: const Ball(),
            ),
            Positioned(
              bottom: 0,
              child: Bat(width: batWidth, height: batHeight),
            ),
          ],
        );
      },
    );
  }
}
