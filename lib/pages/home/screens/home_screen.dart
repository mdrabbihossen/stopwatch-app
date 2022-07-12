import 'dart:async';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Logic of this app is implemented

  int hours = 0, minutes = 0, seconds = 0;
  String digitsSeconds = "00", digitsMinutes = "00", digitsHours = "00";
  Timer? timer;
  bool isRunning = false;
  List laps = [];
  // creating the stop timer function
  void stopTimer() {
    timer!.cancel();
    setState(() {
      isRunning = false;
    });
  }

// creating the reset timer function
  void resetTimer() {
    timer!.cancel();
    setState(() {
      isRunning = false;
      hours = 0;
      minutes = 0;
      seconds = 0;
      digitsSeconds = "00";
      digitsMinutes = "00";
      digitsHours = "00";
    });
  }

  // now add the laps
  void addLaps() {
    String lap = "$digitsHours:$digitsMinutes:$digitsSeconds";
    setState(() {
      laps.add(lap);
    });
  }

  // creating the start timer function
  void startTimer() {
    isRunning = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localSeconds = seconds + 1;
      int localMinutes = minutes;
      int localHours = hours;
      if (localSeconds > 59) {
        if (localMinutes > 59) {
          localHours++;
          localMinutes = 0;
        } else {
          localMinutes++;
          localSeconds = 0;
        }
      }
      setState(() {
        seconds = localSeconds;
        minutes = localMinutes;
        hours = localHours;
        digitsSeconds = (seconds >= 0) ? "$seconds" : "0$seconds";
        digitsMinutes = (minutes >= 0) ? "$minutes" : "0$minutes";
        digitsHours = (hours >= 0) ? "$hours" : "0$hours";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1C2757),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'StopWatch App',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "$digitsHours:$digitsMinutes:$digitsSeconds",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 82,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                    color: Color(0xff323f78),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListView.builder(
                    itemCount: laps.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Lap n°${index + 1}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${laps[index]}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: RawMaterialButton(
                        elevation: 0,
                        onPressed: () {
                          !isRunning ? startTimer() : stopTimer();
                        },
                        shape: StadiumBorder(
                          side: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        child: Text(
                          !isRunning ? 'Start' : 'Pause',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      onPressed: () {
                        addLaps();
                      },
                      icon: Icon(
                        Icons.flag_outlined,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: RawMaterialButton(
                        elevation: 0,
                        onPressed: () {
                          resetTimer();
                        },
                        fillColor: Color(0xff323f78),
                        shape: StadiumBorder(),
                        child: Text(
                          'Reset',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
