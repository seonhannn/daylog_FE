import 'package:flutter/material.dart';
import '../widgets/date_selector.dart';
import '../widgets/memo_list.dart';
import '../widgets/memo_input.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(children: const [DateSelector(), Expanded(child: MemoList()), MemoInput()]),
        ),
      ),
    );
  }
}
