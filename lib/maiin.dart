import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Hydroponics',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String temperature = '0';
  int humidity = 0;
  String waterTemperature = '0';
  bool pumpStatus = false;
  int ph = 0;

  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection('sensor')
        .doc('farm1')
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;

        setState(() {
          temperature = data['Temperature'];
          humidity = int.parse(data['Humidity']);
          waterTemperature = data['Water-Temperature'];
          ph = data['ph'];
        });
      }
    });
  }

  void togglePumpStatus(bool newValue) {
    setState(() {
      pumpStatus = newValue;
    });

    FirebaseFirestore.instance
        .collection('sensor')
        .doc('farm1')
        .update({'Pump': newValue});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SMART HYDROPONICS'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Card(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Environment',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          const Icon(Icons.wb_sunny,
                              size: 40, color: Colors.yellow),
                          const SizedBox(width: 10),
                          const Text('Temperature',
                              style: TextStyle(fontSize: 22)),
                          const Spacer(),
                          Text('$temperature°C', // Add °C symbol
                              style: const TextStyle(fontSize: 22)),
                          const Text('', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Row(
                        children: [
                          const Text('Humidity',
                              style: TextStyle(fontSize: 22)),
                          const Spacer(),
                          Text('$humidity%', // Add % symbol
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 20)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      LinearProgressIndicator(
                        value: humidity /
                            100.0, // Assuming humidity is in percentage (0-100)
                        color: Colors.blue,
                        backgroundColor: Colors.blue[100],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 70),
              Card(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('System',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 40),
                      Row(
                        children: [
                          const Icon(Icons.water_drop,
                              size: 50, color: Colors.yellow),
                          const SizedBox(width: 10),
                          const Text('Water Temperature',
                              style: TextStyle(fontSize: 22)),
                          const Spacer(),
                          Text('$waterTemperature°C', // Add °C symbol
                              style: const TextStyle(fontSize: 20)),
                          const Text(' ', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      const SizedBox(height: 50),
                      const Text('pH', style: TextStyle(fontSize: 20)),
                      LinearProgressIndicator(
                        value:
                            ph / 14.0, // Assuming pH values range from 0 to 14
                        color: Colors.red,
                        backgroundColor: Colors.red[100],
                      ),
                      const SizedBox(height: 50),
                      Row(
                        children: [
                          const Text('Pump Status:',
                              style: TextStyle(fontSize: 20)),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              togglePumpStatus(!pumpStatus);
                            },
                            child: Switch(
                              value: pumpStatus,
                              onChanged: (bool value) {},
                              activeColor: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
