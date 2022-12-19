import 'package:flutter/material.dart';

import 'package:wecom_flutter/wecom_flutter.dart';

import 'config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text('registerApp'),
                onPressed: () async {
                  var registered = await WecomFlutter.registerApp(schema: MY_SCHEMA);
                  print('registered $registered');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
