import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const ProviderScope(child: DaylogApp()));
}

class DaylogApp extends StatelessWidget {
  const DaylogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Daylog',
      theme: const CupertinoThemeData(
        primaryColor: Color(0xffA5BFCC),
        scaffoldBackgroundColor: CupertinoColors.systemGroupedBackground,
      ),
      home: const HomeScreen(),
    );
  }
}
