import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stop_watch/ui/stop_watch_timer_view.dart';
import 'package:window_size/window_size.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isMacOS) {
    setWindowMinSize(const Size(500, 500));
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stop Watch Timer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StopWatchView(),
    );
  }
}
