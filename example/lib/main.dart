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
                  var registered = await WecomFlutter().registerApp(schema: MY_SCHEMA, appId: MY_APPID, agentId: MY_AGENTID);
                  print('registered $registered');
                },
              ),
              ElevatedButton(
                child: const Text('isWWAppInstalled'),
                onPressed: () async {
                  var isWWAppInstalled = await WecomFlutter().isWWAppInstalled();
                  print('isWWAppInstalled $isWWAppInstalled');
                },
              ),
              ElevatedButton(
                child: const Text('sendWeComAuth'),
                onPressed: () async {
                  WecomFlutter().onAuthResponse ??= (Map<String, dynamic> resp) {
                    print('onAuthResponse $resp');
                  };
                  var sent = await WecomFlutter().sendWeComAuth();
                  print('sendWeComAuth $sent');
                },
              ),
              ElevatedButton(
                child: const Text('shareWebPage'),
                onPressed: () async {
                  var sent = await WecomFlutter().shareToWeCom(WeComShareWebPageModel('https://github.com', title: 'Github'));
                  print('shareToWeCom $sent');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
