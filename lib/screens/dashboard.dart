import 'dart:async';

import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  //variable for the timer
  var timer;
  var milliseconds = 0;

  //boolean for isTicking
  bool isTicking = false;

  //calling timer on initstate
  // @override
  // void initState() {
  //   milliseconds = 0;

  //   timer = Timer.periodic(const Duration(milliseconds: 1), _onTick);
  //   super.initState();
  // }

  //onTick function
  void _onTick(Timer timer) {
    setState(() {
      milliseconds += 100;
    });
  }

  //function for start timer
  void _startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 100), _onTick);
    setState(() {
      milliseconds = 0;
      isTicking = true;
    });
  }

  //second text
  String _secondsText(int milliseconds) {
    final seconds = milliseconds / 1000;
    return '$seconds seconds';
  }

  //function for stop timer
  void _stopTime() {
    timer.cancel();
    setState(() {
      isTicking = false;
    });
  }

  //adding lap
  final laps = <int>[];

  //lap method
  void _lap() {
    setState(() {
      laps.add(milliseconds);
      milliseconds = 0;
    });
  }

  //dispose
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                width: MediaQuery.of(context).size.width,
                height: 100,
                color: Colors.orange,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Column for text
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        Text(
                          'Emma Brown',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                    ),
                  ],
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -25),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 12,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: Container(
                        height: 30,
                        width: 90,
                        padding: const EdgeInsets.all(5),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.lock_clock),
                            Text('Now'),
                            Icon(Icons.arrow_drop_down)
                          ],
                        ),
                      ),
                      hintText: 'Where to?',
                    ),
                  ),
                ),
              ),
              //for displaying the timer
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      child: Column(
                        children: [
                          Text(
                            'Lap ${laps.length + 1}',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(color: Colors.black),
                          ),
                          Text(
                            _secondsText(milliseconds) ?? '0',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    //buttons for starting and stopping the timer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //start button
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white)),
                          onPressed: isTicking ? null : _startTimer,
                          child: const Text('Start'),
                        ),
                        //space
                        const SizedBox(width: 20),

                        //lap
                        TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.yellow),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black)),
                          onPressed: isTicking ? _lap : null,
                          child: const Text('Lap'),
                        ),
                        const SizedBox(width: 20),

                        //stop button
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white)),
                          onPressed: isTicking ? _stopTime : null,
                          child: const Text('Stop'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              //adding listView
              Expanded(
                child: _buildLapDisplay(),
              )
            ],
          ),
        ),
      ),
    );
  }

  //lap display widget
  ListView _buildLapDisplay() {
    return ListView(
      children: [
        for (int milliseconds in laps)
          ListTile(
            title: Text(_secondsText(milliseconds)),
          ),
      ],
    );
  }
}
