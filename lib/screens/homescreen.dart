import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //list of map
  List<Map<String, dynamic>> category = [
    {'title': 'Car', 'icon': Icons.taxi_alert},
    {'title': 'Pool', 'icon': Icons.pool},
    {'title': 'Rental', 'icon': Icons.car_rental},
    {'title': 'Reserve', 'icon': Icons.bike_scooter},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            width: MediaQuery.of(context).size.width,
            height: 150,
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
          //searchbar
          Transform.translate(
            offset: const Offset(0, -25),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 12,
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
          //category title
          const Text('Book A Ride Now'),
          //spacing
          const SizedBox(height: 10),
          //build the category
          Row(
            children: category
                .map((e) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(color: Colors.grey[100]),
                            child: Icon(e['icon']),
                          ),
                          const SizedBox(height: 10),
                          Text(e['title'])
                        ]),
                      ),
                    ))
                .toList(),
          ),

          //plan your ride

          const Text('Plan Your Ride'),

          //building the custom carousel
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: category
                  .map((e) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width - 100,
                          height: 120,
                          decoration: BoxDecoration(
                              color: Colors.yellow,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ))
                  .toList(),
            ),
          ),

          //save money ride with us

          const Text('Save Money! Ride With Us'),
          //
          Row(
            children: category
                .map((e) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(color: Colors.grey[100]),
                            child: Icon(e['icon']),
                          ),
                          const SizedBox(height: 10),
                          Text(e['title'])
                        ]),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
