import 'package:flutter/material.dart';
import 'package:simple_pong/ball.dart';
import 'package:simple_pong/bat.dart';

enum Direction { up, down, left, right }

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
  Direction vDir = Direction.down;
  Direction hDir = Direction.right;
  double increment = 5;

  @override
  void initState() {
    posX = 0;
    posY = 0;
    controller = AnimationController(
      duration: const Duration(seconds: 10000),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 100).animate(controller);
    animation.addListener(() {
      setState(() {
        (hDir == Direction.right) ? posX += increment : posX -= increment;
        (vDir == Direction.down) ? posY += increment : posY -= increment;
      });
      checkBorders();
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

  void checkBorders() {
    if (posX <= 0 && hDir == Direction.left) {
      hDir = Direction.right;
    }
    if (posX >= width - 50 && hDir == Direction.right) {
      hDir = Direction.left;
    }
    if (posY >= height - 50 && vDir == Direction.down) {
      vDir = Direction.up;
    }
    if (posY <= 0 && vDir == Direction.up) {
      vDir = Direction.down;
    }
  }
}
