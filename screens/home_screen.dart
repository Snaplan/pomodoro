// ignore_for_file: deprecated_member_use, must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutestoSeconds = 1500;
  int totalSeconds = twentyFiveMinutestoSeconds;
  bool isRunning = false;
  int totalPomodoros = 0;
  late Timer timer;

  void onTick(Timer timer) {
    if (totalSeconds <= 0) {
      setState(() {
        totalSeconds = twentyFiveMinutestoSeconds;
        isRunning = false;
        totalPomodoros += 1;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds -= 1;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onResetPressed() {
    timer.cancel();
    setState(() {
      totalSeconds = 1500;
      isRunning = false;
    });
  }

  void onPomodoroResetPressed() {
    timer.cancel();
    setState(() {
      totalPomodoros = 0;
      isRunning = false;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    var finalDuration = duration.toString().split(".").first.substring(2, 7);
    return finalDuration;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                format(totalSeconds),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Center(
              child: IconButton(
                iconSize: 120,
                color: Theme.of(context).cardColor,
                onPressed: isRunning ? onPausePressed : onStartPressed,
                icon: Icon(isRunning
                    ? Icons.pause_circle_outline_rounded
                    : Icons.play_circle_outline_rounded),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 0,
                child: Center(
                  child: IconButton(
                    iconSize: 60,
                    color: Theme.of(context).cardColor,
                    onPressed: onResetPressed,
                    icon: const Icon(Icons.restore),
                  ),
                ),
              ),
              Flexible(
                flex: 0,
                child: Center(
                  child: IconButton(
                    iconSize: 60,
                    color: Theme.of(context).cardColor,
                    onPressed: onPomodoroResetPressed,
                    icon: const Icon(Icons.restart_alt_rounded),
                  ),
                ),
              ),
            ],
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Pomodoros",
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).textTheme.headline1!.color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "$totalPomodoros",
                          style: TextStyle(
                            fontSize: 58,
                            color: Theme.of(context).textTheme.headline1!.color,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
