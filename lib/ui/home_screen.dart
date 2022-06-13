import 'package:dio_example/services/dio_client.dart';
import 'package:dio_example/models/User.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DioClient _client = DioClient();

  int? randomNumberId = Random().nextInt(11);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Info - Dio Example'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: FutureBuilder<User?>(
              future: _client.getUser(id: randomNumberId!.toString()),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const CircularProgressIndicator();
                  default:
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      User? userInfo = snapshot.data;
                      Data? userData = userInfo!.data;

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.network(userData!.avatar!),
                          const SizedBox(height: 8.0),
                          Text(
                            userData.firstName! + " " + userData.lastName!,
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            userData.email!,
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ],
                      );
                    }
                }
              },
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
              onPressed: () {
                randomNumberId = Random().nextInt(11);

                setState(() {});
              },
              child: const Text("Refresh user"))
        ],
      ),
    );
  }
}
