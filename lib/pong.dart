import 'dart:math';

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
  double randX = 1;
  double randY = 1;
  int score = 0;

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
      safeSetState(() {
        (hDir == Direction.right)
            ? posX += ((increment * randX).round())
            : posX -= ((increment * randX).round());
        (vDir == Direction.down)
            ? posY += ((increment * randY).round())
            : posY -= ((increment * randY).round());
      });
      checkBorders();
    });
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
              top: 10,
              right: 24,
              child: Text(
                'Score: $score',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            Positioned(
              top: posY,
              left: posX,
              child: const Ball(),
            ),
            Positioned(
              bottom: 0,
              left: batPosition,
              child: GestureDetector(
                onHorizontalDragUpdate: (update) => moveBat(update),
                child: Bat(width: batWidth, height: batHeight),
              ),
            ),
          ],
        );
      },
    );
  }

  double randomNumber() {
    var ran = Random();
    int myNum = ran.nextInt(101);
    return (50 + myNum) / 100;
  }

  void checkBorders() {
    double diameter = 50;
    if (posX <= 0 && hDir == Direction.left) {
      hDir = Direction.right;
      randX = randomNumber();
    }
    if (posX >= width - diameter && hDir == Direction.right) {
      hDir = Direction.left;
      randX = randomNumber();
    }
    if (posY >= height - diameter - batHeight && vDir == Direction.down) {
      if (posX >= (batPosition - diameter) &&
          posX <= (batPosition + batWidth + diameter)) {
        vDir = Direction.up;
        randY = randomNumber();
        safeSetState(() {
          score++;
        });
      } else {
        controller.stop();
        showMessage(context);
      }
    }
    if (posY <= 0 && vDir == Direction.up) {
      vDir = Direction.down;
      randY = randomNumber();
    }
  }

  void moveBat(DragUpdateDetails update) {
    safeSetState(() {
      batPosition += update.delta.dx;
    });
  }

  void safeSetState(Function function) {
    if (mounted && controller.isAnimating) {
      setState(() {
        function();
      });
    }
  }

  void showMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Game Over'),
        content: const Text('Would you like to play again?'),
        actions: [
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              setState(
                () {
                  posX = 0;
                  posY = 0;
                  score = 0;
                },
              );
              Navigator.of(context).pop();
              controller.repeat();
            },
          ),
          TextButton(
            child: const Text('No'),
            onPressed: () {
              setState(
                () {
                  posX = 0;
                  posY = 0;
                  score = 0;
                },
              );
              Navigator.of(context).pop();
              dispose();
            },
          ),
        ],
      ),
    );
  }
}
